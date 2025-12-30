Return-Path: <netdev+bounces-246390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F2FCEACAF
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 23:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65846301671D
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 22:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B172D4B5F;
	Tue, 30 Dec 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JcLoJpc8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45772C2365
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134531; cv=none; b=bDWPJ8aPSi7tp33UHp4fnsJJm1cmVNT/oPlLHIL0CytooMWrQu0xcw1N/Ft1yBNiFi+OEqpgCQPbv0EvT3p80D6n72Q95W1E0ObsFqhkftbl/IskDW55PN9Bfm29MtaUDtFvtMasfFQISiwMzajcArkyK5RfTvNYHqQvgwC1o2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134531; c=relaxed/simple;
	bh=pSg4NQOEiZ9FxuNNTbSYmL7iazGUq54fS+MuvPMYUAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/OZWzT4IpFGy542vzzyOwQbCcRUlizIuUpCuQRNd6R9ohDNeKyQHAAugw/XET1W8GqNYRl8qIEu8C+iAsU2nhzZBbYB0KLmCIGiCdY9roDDgVsookCf+nZFSZ3VlxTTCRiq6/eTi0Ai2p9te6QI8YqPmI8OdXQT7EgYu0OxBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JcLoJpc8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso13927697a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767134526; x=1767739326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdkfIz7qxe15y2HDOYYc7pDibZu3MrbXb1r/wYdJTzk=;
        b=JcLoJpc8B0b2WOpcBZMJoyVa18TTVGd4ymDpGLZDQlrgvKDOulgqECxO70vi3gx0rh
         K/MR8ysKFDkhY6f1ZxH675xv7C1aXtIBSpztciy5/dCxHTMK4TlD97St0HKvFyAw99C6
         GtqiFzJRDmzxsPU12Q/kBdOaKYW2dd+ALJZMwB3dZxqAu5DhWSVF7Ltrm4OFCi7GUb4x
         OCD1p5VO/Fz6Elli2bgAc1RvHuxFiD5JQPlLpC5kabJ4OfocUXfqgA6zIh8JvlNNWvzu
         ZQV8mgdMPXQuDzZJxUf3hhimVOef8nfphyXm8oYE57JXCLzinIUQxxi9tXUKbeHwZcoC
         8lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134526; x=1767739326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdkfIz7qxe15y2HDOYYc7pDibZu3MrbXb1r/wYdJTzk=;
        b=SrS7MRfipwS8A9qvWfdZRFeTWp03F014CdUFYuDosfdpu1SdY/9mq8APSF/CZcK1Zq
         kRazyZQWY7pN5XrF7Tnm9Yia9Cav+Ia+o2iBqF4mm7FlsRcMmotdF3VNRkMfTT7mkved
         AVMErSD3oQ9wBVBLp+PyJrPwVgDOR9hx0m3kURUBqALZuKPuIYW2L5M100rNAvjEWcTA
         Ww5Y90X4tA1w1eilL7lyyYlmtOw4VePLVdP4lQZhGSOg1+g5LH7GTk9KARt4hXinoiiL
         suLp8kt56IfQhXzGCqXQO1bqxp4qHDmttE6FT6seu1JJp711yMhT46YgkIDiO6LOe4n+
         9O5Q==
X-Gm-Message-State: AOJu0YwuB8iM7umwiKB/FxR5cCiczL8fwOivUWAr9J8wo+P21UZ1g1iw
	aGfnfZqQGNyxDpeRYouGlXalQwawgDzXhTpxRlKx4EovJRPYtqFnLoIPJH09Jx+JeugQPZLOgeq
	659pI48ch8hIDpC1cyNuUbFUrPoppcTMRisGPtee+ERKWVdzJqW1yDjTZv5ifuc9wilVDRmo6nl
	L1OrwcyqKCohQUfkMsMFLBdu6NE36n3IjgYmvvIQVgGEbfzTqNLg==
X-Gm-Gg: AY/fxX7QLHCxRT2tWz8lL/jPlgVm0xoPaYGfvBfdfJ7aOmSMT00otJ6ln1Wr+famVZa
	XDRRXxWxi0/RVQeIdkeUiI7HPUBFkhuTuHIJasVhXsB4hJX6MlVR2sQGk8nUslOSnpIThSto1cm
	zmVJsIy8oIi0M4D4Owez4UD0nFJFsevk6aLX2WltD/AOgqAPdztnItOkuKUWZODGOMJq07BPXxn
	T3AMNI1jfd8ZU7OU10mzPSjBz+RyQz+m3yVTaMDl9PQBkmiUxVINtYQv+tkSshOsGswX/5P/E0h
	Sf9C/zTfwkR2O1PF4iGfHF9Xf26CPTguBTEsFBUEABXHYhVOLfCMCg00DDy79KaKxbuXov+u1K0
	ueKMm1hxsTam9KYGGu8CWeFox5GZZPfqi8aDZ6wVATna6Ya7RXOPs3hdNlrjBkymkIPUPsFQn66
	097zhZNKW8eANW8aR4O77zWcjFHKBM4n2+V+N8uoeDE8DroPw=
X-Google-Smtp-Source: AGHT+IHZiLjVDcBtpu34HtKQpsXU95AxsuwpwtwuoYwYdbb73g1EDY9XHl177diqZW463qPV3cnI4w==
X-Received: by 2002:a05:6402:254f:b0:649:927c:337c with SMTP id 4fb4d7f45d1cf-64b8eb719c3mr30836637a12.14.1767134525651;
        Tue, 30 Dec 2025 14:42:05 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599844sm36214651a12.25.2025.12.30.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 14:42:04 -0800 (PST)
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
Subject: [PATCH net-next] tls: TLS 1.3 hardware offload support
Date: Tue, 30 Dec 2025 15:41:36 -0700
Message-Id: <20251230224137.3600355-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251230224137.3600355-1-rjethwani@purestorage.com>
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
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
 net/tls/tls_device.c | 48 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 82ea407e520a..7125ada11ea0 100644
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
@@ -1409,12 +1441,22 @@ static struct notifier_block tls_dev_notifier = {
 
 int __init tls_device_init(void)
 {
+	unsigned char *page_addr;
+	int i;
 	int err;
 
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


