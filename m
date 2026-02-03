Return-Path: <netdev+bounces-256443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNH6FPFDgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:52:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8889DDDDD
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F33830021ED
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85878277CB8;
	Tue,  3 Feb 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X8Fvcp9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5B248F54
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144577; cv=none; b=GwXgwFQUCZALP8SavCF5hQwqoAeXchBo3SXcxgTzuFHlN2ivLqhGAsJa9YVlvBppJGml8dFi5tYRLK1URzBwEp41xYW3bTo0sj/r40jlL3KyjMnZ8rrdVyNT+ajbMt+uAYTZ+qi07FQrhFhovw8XkdoLuATKANM6JorUUL1SJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144577; c=relaxed/simple;
	bh=Q8D8xseLKU8j1gikkLzy6hipPtDVxyfXIftQhKP1iRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAGMfIvRLgfZXWUlVH+2sfbuWKYVKIrbkhjXD5E/bQY/jrvCVgsAZtH1XPR4hovionPTXBjM1jtcQNEYA3AsBlzwdmE0hvwCtiLX9FWSh+9pmpltsTw2f+/2Qp225lYC0v0BF2pliFU7qoeXzTGj+lgWqOqqjSsw5BeeJpnbmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X8Fvcp9E; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65941c07e8dso1110216a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144574; x=1770749374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l4ocRR2qjGqMD5icm7jzC6+jXMExtoTld58jaETBts=;
        b=X8Fvcp9EF/NJzgUGY1Jj4eoU5fMc6huCqH6NyWOTs2sjSp7j7tw4bybhgwlgki9vnS
         28TgQ35NHcYEDchVBhUOK5DUz9aqjhxLqcBEgt2lA65ieFzZr9Kl5E3alVT1OWNKzA/4
         +rOBBXr7TulVIsJAXm8LfsikprPnL5+z9Zam3d93uB7pcs3ffrHRsFu46TXE0PfgTpgy
         Q8uaAuEX69Qf2BzN+7JM5vqwsY+KKgWNfmJkihohgUH9fAIwQGElQlVIsfyT2tLS04re
         2EJ47mOXlBuJbVEH1XS6XEvw/91J1kcpPGkKn0iCca9mUXwGh7XURRDorrGW8ePB/Zjq
         Nn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144574; x=1770749374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0l4ocRR2qjGqMD5icm7jzC6+jXMExtoTld58jaETBts=;
        b=vBVOxJp8LBJ6C1weSE+CFduhJuSvh67nB4avLTlTOtNFBMfnRLHSXXx3Uc7b3JLHHI
         WWO/CnK0HKeBvhZx7MtWeyKiVyaHKYQI9MLMtQ89RCe0+ZIF4/7Oj7j7Pws9mL16V554
         NKafXGU2XkUNGgdLthp4tYV+wGDzpvUD27h5tPfysky/DciHHCPXGU5BwzU0FCks7scu
         YO2poRuEsr1Nt72+Wn54KS47lILuV6CveNJXN/NgLeugZCXVCYhQx+hoHET9ZjUDmXN9
         Pr8nnWk27WfABxFawyqf/ocBdcmj0+keNRP5pYh/7pzHPTFspROPPLFzyVm2Y0jNu0tw
         WNVw==
X-Gm-Message-State: AOJu0YwnL8SQ9tqOTIEOTCOR81kMEaiwMkW33kqTkAdxabTuWcS6VNI4
	dLBz+btbbMgICDSovI/doC0ty6daE2iSOrPAM28E2lutCFhXIiJ9ofm9fSOr1ZNvGejpb2VQqBD
	TgTrVjfA8oveD93QYNM+Eirr4BXYN36NOAO8sWus2O7TgLQLjSPLHadrYlxWSjFOGQlK+Hg1TYB
	Ljrzg3uNd0wrvwFT4USF0QRuu8tOh4a5DMkq83G/Mzsv8bzh8=
X-Gm-Gg: AZuq6aJBVKR67in4bgmvOhfQT2hN1xeSPwY3wwMnEuXSymOW9fYaNE+mLNi6mHJPMnQ
	DlNKeBfA66ojqg72CG6hvAuYOS6Ejjs0jKxN2/j42rJz8KYruPlObZYBa7eAMd1Tz7YQ5Ai5DeB
	jr3OLUW5H7nE7nMap6haZR6NMwKbEz+Dxu5y31azkmPScsdRbVzvIWb1c6O5C0qDHE49gUHXwDv
	Z8H50vSyisHGVUoLctvTu59AuCbij+TH5A2o9Avyv1FqQo1hIVSQM7ECFeyQCRM/NDiDiVWZRhc
	UproLuWTEgHFBLVZ7PC6q4JYbyfs42w5u7SG8fKX8GxyqVDATBI5xeopldol+jGaq7cSAIwj9xn
	z65HN4FdhxcAviL8POD7nyYXiyNT2/i36vhyAkMUaAlKWzo7Hyo3xu9UQ8BcAKnIWDTp1nxaGFH
	7u1A5ps+K+7m2kukI1Q2O2umC+QYvuH4kBgqFz
X-Received: by 2002:a17:907:1c99:b0:b88:46c5:eebd with SMTP id a640c23a62f3a-b8e9f34ae47mr32740966b.53.1770144573521;
        Tue, 03 Feb 2026 10:49:33 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8ea004ff2bsm12107766b.63.2026.02.03.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:49:33 -0800 (PST)
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
Subject: [PATCH v6 1/4] tls: add TLS 1.3 hardware offload support
Date: Tue,  3 Feb 2026 11:48:32 -0700
Message-Id: <20260203184835.3619101-2-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256443-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid,dummy_content_type_frag.page:url]
X-Rspamd-Queue-Id: A8889DDDDD
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


