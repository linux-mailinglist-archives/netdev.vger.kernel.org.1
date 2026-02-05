Return-Path: <netdev+bounces-257361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCnILy4lhWlV9AMAu9opvQ
	(envelope-from <netdev+bounces-257361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:18:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39087F84D1
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 124DF300FB4C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910333ADAD;
	Thu,  5 Feb 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W7MViwAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0255337B8C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333484; cv=none; b=mvoCceUhpiSj6uHoXwH+fHIeh5wXPPegx1vKmGb77afLoRQ0/+0Zk2nB9LdZfRUJc8vmav/ZtbK99fEIwb9zfvQ94Mf7aCnGSX5p3Ua/Dv0Q24iFfyVz/qirb7G7+R16GmmdsKRkqGcaPlZ+4v1aCpKoUTPhOc93dhjkGBeyj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333484; c=relaxed/simple;
	bh=Q8D8xseLKU8j1gikkLzy6hipPtDVxyfXIftQhKP1iRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkHjNd00z2PFxae4DaoFznrtJj9HAka5JyW90JXVSoRZYbYFJmG5rNXZToj/KTvrZqZoQKWo3yEbg4qE6dUoNYo88GngvX+e3M9ZbJ3ObyXCw1n8y48pBoi7/IcLR+q7r+rMalFK2ivuxkpqp6VDbr4wUwv+uf3WyZ5L9MvL+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W7MViwAh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8845cb580bso12381566b.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 15:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770333482; x=1770938282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l4ocRR2qjGqMD5icm7jzC6+jXMExtoTld58jaETBts=;
        b=W7MViwAhAUZxVh8zitEW74vD0m5/H9J1pED1nwMliTKxFBkvzoAZqllzikltmdivet
         3U0G5Q3qTMU24IxDjJgPMOZjFKE9mwKtdxyM7mgR9b/MMD5tGvbYbYhk5lIqQcBZBnQo
         2xN7q0TNE+pNkrHZyMs3thyzjoXB07FsLwbXLkgQGU+F+Wa0ryn62I490mjolKHQ+CpC
         Hy+xz5sfEd/xOSv1+s3m2dVG22apaEAS6DwjLrBaHJmvr/aYzUMwoAPyruoVVj154H9i
         7FC1I0/OklltVHYmyRMfcPNOZC0UtvdEPbQ+PwRv4rQeOPkgW/R895nR1AUpv6tZoqph
         eeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333482; x=1770938282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0l4ocRR2qjGqMD5icm7jzC6+jXMExtoTld58jaETBts=;
        b=N41HzPdcSR58Sz8iUvw2kNV+QIRVfpMX+jxmpaHLO6iCOuJp4N2FHMf4BGercwP9lW
         fG7gsQIVJySxZfLGLE68CPUYObJ4BVAUXq9Rc4IlRry1a+PaNs/IqZL0D5IVRGtU5r7M
         w93n8MCAgpS4DAXz8wM9E+bdbY/GMhid+fz2+bW8uS3ZW+iXff+3kum19BbL+qH7d+Ad
         KxqXTmjX/l5+AgsC92ZkqpnbnrqoY2k0n0gMzJ2krNuw+60JeaNDczH4fZwsDSooPolx
         wpA37LKsiAcUNnAw1PbIccW3blvV9Upho9W+EtWHJ1LtXYbIyzReRqTFmaDhZFn9TSFg
         BYZw==
X-Gm-Message-State: AOJu0Yy6SCVUv531JeanQMuVjMBLFpIve69xCCVhwe7paEZGXQXJWCsJ
	tposnzUhe5kOPBqrp1KXyz95BVjdb4MywNTXEZ0+a5Xw/S6lHO0c+BrhNZSWcrUPcU8cLnoUPXH
	z2945o/6tXv6AF0IoD/aJa6WCMakdArVksIMuPJLQpuEs8hn88JPp4itaoZHDNpfdByBCycIkRR
	EsoqDvyRZDRj5fiUkJ5UhG2VP4ez4C4LNr9Iyq86EDWXos9BA4NA==
X-Gm-Gg: AZuq6aIzrdzo3XrlVnOMJZO4RkUZeZ6+AfCZLf7fUJZkznJ/feuWWA02Ov8jXIRCuhZ
	fcwVrph/qa89xA1lmSGoueB0EtfxPNQa6vAfAJl7J2rrpjrXRaTUyUXALD14nmNvGq3rfx0MyO9
	XQs0LgmyGtOjEQAbLXFkTPrPUZPDkv6QM5sZDV4M9Ezu8kEfvW6ZBtCa4CO/VHdoVDr6XMik6Cq
	YIW1BFrnImm15/3x9Qk+bJXFOtdjE7K22fEK3BhdG69HeLHEVfwgM+Pi3Gv7l80x8mYg8egSZGn
	cOQkCRsuvdDXoqgcWNt3fuZBpiS03jjqEUjQ4Niqp+e/JfpBVlbfFnb7qG0fnJlZ1Paj5OTW093
	XyHWAa2TIK8mGtrQPgrTzJTGjAiJ7vSZF2njzIdiV0HVw+sVTUhTbNgx696ZB262UFYHN5Thc73
	GfNxcEQY9u+5l8QDWBlD6Od5IaVtycSiknZmJdK54pnzGnQ2bc7XTlRFmUGEJ+Xx4=
X-Received: by 2002:a17:907:1c93:b0:b7a:39a2:7f50 with SMTP id a640c23a62f3a-b8edf351037mr38728266b.39.1770333481579;
        Thu, 05 Feb 2026 15:18:01 -0800 (PST)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8eda74c415sm26649166b.7.2026.02.05.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 15:18:00 -0800 (PST)
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
Subject: [RFC PATCH v7 1/4] tls: add TLS 1.3 hardware offload support
Date: Thu,  5 Feb 2026 16:15:55 -0700
Message-Id: <20260205231558.139818-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260205231558.139818-1-rjethwani@purestorage.com>
References: <20260205231558.139818-1-rjethwani@purestorage.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257361-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 39087F84D1
X-Rspamd-Action: no action

Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
enabling hardware acceleration for TLS 1.3 connections on capable NICs.

TLS 1.3 differs from TLS 1.2 in several key ways that affect hardware
offload:

1. Content type handling: TLS 1.3 encrypts the content type as part of
   the ciphertext (inner content type), with the outer header always
   showing application_data. Added content type byte appending in
   tls_device_record_close() before the authentication tag.

2. Version validation: Extended tls_set_device_offload() and
   tls_set_device_offload_rx() to accept TLS_1_3_VERSION in addition
   to TLS_1_2_VERSION.

3. Software fallback: Updated tls_device_fallback.c to handle TLS 1.3
   IV construction (XOR with sequence number instead of explicit IV)
   and version-specific AAD sizes (5 bytes for TLS 1.3 vs 13 bytes for
   TLS 1.2).

4. Reencrypt path: Modified tls_device_reencrypt() to use
   prot->prepend_size and prot->tag_size instead of hardcoded
   TLS 1.2 values.

5. Memory fallback: Pre-populate dummy_page with identity mapping for
   all 256 byte values, enabling safe fallback when memory allocation
   fails during TLS 1.3 content type appending.

6. Rekey handling: HW offload key update (rekey) is not yet supported.
   Added upfront checks to reject rekey on HW offload connections with
   -EOPNOTSUPP. For SW connections, rekey skips device offload attempts
   and goes directly to software path.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128
and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c          | 57 ++++++++++++++++++----
 net/tls/tls_device_fallback.c | 36 ++++++++++----
 net/tls/tls_main.c            | 89 +++++++++++++++++++++--------------
 3 files changed, 129 insertions(+), 53 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 82ea407e520a..459963c254f4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -319,6 +319,33 @@ static void tls_device_record_close(struct sock *sk,
 	struct tls_prot_info *prot = &ctx->prot_info;
 	struct page_frag dummy_tag_frag;
 
+	/* TLS 1.3: append content type byte before tag.
+	 * Record structure: [Header (5)] + [Ciphertext + ContentType (1)]
+	 * + [Tag (16)]
+	 * The content type is encrypted with the ciphertext for authentication.
+	 */
+	if (prot->version == TLS_1_3_VERSION) {
+		struct page_frag dummy_content_type_frag;
+		struct page_frag *content_type_pfrag = pfrag;
+
+		if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
+		    !skb_page_frag_refill(prot->tail_size, pfrag,
+					  sk->sk_allocation)) {
+			/* Out of memory: use pre-populated dummy_page */
+			dummy_content_type_frag.page = dummy_page;
+			dummy_content_type_frag.offset = record_type;
+			content_type_pfrag = &dummy_content_type_frag;
+		} else {
+			/* Write content type to current pfrag */
+			unsigned char *content_type_addr;
+
+			content_type_addr = page_address(pfrag->page) +
+					    pfrag->offset;
+			*content_type_addr = record_type;
+		}
+		tls_append_frag(record, content_type_pfrag, prot->tail_size);
+	}
+
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
 	 * use socket memory to improve coalescing (re-using a single buffer
@@ -335,7 +362,7 @@ static void tls_device_record_close(struct sock *sk,
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
-			 record->len - prot->overhead_size,
+			 (record->len - prot->overhead_size) + prot->tail_size,
 			 record_type);
 }
 
@@ -883,6 +910,7 @@ static int
 tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	int err, offset, copy, data_len, pos;
 	struct sk_buff *skb, *skb_iter;
@@ -894,7 +922,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
 	rxm = strp_msg(tls_strp_msg(sw_ctx));
-	orig_buf = kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
+	orig_buf = kmalloc(rxm->full_len + prot->prepend_size,
 			   sk->sk_allocation);
 	if (!orig_buf)
 		return -ENOMEM;
@@ -909,9 +937,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	offset = rxm->offset;
 
 	sg_init_table(sg, 1);
-	sg_set_buf(&sg[0], buf,
-		   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
-	err = skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->iv);
+	sg_set_buf(&sg[0], buf, rxm->full_len + prot->prepend_size);
+	err = skb_copy_bits(skb, offset, buf, prot->prepend_size);
 	if (err)
 		goto free_buf;
 
@@ -922,7 +949,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	else
 		err = 0;
 
-	data_len = rxm->full_len - cipher_desc->tag;
+	data_len = rxm->full_len - prot->tag_size;
 
 	if (skb_pagelen(skb) > offset) {
 		copy = min_t(int, skb_pagelen(skb) - offset, data_len);
@@ -1089,7 +1116,8 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	if (crypto_info->version != TLS_1_2_VERSION) {
+	if (crypto_info->version != TLS_1_2_VERSION &&
+	    crypto_info->version != TLS_1_3_VERSION) {
 		rc = -EOPNOTSUPP;
 		goto release_netdev;
 	}
@@ -1196,7 +1224,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
+	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION &&
+	    ctx->crypto_recv.info.version != TLS_1_3_VERSION)
 		return -EOPNOTSUPP;
 
 	netdev = get_netdev_for_sock(sk);
@@ -1409,12 +1438,22 @@ static struct notifier_block tls_dev_notifier = {
 
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
index 03d508a45aae..c8d18cce80ed 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -55,7 +55,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 	cipher_desc = get_cipher_desc(prot->cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_size = TLS_HEADER_SIZE + cipher_desc->iv;
+	buf_size = prot->prepend_size;
 	len = min_t(int, *in_len, buf_size);
 
 	memcpy_from_scatterwalk(buf, in, len);
@@ -66,16 +66,24 @@ static int tls_enc_record(struct aead_request *aead_req,
 		return 0;
 
 	len = buf[4] | (buf[3] << 8);
-	len -= cipher_desc->iv;
+	if (prot->version != TLS_1_3_VERSION)
+		len -= cipher_desc->iv;
 
 	tls_make_aad(aad, len - cipher_desc->tag, (char *)&rcd_sn, buf[0], prot);
 
-	memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE, cipher_desc->iv);
+	/* For TLS 1.2, copy explicit IV from record header.
+	 * For TLS 1.3, IV was already set up and we XOR with sequence number.
+	 */
+	if (prot->version == TLS_1_3_VERSION)
+		tls_xor_iv_with_seq(prot, iv, (char *)&rcd_sn);
+	else
+		memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE,
+		       cipher_desc->iv);
 
 	sg_init_table(sg_in, ARRAY_SIZE(sg_in));
 	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
-	sg_set_buf(sg_in, aad, TLS_AAD_SPACE_SIZE);
-	sg_set_buf(sg_out, aad, TLS_AAD_SPACE_SIZE);
+	sg_set_buf(sg_in, aad, prot->aad_size);
+	sg_set_buf(sg_out, aad, prot->aad_size);
 	scatterwalk_get_sglist(in, sg_in + 1);
 	scatterwalk_get_sglist(out, sg_out + 1);
 
@@ -112,7 +120,6 @@ static void tls_init_aead_request(struct aead_request *aead_req,
 				  struct crypto_aead *aead)
 {
 	aead_request_set_tfm(aead_req, aead);
-	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);
 }
 
 static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
@@ -303,9 +310,9 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 {
 	struct tls_offload_context_tx *ctx = tls_offload_ctx_tx(tls_ctx);
 	int tcp_payload_offset = skb_tcp_all_headers(skb);
+	void *buf, *iv, *aad, *dummy_buf, *salt, *iv_src;
 	int payload_len = skb->len - tcp_payload_offset;
 	const struct tls_cipher_desc *cipher_desc;
-	void *buf, *iv, *aad, *dummy_buf, *salt;
 	struct aead_request *aead_req;
 	struct sk_buff *nskb = NULL;
 	int buf_len;
@@ -317,7 +324,11 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	cipher_desc = get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_len = cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
+	/* Set AAD size based on TLS version */
+	aead_request_set_ad(aead_req, tls_ctx->prot_info.aad_size);
+
+	buf_len = cipher_desc->salt + cipher_desc->iv +
+		  tls_ctx->prot_info.aad_size +
 		  sync_size + cipher_desc->tag;
 	buf = kmalloc(buf_len, GFP_ATOMIC);
 	if (!buf)
@@ -325,9 +336,16 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 
 	iv = buf;
 	salt = crypto_info_salt(&tls_ctx->crypto_send.info, cipher_desc);
+	iv_src = crypto_info_iv(&tls_ctx->crypto_send.info, cipher_desc);
 	memcpy(iv, salt, cipher_desc->salt);
 	aad = buf + cipher_desc->salt + cipher_desc->iv;
-	dummy_buf = aad + TLS_AAD_SPACE_SIZE;
+	dummy_buf = aad + tls_ctx->prot_info.aad_size;
+
+	/* For TLS 1.3, copy the full fixed IV (salt + iv portion).
+	 * For TLS 1.2, iv portion will be filled from record in tls_enc_record.
+	 */
+	if (tls_ctx->prot_info.version == TLS_1_3_VERSION)
+		memcpy(iv + cipher_desc->salt, iv_src, cipher_desc->iv);
 
 	nskb = alloc_skb(skb_headroom(skb) + skb->len, GFP_ATOMIC);
 	if (!nskb)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 56ce0bc8317b..f7c369714b85 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -711,49 +711,68 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
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
+		/* HW rekey not yet supported */
+		if (update && ctx->tx_conf == TLS_HW) {
+			rc = -EOPNOTSUPP;
+			goto err_crypto_info;
+		}
+
+		/* Only try HW offload on initial setup, not rekey */
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
+		/* HW rekey not yet supported */
+		if (update && ctx->rx_conf == TLS_HW) {
+			rc = -EOPNOTSUPP;
+			goto err_crypto_info;
+		}
+
+		/* Only try HW offload on initial setup, not rekey */
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


