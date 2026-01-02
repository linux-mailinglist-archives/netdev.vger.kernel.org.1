Return-Path: <netdev+bounces-246611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96705CEF344
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10A6301635A
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337F3112C4;
	Fri,  2 Jan 2026 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NJzvCtlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5342F9C39
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379698; cv=none; b=deNRfW5T6jNIi1FU0+PpBG7Nr/goeWIs0EPS6VqAwdh3CzOvjxvPdZ94L3US5QUBije/Yndlw7YZGbytbwQunUIYWOhx1sMfJlbylz4t8ys1KAVI+myz8+uCSL2bkGsJTULqDfSGAd8n3EWh8p8Ntblb4/U8Ch6UQcFdThzwxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379698; c=relaxed/simple;
	bh=q1I9JEu9n9+PcGOQTpDgm/Wa7NFebxrmxuV2pKaXO9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mjd/eNAgnq5qa6OVU38zNwhVTQTweuEz74VD3fZUPYfT/6PDlCb+ZadcY3LUw5G4f/YdeF58clEc1E/xHwdU6TugmVyaXu3X/w10Y46rQseNZaqnnKxJ3qLr9rN9RfmuJPk+jCJs1lBBHSeKacLHmhjizzsxtmz1IbisOaXe5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NJzvCtlE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so15557789a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767379694; x=1767984494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJyIPN2m9QCOoFmhuPAJhAHd5n3IKeqeL4uYx6nbwBI=;
        b=NJzvCtlElWiK1Hc4TlCkaFsr5bG9WPhpZbSi9i4O5AFmQnRgjP124GB6uEvJ/hyg+/
         2AcGAbIVscBsDtsGzdo8GKMUJ/jsyQAX6q5iv7eHqCEsVwTmGOexHe9P1evYtuEN3Q4Y
         pcEojiOPI+QtYzIYD8n5Cd9+Vy0pnkrnS5kvtk2xbr+F/9M+8RHP+NysjgVrUghB6cTY
         Bc9GzZcKTPOdh45JubShOtbuLa0aYfcUXnTBToBx7QETaxgbrZdVzteAPnW/s3FK4jEM
         VmauWQoaFJrxf0t/ObXaNOop0E7JXLLue+YOowXg5P4Yf62loUwsZhwVhl/qw/LSVsNY
         vyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379694; x=1767984494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJyIPN2m9QCOoFmhuPAJhAHd5n3IKeqeL4uYx6nbwBI=;
        b=iErg9V203QQ02gOMYppossnmBiJE9tBKtPx/lFH9meziVwtXXOtZdB4mige9pKwtxY
         cervzurKQkq3zXzrww9Y6a2QdqtMZGQ7K75wkidvOxipIK3cly6qcPSDxvLzbo1qpJco
         Z2ANdpUqVg55gDuROcRYUOFKQ9ya1vlieGUfHeMDnDVXCaf9IQ/6xr8d/aqVuLbrf5Zq
         b1vrp2EFmsvMftfkthKp2Jn34GUaZlnl9b6nJcI4s+rFiVu2G7uhJbnP/j30DcyUNI+d
         W9SVNU6lqvL/Oe/z0k5oGbtJ6ArbBxVN1X/4sdhHnszVmLgZlfPBLbiBqoNQBGNySMGo
         pBeA==
X-Gm-Message-State: AOJu0YxezrNJy5AYi0iUrK9mx22JhZK73wd2qtmFguCLbStWEfeghhLJ
	fF/Ic/eN6fKz2NKmQQswL1Ed0tMovQ9UGai8lMeKiR5pTnoPnOIfVZNO/5iPTkRDUBhdCB109aC
	9vLNPgsqkUutEQwUmql5L9WkqyTHmvrg40A/4hyx6rWAiqui0OY96Wme1EYvmb+3Y2OUNJYrG6R
	GyfaX0K3YT99ydbZQTnJ5E57FYLPcm9BxkvT636ThG6k49BxU=
X-Gm-Gg: AY/fxX6mWmRw0ixyDHewkhujWD9/U7XI2mno/3sRYXYLAk4T4SXm0CrMsiipc6g/IJv
	Fcv5oQvnq42pidYaw8Dlyq6i6tsN0eTeyRytnQKqTLFDErlfSJy5+W11SBd3O6M5Gec3Z9NcLRT
	qdJNSgY2k4JEOP8+D6osh5he7qzL+rf3onBGWvDIfbiwePPOVjtozE+YlGDpoz165LC8gk3f9WE
	T/kbM5pwN2V50EV9nLfWLuS3hCgI+oHA6z5guf2hoz8jgbsCZhRNH4GjcG2iARd6awDyblgUFXB
	33AzBd6tnMxr7ZJNNbEaH6TCABU417WbVR2x8L3HTCGvGoxsGmgZDfyg3pUgWEtlDkb4aFuebU7
	LmkaXUF+mwNi8UYFXq2BE7bWz3Nmhb3uHOq+Xlt2SEx0B5ry7XqvLr/DiuLho+Fti+CdJzN3mmi
	prasZzKNrVCuQ1Srn8GbvtXV9BY/rj+Op1NfHl
X-Google-Smtp-Source: AGHT+IGlzpUoVMO3I06356IwF8aomDh3hVowukxohPKi2uSAZyPm9w2huwd1i2nCZvwp8ZxQH/zkBA==
X-Received: by 2002:a05:6402:5194:b0:649:d01e:36cc with SMTP id 4fb4d7f45d1cf-64b8e9473f0mr37461100a12.2.1767379693690;
        Fri, 02 Jan 2026 10:48:13 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494c03sm44625214a12.18.2026.01.02.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:48:12 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v3 1/2] tls: TLS 1.3 hardware offload support
Date: Fri,  2 Jan 2026 11:47:07 -0700
Message-Id: <20260102184708.24618-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260102184708.24618-1-rjethwani@purestorage.com>
References: <20260102184708.24618-1-rjethwani@purestorage.com>
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

The upstream Broadcom bnxt_en driver does not yet support kTLS offload.
Testing was performed using the out-of-tree driver version
bnxt_en-1.10.3-235.1.154.0, which works without modifications.

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


