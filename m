Return-Path: <netdev+bounces-231860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92143BFE00E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40C23A897E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA9350D74;
	Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjxkLCT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EFC350A33
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160641; cv=none; b=dzTEw2Fr3c9Ji2n0D53qlt6/seEuIUHPGzJTo6djGThEDWzpe8Hl5zzwHSnlXxrm01gQK8j8XLFecK4+L4nRovrRGnnPvaM21kW+Q+1MsKe+g6Vm2aDlrFSh327GxXEDK1Wu0g3uHDIVm73JCNf3cbem9hv527aOC+eqTJO9niE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160641; c=relaxed/simple;
	bh=jpY2K6Uph4d47jpCFSOF4DCLurbGh0xxZhMSZogBkwI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5NWPRoQwoZjIWhrjpayBC/ciLFM/5jUm1QmWGWdsHfiug3k4/ajPZLyfRC1cm99PSFtkPkXgBoSq88UGNO3eyBOI4n9Pz/PQCG/tUWVbgy80hDYdDym47S+72F74Q9N4M/JqeuL0Og54ugLqKPIZJd3ZD1swIyzInFNZcM0Xlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjxkLCT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F7CC4CEE7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160641;
	bh=jpY2K6Uph4d47jpCFSOF4DCLurbGh0xxZhMSZogBkwI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HjxkLCT01DpyrvdqLyltGT5oB1ekxbvTLiJWliraG1nrP2Fwogk81lPx200RhNKTM
	 1zPO9aFsB0dnDr29Ruz1e3p6OIaZFN95ytm/fa8EKcOAG9dfxmcQkhwe/ennjuGbRb
	 Dbp7Ip3lnDZm6AEgxvLdxm/ACCkhxkbgATUkGbQO5uzBnYYm6cq7omwP3FDt59Fn6S
	 dOZkN4ikx792vZnfMZ/CDLvYsZs1gJYtP6vrwox/rilc9Ftpkxvc/DxV9Q+QVdex48
	 s6e2F4tvkIoiQpD28RSinCMLfPcTJzytGP9caHxRNKmThuNUYV6dExSKwV5s2/EjXD
	 vjBVtXsHq3EPQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 12/15] net/rds: Trigger rds_send_ping() more than once
Date: Wed, 22 Oct 2025 12:17:12 -0700
Message-ID: <20251022191715.157755-13-achender@kernel.org>
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

Even though a peer may have already received a
non-zero value for "RDS_EXTHDR_NPATHS" from a node in the past,
the current peer may not.

Therefore it is important to initiate another rds_send_ping()
after a re-connect to any peer:
It is unknown at that time if we're still talking to the same
instance of RDS kernel modules on the other side.

Otherwise, the peer may just operate on a single lane
("c_npaths == 0"), not knowing that more lanes are available.

However, if "c_with_sport_idx" is supported,
we also need to check that the connection we accepted on lane#0
meets the proper source port modulo requirement, as we fan out:

Since the exchange of "RDS_EXTHDR_NPATHS" and "RDS_EXTHDR_SPORT_IDX"
is asynchronous, initially we have no choice but to accept an incoming
connection (via "accept") in the first slot ("cp_index == 0")
for backwards compatibility.

But that very connection may have come from a different lane
with "cp_index != 0", since the peer thought that we already understood
and handled "c_with_sport_idx" properly, as indicated by a previous
exchange before a module was reloaded.

In short:
If a module gets reloaded, we recover from that, but do *not*
allow a downgrade to support fewer lanes.

Downgrades would require us to merge messages from separate lanes,
which is rather tricky with the current RDS design.
Each lane has its own sequence number space and all messages
would need to be re-sequenced as we merge, all while
handling "RDS_FLAG_RETRANSMITTED" and "cp_retrans" properly.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |  5 +++-
 net/rds/rds.h        |  2 +-
 net/rds/recv.c       |  7 +++++-
 net/rds/send.c       | 17 ++++++++++++++
 net/rds/tcp.h        |  2 +-
 net/rds/tcp_listen.c | 55 +++++++++++++++++++++++++++++++++-----------
 6 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 99709ddc80d7..1760a355fbfc 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -442,13 +442,16 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
+		if (conn->c_trans->t_mp_capable &&
+		    cp->cp_index == 0)
+			rds_send_ping(conn, 0);
 		rds_queue_reconnect(cp);
 	} else {
 		rcu_read_unlock();
 	}
 
 	if (conn->c_trans->conn_slots_available)
-		conn->c_trans->conn_slots_available(conn);
+		conn->c_trans->conn_slots_available(conn, false);
 }
 
 /* destroy a single rds_conn_path. rds_conn_destroy() iterates over
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 48623f8d70a8..348ed407cfdc 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -548,7 +548,7 @@ struct rds_transport {
 	 * last time.  This ensures messages received on the new socket are not discarded
 	 * when no connection path was available at the time.
 	 */
