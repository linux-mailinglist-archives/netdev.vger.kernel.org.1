Return-Path: <netdev+bounces-112601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C593A204
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD83B2234F
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05C154BEB;
	Tue, 23 Jul 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="yxlO76ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3A153BF6
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742716; cv=none; b=QnvRjNG+l/LWG4Fw4bfGxhATW/pSo4K11+1KvW7HpIbcdbz02pzZVxORGezMiabD2cd4GIedFlcaxf/MpmwUFnj+zenVANmhh588FdgrzTsk6mINCQE+aTbIQlTjGbkT0GE8rXPrCIdqoI6RCD0Dc8MOlaFKTJpa8KzhvNYGWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742716; c=relaxed/simple;
	bh=1MnD3B6Nfn3MrslJWpGjEcsjGMYS+LyrcEuyjGnNM5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qk++cspkghhekt4zSnm4YUem77xZkY5OjMnbSsTj9K/+6p+qXexyKqKQQnA3uFKvhFuSI5sIhsCuKDADA7nfErYBpzhnP/VIZiBH/shQwmwj0jxxSh6PZyZUk/qNZNC0r6uUyIx93q974K9gPMkPch0RiyHkv2yApRzrl+Hse1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=yxlO76ec; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 910477DCF3;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=1MnD3B6Nfn3MrslJWpGjEcsjGMYS+LyrcEuyjGnNM5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2012/15]=20l2tp:=20use=20rcu=20list=20add/del=20when=20updating
	 =20lists|Date:=20Tue,=2023=20Jul=202024=2014:51:40=20+0100|Message
	 -Id:=20<a52b8f902fc864bfeb0e356391def71ced8d19ee.1721733730.git.jc
	 hapman@katalix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@
	 katalix.com>|References:=20<cover.1721733730.git.jchapman@katalix.
	 com>|MIME-Version:=201.0;
	b=yxlO76ecYpnHBfYTx/FNxteobY196xN/i/5OQusBv+82zUMpAAgQNgtk8Bba3WaLw
	 U5s4dM0/tJo4vKmLZoFMQVQ8mhZHykmUzQKobwWKl8GZKDSI9E1HelzkgH4RxuClPg
	 cSebaMlpJGUao6wt18XsEU6wpL0d2oe6tZ9o/OFUfEF6zmwHwJcA5Zw2lfJ13KMvZA
	 9BH+9ptoiWt35QgPTEvE1rix2u/p57CvBmGhOHRM4WUiBaLDFjR+jiDuvd4CTObKzo
	 1d2Bd+JYbKx7c8jkG2V5HwJzz2jzSGTb14k3l2DnsUUZhDHFU1LGzUf33XnM1xEsJs
	 esYOgdGkHKLhg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 12/15] l2tp: use rcu list add/del when updating lists
Date: Tue, 23 Jul 2024 14:51:40 +0100
Message-Id: <a52b8f902fc864bfeb0e356391def71ced8d19ee.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
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


