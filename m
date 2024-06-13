Return-Path: <netdev+bounces-103276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E829075B7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E88A1C20491
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7E1465B4;
	Thu, 13 Jun 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b="iwtSTx9J"
X-Original-To: netdev@vger.kernel.org
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2565145FFC;
	Thu, 13 Jun 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.98.226.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290313; cv=none; b=rN6s/2qeBGkYzvQGA9W8N/Dre51gaok4fjXSyajZjv8VhmRxaLFtF8UGkDq4HJx3sIPRT6AiziEyNPLvrfSjMZrGpKSC7pcBy5G73uzBSk+HZ9c+tbhPoEh62hAWrxKi5iHhoj6k5CC4NpqKsWzuNZygsiz7AnWn1DlMkV2dFW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290313; c=relaxed/simple;
	bh=dCOgK4sfEtIQpb4RENghRtBqFmwAJPeeYxG6sUQTPdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHpiySHHh9T88NVRa8krp2uDDGMdyd3IUoAShBnffoPDx8ielaMypvACcZ5KXS7baHq4tuLhc+PJQ8nHMxJUzwahqKkRRc4iuIOqjgavb4CRorJRBpTtgTTdjqLO91S0k/etPU9Ofdkry+o3F9lf2N6s+4X5i8FOiP3v6I0yVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com; spf=pass smtp.mailfrom=ubimet.com; dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b=iwtSTx9J; arc=none smtp.client-ip=141.98.226.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubimet.com
Received: from localhost (localhost [127.0.0.1])
	by mx2-at.ubimet.com (Postfix) with ESMTP id 44CA281189;
	Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
	s=20200131mdel; t=1718290310;
	bh=dCOgK4sfEtIQpb4RENghRtBqFmwAJPeeYxG6sUQTPdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwtSTx9J3xUieRImFoua/WutLs3bBXAdgbVLLpi/pAuptT2kucUA+E6nBXD/O21ar
	 VBsLUeZd5hQ2Q/uAgaPZ9fMb4xqJjjE8ygOgFwSkf6TCkD/oPCikFc4RDX4K8Jn5pU
	 SVawoKoygB+vCQdegHov37G9vdRB/UwqBRIXwP66R0OgsM2s5DTCdtQ0ozTJDRH519
	 BKYzvYz38xX+RedqC09Ey5AmHDHEpSkw2EYfRu9YtFE0bylntA6nJpXmciu4f0qjPT
	 bDpXdCq0G4RLxCo0zPciB1b06dlVvE4oyVRBmgPPeoDu2iz/CBq/gvbCJCnPW+cu/x
	 9QqSV6+h7Imfw==
Received: from mx2-at.ubimet.com ([127.0.0.1])
	by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c2BAvqS2Cf8P; Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (webmail-dc.at.ubimet.com [10.1.18.22])
	by mx2-at.ubimet.com (Postfix) with ESMTPS id 35C6481187;
	Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 1EB3D8079E;
	Thu, 13 Jun 2024 14:51:50 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 8a9BZDVDmpnA; Thu, 13 Jun 2024 14:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id A8AC680782;
	Thu, 13 Jun 2024 14:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2WRalMuHULtR; Thu, 13 Jun 2024 14:51:48 +0000 (UTC)
Received: from pcn112.wl97.hub.at.ubimet.com (pcn112.it.hub.at.ubimet.com [10.15.66.143])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 69B0580771;
	Thu, 13 Jun 2024 14:51:48 +0000 (UTC)
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
Subject: [PATCH net-next 2/3] net: phy: dp83867: add cable test support
Date: Thu, 13 Jun 2024 16:51:52 +0200
Message-Id: <20240613145153.2345826-3-jrodrigues@ubimet.com>
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

TI DP83867 returns TDR information into 5 segments
for each of the cable.
Implement the testing based on "Time Domain Reflectometry with DP83867
and DP83869"

Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
---
 drivers/net/phy/dp83867.c | 228 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 5741f09e29cb..ff8c97a29195 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -5,6 +5,7 @@
  */
=20
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
@@ -53,6 +54,14 @@
 #define DP83867_RXFSOP2	0x013A
 #define DP83867_RXFSOP3	0x013B
 #define DP83867_IO_MUX_CFG	0x0170
+#define DP83867_TDR_GEN_CFG5	0x0186
+#define DP83867_TDR_GEN_CFG6	0x0187
+#define DP83867_TDR_GEN_CFG7	0x0189
+#define DP83867_TDR_PEAKS_LOC_1	0x0190
+#define DP83867_TDR_PEAKS_AMP_1	0x019A
+#define DP83867_TDR_GEN_STATUS	0x01A4
+#define DP83867_TDR_PEAKS_SIGN_1	0x01A5
+#define DP83867_TDR_PEAKS_SIGN_2	0x01A6
 #define DP83867_MSE_REG_1	0x0225
 #define DP83867_SGMIICTL	0x00D3
 #define DP83867_10M_SGMII_CFG   0x016F
