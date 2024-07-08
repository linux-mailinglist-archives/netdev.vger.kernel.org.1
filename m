Return-Path: <netdev+bounces-109774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B133929E38
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815201F227D5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E9374C2;
	Mon,  8 Jul 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEsyKfIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A429CE8;
	Mon,  8 Jul 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426979; cv=none; b=QfF0vThJT/mPo47tyDrNfrhit1iROhWqXoTw0jsp6oNXA4aqoV8PyxdSzmxRipN95Nmr+4sfyygo9n5nBY/Rf/KfKAACF+QpNiZGXHS5OIJcEycEcvNnaZwLqX7Tubu0mzsuAIplyvFzxpXTExE/57Rw5PtyB80okNS+a59WCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426979; c=relaxed/simple;
	bh=lWsXWFZeh9kyGpEfA9XQGwP4qVbvEBjJStJiqRow9+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ta579CFmcG/K1aeoSl/u2iY1EEQdzx0OMitel0xFJFVt4lKRqsGanNC+bzOmJ5MnqfW9Ow3yVxSSkONCc3dZnDGUcUKfy7gdDQ0gXIieuGxOjF2pda+PUAkTMd/mk89+O5efBc8TufLaogv1sb+ojJ/2xP/DQcPs6tPos3FiStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEsyKfIp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb1c918860so30302495ad.1;
        Mon, 08 Jul 2024 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720426976; x=1721031776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib8ofPhHLLfeRsP8kdgypeNM8tmnRpEj607PjY7Rd3M=;
        b=jEsyKfIpzMx0zcFWByswSNfJKgcqmo4JpUBKJGhkzBchsdggbbIk2XHIcPE/2f0zf/
         ckcoD42e8lk2kb0UqpVVoVmtTjS1uDrb673OcQQjHbzejGpCzx+URS+2xVt+jvVfxQrv
         HoT696GvztvLRzdAN9xm+eXd/lIUXeLuIHOaW2t5Yv9Ai0WxxU32v8kfWlTZZCp2r91l
         X39obAyOyZYlvWfJ9yIy1AwlIdA7IsJslhbqezas417ayImFuHdXEBiCESsWpP7C6t0c
         MUELTI0XjyIhlKm0me1XaHSLu+U3YHZqlKEEjE46i602mkmaSP/YJJn/hglmH0bK41jw
         udZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426976; x=1721031776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib8ofPhHLLfeRsP8kdgypeNM8tmnRpEj607PjY7Rd3M=;
        b=HOOpqoQJLHL4SnEnKlsZHzXbhzU/F2vQCxPyAR3ZSLKL03SsUN8+0UJqLz53dUm0uA
         3zeDewNe2SD1BAeCzAT/zN3II9BUfMe8dboN1BGKkH1HzxjdstRaEOrsVelon88AY7Br
         U/tp6Pr3gWTQ4gZItyobbG+1T3YrKzLNsS6Q8IGb1SolDnKRG0DM54XvlLjkv9vphlzn
         oSI8FfOIFn7AaYcR2T/M8cjj3O8+NBW65JtT/JE9B6MPYslFnhPQQfg66GaPWS+m0Ep1
         kYYBGj6mRfewi4T5cyUenfdsKx0/7E07Mvn1/CHj/09F04+Ei/9VYqhV2ikKn7/cMoa3
         P/yg==
X-Forwarded-Encrypted: i=1; AJvYcCVZiIDXO6994BgrHNSYm3mtjrIPngzdpOu84XOUkQ7lQaVT1vwEmhoknf7O1iRbajfswGm32XLq20Q+Y9l2p1BizjjbH5D27kpZLJnf
X-Gm-Message-State: AOJu0YxaoB8duyUd5dlagTvHFIRMPHiEV1qevhUsTaPOKLnA/gxTO0Pf
	OLDDOMnzi1VgYfmQkr20EMyJD3tmtBkcFkSwANrciA4AYLNmU3yG
X-Google-Smtp-Source: AGHT+IGu8guYBZ2ZxvyuhFcJKpmwc+cwme7aqTFq6u5iyJ9A3LBK3hCoBIllOBOy6ISebDTbVp0TVg==
X-Received: by 2002:a17:903:1c2:b0:1fb:4215:d9d9 with SMTP id d9443c01a7336-1fb4215e4bcmr164256275ad.6.1720426975966;
        Mon, 08 Jul 2024 01:22:55 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb3b317cf9sm70272225ad.126.2024.07.08.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 01:22:55 -0700 (PDT)
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
Subject: [PATCH net-next v1] net: stmmac: Refactor Frame Preemption(FPE) implementation
Date: Mon,  8 Jul 2024 16:22:20 +0800
Message-Id: <20240708082220.877141-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor FPE implementation by moving common code for DWMAC4 and
DWXGMAC into a separate FPE module.

