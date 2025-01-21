Return-Path: <netdev+bounces-160016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0F1A17C03
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC143A1DE3
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E11C1F07;
	Tue, 21 Jan 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="F6syjK2V"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DEA1BEF82;
	Tue, 21 Jan 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456018; cv=none; b=ZMOwDYSZyKLf2EJIaCUevOCfjodHutU1iXrXii2EOT/qzMNyqBEfSJidYsHYo9O3Jshu2/fEVdkFsbFuTu3y7pdswmSgXNHWvkSufOKmBwpKUzBW5uxAWSQdrR5pApghhR8RTD/dSO8uuernkY8MwCbszG6YEe+LoLp+LptyqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456018; c=relaxed/simple;
	bh=/RFiy4KtEw5Ld7rO4MkJaBpq1+J6T2aRdGYD70o1fXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aVjaQkXWndCQDEm1hWCGLPJeREULOj+mXqLK6abgqGYDLf1Flk/ufHKGq9rXeTbMjz1Gqht6VNr3Ei1cf/k/N0vMYCXeVmg2cKfk0OBXd0/7PDqXOOXvCyU5z5seBHZYT3pDkIyTcMbJQJLK6m1/Cvq0Yhvcv5RN039/iIlQkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=F6syjK2V; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A0A0CA03A7;
	Tue, 21 Jan 2025 11:40:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=64Jisw5Z95VY9Aga6b+rI9eNqwppYLgNfZ35UeF2PNs=; b=
	F6syjK2VoHGpQWXERUmfUB1AGH6A+6LwFcM/V6pS0PReVdZmPY3T7Ic55i1fKc3P
	KaLU6OooxdhWnj5O0YOkI2+Gx0uld9GMf/NAjqYszEhZydGHEBeknTKlCHBqJKx/
	5iMykh2mSBEBvpkoGvK5t75KlBop3MbS2SuHwiBqA7CmVZ9VBh3SiwkUcnTRBZ11
	RpjR9CZcEoZWcsITosvF28HiTQPnmOlRkrpQku8Z1hlOrYBkEmzKHSbK0RNotIHH
	3SK7UnMnd6FioXs6HZLJoav8LGYExLhBG4LMU8g8lXelPpKoaI9UQzsQUXysq6+O
	+hREwmfcVlWZSijN5da5V3olw97BhIdtnoaYwMegM7zcOJGqJq9Y7lcbm/xxbvVn
	K7U2HEpuYD97yYbuAPz0ep+zIo8F9euHLciifqEP3MbgJkW0uQT/r0qNrf92YrxE
	5J4B9rTrclwg0AD3a5h/RiaqkhSjA9F+P0lOdTyGEEkdJwzpxOIFJYJtcWEEhHEB
	A/biMararsd3i49S3D5w5kbUM81838uhG2Z+or20XMMFWzRzAtLokpumEdIWXvMJ
	2pplw5FUauuCHvM0op4++UvchjzzvmfztPH2f9UWWktbE8kV0PlxuMbBTkkG9nh6
	zzkcQLzx4NglWacF3n0uJBRzloTZ4AKsokOqOyNq+W4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Jakub Kicinski <kuba@kernel.org>, Laurent Badel <laurentbadel@eaton.com>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
Subject: [PATCH] net: fec: Refactor MAC reset to function
Date: Tue, 21 Jan 2025 11:38:58 +0100
Message-ID: <20250121103857.12007-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737456004;VERSION=7983;MC=537548373;ID=63783;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852677467

The core is reset both in `fec_restart()`
(called on link-up) and `fec_stop()`
(going to sleep, driver remove etc.).
These two functions had their separate
implementations, which was at first only
a register write and a `udelay()` (and
the accompanying block comment).
However, since then we got soft-reset
(MAC disable) and Wake-on-LAN support,
which meant that these implementations
diverged, often causing bugs. For instance,
as of now, `fec_stop()` does not check for
`FEC_QUIRK_NO_HARD_RESET`. To eliminate
this bug-source, refactor implementation
to a common function.

Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Recommended options for this patch:
    `--color-moved --color-moved-ws=allow-indentation-change`

 drivers/net/ethernet/freescale/fec_main.c | 50 +++++++++++------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68725506a095..850ef3de74ec 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1064,6 +1064,27 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	}
 }
 
+/* Whack a reset.  We should wait for this.
+ * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
+ * instead of reset MAC itself.
+ */
+static void fec_ctrl_reset(struct fec_enet_private *fep, bool wol)
+{
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
@@ -1080,17 +1101,7 @@ fec_restart(struct net_device *ndev)
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
@@ -1344,22 +1355,7 @@ fec_stop(struct net_device *ndev)
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



