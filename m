Return-Path: <netdev+bounces-70463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB484F1FD
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA63286DA7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC815664C0;
	Fri,  9 Feb 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mWh7XVdf"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D865BDE
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469903; cv=none; b=bY4jVa6ZKySp1E0ZQBnG/oYBtIYH8l3escahqD3oPvRuKdm0jZoYCAyIZ9088Q1/FcR6hpvLGGzF9U6pD4+XfU++jvH2bU67+cNVAPpjTMRsiOaOhHFLjNFTbCPQrzYwmU76O88iimAohbRL09vP9PKWDFN7lfC2I15RSFdhrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469903; c=relaxed/simple;
	bh=AA3p4zJPboFgc+xN0CpVJoaA5JvD/uRaeqnIYTv3cEw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLzC9TWFmPs/F5mTfPiy2gMhnBcGMWb5vnAOzgDFsCAxIFHEcEseVZzzb72wSMZrCxOFaxqWHWlAJyGy3Ya00v8ZLybvu7ybbESE0FGKDcLVmMxb6pnq7q63JEhN7gl78DeMK0l/D18lO+C6Hfuy8B8ZOTw7LFgFZU+Xv236MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mWh7XVdf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7D8AFA0EB0;
	Fri,  9 Feb 2024 10:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=5U65dZd4MpITNFzt6UeYg42kS8hKyr3vO9pGLMgIPco=; b=
	mWh7XVdfMjF+71Ghk+J80iJWrh21sCTkgJ4soTkEeNc4JS8iiy3xtKDuyFwcbevT
	H0ddfFQ/EhA0lSN09GbKSgEROzUfU/qk1B6RZS1IOTX2WiDtQiJTTg4SrYsY86ea
	OVU8d/YPn7KchT3fVxVFskD4ltOCoJodwvZkxKkuDlczgnbOMsHCVKPlo3++UKfa
	gHAdpD7dpGHPvZb3Yscx2BZ/jZ6gO1Al4ywg9JK9yQ9PNJP+iLsSthSpwcdDH/1d
	h6TcnEU1D/Vi/7wWkRejRKpBnjJ4IiZd4Xgb4WND6Jlpo/m0upMRtyJ730eMZlMx
	sXFSwntulwQFu9WLE2QIgAATm9QwKt0PmhzcA2JjVoabAOx5GJErUEknHYXyJukO
	F2BrrENCyjDqStCzbQOIUzurdszr6wmGPqpafRkO5TfmqlvC3l9gKnavO5ghHK1j
	1yVuiHIyRvD6+x6IiTG0CQoxvJXbLAnVNHQxr9QULO2d3qWjQe3TGxSO+qMGfmqc
	GQFcPq7uC+9hwhHFr52VMdi9SrUtdlxuij7J/0JUplhrZMAJz4XlHXdmWxpCtlzc
	OLW/VVdGCucPVOnhYxIxhGbSUWH5MqTslS1VzDU2FZzFIPON2/lIr+X4PCdXYkuq
	c3EbSikahRM/wn+XO7HClKWrt+Vglw5wUB1rK4pwYxc=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>
Subject: [PATCH v2] net: fec: Refactor: #define magic constants
Date: Fri, 9 Feb 2024 10:11:01 +0100
Message-ID: <20240209091100.5341-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1707469890;VERSION=7967;MC=2819195385;ID=625947;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55617362

Add defines for bits of ECR, RCR control registers, TX watermark etc.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++++++--------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63707e065141..a16220eff9b3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -85,8 +85,6 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 
 static const u16 fec_enet_vlan_pri_to_queue[8] = {0, 0, 1, 1, 1, 2, 2, 2};
 
-/* Pause frame feild and FIFO threshold */
-#define FEC_ENET_FCE	(1 << 5)
 #define FEC_ENET_RSEM_V	0x84
 #define FEC_ENET_RSFL_V	16
 #define FEC_ENET_RAEM_V	0x8