FPE implementation for DWMAC4 and DWXGMAC differs only for:
1) Offset address of MAC_FPE_CTRL_STS
2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1

Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  6 --
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 66 --------------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  | 16 ----
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  9 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 27 ------
 drivers/net/ethernet/stmicro/stmmac/hwif.c    | 20 ++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 31 ++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 90 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  | 16 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  3 +-
 14 files changed, 157 insertions(+), 152 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..7e46dca90628 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index cd36ff4da68c..73c145dda11a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -591,6 +591,7 @@ struct mac_device_info {
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
+	const struct stmmac_fpe_ops *fpe;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index dbd9f93b2460..1505ac738b13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1265,9 +1265,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.fpe_configure = dwmac5_fpe_configure,
-	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
-	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1317,9 +1314,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.fpe_configure = dwmac5_fpe_configure,
-	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
-	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e02cebc3f1b7..1c431b918719 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -572,69 +572,3 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 	writel(val, ioaddr + MAC_PPS_CONTROL);
 	return 0;
 }
-
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
-			  bool enable)
-{
-	u32 value;
-
-	if (enable) {
-		cfg->fpe_csr = EFPE;
-		value = readl(ioaddr + GMAC_RXQ_CTRL1);
-		value &= ~GMAC_RXQCTRL_FPRQ;
-		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-		writel(value, ioaddr + GMAC_RXQ_CTRL1);
-	} else {
-		cfg->fpe_csr = 0;
-	}
-	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
-}
-
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
-{
-	u32 value;
-	int status;
-
-	status = FPE_EVENT_UNKNOWN;
-
-	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
-	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
-	 */
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (value & TRSP) {
-		status |= FPE_EVENT_TRSP;
-		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
-	}
-
-	if (value & TVER) {
-		status |= FPE_EVENT_TVER;
-		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
-	}
-
-	if (value & RRSP) {
-		status |= FPE_EVENT_RRSP;
-		netdev_info(dev, "FPE: Respond mPacket is received\n");
-	}
-
-	if (value & RVER) {
-		status |= FPE_EVENT_RVER;
-		netdev_info(dev, "FPE: Verify mPacket is received\n");
-	}
-
-	return status;
-}
-
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			     enum stmmac_mpacket_type type)
-{
-	u32 value = cfg->fpe_csr;
-
-	if (type == MPACKET_VERIFY)
-		value |= SVER;
-	else if (type == MPACKET_RESPONSE)
-		value |= SRSP;
-
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
-}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index bf33a51d229e..00b151b3b688 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -11,15 +11,6 @@
 #define PRTYEN				BIT(1)
 #define TMOUTEN				BIT(0)
 
-#define MAC_FPE_CTRL_STS		0x00000234
-#define TRSP				BIT(19)
-#define TVER				BIT(18)
-#define RRSP				BIT(17)
-#define RVER				BIT(16)
-#define SRSP				BIT(2)
-#define SVER				BIT(1)
-#define EFPE				BIT(0)
-
 #define MAC_PPS_CONTROL			0x00000b70
 #define PPS_MAXIDX(x)			((((x) + 1) * 8) - 1)
 #define PPS_MINIDX(x)			((x) * 8)
@@ -102,12 +93,5 @@ int dwmac5_rxp_config(void __iomem *ioaddr, struct stmmac_tc_entry *entries,
 int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 			   struct stmmac_pps_cfg *cfg, bool enable,
 			   u32 sub_second_inc, u32 systime_flags);
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
-			  bool enable);
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
-			     struct stmmac_fpe_cfg *cfg,
-			     enum stmmac_mpacket_type type);
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..f359d70beb83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,8 +84,8 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
-#define XGMAC_RQ_SHIFT			4
+#define XGMAC_FPRQ			GENMASK(7, 4)
+#define XGMAC_FPRQ_SHIFT		4
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
@@ -96,10 +96,11 @@
 #define XGMAC_LPIIS			BIT(5)
 #define XGMAC_PMTIS			BIT(4)
 #define XGMAC_INT_EN			0x000000b4
