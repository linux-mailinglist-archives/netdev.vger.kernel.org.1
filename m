Return-Path: <netdev+bounces-249012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D48D12AD7
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9C3300A36E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5E2D47E3;
	Mon, 12 Jan 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbZWez4/"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303E30B532
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223215; cv=none; b=WpN6K6YG+hBKvO0ngS0uy5gCLIp8VeNyRc2OkAn0PWrOc7xXTP32+bum+T9xYYZ+9L2wno4ma3eRlxTsgKOoTMQonmlfQ40bbXgYfdjG/rbZlEpxg3QR+lwIyAW4eWS4/pEpXQxAYalbqK0OzpHM4gKB0XKHXiyaAOSggLEmQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223215; c=relaxed/simple;
	bh=FsiGsnhkfIMq5xQxcHKbKkmD3OAOQscT86cIg6iw2U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i99dqS7IbZ+A5bF5cw+JbgY8NU/sa0QEhSs0kQvoTRXMyxTTEb6zHfkMD15X+VPhCWLLr+Tuvn7qW9KtW1YrCi0qH2vDTd9xwpZmSR29CAgaTmcFODpklojoEBwrC1NkjvHyYdd8rA3gTy98r6+Lepy22Qzi3pgrDjlNyV7cetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbZWez4/; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768223211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xbIJal/gfJnpbqOOXrwfFZL/+IG8MB1cGwJ3x0vOuxo=;
	b=nbZWez4/3ZblIOQ9G5g1ieE4N3T2mwTJlVl9gJg/aoSELhCwJc6RjuHmqLay54jx93el+z
	BEWStciT9kNesSkrMC+2aO9/21ZAjpXZ2LIr9my8LnofPN6pHuFMHCsrjdw98RMtlAPnOq
	AC85xzrI22VLmhCcvdG0U4gnYjuT9OM=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: Jason@zx2c4.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Mon, 12 Jan 2026 21:06:33 +0800
Message-Id: <20260112130633.25563-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
the code and reduce function size.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/wireguard/allowedips.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 09f7fcd7da78..5ece9acad64d 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
 	}
 }
 
-static void node_free_rcu(struct rcu_head *rcu)
-{
-	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
-}
-
 static void root_free_rcu(struct rcu_head *rcu)
 {
 	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
@@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *node, struct mutex *lock)
 	if (free_parent)
 		child = rcu_dereference_protected(parent->bit[!(node->parent_bit_packed & 1)],
 						  lockdep_is_held(lock));
-	call_rcu(&node->rcu, node_free_rcu);
+	kfree_rcu(node, rcu);
 	if (!free_parent)
 		return;
 	if (child)
 		child->parent_bit_packed = parent->parent_bit_packed;
 	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
-	call_rcu(&parent->rcu, node_free_rcu);
+	kfree_rcu(parent, rcu);
 }
 
 static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
-- 
2.36.1


