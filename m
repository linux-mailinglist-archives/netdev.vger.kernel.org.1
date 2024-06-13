Return-Path: <netdev+bounces-103277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E59075B9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56451F24E63
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D91146A90;
	Thu, 13 Jun 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b="cH6pEtt/"
X-Original-To: netdev@vger.kernel.org
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5157914659F;
	Thu, 13 Jun 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.98.226.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290315; cv=none; b=mhglsf1QVSU73fyal12jIYSN2i7Gr+UMqL3R1KJAW7BhhWXAcTjfFraJ1NRB08XXfLK3JoS7uV9EPCuFDxpGh3CpGG+oiI6lLoG8aPFsieDc5kGPH10wZlVT5ctE+hpFBy0Ho83wkqLoI4KM8Hm0z3ofF9JqQxxHq1hy//HnAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290315; c=relaxed/simple;
	bh=cW6lVNRGSRj11+IEBD3FMIg7WaF5vxI7Ce5hhtb4xoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuN9eK3TkhIZMa+mlYYtnKKjOh0+n05lmlb4Gf92EXsDz2oRRXRBjXa9Y61bSAh/Q+PzR85qBfYVZJ6md8Qqzg9OqITxkngtwz3XZ9o96LCCb4h92m3iTud7UZYNzIVwzr9wjsCdYxJcwmV01M29B2ZEcBGLLBU1+D1VF66MD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com; spf=pass smtp.mailfrom=ubimet.com; dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b=cH6pEtt/; arc=none smtp.client-ip=141.98.226.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubimet.com
Received: from localhost (localhost [127.0.0.1])
	by mx2-at.ubimet.com (Postfix) with ESMTP id 9C88E8118E;
	Thu, 13 Jun 2024 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
	s=20200131mdel; t=1718290311;
	bh=cW6lVNRGSRj11+IEBD3FMIg7WaF5vxI7Ce5hhtb4xoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cH6pEtt/x34MtLYjpQCR5qQXzZnvkaIydd0JjkTqB6HyjtFBJmgYQWKyNpevUHc+0
	 bINRwMLQHggMLhXgDG1/k3I1G3MBuUepWzp/Fs8uZsaROU8Y3rnUJTnbuFYbiLsB6m
	 ldpcRCz4IzvrBjq4qDSQBxmMUBv6U3jNkGw03I1Nw/N2ig1lP5aVBbHIHua08PQFwh
	 v+GEXodRW99JT1fY19qv7OySz0/sM5uN4UjsrXnxmGAGHvk7MIX0SZma8F+ceeBOtj
	 KAsPIaQIVOWLIVVcJyOHtPCbKv6F77JA39mDxCdTBSwj1SPDlLmjJH2jAZxCH+QxdJ
	 QPK1SZ5C31Anw==
Received: from mx2-at.ubimet.com ([127.0.0.1])
	by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hmKLeBIclgYy; Thu, 13 Jun 2024 14:51:51 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (zimbra-mta01.ext.dc.at.ubimet.com [10.1.18.22])
	by mx2-at.ubimet.com (Postfix) with ESMTPS id 8EF1D8118D;
	Thu, 13 Jun 2024 14:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 7A03580771;
	Thu, 13 Jun 2024 14:51:51 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 60i-LECkLL_8; Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 4707880782;
	Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id z1hbTpRenKp5; Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
Received: from pcn112.wl97.hub.at.ubimet.com (pcn112.it.hub.at.ubimet.com [10.15.66.143])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id E8FA080771;
	Thu, 13 Jun 2024 14:51:49 +0000 (UTC)
From: =?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>
To: 
Cc: jrodrigues@ubimet.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/3] net: phy: dp83867: Add support for amplitude graph
Date: Thu, 13 Jun 2024 16:51:53 +0200
Message-Id: <20240613145153.2345826-4-jrodrigues@ubimet.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613145153.2345826-1-jrodrigues@ubimet.com>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Output the raw information of each segment.
Each segment also comes with the distance information,
but this does not map to the current output.

Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
---
 drivers/net/phy/dp83867.c | 86 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index ff8c97a29195..e56a892d3da7 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -54,6 +54,8 @@
 #define DP83867_RXFSOP2	0x013A
 #define DP83867_RXFSOP3	0x013B
 #define DP83867_IO_MUX_CFG	0x0170
+#define DP83867_TDR_GEN_CFG2	0x0181
+#define DP83867_TDR_GEN_CFG4	0x0185
 #define DP83867_TDR_GEN_CFG5	0x0186
 #define DP83867_TDR_GEN_CFG6	0x0187
 #define DP83867_TDR_GEN_CFG7	0x0189
@@ -223,6 +225,8 @@ struct dp83867_private {
 	bool set_clk_output;
 	u32 clk_output_sel;
 	bool sgmii_ref_clk_en;
+	bool cable_test_tdr;
+	s8 pair;
 };
