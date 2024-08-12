Return-Path: <netdev+bounces-117606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94694E82B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D41282674
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A614D28F;
	Mon, 12 Aug 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="m1oYkBjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D355896
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449776; cv=none; b=VF/JKthmHOVWEUnpvemizeNZiBWcsOCnCVwi3/0eq8ktshT0OtS3TwxMPJJ5vJb8Sy9fe4xMocH64KAYJgLhtqs/moKPdRF/16HTQswXkjNgaaJCHtVhngPabIslbpIqWx2q75CF4/gc7gzE6d3MrPvh4l0oIYdOq+/COOdDp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449776; c=relaxed/simple;
	bh=ZcsmFZTv7pEr+UvQDjqCyUmEAgbHMpgJcT8lWQsz9r0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+41Qng5DnV0MdNM3X5aW0NLIlZkrrpMiN2Itj+qeYeiPzM0JSZoaksdj/BJlq7PXHp8WlLCGHezgA9yOQVKO5SzoAzW2003ohVdMwplcqLpLCMrsR9OdbhAbZrTLUZ1aoadyuXGZCB9vUKwp4jtX62JcHh5gSKOk9ZalgUqGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=m1oYkBjy; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2C5EC9C56BD;
	Mon, 12 Aug 2024 04:02:45 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TLTZlj57Waqc; Mon, 12 Aug 2024 04:02:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D3A2C9C5F1F;
	Mon, 12 Aug 2024 04:02:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D3A2C9C5F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723449762; bh=nUY78wg0wPOyUqBpekydQWZAWR7zeDAoThrx/D+A2rY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=m1oYkBjy1HSMLJNoe13m2zkzJKZ3BJkktRFoFb+KTv6dtIcydm8dKWKG2J3LbECAB
	 K9P+ad6ohQL7Sr56JoxoBV3F0JzuV6jLky5EvR1Nw9cQszozpxsSI4FQXXSEUORFdR
	 SsjmnqDm+iv9qILxm0R7UEVqp6eqXTaZRUUdNeJL6a+1+Jg2xwJ6FdUYAaul8QklUO
	 x6ZZvYRoq03n4tUiKkZzZVZWcTMXJ3Hhgl91bwLjCam5tgpv0gkLwb2rjsfmaFU+lf
	 QZelL36/SouTvOQLp8fSJl+u8jkcYSHxjuoacDi1WSY3uPbYjFyT1OWINTyKIZd3kn
	 mj7c8PUlyP62A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2rT9iZWAgDWc; Mon, 12 Aug 2024 04:02:42 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 413849C56BD;
	Mon, 12 Aug 2024 04:02:41 -0400 (EDT)
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
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH v3 net-next] net: dsa: microchip: ksz9477: split half-duplex monitoring function
Date: Mon, 12 Aug 2024 08:02:13 +0000
Message-Id: <20240812080212.26558-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3:
 - keep URL on one line
v2: https://lore.kernel.org/netdev/20240808151421.636937-1-enguerrand.de-=
ribaucourt@savoirfairelinux.com/
 - added line breaks after return statements
 - removed Fixed-by: tag
v1: https://lore.kernel.org/netdev/20240708084934.131175-1-enguerrand.de-=
ribaucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c | 90 +++++++++++++++++------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index 425e20daf1e9..755de092b2c2 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -427,54 +427,70 @@ void ksz9477_freeze_mib(struct ksz_device *dev, int=
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
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Produ=
ctDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
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


