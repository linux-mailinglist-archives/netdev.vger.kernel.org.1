Return-Path: <netdev+bounces-160372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DDA196B1
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860931618AF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61721504D;
	Wed, 22 Jan 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tiiDVHAl"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975D21481F;
	Wed, 22 Jan 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564101; cv=none; b=iWbop1O9vC5LXlYgOEhVOgUGFki5cVbQU9CgPByFC9T0XMbd1DfFqqpqqzB1sezeNb3eh02SAZ9uw/q9wFgj3YMSqnWO2zE/rpyJ60dUFY4ghR/EUFw8Fpfb+W1p//fk/mdLTfmRSD+qbhzm2lSxVjTT7nXhCZJESGb8NZJMu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564101; c=relaxed/simple;
	bh=f0tAfTbWDW2FkQbgi3d758Uem0n6fzGbFvsTA1ngvxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jo1/N3jWYjpMcROW3PihaMee4eKI+VGUTFsGhGQo5V7Skl6gMZE6EVrpJXGaOA4MJ4MfIFgiw2Vc4u93+2gnTc2ql6mu6S7lpcQByd9czMbKDcqBX5ZjYV8RBF3neHoFOkTqScEuH5F4HHOCL9hmEIMmVsIQuKUOCi/BHXC53OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tiiDVHAl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9B90EA09D7;
	Wed, 22 Jan 2025 17:41:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ek8VNfP6wDJAkf+F3SKTcqMo2qWsHK+cLHwLll5Idb0=; b=
	tiiDVHAlloVomCLPy3gPu+/fuJQMrnFxtyZ5oWU8YzEJmr89GPxLLb2qw4hZMHF0
	6G6HFrsX+zCgDxBlaDtWTmPDeViGYBacUysQ8t22KwpV6HQMfZ2Eg4yyGBdymCqH
	D+reuTBcFC66Gb9jP+Dcy6CgfNDoDbeJyv+JhCpIXn/aqcCF3B/zKFqzW5CbzJ0X
	ceYv4xMGj0lAYiQf1AoYUiS47YLEYuZIb/VYKqM/0h49hByotTdr3kPjcllEBYYJ
	Q6HWoh8XMTDIMwJocQOyZG4chC4e2IpSy3to8iKTmUf0MZVjal0p7nb11fmIaZy7
	N4XOkGz+LLzNSTjiN9IQ5P5sXAknrxjyxlLEcMBo3Qi1MoFXBbBQZaNDDx5DUDRG
	xhvVvBHuEIBBHlRvqF/FPemq+oq+rZQXAgZhA6KMbWG45mkBN8VkySuYlpbsruJX
	YdKfxySHrJQon1DJIP7vkQs90WU9HrQnH/UF4hflu30YZLFYBs99xit5353G8gtT
	eT7kJ05vcPma6fuIqng0FAe+zC8xlNRhNyYOoQtuZRwxw4gUHpM5r13RjQHDiHKU
	ePakK/5ttM+s4YMl2Q5Dra3uzbO+PqNX04LiIU3AePqDVYy4Cv4PiTfA1drDQudx
	dT7rV57hahNMGsEMtcOkPeoSTmVrLriRcHkDUiLO4z4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Laurent Badel <laurentbadel@eaton.com>, Jakub Kicinski <kuba@kernel.org>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Ahmad
 Fatoum" <a.fatoum@pengutronix.de>, Simon Horman <horms@kernel.org>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
Subject: [PATCH] net: fec: Refactor MAC reset to function
Date: Wed, 22 Jan 2025 17:39:33 +0100
Message-ID: <20250122163935.213313-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737564089;VERSION=7983;MC=2169678724;ID=57136;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485267776B

The core is reset both in `fec_restart()` (called on link-up) and
`fec_stop()` (going to sleep, driver remove etc.). These two functions
had their separate implementations, which was at first only a register
write and a `udelay()` (and the accompanying block comment). However,
since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
meant that these implementations diverged, often causing bugs. For
instance, as of now, `fec_stop()` does not check for
`FEC_QUIRK_NO_HARD_RESET`, and `fec_restart()` missed the refactor in
commit ff049886671c ("net: fec: Refactor: #define magic constants")
renaming the "magic" constant `1` to `FEC_ECR_RESET`.

To eliminate this bug-source, refactor implementation to a common function.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Recommended options for this patch:
    `--color-moved --color-moved-ws=allow-indentation-change`
    Changes in v2:
    * collect Michal's tag
    * reformat message to 75 cols
    * fix missing `u32 val`

 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68725506a095..520fe638ea00 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1064,6 +1064,29 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	}
 }
 
+/* Whack a reset.  We should wait for this.
+ * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
+ * instead of reset MAC itself.
+ */
+static void fec_ctrl_reset(struct fec_enet_private *fep, bool wol)
+{
+	u32 val;
+
+	if (!wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
+		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
+		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
+			writel(0, fep->hwp + FEC_ECNTRL);
+		} else {
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
+			udelay(10);
+		}
+	} else {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
+}
+
 /*
  * This function is called to start or restart the FEC during a link
  * change, transmit timeout, or to reconfigure the FEC.  The network
@@ -1080,17 +1103,7 @@ fec_restart(struct net_device *ndev)
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
-	/* Whack a reset.  We should wait for this.
-	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
-	 * instead of reset MAC itself.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
-	    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
-		writel(0, fep->hwp + FEC_ECNTRL);
-	} else {
-		writel(1, fep->hwp + FEC_ECNTRL);
-		udelay(10);
-	}
+	fec_ctrl_reset(fep, false);
 
 	/*
 	 * enet-mac reset will reset mac address registers too,
@@ -1344,22 +1357,7 @@ fec_stop(struct net_device *ndev)
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
-	/* Whack a reset.  We should wait for this.
-	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
-	 * instead of reset MAC itself.
-	 */
-	if (!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
-			writel(0, fep->hwp + FEC_ECNTRL);
-		} else {
-			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
-			udelay(10);
-		}
-	} else {
-		val = readl(fep->hwp + FEC_ECNTRL);
-		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
-		writel(val, fep->hwp + FEC_ECNTRL);
-	}
+	fec_ctrl_reset(fep, true);
 	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
 	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 
-- 
2.48.1



