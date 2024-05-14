Return-Path: <netdev+bounces-96352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA9A8C5622
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED53284AB0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD96CDA3;
	Tue, 14 May 2024 12:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [194.37.255.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD86BFA8;
	Tue, 14 May 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690679; cv=none; b=sMhBvOewhx5IW92vwHv/KLFXg1wbyIJ7jvhuX1pZqXf5ZQ9npm6rXSLAfd5uqlMO4PHUDOtF7cuop5RST1cm72GuvvBJ6UIJk/Fz9WN6c3RFvbGaZoPCemrtDusfv+2+rJC5T+h2rHIZeBBe70U90hiavjGkGrrSkNA6Cx19BDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690679; c=relaxed/simple;
	bh=yTLW0IJRaUkMcye7x1q7XLp3U8fuID9lCwQ20A94yiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IdRDiqll9EDeCuGDgOCUMSNnbibiKrphPSNMb1Zes9Q7iG4fkNZ323dkzEJ/QVbm3iXO94iBuRQAuHEVqXttIt2oZOqiEaJjhQqd2iLwZ5z7R4P38MJoiNYtXQjTHwSrBc2WHbCeh0HXbBMWfdN+/aXSiQ1tLXwT7D0/xGV6Zx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=194.37.255.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1s6rGx-00HQk6-BC; Tue, 14 May 2024 14:28:47 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas.gessler@brueckmann-gmbh.de>)
	id 1s6rGv-001xKj-Tw; Tue, 14 May 2024 14:28:45 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id 3A336CA5AA8;
	Tue, 14 May 2024 14:28:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id 353E7CA5AF6;
	Tue, 14 May 2024 14:28:45 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id nar3tVrW8P2h; Tue, 14 May 2024 14:28:45 +0200 (CEST)
Received: from ew-linux.ew (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id 1A1B8CA5AA8;
	Tue, 14 May 2024 14:28:45 +0200 (CEST)
From: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: [PATCH 1/2] net: phy: dp83869: Add PHY ID for chip revision 3
Date: Tue, 14 May 2024 14:27:27 +0200
Message-Id: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1715689726-CD4998D1-EB8F54D6/0/0

The recent silicon revision 3 of the DP83869 has a different PHY ID
which has to be added to the driver in order for the PHY to be detected.
There appear to be no documented differences between the revisions,
although there are some discussions in the TI forum about different
behavior for some registers.

Signed-off-by: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
---
 drivers/net/phy/dp83869.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index d7aaefb5226b..d248a13c1749 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -15,7 +15,8 @@
=20
 #include <dt-bindings/net/ti-dp83869.h>
=20
-#define DP83869_PHY_ID		0x2000a0f1
+#define DP83869REV1_PHY_ID	0x2000a0f1
+#define DP83869REV3_PHY_ID	0x2000a0f3
 #define DP83561_PHY_ID		0x2000a1a4
 #define DP83869_DEVADDR		0x1f
=20
@@ -909,14 +910,16 @@ static int dp83869_phy_reset(struct phy_device *phy=
dev)
 }
=20
 static struct phy_driver dp83869_driver[] =3D {
-	DP83869_PHY_DRIVER(DP83869_PHY_ID, "TI DP83869"),
+	DP83869_PHY_DRIVER(DP83869REV1_PHY_ID, "TI DP83869 Rev. 1"),
+	DP83869_PHY_DRIVER(DP83869REV3_PHY_ID, "TI DP83869 Rev. 3"),
 	DP83869_PHY_DRIVER(DP83561_PHY_ID, "TI DP83561-SP"),
=20
 };
 module_phy_driver(dp83869_driver);
=20
 static struct mdio_device_id __maybe_unused dp83869_tbl[] =3D {
-	{ PHY_ID_MATCH_MODEL(DP83869_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(DP83869REV1_PHY_ID) },
+	{ PHY_ID_MATCH_MODEL(DP83869REV3_PHY_ID) },
 	{ PHY_ID_MATCH_MODEL(DP83561_PHY_ID) },
 	{ }
 };
--=20
2.34.1


