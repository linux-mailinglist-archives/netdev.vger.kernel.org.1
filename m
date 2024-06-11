Return-Path: <netdev+bounces-102598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA4D903E13
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE6A1F253C2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51217E47F;
	Tue, 11 Jun 2024 13:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E917D8AF;
	Tue, 11 Jun 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114127; cv=none; b=CenWROZvIWcoTH4e9Pg+b+IQOTi7t4T/y19NhcnZbyeSy73OfaM5g9ZhbV36B9O9hFqyG4xFh8NxS+9NTsYsISPu2nxqReIvrAViZ3eyGg71035+A9+9IdK9PGcM1+9kmo8AAZCWHalW0h4+Oa9gk7VYPFjYE1c82N0q4hCtIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114127; c=relaxed/simple;
	bh=D3oVcUtkTVq+/7cDht2gnLzzOfcwH0UaOWGZGd6x1lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joXyuzbyBmvBuGcBCMvCwsVM05rdCJ9DuFE/i/lUc+VI6m2r7nv90IvjMJ4uFEnTduvuNWyS2vyj/RS0SX+RPrdXcf4PMB0LFbKnr8rAr3ymOZFkJ2d7uARZaffYR82JoVEf+EXYsJ9hwvqUp7Lf3g8ofBDASMwhe3J3e+9ih0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1y7-0011gh-KN; Tue, 11 Jun 2024 15:55:23 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1y7-00364p-2E; Tue, 11 Jun 2024 15:55:23 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id C2CE0240053;
	Tue, 11 Jun 2024 15:55:22 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 5834A240050;
	Tue, 11 Jun 2024 15:55:22 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 02A25376FA;
	Tue, 11 Jun 2024 15:55:22 +0200 (CEST)
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
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v5 03/12] net: dsa: lantiq_gswip: add terminating \n where missing
Date: Tue, 11 Jun 2024 15:54:25 +0200
Message-ID: <20240611135434.3180973-4-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718114123-36936522-CA75D238/0/0
X-purgate-type: clean
X-purgate: clean

Some dev_err are missing the terminating \n. Let's add that.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/lantiq_gswip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index b9c7076ce32f..fe64baf0d7f1 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -836,7 +836,7 @@ static int gswip_setup(struct dsa_switch *ds)
=20
 	err =3D gswip_pce_load_microcode(priv);
 	if (err) {
-		dev_err(priv->dev, "writing PCE microcode failed, %i", err);
+		dev_err(priv->dev, "writing PCE microcode failed, %i\n", err);
 		return err;
 	}
=20
@@ -1792,7 +1792,7 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_pr=
iv *priv, u32 table,
 	err =3D gswip_switch_r_timeout(priv, GSWIP_BM_RAM_CTRL,
 				     GSWIP_BM_RAM_CTRL_BAS);
 	if (err) {
-		dev_err(priv->dev, "timeout while reading table: %u, index: %u",
+		dev_err(priv->dev, "timeout while reading table: %u, index: %u\n",
 			table, index);
 		return 0;
 	}
@@ -2021,7 +2021,7 @@ static void gswip_gphy_fw_remove(struct gswip_priv =
*priv,
=20
 	ret =3D regmap_write(priv->rcu_regmap, gphy_fw->fw_addr_offset, 0);
 	if (ret)
-		dev_err(priv->dev, "can not reset GPHY FW pointer");
+		dev_err(priv->dev, "can not reset GPHY FW pointer\n");
=20
 	clk_disable_unprepare(gphy_fw->clk_gate);
=20
@@ -2050,7 +2050,7 @@ static int gswip_gphy_fw_list(struct gswip_priv *pr=
iv,
 			priv->gphy_fw_name_cfg =3D &xrx200a2x_gphy_data;
 			break;
 		default:
-			dev_err(dev, "unknown GSWIP version: 0x%x", version);
+			dev_err(dev, "unknown GSWIP version: 0x%x\n", version);
 			return -ENOENT;
 		}
 	}
@@ -2060,7 +2060,7 @@ static int gswip_gphy_fw_list(struct gswip_priv *pr=
iv,
 		priv->gphy_fw_name_cfg =3D match->data;
=20
 	if (!priv->gphy_fw_name_cfg) {
-		dev_err(dev, "GPHY compatible type not supported");
+		dev_err(dev, "GPHY compatible type not supported\n");
 		return -ENOENT;
 	}
=20
@@ -2163,7 +2163,7 @@ static int gswip_probe(struct platform_device *pdev=
)
 			return -EINVAL;
 		break;
 	default:
-		dev_err(dev, "unknown GSWIP version: 0x%x", version);
+		dev_err(dev, "unknown GSWIP version: 0x%x\n", version);
 		return -ENOENT;
 	}
=20
@@ -2191,7 +2191,7 @@ static int gswip_probe(struct platform_device *pdev=
)
 		goto gphy_fw_remove;
 	}
 	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
-		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
+		dev_err(dev, "wrong CPU port defined, HW only supports port: %i\n",
 			priv->hw_info->cpu_port);
 		err =3D -EINVAL;
 		goto disable_switch;
--=20
2.39.2


