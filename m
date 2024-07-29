Return-Path: <netdev+bounces-113706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4F93F9A5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B7F1C21C01
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1C15ECCE;
	Mon, 29 Jul 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="eQiOFtRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702DA15B11F
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267500; cv=none; b=uZEa0k1EscHUj3GMpyEgspvWMbUFM7q9gd2rvOWlMMCDCj7LjP4wz141w38U+dlcOM+XFaXrc3VDTQ/Fe1ZUNB0QGVMDcy346muHwPkTa8a8OiPElnxzQrezp042ZaEGNKUDRJZQu1zqpahHSq1HDP+UYwG/0UgwVRXBuCkiI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267500; c=relaxed/simple;
	bh=qQBFnd27KeNrXqfpSNskAfFAQuKll9xfPCeJvgeNMSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/Qt4oVnRyTC6R8Ra6EBa/H1U2sVwhEsF+pVVMEBCfQMhmTRHEStYnjkZsFqgQ9ds5z3EWOyBnikKLgajwDZdEj/g7paOIXC4HM3JbzHsgKppbAtmzj0JUTVRXoIZgmP67GwYghfj3TuQKpvDLn+DdS62BgV2lpA/uhw7xiO9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=eQiOFtRQ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 79BAB7DCFC;
	Mon, 29 Jul 2024 16:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267496; bh=qQBFnd27KeNrXqfpSNskAfFAQuKll9xfPCeJvgeNMSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2012/15]=20l2tp:=20use=20rcu=20list=20add/del=20when=20upd
	 ating=20lists|Date:=20Mon,=2029=20Jul=202024=2016:38:11=20+0100|Me
	 ssage-Id:=20<4d4bd391f8895d46339691803bc96ad64d84723e.1722265212.g
	 it.jchapman@katalix.com>|In-Reply-To:=20<cover.1722265212.git.jcha
	 pman@katalix.com>|References:=20<cover.1722265212.git.jchapman@kat
	 alix.com>|MIME-Version:=201.0;
	b=eQiOFtRQAuv7bd2Po090sENyXNIjFqEfqRZTg55Kt6S7B0nl/lb1OvKHTNtR5I0I/
	 S1bviLKI4ovriSSpc0KvIXPLma76bhigM7HEeL0i1Isykx0f0UVVkn+4jaPTPMykoP
	 Ly9wK2OuUtuy4Myd8DnAiSpj0UL26VBXHD4gVBCE/5j+Xq+9xRr53KgDqolXYUk/DQ
	 gOf96t6frdq8gh1CzCOjHyyQRD9cB5TmaPHNKIDbX88UMCenprfjD39xHgMex2zt3P
	 UGs5XrjY2sZeMxZG61TgmGPboiO+1mSgTtRR0XuCX4QKSIZRkjWPYrS4BkpgzsfGy3
	 sNZmZT6HyOAfQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 12/15] l2tp: use rcu list add/del when updating lists
Date: Mon, 29 Jul 2024 16:38:11 +0100
Message-Id: <4d4bd391f8895d46339691803bc96ad64d84723e.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_v3_session_htable and tunnel->session_list are read by lockless
getters using RCU. Use rcu list variants when adding or removing list
items.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index cbf117683fab..cd9b157e8b4d 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -419,12 +419,12 @@ static int l2tp_session_collision_add(struct l2tp_net *pn,
 
 	/* If existing session isn't already in the session hlist, add it. */
 	if (!hash_hashed(&session2->hlist))
-		hash_add(pn->l2tp_v3_session_htable, &session2->hlist,
-			 session2->hlist_key);
+		hash_add_rcu(pn->l2tp_v3_session_htable, &session2->hlist,
+			     session2->hlist_key);
 
 	/* Add new session to the hlist and collision list */
-	hash_add(pn->l2tp_v3_session_htable, &session1->hlist,
-		 session1->hlist_key);
+	hash_add_rcu(pn->l2tp_v3_session_htable, &session1->hlist,
+		     session1->hlist_key);
 	refcount_inc(&clist->ref_count);
 	l2tp_session_coll_list_add(clist, session1);
 
@@ -440,7 +440,7 @@ static void l2tp_session_collision_del(struct l2tp_net *pn,
 
 	lockdep_assert_held(&pn->l2tp_session_idr_lock);
 
-	hash_del(&session->hlist);
+	hash_del_rcu(&session->hlist);
 
 	if (clist) {
 		/* Remove session from its collision list. If there
@@ -515,7 +515,7 @@ int l2tp_session_register(struct l2tp_session *session,
 
 	l2tp_tunnel_inc_refcount(tunnel);
 	WRITE_ONCE(session->tunnel, tunnel);
-	list_add(&session->list, &tunnel->session_list);
+	list_add_rcu(&session->list, &tunnel->session_list);
 
 	if (tunnel->version == L2TP_HDR_VER_3) {
 		if (!other_session)
-- 
2.34.1


