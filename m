Return-Path: <netdev+bounces-250007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE05D224E5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 04:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40C3E3016DE3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D822798EA;
	Thu, 15 Jan 2026 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP072mEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50822175A5;
	Thu, 15 Jan 2026 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448008; cv=none; b=q4Is2tyRZAGbycoOprqU45V/33r8AqUah3Feih7QAT6HI70yZjjIDu/FBwRiGCh7UXmx6m/iunjObSgU2nrMY1GjO0UaXe+wxJfJNVcEdeLvYrMqEmbOKmQRPQRAzPg6/YtjVQcnD72EZuQFAVbwKs0HuA2mU/SRomDJLlxPa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448008; c=relaxed/simple;
	bh=8Ymc27CFNVZ9pjs4dlypKvNfcqUnbSbMf8iST/L3RDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGTzNdsYRX+Y4Hkl9yz4BD25mc0Y7ivNxut+Iru4M6QrhXTU6GkV8KCXETgfC1aVDeVW7ooIcQ3TmCumfPa1AWSxWXMuEiSNbVcHZvn0tAAsmkjzyZ7Em8g/YSAvKsayotufgXjHbeSBH1659bhLJ3IS88KM/yqL01+GAdjZG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP072mEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506A3C4CEF7;
	Thu, 15 Jan 2026 03:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768448007;
	bh=8Ymc27CFNVZ9pjs4dlypKvNfcqUnbSbMf8iST/L3RDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NP072mEyDTP0cKPX4iQ/zWTo3ZK02QGLeffLuBEclBtAUkssE7NRMPgmepfgrMpiu
	 gQMQeqvNsp0jivjf2O/hFQWYjcEOINzpjfhxsT3zsE1xtC1cdq3qXb1iFmIugexGa0
	 OmrJCxIxw66q8ha/WR7RFFECub/G92MGylWBj4ccZHr3FtUR8Z+cXZS7UUXf1+N1Yg
	 MU//GxOW8E4W9g/DvQpwOroZI2fIC87Tgt9Lk6RWGkAD4pkjOS+rHqy5+oyd3IBTid
	 sIZC5gF2UQ3JmVMhDGDVFadYCZ0/3MCzSlZMK/wuMx/a/VECNe6RYtXRVYKbVz0o/I
	 BRdcSiHbivpiA==
From: Jakub Kicinski <kuba@kernel.org>
To: fushuai.wang@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	vadim.fedorenko@linux.dev,
	Jason@zx2c4.com,
	wireguard@lists.zx2c4.com,
	wangfushuai@baidu.com
Subject: Re: [net-next,v3] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Wed, 14 Jan 2026 19:32:37 -0800
Message-ID: <20260115033237.1545400-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112130633.25563-1-fushuai.wang@linux.dev>
References: <20260112130633.25563-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
wireguard: allowedips: Use kfree_rcu() instead of call_rcu()

This commit replaces call_rcu() with a custom kmem_cache_free() callback
with kfree_rcu() to simplify the code. The change affects how nodes are
freed in the remove_node() function.

> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> index 09f7fcd7da78..5ece9acad64d 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
>  	}
>  }
>
> -static void node_free_rcu(struct rcu_head *rcu)
> -{
> -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> -}
> -

[ ... ]

> @@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *node, struct mutex *lock)
>  	if (free_parent)
>  		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
>  						  lockdep_is_held(lock));
> -	call_rcu(&node->rcu, node_free_rcu);
> +	kfree_rcu(node, rcu);

Does wg_allowedips_slab_uninit() need to be updated to use
kvfree_rcu_barrier() instead of rcu_barrier()?

When CONFIG_KVFREE_RCU_BATCHED is enabled (the default), kfree_rcu()
uses a batched mechanism that queues work via queue_rcu_work(). The
rcu_barrier() call waits for RCU callbacks to complete, but these
callbacks only queue the actual free to a workqueue via rcu_work_rcufn().
The workqueue work that calls kvfree() may still be pending after
rcu_barrier() returns.

The existing cleanup path is:
  wg_allowedips_slab_uninit() -> rcu_barrier() -> kmem_cache_destroy()

With kfree_rcu(), this sequence could destroy the slab cache while
kfree_rcu_work() still has pending frees queued. The proper barrier for
kfree_rcu() is kvfree_rcu_barrier() which also calls flush_rcu_work()
on all pending batches.

>  	if (!free_parent)
>  		return;
>  	if (child)
>  		child->parent_bit_packed = parent->parent_bit_packed;
>  	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
> -	call_rcu(&parent->rcu, node_free_rcu);
> +	kfree_rcu(parent, rcu);
>  }
-- 
pw-bot: cr