@@ -157,6 +166,22 @@
 /* SQI */
 #define DP83867_MAX_SQI	0x07
=20
+/* TDR bits */
+#define DP83867_TDR_GEN_CFG5_FLAGS	0x294A
+#define DP83867_TDR_GEN_CFG6_FLAGS	0x0A9B
+#define DP83867_TDR_GEN_CFG7_FLAGS	0x0000
+#define DP83867_TDR_START	BIT(0)
+#define DP83867_TDR_DONE	BIT(1)
+#define DP83867_TDR_FAIL	BIT(2)
+#define DP83867_TDR_PEAKS_LOC_LOW	GENMASK(7, 0)
+#define DP83867_TDR_PEAKS_LOC_HIGH	GENMASK(15, 8)
+#define DP83867_TDR_PEAKS_AMP_LOW	GENMASK(6, 0)
+#define DP83867_TDR_PEAKS_AMP_HIGH	GENMASK(14, 8)
+#define DP83867_TDR_INITIAL_THRESHOLD 10
+#define DP83867_TDR_FINAL_THRESHOLD 24
+#define DP83867_TDR_OFFSET	16
+#define DP83867_TDR_P_LOC_CROSS_MODE_SHIFT	8
+
 #define DP83867_LED_COUNT	4
=20
 /* LED_DRV bits */
@@ -1037,6 +1062,205 @@ static int dp83867_loopback(struct phy_device *ph=
ydev, bool enable)
 			  enable ? BMCR_LOOPBACK : 0);
 }
