Return-Path: <netdev+bounces-252513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eECXI5V6cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB916D03D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 353F5300B5AD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913AD3921C1;
	Thu, 22 Jan 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U4QjvsN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CB372B5E
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110161; cv=none; b=aIk5U+WYhZ2JiiEJk9iN6cKlk5atVWy9GPUh1vuc8YhN1v55m9eoHrTIYOKfw0fcWE1b/d47Ji/HahUjEU4ogxT+kZbCBonAjbFpRtmBRz48pGbbsT1OoC4fPzIBF9MLWVrUlxj6nEWrPpHQlc+ANPNVmhLOHDgl7MA3m84fc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110161; c=relaxed/simple;
	bh=Yj9IpeNI84Tk9/fJR1ydwq5Z0ViZ34h4q+ljYBstKlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bffpVVGI5pa/ccBf8tNKbQeyt0VF4DVIItjjEhQJr65Cxe8oFpOsKmz+Cy+AJTjaH2SKik5HX2680HnAMyPI03EjvbP1KVP4ktvyVEx81VSsowiGD4L0yzJ9eMEaMip7ULm31e41EnAFLD4yt41OwGloaQ9f8EgXKFeGTycbkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U4QjvsN8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so1968852a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769110154; x=1769714954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pZ0cZVz8LHxgf6lPIPgHvwd6mOwdlTxJ2INkMl0YPA=;
        b=U4QjvsN8Hdm58fHEwU2YJpdRCE6eXTG7wT+2fCuM7PUwvHk+wHXJ4gtQ2SQzdRpqLH
         yLndA9jaERnm2OFkXgsX/fPUkwwsFjVzgzFhUEq1o0qI28I2a6nmP/2rObLzA8SSnIaH
         mxWDZK4U1BhKfE5Etua4gJUEbfY99KBmp9a25Ew8uehfiOCQItyDku4JmQmMcTG5yUKu
         w2OO6FNDsfC4s2pZHPX3HWwu+ZqBqhOhH53CjiVs/jyvgJUZTP5yEIXKDBq1x2GjrGLg
         d4qWpyL8G9yassU8Qvk4xj3njMyM4YHH3KXQNBnPt3v0o9EAPnVQyps/e0R2YcU9oCEb
         OVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110154; x=1769714954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pZ0cZVz8LHxgf6lPIPgHvwd6mOwdlTxJ2INkMl0YPA=;
        b=T8K2kfBMl5bzOb1FyDW5gzsiGe4D6VlvWRAdxR+eiYQJ0Fz7ZA8Ku+plLnPGqZAWKi
         maRV5AWsOXS+Kdiex2k772k6F+fP+wqeUUWB92sizlfRe3ZQKDk03LyWMyHkNmJZtAQT
         SbGcIxq25JtxxNWWcfySbTPwUwXeK2/3CbwhruKbl4jbwDoH0dDgq+apeJCBTB88bgl3
         kgiyzLR2x73zMBFvGI8OnpttLqYYpyPLTovzbOy08kY2KuxsIkuJb9VRGZjgMDHBW43i
         w/tT+UDpqAqome515q2iG4bJVY9v/d/41Vtc+rW5K3yZeXzDgs1bWlEt2fahkkM2W7TO
         EBwA==
X-Gm-Message-State: AOJu0YzPOuaROQmr/SXNK/BcoIj6XNG5ZJV8Lb8hgzeg+Cy+K+yxIc0v
	l8eMpcSd2s9pLxOOl3p5ze09k0+mb7FoKyiq5EkMPbp0/pW5iDP/T0f+ZyrGTytSte+HSdZr3pk
	HrFWkQ11acT6o9jSlqcW/dTWBV5/Hs7fwjP7J2x4S//WN0Utmf1bHYopTZ0BSYummTQHMJ5y5PV
	/oDpk46jOwY5sX0g5FNF8KutOrrJIC368dD9PqQ6Ina5ADW7Y=
X-Gm-Gg: AZuq6aLY2lnAIstxQZaY6zxXV4w/tm/qFuuHqhq1h/PvY1hpFvaxf24KllnDnEJxpgn
	vXGiDqCXPrAeTtsK+sozFzMLDC+FR5cEJ8cMCVeCsQpcfrSkO9o7LT9zLvJFEaw17gvU5h3LvSV
	zq6gGz3UQ/jVBoTHS5nmEP6WeTFqFdC7V5EV7y+VpfFZHAeBZ+Y2Uw/RNbSCY5gBnlaif2PIVm3
	TbSdEeAJPMDe/x9pHpHaSW4yvSlr8HPKnHKor4OQyEpRBU+rwbJZPnA7AgbfUHHfpbbE5XN+BNh
	0SaPQWUM1h66hnByaDXoRoBdQKjxFhfEKLhrTS3Ije/J8Z8kT/h4b261iyGbcDJLdiuHEHJUp2v
	24ULfmcog1qggtYPvKI8+i/c0YK4I6IX/0c1slCge+vMRIhlxD8WvLe4l0Um6N8dbFbmDFbWzA8
	+LJ1w40jPnoL/nKbFBgmOJ4TDcCl66jKno9KlP
X-Received: by 2002:a17:907:7284:b0:b87:2579:b6cc with SMTP id a640c23a62f3a-b885ae3d07bmr24881666b.37.1769110153774;
        Thu, 22 Jan 2026 11:29:13 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b885b8011dfsm7925266b.70.2026.01.22.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:29:13 -0800 (PST)
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
Subject: [PATCH v5 1/3] tls: add TLS 1.3 hardware offload support
Date: Thu, 22 Jan 2026 12:28:49 -0700
Message-Id: <20260122192851.86670-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260122192851.86670-1-rjethwani@purestorage.com>
References: <20260122192851.86670-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252513-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: 2FB916D03D
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

