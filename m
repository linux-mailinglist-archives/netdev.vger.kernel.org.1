Return-Path: <netdev+bounces-69661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E584C1C9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD8CB22AAA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B45C83;
	Wed,  7 Feb 2024 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmVC/FUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A610C8F62
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268745; cv=none; b=EycxZ877sGk8TfHRmrICyH0DDHZy0XeolOav2u0DI6OPaKDJcUFNpBtvZSF8EYMoPNMrvMA7rOk74psuoMULPrvZp2eCYPMSdv4bxO+o+dH4FUX07tN9Ja7HkbkE/JNagaVgWFV+tIf/vvFmEin7FFXpVPmZhQ8alJF8M4O/HbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268745; c=relaxed/simple;
	bh=0VTun5VltIPfeVGBTg1OI8hQN+H7G3s/UXi5rBhehdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfERiAeeEKtV5zuHSYgFLLZc29VNCvefEjmd7yYc+woBUUNg992BpBgHnWiQ/8VTeHY5vzv7TVsr7w9Ks27zKTXgOHwqUAHWDrBoX+iVy/6tzC4Ls86Tg0W6gss1/DHhSIiNhP9hFiGKIaLI0NLsH58SPUARY/hh70oSmgcgZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmVC/FUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55E7C433F1;
	Wed,  7 Feb 2024 01:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268745;
	bh=0VTun5VltIPfeVGBTg1OI8hQN+H7G3s/UXi5rBhehdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmVC/FUoZ5bvKSqXIQOICB8BPUbMp1p4AOwogB6wytkdF/h9o1ZXLBcF9Z2Fdzn1I
	 p+AUwZlQNTnqKlbZm51yU9hryV9R/UGHJqFtyX7dzluet3lm/mjNf2tmrz25vlCUc/
	 cNMcYCv6u5eWJ1F1b4ciazw92S7hp1rXRU42aZh9xAiec3R2XhQEPXTMQ4ljd16FlN
	 01uSnZu9OdW7g9tX2Oq2T4q4U82obIdaPq8/62tnTUv8ZCr4CJ8JF5+eGDhZBtISlg
	 Ej1k77kSNcPT4NCelQPFALQEleuofUPxDO54oQ4TAiotuBugaN4ktafqf5l5KZsi3t
	 1aT7lQMVArRoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: [PATCH net 1/7] net: tls: factor out tls_*crypt_async_wait()
Date: Tue,  6 Feb 2024 17:18:18 -0800
Message-ID: <20240207011824.2609030-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out waiting for async encrypt and decrypt to finish.
There are already multiple copies and a subsequent fix will
need more. No functional changes.

Note that crypto_wait_req() returns wait->err

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
---
 net/tls/tls_sw.c | 96 +++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 31e8a94dfc11..6a73714f34cc 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -230,6 +230,20 @@ static void tls_decrypt_done(void *data, int err)
 	spin_unlock_bh(&ctx->decrypt_compl_lock);
 }
 
+static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
+{
+	int pending;
+
+	spin_lock_bh(&ctx->decrypt_compl_lock);
+	reinit_completion(&ctx->async_wait.completion);
+	pending = atomic_read(&ctx->decrypt_pending);
+	spin_unlock_bh(&ctx->decrypt_compl_lock);
+	if (pending)
+		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+
+	return ctx->async_wait.err;
+}
+
 static int tls_do_decryption(struct sock *sk,
 			     struct scatterlist *sgin,
 			     struct scatterlist *sgout,
@@ -495,6 +509,28 @@ static void tls_encrypt_done(void *data, int err)
 		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
+static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
+{
+	int pending;
+
+	spin_lock_bh(&ctx->encrypt_compl_lock);
+	ctx->async_notify = true;
+
+	pending = atomic_read(&ctx->encrypt_pending);
+	spin_unlock_bh(&ctx->encrypt_compl_lock);
+	if (pending)
+		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	else
+		reinit_completion(&ctx->async_wait.completion);
+
+	/* There can be no concurrent accesses, since we have no
+	 * pending encrypt operations
+	 */
+	WRITE_ONCE(ctx->async_notify, false);
+
+	return ctx->async_wait.err;
+}
+
 static int tls_do_encryption(struct sock *sk,
 			     struct tls_context *tls_ctx,
 			     struct tls_sw_context_tx *ctx,
@@ -984,7 +1020,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	int num_zc = 0;
 	int orig_size;
 	int ret = 0;
-	int pending;
 
 	if (!eor && (msg->msg_flags & MSG_EOR))
 		return -EINVAL;
@@ -1163,24 +1198,12 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!num_async) {
 		goto send_end;
 	} else if (num_zc) {
+		int err;
+
 		/* Wait for pending encryptions to get completed */
-		spin_lock_bh(&ctx->encrypt_compl_lock);
-		ctx->async_notify = true;
-
-		pending = atomic_read(&ctx->encrypt_pending);
-		spin_unlock_bh(&ctx->encrypt_compl_lock);
-		if (pending)
-			crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-		else
-			reinit_completion(&ctx->async_wait.completion);
-
-		/* There can be no concurrent accesses, since we have no
-		 * pending encrypt operations
-		 */
-		WRITE_ONCE(ctx->async_notify, false);
-
-		if (ctx->async_wait.err) {
-			ret = ctx->async_wait.err;
+		err = tls_encrypt_async_wait(ctx);
+		if (err) {
+			ret = err;
 			copied = 0;
 		}
 	}
@@ -1229,7 +1252,6 @@ void tls_sw_splice_eof(struct socket *sock)
 	ssize_t copied = 0;
 	bool retrying = false;
 	int ret = 0;
-	int pending;
 
 	if (!ctx->open_rec)
 		return;
@@ -1264,22 +1286,7 @@ void tls_sw_splice_eof(struct socket *sock)
 	}
 
 	/* Wait for pending encryptions to get completed */
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-	if (pending)
-		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-	else
-		reinit_completion(&ctx->async_wait.completion);
-
-	/* There can be no concurrent accesses, since we have no pending
-	 * encrypt operations
-	 */
-	WRITE_ONCE(ctx->async_notify, false);
-
-	if (ctx->async_wait.err)
+	if (tls_encrypt_async_wait(ctx))
 		goto unlock;
 
 	/* Transmit if any encryptions have completed */
@@ -2109,16 +2116,10 @@ int tls_sw_recvmsg(struct sock *sk,
 
 recv_end:
 	if (async) {
-		int ret, pending;
+		int ret;
 
 		/* Wait for all previously submitted records to be decrypted */
-		spin_lock_bh(&ctx->decrypt_compl_lock);
-		reinit_completion(&ctx->async_wait.completion);
-		pending = atomic_read(&ctx->decrypt_pending);
-		spin_unlock_bh(&ctx->decrypt_compl_lock);
-		ret = 0;
-		if (pending)
-			ret = crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+		ret = tls_decrypt_async_wait(ctx);
 		__skb_queue_purge(&ctx->async_hold);
 
 		if (ret) {
@@ -2435,16 +2436,9 @@ void tls_sw_release_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
 	struct tls_rec *rec, *tmp;
-	int pending;
 
 	/* Wait for any pending async encryptions to complete */
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-
-	if (pending)
-		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	tls_encrypt_async_wait(ctx);
 
 	tls_tx_records(sk, -1);
 
-- 
2.43.0


