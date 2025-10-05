Return-Path: <netdev+bounces-227892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD92BB97B2
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A34394E242C
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3642882D6;
	Sun,  5 Oct 2025 13:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BD28727C;
	Sun,  5 Oct 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759671618; cv=none; b=UTRHw88cwPHAhuVdolFzDXdHiJ6iaMlOT9adekz1OhjeJ8sKAIjciGFWx9djvvCjUuPTPbOk/KLSNRSSrNGRurvBTMWJz2fJa4WLN1Z9J6FbDSldLFmEy/SnHzD63v5lBfQkBLz28Put/fNC8E1GWCe4yfpxswif0ZEv3nHzYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759671618; c=relaxed/simple;
	bh=x28M0/u657nk2zwrojJZ1LNMdc7vu7oCVsG8XfFSxx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XDQuteUERUqbjCeI5E/gNJQmlew7q1Lk7BbBnR/WFD0GkH2Hh7G91BCdiFlUmLFfmc9+2IURcMXukmWpfY8I2MSM2qhxdPEl6rWBzBxtievwsXOuCqUpv6fhwXoUvDZPiqw+6DKT0K369H0Ad6T/j69TxN0t3dKG9UcK0Y5biD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <Jason@zx2c4.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <wireguard@lists.zx2c4.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH v2] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Sun, 5 Oct 2025 21:39:36 +0800
Message-ID: <20251005133936.32667-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
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


