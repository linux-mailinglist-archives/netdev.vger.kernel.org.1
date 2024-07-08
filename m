Return-Path: <netdev+bounces-109777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75028929E8A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DB2830F1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1FB48CCD;
	Mon,  8 Jul 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="xpELG5c4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756A13ACC
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429039; cv=none; b=CSqyPoId1xF0lwFyu37G/GsACUJzizQbU36tuYyXaCIdr5mfinlGUrQicXZtPPSdeJzcJrJHJ9MWF/JuHlzMmMnxeU1aFu7d+iANMpm6RO38qjr0aQhy/BwZwnfT0lwkqwkZFpUB0C1Wve4XGkJ4wogLGpB5CHVjg/iuxs/N6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429039; c=relaxed/simple;
	bh=/XNEay0bXlPfJR8QlzVbpJIt3AXmsbuuyz1JPaee4Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AeCqv9y8bPVsbaLldpH/nvqRUnZAeFOYCBdKY5uxAXMzf5Lb57zjy48za9sVss5gsPZrkt4DV6HMciVmod9cdCOYVWKCsE2+wf87PVJaEGEfjAnZCJb+Iu+WqKhm93aJfBlQxXIB2fEkBXGcaffrtPG/CvjcGb04v/yCfxkPF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=xpELG5c4; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 26CA39C5C76;
	Mon,  8 Jul 2024 04:49:43 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id nPwjnMNO1L8l; Mon,  8 Jul 2024 04:49:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DA0989C5D1E;
	Mon,  8 Jul 2024 04:49:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DA0989C5D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1720428581; bh=wv2/0DwinvHaahBizP8ndg6WcyGOX63+9+XESb7qK7Q=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=xpELG5c4lz8yG+TQ4VuVBOVGjxj0N+BqTj/FOqf6jKb5AIVWhPPD7hzyyx6F4oV9b
	 lLvFp5U8M92MiRyVHZBH7atgB66iOTASRW/ftyQsewb0K72JTfnbC/dZsFOAaSrCvm
	 n1d6JLOE3DLDbVhxdFD+YssKnRlG3O9MZUxFUmuRmk4vm2VSo/H+gh2av0p5apEiHR
	 DyW+4uMbwOGrIp9MUu9Dp2MzL2EnsPiykgXtLh+uZ7Yhs5SeKRHdkWVD4QdPlK2Fb9
	 UO2i1Df0tYsF3u3nIpfONlEfnczPAyFivyvgteUlK/gxZT03aSaGkCzqc+KcLz2N+x
	 CNysnqst3/dTg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vadIxbmTuNGv; Mon,  8 Jul 2024 04:49:41 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 70EB09C4232;
	Mon,  8 Jul 2024 04:49:40 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	kuba@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	horms@kernel.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net-next] net: dsa: microchip: ksz9477: split half-duplex monitoring function
Date: Mon,  8 Jul 2024 10:49:34 +0200
Message-Id: <20240708084934.131175-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In order to respect the 80 columns limit, split the half-duplex
monitoring function in two.

This is just a styling change, no functional change.

Fixes: bf1bff11e497 ("net: dsa: microchip: monitor potential faults in ha=
lf-duplex mode")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 87 +++++++++++++++++------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index 425e20daf1e9..17f6deb3c598 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -427,54 +427,67 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int=
 port, bool freeze)
 	mutex_unlock(&p->mib.cnt_mutex);
 }
