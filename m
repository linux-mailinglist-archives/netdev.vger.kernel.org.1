Return-Path: <netdev+bounces-202348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B8AED77E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FAC7A24E5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25608242D96;
	Mon, 30 Jun 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7OJk7zB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83C1DE4FF;
	Mon, 30 Jun 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272706; cv=none; b=V5N7VPdx5DeiuHAOyTwTl8t2vqT7e75VLV21ha9anG5ecv7KVCzSmiZ48yxXWi90rp3S7fVX9iMBkVwBLQc+69evP+668Q55wyvGsdemRET0R9jigVVHm/0bsDbwv39CsiMs+QbtmWzFzxS45atjb2jW4VHE9+795RbeBSTzq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272706; c=relaxed/simple;
	bh=fOKokE5xSIuSezXDL92+Q446InjaoHoc0T4fTEZ/Fd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDHj2RtQ2Rh1bkdaIXpGfVSfv/ZHbUuA18Rx4njTjVWVEJRFyDqyJwREO6iKIxUz6as5A+O2iFIn/auwgrXEKAt7JuTyeFBcgwpRVcK9fec/grVPpcRvPCUBe1sEs/ScB/dJdWuSI7gyD2GRrGi17ApJ52C4iHihqGMIbBdav1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7OJk7zB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4e62619afso455565f8f.1;
        Mon, 30 Jun 2025 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751272702; x=1751877502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFdfcEftPl4kbBYI2AsD040dwGd/MXL2A6FySR4WqJg=;
        b=O7OJk7zBkH0OE2RFz5Wf2SObaxW6+bpZ+qrKwkGB9sTy37VsSrnxBC6mwMFxKaj0PB
         Hxpvhq/j7xWmwYxlxLyOJuUCdNxSAD8CnjdTP0nNJUb5qNzliZsI4A8kO3j40rz0xxoG
         Ta+ydBndjlzkqNArqOMUTwi4GFmUJNfxEn+NurR5buS5LigUuu/qvi6m72SJHdwJ1ug6
         auyYfpaGlRdvJVXfLiTLMTZdTiR+cJlTS2kOmtAuMfisYhWSrVbpD2hd6ie5JQJ5py3+
         5okFVImN9mkYRJXq/0KH0et/J0JpLAAwH5DY/GauvY10nc67KbKW7ZNEobGYa/jZs0bO
         4FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272702; x=1751877502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFdfcEftPl4kbBYI2AsD040dwGd/MXL2A6FySR4WqJg=;
        b=ElQAv90EmpaLDSTANyYXJJRszO0DAXxJVSH0MxTXTg8IFKhc7Sf9MIFSVb6NyknzVe
         BpfQuA0ubpkmzGcUZ7xtdYBgwKzk/ndThc7xlvpd0eAK7gNVu4muowoCAJAKtOsFt1df
         3VYi0UrqjCLri6EaAKBYt5poDiO0e5xIgTM4Qj9t1so+PRTHsi9Ds2jGFNLlRJVsxZ/L
         R99T8zu6UE2ECk9b5N5AbeNbOVsX613JMjg5nzPD0LYuLW1eCbCxPdS7ZOdVZrgqJ6X6
         M3Ga5hyAPlWW4WUwOeXZkZK0MSlqbLth9CtYrU9mTnzhWGbPSbOPtg9LJ9c2Be1ZrAaX
         z5/w==
X-Forwarded-Encrypted: i=1; AJvYcCUoyP+nCGtBOcYOli1R9a0IwCbcVVkhqlW++NQI30S3rRkLh87oGI0LOw+Myn6RTFn8dx1NmA+xTbJGF0w=@vger.kernel.org, AJvYcCXtL5xKZS+AEJggNBmWJpkcGcJuKX6P08rtgxBAQg+iyML3C5Ur8RLoOIB6uNXmcbtJmziHW/Fd@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHjjDymMrqVdiQ5HLo16z8H1pFhwd6sybUwPRk1HoVPyp7pWO
	aGf8nPJdQo9LNxWvMXCxqQQJ67GobAv1xz999l75QgehYE4zxHZTWNNN
X-Gm-Gg: ASbGncswcfxc/+VuKisQm9+R0IKzkZjEw4+htM3MG1Iz+Wm1f1ZE0EdvBID8pzL/kMp
	q4YcKy9b9qZCuR/2dFVsIShsuQNl2qwYVTgdcnJa6Sqe3MMC/OBJ2oFt1wHwYz6Pn2GXWH1BgFn
	vpoPI/hr0kj1xJPnkBGuUDbuL0+lM/OuavFnFWjwVJsQYdxVadDhng9Y/XSU1urNASH3xgXpJcu
	bI+RBZ3TTEB57WLIB7iBQ7fimM29yaCuGBrCY3VYIqN8sjmh7CsWmKt7MHj0nS2OVakBaqg6/Te
	NyeHv/4po160X/LgilUTyzODPVrlIde3CSDAN8Oty7LY3g7JWDCk3Rq90kCqiitoKXwO4+VKAOv
	YidfMPH1umsnoQOEskkf6pp8EbQ==
X-Google-Smtp-Source: AGHT+IEvKJqj/TVkGPGZ7v2Ha99spyvgOhQJ0B2GO5apmK6qXsAj7Vj46oKjzqw7IdEg+Na1JMjhHg==
X-Received: by 2002:a05:600d:7:b0:43d:fa58:81d2 with SMTP id 5b1f17b1804b1-4539585f938mr22180605e9.9.1751272701911;
        Mon, 30 Jun 2025 01:38:21 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:234c:3c9a:efe4:2b60])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c800eaasm9946144f8f.37.2025.06.30.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:38:21 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Currier <dullfire@yahoo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nui: Fix dma_mapping_error() check
