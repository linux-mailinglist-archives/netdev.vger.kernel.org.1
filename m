Return-Path: <netdev+bounces-231859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158F3BFE008
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D03A8821
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410123502BA;
	Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IledbMnM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5534DCC7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160641; cv=none; b=ona9gIaOl560d/CuTAc85cCoLm60vygveEFol8qCk54nSM/BoINLgDRDcf03hjRpHcpFgJw9k26Rn3HCx/344Yf4NJMqsDDEuKEr5rFnxjo+TAdHgtfl7GBcETnZnLSZYJIFPoamyEYRJyDRZ55JG9jD195yKHYY0JCbGOTtuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160641; c=relaxed/simple;
	bh=wD53xIvxy4TAqW16WU4SZ4Io4Yq7/RgZR+SrNniKjXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr/amigNtN3uEKzHfTVQEJTUALTb5ke6Xf8GHtW39sZIkN8tF/8oTFEcudGuuxGrh0K4w6+5YrV7IO41WAAtdaN+1Y2kwnNmWhrW9cfi4svXQdtNxwdy9ti3CBzOOaAI3aDRLZqvIJkpyPyAyb7QZwZxVyorJFKxNUtC3qlagkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IledbMnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6D8C4CEF7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160640;
	bh=wD53xIvxy4TAqW16WU4SZ4Io4Yq7/RgZR+SrNniKjXY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IledbMnMhGei5AaSVtOk5M8T78I0OTiNA7/yaqdJY7/rms4rNeB//+jAQczzwPKNt
	 l+RwkW3ULIOvPKgU8rhYjgy4pv0hOS+5cr16WO54/EtXFO8rpRtZittLEvXB2THUwQ
	 KxVxxRxKH88DcwsFQfHS2kMEvCKumQ5AIHOmr7+hYgwZkEj4dlWsu7AT+WzHMAibsu
	 99A4dk3hHB2t2dovXx6HxmD6LSK4KTDoyTAS1VaOkxCnpZ/S3eQ5zEBj4243BDU68Y
	 Us7ObNa9SmxMvV+pzrTz2ozurTShoePEmwO0miMIj+qQL97QMsWrx8+sMISd2CqPnl
	 si0PJA6SkogEA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 11/15] net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
Date: Wed, 22 Oct 2025 12:17:11 -0700
Message-ID: <20251022191715.157755-12-achender@kernel.org>
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

Instead of just blocking the sender until "c_npaths" is known
(it gets updated upon the receipt of a MPRDS PONG message),
simply use the first lane (cp_index#0).

But just using the first lane isn't enough.

As soon as we enqueue messages on a different lane, we'd run the risk
of out-of-order delivery of RDS messages.

Earlier messages enqueued on "cp_index == 0" could be delivered later
than more recent messages enqueued on "cp_index > 0", mostly because of
possible head of line blocking issues causing the first lane to be
slower.

To avoid that, we simply take a snapshot of "cp_next_tx_seq" at the
time we're about to fan-out to more lanes.

Then we delay the transmission of messages enqueued on other lanes
with "cp_index > 0" until cp_index#0 caught up with the delivery of
new messages (from "cp_send_queue") as well as in-flight
messages (from "cp_retrans") that haven't been acknowledged yet
by the receiver.

We also add a new counter "mprds_catchup_tx0_retries" to keep track
of how many times "rds_send_xmit" had to suspend activities,
because it was waiting for the first lane to catch up.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/rds.h   |  3 ++
 net/rds/recv.c  | 23 +++++++++++--
 net/rds/send.c  | 91 ++++++++++++++++++++++++++++++-------------------
 net/rds/stats.c |  1 +
 4 files changed, 79 insertions(+), 39 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index 0196ee99e58e..48623f8d70a8 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -171,6 +171,8 @@ struct rds_connection {
 
 	u32			c_my_gen_num;
 	u32			c_peer_gen_num;
+
+	u64			c_cp0_mprds_catchup_tx_seq;
 };
 
 static inline
@@ -748,6 +750,7 @@ struct rds_statistics {
 	uint64_t	s_recv_bytes_added_to_socket;
 	uint64_t	s_recv_bytes_removed_from_socket;
 	uint64_t	s_send_stuck_rm;
+	uint64_t	s_mprds_catchup_tx0_retries;
 };
 
 /* af_rds.c */
diff --git a/net/rds/recv.c b/net/rds/recv.c
index ddf128a02347..889a5b7935e5 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -208,6 +208,9 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	} buffer;
 	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
+	int new_npaths;
+
+	new_npaths = conn->c_npaths;
 
 	while (1) {
 		len = sizeof(buffer);
@@ -217,8 +220,8 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		/* Process extension header here */
 		switch (type) {
 		case RDS_EXTHDR_NPATHS:
-			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
-					       be16_to_cpu(buffer.rds_npaths));
+			new_npaths = min_t(int, RDS_MPATH_WORKERS,
+					   be16_to_cpu(buffer.rds_npaths));
 			break;
 		case RDS_EXTHDR_GEN_NUM:
 			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
@@ -233,8 +236,22 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	}
 
 	conn->c_with_sport_idx = new_with_sport_idx;
+
+	if (new_npaths > 1 && new_npaths != conn->c_npaths) {
+		/* We're about to fan-out.
+		 * Make sure that messages from cp_index#0
+		 * are sent prior to handling other lanes.
+		 */
+		struct rds_conn_path *cp0 = conn->c_path;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cp0->cp_lock, flags);
+		conn->c_cp0_mprds_catchup_tx_seq = cp0->cp_next_tx_seq;
+		spin_unlock_irqrestore(&cp0->cp_lock, flags);
+	}
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
-	conn->c_npaths = max_t(int, conn->c_npaths, 1);
+	conn->c_npaths = max_t(int, new_npaths, 1);
+
 	conn->c_ping_triggered = 0;
 	rds_conn_peer_gen_update(conn, new_peer_gen_num);
 
