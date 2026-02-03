Return-Path: <netdev+bounces-256444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOFQMGdEgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:54:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E387DDE50
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3795730D32B5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D952D94A1;
	Tue,  3 Feb 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VVBgrYwy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8D299AB3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144582; cv=none; b=kj2KEMJ1m08mUnlW8cPEBPrPQIMmEy/OL5OAEiITCZb9eXiw5E8+IO9KKnc4wAOcAhSSfvpfSI7krkiI+4uS9QEqoy5oDU7aj3/xxYXZORjtKAYTg8upISZsJSjMAy3uCUCrBLg2wjdpy52fsCwjPoEPKq7MU8TSPtgYnlB2Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144582; c=relaxed/simple;
	bh=tp1RkR3c0N1Ez/FxJHOaGwImZpE+Rra90wtzVpWiNo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeiyGapquNX+6ek8l4qB/mUakyL46l7606UAfe2DRKIJLuWp+JzAygyYxn/eFnuBPfPgAlL2rFVNX3HV3wYA9MzTIm1FT7pOGw5mXopPfSC6wm8O7uYDv0kMw1mV4P6Pvwiv+6f3j5bLyj7qCKcKmhHTgz8UXqzrvR6jvNcBV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VVBgrYwy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so20676766b.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144578; x=1770749378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDQymu2Tf7x1qpFxIDzpmzRC35hPrSCx95yl4UkLtXI=;
        b=VVBgrYwyyL727CWDEUDJT8LyNqpNDinWoPMSoKFQ6IeGFujvlm9Txa9L3//3sLLYdJ
         4tvviZ3FFcllciDiUZZLxYRvoskSp0avSzZ9KdWCpKx1zP2B4cKEfCy1GbJ/gGYMVxat
         MeqkWrLphHHK+UFgzrYHMe3PXb1JfLgby9kMLAydEXC4LbnI4a0+/LugMcC04uO4YTWQ
         Ak74zLwyZc5UxY1Z/M0tterMvw6LqI6LNEC+7TCYv/10fojt94aF3sOCMNrwPpzB89VZ
         PvJFWWiv/NVrF9quk0WIT2znyOzB/xGl02NaquOOF7d5Jx3sbOHLfFkecPBYy/5ZKTdg
         6MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144578; x=1770749378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDQymu2Tf7x1qpFxIDzpmzRC35hPrSCx95yl4UkLtXI=;
        b=C585xW4MUKhlgBMKh9uCaNB88q/+quhgJQqdU43809MqHMpr8+PIzGF1H1V6VBIzgC
         2+Y5Tzn79Acah9gdB0K9VL/tUEI4pgBrgkm1O/G1tQUjzwpVmzFU0S6mXyt/2AQCfrTs
         rBUcIk00WWmFYwFdDHFGHHMrAbM/Uaq0KIRqUShcUWszrp0XV0uDu31gDTBhlEllv4T8
         u7lFizp/S0El0FqTyLNSzdsqK3a6xM3R3v3RSGnkuB5vhqkxA+aRyLlVsBN+bg3nuI1G
         Nv2zWd6bTo29XSI/HsbqMZ9/UYWBpV5s8VuC9/oTOD+cHHtY81nkhiYs0IscBbQm1r/Y
         1cZQ==
X-Gm-Message-State: AOJu0Yxoc+lYEcORD5Hac5xIIL+mo0tnxEl0tSRY4s3Dd06Sxnau496r
	FwhbanuAKoDGBHqamq70Cu/wmn0n63Nszr4OPEWP1JTRIkSrg0QFl3GjY1kYOuolVN9GRHfdEhf
	QUDtG2kxcqUtEa+AuK7CYuwMjBwj94SKeoEEsXWmhbAac9ZfLkKrCDtNxEISALgiOnI649by+V8
	piAx2iHlYEbvc7ZucPUfoS1wpxx5pUIjoXcxC+F+VlozXhJ8Q=
