Return-Path: <netdev+bounces-172560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2AA556A2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6433F188BF8A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFCF277029;
	Thu,  6 Mar 2025 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USmf5/S0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3727811B;
	Thu,  6 Mar 2025 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289255; cv=none; b=MzMj0TvC9u3DVsn7w0OssLiS7i4YEzaFPn749i6iMmH7BEONe9E6v93EKjkjsuascThrWCkP5TD/kCXlUOp3Spu8/ZP2ka0JMlipV0olnalfdHRu5EfDi00fyA0Tl3dTJlkcqlJfxQidMJPKnx7UPJ17dhUP0tgxzVMyscm22L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289255; c=relaxed/simple;
	bh=kjA71fy6mh2ees/0jhzGlrJmXvW4XDk0l4lvY2vJHnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyfwNOr/EWJWBpYQfmB3OYM7Z7CH3vzOcqTQA5pb9aHlUVHjBl8nQ20TLMZiZp6m+TlJ1z24Zf77FAKhxndh5pC7ynOT0Nf8TAYIYaC2zSeOfFnfMr4Lhn6zyanetF54MuZu2RRvYnGAJSnlwrFlDYfBx87S+oQGcaXqwaIwvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USmf5/S0; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7272f9b4132so625867a34.0;
        Thu, 06 Mar 2025 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289253; x=1741894053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boA8fKjCvOM7DRAOKKbkjm2FTl7v7G66pyKNtHMRT0A=;
        b=USmf5/S08QPC2BjlXxokFm225k8W4DFgaObYAaWiGRl/aip96dzBaWOSC1bgOOIA8d
         Pi49YccUPY7vEGzlK9WeTos1By4gGf243QPr1A1JhSrR1zDFPvV8NegxbdTT9dz1DRUD
         1JHant/gEfX3Dy1K2YYJPH/xVPGUhzVPhLDhwVlIjJC3q8QuZ8M76PEftXrWhUw24r0t
         ZQ2b0Eh7S16PxHtCx04w6FpfEDKwrXyc5IQOV/ebyMTPKB663JWjNWfNeIiL/diPSa17
         9POtrASsJ4C/MEP7gkBc/9x/9R3nHT7bTdSUW7GaRnZB+Q0aeVwF0yNUmcdJ2p7lCcLV
         cnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289253; x=1741894053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boA8fKjCvOM7DRAOKKbkjm2FTl7v7G66pyKNtHMRT0A=;
        b=AcERwz1qoBrOUY1l6HgFmiBxJ71cNSpicPuIOJtETDK08HUqTkZ+7MM+MjOIi3h3eC
         W4iuVDOTwSesBxQ1UyqAdFHZwQh6wEQadgrW+3MyCQD0EfKOT/M+VMIYalXK3nZwbLKo
         GHTaZfgUBchkn9StqQrQFLCx5hsXRoOz0FW9OJTLiA5xGls4AK3GA4rKA2FTtn6HQWCU
         iVvsTKyIXuKfgjrjELxgHB2Z4oKt1s/c8PrvZFCxsvYJ+YMfJkgcD/fxoznbGIUOivan
         yfL2yoFJb6Bz14jxBCHegykjXrUPCAijgnOFAwAlKQds3rQPMJMvtcL/oB17dEu8CKk5
         l7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXBIFuLLPZdIZbgPQWeEU6JW4QsGrcYPSnmIilBinNp03yPuh544gEDTwQ8uaGEQMVSNl9tanHZ7G/7KLI=@vger.kernel.org, AJvYcCXKl2kPCnhKEXiMNFmS6TQJqwheHLCAV6JLMVrep2vOZol02GHAYF8x2GL3oCx7ulZk+i0nVCnF@vger.kernel.org
X-Gm-Message-State: AOJu0YxXg4B6aAy/Ty9Hg7nRoHdmVFq1l+X/ZpBMICRk/4FxrLCNegqT
	S58OquOgAfTjW4R21i02rl0QfIaH/L5Lq60k5wptSdjfRNUYfFVswZKe5g==
X-Gm-Gg: ASbGnctvrPPrREZdNbYUYtKn/xEJGa5zaxSpWoFJLJogOyY/bBa7mI0YYrn/ghtggSX
	Idp/dUYXCppNxEJ1R926iKbs3dUZlGOksztXhxTE19BSRcdlSUJrGVxd90u3KzYdsFsEZbaJEXv
	bCDOYTn7kqdIYtF+SEvvwqfsHylMITAaqJohqlw0j4LhWVI0ZmHdx1Pxw4p22hx56LF0ch1KYMP
	3CFx9693XYaZ7LRCrKOruviYsDR0QjJN8Z1FRSVbR/k5jptzLjEOlfZeTt+Kh45MBPj56mET/jI
	XSXTM0D1OttecYdONINhgju0O8Hw7GW+bA0s5F2MmSVemf3+3xlyxLBShDoR6O4b7w9v6C5c3up
	pUWYOWW3qELQL