+#define XGMAC_FPEIE			BIT(15)
 #define XGMAC_TSIE			BIT(12)
 #define XGMAC_LPIIE			BIT(5)
 #define XGMAC_PMTIE			BIT(4)
-#define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE)
+#define XGMAC_INT_DEFAULT_EN		(XGMAC_FPEIE | XGMAC_LPIIE | XGMAC_PMTIE)
 #define XGMAC_Qx_TX_FLOW_CTRL(x)	(0x00000070 + (x) * 4)
 #define XGMAC_PT			GENMASK(31, 16)
 #define XGMAC_PT_SHIFT			16
@@ -193,8 +194,6 @@
 #define XGMAC_MDIO_ADDR			0x00000200
 #define XGMAC_MDIO_DATA			0x00000204
 #define XGMAC_MDIO_C22P			0x00000220
-#define XGMAC_FPE_CTRL_STS		0x00000280
-#define XGMAC_EFPE			BIT(0)
 #define XGMAC_ADDRx_HIGH(x)		(0x00000300 + (x) * 0x8)
 #define XGMAC_ADDR_MAX			32
 #define XGMAC_AE			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 6a987cf598e4..e5bc3957041e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1505,31 +1505,6 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-				   u32 num_txq,
-				   u32 num_rxq, bool enable)
-{
-	u32 value;
-
-	if (!enable) {
-		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-
-		value &= ~XGMAC_EFPE;
-
-		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-		return;
-	}
-
-	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &= ~XGMAC_RQ;
-	value |= (num_rxq - 1) << XGMAC_RQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
-
-	value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |= XGMAC_EFPE;
-	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-}
-
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.set_mac = dwxgmac2_set_mac,
@@ -1570,7 +1545,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1627,7 +1601,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
-	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 29367105df54..8c8527ffc7f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -8,6 +8,7 @@
 #include "stmmac.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
+#include "stmmac_fpe.h"
 
 static u32 stmmac_get_id(struct stmmac_priv *priv, u32 id_reg)
 {
@@ -116,6 +117,7 @@ static const struct stmmac_hwif_entry {
 	const void *tc;
 	const void *mmc;
 	const void *est;
+	const void *fpe;
 	int (*setup)(struct stmmac_priv *priv);
 	int (*quirks)(struct stmmac_priv *priv);
 } stmmac_hw[] = {
@@ -205,6 +207,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
+			.fpe_off = FPE_CTRL_STS_GMAC4_OFFSET,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
@@ -214,6 +217,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwmac_fpe_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
@@ -225,6 +229,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
+			.fpe_off = FPE_CTRL_STS_GMAC4_OFFSET,
 		},
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
@@ -234,6 +239,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwmac_fpe_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
@@ -246,6 +252,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
 			.est_off = EST_XGMAC_OFFSET,
+			.fpe_off = FPE_CTRL_STS_XGMAC_OFFSET,
 		},
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
@@ -255,6 +262,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwmac_fpe_ops,
 		.setup = dwxgmac2_setup,
 		.quirks = NULL,
 	}, {
@@ -267,6 +275,7 @@ static const struct stmmac_hwif_entry {
 			.ptp_off = PTP_XGMAC_OFFSET,
 			.mmc_off = MMC_XGMAC_OFFSET,
 			.est_off = EST_XGMAC_OFFSET,
+			.fpe_off = FPE_CTRL_STS_XGMAC_OFFSET,
 		},
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
@@ -276,6 +285,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwmac_fpe_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
 	},
@@ -310,10 +320,13 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		(needs_gmac4 ? PTP_GMAC4_OFFSET : PTP_GMAC3_X_OFFSET);
 	priv->mmcaddr = priv->ioaddr +
 		(needs_gmac4 ? MMC_GMAC4_OFFSET : MMC_GMAC3_X_OFFSET);
