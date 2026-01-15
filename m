Return-Path: <netdev+bounces-250010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8BFD22698
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 06:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4864C3008F2B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 05:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BE2D060E;
	Thu, 15 Jan 2026 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ft7+OiKm"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF529B217
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453963; cv=none; b=pPmHBE8Zgbb60ZPorGsCUr7BRZr+0poATbFowlbVjo7HETyaW4SP4Fws5D/MzCm3nGfLswBAR/jmiK8IpZUw4EH5RePQ6fK2O69YehiLcn9akIuP26mWw8wqGgYhk8lGK+v9NgiZ9C8aK4VMkt4jlOiG2MF6D0lV5la2+RG+SYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453963; c=relaxed/simple;
	bh=37finFM8GqbUZGNA7E2rNLMkPpfYY8iTIquDsZhg2l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mt81a7BbiMllryQSKHZOtWaJpCV9ug4WM6PUB8lkBp+0cujmT9pwsj0ha//Sf3K8yJ8j+DcK9ur6bVMyPNvX1zpLyWdT3SdsIwPJkehy57Rph4xZ7avc2hlBhxX2PZ0wnZTfeIREH3YwcbuRnfURxz49r27hM1W902jX4M0lGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ft7+OiKm; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768453959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqs9U/83nmbmyG5rORjd6RhV9BLTO6XkyhyTLqEtIPI=;
	b=ft7+OiKmZSln0rUGSulTMpwBOK0SEf2j8L/gFLCN5kTbvOEqrZVeVvGpZLhhSpeaj8ldvC
	cOvs605VONB1EjnuLgaUdPvIp6RQe/sDpkx+HcIt6quKykO3peqZBkGBwAAH+3jYX8h8Bp
	tNWz9xMhlwdxBVVimlWxgDg85uoLZbc=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: kuba@kernel.org
Cc: Jason@zx2c4.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	fushuai.wang@linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	wangfushuai@baidu.com,
	wireguard@lists.zx2c4.com
Subject: Re: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Thu, 15 Jan 2026 13:12:21 +0800
Message-Id: <20260115051221.68054-1-fushuai.wang@linux.dev>
In-Reply-To: <20260115033237.1545400-1-kuba@kernel.org>
References: <20260115033237.1545400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> @@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *node, struct mutex *lock)
>>  	if (free_parent)
>>  		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
>>  						  lockdep_is_held(lock));
>> -	call_rcu(&node->rcu, node_free_rcu);
>> +	kfree_rcu(node, rcu);
> 
> Does wg_allowedips_slab_uninit() need to be updated to use
> kvfree_rcu_barrier() instead of rcu_barrier()?
> 
> When CONFIG_KVFREE_RCU_BATCHED is enabled (the default), kfree_rcu()
> uses a batched mechanism that queues work via queue_rcu_work(). The
> rcu_barrier() call waits for RCU callbacks to complete, but these
> callbacks only queue the actual free to a workqueue via rcu_work_rcufn().
> The workqueue work that calls kvfree() may still be pending after
> rcu_barrier() returns.
> 
> The existing cleanup path is:
>   wg_allowedips_slab_uninit() -> rcu_barrier() -> kmem_cache_destroy()
> 
> With kfree_rcu(), this sequence could destroy the slab cache while
> kfree_rcu_work() still has pending frees queued. The proper barrier for
> kfree_rcu() is kvfree_rcu_barrier() which also calls flush_rcu_work()
> on all pending batches.

We do not need to add an explict kvfree_rcu_barrier(), becasue the commit
6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()")
already does it.

---
Regards,
WANG

