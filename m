Return-Path: <netdev+bounces-136363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E829A1816
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C670C1C24B93
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9F20314;
	Thu, 17 Oct 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mIz9PQfr"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4612E4A
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129858; cv=none; b=QM1GsHXK5CzRbBJdaSqo8fVhfxAj3DnNxxUghDQRA62K7cWAvft+jD/MXCMhxXSPHvspp9jEIcPhD0Y5DUZqCklZBlYBRzsMUhi9mSnRyimpPbG5mjYqcy2BYJNlTnC7kSjYEOlpiAyKUqFlgzYTDTANojegKevcBs1XJVBz8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129858; c=relaxed/simple;
	bh=RSKGn99EaPbe4mDp0J2nOlxrzgOcBCJMdHVkZWuooDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blPO66Td1xHUn8h1cOXEQAXwAQbNDZOOg33xRlfqNist/X1NNh3tcbvmSTFPu7Jh/k2lT7MWLsKoX0zqdNGKxv6AI+lqzBK/EfMmAyZAvwXoQtB68/VTOjCvVuOvSQyAlptvFiB+vNI8iZ4ybftuu5Hgut+VbizKDy2kpOOXvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=mIz9PQfr; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 517DA2C0372;
	Thu, 17 Oct 2024 14:50:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729129852;
	bh=wF146WcQVPfkBAz6Ot+jRNqda9CHto4++1fqf9HzLGY=;
	h=From:To:Cc:Subject:Date:From;
	b=mIz9PQfr7lp1h2ODoukVVWRCQR+EkYX0JMhumtYI7HXiNYzk4qpN3tbWTk4QYHWwY
	 IMbyC3XMjBaztaALIQAAbeLhfjzhu27MMyrIXn4yxhXXuRybB9TbdJReoZsJ/eMk25
	 uLHW8jnriJFZJrEE9t7UQ2A30ajAODC6uo22P1O0BoAdtRJ1pKkbKD+t/2er5Ei9Vq
	 ElvE97tzTCWyD3XlSkpCqxc2RU3YejhyET6ad/2EiCTW8o3W4LGuBHJC8h59oWbBOh
	 untOMRqGSYkF6fqhVcf+b8vnuGrHRCB78GcB1+gVoQk1Xh2Whbs3ggZUZPa6GiCNFU
	 2TxTzeNfILNkw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67106d7c0000>; Thu, 17 Oct 2024 14:50:52 +1300
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 2C34713EE32;
	Thu, 17 Oct 2024 14:50:52 +1300 (NZDT)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id 2412940A11; Thu, 17 Oct 2024 14:50:52 +1300 (NZDT)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net-next] net: phy: marvell: Add mdix status reporting
Date: Thu, 17 Oct 2024 14:50:25 +1300
Message-ID: <20241017015026.255224-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67106d7c a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=bTSuseBfvj3mEb2p6r4A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Report MDI-X resolved state after link up.

Tested on Linkstreet 88E6193X internal PHYs.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---
 drivers/net/phy/marvell.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 9964bf3dea2f..28aec37acd2c 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -176,6 +176,7 @@
 #define MII_M1011_PHY_STATUS_FULLDUPLEX	0x2000
 #define MII_M1011_PHY_STATUS_RESOLVED	0x0800
 #define MII_M1011_PHY_STATUS_LINK	0x0400
+#define MII_M1011_PHY_STATUS_MDIX	BIT(6)
=20
 #define MII_88E3016_PHY_SPEC_CTRL	0x10
 #define MII_88E3016_DISABLE_SCRAMBLER	0x0200
@@ -1722,6 +1723,19 @@ static int marvell_read_status_page(struct phy_dev=
ice *phydev, int page)
 	phydev->duplex =3D DUPLEX_UNKNOWN;
 	phydev->port =3D fiber ? PORT_FIBRE : PORT_TP;
=20
+	if (fiber) {
+		phydev->mdix =3D ETH_TP_MDI_INVALID;
+	} else {
+		/* The MDI-X state is set regardless of Autoneg being enabled
+		 * and reflects forced MDI-X state as well as auto resolution
+		 */
+		if (status & MII_M1011_PHY_STATUS_RESOLVED)
+			phydev->mdix =3D status & MII_M1011_PHY_STATUS_MDIX ?
+				ETH_TP_MDI_X : ETH_TP_MDI;
+		else
+			phydev->mdix =3D ETH_TP_MDI_INVALID;
+	}
+
 	if (phydev->autoneg =3D=3D AUTONEG_ENABLE)
 		err =3D marvell_read_status_page_an(phydev, fiber, status);
 	else
--=20
2.47.0


