Return-Path: <netdev+bounces-69028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97013849309
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 05:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE8F283ACB
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 04:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784379455;
	Mon,  5 Feb 2024 04:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313BDAD32
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108523; cv=none; b=Ey2INnwpTMJI79lHj+wvhPEzsji9YkEQp3ktRMe1XYAf2ba+9Ft9WjfrVWvwzNcNBg1nkDF1ZKs8duch0CXNHS/UuARhG2ERCYgVFDzxUTmb3ICYDsVD6RNMbohPSQDlS9hvFqCdMyz0uZfXs+GxA49wG1wzlsnqS8UxbS4x3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108523; c=relaxed/simple;
	bh=cdJQFz6hZUzWJNGzDH63QwKkJo4AU14dQ2yGTGVLD10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtVPNBbPjvy3a+5kVDAfJtvadhMogVYPnFGxGj1ss7ahz196WzVgP44uGr2GPfBJeRaJkPY2QiZrr53yyKRfWEF3kGy3aO+mp41zzcmXr7l2u5LySC7PVmnd0ArX5K8A8Q1/4dO78f5IvJDYu/IvtYuFS2aiW1HCxDtNA9t6Uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.117])
	by sina.com (172.16.235.24) with ESMTP
	id 65C0689A000008B5; Mon, 5 Feb 2024 12:48:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 60248245089159
X-SMAIL-UIID: 810C1F7E0DE348C6A2CB06103849C575-20240205-124829-1
From: Hillf Danton <hdanton@sina.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org,
	mpatocka@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH v3 3/8] workqueue: Implement BH workqueues to eventually replace tasklets
Date: Mon,  5 Feb 2024 12:48:17 +0800
Message-Id: <20240205044817.593-1-hdanton@sina.com>
In-Reply-To: <ZcABypwUML6Osiec@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 4 Feb 2024 11:28:06 -1000 Tejun Heo <tj@kernel.org>
> +static void bh_worker(struct worker *worker)
> +{
> +	struct worker_pool *pool = worker->pool;
> +	int nr_restarts = BH_WORKER_RESTARTS;
> +	unsigned long end = jiffies + BH_WORKER_JIFFIES;
> +
> +	raw_spin_lock_irq(&pool->lock);
> +	worker_leave_idle(worker);
> +
> +	/*
> +	 * This function follows the structure of worker_thread(). See there for
> +	 * explanations on each step.
> +	 */
> +	if (!need_more_worker(pool))
> +		goto done;
> +
> +	WARN_ON_ONCE(!list_empty(&worker->scheduled));
> +	worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
> +
> +	do {
> +		struct work_struct *work =
> +			list_first_entry(&pool->worklist,
> +					 struct work_struct, entry);
> +
> +		if (assign_work(work, worker, NULL))
> +			process_scheduled_works(worker);
> +	} while (keep_working(pool) &&
> +		 --nr_restarts && time_before(jiffies, end));
> +
> +	worker_set_flags(worker, WORKER_PREP);
> +done:
> +	worker_enter_idle(worker);
> +	kick_pool(pool);
> +	raw_spin_unlock_irq(&pool->lock);
> +}

I see no need to exec bh works for 2ms with irq disabled.