X-Gm-Gg: AZuq6aK1cOcxI9Z0LV2+H/6/5lyclLLNVjpJkLsbN1xtPSsqYvhkThYdRoORhU163b1
	2Wwf+IA2h9wNTqFrhArqc5E2ld/ywiE/D3sGJBdj+DD+TOXDseQfMNNvXH/lilx0G9obMydHDrp
	EaWNMvcZk1HT+m50qkcclKeLv7rE/FPR4W58/kErDokSQYGeuKkyxtTUDHFEMLRQyzieQwuFbww
	KdZgkQf8jJODUhDZX7eSsWrtQkzVqhc2MlC9lRShfWFFykZj/a+Z5MfwH4yW0/4N/udRQoViMa9
	NHvXC6196JG7pMAagSP52iIall6IlSVaskJy9Af2P7R85BkbXqW3VlmaFPji1qwAzmSj1yQM5cT
	F4BJ984wW8ne6KuuyQZ4mE6qyCRl3GA7DXAFC4v2OewGuInbhlWfMjefUiAPx0t5iBR0/aKu5V0
	0CtkPyb5p3aGDICTcY4BymplsL+hCboPC03Fge
X-Received: by 2002:a17:906:f5a0:b0:b8d:9bcc:9016 with SMTP id a640c23a62f3a-b8e9f2b8e82mr37502766b.37.1770144578124;
        Tue, 03 Feb 2026 10:49:38 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8ea004ff2bsm12107766b.63.2026.02.03.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:49:37 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v6 2/4] tls: add hardware offload key update support
Date: Tue,  3 Feb 2026 11:48:33 -0700
Message-Id: <20260203184835.3619101-3-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260203184835.3619101-1-rjethwani@purestorage.com>
References: <20260203184835.3619101-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256444-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: 2E387DDE50
X-Rspamd-Action: no action

Add TLS KeyUpdate (rekey) support for hardware offload connections,
enabling key rotation on established TLS 1.3 connections without
tearing down the hardware offload.

Key changes:

1. Rekey API: Extended tls_set_device_offload() and
   tls_set_device_offload_rx() with new_crypto_info parameter to
   distinguish initial setup from key updates. During rekey, the old
   HW context is deleted (tls_dev_del) and a new one is added
   (tls_dev_add) with the updated key material.

2. Graceful degradation: If hardware key update fails, the connection
   gracefully degrades to software. For TX, TLS_TX_DEV_CLOSED is set
   and sk_validate_xmit_skb switches to tls_validate_xmit_skb_sw for
   software encryption. For RX, TLS_RX_DEV_DEGRADED and TLS_RX_DEV_CLOSED
   are set for software decryption. tx_conf/rx_conf remains TLS_HW.

3. Record sequence management: During TX rekey, old pending records
   are deleted and unacked_record_sn is reset to the new rec_seq.

4. SW context refactoring: Split tls_set_sw_offload() into
   tls_sw_ctx_init() and tls_sw_ctx_finalize() to allow the HW offload
   RX path to initialize SW context first, attempt HW setup, then
   finalize (memzero new_crypto_info, call tls_finish_key_update).

5. Added TLS_TX_DEV_CLOSED flag to track TX hardware context state,
   to avoid double tls_dev_del call, symmetric with existing
   TLS_RX_DEV_CLOSED.

This removes the rekey rejection checks added in the previous patch,
replacing them with full rekey support including graceful degradation.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 key update cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |   4 +
 net/tls/tls.h        |  15 ++-
 net/tls/tls_device.c | 274 +++++++++++++++++++++++++++++++------------
 net/tls/tls_main.c   |  94 +++++++--------
 net/tls/tls_sw.c     |  77 ++++++++----
 5 files changed, 319 insertions(+), 145 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..9a203394763b 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -189,6 +189,10 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
+	/* Flag for TX HW context deleted during failed rekey.
+	 * Prevents double tls_dev_del in cleanup paths.
+	 */
+	TLS_TX_DEV_CLOSED = 3,
 };
 
 struct cipher_context {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 2f86baeb71fc..2b93ab13a429 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -147,6 +147,10 @@ void tls_strp_abort_strp(struct tls_strparser *strp, int err);
 int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_crypto_info *crypto_info,
 		   const struct tls_cipher_desc *cipher_desc);