-	if (needs_gmac4)
+	if (needs_gmac4) {
 		priv->estaddr = priv->ioaddr + EST_GMAC4_OFFSET;
-	else if (needs_xgmac)
+		priv->fpeaddr = priv->ioaddr + FPE_CTRL_STS_GMAC4_OFFSET;
+	} else if (needs_xgmac) {
 		priv->estaddr = priv->ioaddr + EST_XGMAC_OFFSET;
+		priv->fpeaddr = priv->ioaddr + FPE_CTRL_STS_XGMAC_OFFSET;
+	}
 
 	/* Check for HW specific setup first */
 	if (priv->plat->setup) {
@@ -351,12 +364,15 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
 		mac->est = mac->est ? : entry->est;
+		mac->fpe = mac->fpe ? : entry->fpe;
 
 		priv->hw = mac;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
 		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
 		if (entry->est)
 			priv->estaddr = priv->ioaddr + entry->regs.est_off;
+		if (entry->fpe)
+			priv->fpeaddr = priv->ioaddr + entry->regs.fpe_off;
 
 		/* Entry found */
 		if (needs_setup) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 97934ccba5b1..4d80892f6885 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -418,13 +418,6 @@ struct stmmac_ops {
 				bool en, bool udp, bool sa, bool inv,
 				u32 match);
 	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
-	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			      u32 num_txq, u32 num_rxq,
-			      bool enable);
-	void (*fpe_send_mpacket)(void __iomem *ioaddr,
-				 struct stmmac_fpe_cfg *cfg,
-				 enum stmmac_mpacket_type type);
-	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -523,12 +516,6 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, config_l4_filter, __args)
 #define stmmac_set_arp_offload(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
-#define stmmac_fpe_configure(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_configure, __args)
-#define stmmac_fpe_send_mpacket(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_send_mpacket, __args)
-#define stmmac_fpe_irq_status(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
@@ -660,10 +647,27 @@ struct stmmac_est_ops {
 #define stmmac_est_irq_status(__priv, __args...) \
 	stmmac_do_void_callback(__priv, est, irq_status, __args)
 
+struct stmmac_fpe_ops {
+	void (*configure)(struct stmmac_priv *priv, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq, bool enable);
+	int (*irq_status)(struct stmmac_priv *priv, struct net_device *dev);
+	void (*send_mpacket)(struct stmmac_priv *priv,
+			     struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type);
+};
+
+#define stmmac_fpe_configure(__priv, __args...) \
+	stmmac_do_void_callback(__priv, fpe, configure, __args)
+#define stmmac_fpe_irq_status(__priv, __args...) \
+	stmmac_do_callback(__priv, fpe, irq_status, __args)
+#define stmmac_fpe_send_mpacket(__priv, __args...) \
+	stmmac_do_void_callback(__priv, fpe, send_mpacket, __args)
+
 struct stmmac_regs_off {
 	u32 ptp_off;
 	u32 mmc_off;
 	u32 est_off;
+	u32 fpe_off;
 };
 
 extern const struct stmmac_ops dwmac100_ops;
@@ -683,6 +687,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
 extern const struct stmmac_est_ops dwmac510_est_ops;
+extern const struct stmmac_fpe_ops dwmac_fpe_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..147e8c99ed51 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -315,6 +315,7 @@ struct stmmac_priv {
 	void __iomem *mmcaddr;
 	void __iomem *ptpaddr;
 	void __iomem *estaddr;
+	void __iomem *fpeaddr;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	int sfty_irq;
 	int sfty_ce_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
new file mode 100644
index 000000000000..7bcde83dba0d
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
+ * stmmac FPE(802.3 Qbu) handling
+ */
+
+#include "stmmac.h"
+#include "stmmac_fpe.h"
+#include "dwmac4.h"
+#include "dwxgmac2.h"
+
+static void fpe_configure(struct stmmac_priv *priv, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq, bool enable)
+{
+	u32 value;
+
+	if (enable) {
+		cfg->fpe_csr = FPE_CTRL_STS_EFPE;
+		if (priv->plat->has_xgmac) {
+			value = readl(priv->ioaddr + XGMAC_RXQ_CTRL1);
+			value &= ~XGMAC_FPRQ;
+			value |= (num_rxq - 1) << XGMAC_FPRQ_SHIFT;
+			writel(value, priv->ioaddr + XGMAC_RXQ_CTRL1);
+		} else if (priv->plat->has_gmac4) {
+			value = readl(priv->ioaddr + GMAC_RXQ_CTRL1);
+			value &= ~GMAC_RXQCTRL_FPRQ;
+			value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+			writel(value, priv->ioaddr + GMAC_RXQ_CTRL1);
+		}
+	} else {
+		cfg->fpe_csr = 0;
+	}
+
+	writel(cfg->fpe_csr, priv->fpeaddr);
+}
+
+static int fpe_irq_status(struct stmmac_priv *priv, struct net_device *dev)
+{
+	u32 value;
+	int status;
+
+	status = FPE_EVENT_UNKNOWN;
+
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
+	value = readl(priv->fpeaddr);
+
+	if (value & FPE_CTRL_STS_TRSP) {
+		status |= FPE_EVENT_TRSP;
+		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
+	}
+
+	if (value & FPE_CTRL_STS_TVER) {
+		status |= FPE_EVENT_TVER;
+		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+	}
+
+	if (value & FPE_CTRL_STS_RRSP) {
+		status |= FPE_EVENT_RRSP;
+		netdev_info(dev, "FPE: Respond mPacket is received\n");
+	}
+
+	if (value & FPE_CTRL_STS_RVER) {
+		status |= FPE_EVENT_RVER;
+		netdev_info(dev, "FPE: Verify mPacket is received\n");
+	}
+
+	return status;
+}
+
+static void fpe_send_mpacket(struct stmmac_priv *priv,
+			     struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type)
+{
+	u32 value = cfg->fpe_csr;
+
+	if (type == MPACKET_VERIFY)
+		value |= FPE_CTRL_STS_SVER;
+	else if (type == MPACKET_RESPONSE)
+		value |= FPE_CTRL_STS_SRSP;
+
+	writel(value, priv->fpeaddr);
+}
+
+const struct stmmac_fpe_ops dwmac_fpe_ops = {
+	.configure = fpe_configure,
+	.irq_status = fpe_irq_status,
+	.send_mpacket = fpe_send_mpacket,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
new file mode 100644
index 000000000000..b74cf8f2c2f2
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
+ * stmmac FPE(802.3 Qbu) handling
+ */
+
+#define FPE_CTRL_STS_GMAC4_OFFSET	0x00000234
+#define FPE_CTRL_STS_XGMAC_OFFSET	0x00000280
+
+#define FPE_CTRL_STS_TRSP		BIT(19)
+#define FPE_CTRL_STS_TVER		BIT(18)
+#define FPE_CTRL_STS_RRSP		BIT(17)
+#define FPE_CTRL_STS_RVER		BIT(16)
+#define FPE_CTRL_STS_SRSP		BIT(2)
+#define FPE_CTRL_STS_SVER		BIT(1)
+#define FPE_CTRL_STS_EFPE		BIT(0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4b6a359e5a94..2983e4efe17f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -974,8 +974,7 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 	bool *hs_enable = &fpe_cfg->hs_enable;
 
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-					MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv, fpe_cfg, MPACKET_VERIFY);
 	} else {
 		*lo_state = FPE_STATE_OFF;
 		*lp_state = FPE_STATE_OFF;
@@ -5996,8 +5995,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
+			stmmac_fpe_send_mpacket(priv, priv, fpe_cfg,
 						MPACKET_RESPONSE);
 	}
 
@@ -6041,8 +6039,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 				      &priv->xstats, tx_cnt);
 
 	if (priv->dma_cap.fpesel) {
-		int status = stmmac_fpe_irq_status(priv, priv->ioaddr,
-						   priv->dev);
+		int status = stmmac_fpe_irq_status(priv, priv, priv->dev);
 
 		stmmac_fpe_event_status(priv, status);
 	}
