Return-Path: <netdev+bounces-103275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC39075B5
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC57A1C23F60
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAE2AEFE;
	Thu, 13 Jun 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b="mJj2Amng"
X-Original-To: netdev@vger.kernel.org
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC5B646;
	Thu, 13 Jun 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.98.226.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290311; cv=none; b=GEupB5vRTXf+LOTkKGmELNsbl00VcXbIOXfgKAfvIju7H6FT4+88DYPiSGvC6Ep/mZE2x4UPwCuPCKI8DtJImPGfMe4eKCt1M2KuZEA1Fx7cE4hNL7SIJrsbFcWHshw0OvFWsB3+aRFtj2kcXfvM2HCDDD2o1bG+O6RNgjJGZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290311; c=relaxed/simple;
	bh=7rakcWxS0PcSIHVBs6vd5F2lWfJa0cr5Bx4OndF8dMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGBBDB5tT2uGZgdV8efNP6A83eJfwi7t24eg+XbmmEMpP4JSs0Nq170kcKmL8erdYDPkpgtLhOYZHEBAb4+YJtYcOAU7LPIz55CEJqsCvezxudjynaJY1g8U9JDBal2/3iY/RliBgwG8PDJ1GD0f4gi+ZOkH0sLfwgRTfz62OsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com; spf=pass smtp.mailfrom=ubimet.com; dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b=mJj2Amng; arc=none smtp.client-ip=141.98.226.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubimet.com
Received: from localhost (localhost [127.0.0.1])
	by mx2-at.ubimet.com (Postfix) with ESMTP id DFC5A81188;
	Thu, 13 Jun 2024 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
	s=20200131mdel; t=1718290307;
	bh=7rakcWxS0PcSIHVBs6vd5F2lWfJa0cr5Bx4OndF8dMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJj2AmngiAJMOmGOSMOSevprFaHji/y/A0K2lLtFNu8HX1l42DsPM3cYojdznjkzt
	 v/8GKawjZYoiEf1bZRmtQsNNX/iTi4RBX1p4OlSaWxybhzIZIQlEWtjaNjpYRM3V00
	 bim2SULXwyZtYN30PKRJHWQIt1GbnrmCBErKSrBUgK1TBvBsS/xJDoxw6tdEZcwfS1
	 CYyBuizqeWw+ymvQJtNxMQ6j9SlyIDCynv/hClNMjO6j3NVfALn0OJlDYYEsp1V4nT
	 mlQvgIClztJc0/cLJERcPwhnkEuNEqNmgF97T+R8uMDGgBqmpk+CaYC+S4NlJ9f2fw
	 3dh6wT9M+LLqw==
Received: from mx2-at.ubimet.com ([127.0.0.1])
	by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbnHciML1L9Y; Thu, 13 Jun 2024 14:51:47 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (webmail-dc.at.ubimet.com [10.1.18.22])
	by mx2-at.ubimet.com (Postfix) with ESMTPS id C845181187;
	Thu, 13 Jun 2024 14:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id A7CAE80771;
	Thu, 13 Jun 2024 14:51:47 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id EdOjm3CKKUYW; Thu, 13 Jun 2024 14:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id AF61880782;
	Thu, 13 Jun 2024 14:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NUGmfzTkUpOF; Thu, 13 Jun 2024 14:51:46 +0000 (UTC)
Received: from pcn112.wl97.hub.at.ubimet.com (pcn112.it.hub.at.ubimet.com [10.15.66.143])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 6C1A080771;
	Thu, 13 Jun 2024 14:51:46 +0000 (UTC)
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
Subject: [PATCH net-next 1/3] net: phy: dp83867: Add SQI support
Date: Thu, 13 Jun 2024 16:51:51 +0200
Message-Id: <20240613145153.2345826-2-jrodrigues@ubimet.com>
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

Don't report SQI values for 10 ethernet, since the datasheet
says MSE values are only valid for 100/1000 ethernet

