Return-Path: <netdev+bounces-111810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479D933094
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 20:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CC1B20F42
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412AA1A38DC;
	Tue, 16 Jul 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGXix5eR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D01A0720;
	Tue, 16 Jul 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155097; cv=none; b=mMt2xHxmLaGYYIfkTheJkh9JwPV2lVOZq1FiT6T8W/60iG150Q4by8g3jsuZQHd/nvOEDkCO3ZalbxiVayZKaZ4YdpZpoLND6K+KGI+/KZCo5JgsH5oSM1fhoOVNh3qpObJvBwYSitjS4Y/GZJgSD3GlOPB2mp5EfN4+wm989Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155097; c=relaxed/simple;
	bh=bhIWzgmFY3aeKFrE6cUAq/sjmY8KoRONFtyh21jnxEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HmlKOS+kZT+n6Lg1arHcoSgVlLw4d5qBzib0ubkTo+kkIkiryld8g90pfFzWW95Q9cvX7zKqLbcu/vUwgIdJBiLY+KxLyCRz1Dr41EacyXd2gL+DMQu7bEHJ1OBtiUfxB5FeqcgbOvm+k0xO1CPT2aJ4xpvCEoOBXHaaispoao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGXix5eR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso7422424a12.1;
        Tue, 16 Jul 2024 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721155093; x=1721759893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2QpPFCXFSzwXuk5Smpy2Q+ucAYxfBE33tkpjc80+O0=;
        b=TGXix5eRY5rtFunR/5pZdaCkHLpvELzo4eAXiudW45ALvOXmHANlSTmuDG4b+LMP86
         DwggqUvltmbqUxzraPnCnN4WSv5R70HR3tHr/c5bbuViA8SnAwozml49EUh/FNUbkCEH
         wLSB4MeZqbs9hLcdmySqK05FdIVXtuM0glWnCoK27Xgk+KFan3V/kmtShxhkndFMJleL
         XHC4r/TxQlc00bDjXHtzbSu66wLvTovvcvcGmBIciYdxa7TLJiEu60qlxOVeSENnYg8C
         0i6ZChmZcWCp235DGU9+DZTaWTwGVfO34VX5qKd0Ms3uYdCu+6v7FDiPKbPDk8X45gbB
         vUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155093; x=1721759893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2QpPFCXFSzwXuk5Smpy2Q+ucAYxfBE33tkpjc80+O0=;
        b=VU44waH8BLCVYd3dXFMkc5mEqgD9ctOe5bvoOrX1538Qy7yEW3AwEkAgxyNb4wnK3G
         6N4Waw+QVpeu092U4TwMbi2pf4HOQxBiDH1/7IN3kxniKMY/JFAkM1Qz6AkHEGcetZc2
         MkgMMs7aU6PKl4ouhXppJ10QHR3vb7uMCWC/4g/hFFiaYnGgBgTtVB57kte2OoYnIHim
         Vm5dn7WJz6T2KYMndPyKobQZ1Pf5cwqh5i2UeKlvs5st07wyibIOMH6N5pv/FTa5Oq1r
         96nKTDylfdI/BP13l4Z8zNr5N2ProwwP+Jfs3Nvk6E3lHcPoIE+AoR1Rlv+/xqra0/6r
         jMUg==
X-Forwarded-Encrypted: i=1; AJvYcCWg3UFKD+v0hMF2nH91K+/sOrpj5i9N1a+lsPlC4tKEe0Zdpb3QibSg6ojvxZhySu7xH1zpewuPG9FkXN+eQROusq/Fy2b452juAYVpxB1/IR78Vt2/YnuwtJtDJDyb0XfuwE+2AsdrWQ==
X-Gm-Message-State: AOJu0YzxTTaQ+vGIvaoKtlv3qLU0kkkLLXDAcw2jn0ZTPjkq1ONvkZX4
	TTu/yyosq17RTMGTHHjnLWRKt+JM3SO410hFwFNQG+Sc74fcJHyFl4w1hit0
X-Google-Smtp-Source: AGHT+IG0+8sJk4vnch/lSp8v1ukZvC8dyq5Z0AzM0HJxIe8NnKCTXm5Ja4RKUb3uO0OQT4puwhQSeg==
X-Received: by 2002:a17:906:e05:b0:a6f:27e6:8892 with SMTP id a640c23a62f3a-a79eaa5b6f1mr187899866b.60.1721155093080;
        Tue, 16 Jul 2024 11:38:13 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820eb3sm341852366b.207.2024.07.16.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:38:12 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: vsc73xx: make RGMII delays configurable
Date: Tue, 16 Jul 2024 20:37:34 +0200
Message-Id: <20240716183735.1169323-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch switches hardcoded RGMII transmit/receive delay to
a configurable value. Delay values are taken from the properties of
the CPU port: 'tx-internal-delay-ps' and 'rx-internal-delay-ps'.

The default value is configured to 2.0 ns to maintain backward
compatibility with existing code.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 68 ++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d9d3e30fd47a..7d3c8176dff7 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -684,6 +684,67 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 	return vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
 }
 
+static void vsc73xx_configure_rgmii_port_delay(struct dsa_switch *ds)
+{
+	/* Keep 2.0 ns delay for backward complatibility */
+	u32 tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS;
+	u32 rx_delay = VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS;
+	struct dsa_port *dp = dsa_to_port(ds, CPU_PORT);
+	struct device_node *port_dn = dp->dn;
+	struct vsc73xx *vsc = ds->priv;
+	u32 delay;
+
+	if (!of_property_read_u32(port_dn, "tx-internal-delay-ps", &delay)) {
+		switch (delay) {
+		case 0:
+			tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_NONE;
+			break;
+		case 1400:
+			tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_1_4_NS;
+			break;
+		case 1700:
+			tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_1_7_NS;
+			break;
+		case 2000:
+			break;
+		default:
+			dev_warn(vsc->dev,
+				 "Unsupported RGMII Transmit Clock Delay, set to 2.0 ns\n");
+			break;
+		}
+	} else {
+		dev_info(vsc->dev,
+			 "RGMII Transmit Clock Delay isn't configured, set to 2.0 ns\n");
+	}
+
+	if (!of_property_read_u32(port_dn, "rx-internal-delay-ps", &delay)) {
+		switch (delay) {
+		case 0:
+			rx_delay = VSC73XX_GMIIDELAY_GMII0_RXDELAY_NONE;
+			break;
+		case 1400:
+			rx_delay = VSC73XX_GMIIDELAY_GMII0_RXDELAY_1_4_NS;
+			break;
+		case 1700:
+			rx_delay = VSC73XX_GMIIDELAY_GMII0_RXDELAY_1_7_NS;
+			break;
+		case 2000:
+			break;
+		default:
+			dev_warn(vsc->dev,
+				 "Unsupported RGMII Receive Clock Delay value, set to 2.0 ns\n");
+			break;
+		}
+	} else {
+		dev_info(vsc->dev,
+			 "RGMII Receive Clock Delay isn't configured, set to 2.0 ns\n");
+	}
+
+	/* MII delay, set both GTX and RX delay */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
+		      tx_delay | rx_delay);
+}
+
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -746,10 +807,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 			      VSC73XX_MAC_CFG, VSC73XX_MAC_CFG_RESET);
 	}
 
-	/* MII delay, set both GTX and RX delay to 2 ns */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
-		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
-		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Configure RGMII delay */
+	vsc73xx_configure_rgmii_port_delay(ds);
+
 	/* Ingess VLAN reception mask (table 145) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
 		      0xff);
-- 
2.34.1


