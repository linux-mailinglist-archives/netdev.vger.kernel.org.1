Return-Path: <netdev+bounces-198695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74015ADD0D6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E05188DF85
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2D2E54BF;
	Tue, 17 Jun 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="nuJiNMxo"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F362E54B7
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172579; cv=none; b=l6qkc7oZ61RWkyQubFcFQaq7rB4fDvxjLl6w7WyCU9FdH6MUVUdbS4szg3H134ahI5tCpiKM2dnSHSs6/6m3G07heJ0/VbcKL6Ex2hxTdnPVqbkdKT29x393WSfIENPAFKsgvlv4yBfp8Bo1Q+vVqnaSqayYsjSSfbSj4JadFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172579; c=relaxed/simple;
	bh=KMPl47eBkOrRFKCL0nN7mpy10zX1krz+mycbtF4w2mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHsCeLwCRD/C10uPO2dG8WZI1j1BKDyWsydgajpYgOdCqHyCi3FzLJBDUUCanHXwBHaCu6+JxYaBjBoAsaFpGSVbtdxx5Io2B+tSDGZkQP53HHJPD13TBu8UrY5l94Z1/82yKnAqXkKJm/bMTrlIN8VFsx3tERDsQZ7xK7mFSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=nuJiNMxo; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750172574; x=1750777374;
	i=markus.stockhausen@gmx.de;
	bh=sM0FSF3pFI4QEHiPjbv9TJql9VmXRMfBGuf3al/YXaU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nuJiNMxou7fR3CSnnpJEeuCBActQB1MXfKlayzSE8LFPr2vmAiZoeABRsIHK8Rew
	 1GgZW+985MZzPmS6K7DX0oJALKhHDbokLpazeNKClNVN9pf46yAQ8U8gSzdU4mkeb
	 sTEcSn+qmlrOpiWIq+EX2lqjO6J6V4fqTJT5XIOPFx7NGzom7sjHo043Ni6mR0bBr
	 rbkPmpq91WR/aOGOqgQYQTSg3Yt4EOTZvfBu0GGIIZSUCI5ro2vHoDPQOqhKPvgcM
	 USxo231b51Auh3XzQoDHTmKboikgbxIQHetkJxfZlSQmV0urIRrlrWRdr3XUZcxLT
	 ACg6ssNb7g2wR1ZMmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKyI-1uL3by1zZ2-00Qypw; Tue, 17
 Jun 2025 17:02:54 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael@fossekall.de,
	daniel@makrotopia.org,
	netdev@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Tue, 17 Jun 2025 11:01:47 -0400
Message-ID: <20250617150147.2602135-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xYrzczbbcVTxRL1sY7c1HALUU8/Mk4tFsI4Oa1D/JZqnNpXPn3Q
 FteR7b6Fhn3W5QGXTT7BHvbOpK/w6wGPHIEvmbB7X7Ajhz3JNh/ezOXIahJKppWe/gXLpcC
 2m/Ejfp1HY2FhTrYtrtE81tdIlB26xAs48kk7i7+Ce2dylYBkcfXVzeYm7/EpTpUyeDtRWa
 RVG1KsNwodUEZr4q5tWcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eEByCvFDqQo=;g+2Io6QMWiTiPLmUU8HD8nOcHx9
 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
 FSrEFuqRh4DX8x+u3nWTHXQUEVbFTFeG5SHNUA==

The RTL8226-CG can be found on devices like the Zyxel XGS1210-12. These
are driven by a RTL9302B SoC that has active phy hardware polling in
the background. As soon as this is active and set to c45 most c22
register accesses are blocked and will stop working. Convert the
phy to a c45-only function set.

For documentation purposes some register extracts that where taken to
verify proper detection.

phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1) =3D 0x0008
phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_STAT2) =3D 0x8200
phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE) =3D 0x41a0
phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_NG_EXTABLE) =3D 0x0001

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/realtek/realtek_main.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/real=
tek/realtek_main.c
index c3dcb6257430..16568f74f5a2 100644
=2D-- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1274,6 +1274,21 @@ static int rtl822x_c45_read_status(struct phy_devic=
e *phydev)
 	return 0;
 }
=20
+static int rtl822x_c45_soft_reset(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret =3D phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+			     MDIO_CTRL1_RESET, MDIO_CTRL1_RESET);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
+					 MDIO_CTRL1, val,
+					 !(val & MDIO_CTRL1_RESET),
+					 5000, 100000, true);
+}
+
 static int rtl822xb_c45_read_status(struct phy_device *phydev)
 {
 	int ret;
@@ -1669,11 +1684,12 @@ static struct phy_driver realtek_drvs[] =3D {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           =3D "RTL8226-CG 2.5Gbps PHY",
-		.get_features   =3D rtl822x_get_features,
-		.config_aneg    =3D rtl822x_config_aneg,
-		.read_status    =3D rtl822x_read_status,
-		.suspend        =3D genphy_suspend,
-		.resume         =3D rtlgen_resume,
+		.soft_reset     =3D rtl822x_c45_soft_reset,
+		.get_features   =3D rtl822x_c45_get_features,
+		.config_aneg    =3D rtl822x_c45_config_aneg,
+		.read_status    =3D rtl822x_c45_read_status,
+		.suspend        =3D genphy_c45_pma_suspend,
+		.resume         =3D rtlgen_c45_resume,
 		.read_page      =3D rtl821x_read_page,
 		.write_page     =3D rtl821x_write_page,
 	}, {
=2D-=20
2.47.0


