Return-Path: <netdev+bounces-132559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FB09921B9
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DDCB20DF3
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726118A951;
	Sun,  6 Oct 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="XeupoG7u"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCD16EC19
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250551; cv=none; b=tYjpEbmGUCjvxQm0hQt6RnefTY0dbIn7ObcAP6ubCcV/PD1t7kzQdf+K8gie9K0LEzycU5HvtusjTJKG+gpr9T0JRH3EQlg+n7MJrVVODHZ46DoS/t8mQVRM5utHqCbqMAiwKkshEhlBhPgGhm+TPJf9tccg/rOXgbobRoDf/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250551; c=relaxed/simple;
	bh=8uzF99lZ2f7QYqv9HXYQ/KMkiUUPwEmh1qjBHrMjUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dO6tJPNcgeBNw7PH3/It9ga8dWLxDySnkMmYrCVWYtsH3UEY0hmtSR6kXaFYBgBqyeuZq+MFyPrPxxrIl5Eo2Nv+BQbFjDgVSYMIoRBuKffQIIZzbN0EctCC3QMlS22XrFh+lCDr1l03+VyKDCu3iml7ViaCbMFEeIA0NIMzURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=XeupoG7u; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 53B402C0707;
	Mon,  7 Oct 2024 10:35:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728250546;
	bh=wfcaBuvQceriZCce9+JxhDm+AQW3zfzjOyZSWRRbmM4=;
	h=From:To:Cc:Subject:Date:From;
	b=XeupoG7uS0IGsFWMnDHDgNVi/Pl6erErRHaSeiTVAIKBUb6hqELzwgA57cA8+QV9V
	 aIXF7vHiRkOKjvofbF3fZB0dFSXDFouOIEAa1Jb/IkV4qhK3D3SN+xGs7AvBgxdXh2
	 U2peuIZjbMAv0/XO4Wk1Hopri5ObHU6xityqo0bdodKkyGwQP81dUewlBQxKSkvSwV
	 Mot80tIrz1LL1wavU6Oz3w9pZuLGHV5Pee/Zb1IPI8Z3AGF/uqC/aGz+VRuXL4lFJh
	 1qnzdCeIUlHLeK5EBZPikcUCjQ59cyYnhKZ4zTWePDwHhAwWtgLZImnUnUwiHF41S3
	 1t5LTZjYZLQ/Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670302b20000>; Mon, 07 Oct 2024 10:35:46 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 27BCA13ED6B;
	Mon,  7 Oct 2024 10:35:46 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 235142A0C47; Mon,  7 Oct 2024 10:35:46 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v0] net: phy: aquantia: poll status register
Date: Mon,  7 Oct 2024 10:35:36 +1300
Message-ID: <20241006213536.3153121-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=670302b2 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=CGjx52yEnwgpAtm7to8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The system interface connection status register is not immediately
correct upon line side link up. This results in the status being read as
OFF and then transitioning to the correct host side link mode with a
short delay. This results in the phylink framework passing the OFF
status down to all MAC config drivers, resulting in the host side link
being misconfigured, which in turn can lead to link flapping or complete
packet loss in some cases.

Mitigate this by periodically polling the register until it not showing
the OFF state. This will be done every 1ms for 10ms, using the same
poll/timeout as the processor intensive operation reads.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/phy/aquantia/aquantia_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
index e982e9ce44a5..d2573982b1e5 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -41,6 +41,7 @@
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_XAUI	4
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII	6
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI	7
+#define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF	9
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII	10
=20
 #define MDIO_AN_VEND_PROV			0xc400
@@ -342,9 +343,18 @@ static int aqr107_read_status(struct phy_device *phy=
dev)
 	if (!phydev->link || phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return 0;
=20
-	val =3D phy_read_mmd(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS)=
;
-	if (val < 0)
-		return val;
+	/**
+	 * The status register is not immediately correct on line side link up.
+	 * Poll periodically until it reflects the correct ON state.
+	 */
+	ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
+					MDIO_PHYXS_VEND_IF_STATUS, val,
+					(FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val) !=3D
+					MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF),
+					AQR107_OP_IN_PROG_SLEEP,
+					AQR107_OP_IN_PROG_TIMEOUT, false);
+	if (ret)
+		return ret;
=20
 	switch (FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val)) {
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR:
--=20
2.46.0


