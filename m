Return-Path: <netdev+bounces-92378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B748B6D3C
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A91F22BF6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DBD127E3F;
	Tue, 30 Apr 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A6+M1fgI"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F01272DB
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466605; cv=none; b=T9AtkE/6A3GtjdfMS3Z0WsH0uAkV05blYFXjLOHGAnbhBDBPrA+F9S1bbOZ9aaAQAr32TRXY549Ph0f6WhQ81S/+DfACKlc73XmzkXNG4ISsGjEyIfFnSLsJkTZxPB1Mg7/hZCfQHF2F6YOOOMUWwQw2LtPs9qxJvMCPOJOcFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466605; c=relaxed/simple;
	bh=yxm2k2a+Skqhd5mvCZqVhrGQNrjeDxywZrAlQxtr3Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3/Ih+VM3tHSrro8O1N4b0xYAi5ZyIqIAjdC3Ic8izuySgKsrq9EHwaLaONCweuKi5mXCYBSMqnvFghljjtY8x2p+2+DSBuoKhLqadGoqdn0QTu2WIvCiUyhrj22pKbG+dEI8hpTTaj/r+5p+HYPgsWXc8NhegDFuobr6HKoK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=A6+M1fgI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PipEzrDvx0NJs11I/QT6g83naEfqIc0qLqd/kmyL0jE=; b=A6+M1fgIzb/gvdD0rauSqu5ydL
	6Gnt488KLWBrmFAkgLr4IvBiJ68Xu+C7CmCOxMiCUrsv6mgfuvvRW9VZg8ROIlYdt/U/uUcQLimr2
	2BIDIynCIdGothfXxJ0vAvgq9pqV2vfvs6+c42H0vWVX39DSIqESxzcbtQCV/3mlgN8XPX3QBvLy/
	ujM0zndDpHU176lbPPsaM5pFuHAB6g5dLoCRrL3oXIsyI2Jq4LZrN/+JhBuKJi4t7eo9FGF/vSUhR
	Pe8sYof/sDgNd58fKOxBVxy5zjwHH/ZHbWFn/DPqYczq67R3037o/l2o4MCLgHq+gc8MFtEqUZ5w4
	/fmdtf7g==;
Received: from 179-125-79-232-dinamico.pombonet.net.br ([179.125.79.232] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s1j4x-001hpA-TL; Tue, 30 Apr 2024 10:43:12 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] net: fix out-of-bounds access in ops_init
Date: Tue, 30 Apr 2024 05:42:53 -0300
Message-Id: <20240430084253.3272177-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_alloc_generic is called by net_alloc, which is called without any
locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
is read twice, first to allocate an array, then to set s.len, which is
later used to limit the bounds of the array access.

It is possible that the array is allocated and another thread is
registering a new pernet ops, increments max_gen_ptrs, which is then used
to set s.len with a larger than allocated length for the variable array.

Fix it by delaying the allocation to setup_net, which is always called
under pernet_ops_rwsem, and is called right after net_alloc.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 net/core/net_namespace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f0540c557515..879e49b10cca 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -87,7 +87,7 @@ static int net_assign_generic(struct net *net, unsigned int id, void *data)
 
 	old_ng = rcu_dereference_protected(net->gen,
 					   lockdep_is_held(&pernet_ops_rwsem));
-	if (old_ng->s.len > id) {
+	if (old_ng && old_ng->s.len > id) {
 		old_ng->ptr[id] = data;
 		return 0;
 	}
@@ -107,8 +107,9 @@ static int net_assign_generic(struct net *net, unsigned int id, void *data)
 	 * the old copy for kfree after a grace period.
 	 */
 
-	memcpy(&ng->ptr[MIN_PERNET_OPS_ID], &old_ng->ptr[MIN_PERNET_OPS_ID],
-	       (old_ng->s.len - MIN_PERNET_OPS_ID) * sizeof(void *));
+	if (old_ng)
+		memcpy(&ng->ptr[MIN_PERNET_OPS_ID], &old_ng->ptr[MIN_PERNET_OPS_ID],
+		       (old_ng->s.len - MIN_PERNET_OPS_ID) * sizeof(void *));
 	ng->ptr[id] = data;
 
 	rcu_assign_pointer(net->gen, ng);
@@ -422,15 +423,10 @@ static struct workqueue_struct *netns_wq;
 static struct net *net_alloc(void)
 {
 	struct net *net = NULL;
-	struct net_generic *ng;
-
-	ng = net_alloc_generic();
-	if (!ng)
-		goto out;
 
 	net = kmem_cache_zalloc(net_cachep, GFP_KERNEL);
 	if (!net)
-		goto out_free;
+		goto out;
 
 #ifdef CONFIG_KEYS
 	net->key_domain = kzalloc(sizeof(struct key_tag), GFP_KERNEL);
@@ -439,7 +435,7 @@ static struct net *net_alloc(void)
 	refcount_set(&net->key_domain->usage, 1);
 #endif
 
-	rcu_assign_pointer(net->gen, ng);
+	rcu_assign_pointer(net->gen, NULL);
 out:
 	return net;
 
@@ -448,8 +444,6 @@ static struct net *net_alloc(void)
 	kmem_cache_free(net_cachep, net);
 	net = NULL;
 #endif
-out_free:
-	kfree(ng);
 	goto out;
 }
 
-- 
2.34.1


