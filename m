Return-Path: <netdev+bounces-69662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947484C1CA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E231C23945
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC33D267;
	Wed,  7 Feb 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuj+DnaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD43C157
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268746; cv=none; b=mfuAihMC8YtJ33ourUsXq+5WNXNmV6XZ+WfrTm9iZ+FIGC+dNDPBsO6Sidxax8GmsU1x0A0pNgIOWj3Do3JzOkWfSg/uSZOg+tfnUIaa7szrpHwSIst2RC2nvc+ovdloZJeJSJc4NjA3JCVic+bgUysR8i+TA7/HEapju0cBnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268746; c=relaxed/simple;
	bh=JPUDzo8igKrxNhC4kU7JFFyAUdL8xcA3JampbCc2ZOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5OUE+BZ/I+Czwub+pxvmoBqQJNsxSVx+HO4D7EEUVUFamMx3LghKQvk3A1xLC/8/TS7aD3ooEum8Iq025w3YGskW/gZrQzvgdK1LJuAT2dKcPktUYTqgT5s//SLNwDnePx+fTowtkfwsWdU+lhZWPpYmLNEnse56Slsn3JHHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuj+DnaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418EAC43399;
	Wed,  7 Feb 2024 01:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268745;
	bh=JPUDzo8igKrxNhC4kU7JFFyAUdL8xcA3JampbCc2ZOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuj+DnaTiWk7F/REPWytQSLUKV/ygLKzqikEHTCwwBw/WQnmWMYQwoPCFmt7wuUmy
	 V+wUrL/Iq1rBbU/P/0NPXOIiqbGmw/QJpEgk2I5M8NmwVS0cbE9vI+9ZmCpmQsTbNw
	 fx3AjgmrR/QlKmSJKiN7dX515ZMkm4Sx5h3sBXJ/UrK/Z1di0FZKCjtVV9rbpn4Pkk
	 nuNc7BWyl2ziyrcELSBwzTmt3oRSH+Dbi018N+xsdfC3akZ0smJ11wJOt2S2k+5OAh
	 89JUUEPa06xlgFdgy588JzYluPT0rXvQ1gS61VOIwDkYm2Ys0B2UAx4s9YqQBAQMXj
	 SiAEfGvKvoDCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	vinay.yadav@chelsio.com
Subject: [PATCH net 2/7] tls: fix race between async notify and socket close
Date: Tue,  6 Feb 2024 17:18:19 -0800
Message-ID: <20240207011824.2609030-3-kuba@kernel.org>
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

The submitting thread (one which called recvmsg/sendmsg)
may exit as soon as the async crypto handler calls complete()
so any code past that point risks touching already freed data.

Try to avoid the locking and extra flags altogether.
Have the main thread hold an extra reference, this way
we can depend solely on the atomic ref counter for
synchronization.

Don't futz with reiniting the completion, either, we are now
tightly controlling when completion fires.

Reported-by: valis <sec@valis.email>
Fixes: 0cada33241d9 ("net/tls: fix race condition causing kernel panic")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
CC: vinay.yadav@chelsio.com
---
 include/net/tls.h |  5 -----
 net/tls/tls_sw.c  | 43 ++++++++++---------------------------------
 2 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 962f0c501111..340ad43971e4 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -97,9 +97,6 @@ struct tls_sw_context_tx {
 	struct tls_rec *open_rec;
 	struct list_head tx_list;
 	atomic_t encrypt_pending;
-	/* protect crypto_wait with encrypt_pending */
-	spinlock_t encrypt_compl_lock;
-	int async_notify;
 	u8 async_capable:1;
 
 #define BIT_TX_SCHEDULED	0
@@ -136,8 +133,6 @@ struct tls_sw_context_rx {
 	struct tls_strparser strp;
 
 	atomic_t decrypt_pending;
-	/* protect crypto_wait with decrypt_pending*/
-	spinlock_t decrypt_compl_lock;
 	struct sk_buff_head async_hold;
 	struct wait_queue_head wq;
 };
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 6a73714f34cc..635305bebfef 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -224,22 +224,15 @@ static void tls_decrypt_done(void *data, int err)
 
 	kfree(aead_req);
 
-	spin_lock_bh(&ctx->decrypt_compl_lock);
-	if (!atomic_dec_return(&ctx->decrypt_pending))
+	if (atomic_dec_and_test(&ctx->decrypt_pending))
 		complete(&ctx->async_wait.completion);
-	spin_unlock_bh(&ctx->decrypt_compl_lock);
 }
 
 static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
 {
-	int pending;
-
-	spin_lock_bh(&ctx->decrypt_compl_lock);
-	reinit_completion(&ctx->async_wait.completion);
-	pending = atomic_read(&ctx->decrypt_pending);
-	spin_unlock_bh(&ctx->decrypt_compl_lock);
-	if (pending)
+	if (!atomic_dec_and_test(&ctx->decrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	atomic_inc(&ctx->decrypt_pending);
 
 	return ctx->async_wait.err;
 }
@@ -267,6 +260,7 @@ static int tls_do_decryption(struct sock *sk,
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
 					  tls_decrypt_done, aead_req);
+		DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
 		aead_request_set_callback(aead_req,
@@ -455,7 +449,6 @@ static void tls_encrypt_done(void *data, int err)
 	struct sk_msg *msg_en;
 	bool ready = false;
 	struct sock *sk;
-	int pending;
 
 	msg_en = &rec->msg_encrypted;
 
@@ -494,12 +487,8 @@ static void tls_encrypt_done(void *data, int err)
 			ready = true;
 	}
 
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	pending = atomic_dec_return(&ctx->encrypt_pending);
-
-	if (!pending && ctx->async_notify)
+	if (atomic_dec_and_test(&ctx->encrypt_pending))
 		complete(&ctx->async_wait.completion);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
 
 	if (!ready)
 		return;
@@ -511,22 +500,9 @@ static void tls_encrypt_done(void *data, int err)
 
 static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
 {
-	int pending;
-
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-	if (pending)
+	if (!atomic_dec_and_test(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-	else
-		reinit_completion(&ctx->async_wait.completion);
-
-	/* There can be no concurrent accesses, since we have no
-	 * pending encrypt operations
-	 */
-	WRITE_ONCE(ctx->async_notify, false);
+	atomic_inc(&ctx->encrypt_pending);
 
 	return ctx->async_wait.err;
 }
@@ -577,6 +553,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	/* Add the record in tx_list */
 	list_add_tail((struct list_head *)&rec->list, &ctx->tx_list);
+	DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->encrypt_pending) < 1);
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
@@ -2601,7 +2578,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
 	}
 
 	crypto_init_wait(&sw_ctx_tx->async_wait);
-	spin_lock_init(&sw_ctx_tx->encrypt_compl_lock);
+	atomic_set(&sw_ctx_tx->encrypt_pending, 1);
 	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
 	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
 	sw_ctx_tx->tx_work.sk = sk;
@@ -2622,7 +2599,7 @@ static struct tls_sw_context_rx *init_ctx_rx(struct tls_context *ctx)
 	}
 
 	crypto_init_wait(&sw_ctx_rx->async_wait);
-	spin_lock_init(&sw_ctx_rx->decrypt_compl_lock);
+	atomic_set(&sw_ctx_rx->decrypt_pending, 1);
 	init_waitqueue_head(&sw_ctx_rx->wq);
 	skb_queue_head_init(&sw_ctx_rx->rx_list);
 	skb_queue_head_init(&sw_ctx_rx->async_hold);
-- 
2.43.0


