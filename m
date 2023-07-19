Return-Path: <netdev+bounces-18985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B475940D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0EA1C20EFC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658C13AF1;
	Wed, 19 Jul 2023 11:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C213ADC
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:19:51 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8118D;
	Wed, 19 Jul 2023 04:19:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 24B6C1FE99;
	Wed, 19 Jul 2023 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689765588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3p0dVCyhrp9NlRfX+MDby+KmQBnRbC+np8nuy9UWz4=;
	b=YUMq49V0E2XR0Leu4vGXL/OGyhok7YK+BGOqTbH3QDw5/AYRfzwH5+fZH8qL5nWltXEL6z
	0q7xsrtFHrCOQgxsK3zhUa2d4PUG0/xEi+uQuzLvVm291yyPFV4qvehSZchbT9lj/7/VoX
	gw3ejzdCPh2Pbw7oMBBMXOx7Qstdt4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689765588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3p0dVCyhrp9NlRfX+MDby+KmQBnRbC+np8nuy9UWz4=;
	b=FsSIinEjJoz9VSVbdFEroG4xqPJCjF1ebhvKAZHRAQFg7PWvAGU+cr3qg5CNyPBntBQh81
	Ma+0TUtnQsDrUuAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 09B152C14E;
	Wed, 19 Jul 2023 11:19:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0209651C9EC7; Wed, 19 Jul 2023 13:19:48 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Boris Pismenny <boris.pismenny@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6/6] net/tls: implement ->read_sock()
Date: Wed, 19 Jul 2023 13:19:44 +0200
Message-Id: <20230719111944.68544-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719111944.68544-1-hare@suse.de>
References: <20230719111944.68544-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement ->read_sock() function for use with nvme-tcp.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: Boris Pismenny <boris.pismenny@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 net/tls/tls.h      |  2 +
 net/tls/tls_main.c |  2 +
 net/tls/tls_sw.c   | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 86cef1c68e03..7e4d45537deb 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -110,6 +110,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
 ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
 			   struct pipe_inode_info *pipe,
 			   size_t len, unsigned int flags);
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor);
 
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_device_splice_eof(struct socket *sock);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b6896126bb92..7dbb8cd8f809 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -962,10 +962,12 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 	ops[TLS_BASE][TLS_SW  ] = ops[TLS_BASE][TLS_BASE];
 	ops[TLS_BASE][TLS_SW  ].splice_read	= tls_sw_splice_read;
 	ops[TLS_BASE][TLS_SW  ].poll		= tls_sk_poll;
+	ops[TLS_BASE][TLS_SW  ].read_sock	= tls_sw_read_sock;
 
 	ops[TLS_SW  ][TLS_SW  ] = ops[TLS_SW  ][TLS_BASE];
 	ops[TLS_SW  ][TLS_SW  ].splice_read	= tls_sw_splice_read;
 	ops[TLS_SW  ][TLS_SW  ].poll		= tls_sk_poll;
+	ops[TLS_SW  ][TLS_SW  ].read_sock	= tls_sw_read_sock;
 
 #ifdef CONFIG_TLS_DEVICE
 	ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d0636ea13009..4829d2cb9a7c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2202,6 +2202,102 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	goto splice_read_end;
 }
 
+int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
+		     sk_read_actor_t read_actor)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
+	struct strp_msg *rxm = NULL;
+	struct tls_msg *tlm;
+	struct sk_buff *skb;
+	struct sk_psock *psock;
+	ssize_t copied = 0;
+	bool bpf_strp_enabled;
+	int err, used;
+
+	psock = sk_psock_get(sk);
+	err = tls_rx_reader_acquire(sk, ctx, true);
+	if (err < 0)
+		goto psock_put;
+	bpf_strp_enabled = sk_psock_strp_enabled(psock);
+
+	/* If crypto failed the connection is broken */
+	err = ctx->async_wait.err;
+	if (err)
+		goto read_sock_end;
+
+	do {
+		if (!skb_queue_empty(&ctx->rx_list)) {
+			skb = __skb_dequeue(&ctx->rx_list);
+			rxm = strp_msg(skb);
+		} else {
+			struct tls_decrypt_arg darg;
+
+			err = tls_rx_rec_wait(sk, psock, true, true);
+			if (err <= 0)
+				goto read_sock_end;
+
+			memset(&darg.inargs, 0, sizeof(darg.inargs));
+			darg.zc = !bpf_strp_enabled && ctx->zc_capable;
+
+			rxm = strp_msg(tls_strp_msg(ctx));
+			tlm = tls_msg(tls_strp_msg(ctx));
+
+			/* read_sock does not support reading control messages */
+			if (tlm->control != TLS_RECORD_TYPE_DATA) {
+				err = -EINVAL;
+				goto read_sock_requeue;
+			}
+
+			if (!bpf_strp_enabled)
+				darg.async = ctx->async_capable;
+			else
+				darg.async = false;
+
+			err = tls_rx_one_record(sk, NULL, &darg);
+			if (err < 0) {
+				tls_err_abort(sk, -EBADMSG);
+				goto read_sock_end;
+			}
+
+			sk_flush_backlog(sk);
+			skb = darg.skb;
+			rxm = strp_msg(skb);
+
+			tls_rx_rec_done(ctx);
+		}
+
+		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
+		if (used <= 0) {
+			if (!copied)
+				err = used;
+			goto read_sock_end;
+		}
+		copied += used;
+		if (used < rxm->full_len) {
+			rxm->offset += used;
+			rxm->full_len -= used;
+			if (!desc->count)
+				goto read_sock_requeue;
+		} else {
+			consume_skb(skb);
+			if (!desc->count)
+				skb = NULL;
+		}
+	} while (skb);
+
+read_sock_end:
+	tls_rx_reader_release(sk, ctx);
+psock_put:
+	if (psock)
+		sk_psock_put(sk, psock);
+	return copied ? : err;
+
+read_sock_requeue:
+	__skb_queue_head(&ctx->rx_list, skb);
+	goto read_sock_end;
+}
+
 bool tls_sw_sock_is_readable(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
-- 
2.35.3