+int tls_sw_ctx_init(struct sock *sk, int tx,
+		    struct tls_crypto_info *new_crypto_info);
+void tls_sw_ctx_finalize(struct sock *sk, int tx,
+			 struct tls_crypto_info *new_crypto_info);
 int tls_set_sw_offload(struct sock *sk, int tx,
 		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
@@ -229,9 +233,11 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
-int tls_set_device_offload(struct sock *sk);
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *crypto_info);
 void tls_device_offload_cleanup_rx(struct sock *sk);
 void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq);
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx);
@@ -240,7 +246,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
-tls_set_device_offload(struct sock *sk)
+tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
@@ -248,7 +254,8 @@ tls_set_device_offload(struct sock *sk)
 static inline void tls_device_free_resources_tx(struct sock *sk) {}
 
 static inline int
-tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			  struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 459963c254f4..4aaa51a35f1f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -79,7 +79,9 @@ static void tls_device_tx_del_task(struct work_struct *work)
 	netdev = rcu_dereference_protected(ctx->netdev,
 					   !refcount_read(&ctx->refcount));
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						 TLS_OFFLOAD_CTX_DIR_TX);
 	dev_put(netdev);
 	ctx->netdev = NULL;
 	tls_device_free_ctx(ctx);
@@ -1086,12 +1088,13 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
-int tls_set_device_offload(struct sock *sk)
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *new_crypto_info)
 {
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	struct tls_record_info *start_marker_record;
 	struct tls_offload_context_tx *offload_ctx;
 	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
@@ -1101,8 +1104,12 @@ int tls_set_device_offload(struct sock *sk)
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
 
-	if (ctx->priv_ctx_tx)
-		return -EEXIST;
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->tx_conf != TLS_HW)
+		return -EINVAL;
 
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
@@ -1116,57 +1123,62 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	if (crypto_info->version != TLS_1_2_VERSION &&
-	    crypto_info->version != TLS_1_3_VERSION) {
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	if (src_crypto_info->version != TLS_1_2_VERSION &&
+	    src_crypto_info->version != TLS_1_3_VERSION) {
 		rc = -EOPNOTSUPP;
 		goto release_netdev;
 	}
 
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
 	if (!cipher_desc || !cipher_desc->offloadable) {
 		rc = -EINVAL;
 		goto release_netdev;
 	}
 
-	rc = init_prot_info(prot, crypto_info, cipher_desc);
-	if (rc)
-		goto release_netdev;
+	iv = crypto_info_iv(src_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
-	iv = crypto_info_iv(crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+	if (!new_crypto_info) {
+		rc = init_prot_info(prot, src_crypto_info, cipher_desc);
+		if (rc)
+			goto release_netdev;
 
-	memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
-	memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
+		memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
+		memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
 
-	start_marker_record = kmalloc(sizeof(*start_marker_record), GFP_KERNEL);
-	if (!start_marker_record) {
-		rc = -ENOMEM;
-		goto release_netdev;
-	}
+		start_marker_record = kmalloc(sizeof(*start_marker_record),
+					      GFP_KERNEL);
+		if (!start_marker_record) {
+			rc = -ENOMEM;
+			goto release_netdev;
+		}
 
-	offload_ctx = alloc_offload_ctx_tx(ctx);
-	if (!offload_ctx) {
-		rc = -ENOMEM;
-		goto free_marker_record;
-	}
+		offload_ctx = alloc_offload_ctx_tx(ctx);
+		if (!offload_ctx) {
+			rc = -ENOMEM;
+			goto free_marker_record;
+		}
 
-	rc = tls_sw_fallback_init(sk, offload_ctx, crypto_info);
-	if (rc)
-		goto free_offload_ctx;
+		rc = tls_sw_fallback_init(sk, offload_ctx, src_crypto_info);
+		if (rc)
+			goto free_offload_ctx;
 
-	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
-	start_marker_record->len = 0;
-	start_marker_record->num_frags = 0;
-	list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
+		start_marker_record->end_seq = tcp_sk(sk)->write_seq;
+		start_marker_record->len = 0;
+		start_marker_record->num_frags = 0;
+		list_add_tail(&start_marker_record->list,
+			      &offload_ctx->records_list);
 
-	clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
-	ctx->push_pending_record = tls_device_push_pending_record;
+		clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
+		ctx->push_pending_record = tls_device_push_pending_record;
 
-	/* TLS offload is greatly simplified if we don't send
-	 * SKBs where only part of the payload needs to be encrypted.
-	 * So mark the last skb in the write queue as end of record.
-	 */
-	tcp_write_collapse_fence(sk);
+		/* TLS offload is greatly simplified if we don't send
+		 * SKBs where only part of the payload needs to be encrypted.
+		 * So mark the last skb in the write queue as end of record.
+		 */
+		tcp_write_collapse_fence(sk);
+	}
 
 	/* Avoid offloading if the device is down
 	 * We don't want to offload new flows after
@@ -1182,29 +1194,91 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_lock;
 	}
 
-	ctx->priv_ctx_tx = offload_ctx;
+	if (!new_crypto_info) {
+		ctx->priv_ctx_tx = offload_ctx;
+	} else {
+		char *key = crypto_info_key(src_crypto_info, cipher_desc);
+
+		offload_ctx = tls_offload_ctx_tx(ctx);
+
+		rc = crypto_aead_setkey(offload_ctx->aead_send, key,
+					cipher_desc->key);
+		if (rc)
+			goto release_lock;
+
+		/* For rekey, delete old HW context before adding new one. */
+		if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags))
+			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+							TLS_OFFLOAD_CTX_DIR_TX);
+	}
+
 	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
