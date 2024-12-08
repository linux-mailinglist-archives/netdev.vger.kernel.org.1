Return-Path: <netdev+bounces-149963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5059E8416
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 08:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC09C164C39
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359341C62;
	Sun,  8 Dec 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9XoPGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6B1BC4E;
	Sun,  8 Dec 2024 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733641338; cv=none; b=HvNV0R1T+rvvzoZ5IJXawwkOluF/aNtOgNRDsr1P4JXNj6pKBUVy+pcgopcS2x9GiGVO7dNXBrQ1uos7JtqkzYlQEFoM3rhBWldamwhHMx3aOwD1OHV95ogDmc2vNiqtwOV7GHN+ilzrXzHcv0/xibFyIIkYYtfGadXLhmxoKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733641338; c=relaxed/simple;
	bh=7gzOUpTLucWqdlo8JUaLzjHTiNoG9rbGmRJnIQu/1o0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JmKrgJ/2nR0HI27DrAKvZUHBwvClM1KC9qNB6GKtdtQyn0B7kg1UDp2aaez84wbGaiMP8uTuHrm5EzS8i18s/gb6Flo7g3X5yqgbHXs3+q7aklEh2x6CoGEldO/mm1nc/SqThaD+XsNbF9OKHdttkSnRaa2U1FxkUzyTLotIOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG9XoPGH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21636268e43so5764075ad.2;
        Sat, 07 Dec 2024 23:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733641335; x=1734246135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXUKUf+0SF76THFk57e33zgLbiORDIy5CN/un9OCYYM=;
        b=UG9XoPGHNreLjI/s16G7csUkptWI4pSvW+OFFGSu7LnmY2HeyaubebE40gUM+ZMsSv
         gN6f4CPe86TwOk2owbUcm6QhKiWzCDGBSX/tKsvPv6P9gI+zx1Rh9MlDNlM1FDep8e7f
         Ldmt9Q6+0hbW8+1z+PfBB+sgA+UPdx2UzzersIpGS78Qwp+3b8wfToCmJwVnZM0SFbGk
         h+W7l8gEzVSxjTDpk4AXXU5efrGrWyl8S726H/R/br/TtzCtg3WPg20nIiilKy8AiCtv
         DN7W0TeT8f7J+2knPu4F3mpIrSEqcVamSHknXfnu5LoYfwImMrxtpmdfspWJeHIBocNw
         Dj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733641335; x=1734246135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXUKUf+0SF76THFk57e33zgLbiORDIy5CN/un9OCYYM=;
        b=X9cyQ1aEgsInzN2NKI+WK8f3GJ/hmrhmhA8VGL/Wo/maIZ1dcQQObFk+83AehLyV8Z
         dwRw2Gw9+8YoaY7vom+KYnVzkxc3v7DE6GdIePsLi5FrTPlEy3V1HPz5cHsLnbJ7MtKe
         ljbK1RGR3t5L7EEDV6WkJURYfouiXMfEfNldpENNyTxVSKRAhmnK1yU+kMKQioiXIT9Q
         PDNZg/IShlq3kc+RPiEvCt88ZkvDTKkP/u7x9Dau/g/Wap7JPqIsQUuw5j3wM/8rwMn+
         Tkev0+YYVMTTb20BYXDR7pls2zUJrPcaG9v1oDk8EnN71wip3qVp7patcRs9ae0jyFMf
         MffQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUMQjG4R8DvkjY1MYzBx30PgCiJMU9bHpn5CgGzA2rP4P9jvFwIqwjl6VdfMNAmzv+5smOMKjwK4kSvto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLREmtODLbd1dCSGXbp5Szdvmz6BVcp78oZdPpN31PS0q+IhUF
	Kmnr2s+5TGT6srihhEvPnXwhPiLOepmZFXSVpZzQKudRTORROGipabcBdA==
X-Gm-Gg: ASbGncu2ti/b82i1c4WOgBS83PnhqkBserBG0XY1k0yXVtXfFhZd7aqymT6fzA0IQXh
	dQyILjs/XKcvz79WZZBV+aZivhK0B0BdPNG8wfASzr6I/MgDI7wfHOVV0Z5frFzNJJYV0R7L9eN
	D9bH7FP+AHdp4Z8qxXWVKGV3yZTrFuI7lxf8h4M5AJHMXsdPDs4ZVeawtXiIOl++tKuMMFzmZHc
	9TnRpzWK7zp86v4w4od/YsXmhPP2TOWaLsJUecyHmHYznuTR4oyV1TJ0fboUGM=
X-Google-Smtp-Source: AGHT+IEEcAin+aWPC3AV5wr/aZQOsP3NZQnwUgmYE78w2zS/hoJm9C12M0otPQyTvLsXpbG5GY7beQ==
X-Received: by 2002:a17:903:41cc:b0:215:a18c:88fa with SMTP id d9443c01a7336-21614da3f4dmr143381415ad.38.1733641335193;
        Sat, 07 Dec 2024 23:02:15 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-215f8f08f8bsm52521675ad.179.2024.12.07.23.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 23:02:14 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v1] net: stmmac: Relocate extern declarations in common.h and hwif.h
