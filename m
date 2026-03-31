Return-Path: <netdev+bounces-273700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH5fFnr8y2nDNAYAu9opvQ
	(envelope-from <netdev+bounces-273700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DF536D696
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4330631632AF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151C4279F9;
	Tue, 31 Mar 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eCDAb1Pm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B96427A06
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975140; cv=none; b=I6lIBpGPU3qf5SdpJD1flEweJ+6/CU7cXvv8n8eEe4ZlYJcFI6qHN0z+z7NeJZQ6hbYz24qqEPEeDAKSIJRe7uiIQN75OJqDpiE1tvF2YQ6ytM+sKa8LGzjizSajpS2COdQ4b5JcdDqAfpPEJN5za7fgS6ARxcF9BmTV0wiK/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975140; c=relaxed/simple;
	bh=Ij2HxvUJuYcOhH65vJayYhQDZfr9DCwdwumCxgkTBw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6EoOuNmoedQjk67oZvq9vQBBl6r/YP/wYwEYbw5o9ZVB6q/zKcmuYzIcSUpCHjFUtykjAZt8JUdNEJHwCwVp8h2IX35YJCYSA52aQ0vHQ6QzrbZY4BcpjwgKHv9zn0CqCnqdQgI1c1/bRmbSgpZsrSf3hkCSLboNyspUXETrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eCDAb1Pm; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-46aa216a65aso2030055b6e.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975137; x=1775579937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U1Q8wx1N7PQ4eqg1H8/LRB2+VR0PfgkNh5DLCoGgkI=;
        b=eCDAb1Pm5Yw7NAvSq1IQVKFZjtri388/+z/6hjsPEak+xNpfDf9LfeWym3lul1Aa3j
         clsWINeAIo3llJER2KUKwPP5H1XEcBM9I2mYmkyGE9qMzdAkZ63GB7oOlCedwRhznQsp
         hTNkcljrmtBtYBN8YtYjas6E8A/vkdD6E3/cap/8/dYYJdrDU46ZB7z3BLUc1+JV7DJy
         S3Ck64CviuEj2dccOrtacH1jIUdQZY25yvlr757Lr4rfYeYKFuz5jqYCyC3WHqJ0Oiia
         4KUGHZGFxF8va9VrAVoUVg+v5iN6a8X/jpuOAEyDOCt/+wxr6H/wvcKxrE+quZpE3gta
         OqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975137; x=1775579937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1U1Q8wx1N7PQ4eqg1H8/LRB2+VR0PfgkNh5DLCoGgkI=;
        b=ZRzURTtqaN5CYzh1gR7WtadXwcCz+ylcZp9JfSHBkHLSdk+nBkxuCvBiwqoIIPpwXa
         xyr0IGBDJKB14WJeFS+XGKYHcoFoSJyLJHVRH1fdd5SSJ14v1BjqXp/NbW0XtjMbX+B/
         dJipAVnc0eS13ptvKuw2axkSq8sJYxKDfVKvY13z37Ckljo5c9hK0k9xY/alxny/fUKi
         VZefLnUuf7q6LkgL5qrrWSI235aIBFviAtwgZ+BtNJx2uO/Bll2sIWfGq77Jc/sDntns
         DfVitgq3hoFQqCBqkLe+jCMYVM0vMNLf4HRxrP9uSvfn+hel5ARIK19i5kbx6F/8yZ3n
         eJbQ==
X-Gm-Message-State: AOJu0YwUO9khoC9Ut7nG3umHJsEO8Mw6RFFLQ25QqqdoLciQ5bX3ynA3
	HMXvBBf59VQNOooC++/0IaEKa/GeegaJIrVngLOUYcfSnhx19YMJoqsxP1XVQxMdoPYgomanjO4
	vBCrjQJMv+O4lF4ZmrCswv+RZaw2TMWZlLkAL8DZm4JLAIPsJtn8tBZrN2k8TqMTVLiY2LawCtx
	c7ZKB1w9ytSU90HsQb5Lu9rLVtm1+iNBPxMP3TN1FwBsFVkpI=
X-Gm-Gg: ATEYQzy6E/MmqToxc4TkEgNZDeYXW68rERSGfe7aNUHWpuqjzYkDziN00Lh9oe3tN/H
	op5BzDeOdyx7vDv9P8+IQBrhe1LHFpDt8aBvYpK1twz6+IxCKY2zb7/OPfAjsak2xY8m3Iuqs2f
	smNfQPXuj4gRfTn4CkLXJdDuDh3V4IhWHbRBBwp83SEBNBQtEu/5dY8GjVVcwd8C95XcxCcf2p6
	tAeRKjkKjGh6IVOXLxTC2XXGqY0XPc2fIysCj7Plkc876VZifNaI7mb7+JR+zdLgTqwMV5zh9Ak
	ReYibGS+iiee222Ph6FaMKLbngBC2nCVdZ4K/qgf9tcvtrYgRknbtJNXyWVc7hoiR89NLHCeDkJ
	LiWjUHqpUqj/Cm+gLztyurYEe8xD+BDb1d6SbGvQMonSdUNkp01tZx3PACiW0uq1NjZdZhuBLHM
	FmjD38O3qYnnC9/FY64iGzijTBpQ7LZwC2qhYgtnal2GqxMZlBmaIufHPtgsi3BBsfyio+U+Az5
	Gk=
X-Received: by 2002:a05:6808:3448:b0:467:14c7:a8b5 with SMTP id 5614622812f47-46adff87158mr54053b6e.10.1774975137078;
        Tue, 31 Mar 2026 09:38:57 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm7599651fac.18.2026.03.31.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:38:56 -0700 (PDT)
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
Subject: [PATCH v11 3/6] tls: add TLS 1.3 hardware offload support
Date: Tue, 31 Mar 2026 10:37:54 -0600
Message-Id: <20260331163757.149343-4-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273700-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,dummy_tag_frag.page:url]
X-Rspamd-Queue-Id: 82DF536D696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
enabling hardware acceleration for TLS 1.3 connections on capable NICs.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128
and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c          | 65 ++++++++++++++++-----------
 net/tls/tls_device_fallback.c | 58 +++++++++++++-----------
 net/tls/tls_main.c            | 85 ++++++++++++++++++++---------------
 3 files changed, 121 insertions(+), 87 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 99c8eff9783e..1321bf9b59b0 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -317,25 +317,34 @@ static void tls_device_record_close(struct sock *sk,
 				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	struct page_frag dummy_tag_frag;
-
-	/* append tag
-	 * device will fill in the tag, we just need to append a placeholder
-	 * use socket memory to improve coalescing (re-using a single buffer
-	 * increases frag count)
-	 * if we can't allocate memory now use the dummy page
+	int tail = prot->tag_size + prot->tail_size;
+
+	/* Append tail: tag for TLS 1.2, content_type + tag for TLS 1.3.
+	 * Device fills in the tag, we just need to append a placeholder.
+	 * Use socket memory to improve coalescing (re-using a single buffer
+	 * increases frag count); if allocation fails use dummy_page
+	 * (offset = record_type gives correct content_type byte via
+	 * identity mapping)
 	 */
-	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
-	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
-		dummy_tag_frag.page = dummy_page;
-		dummy_tag_frag.offset = 0;
-		pfrag = &dummy_tag_frag;
+	if (unlikely(pfrag->size - pfrag->offset < tail) &&
+	    !skb_page_frag_refill(tail, pfrag, sk->sk_allocation)) {
+		struct page_frag dummy_pfrag = {
+			.page = dummy_page,
+			.offset = record_type,
+		};
+		tls_append_frag(record, &dummy_pfrag, tail);
+	} else {
+		if (prot->tail_size) {
+			char *content_type_addr = page_address(pfrag->page) +
+						  pfrag->offset;
+			*content_type_addr = record_type;
+		}
+		tls_append_frag(record, pfrag, tail);
 	}
-	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
-			 record->len - prot->overhead_size,
+			 record->len - prot->overhead_size + prot->tail_size,
 			 record_type);
 }
 
