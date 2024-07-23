Return-Path: <netdev+bounces-112598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F157193A201
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67AA1F230CF
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5C15444E;
	Tue, 23 Jul 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FEGWyXTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19615380A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742715; cv=none; b=MBPjJyIyvETM5TTGMISfqn7MIMBC8wGQu21j2JF2gQmhcvJy+cNcIQeH3r2kxyHYK3PG6eC46OzmMf4jXdN4nidDidZDGYniDZq3OEDhZ9RbUBxn0bds7r7wijRchpgl+dGzQOTsUTsPn82FxrXp6oMAjy8BTDnKcMTaDekmVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742715; c=relaxed/simple;
	bh=T6hLeXX7Sgkm5cr8ehfdSKVlUfoZynlwUDoVtbhDoqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkwiqX1m/bSC0kgchn+iLrr/3PqOt44qNGnojc+hJJUw5aVLr81cm8u8JwA8RSX6KE9O+z+GEv0mwKsHzYG774O84be4GvcjCDc9/TsLTgwkjmVDvo6w5OO9Vr0aCvAYBVvD62FwP4Y/MDZSQXgozN6ezGF/85/9M990irz6zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FEGWyXTh; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 1754B7DCEF;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=T6hLeXX7Sgkm5cr8ehfdSKVlUfoZynlwUDoVtbhDoqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2008/15]=20l2tp:=20delete=20sessions=20using=20work=20queue|Dat
	 e:=20Tue,=2023=20Jul=202024=2014:51:36=20+0100|Message-Id:=20<3017
	 b6e6df2c9591eb2e487b6e23fe509411f1c0.1721733730.git.jchapman@katal
	 ix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@katalix.com>
	 |References:=20<cover.1721733730.git.jchapman@katalix.com>|MIME-Ve
	 rsion:=201.0;
	b=FEGWyXThopLIeRfiLLp8s9gau+Ib+njkrMYbCf1ZRfErHLwUO6HouZPbyhXxsjZig
	 hBz6gZuUO0QKq2iYVv/3DlBIp6fh3ed2uWIE6ZQm39WpOqIqiDJy8ynsUnGO0dAT+t
	 nOjRjbhH/IOY3naJQtSSF8RUF2XDAyrnRFdsHtbQWvMYOmDRSYIXdcJmY1cXTxKQ8p
	 IzSCfIjTYaHsXPeUehGSc38mhBycYSRbI8PyReYmyiSeOljiURMjwRLrZy03rvextg
	 FN6REOT2MJzTHphw7QSkej1dTVNVxdj/7u/n5ScrbWST5DPh4e5B+Qjiam3V3JxW6i
	 GdgNXczFQWwpQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 08/15] l2tp: delete sessions using work queue
Date: Tue, 23 Jul 2024 14:51:36 +0100
Message-Id: <3017b6e6df2c9591eb2e487b6e23fe509411f1c0.1721733730.git.jchapman@katalix.com>
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

When a tunnel is closed, l2tp_tunnel_closeall closes all sessions in
the tunnel. Move the work of deleting each session to the work queue
so that sessions are deleted using the same codepath whether they are
closed by user API request or their parent tunnel is closing. This
also avoids the locking dance in l2tp_tunnel_closeall where the
tunnel's session list lock was unlocked and relocked in the loop.

In l2tp_exit_net, use drain_workqueue instead of flush_workqueue
because the processing of tunnel_delete work may queue session_delete
work items which must also be processed.
---
 net/l2tp/l2tp_core.c | 36 ++++++++++++++++++++----------------
 net/l2tp/l2tp_core.h |  1 +
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index a01dd891639b..f6ae18c180bf 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1282,18 +1282,8 @@ static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 
 	spin_lock_bh(&tunnel->list_lock);
 	tunnel->acpt_newsess = false;
-	for (;;) {
-		session = list_first_entry_or_null(&tunnel->session_list,
-						   struct l2tp_session, list);
-		if (!session)
-			break;
-		l2tp_session_inc_refcount(session);
-		list_del_init(&session->list);
-		spin_unlock_bh(&tunnel->list_lock);
+	list_for_each_entry(session, &tunnel->session_list, list)
 		l2tp_session_delete(session);
-		spin_lock_bh(&tunnel->list_lock);
-		l2tp_session_dec_refcount(session);
-	}
 	spin_unlock_bh(&tunnel->list_lock);
 }
 
@@ -1631,18 +1621,31 @@ EXPORT_SYMBOL_GPL(l2tp_tunnel_delete);
 
 void l2tp_session_delete(struct l2tp_session *session)
 {
-	if (test_and_set_bit(0, &session->dead))
-		return;
+	if (!test_and_set_bit(0, &session->dead)) {
+		trace_delete_session(session);
+		l2tp_session_inc_refcount(session);
+		queue_work(l2tp_wq, &session->del_work);
+	}
+}
+EXPORT_SYMBOL_GPL(l2tp_session_delete);
+
+/* Workqueue session deletion function */
+static void l2tp_session_del_work(struct work_struct *work)
+{
+	struct l2tp_session *session = container_of(work, struct l2tp_session,
+						    del_work);
 
-	trace_delete_session(session);
 	l2tp_session_unhash(session);
 	l2tp_session_queue_purge(session);
 	if (session->session_close)
 		(*session->session_close)(session);
 
+	/* drop initial ref */
+	l2tp_session_dec_refcount(session);
+
+	/* drop workqueue ref */
 	l2tp_session_dec_refcount(session);
 }
-EXPORT_SYMBOL_GPL(l2tp_session_delete);
 
 /* We come here whenever a session's send_seq, cookie_len or
  * l2specific_type parameters are set.
@@ -1694,6 +1697,7 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 		INIT_HLIST_NODE(&session->hlist);
 		INIT_LIST_HEAD(&session->clist);
 		INIT_LIST_HEAD(&session->list);
+		INIT_WORK(&session->del_work, l2tp_session_del_work);
 
 		if (cfg) {
 			session->pwtype = cfg->pw_type;
@@ -1751,7 +1755,7 @@ static __net_exit void l2tp_exit_net(struct net *net)
 	rcu_read_unlock_bh();
 
 	if (l2tp_wq)
-		flush_workqueue(l2tp_wq);
+		drain_workqueue(l2tp_wq);
 	rcu_barrier();
 
 	idr_destroy(&pn->l2tp_v2_session_idr);
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 6c62d02a0ae6..8d7a589ccd2a 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -102,6 +102,7 @@ struct l2tp_session {
 	int			reorder_skip;	/* set if skip to next nr */
 	enum l2tp_pwtype	pwtype;
 	struct l2tp_stats	stats;
+	struct work_struct	del_work;
 
 	/* Session receive handler for data packets.
 	 * Each pseudowire implementation should implement this callback in order to
-- 
2.34.1


