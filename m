Return-Path: <netdev+bounces-69783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46884C998
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3011F219A4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D13418EBF;
	Wed,  7 Feb 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="NrNImYYI"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53829199DC
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305272; cv=none; b=nVWtTaLEOyoQc6tCC6UCpiBvADw67ncUPlM+aciaJKgvNpX5rOFUFfL66FZ5x/yqnVGtzIGLL/c8+R6/EABh9C/bR2+m7Z+DLDkHvSg1TQzbN5wYr9uKdXP5o+h8Et77lcPBWHWP60XcDXpIkgQkBhuJ8lr8D9Vm+L96S5TkvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305272; c=relaxed/simple;
	bh=MQjoyTUC8RNB36w5sTev0QAlLhksX+9RUHrdXIsLaoM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R5JcPMS/uRLyw3RrhD4xU1WrfF1YGsJ8KDRBh66KIJm2W++dzfsqBxo7NMuvyV/oNRl7xOCu7T9t+m0S4sk7F79HQg3lMhxFTmADqoK7YBh2bBubSz1YCHvTawSRalhVplLOlH/hmsOh8D8253Rb33W7cHHr5IDLiMisQO+kfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=NrNImYYI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 36B5EA09B8;
	Wed,  7 Feb 2024 12:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=1MhkQyENh48+1sTnIIQ0p6HUF/W0m7FkG7ghm6Oa8oo=; b=
	NrNImYYIGk2qKFTyTTrlIxPHohAdJzLAWh/wTmchMa1+bSeEdXQRgNlmlHNHHoZu
	u8eIgI0S7BMDxIbzMJfNdn+BMDAcx+zRdzb4jf5qmi9derbU2xNlmYKH7wO1WdOp
	Gu7p9NttrhXIYM9t0+h7QSM2leB8NHOWG3BrjK4Q9XR//4xGwpDV4lVv2n9sZhFR
	YkHu0awoOdVx27Ql406Y817/DYevqo5SkreXPf7LkIsqNALlubdpkMNC8rRCUM4H
	KyWun1e9okPRnuDGtJzTrH30LZWYpsoklBDGSd6uQX7kIBBP7SqZwKwjkJi/C/eg
	YtsUqn0BpYOhqk4dy3r93/z4/ehOs6lMRzv4ivHuHoXAw/ptmSgas5KXSNmKPNI/
	qjvB37HtQkVF8nCeYPkjPucCzES9EFWmUKI5wO4WMVj1a9P+FEAASmFw2Q38zHEP
	Sq8VtzGFgTDHqOuC2+Ba7G8f8FQA9H2jOkMD0SETdMmq8lMIGUsVU/iaTiIlQ7BJ
	QvANCv4KWVOqB442HbN1J/PWAnQTJW38ika6ApR+T925gnwAtQ5oqvF0nBHmoBQ7
	AvZpkBgqj7Bnk15LBuqohXUAfl+8L2iDLhB1Be4FRnm9lz3WJoRQ8KOX3HXl3ZiD
	3EmZiGyJO7twD20qOVzqtzW97UVk8gYPmSVF3HH9HH4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>
Subject: [PATCH] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being cleared on link-down
Date: Wed, 7 Feb 2024 12:18:59 +0100
Message-ID: <20240207111859.15463-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1707304740;VERSION=7967;MC=2569388289;ID=665117;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B5561766A

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63707e065141..652251e48ad4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -273,8 +273,11 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_MMFR_TA		(2 << 16)
 #define FEC_MMFR_DATA(v)	(v & 0xffff)
 /* FEC ECR bits definition */
-#define FEC_ECR_MAGICEN		(1 << 2)
-#define FEC_ECR_SLEEP		(1 << 3)
+#define FEC_ECR_RESET   BIT(0)
+#define FEC_ECR_ETHEREN BIT(1)
+#define FEC_ECR_MAGICEN BIT(2)
+#define FEC_ECR_SLEEP   BIT(3)
+#define FEC_ECR_EN1588  BIT(4)
 
 #define FEC_MII_TIMEOUT		30000 /* us */
 
@@ -1213,7 +1216,7 @@ fec_restart(struct net_device *ndev)
 	}
 
 	if (fep->bufdesc_ex)
-		ecntl |= (1 << 4);
+		ecntl |= FEC_ECR_EN1588;
 
 	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
 	    fep->rgmii_txc_dly)
@@ -1314,6 +1317,7 @@ fec_stop(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
 	u32 val;
+	u32 ecntl = 0;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
 	if (fep->link) {
@@ -1342,12 +1346,17 @@ fec_stop(struct net_device *ndev)
 	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
 	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 
+	if (fep->bufdesc_ex)
+		ecntl |= FEC_ECR_EN1588;
+
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