Date: Sun,  8 Dec 2024 15:02:02 +0800
Message-Id: <20241208070202.203931-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extern declarations should be in a header file that corresponds to
their definition, move these extern declarations to its header file.
Some of them have nowhere to go, so move them to hwif.h since they are
referenced in hwif.c only.

dwmac100_* dwmac1000_* dwmac4_* dwmac410_* dwmac510_* stay in hwif.h,
otherwise you will be flooded with name conflicts from dwmac100.h,
dwmac1000.h and dwmac4.h if hwif.c try to #include these .h files.

Compile tested only.
No functional change intended.

Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h     | 14 --------------
 .../net/ethernet/stmicro/stmmac/dwmac4_descs.h   |  3 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   |  5 +++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c       |  2 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 16 +++++++++-------
 drivers/net/ethernet/stmicro/stmmac/mmc.h        |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h |  3 +++
 8 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1367fa5c9b8e..fbcf07d201cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -543,18 +543,8 @@ struct dma_features {
 #define STMMAC_VLAN_INSERT	0x2
 #define STMMAC_VLAN_REPLACE	0x3
 
-extern const struct stmmac_desc_ops enh_desc_ops;
-extern const struct stmmac_desc_ops ndesc_ops;
-
 struct mac_device_info;
 
-extern const struct stmmac_hwtimestamp stmmac_ptp;
-extern const struct stmmac_hwtimestamp dwmac1000_ptp;
-extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
-
-extern const struct ptp_clock_info stmmac_ptp_clock_ops;
-extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
-
 struct mac_link {
 	u32 caps;
 	u32 speed_mask;
@@ -641,8 +631,4 @@ void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable);
 
 void dwmac_dma_flush_tx_fifo(void __iomem *ioaddr);
 
-extern const struct stmmac_mode_ops ring_mode_ops;
-extern const struct stmmac_mode_ops chain_mode_ops;
-extern const struct stmmac_desc_ops dwmac4_desc_ops;
-
 #endif /* __COMMON_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
index 1ce6f43d545a..806555976496 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
@@ -144,4 +144,7 @@
 /* TDS3 use for both format (read and write back) */
 #define RDES3_OWN			BIT(31)
 
+extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
+extern const struct stmmac_desc_ops dwmac4_desc_ops;
+
 #endif /* __DWMAC4_DESCS_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index a04a79003692..20027d3c25a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -493,4 +493,9 @@
 #define XGMAC_RDES3_TSD			BIT(6)
 #define XGMAC_RDES3_TSA			BIT(4)
 
+extern const struct stmmac_ops dwxgmac210_ops;
+extern const struct stmmac_ops dwxlgmac2_ops;
+extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
+extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index a72d336a8350..4bd79de2e222 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -9,6 +9,8 @@
 #include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
+#include "dwmac4_descs.h"
+#include "dwxgmac2.h"
 
 static u32 stmmac_get_id(struct stmmac_priv *priv, u32 id_reg)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 64f8ed67dcc4..e428c82b7d31 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -665,6 +665,15 @@ struct stmmac_regs_off {
 	u32 est_off;
 };
 
+extern const struct stmmac_desc_ops enh_desc_ops;
+extern const struct stmmac_desc_ops ndesc_ops;
+
+extern const struct stmmac_hwtimestamp stmmac_ptp;
+extern const struct stmmac_hwtimestamp dwmac1000_ptp;
+
+extern const struct stmmac_mode_ops ring_mode_ops;
+extern const struct stmmac_mode_ops chain_mode_ops;
+
 extern const struct stmmac_ops dwmac100_ops;
 extern const struct stmmac_dma_ops dwmac100_dma_ops;
 extern const struct stmmac_ops dwmac1000_ops;
@@ -677,13 +686,6 @@ extern const struct stmmac_ops dwmac510_ops;
 extern const struct stmmac_tc_ops dwmac4_tc_ops;
 extern const struct stmmac_tc_ops dwmac510_tc_ops;
 extern const struct stmmac_tc_ops dwxgmac_tc_ops;
-extern const struct stmmac_ops dwxgmac210_ops;
-extern const struct stmmac_ops dwxlgmac2_ops;
-extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
-extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
-extern const struct stmmac_mmc_ops dwmac_mmc_ops;
-extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
-extern const struct stmmac_est_ops dwmac510_est_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
index 5d1ea3e07459..1cba39fb2c44 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
@@ -139,4 +139,7 @@ struct stmmac_counters {
 	unsigned int mmc_rx_fpe_fragment_cntr;
 };
 
+extern const struct stmmac_mmc_ops dwmac_mmc_ops;
+extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
+
 #endif /* __MMC_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index 7a858c566e7e..d247fa383a6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -62,3 +62,5 @@
 #define EST_SRWO			BIT(0)
 
 #define EST_GCL_DATA			0x00000034
+
+extern const struct stmmac_est_ops dwmac510_est_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index 4cc70480ce0f..3fe0e3a80e80 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -104,4 +104,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time);
 void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv);
 
+extern const struct ptp_clock_info stmmac_ptp_clock_ops;
+extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
+
 #endif	/* __STMMAC_PTP_H__ */
-- 
2.34.1