-					     &ctx->crypto_send.info,
+					     src_crypto_info,
 					     tcp_sk(sk)->write_seq);
 	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
 				     tcp_sk(sk)->write_seq, rec_seq, rc);
-	if (rc)
-		goto release_lock;
 
-	tls_device_attach(ctx, sk, netdev);
+	if (new_crypto_info) {
+		unsigned long flags;
+		__be64 rcd_sn;
+
+		memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
+		memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
+
+		spin_lock_irqsave(&offload_ctx->lock, flags);
+		/* Delete old records, can't be retransmitted with new key */
+		delete_all_records(offload_ctx);
+
+		/* Update unacked_record_sn for the new key's rec_seq.
+		 * This is critical for SW fallback encryption to use
+		 * the correct record sequence number after rekey.
+		 */
+		memcpy(&rcd_sn, rec_seq, sizeof(rcd_sn));
+		offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn);
+		spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+		unsafe_memcpy(crypto_info, new_crypto_info,
+			      cipher_desc->crypto_info,
+			      /* size was checked in do_tls_setsockopt_conf */);
+		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+	}
+
+	if (rc) {
+		if (new_crypto_info) {
+			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+			/* HW rekey failed, gracefully degrade to SW encryption.
+			 * SW fallback already has new key, IV, and rec_seq.
+			 * Old HW ctx was deleted, continue with SW encryption.
+			 */
+			smp_store_release(&sk->sk_validate_xmit_skb,
+					  tls_validate_xmit_skb_sw);
+		} else {
+			goto release_lock;
+		}
+	} else {
+		if (new_crypto_info)
+			clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+
+		tls_device_attach(ctx, sk, netdev);
+
+		/* following this assignment tls_is_skb_tx_device_offloaded
+		 * will return true and the context might be accessed
+		 * by the netdev's xmit function.
+		 */
+		smp_store_release(&sk->sk_validate_xmit_skb,
+				  tls_validate_xmit_skb);
+	}
+
 	up_read(&device_offload_lock);
 
-	/* following this assignment tls_is_skb_tx_device_offloaded
-	 * will return true and the context might be accessed
-	 * by the netdev's xmit function.
-	 */
-	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
 	dev_put(netdev);
 
 	return 0;
 
 release_lock:
 	up_read(&device_offload_lock);
+	if (new_crypto_info)
+		goto release_netdev;
 	clean_acked_data_disable(tcp_sk(sk));
 	crypto_free_aead(offload_ctx->aead_send);
 free_offload_ctx:
@@ -1217,17 +1291,33 @@ int tls_set_device_offload(struct sock *sk)
 	return rc;
 }
 
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *new_crypto_info)
 {
-	struct tls12_crypto_info_aes_gcm_128 *info;
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
 	struct tls_offload_context_rx *context;
 	struct net_device *netdev;
+	char *rec_seq;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION &&
-	    ctx->crypto_recv.info.version != TLS_1_3_VERSION)
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->rx_conf != TLS_HW)
+		return -EINVAL;
+
+	crypto_info = &ctx->crypto_recv.info;
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	if (src_crypto_info->version != TLS_1_2_VERSION &&
+	    src_crypto_info->version != TLS_1_3_VERSION)
 		return -EOPNOTSUPP;
 
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable)
+		return -EINVAL;
+
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
@@ -1253,28 +1343,57 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto release_lock;
 	}
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
-	if (!context) {
-		rc = -ENOMEM;
-		goto release_lock;
+	if (!new_crypto_info) {
+		context = kzalloc(sizeof(*context), GFP_KERNEL);
+		if (!context) {
+			rc = -ENOMEM;
+			goto release_lock;
+		}
+		context->resync_nh_reset = 1;
+		ctx->priv_ctx_rx = context;
 	}
-	context->resync_nh_reset = 1;
 
-	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
 	if (rc)
 		goto release_ctx;
 
+	/* For rekey, delete old HW context before adding new one. */
+	if (new_crypto_info && !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
+
 	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_RX,
-					     &ctx->crypto_recv.info,
+					     src_crypto_info,
 					     tcp_sk(sk)->copied_seq);
-	info = (void *)&ctx->crypto_recv.info;
+	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
-				     tcp_sk(sk)->copied_seq, info->rec_seq, rc);
-	if (rc)
-		goto free_sw_resources;
+				     tcp_sk(sk)->copied_seq, rec_seq, rc);
+	if (rc) {
+		if (new_crypto_info) {
+			/* HW rekey failed, gracefully degrade to SW decryption.
+			 * SW context already set up via tls_sw_ctx_init.
+			 * Old HW ctx was deleted, set degraded flag for
+			 * SW fallback.
+			 */
+			set_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		} else {
+			goto free_sw_resources;
+		}
+	} else {
+		if (new_crypto_info) {
+			/* HW rekey succeeded, clear degraded state
+			 * if previously set
+			 */
+			clear_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
+			clear_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
+
+		tls_device_attach(ctx, sk, netdev);
+	}
+
+	tls_sw_ctx_finalize(sk, 0, new_crypto_info);
 
-	tls_device_attach(ctx, sk, netdev);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1283,10 +1402,15 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 
 free_sw_resources:
 	up_read(&device_offload_lock);
-	tls_sw_free_resources_rx(sk);
+	if (new_crypto_info)
+		goto release_netdev;
+	tls_sw_release_resources_rx(sk);
 	down_read(&device_offload_lock);
 release_ctx:
-	ctx->priv_ctx_rx = NULL;
+	if (!new_crypto_info) {
+		kfree(ctx->priv_ctx_rx);
+		ctx->priv_ctx_rx = NULL;
+	}
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
@@ -1305,8 +1429,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1363,13 +1488,18 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (ctx->tx_conf == TLS_HW &&
+		    !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
+			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+		}
 		if (ctx->rx_conf == TLS_HW &&
-		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_RX);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
 
 		dev_put(netdev);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f7c369714b85..f7fe6676cc4c 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -711,68 +711,68 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	}
 
 	if (tx) {
-		/* HW rekey not yet supported */
-		if (update && ctx->tx_conf == TLS_HW) {
-			rc = -EOPNOTSUPP;
-			goto err_crypto_info;
-		}
-
-		/* Only try HW offload on initial setup, not rekey */
-		if (!update) {
-			rc = tls_set_device_offload(sk);
-			conf = TLS_HW;
-			if (!rc) {
+		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
+		conf = TLS_HW;
+		if (!rc) {
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+			} else {
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
-				goto out;
 			}
-		}
-
-		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
-		if (rc)
+		} else if (update && ctx->tx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;
-
-		if (update) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
 		} else {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			rc = tls_set_sw_offload(sk, 1,
+						update ? crypto_info : NULL);
+			if (rc)
+				goto err_crypto_info;
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			}
+			conf = TLS_SW;
 		}
