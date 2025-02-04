Return-Path: <netdev+bounces-162439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72057A26E99
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448C518841A6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431C207A3D;
	Tue,  4 Feb 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="NpAAPG6/"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40533207A2A;
	Tue,  4 Feb 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661821; cv=none; b=ShzvUiEtpqtWVdBlz87XRJjeFcAAS9HaUk8Itf6uX3LAYDtxA+h8LFIIKn6OOOzp1w8Gxlq7xRl+icWgx4B2Lk8X7hTLfEsoPnJNJ36Kf/5FsUDfxeb8O1DH6ZzeL6vLJJlOOI40OM3txHlUfl2jENfodedO9iWCxB8fThJ/MNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661821; c=relaxed/simple;
	bh=wDHC1KEHF8DQWAcUfnfxCywjfzzoTefVOSXvL3BKXuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XUEnVDBwKbbEBATCYLoBvgGOOqPVrak/ijJx32VjgNxJCcyghl2Y1yYNpY95GvdzIB5RwsZzCTlIw4AL5i4oGsBVc1kcsN4KjGUZtAjBu15txhG+BEZT71vEwkytlFcHQ+IheK8uzzfoBagNESdFkR3b5arr7Zxbu2tE5WzJLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=NpAAPG6/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 586E0A0E19;
	Tue,  4 Feb 2025 10:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Arq9TziV6dw9WdFzvtYFlrk4miTqYDr7Y/tlevZbNFA=; b=
	NpAAPG6/A1MwPIp4sAVU5yW9PoZph/3FOiSqqBT2Vs3AZ7ih9z3Q7X1GJzlLXqwG
	cdO4wghQqQqgt91WkPSE2YyDewZse+SF4E2VzHbBpaeg0V3dMTt4ZUfBKl2+MnwI
	6ihhmquOIXXc01wyrs9ULwXnvYI7C92FxeKB5spUxWqcdfUg22OB4FMq5rFlcvY6
	q+6Atc3F5PMeQTxpBSiru67IfkfTR+vfwHjkq7HKrYI5nZ9rl2BKy+AWOvGz64/o
	HPsY9cFzgTt9Bf2+IN6kHPth5VMFwyxdzBmKDy3PUSZtwyT6YTWFfKMRdbyEcYfO
	ZwRwSBFrxo82TKHlQ2aG/3us/Bz8YnoGXLC6Cge8VXRBU70O6ktomMUaDJookx2A
	cj+a9L4VVNWPww05TCrK6XWibb1LP9/WLHRCTtCPrAYN0bVRiH/tdAveWZ48i6vx
	hiQJ+H0jEXAcrgQnEqpm4d8k2mVr5yuuULwilop3lY6nnns2zFfT5Zg/BloYJ4yG
	BFPmaO3hnhNyNSAr5xXD/NaEI7bfM6lCCvabXHmNbocNl7gnniOJmuF1vqvtZ3k2
	PYMk+TZwFHWTNj6KMmoWVpHBvWYozwiVOLiku7KYpnmwQktkPSGgTLnXHogyyHTl
	5/fuOEEs7e5iw8+geWk9VgfsIGQsjn5U0Sh51QjDqlM=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Laurent Badel <laurentbadel@eaton.com>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: fec: Refactor MAC reset to function
Date: Tue, 4 Feb 2025 10:36:03 +0100
Message-ID: <20250204093604.253436-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738661813;VERSION=7985;MC=3118175526;ID=197840;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