=20
 /* Register values are converted to SNR(dB) as suggested by
@@ -1068,7 +1072,7 @@ static u32 dp83867_cycles2cm(u32 cycles)
 	return cycles * 8 * 20;
 }
=20
-static int dp83867_cable_test_start(struct phy_device *phydev)
+static int dp83867_cable_test_common(struct phy_device *phydev)
 {
 	int ret;
=20
@@ -1082,11 +1086,38 @@ static int dp83867_cable_test_start(struct phy_de=
vice *phydev)
 	if (ret < 0)
 		return ret;
=20
-	ret =3D phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_TDR_GEN_CFG5,
-			    DP83867_TDR_GEN_CFG5_FLAGS);
+	return phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_TDR_GEN_CFG5,
+			     DP83867_TDR_GEN_CFG5_FLAGS);
+}
+
+static int dp83867_cable_test_start(struct phy_device *phydev)
+{
+	struct dp83867_private *priv =3D phydev->priv;
+	int ret;
+
+	ret =3D dp83867_cable_test_common(phydev);
+	if (ret < 0)
+		return ret;
+
+	priv->cable_test_tdr =3D false;
+
+	return phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_CFG3,
+			     DP83867_TDR_START);
+}
+
+static int dp83867_cable_test_tdr_start(struct phy_device *phydev,
+					const struct phy_tdr_config *cfg)
+{
+	struct dp83867_private *priv =3D phydev->priv;
+	int ret;
+
+	ret =3D dp83867_cable_test_common(phydev);
 	if (ret < 0)
 		return ret;
=20
+	priv->cable_test_tdr =3D true;
+	priv->pair =3D cfg->pair;
+
 	return phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_CFG3,
 			     DP83867_TDR_START);
 }
@@ -1105,9 +1136,14 @@ static int dp83867_cable_test_report_trans(struct =
phy_device *phydev, s8 pair,
=20
 	for (i =3D number_peaks; i >=3D 0; --i) {
 		if (peak_value[i] > threshold) {
-			fault_location =3D
-				dp83867_cycles2cm(peak_location[i] -
+			if (peak_location[i] >=3D DP83867_TDR_OFFSET) {
+				fault_location =3D dp83867_cycles2cm(peak_location[i] -
 					DP83867_TDR_OFFSET) / 2;
+			} else {
+				phydev_dbg(phydev, "Returned TDR fault location is too low");
+				fault_location =3D dp83867_cycles2cm(peak_location[i]) / 2;
+			}
+
 			if (peak_sign[i] =3D=3D 1) {
 				fault_rslt =3D
 					ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
@@ -1208,6 +1244,39 @@ static int dp83867_read_tdr_registers(struct phy_d=
evice *phydev, s8 pair,
 	return 0;
 }
=20
+static int dp83867_simplified_amplitude_graph(struct phy_device *phydev)
+{
+	struct dp83867_private *priv =3D phydev->priv;
+	int peak_sign[5];
+	int peak_loc[ARRAY_SIZE(peak_sign)];
+	int peak_val[ARRAY_SIZE(peak_sign)];
+	int i;
+	int mV;
+	int ret;
+	s8 pair;
+
+	for (pair =3D ETHTOOL_A_CABLE_PAIR_A; pair <=3D ETHTOOL_A_CABLE_PAIR_D;
+			pair++) {
+		if (priv->pair !=3D PHY_PAIR_ALL && pair !=3D priv->pair)
+			continue;
+
+		ret =3D dp83867_read_tdr_registers(phydev, pair, peak_loc,
+						 peak_val, peak_sign,
+						 ARRAY_SIZE(peak_sign));
+		if (ret < 0)
+			return ret;
+
+		for (i =3D 0; i < ARRAY_SIZE(peak_loc); i++) {
+			mV =3D peak_val[i];
+			if (peak_sign[i])
+				mV *=3D -1;
+
+			ethnl_cable_test_amplitude(phydev, pair, mV);
+		}
+	}
+	return 0;
+}
+
 static int dp83867_cable_test_report_pair(struct phy_device *phydev, s8 =
pair)
 {
 	int peak_sign[5];
@@ -1242,6 +1311,7 @@ static int dp83867_cable_test_report(struct phy_dev=
ice *phydev)
 static int dp83867_cable_test_get_status(struct phy_device *phydev,
 					 bool *finished)
 {
+	struct dp83867_private *priv =3D phydev->priv;
 	int ret;
=20
 	*finished =3D false;
@@ -1258,7 +1328,10 @@ static int dp83867_cable_test_get_status(struct ph=
y_device *phydev,
 	if (ret & DP83867_TDR_FAIL)
 		return -EBUSY;
=20
-	return dp83867_cable_test_report(phydev);
+	if (priv->cable_test_tdr)
+		return dp83867_simplified_amplitude_graph(phydev);
+	else
+		return dp83867_cable_test_report(phydev);
 }
=20
 static int dp83867_get_sqi(struct phy_device *phydev)
@@ -1478,6 +1551,7 @@ static struct phy_driver dp83867_driver[] =3D {
 		.set_loopback	=3D dp83867_loopback,
=20
 		.cable_test_start	=3D dp83867_cable_test_start,
+		.cable_test_tdr_start	=3D dp83867_cable_test_tdr_start,
 		.cable_test_get_status	=3D dp83867_cable_test_get_status,
=20
 		.led_brightness_set =3D dp83867_led_brightness_set,
--=20
2.25.1