-		conf = TLS_SW;
 	} else {
-		/* HW rekey not yet supported */
-		if (update && ctx->rx_conf == TLS_HW) {
-			rc = -EOPNOTSUPP;
-			goto err_crypto_info;
-		}
-
-		/* Only try HW offload on initial setup, not rekey */
-		if (!update) {
-			rc = tls_set_device_offload_rx(sk, ctx);
-			conf = TLS_HW;
-			if (!rc) {
+		rc = tls_set_device_offload_rx(sk, ctx,
+					       update ? crypto_info : NULL);
+		conf = TLS_HW;
+		if (!rc) {
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			} else {
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
-				tls_sw_strparser_arm(sk, ctx);
-				goto out;
 			}
-		}
-
-		rc = tls_set_sw_offload(sk, 0, update ? crypto_info : NULL);
-		if (rc)
+		} else if (update && ctx->rx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;
-
-		if (update) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
 		} else {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
-			tls_sw_strparser_arm(sk, ctx);
+			rc = tls_set_sw_offload(sk, 0,
+						update ? crypto_info : NULL);
+			if (rc)
+				goto err_crypto_info;
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			}
+			conf = TLS_SW;
 		}
-		conf = TLS_SW;
+		if (!update)
+			tls_sw_strparser_arm(sk, ctx);
 	}
 
-out:
 	if (tx)
 		ctx->tx_conf = conf;
 	else
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..2fcc0178490d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2775,20 +2775,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
 	ctx->saved_data_ready(sk);
 }
 
-int tls_set_sw_offload(struct sock *sk, int tx,
-		       struct tls_crypto_info *new_crypto_info)
+int tls_sw_ctx_init(struct sock *sk, int tx,
+		    struct tls_crypto_info *new_crypto_info)
 {
 	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	struct tls_sw_context_tx *sw_ctx_tx = NULL;
 	struct tls_sw_context_rx *sw_ctx_rx = NULL;
 	const struct tls_cipher_desc *cipher_desc;
-	char *iv, *rec_seq, *key, *salt;
-	struct cipher_context *cctx;
 	struct tls_prot_info *prot;
 	struct crypto_aead **aead;
 	struct tls_context *ctx;
 	struct crypto_tfm *tfm;
 	int rc = 0;
+	char *key;
 
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
@@ -2809,12 +2808,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (tx) {
 		sw_ctx_tx = ctx->priv_ctx_tx;
 		crypto_info = &ctx->crypto_send.info;
-		cctx = &ctx->tx;
 		aead = &sw_ctx_tx->aead_send;
 	} else {
 		sw_ctx_rx = ctx->priv_ctx_rx;
 		crypto_info = &ctx->crypto_recv.info;
-		cctx = &ctx->rx;
 		aead = &sw_ctx_rx->aead_recv;
 	}
 
@@ -2830,10 +2827,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2877,19 +2871,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	memcpy(cctx->iv, salt, cipher_desc->salt);
-	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
-	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
-
-	if (new_crypto_info) {
-		unsafe_memcpy(crypto_info, new_crypto_info,
-			      cipher_desc->crypto_info,
-			      /* size was checked in do_tls_setsockopt_conf */);
-		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
-		if (!tx)
-			tls_finish_key_update(sk, ctx);
-	}
-
 	goto out;
 
 free_aead:
@@ -2908,3 +2889,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 out:
 	return rc;
 }
+
+void tls_sw_ctx_finalize(struct sock *sk, int tx,
+			 struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct cipher_context *cctx;
+	char *iv, *salt, *rec_seq;
+
+	if (tx) {
+		crypto_info = &ctx->crypto_send.info;
+		cctx = &ctx->tx;
+	} else {
+		crypto_info = &ctx->crypto_recv.info;
+		cctx = &ctx->rx;
+	}
+
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+
+	iv = crypto_info_iv(src_crypto_info, cipher_desc);
+	salt = crypto_info_salt(src_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
+
+	memcpy(cctx->iv, salt, cipher_desc->salt);
+	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
+	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
+
+	if (new_crypto_info) {
+		unsafe_memcpy(crypto_info, new_crypto_info,
+			      cipher_desc->crypto_info,
+			      /* size was checked in do_tls_setsockopt_conf */);
+		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+
+		if (!tx)
+			tls_finish_key_update(sk, ctx);
+	}
+}
+
+int tls_set_sw_offload(struct sock *sk, int tx,
+		       struct tls_crypto_info *new_crypto_info)
+{
+	int rc;
+
+	rc = tls_sw_ctx_init(sk, tx, new_crypto_info);
+	if (rc)
+		return rc;
+
+	tls_sw_ctx_finalize(sk, tx, new_crypto_info);
+	return 0;
+}
-- 
2.25.1