=20
+static u32 dp83867_cycles2cm(u32 cycles)
+{
+	/* for cat. 6 cable, signals travel at 5 ns / m */
+	return cycles * 8 * 20;
+}
+
+static int dp83867_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	ret =3D phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_TDR_GEN_CFG7,
+			    DP83867_TDR_GEN_CFG7_FLAGS);
+	if (ret < 0)
+		return ret;
+
+	ret =3D phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_TDR_GEN_CFG6,
+			    DP83867_TDR_GEN_CFG6_FLAGS);
+	if (ret < 0)
+		return ret;
+
+	ret =3D phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_TDR_GEN_CFG5,
+			    DP83867_TDR_GEN_CFG5_FLAGS);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_CFG3,
+			     DP83867_TDR_START);
+}
+
+static int dp83867_cable_test_report_trans(struct phy_device *phydev, s8=
 pair,
+					   int *peak_location, int *peak_value,
+					   int *peak_sign,
+					   unsigned int number_peaks)
+{
+	int fault_rslt =3D ETHTOOL_A_CABLE_RESULT_CODE_OK;
+	int threshold =3D DP83867_TDR_INITIAL_THRESHOLD;
+	unsigned long cross_result;
+	u32 fault_location =3D 0;
+	int i;
+	int ret;
+
+	for (i =3D number_peaks; i >=3D 0; --i) {
+		if (peak_value[i] > threshold) {
+			fault_location =3D
+				dp83867_cycles2cm(peak_location[i] -
+					DP83867_TDR_OFFSET) / 2;
+			if (peak_sign[i] =3D=3D 1) {
+				fault_rslt =3D
+					ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+			} else {
+				fault_rslt =3D ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+			}
+			break;
+		}
+		if (i =3D=3D 1)
+			threshold =3D DP83867_TDR_FINAL_THRESHOLD;
+	}
+
+	ret =3D phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_TDR_GEN_STATUS);
+	if (ret < 0)
+		return ret;
+
+	cross_result =3D ret;
+
+	if (test_bit(DP83867_TDR_P_LOC_CROSS_MODE_SHIFT + pair -
+		     ETHTOOL_A_CABLE_PAIR_A, &cross_result))
+		fault_rslt =3D ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
+
+	ret =3D ethnl_cable_test_result(phydev, pair, fault_rslt);
+	if (ret < 0)
+		return ret;
+
+	if (fault_rslt !=3D ETHTOOL_A_CABLE_RESULT_CODE_OK) {
+		return ethnl_cable_test_fault_length(phydev, pair,
+						     fault_location);
+	}
+	return 0;
+}
+
+static int dp83867_read_tdr_registers(struct phy_device *phydev, s8 pair=
,
+				      int *peak_loc, int *peak_val,
+				      int *peak_sign,
+				      unsigned int number_peaks)
+{
+	u32 segment_dist, register_dist;
+	unsigned long peak_sign_result;
+	int ret;
+	int i;
+
+	segment_dist =3D (pair - ETHTOOL_A_CABLE_PAIR_A) * 5;
+	for (i =3D 0; i < number_peaks; ++i) {
+		register_dist =3D (segment_dist + i) / 2;
+		ret =3D phy_read_mmd(phydev, DP83867_DEVADDR,
+				   DP83867_TDR_PEAKS_LOC_1 + register_dist);
+		if (ret < 0)
+			return ret;
+		if (((register_dist + i) % 2) =3D=3D 0)
+			peak_loc[i] =3D FIELD_GET(DP83867_TDR_PEAKS_LOC_LOW, ret);
+		else
+			peak_loc[i] =3D FIELD_GET(DP83867_TDR_PEAKS_LOC_HIGH, ret);
+
+		ret =3D phy_read_mmd(phydev, DP83867_DEVADDR,
+				   DP83867_TDR_PEAKS_AMP_1 + register_dist);
+		if (ret < 0)
+			return ret;
+		if (((register_dist + i) % 2) =3D=3D 0)
+			peak_val[i] =3D FIELD_GET(DP83867_TDR_PEAKS_AMP_LOW, ret);
+		else
+			peak_val[i] =3D FIELD_GET(DP83867_TDR_PEAKS_AMP_HIGH, ret);
+	}
+
+	switch (pair) {
+	case ETHTOOL_A_CABLE_PAIR_A:
+	case ETHTOOL_A_CABLE_PAIR_B:
+		ret =3D phy_read_mmd(phydev, DP83867_DEVADDR,
+				   DP83867_TDR_PEAKS_SIGN_1);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_C:
+	case ETHTOOL_A_CABLE_PAIR_D:
+		ret =3D phy_read_mmd(phydev, DP83867_DEVADDR,
+				   DP83867_TDR_PEAKS_SIGN_2);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (ret < 0)
+		return ret;
+
+	peak_sign_result =3D ret;
+
+	switch (pair) {
+	case ETHTOOL_A_CABLE_PAIR_A:
+	case ETHTOOL_A_CABLE_PAIR_C:
+		for (i =3D 0; i < number_peaks; i++)
+			peak_sign[i] =3D test_bit(i, &peak_sign_result);
+		break;
+	case ETHTOOL_A_CABLE_PAIR_B:
+	case ETHTOOL_A_CABLE_PAIR_D:
+		for (i =3D 0; i < number_peaks; i++)
+			peak_sign[i] =3D test_bit(i + 5, &peak_sign_result);
+		break;
+	}
+
+	return 0;
+}
+
+static int dp83867_cable_test_report_pair(struct phy_device *phydev, s8 =
pair)
+{
+	int peak_sign[5];
+	int peak_loc[ARRAY_SIZE(peak_sign)];
+	int peak_val[ARRAY_SIZE(peak_sign)];
+	int ret;
+
+	ret =3D dp83867_read_tdr_registers(phydev, pair, peak_loc, peak_val,
+					 peak_sign, ARRAY_SIZE(peak_sign));
+	if (ret < 0)
+		return ret;
+	return dp83867_cable_test_report_trans(phydev, pair, peak_loc,
+					       peak_val, peak_sign,
+					       ARRAY_SIZE(peak_sign));
+}
+
+static int dp83867_cable_test_report(struct phy_device *phydev)
+{
+	s8 pair;
+	int ret;
+
+	for (pair =3D ETHTOOL_A_CABLE_PAIR_A; pair <=3D ETHTOOL_A_CABLE_PAIR_D;
+	     ++pair) {
+		ret =3D dp83867_cable_test_report_pair(phydev, pair);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int dp83867_cable_test_get_status(struct phy_device *phydev,
+					 bool *finished)
+{
+	int ret;
+
+	*finished =3D false;
+
+	ret =3D phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_CFG3);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & DP83867_TDR_DONE))
+		return 0;
+
+	*finished =3D true;
+
+	if (ret & DP83867_TDR_FAIL)
+		return -EBUSY;
+
+	return dp83867_cable_test_report(phydev);
+}
+
 static int dp83867_get_sqi(struct phy_device *phydev)
 {
 	u16 mse_val;
@@ -1226,6 +1450,7 @@ static struct phy_driver dp83867_driver[] =3D {
 		.phy_id		=3D DP83867_PHY_ID,
 		.phy_id_mask	=3D 0xfffffff0,
 		.name		=3D "TI DP83867",
+		.flags		=3D PHY_POLL_CABLE_TEST,
 		/* PHY_GBIT_FEATURES */
=20
 		.probe          =3D dp83867_probe,
@@ -1252,6 +1477,9 @@ static struct phy_driver dp83867_driver[] =3D {
 		.link_change_notify =3D dp83867_link_change_notify,
 		.set_loopback	=3D dp83867_loopback,
=20
+		.cable_test_start	=3D dp83867_cable_test_start,
+		.cable_test_get_status	=3D dp83867_cable_test_get_status,
+
 		.led_brightness_set =3D dp83867_led_brightness_set,
 		.led_hw_is_supported =3D dp83867_led_hw_is_supported,
 		.led_hw_control_set =3D dp83867_led_hw_control_set,
--=20
2.25.1


