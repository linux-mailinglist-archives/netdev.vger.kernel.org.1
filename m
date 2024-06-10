Return-Path: <netdev+bounces-102235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4809020D1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1441F1C214B5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776117E103;
	Mon, 10 Jun 2024 11:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D687F487;
	Mon, 10 Jun 2024 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020500; cv=none; b=pu+huLLeMHLsSLjZmU7szybwj6XVZKDYPrTKkjmrplCU4AOmpfW0MPqBuOt/Nt+hwHLgZPO1waaShZVbIACnCTInH9ILTxXpUYCaTz1XOR7YsXnk2k+mT2HgsCm7GfDgYRZuQ66NM5G04nNT/o5mZdqBe24xaNDcnxt353FHx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020500; c=relaxed/simple;
	bh=1UB+Yxv7R5RQxjsu3LIwDtxV1Vjf3qHcNF06y1Uk4EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWFRUE36SU6D23oW0lLgLC4FvD0IpkfdX0b9xu1kYlsgzit/JVJJKJf6EPJkrdBGEXsVlPEsu2YJTqSKJIph0taFJArSqAh7gQSMFa7tuir9tcBkau/TPMazk4ngGYWHCAenkSovOH8/uWsAB8agY2JHQYTIlTX4+AW9Zl46bRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGdc0-0002If-Qk; Mon, 10 Jun 2024 13:54:56 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGdc0-00BAaU-9i; Mon, 10 Jun 2024 13:54:56 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id ECAFD240053;
	Mon, 10 Jun 2024 13:54:55 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 80228240050;
	Mon, 10 Jun 2024 13:54:55 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 20A2626128;
	Mon, 10 Jun 2024 13:54:55 +0200 (CEST)
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
Subject: [PATCH net-next v2 04/12] net: dsa: lantiq_gswip: Use dev_err_probe where appropriate
Date: Mon, 10 Jun 2024 13:53:52 +0200
Message-ID: <20240610115400.2759500-5-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610115400.2759500-1-ms@dev.tdt.de>
References: <20240610115400.2759500-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1718020496-036F2E81-5C389155/0/0
X-purgate-type: clean
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