4. Reencrypt path: Modified tls_device_reencrypt() to use prot->prepend_size
   and prot->tag_size instead of hardcoded TLS 1.2 values.

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
 net/tls/tls_device.c          | 54 +++++++++++++++++----
 net/tls/tls_device_fallback.c | 34 +++++++++----
 net/tls/tls_main.c            | 89 +++++++++++++++++++++--------------
 3 files changed, 124 insertions(+), 53 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 82ea407e520a..9c8dfbc668d4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -319,6 +319,30 @@ static void tls_device_record_close(struct sock *sk,
 	struct tls_prot_info *prot = &ctx->prot_info;
 	struct page_frag dummy_tag_frag;
 
+	/* TLS 1.3: append content type byte before tag.
+	 * Record structure: [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]
+	 * The content type is encrypted with the ciphertext for authentication.
+	 */
+	if (prot->version == TLS_1_3_VERSION) {
+		struct page_frag dummy_content_type_frag;
+		struct page_frag *content_type_pfrag = pfrag;
+
+		if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
+		    !skb_page_frag_refill(prot->tail_size, pfrag, sk->sk_allocation)) {
+			/* Out of memory: use pre-populated dummy_page */
+			dummy_content_type_frag.page = dummy_page;
+			dummy_content_type_frag.offset = record_type;
+			content_type_pfrag = &dummy_content_type_frag;
+		} else {
+			/* Write content type to current pfrag */
+			unsigned char *content_type_addr;
+
+			content_type_addr = page_address(pfrag->page) + pfrag->offset;
+			*content_type_addr = record_type;
+		}
+		tls_append_frag(record, content_type_pfrag, prot->tail_size);
+	}
+
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
 	 * use socket memory to improve coalescing (re-using a single buffer
@@ -335,7 +359,7 @@ static void tls_device_record_close(struct sock *sk,
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
-			 record->len - prot->overhead_size,
+			 (record->len - prot->overhead_size) + prot->tail_size,
 			 record_type);
 }
 
@@ -883,6 +907,7 @@ static int
 tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	int err, offset, copy, data_len, pos;
 	struct sk_buff *skb, *skb_iter;
@@ -894,7 +919,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
 	rxm = strp_msg(tls_strp_msg(sw_ctx));
-	orig_buf = kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
+	orig_buf = kmalloc(rxm->full_len + prot->prepend_size,
 			   sk->sk_allocation);
 	if (!orig_buf)
 		return -ENOMEM;
@@ -909,9 +934,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	offset = rxm->offset;
 
 	sg_init_table(sg, 1);
-	sg_set_buf(&sg[0], buf,
-		   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
-	err = skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->iv);
+	sg_set_buf(&sg[0], buf, rxm->full_len + prot->prepend_size);
+	err = skb_copy_bits(skb, offset, buf, prot->prepend_size);
 	if (err)
 		goto free_buf;
 
@@ -922,7 +946,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	else
 		err = 0;
 
-	data_len = rxm->full_len - cipher_desc->tag;
+	data_len = rxm->full_len - prot->tag_size;
 
 	if (skb_pagelen(skb) > offset) {
 		copy = min_t(int, skb_pagelen(skb) - offset, data_len);
@@ -1089,7 +1113,8 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	if (crypto_info->version != TLS_1_2_VERSION) {
+	if (crypto_info->version != TLS_1_2_VERSION &&
+	    crypto_info->version != TLS_1_3_VERSION) {
 		rc = -EOPNOTSUPP;
 		goto release_netdev;
 	}
@@ -1196,7 +1221,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
+	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION &&
+	    ctx->crypto_recv.info.version != TLS_1_3_VERSION)
 		return -EOPNOTSUPP;
 
 	netdev = get_netdev_for_sock(sk);
@@ -1409,12 +1435,22 @@ static struct notifier_block tls_dev_notifier = {
 
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
index 03d508a45aae..d0c9b7ad8a23 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -55,7 +55,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 	cipher_desc = get_cipher_desc(prot->cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_size = TLS_HEADER_SIZE + cipher_desc->iv;
+	buf_size = prot->prepend_size;
 	len = min_t(int, *in_len, buf_size);
 
 	memcpy_from_scatterwalk(buf, in, len);
@@ -66,16 +66,23 @@ static int tls_enc_record(struct aead_request *aead_req,
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
+		memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE, cipher_desc->iv);
 
 	sg_init_table(sg_in, ARRAY_SIZE(sg_in));
 	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
-	sg_set_buf(sg_in, aad, TLS_AAD_SPACE_SIZE);
-	sg_set_buf(sg_out, aad, TLS_AAD_SPACE_SIZE);
+	sg_set_buf(sg_in, aad, prot->aad_size);
+	sg_set_buf(sg_out, aad, prot->aad_size);
 	scatterwalk_get_sglist(in, sg_in + 1);
 	scatterwalk_get_sglist(out, sg_out + 1);
 
@@ -112,7 +119,6 @@ static void tls_init_aead_request(struct aead_request *aead_req,
 				  struct crypto_aead *aead)
 {
 	aead_request_set_tfm(aead_req, aead);
-	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);
 }
 
 static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
@@ -303,9 +309,9 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
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
@@ -317,7 +323,10 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	cipher_desc = get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_len = cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
+	/* Set AAD size based on TLS version */
+	aead_request_set_ad(aead_req, tls_ctx->prot_info.aad_size);
+
+	buf_len = cipher_desc->salt + cipher_desc->iv + tls_ctx->prot_info.aad_size +
 		  sync_size + cipher_desc->tag;
 	buf = kmalloc(buf_len, GFP_ATOMIC);
 	if (!buf)
@@ -325,9 +334,16 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 
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