X-Google-Smtp-Source: AGHT+IHxEYyC3Ps1XhQT6cEiMwnDoomoATFDl752jNe5PbKrTBPR8pg/FjVYh01eW2ITw7L6v87WWA==
X-Received: by 2002:a05:6830:dcb:b0:727:11be:f4ae with SMTP id 46e09a7af769-72a37b3eca3mr257271a34.3.1741289252513;
        Thu, 06 Mar 2025 11:27:32 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:31 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 05/14] net: bcmgenet: extend bcmgenet_hfb_* API
Date: Thu,  6 Mar 2025 11:26:33 -0800
Message-Id: <20250306192643.2383632-6-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the bcmgenet_hfb_* API to allow initialization and
programming of the Hardware Filter Block on GENET v1 and
GENET v2 hardware. Programming of ethtool flows is still
not supported on this older hardware.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 94 +++++++++++--------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e6b2a0499edb..9aeb1133ffa1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -446,33 +446,48 @@ static void bcmgenet_hfb_enable_filter(struct bcmgenet_priv *priv, u32 f_index)
 	u32 offset;
 	u32 reg;
 
-	offset = HFB_FLT_ENABLE_V3PLUS + (f_index < 32) * sizeof(u32);
-	reg = bcmgenet_hfb_reg_readl(priv, offset);
-	reg |= (1 << (f_index % 32));
-	bcmgenet_hfb_reg_writel(priv, reg, offset);
-	reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
-	reg |= RBUF_HFB_EN;
-	bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+	if (GENET_IS_V1(priv) || GENET_IS_V2(priv)) {
+		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+		reg |= (1 << ((f_index % 32) + RBUF_HFB_FILTER_EN_SHIFT)) |
+			RBUF_HFB_EN;
+		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+	} else {
+		offset = HFB_FLT_ENABLE_V3PLUS + (f_index < 32) * sizeof(u32);
+		reg = bcmgenet_hfb_reg_readl(priv, offset);
+		reg |= (1 << (f_index % 32));
+		bcmgenet_hfb_reg_writel(priv, reg, offset);
+		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+		reg |= RBUF_HFB_EN;
+		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+	}
 }
 
 static void bcmgenet_hfb_disable_filter(struct bcmgenet_priv *priv, u32 f_index)
 {
 	u32 offset, reg, reg1;
 
-	offset = HFB_FLT_ENABLE_V3PLUS;
-	reg = bcmgenet_hfb_reg_readl(priv, offset);
-	reg1 = bcmgenet_hfb_reg_readl(priv, offset + sizeof(u32));
-	if  (f_index < 32) {
-		reg1 &= ~(1 << (f_index % 32));
-		bcmgenet_hfb_reg_writel(priv, reg1, offset + sizeof(u32));
-	} else {
-		reg &= ~(1 << (f_index % 32));
-		bcmgenet_hfb_reg_writel(priv, reg, offset);
-	}
-	if (!reg && !reg1) {
+	if (GENET_IS_V1(priv) || GENET_IS_V2(priv)) {
 		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
-		reg &= ~RBUF_HFB_EN;
+		reg &= ~(1 << ((f_index % 32) + RBUF_HFB_FILTER_EN_SHIFT));
+		if (!(reg & RBUF_HFB_FILTER_EN_MASK))
+			reg &= ~RBUF_HFB_EN;
 		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+	} else {
+		offset = HFB_FLT_ENABLE_V3PLUS;
+		reg = bcmgenet_hfb_reg_readl(priv, offset);
+		reg1 = bcmgenet_hfb_reg_readl(priv, offset + sizeof(u32));
+		if  (f_index < 32) {
+			reg1 &= ~(1 << (f_index % 32));
+			bcmgenet_hfb_reg_writel(priv, reg1, offset + sizeof(u32));
+		} else {
+			reg &= ~(1 << (f_index % 32));
+			bcmgenet_hfb_reg_writel(priv, reg, offset);
+		}
+		if (!reg && !reg1) {
+			reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+			reg &= ~RBUF_HFB_EN;
+			bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
+		}
 	}
 }
 
@@ -482,6 +497,9 @@ static void bcmgenet_hfb_set_filter_rx_queue_mapping(struct bcmgenet_priv *priv,
 	u32 offset;
 	u32 reg;
 
+	if (GENET_IS_V1(priv) || GENET_IS_V2(priv))
+		return;
+
 	offset = f_index / 8;
 	reg = bcmgenet_rdma_readl(priv, DMA_INDEX2RING_0 + offset);
 	reg &= ~(0xF << (4 * (f_index % 8)));
@@ -495,9 +513,13 @@ static void bcmgenet_hfb_set_filter_length(struct bcmgenet_priv *priv,
 	u32 offset;
 	u32 reg;
 
-	offset = HFB_FLT_LEN_V3PLUS +
-		 ((priv->hw_params->hfb_filter_cnt - 1 - f_index) / 4) *
-		 sizeof(u32);
+	if (GENET_IS_V1(priv) || GENET_IS_V2(priv))
+		offset = HFB_FLT_LEN_V2;
+	else
+		offset = HFB_FLT_LEN_V3PLUS;
+
+	offset += sizeof(u32) *
+		  ((priv->hw_params->hfb_filter_cnt - 1 - f_index) / 4);
 	reg = bcmgenet_hfb_reg_readl(priv, offset);
 	reg &= ~(0xFF << (8 * (f_index % 4)));
 	reg |= ((f_length & 0xFF) << (8 * (f_index % 4)));
@@ -690,6 +712,7 @@ static void bcmgenet_hfb_clear_filter(struct bcmgenet_priv *priv, u32 f_index)
 {
 	u32 base, i;
 
+	bcmgenet_hfb_set_filter_length(priv, f_index, 0);
 	base = f_index * priv->hw_params->hfb_filter_size;
 	for (i = 0; i < priv->hw_params->hfb_filter_size; i++)
 		bcmgenet_hfb_writel(priv, 0x0, (base + i) * sizeof(u32));
@@ -699,19 +722,16 @@ static void bcmgenet_hfb_clear(struct bcmgenet_priv *priv)
 {
 	u32 i;
 
-	if (GENET_IS_V1(priv) || GENET_IS_V2(priv))
-		return;
-
-	bcmgenet_hfb_reg_writel(priv, 0x0, HFB_CTRL);
-	bcmgenet_hfb_reg_writel(priv, 0x0, HFB_FLT_ENABLE_V3PLUS);
-	bcmgenet_hfb_reg_writel(priv, 0x0, HFB_FLT_ENABLE_V3PLUS + 4);
-
-	for (i = DMA_INDEX2RING_0; i <= DMA_INDEX2RING_7; i++)
-		bcmgenet_rdma_writel(priv, 0x0, i);
+	bcmgenet_hfb_reg_writel(priv, 0, HFB_CTRL);
 
-	for (i = 0; i < (priv->hw_params->hfb_filter_cnt / 4); i++)
-		bcmgenet_hfb_reg_writel(priv, 0x0,
-					HFB_FLT_LEN_V3PLUS + i * sizeof(u32));
+	if (!GENET_IS_V1(priv) && !GENET_IS_V2(priv)) {
+		bcmgenet_hfb_reg_writel(priv, 0,
+					HFB_FLT_ENABLE_V3PLUS);
+		bcmgenet_hfb_reg_writel(priv, 0,
+					HFB_FLT_ENABLE_V3PLUS + 4);
+		for (i = DMA_INDEX2RING_0; i <= DMA_INDEX2RING_7; i++)
+			bcmgenet_rdma_writel(priv, 0, i);
+	}
 
 	for (i = 0; i < priv->hw_params->hfb_filter_cnt; i++)
 		bcmgenet_hfb_clear_filter(priv, i);
@@ -722,9 +742,6 @@ static void bcmgenet_hfb_init(struct bcmgenet_priv *priv)
 	int i;
 
 	INIT_LIST_HEAD(&priv->rxnfc_list);
-	if (GENET_IS_V1(priv) || GENET_IS_V2(priv))
-		return;
-
 	for (i = 0; i < MAX_NUM_OF_FS_RULES; i++) {
 		INIT_LIST_HEAD(&priv->rxnfc_rules[i].list);
 		priv->rxnfc_rules[i].state = BCMGENET_RXNFC_STATE_UNUSED;
@@ -3735,8 +3752,10 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v1 = {
 	.bp_in_en_shift = 16,
 	.bp_in_mask = 0xffff,
 	.hfb_filter_cnt = 16,
+	.hfb_filter_size = 64,
 	.qtag_mask = 0x1F,
 	.hfb_offset = 0x1000,
+	.hfb_reg_offset = GENET_RBUF_OFF + RBUF_HFB_CTRL_V1,
 	.rdma_offset = 0x2000,
 	.tdma_offset = 0x3000,
 	.words_per_bd = 2,
@@ -3750,6 +3769,7 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v2 = {
 	.bp_in_en_shift = 16,
 	.bp_in_mask = 0xffff,
 	.hfb_filter_cnt = 16,
+	.hfb_filter_size = 64,
 	.qtag_mask = 0x1F,
 	.tbuf_offset = 0x0600,
 	.hfb_offset = 0x1000,
-- 
2.34.1


