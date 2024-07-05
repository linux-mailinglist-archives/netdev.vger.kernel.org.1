Return-Path: <netdev+bounces-109359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B901592821D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266E1287583
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92BE1448DF;
	Fri,  5 Jul 2024 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgQnoqJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4817995;
	Fri,  5 Jul 2024 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161041; cv=none; b=Ty0im/uysxg+H5ZVSb6CMFAi8NrahwQpnZNyMOtC7pRcCos/k0nHRrzyXWnAq5UzCUZ6upmHomNc0SesDi7heLdY4tpaXNuZT1bzitXVXyWeg6GAZEtYLUr7mVGEYZpYukrFrlxadKqB3RVfJ8UgDteQFQdr/GtYAZuPrNfjU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161041; c=relaxed/simple;
	bh=58oOxES0lzM392/6H8RgwAqerwHqbbjny/y5448aMuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jM58Yg1TO6Kk27oH2FZjExOQWyNIJZXdr0GW0v56WatgVOHPyyCJR9YIuJ5EhjrcJvQTI9Zg3rzSf7n+jdU0Zla6vXqUzbbSKNGhylT4qjAvFvGlK9E4tqCa9M7dr3zG5orhGXcsj1IKdNPh60PEblwbrhWkMajskX45Ho2q4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgQnoqJn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa2ea1c443so8920955ad.0;
        Thu, 04 Jul 2024 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720161039; x=1720765839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znD+DHZ03Xc1hLW5FfmfP3AjgTz3IHInSXaFKd4zqU4=;
        b=OgQnoqJn0N4hOaiqSwkFDmriuvkhDpKcZY3S9SCd4zJwNlhHc1964zGZbzwfeg2yyR
         MzAyL9Lg7Jsd8GqWlbabeY8gV8axH8SXH95/DUNDid9r+KDKZUMKl5MJZTJNtIjAZAl8
         oaeVFCycFNRk2hc2jnZn1d1pY3Obg3Zbqbk6Rg1xREuqXFOeTU5CjQPL66iYbfSP0Wqk
         R+hQ+420GaTOV9zidqm9md0iU7me8DnBnre4FuFI2a0KXr8vT7RriGoLl8Vsa8XebZ8G
         f8PyFVmNw5/WI+/RRsiJSKm8nm3cmTUD0R2FhmEfoSmV/gspLdiE/ObGBl2+5jCzrwXd
         IITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720161039; x=1720765839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znD+DHZ03Xc1hLW5FfmfP3AjgTz3IHInSXaFKd4zqU4=;
        b=QSHFkzIk6sDOfZCfZsOQk67Pcii/WBu0/8zUwX/EhWrvK1AP6PER6jD520zSLp2jJk
         aek9faxwNLhUYQU/IRxLX/u2sCqKrhj2uNa4NqaV4IFCuxOmX9/ngNfyQVK3JMb1MdA3
         ZYUO+PeSFUSefRWpvFEHouEQCWjgIe4+2SAHFOVkbgmav/fY5xZQwSTtSiah+v/Y1Phb
         AqNYuk+hX1osdQsTRe6iewdivpG/ogocy0kJb84KS9QE+MVuhmP2Kn+PPotqVE258eUy
         KSvKBQY4Qu7rOx6WRsSKOCJRowjcXDtbS7tB86mWmG9bPWE2dU8RUvXP9XJGGeyqMiAd
         Rqcg==
X-Forwarded-Encrypted: i=1; AJvYcCWjMkijNU2PqrF9O4yywoQffUb2k16mnH0GMKCIV1iky7w++F+YiGgByp/+2RTS9uPwvRvmFESK4S/TQyotjEfTIc5xPni6sBUQ8057
X-Gm-Message-State: AOJu0YyX/btPSDq30xDCb6tO/HvdoTw8UJBcgIe+ERlf+phzLLcrn04R
	sR+cqS2IT4nmagQllxJiYsL/FI8eYmUOjebbWFOea/T9PdY/4wYe
X-Google-Smtp-Source: AGHT+IGiekAtzI6KVFfNnBe7S/cylZJ4g2TdGcaP75Xl91oUKJ+AwWvYJL5v9f+jbUZu4wDMKFueRQ==
X-Received: by 2002:a17:902:e751:b0:1fa:ac73:ca28 with SMTP id d9443c01a7336-1fb33e62d7fmr30255415ad.32.1720161039026;
        Thu, 04 Jul 2024 23:30:39 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb44752cf2sm9976255ad.268.2024.07.04.23.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:30:38 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: xgmac: add support for HW-accelerated VLAN stripping
