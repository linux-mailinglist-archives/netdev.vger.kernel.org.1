Return-Path: <netdev+bounces-227889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70754BB9634
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 14:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531861895878
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B372877D4;
	Sun,  5 Oct 2025 12:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B71DED5B;
	Sun,  5 Oct 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759667249; cv=none; b=QwuW5LDCkugvxvBHl3Mg2bMt9Do6Kbt9/sln6zKuZ5i3aTXJTQzqMnyaDSesxtqkQSM772/lz5Kp3p6hZK9A0DK1AIM+sMxK0bCWzyzuTKt/sPPvMP+jd7Y4Nh9cBzMLp+wHJCjd6LB/DdhCe82dWx770AL0wL10Tti8WfAasow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759667249; c=relaxed/simple;
	bh=8NEuS4IryImOLuWbk47FRs5S5vyICdNE+kwwGvuwb9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvRmbGecLVwzJmLr7xnxiroPUgO6P2TA5S3Xasahasz9ORFzB7uOOneR0cx1NCzD9fw4tv12tQPJLeqPecPR5KTrMsI+6Rdk3rOWO6apcXxq4Drr3rHh/mGizrN/GCGXTuzzYipK7OpRPgHryuf3nExPTrhJfGXZ7e7DdikUjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <Jason@zx2c4.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <wireguard@lists.zx2c4.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Sun, 5 Oct 2025 20:26:26 +0800
Message-ID: <20251005122626.26988-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
the code and reduce function size.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/net/wireguard/allowedips.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 09f7fcd7da78..506f7cf0d7cf 100644
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
+	kfree_rcu(&node, rcu);
 	if (!free_parent)
 		return;
 	if (child)
 		child->parent_bit_packed = parent->parent_bit_packed;
 	*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
-	call_rcu(&parent->rcu, node_free_rcu);
+	kfree_rcu(&parent, rcu);
 }
 
 static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8 *key,
-- 
2.36.1


