Return-Path: <netdev+bounces-163942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE74A2C244
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC41889BBC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B11DF738;
	Fri,  7 Feb 2025 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hbmmYScl"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304B1DEFDC;
	Fri,  7 Feb 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930414; cv=none; b=or62JOQQ2crzA54tjqADr9Np/NEb76AVhDZ4MBxdEcylk8t1aIwu0jFuYyBqfyPKQLXV3OtuL8IRspaXoP6lPVBdZ+/4fefcylZWC7Hi7u0k7nThmQDX9Z+ZIFxRH/Tn3edllZBUSA6hLU5d1LqHRCcCo0hVk4KmzbFwanviUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930414; c=relaxed/simple;
	bh=UgGDfz4QxlxB7uGN8UyOKQSTzMDA+3Otn6I41VTV8cA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ty+ZZzfauGkUO+90JmBm5KlVxaPxBr1djib2b4iyBEQrru1mSZL2FbfApOiF0ROxjbZ6lnhqm7C/KALiJF5dqyCXJVONvGsNKjZMoe9nO2q7qNYzp/DJSNv4dCIeIB6c7kjTT6gB/y6CutWklLzG1pQZXAdHfXmdCbQgrZnohpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hbmmYScl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BB49AA0155;
	Fri,  7 Feb 2025 13:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=9OWJCfb9mBLeS+qmNVaUT+6UZW8yr/J2AZVV36sD2ZM=; b=
	hbmmYSclNOifu72HvKJxj6Y5pZNFpH6l4kkirtkjOaoTZiSI7K3JJAUx8Pa3SXq+
	mdf8oDbbSLODUF38fKCw0nGjT/imQ/ZCqHImbjtST5Av33AEF2xuSnMRQVnJEaVV
	7yBq17zEmanhUQdwMksLjcRS6CAQTLnTM6VpiNQPdzd7xuyayyMTpwZyMJTNAKso
	bxR2R2EZyLfukKSKdvGy9BfIQiXk0E+0pNT644TuNfEa4jS+4+batQACg9oXVLeH
	00FXDQk41hra3YYyEi3QMXIHacJqmEI3H9Ta8JFpToX05GGly/uyXWUo01MBiQR8
	ktIS65aCK+9sJUnVuVGn7rcq65TWPOCXAoXMZt1As9uVHV1vxd5f/GQHdTvMshN5
	fElzM0reZ1kyBJ2vGSMG/KRCaBfuUa86hfYri9Sf+mkb4YjolUlbbftrg6NvGL8b
	4m/dsJyeK492Ix9v9RnaoM+7yZit0YD4PPzwBmzTZnWpR13Jq+mJrz3YtYXMrOlc
	gFruXYe7sMO19gdVizP/2P8joDU51Lr9JNcYrmSrWK+ctVgGhl+kQ5514aYWa6gv
	mn6sYR8uiBV4oxnmSXhoC3PnZO0ZE6EDAhC/jR7QQp6oB6HYqq8kJKOTPdqQU2cG
	5I62Vbc/hrgsci1ULrMGQblwR116tSu2GaIvWIFI3P4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4] net: fec: Refactor MAC reset to function
Date: Fri, 7 Feb 2025 13:12:55 +0100
Message-ID: <20250207121255.161146-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738930407;VERSION=7985;MC=1996129542;ID=399764;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852617560

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
Reviewed-by: Simon Horman <horms@kernel.org>
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
    Changes in v4:
    * collect Simon's tag
    * rebased again
    * drop Fixes:, target net-next

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
 

base-commit: 26db4dbb747813b5946aff31485873f071a10332
-- 
2.48.1



