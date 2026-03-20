Return-Path: <netdev+bounces-270119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP0VN7TfvWk1DAMAu9opvQ
	(envelope-from <netdev+bounces-270119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:00:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1242E26E9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E514304DAD2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7938E5C1;
	Fri, 20 Mar 2026 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WfugqEkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98F25A2A2
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051116; cv=none; b=Ae8OVCY9BqG8rpjjCm/vtc0mSWGdAQzLPIPlESWmxrM+1i3gd6O9jAvnzjFXUkFiBPPzhtFVC7xuUJyRVdMHFlZly+euwC4PALSJoTbmWU2eE6sHV/j9w/YgzATEJa3je2g1FmHWR4LoyebLbU/qWdw5leUJPV3EvZIKoH0IoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051116; c=relaxed/simple;
	bh=q+f4yDKvB4ekXEQmqXZyKChOX7Crd7TgMWI4HQrYD2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbV82LSRGTH/rey2v8m8ymTWTiwdcYlm1qnFnyAUpsvRN86GUoi3toQwpZkMgnP2yfcvjAm37nIuzHj763WV5IuQlX5M9PY8RX6caDKZ398+7SGklhjZQqJvYuh8lBVgScdR7T9BI1JtymcI4PpkMonX3xASBp6fGPKy1mFU97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WfugqEkA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd27754bso15676605e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774051104; x=1774655904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCxDdCmKsplhesiP7ezu7+DhGnQZIyOEoqSHubUjVcY=;
        b=WfugqEkAhbMomY68qeZdOEJTt8yhUYXuHhTbY/jyWUsXd81Td+tQ/eD09XJ1CdIfZt
         bA+L31n5Qv4z2uGCH43i7jV/0y3DLa9gU0P6Szynx+tAUclGg9crn84pcc8+uHV9RUzs
         xToXP8Vh2n6h6Yh+HyFK2If6zBFsOsstD12ffb53mEEQIWNnFL3vCJ3v5q4H3CcflbEF
         QimcV6MVrMshks7DcKtsDQeg7XTfdG7aXtH+QdpU0KGghqCQYpT/MqbPBBsFFqDB9kVs
         BFZRLh0y++YM1VdofhpBQ9UBHlkfeM1to18NG2BIS4gOW8BQaopFYYRdED897tfP6/mu
         OCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051104; x=1774655904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCxDdCmKsplhesiP7ezu7+DhGnQZIyOEoqSHubUjVcY=;
        b=l2slWTl+AmGmAo5QwMFQrVXbWOI7xR+4E08PWYx5hIHcgzvTg5Cf6oD2eOsZlk9QpX
         lqzeDcrk7qWF0YpSg+3w2PNTpR6Y9pgh4oNMdBr9kYej+hoXOWoWJxvkBnk0dJb+InVZ
         5C3tXOWfxj7mjeVm8zdNUTv9rpFpEIlKvYLGKdcMAioGSwT0AasoNbkpoSSZh4EHlZqH
         25+ZyM7crhZHlQMjmX5Zcpz6qXh+ny1XG6CRswOBKH7qhWP0YZ83grRxIGu6GmulDR5A
         Bj0OKeRovcusFtUPgl4F6DcA6y5PZtcEK4PUeODLfgeko0v8RH69GFTHmYQgbVEUmhOu
         b84Q==
X-Gm-Message-State: AOJu0YwIgAgS59WbDlMZvU5QETdcZ/O/rp+WpL/JY6N4mc3c7fkgs1Fu
	8+xturnwNSrQ0wdsJAfaigWGMzCw6fBlemMxFOxRuvOjZ++0OBHxQG+AGxgE38ccOGiAqboi1kr
	jT/mvkjtoBMpY1OvcrVAQcN0OFseAxSuzLEqgaRGli1vJFbDs2VO5bad7KXmjCQgco1ti+ZwKkF
	NM41655rIkFgZ4ZvXtN3FiBT7SQs919KUJATlVwCFbRhJqhkA=
X-Gm-Gg: ATEYQzzAIMVf+8G5CRRjjkimJmltfW/ERull/IBwwptXlfsq4CTTL+YztK0tFGeiRaR
	lAZ+//SJGq43EqvsXrhTjI9X2Z5uoob72EGlH23lCVeyZr7GxtR3jkWpXyCsP7HtPB2k348QuPf
	cE8r/FxbEK1da1dUogxQuC/OiNm5DSo6qgbFehm4889H1PL+2KaU5BlSci/OF0miyVgNg4Q4XCt
	dmV47LHXRppat4Ii6oKYnshKRH+L9dVARpPxTgtetTS8fwLPUB+xklqs9uHQiDfczUePqMXr4Gu
	qaKaE7f0/2/pOhrz+9NY9GBC57trbv43FYXD7it4CFcaV44Mo07jeaM5tAoWRs+sk7EYHoDNXdN
	xIIa6RfZ/JEgdjMmLiq2AFN1xjn/1ZK2XZ/eq9RCLpZytFqwYrNYyDhhaVaNAX0JLDmwPG3XPps
	IMD6Ue5dZtPZCLvnvIo1PL95WgwvHEzoJgh/1u1YsET7hFoK033j3sahCf5VxLHpTrfT3keqTHV
	1U=
X-Received: by 2002:a05:600c:1d0c:b0:485:a4de:f4f9 with SMTP id 5b1f17b1804b1-486fee30075mr75800335e9.27.1774051103869;
        Fri, 20 Mar 2026 16:58:23 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm28704635e9.7.2026.03.20.16.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:58:23 -0700 (PDT)
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
Subject: [PATCH v9 4/6] tls: split tls_set_sw_offload into init and finalize stages
Date: Fri, 20 Mar 2026 17:57:04 -0600
Message-Id: <20260320235706.636531-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260320235706.636531-1-rjethwani@purestorage.com>
References: <20260320235706.636531-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270119-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid]
X-Rspamd-Queue-Id: DE1242E26E9
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
index 1321bf9b59b0..cd26873e9063 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1233,7 +1233,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
@@ -1247,6 +1247,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
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


