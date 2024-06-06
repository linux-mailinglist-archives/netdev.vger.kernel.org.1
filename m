Return-Path: <netdev+bounces-101317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4548FE1CB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5807B28375E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50714D28F;
	Thu,  6 Jun 2024 08:54:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320E1514F4;
	Thu,  6 Jun 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664087; cv=none; b=ZKEDnaL6AYb0fC3dNGJEw8ey1bVEYQoNfxAwlvil5jThjmIi4wsfy8K8HtTUsuA6EqTUeNfKbQqbZFwp0W5tR7FiC7He+RiwygIR3aYbVLJvB97b81RZSmb7Pov4Fyb1Vs8OQlPct2jfaKDwq2aCuk8vw1mqMrR4qxtarG4FezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664087; c=relaxed/simple;
	bh=Tku3qhWCDMuJ21BgSTr1MYubHb54Q4c0MxJpGN/1K7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKFVvCkkKO51fehZx5L21odbFE3+PSjcpFSNcD1z+6ZGYdgcJBKQlFusfjwfYkHsgKEQBMdfZ09CXP4mUit4rsOvKtwrtfuDSBlW4z/LthZLw3sMgoxZ/63h5+faSodCUHYhe+0bhNzie1RbnF4dhM3CnQ0vicCIUgr09KUCkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8tQ-00EUxP-21; Thu, 06 Jun 2024 10:54:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8tP-00EK3l-Fz; Thu, 06 Jun 2024 10:54:43 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 36EC4240054;
	Thu,  6 Jun 2024 10:54:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id BD3C0240053;
	Thu,  6 Jun 2024 10:54:42 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7C9E5379F6;
	Thu,  6 Jun 2024 10:54:42 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/13] net: dsa: lantiq_gswip: Consistently use macros for the mac bridge table
Date: Thu,  6 Jun 2024 10:52:29 +0200
Message-ID: <20240606085234.565551-9-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606085234.565551-1-ms@dev.tdt.de>
References: <20240606085234.565551-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1717664084-E147EADA-BC968BDD/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Introduce a new GSWIP_TABLE_MAC_BRIDGE_PORT macro and use it throughout
the driver. Also update GSWIP_TABLE_MAC_BRIDGE_STATIC to use the BIT()
macro. This makes the driver code easier to understand.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index c049f505fcc7..ee8296d5b901 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -236,7 +236,8 @@
 #define GSWIP_TABLE_ACTIVE_VLAN		0x01
 #define GSWIP_TABLE_VLAN_MAPPING	0x02
 #define GSWIP_TABLE_MAC_BRIDGE		0x0b
-#define  GSWIP_TABLE_MAC_BRIDGE_STATIC	0x01	/* Static not, aging entry *=
/
+#define  GSWIP_TABLE_MAC_BRIDGE_STATIC	BIT(0)		/* Static not, aging entr=
y */
+#define  GSWIP_TABLE_MAC_BRIDGE_PORT	GENMASK(7, 4)	/* Port on learned en=
tries */
=20
 #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
=20
@@ -1307,7 +1308,8 @@ static void gswip_port_fast_age(struct dsa_switch *=
ds, int port)
 		if (mac_bridge.val[1] & GSWIP_TABLE_MAC_BRIDGE_STATIC)
 			continue;
=20
-		if (((mac_bridge.val[0] & GENMASK(7, 4)) >> 4) !=3D port)
+		if (port !=3D FIELD_GET(GSWIP_TABLE_MAC_BRIDGE_PORT,
+				      mac_bridge.val[0]))
 			continue;
=20
 		mac_bridge.valid =3D false;
@@ -1445,7 +1447,8 @@ static int gswip_port_fdb_dump(struct dsa_switch *d=
s, int port,
 					return err;
 			}
 		} else {
-			if (((mac_bridge.val[0] & GENMASK(7, 4)) >> 4) =3D=3D port) {
+			if (port =3D=3D FIELD_GET(GSWIP_TABLE_MAC_BRIDGE_PORT,
+					      mac_bridge.val[0])) {
 				err =3D cb(addr, 0, false, data);
 				if (err)
 					return err;
--=20
2.39.2


