Return-Path: <netdev+bounces-27328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74777B786
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5061C20A6F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F6C8D2;
	Mon, 14 Aug 2023 11:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB20C8C8
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:19:59 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA6E62
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:19:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 68B1E1FD6D;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cToI6lvt8SPVKbzMfXUds4jiS1yzir5a/pnkYsOEe8=;
	b=my1zE0J7e9iddepsAGoKZe+gL9tMBp4Y0D2q9CpOalF31f5RfUIc8H7FzdStdta5n7ugDP
	g7UHSfAtPJXTg7CTr+SUmSUmWsVKaJjyzOgX3CTVB3SiyN5mg22GqZmvx/DHJS3gW/0gmZ
	wqiDcUgTDn8DF9NDNd05qg91qz+YkY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cToI6lvt8SPVKbzMfXUds4jiS1yzir5a/pnkYsOEe8=;
	b=WC9K6SqOU/nGN76LIbdbR9qQf7V+76jJUflDmpWB32TBhPzZDyZ7vJ2PyYCZayRVUr7xjr
	uZgmKjRNI1T4HeDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 548362C174;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 50DE051CB0DF; Mon, 14 Aug 2023 13:19:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/17] nvmet-tcp: control messages for recvmsg()
Date: Mon, 14 Aug 2023 13:19:42 +0200
Message-Id: <20230814111943.68325-17-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kTLS requires control messages for recvmsg() to relay any out-of-band
TLS messages (eg TLS alerts) to the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 94 +++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 77fa339008e1..ded985efdb66 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -14,6 +14,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
@@ -118,6 +119,7 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
+	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1119,20 +1121,65 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
+		struct msghdr *msg, char *cbuf)
+{
+	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
+	u8 ctype, level, description;
+	int ret = 0;
+
+	ctype = tls_get_record_type(queue->sock->sk, cmsg);
+	switch (ctype) {
+	case 0:
+		break;
+	case TLS_RECORD_TYPE_DATA:
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		tls_alert_recv(queue->sock->sk, msg, &level, &description);
+		if (level == TLS_ALERT_LEVEL_FATAL) {
+			pr_err("queue %d: TLS Alert desc %u\n",
+			       queue->idx, description);
+			ret = -ENOTCONN;
+		} else {
+			pr_warn("queue %d: TLS Alert desc %u\n",
+			       queue->idx, description);
+			ret = -EAGAIN;
+		}
+		break;
+	default:
+		/* discard this record type */
+		pr_err("queue %d: TLS record %d unhandled\n",
+		       queue->idx, ctype);
+		ret = -EAGAIN;
+		break;
+	}
+	return ret;
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
-	int len;
+	int len, ret;
 	struct kvec iov;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 
 recv:
 	iov.iov_base = (void *)&queue->pdu + queue->offset;
 	iov.iov_len = queue->left;
+	if (queue->tls_pskid) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+	}
 	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0))
 		return len;
+	if (queue->tls_pskid) {
+		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		if (ret < 0)
+			return ret;
+	}
 
 	queue->offset += len;
 	queue->left -= len;
@@ -1185,16 +1232,22 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd  *cmd = queue->cmd;
-	int ret;
+	int len, ret;
 
 	while (msg_data_left(&cmd->recv_msg)) {
-		ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
+		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
-		if (ret <= 0)
-			return ret;
+		if (len <= 0)
+			return len;
+		if (queue->tls_pskid) {
+			ret = nvmet_tcp_tls_record_ok(cmd->queue,
+					&cmd->recv_msg, cmd->recv_cbuf);
+			if (ret < 0)
+				return ret;
+		}
 
-		cmd->pdu_recv += ret;
-		cmd->rbytes_done += ret;
+		cmd->pdu_recv += len;
+		cmd->rbytes_done += len;
 	}
 
 	if (queue->data_digest) {
@@ -1212,20 +1265,30 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmd;
-	int ret;
+	int ret, len;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
 		.iov_base = (void *)&cmd->recv_ddgst + queue->offset,
 		.iov_len = queue->left
 	};
 
-	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+	if (queue->tls_pskid) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+	}
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (unlikely(ret < 0))
-		return ret;
+	if (unlikely(len < 0))
+		return len;
+	if (queue->tls_pskid) {
+		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		if (ret < 0)
+			return ret;
+	}
 
-	queue->offset += ret;
-	queue->left -= ret;
+	queue->offset += len;
+	queue->left -= len;
 	if (queue->left)
 		return -EAGAIN;
 
@@ -1401,6 +1464,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		c->recv_msg.msg_control = c->recv_cbuf;
+		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
+	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1675,6 +1742,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status)
 		queue->tls_pskid = peerid;
+
 	queue->state = NVMET_TCP_Q_CONNECTING;
 	spin_unlock_bh(&queue->state_lock);
 
-- 
2.35.3


