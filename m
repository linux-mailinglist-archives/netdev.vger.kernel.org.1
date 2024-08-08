Return-Path: <netdev+bounces-116911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57B94C112
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D73B1F29C3B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736B190052;
	Thu,  8 Aug 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ERFQ86ou"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD018FC93
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130660; cv=none; b=nQ51C8Zzv/3SlEFJCkWaJ8tgF1QUBfi2zu3tIbtYRbm4irsBPrmwxlnQTEN8JndmIOgkQRJg1T5XN8hphosWhuU6zUOrtxGHkw0RI0hKtayiU0RyLMwsrRlTVv2T774YKpVMdywkWmQSKFujTIwUQteCQcJDGGQ58o5eLBoZFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130660; c=relaxed/simple;
	bh=/FwBY7ZLw3tlVtJI5q4uhU83jgrSj98/jpIQWivVw68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILJQVoPBbwJh3U9+HKMEqsD5l0s+NlEXaftlkhyk+1ytBeFEMB/D8z1qtvO8pNWkLAeoSOI7qlJaHtifo5piUY/DsS1NF0D4VC8qJhTdKCPmU8DgPELVzR7RYqq2jZ37ySMjvv/NJGS3JfFqog2uzvx9++wKWipxL+U9d7xhcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ERFQ86ou; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1B1909C53C0;
	Thu,  8 Aug 2024 11:14:31 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LAhwhicIfrvB; Thu,  8 Aug 2024 11:14:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 659119C53C1;
	Thu,  8 Aug 2024 11:14:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 659119C53C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723130070; bh=zVsgPi90M/Pt73vL/QH4PbHoVsdzx/aG5TBXet43/wQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ERFQ86oucMU7xczNVeQ57rxoajHPowAfdU3MSY/qzjDpPOnJscfUFoxuCnfl7/pc1
	 OKOR+rU3ypqTdpXlmklEdxV+sSS83MFClHOtm1jnzEVsF2DJsbUkc07QHmR2pr9L7A
	 cm1i62dLcJWF9gWofopaF9qXfAxCn9WPLA9zgvc1lSYl70PeIoO7HQDHEZRTsjwa57
	 RPyYgMvTHb2N1GIO+T9aYgNAeFd5JHNpjFrwWZmvn2OMX+24pdzQvxW4xJk1lSIPuF
	 GZ3THL3henKbEVscZhNtwhCJT+D+4k+mb+zAzJTkVHABkQc9vrkKUmaFa/uQKCV0sS
	 mCjVCzGR8SAng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id JRi4UprVAsVH; Thu,  8 Aug 2024 11:14:30 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 084619C53C0;
	Thu,  8 Aug 2024 11:14:28 -0400 (EDT)
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
Subject: [PATCH v2 net-next] net: dsa: microchip: ksz9477: split half-duplex monitoring function
Date: Thu,  8 Aug 2024 15:14:21 +0000
Message-Id: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>

---
v2:
 - added line breaks after return statements
 - removed Fixed-by: tag
v1: https://lore.kernel.org/netdev/20240708084934.131175-1-enguerrand.de-=
ribaucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c | 91 +++++++++++++++++------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index 425e20daf1e9..1e2293aa00dc 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -427,54 +427,71 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int=
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
+
+		ret =3D ksz_read32(dev, REG_PMAVBC, &pmavbc);
+		if (ret)
+			return ret;
+
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
+
+	if (!(FIELD_GET(PORT_INTF_SPEED_MASK, status)
+	      =3D=3D PORT_INTF_SPEED_NONE) &&
+	    !(status & PORT_INTF_FULL_DUPLEX)) {
+		ret =3D ksz9477_half_duplex_monitor(dev, port, tx_late_col);
+	}
+
 	return ret;
 }
=20
--=20
2.34.1


