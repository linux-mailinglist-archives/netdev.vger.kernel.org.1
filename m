Return-Path: <netdev+bounces-114508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D4942C3F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937951F25AE7
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708321AC429;
	Wed, 31 Jul 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAVMyj00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E01AC43C;
	Wed, 31 Jul 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422642; cv=none; b=SE2eJsSzq9KlLC3GGoz4YNOVo+MCL+huUekMpWwkWVF5nG0koOdROEvVzE1x/81op6H7PV7qYa21lcmt9QFmGUN7bLrT5nzWTxbqfxxu0ECeIwgp4zevakfJmeiGO2+mYLxJHif4O9g7WOjTBp0rWxsS/uBh1M98Q3O5zbfsiYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422642; c=relaxed/simple;
	bh=cwE18384uqPuD1tFF56u+x14DWLh518w7m2ga33PTvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ji9HOTTijHsF1jmSiLhoLbX5QQFLnSP2Lic1Y3h7StuHPYb+Suyw0K9B39clgcsZiNwGKIq0hgUZnFR3DzOPq4TEb979XBkQbBjB+AlK7HVs9kcuoW4gDWTUFmvbaNNuGidbalHhttBUUPP361awUy7EBFmoG4jQA8GcCOZiN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAVMyj00; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db16b2c1d2so3987023b6e.2;
        Wed, 31 Jul 2024 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422639; x=1723027439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snaCsACqyJEvDPoCe8c6j2mEdiz6XpKSMeazDSmVYA8=;
        b=NAVMyj00p353ssTioSK5kETYSykfIAdkl2SeHtzXHSmRo9Mlcbfo/NwAfMEkOxxon5
         ypspudPwgdm3UzNmGPJGacCqy5KAyWNCfaU6HBIwo70oXfzRlBMAF/t5B3a5bE63XLAu
         nWtkeZPklLpoMZJ6tn/P3ghW5TyyxfGHB9Yh6tgONNLVHtGCiLggIIr7ui9GZbPIJIeW
         /x5rcowM1Il6Io1x3sI7R1Ry/AFj4OvlFOc0RrUj9gMGR2CmOPrizA6BfMUdWhpYRtu5
         dz1vRj9DHkV+tVGLXSgjXKIATRUk29gpqGwib0frTntU+sa/wJdnhdE+wH9OhGNB+Fq4
         Bu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422639; x=1723027439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snaCsACqyJEvDPoCe8c6j2mEdiz6XpKSMeazDSmVYA8=;
        b=YePpXQP3+ObEzh320zmPuA1ol/8un5lbPV2ehyyQUOFVhPn1fiYlp37ipfkWtUy0I8
         OHUsRaf4xLbfQnBVuCOODwNROuC59TmDIKDfLAg6+46RTvMBEN+E3Y4oFbm8WLls3n8l
         G9zhHdb0Oay732aazB6dAG8rt4vyavOM6oGqtOViY77Di6HLylNX/DA8vrdzEmIzFQzk
         I5bp3Xd2cheX886y6Qm8rdb6R45/icg1kMAg7CXMWFXFoH0OjAXtuBuL7C0QbBJgi+Nx
         MjaSzCZrRb7wAAdCdA0r8Ish9/mSagJBgALF+RSfmhpuPmEGVN3s8wtTYoj+1Ex7rQlK
         N9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCWd9NwCsYEtcdntouJ9HUyNlGXKnlUCnlEiVKbT1N1hCiZYgiqG2C9uPd3PvqVKKB4IVwtl62r7caC04=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDTO0M0DGOLCGEe+bjaDOUVV+C0N9nm3C60NtblY1canYddFI
	yGh1D97fTkcpGi7CU1lj7plg/OVbzdrei8FZDdo97qDycXfMeaPZ
X-Google-Smtp-Source: AGHT+IFvZHTHnA2mtTbaHt9st4XF5vvQ0tz9N8ooQBOxEewsYWTEfsn8Xwb59WNXcqec07rlupgtug==
X-Received: by 2002:a05:6870:1685:b0:25e:24a0:4c96 with SMTP id 586e51a60fabf-267d4d0710bmr16665666fac.11.1722422639081;
        Wed, 31 Jul 2024 03:43:59 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f816da59sm8791375a12.29.2024.07.31.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:43:58 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net-next v1 1/5] net: stmmac: configure FPE via ethtool-mm
Date: Wed, 31 Jul 2024 18:43:12 +0800
Message-Id: <d20b291dc4dd5030adefbabef7dda1bf2206a15f.1722421644.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>
References: <cover.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ethtool --show-mm and --set-mm callbacks.

