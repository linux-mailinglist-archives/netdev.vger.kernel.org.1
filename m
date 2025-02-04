Return-Path: <netdev+bounces-162442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252E4A26EB6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C477818871E7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB3207DF0;
	Tue,  4 Feb 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GKZMqyk1"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9B143C5D;
	Tue,  4 Feb 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662244; cv=none; b=Aqoqm2Wwdjy5sUoRFOYRnHo+MUD5129/RsXgscFv3FVJtxDc7bOlMz8WhZ2w7PFa+ZWJQ2CIO7hRiRbjaXsEHFK1rJRt8gsR6rAk7Sae+wUvW/GfF5oD2MxlsE4VC5bn3eBehguTSes+pm9Xzc1vUlxGVoVf8y/so0DFqcnwG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662244; c=relaxed/simple;
	bh=wDHC1KEHF8DQWAcUfnfxCywjfzzoTefVOSXvL3BKXuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcrtesOrnp5pkKF4eBra7TCfclus2BsfVgSr8ymEidN5VC1ArdNyFIUar9n/apSPWmAOiVwwzZIvMm6jzKLiV5iGf8a+9WdD+RPO22NE64jxU0BfUWoMb870C3d3oMecXy8QYso0otRgmsJIGES8iQRgmlt4d8d1JOIprJvGc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GKZMqyk1; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5CC10A0031;
	Tue,  4 Feb 2025 10:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Arq9TziV6dw9WdFzvtYF
	lrk4miTqYDr7Y/tlevZbNFA=; b=GKZMqyk1lK5CbdOtG5i53YSr5Rzx7xoiaK6R
	HqIUkDuZPd9Co2B7sdhdUCWAaNFkHKbe8mYDRBc81hLBtHuLm6JG7LVLcoU/XUIO
	dibOt40w0B2CL7O3QHutDawmPcgHBRaF21KEUe1T5I7nf7mQ/Af0MpQRfPpWBY2L
	Pn9BCSfPPSjpaI/DG69uhR+20wiicbjE8oIDSfFCD4/fLrta1tXuzoc9EPN8YVai
	7HZO9++OzNKhzBwcCdF4RqKZTVmnDuInpXW37GOkXWW5n1QqqM0mP+TvFvDvrICe
	t77IgdbAE0zlmTe+uMRVvE9a95nOTS0TaZi1ELTub5UuqAd1ja93a7KDXhfUvKeQ
	dYP1kKFOFN/VBSUKI6pFLCrxhdClBxBNUcfTOSJ0DZCC2huBozBy1DDus+8oUqzV
	Nk0SBQcuuh86TdMCB9CJBvv28emZ+9jVFZNn1Y2rI2O5F/oJN9QxCxKeF2YyJxaA
	5cJYiFCGdrKpXyeWxclxrGIL9MgK4foHp+ODd6llFCfO3CA4L/3TFAIiPro9wpEL
	3imD/xXUxVxhVtVIH1srmw9iCjxOXygB5jDdOb6e/qvV1EOKOyWVI9Q5hhrCKQ0T
	AMsIwrpSJtGlE/ObmflV1Sy6tYqykDCGb/XB8s8uT0pSLaGNarElal8OuJjlFztu
	Cj7TkUE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Laurent Badel <laurentbadel@eaton.com>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3] net: fec: Refactor MAC reset to function
Date: Tue, 4 Feb 2025 10:37:54 +0100
Message-ID: <20250204093756.253642-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122163935.213313-2-csokas.bence@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738662239;VERSION=7985;MC=507896856;ID=198007;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852667366

The core is reset both in `fec_restart()` (called on link-up) and
`fec_stop()` (going to sleep, driver remove etc.). These two functions
had their separate implementations, which was at first only a register
write and a `udelay()` (and the accompanying block comment). However,
since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
meant that these implementations diverged, often causing bugs.

For instance, as of now, `fec_stop()` does not check for
`FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
a PM power-down event; and `fec_restart()` missed the refactor renaming
the "magic" constant `1` to `FEC_ECR_RESET`.

To harmonize current implementations, and eliminate this source of
potential future bugs, refactor implementation to a common function.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
Fixes: ff049886671c ("net: fec: Refactor: #define magic constants")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Recommended options for this patch:
    `--color-moved --color-moved-ws=allow-indentation-change`
    Changes in v2:
    * collect Michal's tag
    * reformat message to 75 cols
    * fix missing `u32 val`
    Changes in v3:
    * rename parameter to `allow_wol`
    Changes in v3:
    * clarify message
    * collect Jacob's tag
    * rebased onto c2933b2befe2

 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f7c4ce8e9a26..a86cfebedaa8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1093,6 +1093,29 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	}
 }
 
+/* Whack a reset.  We should wait for this.
+ * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
+ * instead of reset MAC itself.
+ */
+static void fec_ctrl_reset(struct fec_enet_private *fep, bool allow_wol)
+{
+	u32 val;
+
+	if (!allow_wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
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
@@ -1109,17 +1132,7 @@ fec_restart(struct net_device *ndev)
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
@@ -1373,22 +1386,7 @@ fec_stop(struct net_device *ndev)
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



