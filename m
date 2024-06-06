Return-Path: <netdev+bounces-101321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34278FE1DE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD68C1C254BD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F6155338;
	Thu,  6 Jun 2024 08:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123A155307;
	Thu,  6 Jun 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664105; cv=none; b=B6FACCMtn+WldNoxkTvhv68n7xNXnaF+jmOL/BVyCvedB092VGALfqDHuWVw9aFojtHMOCLiQx3xYcmYlMf2/G0bZlHZMD9pKDnGxGzRLG2VqgH9M7oKEvRrxV+ArhdPnJa0+ukdSCZm1w9FkM0R0G9AOkMh2dv8wlgdgzV+XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664105; c=relaxed/simple;
	bh=whHbmZoVgRqfuvp8JQDubSalkz34FeHDYtrAB7NSNX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlptdBhp1S+SIUXbU1QIWIdp+Zi9sckjaGcU7RdCfU9SdSxCDhvO5MibuUKpQBlGKe2k7mwDy7jKLjYbiROz+eQ7sqxWiDbLN4RqwDXXMRfk+y6LekfRWxLsL9augkOK+duZNkG/AGAuWC98ixomPxjbiISM7qf7+iqwLTbUTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8ti-00ESSM-H9; Thu, 06 Jun 2024 10:55:02 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8th-002l7A-W2; Thu, 06 Jun 2024 10:55:02 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id ADD66240053;
	Thu,  6 Jun 2024 10:55:01 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 41261240050;
	Thu,  6 Jun 2024 10:55:01 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E8977379F6;
	Thu,  6 Jun 2024 10:55:00 +0200 (CEST)
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
Subject: [PATCH net-next 12/13] net: dsa: lantiq_gswip: Add and use a GSWIP_TABLE_MAC_BRIDGE_FID macro
Date: Thu,  6 Jun 2024 10:52:33 +0200
Message-ID: <20240606085234.565551-13-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1717664102-06392B7C-B77CF30C/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Only bits [5:0] in mac_bridge.key[3] are reserved for the FID. Add a
macro so this becomes obvious when reading the driver code.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index f2faee112e33..4bb894e75b81 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -238,6 +238,7 @@
 #define GSWIP_TABLE_MAC_BRIDGE		0x0b
 #define  GSWIP_TABLE_MAC_BRIDGE_STATIC	BIT(0)		/* Static not, aging entr=
y */
 #define  GSWIP_TABLE_MAC_BRIDGE_PORT	GENMASK(7, 4)	/* Port on learned en=
tries */
+#define  GSWIP_TABLE_MAC_BRIDGE_FID	GENMASK(5, 0)	/* Filtering identifie=
r */
=20
 #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
=20
@@ -1385,7 +1386,7 @@ static int gswip_port_fdb(struct dsa_switch *ds, in=
t port,
 	mac_bridge.key[0] =3D addr[5] | (addr[4] << 8);
 	mac_bridge.key[1] =3D addr[3] | (addr[2] << 8);
 	mac_bridge.key[2] =3D addr[1] | (addr[0] << 8);
-	mac_bridge.key[3] =3D fid;
+	mac_bridge.key[3] =3D FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_FID, fid);
 	mac_bridge.val[0] =3D add ? BIT(port) : 0; /* port map */
 	mac_bridge.val[1] =3D GSWIP_TABLE_MAC_BRIDGE_STATIC;
 	mac_bridge.valid =3D add;
--=20
2.39.2


