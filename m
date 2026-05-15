Return-Path: <netdev+bounces-288460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOyXGqiRB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6C55833E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFAB304BDAB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85153405C42;
	Fri, 15 May 2026 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ckA0RALK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB7405C4F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880534; cv=none; b=JGv+CCUUjVTW+NTHoQi+o4v2VYPKKFuo9y5pV8yIfHddIO9a75ot+BNgdGysxoWnSRXK+0fUrRyuIATqrV3+WsdPFFIYG8paxlCG7tHbiX7ojJmWMJILA2QKrTSvWou7Ba2aAWrKM5kPywi2tondI3lEQKn8Y7MRNcLi5Gqf7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880534; c=relaxed/simple;
	bh=u7IDdS1bDJM3NswacuLnnQ6nvmpNjisZ477O1m3nPE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOGbHRsvMEn0dXAqgJfkpr1+BfWXy6f5Ey0MDTKzsQ5OvSNtwXh1Y0OdEcRO6t+KDobOm9sO9T7QmxGPCYKmYMzC+0J5wQcxAfCph8KoayZSsiVGcVVb5e2n09nWhw3G1QWehy1YfC1gNSwiE9xoq4Kt62gWZpe2iuMlgLeNQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ckA0RALK; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40427db1300so308978fac.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880532; x=1779485332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLkg28vkQMWwDukWPPM3MIKAtvhEPgxD2DJUdtD67I4=;
        b=ckA0RALKAWckBRC3TN/ZlIpSDlYubPoLN6mNwUac9jum0ab+UuIb/2JRGNPlr8obIu
         w0K73Dzj3yzM0kXMyo1BJRyafxbS7bQjg07RbD3CocrnVFXmVrDghvYWMzcX/QAItgr7
         otJyLn4l3JNDG8pEFRveKjrJI1o19WgaCynI6h10Pale7raGe6xw3KdGMg4O8z4oPY2Q
         bq2n4ODZp4mB0SK791P9FRZ4q0kxNJlojBSWDLPW5TvqMri02SuIkkF4Q+Tq+PZr8iLG
         03SIT6Fq9sffRYK2/J0NTZ5jw7Lbwa013XrVa8/4TwucjWc+9Kii2DJyA4Mna53niW6D
         twig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880532; x=1779485332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLkg28vkQMWwDukWPPM3MIKAtvhEPgxD2DJUdtD67I4=;
        b=IL8miS4CEjBRy/PDmc0A0HccKSteci08lXTIpebvCSLDILmPKjfwIs0xfDkua4TOIr
         rtllTxCajUjTa/x/6eDYqJn862HkReq8Tf6UvGwQf3k7bBwowuhuR0RNSAZH/LaJRI4x
         LhbwdF+PT3OiwQM2+iVFHsomvhaVukfk86pP06IttUpK1bQLlH1fgSPiWjtoNlH8sr5g
         vYxlvvqhPCjmUrMaPM4fvL3NXUE3suCB4Jp4EX/ZB4ofx6FLQPTGe5I0jXj4BgzX4n8F
         gL6sZlnUFB1iDBXMTjXAawpkXD/hzCThRftMVsP9moMD5rUS6JnIxif9KZGrO4mV2YXF
         zH4Q==
X-Gm-Message-State: AOJu0Yygq1NxXwJwC0UG4tbfSE59DAlLpLXkKMOMaYIo7OjCa6A0dicr
	ygS6FFtMkQUkkABJTrEnkXKu89Uga8r7ui5qqobCZl/Yy9M8c15qvzV6ySVRq5AfQUOH8hFnZEX
	VaoPX/gXEjg+F0b4bzDTo/rQ6zpZRMttdCKpbCN5IVvZsOZi0Ul5h9bHxQORXfVkRQevCfJBLMv
	ruGFC+KNAge9u3o2LtpW+St+UWFDHVy+W6zklZz2PcUWDDpeg=
X-Gm-Gg: Acq92OEg0aZessVCJ1MTfU86LClGuhbBT/GQ1kE8W0p8vBlHly5Th3oyABG/kxfXlqk
	1xX6WfWjIJ1aaxALfBQgz1q2Q/HDZTQbG/4qrF3ehwRCGc5S8Pjx7m7fxOdFEw/eQAIlZHq4Suy
	nTg5/NbAm++dkT7bsF+1ydrL9gp0iMQLJlZ3bxFTCAY64YztgDze29Cxnn9OuI80/mILUMhU+tW
	bN5yukvnEePzpdbGz9LEZJVnIJZZvwcJKwc9h9lmeHRCSWMCDZaJz9vYs8OXH8lRdxTz4g8l+QH
	kmXM8B+BDp/JqQrqOU4YERjedLx0hMqQ+MC48AKbgiU6TdM66cQQUZqILOeGCRE6efKQeGBdsKO
	TrpSYc3etKrqx4b9hjDl91p+nnZ5LJ6L0ynk0LP+Bf0tQBkdlU/fIzkanMvDGmnpJ68bd3xs2Qo
	bONA3+Mt5XT415EWHK9EiT8SgT3WTuyiJ0WCIstladMFkbcM6KO/yXjMb3TEu9Y5yiiBbx
X-Received: by 2002:a05:6820:1688:b0:69b:3fff:1407 with SMTP id 006d021491bc7-69c9bfc7a64mr3624274eaf.54.1778880531606;
        Fri, 15 May 2026 14:28:51 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:28:51 -0700 (PDT)
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
Subject: [PATCH v14 4/9] tls: split tls_set_sw_offload into init and finalize stages
Date: Fri, 15 May 2026 15:27:10 -0600
Message-Id: <20260515212715.3151307-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01A6C55833E
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-288460-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

Separate cipher context initialization from key material finalization
to support staged setup for hardware offload fallback paths.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls.h        |  4 +++
 net/tls/tls_device.c |  3 +-
 net/tls/tls_sw.c     | 77 +++++++++++++++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 12f44cb649c9..44bedb0dfdda 100644
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
index a087cf3f544f..f22f8a550c82 100644
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
index 3bfdaf5e64f5..dd8e88cc2a36 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2798,20 +2798,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
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
@@ -2832,12 +2831,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
 
@@ -2853,10 +2850,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2900,19 +2894,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
@@ -2931,3 +2912,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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