@@ -240,8 +238,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define PKT_MINBUF_SIZE		64
 
 /* FEC receive acceleration */
-#define FEC_RACC_IPDIS		(1 << 1)
-#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_IPDIS		BIT(1)
+#define FEC_RACC_PRODIS		BIT(2)
 #define FEC_RACC_SHIFT16	BIT(7)
 #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
 
@@ -273,8 +271,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_MMFR_TA		(2 << 16)
 #define FEC_MMFR_DATA(v)	(v & 0xffff)
 /* FEC ECR bits definition */
-#define FEC_ECR_MAGICEN		(1 << 2)
-#define FEC_ECR_SLEEP		(1 << 3)
+#define FEC_ECR_RESET           BIT(0)
+#define FEC_ECR_ETHEREN         BIT(1)
+#define FEC_ECR_MAGICEN         BIT(2)
+#define FEC_ECR_SLEEP           BIT(3)
+#define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_BYTESWP         BIT(8)
+/* FEC RCR bits definition */
+#define FEC_RCR_LOOP            BIT(0)
+#define FEC_RCR_HALFDPX         BIT(1)
+#define FEC_RCR_MII             BIT(2)
+#define FEC_RCR_PROMISC         BIT(3)
+#define FEC_RCR_BC_REJ          BIT(4)
+#define FEC_RCR_FLOWCTL         BIT(5)
+#define FEC_RCR_RMII            BIT(8)
+#define FEC_RCR_10BASET         BIT(9)
+/* TX WMARK bits */
+#define FEC_TXWMRK_STRFWD       BIT(8)
 
 #define FEC_MII_TIMEOUT		30000 /* us */
 
@@ -1137,18 +1150,18 @@ fec_restart(struct net_device *ndev)
 		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
 			rcntl |= (1 << 6);
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
-			rcntl |= (1 << 8);
+			rcntl |= FEC_RCR_RMII;
 		else
-			rcntl &= ~(1 << 8);
+			rcntl &= ~FEC_RCR_RMII;
 
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
 				ecntl |= (1 << 5);
 			else if (ndev->phydev->speed == SPEED_100)
-				rcntl &= ~(1 << 9);
+				rcntl &= ~FEC_RCR_10BASET;
 			else
-				rcntl |= (1 << 9);
+				rcntl |= FEC_RCR_10BASET;
 		}
 	} else {
 #ifdef FEC_MIIGSK_ENR
@@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
 	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
 	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
 	     ndev->phydev && ndev->phydev->pause)) {
-		rcntl |= FEC_ENET_FCE;
+		rcntl |= FEC_RCR_FLOWCTL;
 
 		/* set FIFO threshold parameter to reduce overrun */
 		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
@@ -1192,7 +1205,7 @@ fec_restart(struct net_device *ndev)
 		/* OPD */
 		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
 	} else {
-		rcntl &= ~FEC_ENET_FCE;
+		rcntl &= ~FEC_RCR_FLOWCTL;
 	}
 #endif /* !defined(CONFIG_M5272) */
 
@@ -1207,13 +1220,13 @@ fec_restart(struct net_device *ndev)
 
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
-		ecntl |= (1 << 8);
+		ecntl |= FEC_ECR_BYTESWP;
 		/* enable ENET store and forward mode */
-		writel(1 << 8, fep->hwp + FEC_X_WMRK);
+		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
-		ecntl |= (1 << 4);
+		ecntl |= FEC_ECR_EN1588;
 
 	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
 	    fep->rgmii_txc_dly)
@@ -1312,7 +1325,8 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
+	u32 ecntl = 0;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1345,9 +1359,11 @@ fec_stop(struct net_device *ndev)
 	/* We have to keep ENET enabled to have MII interrupt stay working */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
 		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		writel(2, fep->hwp + FEC_ECNTRL);
+		ecntl |= FEC_ECR_ETHEREN;
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
+
+	writel(ecntl, fep->hwp + FEC_ECNTRL);
 }
 
 
-- 
2.25.1



