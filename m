Return-Path: <netdev+bounces-282464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ46HT9K8mnNpQEAu9opvQ
	(envelope-from <netdev+bounces-282464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:13:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D363C498DA5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5403034AA8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7D38D688;
	Wed, 29 Apr 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UbFNLgIz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D631BCAE
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486322; cv=none; b=fCaFiIDyCk3yK+9HQY2V4KjnX9XTnx7ylZb+etUODwvtrXPqt5wPPCAeg2p+mLopR7u0dkTFZkcqiQi1aNaYX/9EISBuu1EhuvWYtJciAhDquftdXNlWj8DB+XCWxya07bRt/lb/f0Rp8yvML3SVVXkVGeBOdwxyEC9blBF+wJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486322; c=relaxed/simple;
	bh=5W8iRfD72QIOspKk0xvoGSeUmUi+N59fRxpfp5fVDhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HeNuCF+SrK6pRoJVIbBY9eUhH27PTKJIsvyPrXMUedQ1p58Q+KibROVhSXIPhAX1HxJHfFEHhdJxV1FDrNf4j5hVDFsG5vW9vhMgPNLaQVRiJdrh4KhEgGfyi0kkKaNdpml023lje2OTI4f7YTnqoJrF4vTQrmHgVPr29ttxy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UbFNLgIz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48896199cbaso426785e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777486319; x=1778091119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NM7R94dE58DheSFh2JVocjMVQmfKxwu6QIeFRTzCdA=;
        b=UbFNLgIz1+ZOb2AERRVmffDAye8vOSPnFM3kyd+VO4rmyJWCtCqq8rUsJFQE5z6u6U
         sHwPSMQ3CVzPKd6MSO0ELG/JTyrtI4XYoBhM+TPr3obBwZhHATMdq1Bh7BboJcDCKuEQ
         i5MEGFHl6DHoxLTvk+T9bdYuwf3Z4mRbwO2QMJZ6F+/q4a2YuWk2+nye/zzUIAF5eEFy
         IomNtJeWXEvaRzAHb/OEsCebFJIIqahi9GnLLcQVwKYRa75EDTCD5JDVvYmGr+7zsJAU
         dJnoiAwq3topr6f7HGgFYQPV/+W0YFk7BPamomc90TLuUa9fuW6DB0a0tQOJ8MmfUdat
         oXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486319; x=1778091119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NM7R94dE58DheSFh2JVocjMVQmfKxwu6QIeFRTzCdA=;
        b=VN5GKOIy0QwaGwnyrimI39ckYi3zH+zN/cp79/f4BRu18JIhkb2biiEcZoG2hjEJP+
         JKC+PSOnBmA+ljGpoBcD4iQ0uzh3CQ3zH0vJVfCWXKpZ3LvHeZZkBe7oiZMnmAUwOXHR
         MG3gbUPKK27XVs9NDUb4ymlgX56pv6ftR2uMAHhPZVLMEMYV/eDLplQYqEOccd6KXmfn
         Qka7C+lhLmVu/HJLJRNz0J7EpY0ePUF/K85FNLFFsiYsYuHxLE9zS3RnBaA6a5VNzf6h
         dwzjKwa9nVqbziiryoGt8kwpZBLXMRQG1Iv7fysfbMSALr0T25O0GlTuOei16KpwABMB
         8dVQ==
X-Gm-Message-State: AOJu0YxAOzPPz+QTvRF/olYceqwXcXx77aTNARAJraL0Lrk9XFSlKIVz
	1jeFssLDpN63BWdNGwgCo3QysGeVMP+iO+U3xiLAP9xMUwlGu54t+FU5e9ZFs0WPSnf56+hbGaH
	+c2lg+0ykWZLm2wLsKUfVMIo/A+8sA0KhYhC9baRurHYih4LCZtYRaSKkGm/j3/teEqdcgwM1JT
	y+tRhS6bUswLBWi8DAuvfPO5S5sGbbELyA1ODUV7oHrZaeqK4=
X-Gm-Gg: AeBDievlkWm8KpzFS9t/vbO7FTeg+qDNSgF34jp1+MpyG+PEJTGqJbAVfXW2BgFyi8v
	7WReaZqGQSEITRyreFdNuonNXkGPANz7oEhTAeh2y4CaYxQX0TsOk0VHsHudxN2vQFVZ9Ryjysm
	2RT9AhwV/quBKKdGETQojXU/ViWlvJFdjy7t3jaTeLRqjW+5vu/8D3KD4LlZklFecd6ucntodnO
	F/XImKoKZJcdBbJClNmHDMKbE5HcA9gjxMJngnTafHqm9nVRXxnQ+uCrAU7ikXFHmrZ87AOAZ2i
	PAGpZuQW+X9AjiX9Zh9/L1lxUzXS8F6/2Wvhu8uhvExxv8ZaO6JgkclIkdLFKI4h8IAc0pr9Xkf
	EorwmrgLyipBTPRbDwxHF3SX5KDfP/dNYC/ip4/Nm77WLTC9sHupXXw2hiotnSHum52KFvUTDeK
	6APh30a/5fNW+mooh+RmMmiuPNH6aL5yJjfJ68UReCJ9/FmMBbfQiJx8sQ82B3y6UyON0=
X-Received: by 2002:a05:600c:3b15:b0:489:1f3e:5f6f with SMTP id 5b1f17b1804b1-48a77ae5502mr146577865e9.12.1777486318663;
        Wed, 29 Apr 2026 11:11:58 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm7525285e9.14.2026.04.29.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:11:58 -0700 (PDT)
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
Subject: [PATCH v13 4/6] tls: split tls_set_sw_offload into init and finalize stages
Date: Wed, 29 Apr 2026 12:10:14 -0600
Message-Id: <20260429181016.3164935-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429181016.3164935-1-rjethwani@purestorage.com>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D363C498DA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282464-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,purestorage.com:dkim,purestorage.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index 94d2ae0daa8c..1412b3dcce4c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2784,20 +2784,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
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
@@ -2818,12 +2817,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
 
@@ -2839,10 +2836,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2886,19 +2880,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
@@ -2917,3 +2898,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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


