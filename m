Return-Path: <netdev+bounces-21588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15C763F56
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E75B1C2113C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EDE4CE9C;
	Wed, 26 Jul 2023 19:16:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FA4CE98
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:16:11 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DC272A
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:16:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2E02A1F74D;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtKJcMxJHzVUfqNXX7H4Vu0VeOgdBGxSYotX+F6gOZs=;
	b=uefzrxj7Ustnb7MuEifcPMm0pFtT0DbIhHGkoFCaU2i6beJKBuZ06w6biow1et7SNLCCvA
	JlgQNl5Kop4hIU65NIWSyM2AvVLYd4qvO3Jz7xpSuJO1GCLe7Udc2Yhtw4BQ7vtHAVANib
	2iq9DtpOvor6iNLNF13FglAbgrh7mQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtKJcMxJHzVUfqNXX7H4Vu0VeOgdBGxSYotX+F6gOZs=;
	b=b+2Pp7Ljcw2QAox/NYs5XkJRg3qhYdVv/4nDCFz18MQpdj4XlFZ86u6vK4+2q8+zXhf+gN
	tzv949DONRfY0DBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 17BD82C14B;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 35F3A51CA337; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
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
Subject: [PATCH 5/6] net/tls: split tls_rx_reader_lock
Date: Wed, 26 Jul 2023 21:15:55 +0200
Message-Id: <20230726191556.41714-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
References: <20230726191556.41714-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
the actual locking part.
With that we can use the tls_rx_reader_lock in situations where
the socket is already locked.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9aef45e870a5..d0636ea13009 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1848,13 +1848,10 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 	return sk_flush_backlog(sk);
 }
 
-static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
-			      bool nonblock)
+static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
+				 bool nonblock)
 {
 	long timeo;
-	int err;
-
-	lock_sock(sk);
 
 	timeo = sock_rcvtimeo(sk, nonblock);
 
@@ -1868,26 +1865,30 @@ static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
 			      !READ_ONCE(ctx->reader_present), &wait);
 		remove_wait_queue(&ctx->wq, &wait);
 
-		if (timeo <= 0) {
-			err = -EAGAIN;
-			goto err_unlock;
-		}
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			goto err_unlock;
-		}
+		if (timeo <= 0)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return sock_intr_errno(timeo);
 	}
 
 	WRITE_ONCE(ctx->reader_present, 1);
 
 	return 0;
+}
 
-err_unlock:
-	release_sock(sk);
+static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
+			      bool nonblock)
+{
+	int err;
+
+	lock_sock(sk);
+	err = tls_rx_reader_acquire(sk, ctx, nonblock);
+	if (err)
+		release_sock(sk);
 	return err;
 }
 
-static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
+static void tls_rx_reader_release(struct sock *sk, struct tls_sw_context_rx *ctx)
 {
 	if (unlikely(ctx->reader_contended)) {
 		if (wq_has_sleeper(&ctx->wq))
@@ -1899,6 +1900,11 @@ static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
 	}
 
 	WRITE_ONCE(ctx->reader_present, 0);
+}
+
+static void tls_rx_reader_unlock(struct sock *sk, struct tls_sw_context_rx *ctx)
+{
+	tls_rx_reader_release(sk, ctx);
 	release_sock(sk);
 }
 
-- 
2.35.3


