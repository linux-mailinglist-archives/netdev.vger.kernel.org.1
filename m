Return-Path: <netdev+bounces-231855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E58BFDFF6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A00D1A6137E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC236334371;
	Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B256OHly"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891D34AAED
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160639; cv=none; b=IzqmYUSmy5BlYv9wk9ABDINtqk9k2RgwAEqUMZrmsRJRUzdqi2lSmFSL/G3LdEyy7d+T71urlvCGi9wrjV0I/lz0UlHGjY59UnL0tXvyNwsDCkJDXaqrvUIarGom16E4W+4rpoppj9+w/KRoyrBAnClSxEjv8SWpBIC5m3QVcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160639; c=relaxed/simple;
	bh=sQB0kg59rAHXpEyW1Ni1ICB9cd9tnltPrUurivU19m0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5ufZSkmNVz1flRP+L7Vvyy5wMZ7nM6d8mY+0kgdQ4SdqLuOizGL8YhluyKlwijpBAI6/nZ5+GgMVq86TzvlPk9RTuPX7rGdmXzKvXI28RZ7kqMckpNPaqKFxvrIdsyBzQhEjc/SCt+zjpN4nSYstWbRXJCKiOKMKSQxpqj3Das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B256OHly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EEFC116B1
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160639;
	bh=sQB0kg59rAHXpEyW1Ni1ICB9cd9tnltPrUurivU19m0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B256OHlyaT7EtQ+V0lFOO/7KsG5YOf509LEdHSXHxYgOlc3tz3qY7k1nq1i8djFRo
	 iXeTuoSxNEf6IsxuYM8bFjBpNNtVm5+nDkvX4tjfE8fE2RwiFgu9O5gPH78fyyZcEH
	 8zNQCHOADZ2DJYjqX9lZt+ZPsZ6/kR1snpXXmxbXbR/qnVURPCuW780F5cGZAQaP7w
	 9GdgYx4oR+IbJyFqkxov+Tb+qBnl0BNW/6FzAlnvsb1lJE+0UmJYopc6lr/WhDFOWK
	 Ni7Nwak2dPflgslOUwthPCWc4L7HSZKsZHc/TWQNryz0bqEMzpJ5fvOnClNKaJeOr/
	 /kN3X48oP0MbA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 07/15] net/rds: Encode cp_index in TCP source port
Date: Wed, 22 Oct 2025 12:17:07 -0700
Message-ID: <20251022191715.157755-8-achender@kernel.org>
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

Upon "sendmsg", RDS/TCP selects a backend connection based
on a hash calculated from the source-port ("RDS_MPATH_HASH").

However, "rds_tcp_accept_one" accepts connections
in the order they arrive, which is non-deterministic.

Therefore the mapping of the sender's "cp->cp_index"
to that of the receiver changes if the backend
connections are dropped and reconnected.

However, connection state that's preserved across reconnects
(e.g. "cp_next_rx_seq") relies on that sender<->receiver
mapping to never change.

So we make sure that client and server of the TCP connection
have the exact same "cp->cp_index" across reconnects by
encoding "cp->cp_index" in the lower three bits of the
client's TCP source port.

A new extension "RDS_EXTHDR_SPORT_IDX" is introduced,
that allows the server to tell the difference between
clients that do the "cp->cp_index" encoding, and
legacy clients that pick source ports randomly.

Fixes: commit 5916e2c1554f ("RDS: TCP: Enable multipath RDS for TCP")
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/message.c     |  1 +
 net/rds/rds.h         |  3 +++
 net/rds/recv.c        |  7 +++++++
 net/rds/send.c        |  4 ++++
 net/rds/tcp.h         |  1 +
 net/rds/tcp_connect.c | 22 ++++++++++++++++++++-
 net/rds/tcp_listen.c  | 45 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 591a27c9c62f..54fd000806ea 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -47,6 +47,7 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_RDMA_BYTES] = sizeof(struct rds_ext_header_rdma_bytes),
 [RDS_EXTHDR_NPATHS]	= sizeof(__be16),
 [RDS_EXTHDR_GEN_NUM]	= sizeof(__be32),