Signed-off-by: Jo=C3=A3o Rodrigues <jrodrigues@ubimet.com>
---
 drivers/net/phy/dp83867.c | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 4120385c5a79..5741f09e29cb 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -53,6 +53,7 @@
 #define DP83867_RXFSOP2	0x013A
 #define DP83867_RXFSOP3	0x013B
 #define DP83867_IO_MUX_CFG	0x0170
+#define DP83867_MSE_REG_1	0x0225
 #define DP83867_SGMIICTL	0x00D3
 #define DP83867_10M_SGMII_CFG   0x016F
 #define DP83867_10M_SGMII_RATE_ADAPT_MASK BIT(7)
@@ -153,6 +154,9 @@
 /* FLD_THR_CFG */
 #define DP83867_FLD_THR_CFG_ENERGY_LOST_THR_MASK	0x7
=20
+/* SQI */
+#define DP83867_MAX_SQI	0x07
+
 #define DP83867_LED_COUNT	4
=20
 /* LED_DRV bits */
@@ -196,6 +200,24 @@ struct dp83867_private {
 	bool sgmii_ref_clk_en;
 };
=20
+/* Register values are converted to SNR(dB) as suggested by
+ * "How to utilize diagnostic test suite of Ethernet PHY":
+ * SNR(dB) =3D -10 * log10 (VAL/2^17) - 3 dB.
+ * SQI ranges are implemented according to "OPEN ALLIANCE - Advanced dia=
gnostic
+ * features for 100BASE-T1 automotive Ethernet PHYs"
+ */
+
+static const u16 dp83867_mse_sqi_map[] =3D {
+	0x0411, /* < 18dB */
+	0x033b, /* 18dB =3D< SNR < 19dB */
+	0x0290, /* 19dB =3D< SNR < 20dB */
+	0x0209, /* 20dB =3D< SNR < 21dB */
+	0x019e, /* 21dB =3D< SNR < 22dB */
+	0x0149, /* 22dB =3D< SNR < 23dB */
+	0x0105, /* 23dB =3D< SNR < 24dB */
+	0x0000  /* 24dB =3D< SNR */
+};
+
 static int dp83867_ack_interrupt(struct phy_device *phydev)
 {
 	int err =3D phy_read(phydev, MII_DP83867_ISR);
@@ -1015,6 +1037,32 @@ static int dp83867_loopback(struct phy_device *phy=
dev, bool enable)
 			  enable ? BMCR_LOOPBACK : 0);
 }
=20
+static int dp83867_get_sqi(struct phy_device *phydev)
+{
+	u16 mse_val;
+	int sqi;
+	int ret;
+
+	if (phydev->speed =3D=3D SPEED_10)
+		return -EOPNOTSUPP;
+
+	ret =3D phy_read_mmd(phydev, DP83867_DEVADDR, DP83867_MSE_REG_1);
+	if (ret < 0)
+		return ret;
+
+	mse_val =3D 0xFFFF & ret;
+	for (sqi =3D 0; sqi < ARRAY_SIZE(dp83867_mse_sqi_map); sqi++) {
+		if (mse_val >=3D dp83867_mse_sqi_map[sqi])
+			return sqi;
+	}
+	return -EINVAL;
+}
+
+static int dp83867_get_sqi_max(struct phy_device *phydev)
+{
+	return DP83867_MAX_SQI;
+}
+
 static int
 dp83867_led_brightness_set(struct phy_device *phydev,
 			   u8 index, enum led_brightness brightness)
@@ -1195,6 +1243,9 @@ static struct phy_driver dp83867_driver[] =3D {
 		.config_intr	=3D dp83867_config_intr,
 		.handle_interrupt =3D dp83867_handle_interrupt,
=20
+		.get_sqi	=3D dp83867_get_sqi,
+		.get_sqi_max	=3D dp83867_get_sqi_max,
+
 		.suspend	=3D dp83867_suspend,
 		.resume		=3D dp83867_resume,
=20
--=20
2.25.1


