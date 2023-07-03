Return-Path: <netdev+bounces-15072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB25745808
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CAF280CD2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA954419;
	Mon,  3 Jul 2023 09:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0C3FFF
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:04:59 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE427E4E
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 02:04:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3815F218F3;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slKVuHlQLLm38POGRVwlSA+SLJNSLb1/O0U9okq5QUI=;
	b=iIebFiyY8zMHzVB1lH8kChThPmkNJAQAHzrxp5z6nEqtjUrbjAWh7uWFy+UBT3Q/At20x7
	FMNsDv6g7ZgFr3X8hiG/+CV+whE0/TCIiuEKJboxRaW0a17CtYj5SwV7e5WJl7K4Nq0Fhr
	Ay3U1oT3NC7nuRD2yPgfnMUAcBsb5xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slKVuHlQLLm38POGRVwlSA+SLJNSLb1/O0U9okq5QUI=;
	b=segoq3mbJzHCBi0CTp0Rs7BDzKfz9ooY/xx/IoYvVSaU6j33UhiitLss7l0dSYM4ZczW4s
	4aObjEu3csJILDBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 088022C146;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id EEB3951C5D8D; Mon,  3 Jul 2023 11:04:55 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Date: Mon,  3 Jul 2023 11:04:43 +0200
Message-Id: <20230703090444.38734-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230703090444.38734-1-hare@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
the actual locking part.
With that we can use the tls_rx_reader_lock in situations where
the socket is already locked.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
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