Date: Fri,  5 Jul 2024 14:28:08 +0800
Message-Id: <20240705062808.805071-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN
stripping") introduced MAC level VLAN tag stripping for gmac4 core.
This patch extend the support to xgmac core.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  7 ++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 39 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 19 +++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..db3217784cb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -60,6 +60,10 @@
 #define XGMAC_VLAN_TAG			0x00000050
 #define XGMAC_VLAN_EDVLP		BIT(26)
 #define XGMAC_VLAN_VTHM			BIT(25)
+#define XGMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
+#define XGMAC_VLAN_TAG_CTRL_EVLS	GENMASK(22, 21)
+#define XGMAC_VLAN_TAG_STRIP_NONE	0x0
+#define XGMAC_VLAN_TAG_STRIP_ALL	0x3
 #define XGMAC_VLAN_DOVLTC		BIT(20)
 #define XGMAC_VLAN_ESVL			BIT(18)
 #define XGMAC_VLAN_ETV			BIT(16)
@@ -477,6 +481,7 @@
 #define XGMAC_TDES3_VLTV		BIT(16)
 #define XGMAC_TDES3_VT			GENMASK(15, 0)
 #define XGMAC_TDES3_FL			GENMASK(14, 0)
+#define XGMAC_RDES0_VLAN_TAG		GENMASK(15, 0)
 #define XGMAC_RDES2_HL			GENMASK(9, 0)
 #define XGMAC_RDES3_OWN			BIT(31)
 #define XGMAC_RDES3_CTXT		BIT(30)
@@ -490,6 +495,8 @@
 #define XGMAC_L34T_IP4UDP		0x2
 #define XGMAC_L34T_IP6TCP		0x9
 #define XGMAC_L34T_IP6UDP		0xA
+#define XGMAC_RDES3_L2T			GENMASK(19, 16)
+#define XGMAC_L2T_SINGLE_C_VLAN		0x9
 #define XGMAC_RDES3_ES			BIT(15)
 #define XGMAC_RDES3_PL			GENMASK(13, 0)
 #define XGMAC_RDES3_TSD			BIT(6)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 6a987cf598e4..89ac9ad6164a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1530,6 +1530,41 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *
 	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
 }
 
+static void dwxgmac2_rx_hw_vlan(struct mac_device_info *hw,
+				struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	u16 vid;
+
+	if (!hw->desc->get_rx_vlan_valid(rx_desc))
+		return;
+
+	vid = hw->desc->get_rx_vlan_tci(rx_desc);
+
+	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+}
+
+static void dwxgmac2_set_hw_vlan_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + XGMAC_VLAN_TAG);
+
+	value &= ~XGMAC_VLAN_TAG_CTRL_EVLS;
+
+	if (hw->hw_vlan_en)
+		/* Always strip VLAN on Receive */
+		value |= FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS,
+				    XGMAC_VLAN_TAG_STRIP_ALL);
+	else
+		/* Do not strip VLAN on Receive */
+		value |= FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS,
+				    XGMAC_VLAN_TAG_STRIP_NONE);
+
+	/* Enable outer VLAN Tag in Rx DMA descriptor */
+	value |= XGMAC_VLAN_TAG_CTRL_EVLRXS;
+
+	writel(value, ioaddr + XGMAC_VLAN_TAG);
+}
+
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.set_mac = dwxgmac2_set_mac,
@@ -1571,6 +1606,8 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
+	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1628,6 +1665,8 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
+	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index fc82862a612c..f5293f75fbb4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -67,6 +67,23 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
 }
 
+static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG);
+}
+
+static bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	u32 l2_type;
+
+	if (!(le32_to_cpu(p->des3) & XGMAC_RDES3_LD))
+		return false;
+
+	l2_type = FIELD_GET(XGMAC_RDES3_L2T, le32_to_cpu(p->des3));
+
+	return (l2_type == XGMAC_L2T_SINGLE_C_VLAN);
+}
+
 static int dwxgmac2_get_rx_frame_len(struct dma_desc *p, int rx_coe)
 {
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_PL);
@@ -349,6 +366,8 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_tx_ls = dwxgmac2_get_tx_ls,
+	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
+	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
 	.enable_tx_timestamp = dwxgmac2_enable_tx_timestamp,
 	.get_tx_timestamp_status = dwxgmac2_get_tx_timestamp_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4b6a359e5a94..6f594c455d0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7663,7 +7663,7 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
-- 
2.34.1


