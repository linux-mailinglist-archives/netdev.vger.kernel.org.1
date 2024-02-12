Return-Path: <netdev+bounces-70995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386985183C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFA82864B4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E73C478;
	Mon, 12 Feb 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Mk2oVwoI"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946D3C684
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752269; cv=none; b=gVAx/HuNLuhN/oO4tIXCqBd0HlnTq1Ywc7sYYW+LqHlk7q3CnRgf/OaTk3hpfDglDwnzVR6PUxonDbSQH6rB9MXTGw7vLh3IZu0FwC8M9ny3Fxci1Qwnb57IG//5Nyw0eQ33EzxtTzBH/AD8j1Pq/3UwewgzZ9J2dUo2SaqbCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752269; c=relaxed/simple;
	bh=pDZCdj3zfKTHocfo47Jemet0Xf+rAOXs9uZZ72GyjgA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DyRFNBbwqPJPkVllIVrcYSMXplZf2xJvfzpf1A8L2EEUm67kSyCJb+K2KIMds+ATfashRG9Bo2Q2cH/i64LbgjQsMRh0uE32vKaShG4k4+jfdSDA+4RDwSJBzz0vZKHj1CUqp3LHO/kHTkC1Ukw6VzUFBDIN8y6c4eAhxrVMJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Mk2oVwoI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2571FA048F;
	Mon, 12 Feb 2024 16:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=qvMd+eWn/cHUBfh6YmtPteQfHMNXDeVZKWAv2YxLbuo=; b=
	Mk2oVwoIjOjvujTxPaux2uYbVh2QDBF2HfS/BlOKAQ3gOCv/AVhuqIJYqDZmtu+q
	S41jSS7OBbaGiRy3X3StnVqe13Jk0yu82I5TFU66mVVAAVtxtHP0dpBtXVkqwUuI
	VVi3+uHaiTuciP6PIUGB88a2WNtdL3yoVhjeg2DflmgjHlQCtrERen/0So1ElbvY
	P6TYSRYu7jzcbwgahD8huh32VdR0JFkZuwkmey5HYfyGiemkgtnsxr3R/gSk2KN6
	HT2VaHBI6NCWtS4g9y8fa5DpDGCTb0D8pgcCGra/n6aa01POH+8Qgq28JN0Ln6f6
	1MDrtxuzXLPfKrQu0yXaK0wMTDYoZ1DQgtjLxwVFP483gocujuvznufv0W6qaJrC
	vFV9xVbRA2K2qJ6ZNbCh0ML0HzYl73JeLhI8IYRkwDdIiF9PRw36nHrrmF9fqUhI
	uCerY4SZ+0kDxdq74yElKHM0/eEPzS3bOtXcmiWzU7OTUk+A2wG3D8C87pHp93u2
	Ec5rhkQYkGdQe4czpq3cjq0zm9TZM630uCn293hx7fiqI5OsrthP55ujMBwzlMlF
	yao10vjcU56DybbtAm4gvrYUzyRuniahcVXpBA53ssLnT3bwyViXxXGWJxLLq3Wq
	oTbS/dK8WxSErkSnZ0iMFfJOH+FBjeGkWYTRgdiomH0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, Denis Kirjanov <dkirjanov@suse.de>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH net-next v4 1/2] net: fec: Refactor: #define magic constants
Date: Mon, 12 Feb 2024 16:37:17 +0100
Message-ID: <20240212153717.10023-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1707752262;VERSION=7967;MC=4227844205;ID=914895;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B55617C60

Add defines for bits of ECR, RCR control registers, TX watermark etc.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v4:
    * factored out the removal of FEC_ENET_FCE
    
    Changes in v3:
    * remove `u32 ecntl` from `fec_stop()`
    * found another ETHEREN in `fec_restart()`

 drivers/net/ethernet/freescale/fec_main.c | 46 +++++++++++++++--------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63707e065141..52c674ecbebf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -240,8 +240,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define PKT_MINBUF_SIZE		64
 
 /* FEC receive acceleration */
-#define FEC_RACC_IPDIS		(1 << 1)
-#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_IPDIS		BIT(1)
+#define FEC_RACC_PRODIS		BIT(2)
 #define FEC_RACC_SHIFT16	BIT(7)
 #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
 
@@ -273,8 +273,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
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
 
@@ -1062,7 +1077,7 @@ fec_restart(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
+	u32 ecntl = FEC_ECR_ETHEREN;
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1137,18 +1152,18 @@ fec_restart(struct net_device *ndev)
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
@@ -1207,13 +1222,13 @@ fec_restart(struct net_device *ndev)
 
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
@@ -1312,7 +1327,7 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1331,7 +1346,7 @@ fec_stop(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
 			writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(1, fep->hwp + FEC_ECNTRL);
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 	} else {
@@ -1345,12 +1360,11 @@ fec_stop(struct net_device *ndev)
 	/* We have to keep ENET enabled to have MII interrupt stay working */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
 		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		writel(2, fep->hwp + FEC_ECNTRL);
+		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
 }
 
-
 static void
 fec_timeout(struct net_device *ndev, unsigned int txqueue)
 {
-- 
2.25.1