dev_err_probe() can be used to simplify the existing code. Also it means
we get rid of the following warning which is seen whenever the PMAC
(Ethernet controller which connects to GSWIP's CPU port) has not been
probed yet:
  gswip 1e108000.switch: dsa switch register failed: -517

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 53 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index fe64baf0d7f1..37cc0247dc78 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1931,11 +1931,9 @@ static int gswip_gphy_fw_load(struct gswip_priv *p=
riv, struct gswip_gphy_fw *gph
 	msleep(200);
=20
 	ret =3D request_firmware(&fw, gphy_fw->fw_name, dev);
-	if (ret) {
-		dev_err(dev, "failed to load firmware: %s, error: %i\n",
-			gphy_fw->fw_name, ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to load firmware: %s\n",
+				     gphy_fw->fw_name);
=20
 	/* GPHY cores need the firmware code in a persistent and contiguous
 	 * memory area with a 16 kB boundary aligned start address.
@@ -1948,9 +1946,9 @@ static int gswip_gphy_fw_load(struct gswip_priv *pr=
iv, struct gswip_gphy_fw *gph
 		dev_addr =3D ALIGN(dma_addr, XRX200_GPHY_FW_ALIGN);
 		memcpy(fw_addr, fw->data, fw->size);
 	} else {
-		dev_err(dev, "failed to alloc firmware memory\n");
 		release_firmware(fw);
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to alloc firmware memory\n");
 	}
=20
 	release_firmware(fw);
@@ -1977,8 +1975,8 @@ static int gswip_gphy_fw_probe(struct gswip_priv *p=
riv,
=20
 	gphy_fw->clk_gate =3D devm_clk_get(dev, gphyname);
 	if (IS_ERR(gphy_fw->clk_gate)) {
-		dev_err(dev, "Failed to lookup gate clock\n");
-		return PTR_ERR(gphy_fw->clk_gate);
+		return dev_err_probe(dev, PTR_ERR(gphy_fw->clk_gate),
+				     "Failed to lookup gate clock\n");
 	}
=20
 	ret =3D of_property_read_u32(gphy_fw_np, "reg", &gphy_fw->fw_addr_offse=
t);
@@ -1998,8 +1996,8 @@ static int gswip_gphy_fw_probe(struct gswip_priv *p=
riv,
 		gphy_fw->fw_name =3D priv->gphy_fw_name_cfg->ge_firmware_name;
 		break;
 	default:
-		dev_err(dev, "Unknown GPHY mode %d\n", gphy_mode);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "Unknown GPHY mode %d\n",
+				     gphy_mode);
 	}
=20
 	gphy_fw->reset =3D of_reset_control_array_get_exclusive(gphy_fw_np);
@@ -2050,8 +2048,9 @@ static int gswip_gphy_fw_list(struct gswip_priv *pr=
iv,
 			priv->gphy_fw_name_cfg =3D &xrx200a2x_gphy_data;
 			break;
 		default:
-			dev_err(dev, "unknown GSWIP version: 0x%x\n", version);
-			return -ENOENT;
+			return dev_err_probe(dev, -ENOENT,
+					     "unknown GSWIP version: 0x%x\n",
+					     version);
 		}
 	}
=20
@@ -2059,10 +2058,9 @@ static int gswip_gphy_fw_list(struct gswip_priv *p=
riv,
 	if (match && match->data)
 		priv->gphy_fw_name_cfg =3D match->data;
=20
-	if (!priv->gphy_fw_name_cfg) {
-		dev_err(dev, "GPHY compatible type not supported\n");
-		return -ENOENT;
-	}
+	if (!priv->gphy_fw_name_cfg)
+		return dev_err_probe(dev, -ENOENT,
+				     "GPHY compatible type not supported\n");
=20
 	priv->num_gphy_fw =3D of_get_available_child_count(gphy_fw_list_np);
 	if (!priv->num_gphy_fw)
@@ -2163,8 +2161,8 @@ static int gswip_probe(struct platform_device *pdev=
)
 			return -EINVAL;
 		break;
 	default:
-		dev_err(dev, "unknown GSWIP version: 0x%x\n", version);
-		return -ENOENT;
+		return dev_err_probe(dev, -ENOENT,
+				     "unknown GSWIP version: 0x%x\n", version);
 	}
=20
 	/* bring up the mdio bus */
@@ -2172,28 +2170,27 @@ static int gswip_probe(struct platform_device *pd=
ev)
 	if (gphy_fw_np) {
 		err =3D gswip_gphy_fw_list(priv, gphy_fw_np, version);
 		of_node_put(gphy_fw_np);
-		if (err) {
-			dev_err(dev, "gphy fw probe failed\n");
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "gphy fw probe failed\n");
 	}
=20
 	/* bring up the mdio bus */
 	err =3D gswip_mdio(priv);
 	if (err) {
-		dev_err(dev, "mdio probe failed\n");
+		dev_err_probe(dev, err, "mdio probe failed\n");
 		goto gphy_fw_remove;
 	}
=20
 	err =3D dsa_register_switch(priv->ds);
 	if (err) {
-		dev_err(dev, "dsa switch register failed: %i\n", err);
+		dev_err_probe(dev, err, "dsa switch registration failed\n");
 		goto gphy_fw_remove;
 	}
 	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
-		dev_err(dev, "wrong CPU port defined, HW only supports port: %i\n",
-			priv->hw_info->cpu_port);
-		err =3D -EINVAL;
+		err =3D dev_err_probe(dev, -EINVAL,
+				    "wrong CPU port defined, HW only supports port: %i\n",
+				    priv->hw_info->cpu_port);
 		goto disable_switch;
 	}
=20
--=20
2.39.2


