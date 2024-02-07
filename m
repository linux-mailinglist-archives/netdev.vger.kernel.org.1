Return-Path: <netdev+bounces-69813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7BA84CAC4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15E428C75E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A176037;
	Wed,  7 Feb 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="O6u7+WkH"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A37603F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309389; cv=none; b=ohXHhb2iAMg2xOmDGelMdJaXat6MR39mryeDzfuqPL6XEg73RE55UH+VG8CTvDsLwAmh6XhwZ0twvJtD+vsCErMey+3dKj/XxRToWWOX3VgO8szXsn44DAJ47PgfZSsXjfhfJmkU5rxNWIgcT6s3WhsdCDDK3cm1tUMzHeojcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309389; c=relaxed/simple;
	bh=azjfGpw8VVz2xWVTxs6znN4hiFUM/0Tbo7F8haH2fLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MvGsDOHiN0Ymh5a8236AGqtmCnJ9jBYcb3x23yiKYgcizS6BzJMpBEjb3FBU+x41j7XYleSGNQ4OfSZnxmNI1+1uIJf1eIVZG0ekink7dQIMD/YpC+eIX+qqaA40nP4ljGPPSvWvj7SvAZQbxS9so5WnJpNzzzIN1+I4CIzUwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=O6u7+WkH; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E1781A004E;
	Wed,  7 Feb 2024 13:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Srxw/+uy+amHWqAOEVM6LJbRgnFPMA/zIQT/u8+w3tQ=; b=
	O6u7+WkHsrTLb99YFNHfQ5exYDaCMOISJAsLDC/0enaLAFF1IRLPo8IE0JQjFG9V
	KA6uldCRjNbVDdg39uaXWN1/Tj20/xWKKULYWmzl+Kimj04M31EpurMKJ+qnNzK4
	n1UcfAoPgiIKqTsfEt7dk7YaQyLuvBvX/lmnzyTeEXletGwRXt3qEeR6TvBRWno6
	ZUdsTXlbx7OqBTriDmtDHFmRnLkMqdVw+BeKhEJZD/kMVRsWPH5KiiiW1OmwkDUs
	18ZO4DPTUPGbDwzgAieeW5yoURXcxg08nMFTjx2sKfNvKOK+6XmfdOLKPNU1ySp/
	Yldg+6Ndk4fOrpcjreeBgiqDw2csd/w8c6pV8zdDRwROwtoE/XlLvQbFb/j+3f7l
	1jL31AGie3C8RZjiw7Ml3rdPKaXdEovwuN3CWOmSbNg6v8tQ7BKW066K48vP2+iU
	trPMT8AbFGD09ObQURgtFccbAv9LD0lBW4PP98H/3+PFiGfD+uBbCWurI+yeJwlE
	BBUS2IM5INGSky1q0uRrgEY9i7H6dx9xlFAVA4TtRu0a0vm9Yd2KeyFiL+EVRau2
	3NlHVmw7h8TeJ/pONdx/XE+qilBVIB5EOfytMnbdwAKdsWR+PqxvZrBggFFeTwl/
	ahrqBY7DXRQFKzulugH2d9iEdR8IYqR8BarbJiB/8ig=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>
Subject: [PATCH resubmit] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being cleared on link-down
Date: Wed, 7 Feb 2024 13:36:11 +0100
Message-ID: <20240207123610.16337-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1707309382;VERSION=7967;MC=1354965649;ID=669748;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE703B5561766A

FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
makes all 1588 functionality shut down on link-down. However, some
functionality needs to be retained (e.g. PPS) even without link.

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



