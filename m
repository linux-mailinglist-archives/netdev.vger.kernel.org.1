Return-Path: <netdev+bounces-231863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A899CBFE002
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EA2F3455C5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DA333448;
	Wed, 22 Oct 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu/s1iJE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E3351FD9
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160642; cv=none; b=t1WjIE2qMifJMzJuoOLzet7ArK1l06Tg0LSVESSB4q8QuJodcH0DzvaBXWxktzh86lSOmzs5UPc3+mIS5hNfRH8iOifA0hDmmz1CPGx4mqT7fGgCB3VDU+JdPUcCxzPr+AEsZ3scGYuij9r2OgsI/n2Wjaqsym83EI1Jejm4c/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160642; c=relaxed/simple;
	bh=/T/o6B1lOIa0smDycRVqrkfGehnLhQG/8tIgXy1mIqE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABLjz/MBGCENyNOKM+ZiQADOubGcPkTPBRSsCgeX8fT1VgFjanF9TcHGTBgN9clOHhtqBg+Kyix1Zsti7U6V6Gz7GlZW00xeDFHh5T8s1rUj+wmpXk2JB6dqHVFOr0dKt9cQMK9o4a/2RjkGa5M32TVQG6CZAYYojbMI+F8WfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu/s1iJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43414C4CEFD
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160641;
	bh=/T/o6B1lOIa0smDycRVqrkfGehnLhQG/8tIgXy1mIqE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lu/s1iJEvQUyYNzY5Jlb94yATV0Z2l2ojx2mcLInFLcd6b5rYyb5berRR+O67R0AV
	 4SxvtxAB14IiB/3ggfpD3JGPsOdGEsOXJYLyI3vMSnNGhMtPNxWkl5KP7DgIHYvEOM
	 F5Cv6R2GWeA2386mzXEC4meArvIHYcLTqtIZi+Ha/WbNrnKzbUs0A+NKs5bQRqAruI
	 rXESM9TrKAl0F6DBGSh1FHqgjj5qP3eXdn7KJZORdRSL+mlMfKTbAo+ly3tFApWx8G
	 koWFxBBlma85av2JFooDT93RTyRN8MyIsfHh7u46hdFNrsGyz7iLunIhsVzOefeIvp
	 4BFmJAex4iScA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 13/15] net/rds: Delegate fan-out to a background worker
Date: Wed, 22 Oct 2025 12:17:13 -0700
Message-ID: <20251022191715.157755-14-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerd Rausch <gerd.rausch@oracle.com>

Delegate fan-out to a background worker in order to allow
kernel_getpeername() to acquire a lock on the socket.

This has become necessary since the introduction of
commit "9dfc685e0262d ("inet: remove races in inet{6}_getname()")

The socket is already locked in the context that
"kernel_getpeername" used to get called by either
rds_tcp_recv_path" or "tcp_v{4,6}_rcv",
and therefore causing a deadlock.

Luckily, the fan-out need not happen in-context nor fast,
so we can easily just do the same in a background worker.