Date: Mon, 30 Jun 2025 10:36:43 +0200
Message-ID: <20250630083650.47392-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_map_XXX() functions return values DMA_MAPPING_ERROR as error values
which is often ~0.  The error value should be tested with
dma_mapping_error().

This patch creates a new function in niu_ops to test if the mapping
failed.  The test is fixed in niu_rbr_add_page(), added in
niu_start_xmit() and the successfully mapped pages are unmaped upon error.

Fixes: ec2deec1f352 ("niu: Fix to check for dma mapping errors.")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 31 ++++++++++++++++++++++++++++++-
 drivers/net/ethernet/sun/niu.h |  4 ++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index ddca8fc7883e..26119d02a94d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3336,7 +3336,7 @@ static int niu_rbr_add_page(struct niu *np, struct rx_ring_info *rp,
 
 	addr = np->ops->map_page(np->device, page, 0,
 				 PAGE_SIZE, DMA_FROM_DEVICE);
-	if (!addr) {
+	if (np->ops->mapping_error(np->device, addr)) {
 		__free_page(page);
 		return -ENOMEM;
 	}
@@ -6676,6 +6676,8 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 	len = skb_headlen(skb);
 	mapping = np->ops->map_single(np->device, skb->data,
 				      len, DMA_TO_DEVICE);
+	if (np->ops->mapping_error(np->device, mapping))
+		goto out_drop;
 
 	prod = rp->prod;
 
@@ -6717,6 +6719,8 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 		mapping = np->ops->map_page(np->device, skb_frag_page(frag),
 					    skb_frag_off(frag), len,
 					    DMA_TO_DEVICE);
+		if (np->ops->mapping_error(np->device, mapping))
+			goto out_unmap;
 
 		rp->tx_buffs[prod].skb = NULL;
 		rp->tx_buffs[prod].mapping = mapping;
@@ -6741,6 +6745,19 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 out:
 	return NETDEV_TX_OK;
 
+out_unmap:
+	while (i--) {
+		const skb_frag_t *frag;
+
+		prod = PREVIOUS_TX(rp, prod);
+		frag = &skb_shinfo(skb)->frags[i];
+		np->ops->unmap_page(np->device, rp->tx_buffs[prod].mapping,
+				    skb_frag_size(frag), DMA_TO_DEVICE);
+	}
+
+	np->ops->unmap_single(np->device, rp->tx_buffs[rp->prod].mapping,
+			      skb_headlen(skb), DMA_TO_DEVICE);
+
 out_drop:
 	rp->tx_errors++;
 	kfree_skb(skb);
@@ -9644,6 +9661,11 @@ static void niu_pci_unmap_single(struct device *dev, u64 dma_address,
 	dma_unmap_single(dev, dma_address, size, direction);
 }
 
+static int niu_pci_mapping_error(struct device *dev, u64 addr)
+{
+	return dma_mapping_error(dev, addr);
+}
+
 static const struct niu_ops niu_pci_ops = {
 	.alloc_coherent	= niu_pci_alloc_coherent,
 	.free_coherent	= niu_pci_free_coherent,
@@ -9651,6 +9673,7 @@ static const struct niu_ops niu_pci_ops = {
 	.unmap_page	= niu_pci_unmap_page,
 	.map_single	= niu_pci_map_single,
 	.unmap_single	= niu_pci_unmap_single,
+	.mapping_error	= niu_pci_mapping_error,
 };
 
 static void niu_driver_version(void)
@@ -10019,6 +10042,11 @@ static void niu_phys_unmap_single(struct device *dev, u64 dma_address,
 	/* Nothing to do.  */
 }
 
+static int niu_phys_mapping_error(struct device *dev, u64 dma_address)
+{
+	return false;
+}
+
 static const struct niu_ops niu_phys_ops = {
 	.alloc_coherent	= niu_phys_alloc_coherent,
 	.free_coherent	= niu_phys_free_coherent,
@@ -10026,6 +10054,7 @@ static const struct niu_ops niu_phys_ops = {
 	.unmap_page	= niu_phys_unmap_page,
 	.map_single	= niu_phys_map_single,
 	.unmap_single	= niu_phys_unmap_single,
+	.mapping_error	= niu_phys_mapping_error,
 };
 
 static int niu_of_probe(struct platform_device *op)
diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/niu.h
index 04c215f91fc0..0b169c08b0f2 100644
--- a/drivers/net/ethernet/sun/niu.h
+++ b/drivers/net/ethernet/sun/niu.h
@@ -2879,6 +2879,9 @@ struct tx_ring_info {
 #define NEXT_TX(tp, index) \
 	(((index) + 1) < (tp)->pending ? ((index) + 1) : 0)
 
+#define PREVIOUS_TX(tp, index) \
+	(((index) - 1) >= 0 ? ((index) - 1) : (((tp)->pending) - 1))
+
 static inline u32 niu_tx_avail(struct tx_ring_info *tp)
 {
 	return (tp->pending -
@@ -3140,6 +3143,7 @@ struct niu_ops {
 			  enum dma_data_direction direction);
 	void (*unmap_single)(struct device *dev, u64 dma_address,
 			     size_t size, enum dma_data_direction direction);
+	int (*mapping_error)(struct device *dev, u64 dma_address);
 };
 
 struct niu_link_config {
-- 
2.43.0


