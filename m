Return-Path: <netdev+bounces-151761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B929F0C99
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A4C282D44
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2F1DFD94;
	Fri, 13 Dec 2024 12:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5301DF97A
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093744; cv=none; b=YIB0vKIahD/hz8NpSj91ZxUu1sGBvzixGabw52HZafxowRWSZHn/KF+alQwEDYSo4cpotu1ju09RTOw3QIzHUVGwWnKbtkuVtoeFhLhUzpGujGlz1Z+NIXzQN8L4QBS+IlsH9r1K74OJ2Z+ZyJZjX5FD6r5jICJ8ms48lEe2x2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093744; c=relaxed/simple;
	bh=WkuTvNKXZEGln+4PdhWfUwmeQ0+ppMC15Dp1iqzsY08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vA8+O3AKOvwooIWt+hHGG1OXO2lbc1IbUo6c3JD27AMbI6MM/MbhLdo62BCfPur8xl8Q/ApO4AhDMDIhIDtoJRG/bfIVjv1gDVD5+IOPEplhuj2fwGXzApAO71fOjlfYnDSI326cdHfBpTxO4NrXm8xKQkNyhBT18JY0Fgw0hGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.125])
	by sina.com (10.185.250.24) with ESMTP
	id 675C2A6000004E21; Fri, 13 Dec 2024 20:36:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 64236310748386
X-SMAIL-UIID: B9AB6D57269D4CAFAE352980AC829871-20241213-203652-1
From: Hillf Danton <hdanton@sina.com>
To: Brian Vazquez <brianvv@google.com>,
	Marco Leogrande <leogrande@google.com>
Cc: Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [iwl-next PATCH v3 2/3] idpf: convert workqueues to unbound
Date: Fri, 13 Dec 2024 20:36:43 +0800
Message-Id: <20241213123643.1898-1-hdanton@sina.com>
In-Reply-To: <20241212233333.3743239-3-brianvv@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 12 Dec 2024 23:33:32 +0000 Brian Vazquez <brianvv@google.com>
> When a workqueue is created with `WQ_UNBOUND`, its work items are
> served by special worker-pools, whose host workers are not bound to
> any specific CPU. In the default configuration (i.e. when
> `queue_delayed_work` and friends do not specify which CPU to run the
> work item on), `WQ_UNBOUND` allows the work item to be executed on any
> CPU in the same node of the CPU it was enqueued on. While this
> solution potentially sacrifices locality, it avoids contention with
> other processes that might dominate the CPU time of the processor the
> work item was scheduled on.
> 
> This is not just a theoretical problem: in a particular scenario

The cpu hog due to (the user space) misconfig exists regardless it is
bound workqueue or not, in addition to the fact that linux kernel is
never the blue pill to kill all pains, so extra support for unbound wq
is needed.

> misconfigured process was hogging most of the time from CPU0, leaving
> less than 0.5% of its CPU time to the kworker. The IDPF workqueues
> that were using the kworker on CPU0 suffered large completion delays
> as a result, causing performance degradation, timeouts and eventual
> system crash.

