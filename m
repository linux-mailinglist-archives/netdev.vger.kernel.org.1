Return-Path: <netdev+bounces-246460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD4CEC7E6
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44CBE30050A7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385C2FF661;
	Wed, 31 Dec 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WqrY2Hfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC890233721
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209123; cv=none; b=NzPMqj/t00JJWyM0PHf1ejlELlHV+SH2lKaOKjtDlSi7XMpOszlHVCYSe/qcFElfpAbjx2AYvt1NbqJeX0kcce9sgJDTpXr+maNBXuJszcPiXhV+P5BfYoSUSfDYOVebVMGiUFNYHNoLZpI/4A4iP9EnV3+0CQu6nDoA59iiv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209123; c=relaxed/simple;
	bh=z0mIBieEKx0GvDMnbebPQyM78jLI+0mIMN8B1pNJkgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yc3S65BOY3PQgcY1visRIZ0BDRPpg8FOc2Lb0hYY6XTinaXRUwzfWU9zdtD/S6S4+HScFLA9xxt6HtoxUSX+2Iu0l8AeV6UPG9x8LKeUqUw8f9IXnjOwwTsfJXOOnC3lAsEHPcRMJ+lAH20H93/N2C9MRmgWR2HGvnnnFIGFW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WqrY2Hfq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso18719406a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 11:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767209120; x=1767813920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzcC+CabUmEFL3bmKndpl9n8AXbuh4Sby1M8iUzToco=;
        b=WqrY2HfqPAjeJJ7ktOvlbr0JoOb25vPIRE45BjaDb28jUAgNNDyG3LY0ATTiMGeCLA
         iOtFSajLyVSdUr3OTR2IQC++HKdex1YukGzPr+1WcoN//jMCLOm7hbAVVSUBX2T1qklg
         7TvxvWR6rg6FueTpAttyW1pN6liZOysuqlJtjnls98EawglTSHYUgDWXRz/B6/v1ecNK
         U0quxKTmujmLYVU742gYSqbJ28p30vwiXZpdjWycUjyyZxvmqMWu/WJ5+DOUNdJxKAe0
         bqj8DtaDA/3PwZsMjbIJrAumx0YrC+Yk4bZG0sl8uHefgHACPnkpbtE+HdX1qDMAhNII
         po0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767209120; x=1767813920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzcC+CabUmEFL3bmKndpl9n8AXbuh4Sby1M8iUzToco=;
        b=Tgi71PJoI2rAKxT1zNu8dV9Vy6MhrfLvh4is0Z09Qpkj+rMuaWfgbAZ55P2+ovYU59
         GADHDxciwvnE4oJtE6nkDAXSBDlJFOvtPrpf20XVAwcJeDS/qVo06766fQkVISDVL/ha
         n6eMPX+VYMOPDvLlVk9zH7o7BC1zB/rY4ebLXqmvtWdX5vurYi6iWdbKOT/maC8QCU1U
         2FnEzobWdLJyI+uiCGP2Ao9Y6bnxuUCmK4cS3R+BauHxx8zZVlHHBA0flStai41EfH1y
         prJ7jLfTL5u7hydNi0j5hhuUxfwsxKwpgZvNTPOPWaqtzRllC+KtgQkdF+tl28Z0/ha+
         n8GQ==
X-Gm-Message-State: AOJu0YyotjbJUroQscT43LRWESVWz6N8weNQSZLddunMvtcZbqmGTWIf
	vPxKTgPhLaZnaqs3ib2o1bRQRYRBm0PyIJ1JFZOyTt4I6zHcjtjIRdh+Vk11jzGsjtDbga3BHov
	qUa/C1qbczSbedM2dSWJv1pnclpqAH/M3+R3FEOy0MINtCCkhufmnaZFykpqVHCYyHtSBH89B/j
	eWhX3tj8M/mB7GaXdF3Qqd/2B1lek5pbCSZUUBfzFfkLgcw7g=
X-Gm-Gg: AY/fxX5Wg8OuDVRgQ84sqk+eLfhhMQ1qCFedxF/ToYXNYTMkA2xzXajdpOIXU2SDZD3
	YM6c8QVdqDZNZNQZYNEf95aJEDCeEUU2wCwhGOzmlzkzqYz2TjvHg8rx87uFMzI8RxJNRC5nhjU
	gcnAugPPjjImPA2Q5Y8QQdiFozjNpbHI+jk2awSKOHemKlyP4rEDIH6ge9ryGBBNraaJJgikmH4
	fWbb1Fx/ALSWmW1WzJa+7byzxPJZI3gOBk7OzUAmmF2Qfvy4PX9bzBS2b3FhALeli35vEbr4g6N
	5s/lSxWWXyP/lhJmLZ6dQBcG818YG5wDDSJG22p3afI4u8rg7UHHzkUr4qzQoguecb8hMXBdrHR
	SRno3NFCRVeLuwryepwa6Gt2+sa/sD0H3FzVL4VnHAT4lM7ViPHwKPrn39fJYT3YqlVrmMj4vrE
	x1HQdYmfim87jmhJ7IFKDdMGipn3/4hXC2wgj9IBnB5ok8+B0=
