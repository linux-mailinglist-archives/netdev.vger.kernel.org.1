Return-Path: <netdev+bounces-102283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F6902371
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D51E2875D2
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01278286B;
	Mon, 10 Jun 2024 14:02:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886071B45;
	Mon, 10 Jun 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028172; cv=none; b=pKrspBwKgD8ZZEmM//15V7TEZvuDC94W9DBbEBWwhDR2IdYnaFEI0HYHrrJdS9MlH540+wGZAUh44/Hu2GG2TYKwy8KoFWijTiHQtv11uNbFLwEXNrjlVmPQqPsab7YOGx8QvbDxog6wfW2+AtHpOFmMmbnmjBSoFkbCzI0e1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028172; c=relaxed/simple;
	bh=6nVh/RFHPpP/ApwFY6kktPoPTdT7kWzFRFeS0hlqlNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJy7X4dWqVpix1pUEmvsmcm26xUloBZ6Ei+YaXA/UxGhNpQdg0GHiUHkKP+BIxY7Fb+KTjw6+in6fgR+dQvoLgcW1PFBCjUxf0P2MF0mHxdYaAHvfayU9mM5zwhCY6Icl3iXHzdbcO+sOKIGTQnBMCpoXOfywjAHSxrHpnfjVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfbk-00Cb9s-P6; Mon, 10 Jun 2024 16:02:48 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfbk-00Cb9f-6p; Mon, 10 Jun 2024 16:02:48 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E64EC240053;
	Mon, 10 Jun 2024 16:02:47 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 7B77B240050;
	Mon, 10 Jun 2024 16:02:47 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 1545936F2E;
	Mon, 10 Jun 2024 16:02:47 +0200 (CEST)
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
Subject: [PATCH net-next v3 03/12] net: dsa: lantiq_gswip: add terminating \n where missing
Date: Mon, 10 Jun 2024 16:02:10 +0200
Message-ID: <20240610140219.2795167-4-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610140219.2795167-1-ms@dev.tdt.de>
References: <20240610140219.2795167-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1718028168-1EC4CD11-8D8FE224/0/0
X-purgate-type: clean

Some dev_err are missing the terminating \n. Let's add that.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
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


