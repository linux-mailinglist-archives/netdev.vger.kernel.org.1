Return-Path: <netdev+bounces-26428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D40777BC6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C601C21643
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94582150F;
	Thu, 10 Aug 2023 15:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AB2150E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:06:45 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3212702
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:06:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1B5531F88E;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy4mnOOymcRaLlbbw1BMtXaPm615zScYhEHifhWB5WE=;
	b=A72M70g2cX9QXCBjLGIhcLHs4PiahimtuwafEiWDCuCJpRQVGWOaU9bMXztUMvjwC/h/kJ
	wp+WhxlN9eDON6suJJ6VoIDld/XkqBL8rr3+qVF22qzQMIZSh+0/jxZQT+oFdtZaxy02pj
	kk37Oga8Fu1qAlrGRNxL3l4WoTwoUKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sy4mnOOymcRaLlbbw1BMtXaPm615zScYhEHifhWB5WE=;
	b=s7KEKQvmnEKRdTdwNw4trh1ageLXgJ3jR2SrYK/c3Rwi9QKQda0oH9kX2Ka3XMDVDClOnM
	c2r3Eims0UH8M8DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 0729F2C166;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5A89E51CAE5E; Thu, 10 Aug 2023 17:06:40 +0200 (CEST)
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
Subject: [PATCH 17/17] nvmet-tcp: control messages for recvmsg()
Date: Thu, 10 Aug 2023 17:06:30 +0200
Message-Id: <20230810150630.134991-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kTLS requires control messages for recvmsg() to relay any out-of-band
TLS messages (eg TLS alerts) to the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 87 +++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6eebc1157900..d6241bcf9b27 100644
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
@@ -1122,20 +1124,58 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
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
+		pr_err("TLS Alert level %u desc %u\n", level, description);
+		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
+			-ENOTCONN : -EAGAIN;
+		break;
+	default:
+		/* discard this record type */
+		pr_err("TLS record %d unhandled\n", ctype);
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
@@ -1188,16 +1228,22 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
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
@@ -1215,20 +1261,30 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
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
 
@@ -1396,6 +1452,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		c->recv_msg.msg_control = c->recv_cbuf;
+		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
+	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1705,6 +1765,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status)
 		queue->tls_pskid = peerid;
+
 	queue->state = NVMET_TCP_Q_CONNECTING;
 	spin_unlock_bh(&queue->state_lock);
 
-- 
2.35.3