X-Google-Smtp-Source: AGHT+IEFrylrfXPRN5lj38PzYKTAgukc8HN9JOyVEv6B4csPCXPeiebzXCVZ8b6mDceQry3grbJJXg==
X-Received: by 2002:a05:6402:2787:b0:64d:1fcf:3eda with SMTP id 4fb4d7f45d1cf-64d1fcf41d4mr31847964a12.22.1767209119952;
        Wed, 31 Dec 2025 11:25:19 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f5400bsm38680736a12.4.2025.12.31.11.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:25:19 -0800 (PST)
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
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v2 1/2] tls: TLS 1.3 hardware offload support
Date: Wed, 31 Dec 2025 12:23:21 -0700
Message-Id: <20251231192322.3791912-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231192322.3791912-1-rjethwani@purestorage.com>
References: <20251231192322.3791912-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
enabling hardware acceleration for TLS 1.3 connections on capable NICs.

This patch implements the critical differences between TLS 1.2 and TLS 1.3
record formats for hardware offload:

TLS 1.2 record structure:
  [Header (5)] + [Explicit IV (8)] + [Ciphertext] + [Tag (16)]

TLS 1.3 record structure:
  [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]

Key changes:
1. Content type handling: In TLS 1.3, the content type byte is appended
   to the plaintext before encryption and tag computation. This byte must
   be encrypted along with the ciphertext to compute the correct
   authentication tag. Modified tls_device_record_close() to append
   the content type before the tag for TLS 1.3 records.

2. Version validation: Both tls_set_device_offload() and
   tls_set_device_offload_rx() now accept TLS_1_3_VERSION in addition
   to TLS_1_2_VERSION.

3. Pre-populate dummy_page with valid record types for memory
   allocation failure fallback path.

Note: TLS 1.3 protocol parameters (aad_size, tail_size, prepend_size)
are already handled by init_prot_info() in tls_sw.c.

Testing:
Verified on Broadcom BCM957608 (Thor 2) and Mellanox ConnectX-6 Dx
(Crypto Enabled) using ktls_test. Both TX and RX hardware offload working
successfully with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 49 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 82ea407e520a..f57e96862b1c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -319,6 +319,36 @@ static void tls_device_record_close(struct sock *sk,
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
+		/* Validate record type range */
+		if (unlikely(record_type < TLS_RECORD_TYPE_CHANGE_CIPHER_SPEC ||
+			     record_type > TLS_RECORD_TYPE_ACK)) {
+			pr_err_once("tls_device: invalid record type %u\n",
+				    record_type);
+			return;
+		}
+
+		if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
+		    !skb_page_frag_refill(prot->tail_size, pfrag, sk->sk_allocation)) {
+			/* Out of memory: use pre-populated dummy_page */
+			dummy_content_type_frag.page = dummy_page;
+			dummy_content_type_frag.offset = record_type;
+			content_type_pfrag = &dummy_content_type_frag;
+		} else {
+			/* Current pfrag has space or allocation succeeded - write content type */
+			*(unsigned char *)(page_address(pfrag->page) + pfrag->offset) =
+				record_type;
+		}
+		tls_append_frag(record, content_type_pfrag, prot->tail_size);
+	}
+
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
 	 * use socket memory to improve coalescing (re-using a single buffer
@@ -335,7 +365,7 @@ static void tls_device_record_close(struct sock *sk,
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
-			 record->len - prot->overhead_size,
+			 (record->len - prot->overhead_size) + prot->tail_size,
 			 record_type);
 }
 
@@ -1089,7 +1119,8 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	if (crypto_info->version != TLS_1_2_VERSION) {
+	if (crypto_info->version != TLS_1_2_VERSION &&
+	    crypto_info->version != TLS_1_3_VERSION) {
 		rc = -EOPNOTSUPP;
 		goto release_netdev;
 	}
@@ -1196,7 +1227,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
+	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION &&
+	    ctx->crypto_recv.info.version != TLS_1_3_VERSION)
 		return -EOPNOTSUPP;
 
 	netdev = get_netdev_for_sock(sk);
@@ -1409,12 +1441,21 @@ static struct notifier_block tls_dev_notifier = {
 
 int __init tls_device_init(void)
 {
-	int err;
+	unsigned char *page_addr;
+	int err, i;
 
 	dummy_page = alloc_page(GFP_KERNEL);
 	if (!dummy_page)
 		return -ENOMEM;
 
+	/* Pre-populate dummy_page with all valid TLS record types
+	 * at their corresponding offsets for TLS 1.3 content type
+	 * fallback path
+	 */
+	page_addr = page_address(dummy_page);
+	for (i = TLS_RECORD_TYPE_CHANGE_CIPHER_SPEC; i <= TLS_RECORD_TYPE_ACK; i++)
+		page_addr[i] = (unsigned char)i;
+
 	destruct_wq = alloc_workqueue("ktls_device_destruct", WQ_PERCPU, 0);
 	if (!destruct_wq) {
 		err = -ENOMEM;
-- 
2.25.1


