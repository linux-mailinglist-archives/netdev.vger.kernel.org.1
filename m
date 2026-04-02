Return-Path: <netdev+bounces-274778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGfQAGgCz2mBsQYAu9opvQ
	(envelope-from <netdev+bounces-274778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A738F58A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3775C301DC0D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E723B531B;
	Thu,  2 Apr 2026 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YwQZ1/wB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FB3B894B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174194; cv=none; b=p/zVzgq1i4zIvQAZNBHbJZ6zhLasVNvktAPL05zF+UD14gFaT0/TSAGTdcnN7q8cr/tErrR7qw809R4Qxc9L7VEAuzC/3yTADybQ94L5QBL0sFBnRENaN9JV+d5iyc1cRMNsd22+3U+LAcFFE5a9E6q5Mmj3GnuPlwZQ4XDWTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174194; c=relaxed/simple;
	bh=wVhA+uq0kld6H10x5yccK0ZRhxorcOZ35EAlrTmVDOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgrpUASdaRqQbxUKBlix/NdHoMauqExnqbyn8S03WPCufNCnXNfuTOYvmYby1LUn1jU9dkkcGAS8Uan7sf2TL7BWKUBpT3JdIEb5LrSHJD1v09B70BKK5pTX+kl8N41E0NVERlUc+u4OLme+LZx83a7RNFyCpiaTu3b79gC+VPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YwQZ1/wB; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-46702742c99so944791b6e.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775174191; x=1775778991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFNmODwbyOIfVXS2kNXCmu1eqkHG0NLc5XAsnLhykkE=;
        b=YwQZ1/wBFEnyUNqYtsnWBj2/c6+tuV8q9V29HCPyYPFs87zSIGvSR9MSmY96twrNHo
         RODXhDZqrpmGLpsI21Wm4whWO6P78wN7TvIDheg92sxVy4KM2NqqbZXtRvqqyjgfmRDn
         YxBiWRto4FQuWagR64E5h5Cus/ynJ4ZQtHPF/Uh7wrwtqDeTABCebG/MWMOUKKm0BO6i
         hegbG6CaaTsSwFzzIEhQslPOPxuV06V3c6vd6JD7OLozLMk0h1SspJ57a3cGq4yaKtw4
         dMSYWjvxegPQAFP4HwL2uxCQ9OdXD+amkhxunKBV17SMctb8VuOJqyNtLnqz2i9jXxLE
         iozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775174191; x=1775778991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFNmODwbyOIfVXS2kNXCmu1eqkHG0NLc5XAsnLhykkE=;
        b=rml9aE5Gp0KFghjYbhkLdYi950paoKZ+OlmKxrbwaHe1PrDePVH13lJnSeDNRkQxzs
         6dHA+fC9QUFPWf8ahwquOs/vwWq3fWZES6ytEWc+/iA0Xz7I5PVIYBbonSW+oMpthONj
         WU5F2uTalETgT8xfM9m06PmjTUH/QODOvN19pwE3BMmeMeQWZXNNx/SAP2YDzDjxqoAP
         M26EJ2ciWWQ7dCNWsxTwmE6A4LchtSvvqspDuWyo25jsKbJnMZtjyeoR2DgnLPtDQnHP
         DAkGd7zs3JFnZ0w5WJ278mKe3iqLYX9hukK0SI18J0qzdY6HBFhHypBZKeHL8XSg7A23
         Dv8w==
X-Gm-Message-State: AOJu0YzdwLK84qvCGKesxuqn+X4LBCj1gv6UQzENijsE1ruUbiYb1dQi
	Y6Y5bEYq5Q/IO8x7+lwHUGWY12CpWv9CS94qRTfzNXJutSFneHJnuOSfGOLmqVyP2AjWFGBEwVu
	VEFog8yju9xQIJE7BYjnf17YbHf0abK2t0QYQ7WpCXMivI8CWVJuZ22fBpNI7VhmuQ5yI8ULfJF
	8dvDKsklQ+6yJZpPzajxLNWSL5etzlMOVouXZnbBI8tQrPle8=
X-Gm-Gg: ATEYQzw7Vmrd724MYF0WsrmEves7sgHdLD1BV+Ucz1Mmc79jS8ymDpXhlz+rQiOtFEX
	jwPcpuakTfPpRimUv/feFp/zDlcKfzsxBEYzdC0sZT9HxFJRldJu/DJE04xK0lUJ7KRZ1a9a5JY
	K7Nmflbhgq9H2ICgN78NP/hDvuUrM1KIofMrf3YyEarxEWZtpBXAbb/NPe26NaKidQ0XMOHzMW7
	fhmIkk5J1zXD7Cm5JvcFytaYscVm1KogKeq9yjR5gvN/AEJRFcZBm5246zRMMcOwEQh5zbk3apl
	WyV0+XsT275Ax/kGZ4Bo2l5wTeFzw9fc0QVoHFJ5oIZwkj8ufjqqMeca03CvULniApx4BNxwR0T
	jAU3Ng4JtfrEcxaAG5Zhx6dF4hkPWA5xpMBoZj73QIIYVEUKB8WdvOEBv5iv5Eqqru/aT/+F4Gb
	MeZvdZbKmvjuNt9o2GgUzmHusA5E2QJlnUxaPUJS0sSJWBDTncUlQ9+0u9SqlQp/08TFiadKwMX
	5g=
X-Received: by 2002:a05:6808:3509:b0:459:b569:702f with SMTP id 5614622812f47-46ef966f46dmr723906b6e.15.1775174191193;
        Thu, 02 Apr 2026 16:56:31 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-46d8f9609bfsm2394775b6e.3.2026.04.02.16.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:56:30 -0700 (PDT)
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
Subject: [PATCH v12 4/6] tls: split tls_set_sw_offload into init and finalize stages
Date: Thu,  2 Apr 2026 17:55:09 -0600
Message-Id: <20260402235511.664801-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402235511.664801-1-rjethwani@purestorage.com>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
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
	TAGGED_FROM(0.00)[bounces-274778-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: EC6A738F58A
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
index e8f81a006520..a65cf9bab190 100644
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
index 20f8fc84c5f5..5df27493c2a7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2774,20 +2774,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
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
@@ -2808,12 +2807,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
 
@@ -2829,10 +2826,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2876,19 +2870,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
@@ -2907,3 +2888,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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