@@ -7394,8 +7391,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 
 		if (*lo_state == FPE_STATE_ENTERING_ON &&
 		    *lp_state == FPE_STATE_ENTERING_ON) {
-			stmmac_fpe_configure(priv, priv->ioaddr,
-					     fpe_cfg,
+			stmmac_fpe_configure(priv, priv, fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -7413,8 +7409,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 		     *lp_state != FPE_STATE_ON) {
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
+			stmmac_fpe_send_mpacket(priv, priv, fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7428,8 +7423,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
 {
 	if (priv->plat->fpe_cfg->hs_enable != enable) {
 		if (enable) {
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						priv->plat->fpe_cfg,
+			stmmac_fpe_send_mpacket(priv, priv, priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
@@ -7896,8 +7890,7 @@ int stmmac_suspend(struct device *dev)
 
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
-		stmmac_fpe_configure(priv, priv->ioaddr,
-				     priv->plat->fpe_cfg,
+		stmmac_fpe_configure(priv, priv, priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 996f2bcd07a2..d12b860d03c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1110,8 +1110,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	}
 
 	priv->plat->fpe_cfg->enable = false;
-	stmmac_fpe_configure(priv, priv->ioaddr,
-			     priv->plat->fpe_cfg,
+	stmmac_fpe_configure(priv, priv, priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
-- 
2.34.1