-	void (*conn_slots_available)(struct rds_connection *conn);
+	void (*conn_slots_available)(struct rds_connection *conn, bool fan_out);
 	int (*conn_path_connect)(struct rds_conn_path *cp);
 
 	/*
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 889a5b7935e5..4b3f9e4a8bfd 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -209,6 +209,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
 	int new_npaths;
+	bool fan_out;
 
 	new_npaths = conn->c_npaths;
 
@@ -248,7 +249,11 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		spin_lock_irqsave(&cp0->cp_lock, flags);
 		conn->c_cp0_mprds_catchup_tx_seq = cp0->cp_next_tx_seq;
 		spin_unlock_irqrestore(&cp0->cp_lock, flags);
+		fan_out = true;
+	} else {
+		fan_out = false;
 	}
+
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, new_npaths, 1);
 
@@ -257,7 +262,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 
 	if (conn->c_npaths > 1 &&
 	    conn->c_trans->conn_slots_available)
-		conn->c_trans->conn_slots_available(conn);
+		conn->c_trans->conn_slots_available(conn, fan_out);
 }
 
 /* rds_start_mprds() will synchronously start multiple paths when appropriate.
diff --git a/net/rds/send.c b/net/rds/send.c
index 5e360235dc94..8b051f1dfc6a 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1327,6 +1327,23 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		cpath = &conn->c_path[0];
 	}
 
+	/* c_npaths == 0 if we have not talked to this peer
+	 * before.  Initiate a connection request to the
+	 * peer right away.
+	 */
+	if (conn->c_trans->t_mp_capable &&
+	    !rds_conn_path_up(&conn->c_path[0])) {
+		/* Ensures that only one request is queued.  And
+		 * rds_send_ping() ensures that only one ping is
+		 * outstanding.
+		 */
+		if (!test_and_set_bit(RDS_RECONNECT_PENDING,
+				      &conn->c_path[0].cp_flags))
+			queue_delayed_work(conn->c_path[0].cp_wq,
+					   &conn->c_path[0].cp_conn_w, 0);
+		rds_send_ping(conn, 0);
+	}
+
 	rm->m_conn_path = cpath;
 
 	/* Parse any control messages the user may have included. */
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 1893bc4bd342..67da77e9016d 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -90,7 +90,7 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
-void rds_tcp_conn_slots_available(struct rds_connection *conn);
+void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out);
 int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
 void *rds_tcp_listen_sock_def_readable(struct net *net);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 3da259f3a556..e11c8c5dae98 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -56,14 +56,8 @@ void rds_tcp_keepalive(struct socket *sock)
 	tcp_sock_set_keepintvl(sock->sk, keepidle);
 }
 
-/* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
- * client's ipaddr < server's ipaddr. Otherwise, close the accepted
- * socket and force a reconneect from smaller -> larger ip addr. The reason
- * we special case cp_index 0 is to allow the rds probe ping itself to itself
- * get through efficiently.
- */
-static struct rds_tcp_connection *
-rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
+static int
+rds_tcp_get_peer_sport(struct socket *sock)
 {
 	union {
 		struct sockaddr_storage storage;
@@ -71,11 +65,9 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 		struct sockaddr_in sin;
 		struct sockaddr_in6 sin6;
 	} saddr;
-	int sport, npaths, i_min, i_max, i;
+	int sport;
 
-	if (conn->c_with_sport_idx &&
-	    kernel_getpeername(sock, &saddr.addr) == 0) {
-		/* cp->cp_index is encoded in lowest bits of source-port */
+	if (kernel_getpeername(sock, &saddr.addr) == 0) {
 		switch (saddr.addr.sa_family) {
 		case AF_INET:
 			sport = ntohs(saddr.sin.sin_port);
@@ -90,6 +82,26 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 		sport = -1;
 	}
 
+	return sport;
+}
+
+/* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
+ * client's ipaddr < server's ipaddr. Otherwise, close the accepted
+ * socket and force a reconneect from smaller -> larger ip addr. The reason
+ * we special case cp_index 0 is to allow the rds probe ping itself to itself
+ * get through efficiently.
+ */
+static struct rds_tcp_connection *
+rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
+{
+	int sport, npaths, i_min, i_max, i;
+
+	if (conn->c_with_sport_idx)
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		sport = rds_tcp_get_peer_sport(sock);
+	else
+		sport = -1;
+
 	npaths = max_t(int, 1, conn->c_npaths);
 
 	if (sport >= 0) {
@@ -111,10 +123,12 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 	return NULL;
 }
 
-void rds_tcp_conn_slots_available(struct rds_connection *conn)
+void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 {
 	struct rds_tcp_connection *tc;
 	struct rds_tcp_net *rtn;
+	struct socket *sock;
+	int sport, npaths;
 
 	if (rds_destroy_pending(conn))
 		return;
@@ -124,6 +138,21 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn)
 	if (!rtn)
 		return;
 
+	sock = tc->t_sock;
+
+	/* During fan-out, check that the connection we already
+	 * accepted in slot#0 carried the proper source port modulo.
+	 */
+	if (fan_out && conn->c_with_sport_idx && sock &&
+	    rds_addr_cmp(&conn->c_laddr, &conn->c_faddr) > 0) {
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		sport = rds_tcp_get_peer_sport(sock);
+		npaths = max_t(int, 1, conn->c_npaths);
+		if (sport >= 0 && sport % npaths != 0)
+			/* peer initiated with a non-#0 lane first */
+			rds_conn_path_drop(conn->c_path, 0);
+	}
+
 	/* As soon as a connection went down,
 	 * it is safe to schedule a "rds_tcp_accept_one"
 	 * attempt even if there are no connections pending:
-- 
2.43.0


