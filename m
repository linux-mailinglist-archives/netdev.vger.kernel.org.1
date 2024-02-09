Return-Path: <netdev+bounces-70480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E884F2EC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DFD288817
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E8167E62;
	Fri,  9 Feb 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mzfPkFvT"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489567E61
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473122; cv=none; b=C7ArUlvXLjHbOWkfFtxhJKkyq1OzR8YuxgIyGRmQGJTIKNaTE1Ay5TbGVMc2clwnfGmjew7NyeBl+KheYCAg6cP9OtJjAoJ53WnQxkDpfz4483+AONUYqOKhRKBLoePCxkEBQzaHra7sMd93MMS1V1g+PQt6Bu5XxDy0iwbSTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473122; c=relaxed/simple;
	bh=LpId7MWNO6tC/dT5AyI2e2h2RKJBUol2yT2jrwBH+o8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MXGrZ2nfUfs2HZBopwbg+bImOACfadh55p/hDhXE661XZm/W1Dgg/imOPp/mbiWJ9jcIiw4CTuC/0uNcGtWK+rS9jO2y4i3Cdx/jyref6CJCzxily9KHDy8/T+NXGuzmNycIw/LrI1EbL2HqwiaASFhaDi/hW0UW/Gejv1cb+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mzfPkFvT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 98561A0921;
	Fri,  9 Feb 2024 11:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=4rlVR1nRwMZg34654zIfRzA6Fn02BC7ITCz7grW4Lgc=; b=
	mzfPkFvTEX6K7bVsW9WeTa+D+V+yOgQPRjCtyLBEnpZfq1QzW+2tm40VZ394hVYk
	nYX3dHdokICflfnQrP9G7JmtrF5inMferoeYe6jbSzBQR0jNDX+iHEwp0kKGRzJ8
	JXbBlEjFBCJGAYda9puPxWN6ULwmoG3D9B3JhD3jKptBqvkoSeKmR6WgOCUJvmf8
	Pkb3xD3iKlZ4mIYWQLRIL9AT76tnGcTIgXevgdP6xyIQf14opCPoJSf/gsd/BKKh
	Okz7lX3fymRC9Ti14tsa+4GK8rQIc0QZ92eQNo2I0TXabUrlpOGdHfRmUvuYSB9f
	9Sue34yXqeaQ0C7E3Dj51nWiRKx+R1EUAHah5r3BjYqQ0xLwcnTnwfeL7Bi2cGyj
	NlZrIw+sn7yaaFRPVXP1Y1jQ9YaTs+8GJOOCplQJWhr/IKuj7pLVtKSWn8a5G3wC
	cLVc9jd8cBSmiYZE1BYVKnQpgQqM2H6t4YQk2TeOZa0AIeJ+WP6aCC+Xxqan5w4a
	I+dbEKsFrKrGXDvcbwnXpYEL8RAXhGCuXQwn+FE7DUgx1yMIa6iC7OTNB0Dp5LOz
	3EVBNxb2pUeoc07W0/UZI1BcvwBwW36rFlQh5NHMelGpolV63nv2q8sN43NOd8hB
	j0GFmOpOYz0VeOECo27k/61cOM1rhwuW4ZcA+NXWXWU=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, Denis Kirjanov <dkirjanov@suse.de>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH net-next v3] net: fec: Refactor: #define magic constants
Date: Fri, 9 Feb 2024 11:01:33 +0100
Message-ID: <20240209100132.8649-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1707473114;VERSION=7967;MC=1952559061;ID=738635;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B55617362

Add defines for bits of ECR, RCR control registers, TX watermark etc.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
Notes:
    Changes in v3:
    * remove `u32 ecntl` from `fec_stop()`
    * found another ETHEREN in `fec_restart()`
 drivers/net/ethernet/freescale/fec_main.c | 52 ++++++++++++++---------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63707e065141..84f24a0fe278 100644
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
 
@@ -1062,7 +1075,7 @@ fec_restart(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
+	u32 ecntl = FEC_ECR_ETHEREN;
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
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
@@ -1312,7 +1325,7 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1331,7 +1344,7 @@ fec_stop(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
 			writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(1, fep->hwp + FEC_ECNTRL);
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 	} else {
@@ -1345,12 +1358,11 @@ fec_stop(struct net_device *ndev)
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