+[RDS_EXTHDR_SPORT_IDX]	= 1,
 };
 
 void rds_message_addref(struct rds_message *rm)
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 569a72c2a2a5..0196ee99e58e 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -148,6 +148,7 @@ struct rds_connection {
 				c_ping_triggered:1,
 				c_pad_to_32:29;
 	int			c_npaths;
+	bool			c_with_sport_idx;
 	struct rds_connection	*c_passive;
 	struct rds_transport	*c_trans;
 
@@ -278,8 +279,10 @@ struct rds_ext_header_rdma_bytes {
  */
 #define RDS_EXTHDR_NPATHS	5
 #define RDS_EXTHDR_GEN_NUM	6
+#define RDS_EXTHDR_SPORT_IDX    8
 
 #define __RDS_EXTHDR_MAX	16 /* for now */
+
 #define RDS_RX_MAX_TRACES	(RDS_MSG_RX_DGRAM_TRACE_MAX + 1)
 #define	RDS_MSG_RX_HDR		0
 #define	RDS_MSG_RX_START	1
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 66680f652e74..ddf128a02347 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -204,7 +204,9 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		struct rds_ext_header_version version;
 		__be16 rds_npaths;
 		__be32 rds_gen_num;
+		u8 dummy;
 	} buffer;
+	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
 
 	while (1) {
@@ -221,11 +223,16 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		case RDS_EXTHDR_GEN_NUM:
 			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
 			break;
+		case RDS_EXTHDR_SPORT_IDX:
+			new_with_sport_idx = true;
+			break;
 		default:
 			pr_warn_ratelimited("ignoring unknown exthdr type "
 					     "0x%x\n", type);
 		}
 	}
+
+	conn->c_with_sport_idx = new_with_sport_idx;
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
diff --git a/net/rds/send.c b/net/rds/send.c
index f73facfbe5b0..a90056d40749 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1456,12 +1456,16 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	    cp->cp_conn->c_trans->t_mp_capable) {
 		__be16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
 		__be32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
+		u8 dummy = 0;
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_NPATHS, &npaths);
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_GEN_NUM,
 					  &my_gen_num);
+		rds_message_add_extension(&rm->m_inc.i_hdr,
+					  RDS_EXTHDR_SPORT_IDX,
+					  &dummy);
 	}
 	spin_unlock_irqrestore(&cp->cp_lock, flags);
 
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 2000f4acd57a..3beb0557104e 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -34,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	u32			t_client_port_group;
 	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..6b9d4776e504 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -93,6 +93,8 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct sockaddr *addr;
+	int port_low, port_high, port;
+	int port_groups, groups_left;
 	int addrlen;
 	bool isv6;
 	int ret;
@@ -145,7 +147,25 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = kernel_bind(sock, addr, addrlen);
+	/* encode cp->cp_index in lowest bits of source-port */
+	inet_get_local_port_range(rds_conn_net(conn), &port_low, &port_high);
+	port_low = ALIGN(port_low, RDS_MPATH_WORKERS);
+	port_groups = (port_high - port_low + 1) / RDS_MPATH_WORKERS;
+	ret = -EADDRINUSE;
+	groups_left = port_groups;
+	while (groups_left-- > 0 && ret) {
+		if (++tc->t_client_port_group >= port_groups)
+			tc->t_client_port_group = 0;
+		port =  port_low +
+			tc->t_client_port_group * RDS_MPATH_WORKERS +
+			cp->cp_index;
+
+		if (isv6)
+			sin6.sin6_port = htons(port);
+		else
+			sin.sin_port = htons(port);
+		ret = sock->ops->bind(sock, addr, addrlen);
+	}
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 23fa67fed567..d9960c2399d4 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -62,19 +62,52 @@ void rds_tcp_keepalive(struct socket *sock)
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
  */
-static
-struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
+static struct rds_tcp_connection *
+rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 {
-	int i;
-	int npaths = max_t(int, 1, conn->c_npaths);
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr addr;
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} saddr;
+	int sport, npaths, i_min, i_max, i;
+
+	if (conn->c_with_sport_idx &&
+	    kernel_getpeername(sock, &saddr.addr) == 0) {
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		switch (saddr.addr.sa_family) {
+		case AF_INET:
+			sport = ntohs(saddr.sin.sin_port);
+			break;
+		case AF_INET6:
+			sport = ntohs(saddr.sin6.sin6_port);
+			break;
+		default:
+			sport = -1;
+		}
+	} else {
+		sport = -1;
+	}
+
+	npaths = max_t(int, 1, conn->c_npaths);
 
-	for (i = 0; i < npaths; i++) {
+	if (sport >= 0) {
+		i_min = sport % npaths;
+		i_max = i_min;
+	} else {
+		i_min = 0;
+		i_max = npaths - 1;
+	}
+
+	for (i = i_min; i <= i_max; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
 					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
 	}
+
 	return NULL;
 }
 
@@ -199,7 +232,7 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		 * to and discarded by the sender.
 		 * We must not throw those away!
 		 */
-		rs_tcp = rds_tcp_accept_one_path(conn);
+		rs_tcp = rds_tcp_accept_one_path(conn, new_sock);
 		if (!rs_tcp) {
 			/* It's okay to stash "new_sock", since
 			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
-- 
2.43.0