@@ -883,6 +892,7 @@ static int
 tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	int err, offset, copy, data_len, pos;
 	struct sk_buff *skb, *skb_iter;
@@ -894,7 +904,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
 	rxm = strp_msg(tls_strp_msg(sw_ctx));
-	orig_buf = kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
+	orig_buf = kmalloc(rxm->full_len + prot->prepend_size,
 			   sk->sk_allocation);
 	if (!orig_buf)
 		return -ENOMEM;
@@ -909,9 +919,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	offset = rxm->offset;
 
 	sg_init_table(sg, 1);
-	sg_set_buf(&sg[0], buf,
-		   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
-	err = skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->iv);
+	sg_set_buf(&sg[0], buf, rxm->full_len + prot->prepend_size);
+	err = skb_copy_bits(skb, offset, buf, prot->prepend_size);
 	if (err)
 		goto free_buf;
 
@@ -1089,11 +1098,6 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	if (crypto_info->version != TLS_1_2_VERSION) {
-		rc = -EOPNOTSUPP;
-		goto release_netdev;
-	}
-
 	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
 	if (!cipher_desc || !cipher_desc->offloadable) {
 		rc = -EINVAL;
@@ -1196,9 +1200,6 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
-		return -EOPNOTSUPP;
-
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
@@ -1409,12 +1410,22 @@ static struct notifier_block tls_dev_notifier = {
 
 int __init tls_device_init(void)
 {
-	int err;
+	unsigned char *page_addr;
+	int err, i;
 
 	dummy_page = alloc_page(GFP_KERNEL);
 	if (!dummy_page)
 		return -ENOMEM;
 
+	/* Pre-populate dummy_page with identity mapping for all byte values.
+	 * This is used as fallback for TLS 1.3 content type when memory
+	 * allocation fails. By populating all 256 values, we avoid needing
+	 * to validate record_type at runtime.
+	 */
+	page_addr = page_address(dummy_page);
+	for (i = 0; i < 256; i++)
+		page_addr[i] = (unsigned char)i;
+
 	destruct_wq = alloc_workqueue("ktls_device_destruct", WQ_PERCPU, 0);
 	if (!destruct_wq) {
 		err = -ENOMEM;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index d3c72f509baa..99d5590d20b0 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -37,14 +37,15 @@
 
 #include "tls.h"
 
-static int tls_enc_record(struct aead_request *aead_req,
+static int tls_enc_record(struct tls_context *tls_ctx,
+			  struct aead_request *aead_req,
 			  struct crypto_aead *aead, char *aad,
 			  char *iv, __be64 rcd_sn,
 			  struct scatter_walk *in,
-			  struct scatter_walk *out, int *in_len,
-			  struct tls_prot_info *prot)
+			  struct scatter_walk *out, int *in_len)
 {
 	unsigned char buf[TLS_HEADER_SIZE + TLS_MAX_IV_SIZE];
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	struct scatterlist sg_in[3];
 	struct scatterlist sg_out[3];
@@ -55,7 +56,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 	cipher_desc = get_cipher_desc(prot->cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_size = TLS_HEADER_SIZE + cipher_desc->iv;
+	buf_size = prot->prepend_size;
 	len = min_t(int, *in_len, buf_size);
 
 	memcpy_from_scatterwalk(buf, in, len);
@@ -66,16 +67,27 @@ static int tls_enc_record(struct aead_request *aead_req,
 		return 0;
 
 	len = buf[4] | (buf[3] << 8);
-	len -= cipher_desc->iv;
+	if (prot->version != TLS_1_3_VERSION)
+		len -= cipher_desc->iv;
 
 	tls_make_aad(aad, len - cipher_desc->tag, (char *)&rcd_sn, buf[0], prot);
 
-	memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE, cipher_desc->iv);
+	if (prot->version == TLS_1_3_VERSION) {
+		void *iv_src = crypto_info_iv(&tls_ctx->crypto_send.info,
+					      cipher_desc);
+
+		memcpy(iv + cipher_desc->salt, iv_src, cipher_desc->iv);
+	} else {
+		memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE,
+		       cipher_desc->iv);
+	}
+
+	tls_xor_iv_with_seq(prot, iv, (char *)&rcd_sn);
 
 	sg_init_table(sg_in, ARRAY_SIZE(sg_in));
 	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
-	sg_set_buf(sg_in, aad, TLS_AAD_SPACE_SIZE);
-	sg_set_buf(sg_out, aad, TLS_AAD_SPACE_SIZE);
+	sg_set_buf(sg_in, aad, prot->aad_size);
+	sg_set_buf(sg_out, aad, prot->aad_size);
 	scatterwalk_get_sglist(in, sg_in + 1);
 	scatterwalk_get_sglist(out, sg_out + 1);
 
@@ -108,13 +120,6 @@ static int tls_enc_record(struct aead_request *aead_req,
 	return rc;
 }
 
-static void tls_init_aead_request(struct aead_request *aead_req,
-				  struct crypto_aead *aead)
-{
-	aead_request_set_tfm(aead_req, aead);
-	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);
-}
-
 static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
 						   gfp_t flags)
 {
@@ -124,14 +129,15 @@ static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
 
 	aead_req = kzalloc(req_size, flags);
 	if (aead_req)
-		tls_init_aead_request(aead_req, aead);
+		aead_request_set_tfm(aead_req, aead);
 	return aead_req;
 }
 
-static int tls_enc_records(struct aead_request *aead_req,
+static int tls_enc_records(struct tls_context *tls_ctx,
+			   struct aead_request *aead_req,
 			   struct crypto_aead *aead, struct scatterlist *sg_in,
 			   struct scatterlist *sg_out, char *aad, char *iv,
-			   u64 rcd_sn, int len, struct tls_prot_info *prot)
+			   u64 rcd_sn, int len)
 {
 	struct scatter_walk out, in;
 	int rc;
@@ -140,8 +146,8 @@ static int tls_enc_records(struct aead_request *aead_req,
 	scatterwalk_start(&out, sg_out);
 
 	do {
-		rc = tls_enc_record(aead_req, aead, aad, iv,
-				    cpu_to_be64(rcd_sn), &in, &out, &len, prot);
+		rc = tls_enc_record(tls_ctx, aead_req, aead, aad, iv,
+				    cpu_to_be64(rcd_sn), &in, &out, &len);
 		rcd_sn++;
 
 	} while (rc == 0 && len);
@@ -317,7 +323,10 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	cipher_desc = get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_len = cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
+	aead_request_set_ad(aead_req, tls_ctx->prot_info.aad_size);
+
+	buf_len = cipher_desc->salt + cipher_desc->iv +
+		  tls_ctx->prot_info.aad_size +
 		  sync_size + cipher_desc->tag;
 	buf = kmalloc(buf_len, GFP_ATOMIC);
 	if (!buf)
@@ -327,7 +336,7 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	salt = crypto_info_salt(&tls_ctx->crypto_send.info, cipher_desc);
 	memcpy(iv, salt, cipher_desc->salt);
 	aad = buf + cipher_desc->salt + cipher_desc->iv;
-	dummy_buf = aad + TLS_AAD_SPACE_SIZE;
+	dummy_buf = aad + tls_ctx->prot_info.aad_size;
 
 	nskb = alloc_skb(skb_headroom(skb) + skb->len, GFP_ATOMIC);
 	if (!nskb)
@@ -338,9 +347,8 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	fill_sg_out(sg_out, buf, tls_ctx, nskb, tcp_payload_offset,
 		    payload_len, sync_size, dummy_buf);
 
-	if (tls_enc_records(aead_req, ctx->aead_send, sg_in, sg_out, aad, iv,
-			    rcd_sn, sync_size + payload_len,
-			    &tls_ctx->prot_info) < 0)
+	if (tls_enc_records(tls_ctx, aead_req, ctx->aead_send, sg_in, sg_out,
+			    aad, iv, rcd_sn, sync_size + payload_len) < 0)
 		goto free_nskb;
 
 	complete_skb(nskb, skb, tcp_payload_offset);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41a61..fd04857fa0ab 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -711,49 +711,64 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	}
 
 	if (tx) {
-		rc = tls_set_device_offload(sk);
-		conf = TLS_HW;
-		if (!rc) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
-		} else {
-			rc = tls_set_sw_offload(sk, 1,
-						update ? crypto_info : NULL);
-			if (rc)
-				goto err_crypto_info;
-
-			if (update) {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
-			} else {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+		if (update && ctx->tx_conf == TLS_HW) {
+			rc = -EOPNOTSUPP;
+			goto err_crypto_info;
+		}
+
+		if (!update) {
+			rc = tls_set_device_offload(sk);
+			conf = TLS_HW;
+			if (!rc) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+				goto out;
 			}
-			conf = TLS_SW;
 		}
-	} else {
-		rc = tls_set_device_offload_rx(sk, ctx);
-		conf = TLS_HW;
-		if (!rc) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+
+		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
+		if (rc)
+			goto err_crypto_info;
+
+		if (update) {
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
 		} else {
-			rc = tls_set_sw_offload(sk, 0,
-						update ? crypto_info : NULL);
-			if (rc)
-				goto err_crypto_info;
-
-			if (update) {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
-			} else {
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
-				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+		}
+		conf = TLS_SW;
+	} else {
+		if (update && ctx->rx_conf == TLS_HW) {
+			rc = -EOPNOTSUPP;
+			goto err_crypto_info;
+		}
+
+		if (!update) {
+			rc = tls_set_device_offload_rx(sk, ctx);
+			conf = TLS_HW;
+			if (!rc) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+				tls_sw_strparser_arm(sk, ctx);
+				goto out;
 			}
-			conf = TLS_SW;
 		}
-		if (!update)
+
+		rc = tls_set_sw_offload(sk, 0, update ? crypto_info : NULL);
+		if (rc)
+			goto err_crypto_info;
+
+		if (update) {
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+		} else {
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
 			tls_sw_strparser_arm(sk, ctx);
+		}
+		conf = TLS_SW;
 	}
 
+out:
 	if (tx)
 		ctx->tx_conf = conf;
 	else
-- 
2.25.1