0) Setup two DWMAC CORE 5.10a devices, connect in a back-to-back manner.

1) After kernel booted, get initial status:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": false,
        "tx-active": false,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": false,
        "verify-time": 0,
        "max-verify-time": 128,
        "verify-status": "DISABLED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

3) Enable FPE on local device, keep FPE disabled on remote device:
ethtool --set-mm eth1 verify-enabled on verify-time 100 tx-enabled on

4) Get status on local device:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": true,
        "tx-active": false,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": true,
        "verify-time": 100,
        "max-verify-time": 128,
        "verify-status": "VERIFYING",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

5) Enable FPE on remote device, handshake can be finished now:
ethtool --set-mm eth1 verify-enabled on verify-time 100 tx-enabled on

6) Get status on local and remote device, both report SUCCEEDED:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": true,
        "tx-active": true,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": true,
        "verify-time": 100,
        "max-verify-time": 128,
        "verify-status": "SUCCEEDED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

7) tc-mqprio or tc-taprio can be used to select whether traffic classes are
express or preemptible.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   4 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  17 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |   5 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   6 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   3 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 111 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   9 +-
 include/linux/stmmac.h                        |   1 +
 8 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index f98741d2607e..af871cce767e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1268,6 +1268,8 @@ const struct stmmac_ops dwmac410_ops = {
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
 	.fpe_irq_status = dwmac5_fpe_irq_status,
+	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
+	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1320,6 +1322,8 @@ const struct stmmac_ops dwmac510_ops = {
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
 	.fpe_irq_status = dwmac5_fpe_irq_status,
+	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
+	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e02cebc3f1b7..5d132bada3fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -638,3 +638,20 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
+
+int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr)
+{
+	return FIELD_GET(AFSZ, readl(ioaddr + MTL_FPE_CTRL_STS));
+}
+
+void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
+{
+	u32 value;
+
+	value = readl(ioaddr + MTL_FPE_CTRL_STS);
+
+	value &= ~AFSZ;
+	value |= FIELD_PREP(AFSZ, add_frag_size);
+
+	writel(value, ioaddr + MTL_FPE_CTRL_STS);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index bf33a51d229e..6b1c9d2da308 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -39,6 +39,9 @@
 #define MAC_PPSx_INTERVAL(x)		(0x00000b88 + ((x) * 0x10))
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
+#define MTL_FPE_CTRL_STS		0x00000c90
+#define AFSZ				GENMASK(1, 0)
+
 #define MTL_RXP_CONTROL_STATUS		0x00000ca0
 #define RXPI				BIT(31)
 #define NPE				GENMASK(23, 16)
@@ -109,5 +112,7 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
+int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr);
+void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e53c32362774..f868ffc3e64f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -425,6 +425,8 @@ struct stmmac_ops {
 				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
+	int (*fpe_get_add_frag_size)(void __iomem *ioaddr);
+	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -529,6 +531,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, fpe_send_mpacket, __args)
 #define stmmac_fpe_irq_status(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
+#define stmmac_fpe_get_add_frag_size(__priv, __args...) \
+	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
+#define stmmac_fpe_set_add_frag_size(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..5228493bc68c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -345,6 +345,9 @@ struct stmmac_priv {
 	struct work_struct fpe_task;
 	char wq_name[IFNAMSIZ + 4];
 
+	/* Serialize access to MAC Merge state between ethtool requests */
+	struct mutex mm_lock;
+
 	/* TC Handling */
 	unsigned int tc_entries_max;
 	unsigned int tc_off_max;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 7008219fd88d..ca85e8694285 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -19,6 +19,7 @@
 #include "stmmac.h"
 #include "dwmac_dma.h"
 #include "dwxgmac2.h"
+#include "dwmac5.h"
 
 #define REG_SPACE_SIZE	0x1060
 #define GMAC4_REG_SPACE_SIZE	0x116C
@@ -1270,6 +1271,113 @@ static int stmmac_set_tunable(struct net_device *dev,
 	return ret;
 }
 
+static int stmmac_get_mm(struct net_device *ndev,
+			 struct ethtool_mm_state *state)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	enum stmmac_fpe_state lo_state = priv->plat->fpe_cfg->lo_fpe_state;
+	u32 add_frag_size;
+
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&priv->mm_lock);
+
+	/* If FPE is supported by hardware, preemptible MAC is always enabled */
+	state->pmac_enabled = true;
+
+	state->verify_time = priv->plat->fpe_cfg->verify_time;
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = 128;
+
+	if (lo_state == FPE_STATE_CAPABLE)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+	else if (lo_state == FPE_STATE_ENTERING_ON || lo_state == FPE_STATE_ON)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+	else if (lo_state == FPE_STATE_OFF)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	else
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+
+	/* Cannot read MAC_FPE_CTRL_STS register here, or FPE interrupt events
+	 * can lose.
+	 *
+	 * See commit 37e4b8df27bc ("net: stmmac: fix FPE events losing")
+	 */
+	state->tx_enabled = !!(priv->plat->fpe_cfg->fpe_csr == EFPE);
+
+	/* FPE active if common tx_enabled and verification success or disabled (forced) */
+	state->tx_active = state->tx_enabled &&
+			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+
+	state->verify_enabled = priv->plat->fpe_cfg->hs_enable;
+
+	add_frag_size = stmmac_fpe_get_add_frag_size(priv, priv->ioaddr);
+	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
+
+	state->rx_min_frag_size = ETH_ZLEN;
+
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
+static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+			 struct netlink_ext_ack *extack)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 add_frag_size;
+	int err;
+
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size,
+					      &add_frag_size, extack);
+	if (err)
+		return err;
+
+	mutex_lock(&priv->mm_lock);
+
+	priv->plat->fpe_cfg->verify_time = cfg->verify_time;
+
+	stmmac_fpe_configure(priv, priv->ioaddr, priv->plat->fpe_cfg,
+			     priv->plat->tx_queues_to_use,
+			     priv->plat->rx_queues_to_use,
+			     cfg->tx_enabled);
+
+	stmmac_fpe_set_add_frag_size(priv, priv->ioaddr, add_frag_size);
+
+	stmmac_fpe_handshake(priv, cfg->verify_enabled);
+
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
+static void stmmac_get_mm_stats(struct net_device *ndev,
+				struct ethtool_mm_stats *s)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_counters *mmc = &priv->mmc;
+
+	if (!priv->dma_cap.rmon)
+		return;
+
+	stmmac_mmc_read(priv, priv->mmcaddr, mmc);
+
+	s->MACMergeFrameAssErrorCount = mmc->mmc_rx_packet_assembly_err_cntr;
+	s->MACMergeFrameSmdErrorCount = mmc->mmc_rx_packet_smd_err_cntr;
+	s->MACMergeFrameAssOkCount = mmc->mmc_rx_packet_assembly_ok_cntr;
+	s->MACMergeFragCountRx = mmc->mmc_rx_fpe_fragment_cntr;
+	s->MACMergeFragCountTx = mmc->mmc_tx_fpe_fragment_cntr;
+	s->MACMergeHoldCount = mmc->mmc_tx_hold_req_cntr;
+}
+
 static const struct ethtool_ops stmmac_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -1309,6 +1417,9 @@ static const struct ethtool_ops stmmac_ethtool_ops = {
 	.set_tunable = stmmac_set_tunable,
 	.get_link_ksettings = stmmac_ethtool_get_link_ksettings,
 	.set_link_ksettings = stmmac_ethtool_set_link_ksettings,
+	.get_mm = stmmac_get_mm,
+	.set_mm = stmmac_set_mm,
+	.get_mm_stats = stmmac_get_mm_stats,
 };
 
 void stmmac_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 12689774d755..9b1cf81c50ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7384,7 +7384,6 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
 	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
 	bool *hs_enable = &fpe_cfg->hs_enable;
-	bool *enable = &fpe_cfg->enable;
 	int retries = 20;
 
 	while (retries-- > 0) {
@@ -7394,11 +7393,6 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 
 		if (*lo_state == FPE_STATE_ENTERING_ON &&
 		    *lp_state == FPE_STATE_ENTERING_ON) {
-			stmmac_fpe_configure(priv, priv->ioaddr,
-					     fpe_cfg,
-					     priv->plat->tx_queues_to_use,
-					     priv->plat->rx_queues_to_use,
-					     *enable);
 
 			netdev_info(priv->dev, "configured FPE\n");
 
@@ -7418,7 +7412,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
-		msleep(500);
+		msleep(fpe_cfg->verify_time);
 	}
 
 	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
@@ -7720,6 +7714,7 @@ int stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->mm_lock);
 
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 84e13bd5df28..707a6916e51a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -162,6 +162,7 @@ struct stmmac_fpe_cfg {
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
 	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
+	u32 verify_time;			/* see struct ethtool_mm_state */
 };
 
 struct stmmac_safety_feature_cfg {
-- 
2.34.1


