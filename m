Return-Path: <netdev+bounces-273701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGKNATb8y2mcNAYAu9opvQ
	(envelope-from <netdev+bounces-273701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:54:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230136D5B1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68531321EF9E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB91427A03;
	Tue, 31 Mar 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FNLNHwbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE5427A0C
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975142; cv=none; b=bIxZB4AYjg3cEI0UA8ywgVjN2vK28twM+Sfagc+UklGVxxh1RYpIy2xPvfPjbMPLqBh/7Es9rUNtQgdUjwSeMQWr4YgQ7zjE5FmpNBUNomVVhKCQQEX7vsBBTIi0iYn2ic0SqnGFAG6nuwTB/rum3H1t0N3zYEBTEqkk7IZg+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975142; c=relaxed/simple;
	bh=q+f4yDKvB4ekXEQmqXZyKChOX7Crd7TgMWI4HQrYD2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUACAy9u1pnMKU0ByImETl6x3ZK2GdCJ2B5bvuLJ0aqyMRzytQrM6EiPTsLrz03h+33fK+3YFv7Ph88MWV6wT/a+3loZDW+hHLACHZYAQe/aLQmt7Jhyfm6xx1R/EC0ZS4bbbifIBFiZgQo36SesR+hPjvPUB2aPYeknckJACH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FNLNHwbN; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4152698e745so2160472fac.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975140; x=1775579940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCxDdCmKsplhesiP7ezu7+DhGnQZIyOEoqSHubUjVcY=;
        b=FNLNHwbNXEbrHZWhraPDRjRzI21ARzUkxQJXS00Y4QJrwfRIaZE71+IOIOxrdX1Im6
         QWabJLmK5KT52eCZstic7RAFHGFxNxYEna5dvUPpgPeVu4N6Je/9Ug/LhA9zzOzw+fn+
         AvFyku+dJCDYRCaSkhtXKkeULoP9jpburJe6fgu50tIxpgIS7RyqmGbL+nLSeImaYge/
         S7zumURUddBwkXVzivWCW2bXs80UcwNz9+U3gBrreseQ+aJfB7P4ivGoYofCC4Pp2wmw
         pSjL9Vq811GBefIr9P2BrfkGXwZNDZ9HI/Xio3xaVmCF0l/f7Y7LXEVrgChhJZ87uwb8
         nC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975140; x=1775579940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCxDdCmKsplhesiP7ezu7+DhGnQZIyOEoqSHubUjVcY=;
        b=h0IdfE40OsgnLwl8DbTBFVQvdpS2sJxyjnEYyuslZE9nrZVZDv8CVLaRCPwAmTbiwQ
         eZe5ZzAWhoBje9sgdpmPJJx/gnfogQ6AxMWDbrA2nkW4UUl/wk2Wr5+TR1pHR35WL/2x
         K3H31Mh4+BouWV2qa9XzO6ZvZXSmfKKpyffUTSCffYgQUYGfcmelVvCN0nqFRcnJ58fo
         RLAPvs0EB5qeZ8M1mWEpJ03HxRzyYGPpB36f/iVEyl6ltYR7r45oVE73yHtzd7qUj4t+
         ECKsnIdUiBMFi34+mjNGHB1E7U1GdQDXREWzRcmThasfKVF2B+J+EkGDmRjQYYQkcj/x
         h+tQ==
X-Gm-Message-State: AOJu0Yyf82Hj+PYEjnGApMas6pAdQuYjoi2zHOIkmCLCainwMafBOa0N
	h9OZ55+MGfvTEzEm1qsy9ibDM1zn6uXq6/EZhW3DX5Yt8J6Ys+ruj+B4h62Rwyq42b7nLCWYo5j
	9UKsCFdaAekgn+Ms0X2JmeIeIe5CB05/4OUgspszcNzRMAgtw9OrxB+vQOUyPPQczn43EMy+jgc
	byfNV5l8NHZhKhAwHWXFy4e03XoyIX87hkHIEjQq7lY1adSZk=
X-Gm-Gg: ATEYQzzp5ZFjOw6RoSW9bs4CHz8wnJhCuZel9ZnOfJn4TNaAcXvoNbOoyLxWxnKzjKX
	aaxahDT4be2qa/7/4E2YxsZ4lywQf9FkaQMDzbQ8VFHYfAkdiWbzpd3l14y+90rrGUgI0kXoKZ0
	9feRqIb3IW+DpmrQGjK4tGSh8pL3QwIWNSx5YoQ1hKIy2Qf4zI0JRqICrRzbMjvhEJYt8ivD4s4
	3canCsZEHFFtjSgogLyhWvge4iDGhOavhp8LXwT3eBoJTQpZSjPZfqOTQThf2eoDb7Kgu3qrfOZ
	i3H713ICfVO9vs95zu2HynGVK4R/kwR8naR0/w4yebSb7ejawUptJIhnF+rjiGeQ0KlBWA9ttPY
	ZttAOqIYnWvJ0b3BeyCnQiM2LmnjLytGZxB2BqpPPd+Y+NaMyvD4GlQ+pFJLrNzgex4LpkgQNs8
	O1YWkeOlKnsD8szkBdzD+OlPhpteLeOmx5n6T2u+pDDM3yHHC1rNoTNPStHpZtjryjrREsiE1Ah
	mc=
X-Received: by 2002:a05:6870:8253:b0:41b:e72e:c115 with SMTP id 586e51a60fabf-422cfc39785mr195311fac.1.1774975139519;
        Tue, 31 Mar 2026 09:38:59 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm7599651fac.18.2026.03.31.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:38:59 -0700 (PDT)
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
Subject: [PATCH v11 4/6] tls: split tls_set_sw_offload into init and finalize stages
Date: Tue, 31 Mar 2026 10:37:55 -0600
Message-Id: <20260331163757.149343-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331163757.149343-1-rjethwani@purestorage.com>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273701-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid]
X-Rspamd-Queue-Id: 7230136D5B1
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