diff --git a/net/rds/send.c b/net/rds/send.c
index a90056d40749..5e360235dc94 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -137,6 +137,8 @@ int rds_send_xmit(struct rds_conn_path *cp)
 {
 	struct rds_connection *conn = cp->cp_conn;
 	struct rds_message *rm;
+	struct rds_conn_path *cp0 = conn->c_path;
+	struct rds_message *rm0;
 	unsigned long flags;
 	unsigned int tmp;
 	struct scatterlist *sg;
@@ -248,6 +250,52 @@ int rds_send_xmit(struct rds_conn_path *cp)
 			if (batch_count >= send_batch_count)
 				goto over_batch;
 
+			if (cp->cp_index > 0) {
+				/* make sure cp_index#0 caught up during fan-out
+				 * in order to avoid lane races
+				 */
+
+				spin_lock_irqsave(&cp0->cp_lock, flags);
+
+				/* the oldest / first message in the retransmit queue
+				 * has to be at or beyond c_cp0_mprds_catchup_tx_seq
+				 */
+				if (!list_empty(&cp0->cp_retrans)) {
+					rm0 = list_entry(cp0->cp_retrans.next,
+							 struct rds_message,
+							 m_conn_item);
+					if (be64_to_cpu(rm0->m_inc.i_hdr.h_sequence) <
+					    conn->c_cp0_mprds_catchup_tx_seq) {
+						/* the retransmit queue of cp_index#0 has not
+						 * quite caught up yet
+						 */
+						spin_unlock_irqrestore(&cp0->cp_lock, flags);
+						rds_stats_inc(s_mprds_catchup_tx0_retries);
+						goto over_batch;
+					}
+				}
+
+				/* the oldest / first message of the send queue
+				 * has to be at or beyond c_cp0_mprds_catchup_tx_seq
+				 */
+				rm0 = cp0->cp_xmit_rm;
+				if (!rm0 && !list_empty(&cp0->cp_send_queue))
+					rm0 = list_entry(cp0->cp_send_queue.next,
+							 struct rds_message,
+							 m_conn_item);
+				if (rm0 && be64_to_cpu(rm0->m_inc.i_hdr.h_sequence) <
+				    conn->c_cp0_mprds_catchup_tx_seq) {
+					/* the send queue of cp_index#0 has not quite
+					 * caught up yet
+					 */
+					spin_unlock_irqrestore(&cp0->cp_lock, flags);
+					rds_stats_inc(s_mprds_catchup_tx0_retries);
+					goto over_batch;
+				}
+
+				spin_unlock_irqrestore(&cp0->cp_lock, flags);
+			}
+
 			spin_lock_irqsave(&cp->cp_lock, flags);
 
 			if (!list_empty(&cp->cp_send_queue)) {
@@ -1041,39 +1089,6 @@ static int rds_cmsg_send(struct rds_sock *rs, struct rds_message *rm,
 	return ret;
 }
 
-static int rds_send_mprds_hash(struct rds_sock *rs,
-			       struct rds_connection *conn, int nonblock)
-{
-	int hash;
-
-	if (conn->c_npaths == 0)
-		hash = RDS_MPATH_HASH(rs, RDS_MPATH_WORKERS);
-	else
-		hash = RDS_MPATH_HASH(rs, conn->c_npaths);
-	if (conn->c_npaths == 0 && hash != 0) {
-		rds_send_ping(conn, 0);
-
-		/* The underlying connection is not up yet.  Need to wait
-		 * until it is up to be sure that the non-zero c_path can be
-		 * used.  But if we are interrupted, we have to use the zero
-		 * c_path in case the connection ends up being non-MP capable.
-		 */
-		if (conn->c_npaths == 0) {
-			/* Cannot wait for the connection be made, so just use
-			 * the base c_path.
-			 */
-			if (nonblock)
-				return 0;
-			if (wait_event_interruptible(conn->c_hs_waitq,
-						     conn->c_npaths != 0))
-				hash = 0;
-		}
-		if (conn->c_npaths == 1)
-			hash = 0;
-	}
-	return hash;
-}
-
 static int rds_rdma_bytes(struct msghdr *msg, size_t *rdma_bytes)
 {
 	struct rds_rdma_args *args;
@@ -1303,10 +1318,14 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		rs->rs_conn = conn;
 	}
 
-	if (conn->c_trans->t_mp_capable)
-		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn, nonblock)];
-	else
+	if (conn->c_trans->t_mp_capable) {
+		/* Use c_path[0] until we learn that
+		 * the peer supports more (c_npaths > 1)
+		 */
+		cpath = &conn->c_path[RDS_MPATH_HASH(rs, conn->c_npaths ? : 1)];
+	} else {
 		cpath = &conn->c_path[0];
+	}
 
 	rm->m_conn_path = cpath;
 
diff --git a/net/rds/stats.c b/net/rds/stats.c
index cb2e3d2cdf73..24ee22d09e8c 100644
--- a/net/rds/stats.c
+++ b/net/rds/stats.c
@@ -79,6 +79,7 @@ static const char *const rds_stat_names[] = {
 	"recv_bytes_added_to_sock",
 	"recv_bytes_freed_fromsock",
 	"send_stuck_rm",
+	"mprds_catchup_tx0_retries",
 };
 
 void rds_stats_info_copy(struct rds_info_iterator *iter,
-- 
2.43.0