We also need to fix the usage of function kernel_getpeername(),
because it no longer returns "== 0" upon success, since:
commit 9b2c45d479d0 ("net: make getname() functions return length
rather than use int* parameter")
Which was introduced Linux-4.17

The comments in "net/socket.c" still claimed that it would
return "== 0", until that was fixed in Linux-5.17:
commit 0fc95dec096c2 ("net: fix documentation for kernel_getsockname")

Also, while we're doing this, we get rid of the unused
struct members "t_conn_w", "t_send_w", "t_down_w" & "t_recv_w".

For simplicity & resilience against future cherry-picks,
we target this change for both UEK-6 & UEK7 (and beyond),
even though technically speaking UEK-6 only needs the subset
affecting the return-value of function kernel_getpeername(),
as that function doesn't acquire a lock on the socket (yet).

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp.c         |  3 +++
 net/rds/tcp.h         |  7 ++----
 net/rds/tcp_connect.c |  2 ++
 net/rds/tcp_listen.c  | 56 ++++++++++++++++++++++++++++++-------------
 4 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 45484a93d75f..02f8f928c20b 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -358,6 +358,8 @@ static void rds_tcp_conn_free(void *arg)
 
 	rdsdebug("freeing tc %p\n", tc);
 
+	cancel_work_sync(&tc->t_fan_out_w);
+
 	spin_lock_irqsave(&rds_tcp_conn_lock, flags);
 	if (!tc->t_tcp_node_detached)
 		list_del(&tc->t_tcp_node);
@@ -384,6 +386,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
+		INIT_WORK(&tc->t_fan_out_w, rds_tcp_fan_out_w);
 		init_waitqueue_head(&tc->t_recv_done_waitq);
 
 		conn->c_path[i].cp_transport_data = tc;
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 67da77e9016d..97834d241da8 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -44,11 +44,7 @@ struct rds_tcp_connection {
 	size_t			t_tinc_hdr_rem;
 	size_t			t_tinc_data_rem;
 
-	/* XXX error report? */
-	struct work_struct	t_conn_w;
-	struct work_struct	t_send_w;
-	struct work_struct	t_down_w;
-	struct work_struct	t_recv_w;
+	struct work_struct	t_fan_out_w;
 
 	/* for info exporting only */
 	struct list_head	t_list_item;
@@ -90,6 +86,7 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
+void rds_tcp_fan_out_w(struct work_struct *work);
 void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out);
 int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index f832cdfe149b..469d70f2d87b 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -115,6 +115,8 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	if (cp->cp_index > 0 && cp->cp_conn->c_npaths < 2)
 		return -EAGAIN;
 
+	cancel_work_sync(&tc->t_fan_out_w);
+
 	mutex_lock(&tc->t_conn_path_lock);
 
 	if (rds_conn_path_up(cp)) {
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index e11c8c5dae98..f46bdfbd0834 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -67,7 +67,7 @@ rds_tcp_get_peer_sport(struct socket *sock)
 	} saddr;
 	int sport;
 
-	if (kernel_getpeername(sock, &saddr.addr) == 0) {
+	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
 		switch (saddr.addr.sa_family) {
 		case AF_INET:
 			sport = ntohs(saddr.sin.sin_port);
@@ -123,27 +123,20 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 	return NULL;
 }
 
-void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
+void rds_tcp_fan_out_w(struct work_struct *work)
 {
-	struct rds_tcp_connection *tc;
-	struct rds_tcp_net *rtn;
-	struct socket *sock;
+	struct rds_tcp_connection *tc = container_of(work,
+						     struct rds_tcp_connection,
+						     t_fan_out_w);
+	struct rds_connection *conn = tc->t_cpath->cp_conn;
+	struct rds_tcp_net *rtn = tc->t_rtn;
+	struct socket *sock = tc->t_sock;
 	int sport, npaths;
 
-	if (rds_destroy_pending(conn))
-		return;
-
-	tc = conn->c_path->cp_transport_data;
-	rtn = tc->t_rtn;
-	if (!rtn)
-		return;
-
-	sock = tc->t_sock;
-
 	/* During fan-out, check that the connection we already
 	 * accepted in slot#0 carried the proper source port modulo.
 	 */
-	if (fan_out && conn->c_with_sport_idx && sock &&
+	if (conn->c_with_sport_idx && sock &&
 	    rds_addr_cmp(&conn->c_laddr, &conn->c_faddr) > 0) {
 		/* cp->cp_index is encoded in lowest bits of source-port */
 		sport = rds_tcp_get_peer_sport(sock);
@@ -167,6 +160,37 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 	rds_tcp_accept_work(rtn);
 }
 
+void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
+{
+	struct rds_conn_path *cp0;
+	struct rds_tcp_connection *tc;
+	struct rds_tcp_net *rtn;
+
+	if (rds_destroy_pending(conn))
+		return;
+
+	cp0 = conn->c_path;
+	tc = cp0->cp_transport_data;
+	rtn = tc->t_rtn;
+	if (!rtn)
+		return;
+
+	if (fan_out)
+		/* Delegate fan-out to a background worker in order
+		 * to allow "kernel_getpeername" to acquire a lock
+		 * on the socket.
+		 * The socket is already locked in this context
+		 * by either "rds_tcp_recv_path" or "tcp_v{4,6}_rcv",
+		 * depending on the origin of the dequeue-request.
+		 */
+		queue_work(cp0->cp_wq, &tc->t_fan_out_w);
+	else
+		/* Fan-out either already happened or is unnecessary.
+		 * Just go ahead and attempt to accept more connections
+		 */
+		rds_tcp_accept_work(rtn);
+}
+
 int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 {
 	struct socket *listen_sock = rtn->rds_tcp_listen_sock;
-- 
2.43.0