=20
-int ksz9477_errata_monitor(struct ksz_device *dev, int port,
-			   u64 tx_late_col)
+static int ksz9477_half_duplex_monitor(struct ksz_device *dev, int port,
+				       u64 tx_late_col)
 {
+	u8 lue_ctrl;
 	u32 pmavbc;
-	u8 status;
 	u16 pqm;
 	int ret;
=20
-	ret =3D ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
+	/* Errata DS80000754 recommends monitoring potential faults in
+	 * half-duplex mode. The switch might not be able to communicate anymor=
e
+	 * in these states. If you see this message, please read the
+	 * errata-sheet for more information:
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents
+	 * /UNG/ProductDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
+	 * To workaround this issue, half-duplex mode should be avoided.
+	 * A software reset could be implemented to recover from this state.
+	 */
+	dev_warn_once(dev->dev,
+		      "Half-duplex detected on port %d, transmission halt may occur\n"=
,
+		      port);
+	if (tx_late_col !=3D 0) {
+		/* Transmission halt with late collisions */
+		dev_crit_once(dev->dev,
+			      "TX late collisions detected, transmission may be halted on por=
t %d\n",
+			      port);
+	}
+	ret =3D ksz_read8(dev, REG_SW_LUE_CTRL_0, &lue_ctrl);
 	if (ret)
 		return ret;
-	if (!(FIELD_GET(PORT_INTF_SPEED_MASK, status) =3D=3D PORT_INTF_SPEED_NO=
NE) &&
-	    !(status & PORT_INTF_FULL_DUPLEX)) {
-		/* Errata DS80000754 recommends monitoring potential faults in
-		 * half-duplex mode. The switch might not be able to communicate anymo=
re
-		 * in these states.
-		 * If you see this message, please read the errata-sheet for more info=
rmation:
-		 * https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Prod=
uctDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
-		 * To workaround this issue, half-duplex mode should be avoided.
-		 * A software reset could be implemented to recover from this state.
-		 */
-		dev_warn_once(dev->dev,
-			      "Half-duplex detected on port %d, transmission halt may occur\n=
",
-			      port);
-		if (tx_late_col !=3D 0) {
-			/* Transmission halt with late collisions */
-			dev_crit_once(dev->dev,
-				      "TX late collisions detected, transmission may be halted on po=
rt %d\n",
-				      port);
-		}
-		ret =3D ksz_read8(dev, REG_SW_LUE_CTRL_0, &status);
+	if (lue_ctrl & SW_VLAN_ENABLE) {
+		ret =3D ksz_pread16(dev, port, REG_PORT_QM_TX_CNT_0__4, &pqm);
 		if (ret)
 			return ret;
-		if (status & SW_VLAN_ENABLE) {
-			ret =3D ksz_pread16(dev, port, REG_PORT_QM_TX_CNT_0__4, &pqm);
-			if (ret)
-				return ret;
-			ret =3D ksz_read32(dev, REG_PMAVBC, &pmavbc);
-			if (ret)
-				return ret;
-			if ((FIELD_GET(PMAVBC_MASK, pmavbc) <=3D PMAVBC_MIN) ||
-			    (FIELD_GET(PORT_QM_TX_CNT_M, pqm) >=3D PORT_QM_TX_CNT_MAX)) {
-				/* Transmission halt with Half-Duplex and VLAN */
-				dev_crit_once(dev->dev,
-					      "resources out of limits, transmission may be halted\n");
-			}
+		ret =3D ksz_read32(dev, REG_PMAVBC, &pmavbc);
+		if (ret)
+			return ret;
+		if ((FIELD_GET(PMAVBC_MASK, pmavbc) <=3D PMAVBC_MIN) ||
+		    (FIELD_GET(PORT_QM_TX_CNT_M, pqm) >=3D PORT_QM_TX_CNT_MAX)) {
+			/* Transmission halt with Half-Duplex and VLAN */
+			dev_crit_once(dev->dev,
+				      "resources out of limits, transmission may be halted\n");
 		}
 	}
+
+	return ret;
+}
+
+int ksz9477_errata_monitor(struct ksz_device *dev, int port,
+			   u64 tx_late_col)
+{
+	u8 status;
+	int ret;
+
+	ret =3D ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
+	if (ret)
+		return ret;
+	if (!(FIELD_GET(PORT_INTF_SPEED_MASK, status)
+	      =3D=3D PORT_INTF_SPEED_NONE) &&
+	    !(status & PORT_INTF_FULL_DUPLEX)) {
+		ret =3D ksz9477_half_duplex_monitor(dev, port, tx_late_col);
+	}
 	return ret;
 }
=20
--=20
2.34.1


