Return-Path: <netdev+bounces-28052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1D77E130
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDA52819A5
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815BB156F2;
	Wed, 16 Aug 2023 12:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75596156E8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:06:30 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C302690
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:06:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2D6FC1FD6D;
	Wed, 16 Aug 2023 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5syOYf2FbNeUU81PSg/DjOopXf1XiFXvucnCZoHAhkA=;
	b=jmQHoYupaT98WIKPFeXnP1NkAvVbpybsv46oOqw6siK8TXQf/frJZxsi84JxQU8KXHbC3l
	Kw/AVxGTZUQS7oOdOQntkf2shfycMEeyx3eTbeCfo1ehc1el6rqTuR5Xbq4mhXzthNls52
	1Lm7PeqJ7Yv7Lg5HvzBJddpXoRC0/vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5syOYf2FbNeUU81PSg/DjOopXf1XiFXvucnCZoHAhkA=;
	b=u1ZezhLidyO2i4DIqxQWBc5ZDpbLFC3YTdN7tJgFu2IL7P7NcJvGfT6IIU4iF8w49g0tDJ
	w2DOv3UHlYP5ieDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1A3832C175;
	Wed, 16 Aug 2023 12:06:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 15B7151CB240; Wed, 16 Aug 2023 14:06:24 +0200 (CEST)
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
Subject: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Date: Wed, 16 Aug 2023 14:06:08 +0200
Message-Id: <20230816120608.37135-19-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816120608.37135-1-hare@suse.de>
References: <20230816120608.37135-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Incoming connection might be either 'normal' NVMe-TCP connections
starting with icreq or TLS handshakes. To ensure that 'normal'
connections can still be handled we need to peek the first packet
and only start TLS handshake if it's not an icreq.
With that we can lift the restriction to always set TREQ to
'required' when TLS1.3 is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 25 +++++++++++---
 drivers/nvme/target/nvmet.h    |  5 +++
 drivers/nvme/target/tcp.c      | 61 +++++++++++++++++++++++++++++++---
 3 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b780ce049163..9eed6e6765ea 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -198,6 +198,20 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	return -EINVAL;
 
 found:
+	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
+	    port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
+		switch (nvmet_addr_treq[i].type) {
+		case NVMF_TREQ_NOT_SPECIFIED:
+			pr_debug("treq '%s' not allowed for TLS1.3\n",
+				 nvmet_addr_treq[i].name);
+			return -EINVAL;
+		case NVMF_TREQ_NOT_REQUIRED:
+			pr_warn("Allow non-TLS connections while TLS1.3 is enabled\n");
+			break;
+		default:
+			break;
+		}
+	}
 	treq |= nvmet_addr_treq[i].type;
 	port->disc_addr.treq = treq;
 	return count;
@@ -410,12 +424,15 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
 	nvmet_port_init_tsas_tcp(port, sectype);
 	/*
-	 * The TLS implementation currently does not support
-	 * secure concatenation, so TREQ is always set to 'required'
-	 * if TLS is enabled.
+	 * If TLS is enabled TREQ should be set to 'required' per default
 	 */
 	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
-		treq |= NVMF_TREQ_REQUIRED;
+		u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
+
+		if (sc == NVMF_TREQ_NOT_SPECIFIED)
+			treq |= NVMF_TREQ_REQUIRED;
+		else
+			treq |= sc;
 	} else {
 		treq |= NVMF_TREQ_NOT_SPECIFIED;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e35a03260f45..3e179019ca7c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -184,6 +184,11 @@ static inline u8 nvmet_port_disc_addr_treq_secure_channel(struct nvmet_port *por
 	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
 }
 
+static inline bool nvmet_port_secure_channel_required(struct nvmet_port *port)
+{
+    return nvmet_port_disc_addr_treq_secure_channel(port) == NVMF_TREQ_REQUIRED;
+}
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8be9203a1de6..5cae74e48e84 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1729,6 +1729,54 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 }
 
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
+{
+	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
+	int len, ret;
+	struct kvec iov = {
+		.iov_base = (u8 *)&queue->pdu + queue->offset,
+		.iov_len = sizeof(struct nvme_tcp_hdr),
+	};
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_PEEK,
+	};
+
+	if (nvmet_port_secure_channel_required(queue->port->nport))
+		return 0;
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+			iov.iov_len, msg.msg_flags);
+	if (unlikely(len < 0)) {
+		pr_debug("queue %d: peek error %d\n",
+			 queue->idx, len);
+		return len;
+	}
+
+	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+	if (ret < 0)
+		return ret;
+
+	if (len < sizeof(struct nvme_tcp_hdr)) {
+		pr_debug("queue %d: short read, %d bytes missing\n",
+			 queue->idx, (int)iov.iov_len - len);
+		return -EAGAIN;
+	}
+	pr_debug("queue %d: hdr type %d hlen %d plen %d size %d\n",
+		 queue->idx, hdr->type, hdr->hlen, hdr->plen,
+		 (int)sizeof(struct nvme_tcp_icreq_pdu));
+	if (hdr->type == nvme_tcp_icreq &&
+	    hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
+	    hdr->plen == (__le32)sizeof(struct nvme_tcp_icreq_pdu)) {
+		pr_debug("queue %d: icreq detected\n",
+			 queue->idx);
+		return len;
+	}
+	return 0;
+}
+
 static void nvmet_tcp_tls_handshake_done(void *data, int status,
 					 key_serial_t peerid)
 {
@@ -1868,11 +1916,14 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_user_data = NULL;
 		sk->sk_data_ready = port->data_ready;
 		read_unlock_bh(&sk->sk_callback_lock);
-		if (!nvmet_tcp_tls_handshake(queue))
-			return;
-
-		/* TLS handshake failed, terminate the connection */
-		goto out_destroy_sq;
+		if (!nvmet_tcp_try_peek_pdu(queue)) {
+			if (!nvmet_tcp_tls_handshake(queue))
+				return;
+			/* TLS handshake failed, terminate the connection */
+			goto out_destroy_sq;
+		}
+		/* Not a TLS connection, continue with normal processing */
+		queue->state = NVMET_TCP_Q_CONNECTING;
 	}
 #endif
 
-- 
2.35.3


