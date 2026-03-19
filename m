Return-Path: <netdev+bounces-269670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCoGBIpsvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:37:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2B2D2BCC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1C10300D4EA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010C73F165D;
	Thu, 19 Mar 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vlm6x1EB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3D36F431
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956228; cv=none; b=Q/1sn6Fki+VuMD+YxzdOrivRGLI0JmTgHuHjCublRoeDvlmkejQRD5gy/Jgj2t5xazAQRPzOmGy32ZUrD7amPR3BZfpcVbftDLKV91lCf212rzZT8hW4qJ3KvahqRCcrGqd/bLBiEqiCVUO3VXgKxiayO9qbyFr96QbKVR/N/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956228; c=relaxed/simple;
	bh=9M25cTOcyQyC+4jnrTlVutywLZC47r+SWpGo5/huTpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBsVYygqwJZyakLbzdXCK9h4JlySwWu9LhZtGT5MyIEHz4mjlfjeKMieKKx5Oss+dtl8FpvorvpocPv4YPedDGmn3whlwgBHrAp3cc1SXp7QoR2dljsf/NO/Yt7ZZVBbv3XvTXf/zkx/8keacQ+EJhtPc/7x0BBtSyoYw/Hw0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vlm6x1EB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b4915161fso1266256f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773956226; x=1774561026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsZvhRGVNb7BeilUnwzOYRj9+WW63E8xpY1fOzh5J1k=;
        b=Vlm6x1EBHJ6+EuAnuKB6bH0YAppuIl01IunlM10gaLYSrCgzvDhbG8l0fB5H9mypr8
         3oQLSnjZ6yCRQbBLj4y/Gp2Sof6cVoMOvP9l2LvnDHmHJAY2ltOfQkzUcQL5aw+aLfkC
         zld0pNX5OWh+sXMAt9dAZqpLB8kwIvW0je8OQqX2XmOuzMLoJ+G9pbJ+lRZj2IOMSt2l
         ju0SIf4zhxnvdT35he3b2ZJPShnmEFb/z3xgebaOjKqYGz3R04lqxImT1kD3ryT7J65B
         Y8EEuj1JSnsMGp9+lw+McDnAGWzILd3I1mP0IxNIvB0YvaAwBCi25zoKpSKOBhMxf455
         ORbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956226; x=1774561026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AsZvhRGVNb7BeilUnwzOYRj9+WW63E8xpY1fOzh5J1k=;
        b=Dw1i1NIbyzmCTVwNPyNedmj52vIiaHvhTGddbi9EJbp8kygYrNmPTaIW/shLZHX49/
         oe0wHx4I6g7sXTpQ86bfkF3GlIAE7/zULAdwJLZhxUUyqdje8csMgY5EEvWIGIwjfXev
         GGhYxSgu9GnpUID7j48jd8PHoeHiAIIuPd7hrrILS4xKBE5azFcq+nrHlvBZHFJZCOhb
         r1qECucxXKGcbHQMd9Y8kKzolwfzVWbA++zkOp+JmbwnOKsUDV/Qj56zNLxWPKfvCvHs
         RBxkmX42/EZf7WvkKP+fk2LLWj41m3n5ol5SNt1AD7Tda8WtSgUl/tEyuKkrl7hZyIRS
         QNCw==
X-Gm-Message-State: AOJu0Yxj/AgJvbEMZAOTjbqaC5OdORjNuCGPa/iCRePtJmvwJeHRmrOY
	lsPRmDcwxZ7NwGatHmrV67pDbotBeuEOfZv31fNVF0e7v7CjIAMCighsNFAHsUknXdGcdvVUaIA
	r+8DzJJUwHmCMryFAH5Yjg+Qs/TPY/9sgZ4POHG9aEZ/ePGvQN3laVrOdAQfnOlaycx3JFTSLEf
	RpRbMvb8AAPrYnKw8nKBvlMgYOTl41Ftsw3xZmyy/pl6oZ2wg=
X-Gm-Gg: ATEYQzxrT38RtS1lQUmSpIoyf/5RfeA0xgyS28QaFxWIwDIWwqcNcPPZCeXXwuNyZVR
	nJ3N9ifAGChOsssWT57xAbEpLfdHtRYfw2oIZgDHP9np3XTxtwQokwzRaODDEuEDc9uhB2UCBoj
	HTTwQRbqM2qjF+8/+MpKbxjWSOvOMG6drRyX2+ula0KQUFdLHdpUnXUP8N4MtD58DtWWIvrpTg/
	xN3KOERrmVNLRL1GmKt7SXxQoFrlup9upXE6QRohOk9BmrwwXkZPpDWn5s8dJK/EocuUsyySdXt
	KGtKu0ZEOSQx9y7tS//QTYt8hNiLEzg5ssYBUkr8so3Sy7hx7ch9wQsCP8IaFQnAg3NnXoTWebY
	3OnXUawHSsTrCJ3eeuWDnIhl/xk2cDhWrxPQzdTiMu45DSZOQ3cjTQUAeIosDaZRh0gDz/9D8jC
	EVe6UlkVsJTb3A5Hk4zx2Q3CfNLUJJB3BLOG178XRJSa1hLpQcUFBH7mb/Nl0ixq/JLDnsBA4jM
	sY=
X-Received: by 2002:a05:6000:2011:b0:43b:3c05:d7fb with SMTP id ffacd0b85a97d-43b6427d66dmr1396379f8f.54.1773956225692;
        Thu, 19 Mar 2026 14:37:05 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm1190659f8f.4.2026.03.19.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:37:05 -0700 (PDT)
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
Subject: [PATCH v8 4/6] tls: split tls_set_sw_offload into init and finalize stages
Date: Thu, 19 Mar 2026 15:33:21 -0600
Message-Id: <20260319213323.235559-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260319213323.235559-1-rjethwani@purestorage.com>
References: <20260319213323.235559-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269670-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.933];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FE2B2D2BCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Separate cipher context initialization from key material finalization
to support staged setup for hardware offload fallback paths.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls.h        |  4 +++
 net/tls/tls_device.c |  3 +-
 net/tls/tls_sw.c     | 77 +++++++++++++++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 2f86baeb71fc..56eba13261d4 100644
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
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 5f5c0db118ff..1b2a8ada71c1 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1245,7 +1245,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
@@ -1259,6 +1259,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5fe07f110fe8..424e0a11bcf4 100644
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


