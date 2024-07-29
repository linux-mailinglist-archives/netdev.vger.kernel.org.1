Return-Path: <netdev+bounces-113805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B23940003
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E4FB21A27
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9918A958;
	Mon, 29 Jul 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2NJaj8d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87E189F2D;
	Mon, 29 Jul 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286940; cv=none; b=FvLmi5UQySMqEhLP1HnbLl47H2Qcu4QkV+dQHFMr7pD+4h767KOcAB0p0AmODCiPrue+gp3rBOMsER1T6b6vh0J8j77+AB/2DWBJGXuWsTgmdV5ZzUJhgAs+sp30V2rARQ4jP6eOayUhvLuZ0so1SRMQpKSg9zPQ9QwWID0y7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286940; c=relaxed/simple;
	bh=OwJ4nV0UC7z6sWgw/tEs87svxoBXUwYrj6+WA/PpIjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ajxfwhw7EiU9n9IRy22F3ikmbNcSEYem7OrSl7OjakcXg3BFd5b6m2rtAGjUgxVGppp3fkTmEbxxtCcjC4PKpGfpzohbMHA232AiJnO76L3WrODkvRTkvaptwRfR4dXHsoc/PPynEIdY2g6uWtr/utG+jPEWQC8HFmcXBLZl3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2NJaj8d; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so8722792e87.0;
        Mon, 29 Jul 2024 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722286936; x=1722891736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxImqjImHSTIXbOqmwogsB2DN1FXNY9aC5IORIJ/6/Y=;
        b=P2NJaj8dXL9vqNkDN3gGWt77N+paIXmuI1IwtCCosXvWwLTwRXB6zqmuEW99o1/rQ2
         ZpdiTZCkaimigZzYQjOvFoIduH4vN42J3aKt/yxWl5aV53rII8zrM+UeM4hhKfpeWSFe
         64LPfUaBIOHsWIvoVNI/xCV4GVisGDYX4q0X7Z3aFEbT41qxqZ/jRhUk9S4KCfoBoezJ
         XO71O4GkTAdebjxxBF3rTbKiGvHgPE31RkDPHMWCcRperxD53AihMp/r1220Hs5RpfgC
         FwN86WDVzmCIE1i7q9+UjB0ZqXd7pHgASWbnlv+5UH8dd63C2SDlkBhyRa9PUEbL9lpo
         dwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286936; x=1722891736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxImqjImHSTIXbOqmwogsB2DN1FXNY9aC5IORIJ/6/Y=;
        b=TND37sBxbbcfQZUqw7drA2niA9L0SyZ+8kd75A9Q7N40YLbbPJJcAXg80M1WW1sgpD
         B3sKbHqkNDdlgAaX6gEZ3U8PCjn64cPONY6ey/12qUgEsx0d18x3UGOQem/7wAd+auJ/
         5gLdq8IwQZwJ+FkTMia1l28hr1xOQVnfx5i60/wDsu4SWO+iPdkqGEYvcqnE+2FDx2Lj
         4o5NO+xJFy6l3D+Xzni9gyi6zrpnSwFPJ3I6gLcovB0KZL2hfVtnlzsHPF8YK+uXkTM8
         f8b4JEOmDb6+s12K7bztLr0CTePp/s/gnvlg6IWpMCUVAoqusixx4WyJD4zBalk9V//T
         xJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVgbFiYD85iUGl6mnCcGBuYbADR1Ap36zEt5lMS67MsZ/92aNHwGmxxqa74c9BkLXnsekHiXMaSHDD+Ctl8OpAEHBsv3TlLTt/+mw43y+89N+m+dEsaNvJ9FrCjtF3GuVLHrk/X1mO+lA==
X-Gm-Message-State: AOJu0Yy9YQSJtiNiph14H5WzqLU7F7wJ6NmHKGVcmE4ALuzarfCd6dzS
	D3sM835NElPqA0wuNISBRad5cvfnln+B56RsK0/1ur5qWtcSChzn6Hdid9kU
X-Google-Smtp-Source: AGHT+IFFtSBzwsQc7lH/eH0vzXqE5voEFwgC/6quafLaFGvh4reIjNQUy1cZGiBNw9v2f5qWS0yFRA==
X-Received: by 2002:a05:6512:3504:b0:52c:db0e:6c4a with SMTP id 2adb3069b0e04-5309b269280mr8853961e87.2.1722286935821;
        Mon, 29 Jul 2024 14:02:15 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c0831fsm1621050e87.174.2024.07.29.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:02:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/2] net: dsa: vsc73xx: make RGMII delays configurable
Date: Mon, 29 Jul 2024 23:01:59 +0200
Message-Id: <20240729210200.279798-1-paweldembicki@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---
v3:
  - added 'Reviewed-by:' only
v2:
  - return -EINVAL when value is wrong
  - info about default value are silenced
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 70 ++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d9d3e30fd47a..07b704a1557e 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -684,6 +684,67 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
 	return vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
 }
 
+static int vsc73xx_configure_rgmii_port_delay(struct dsa_switch *ds)
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
+			dev_err(vsc->dev,
+				"Unsupported RGMII Transmit Clock Delay\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_dbg(vsc->dev,
+			"RGMII Transmit Clock Delay isn't configured, set to 2.0 ns\n");
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
+			dev_err(vsc->dev,
+				"Unsupported RGMII Receive Clock Delay value\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_dbg(vsc->dev,
+			"RGMII Receive Clock Delay isn't configured, set to 2.0 ns\n");
+	}
+
+	/* MII delay, set both GTX and RX delay */
+	return vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
+			     tx_delay | rx_delay);
+}
+
 static int vsc73xx_setup(struct dsa_switch *ds)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -746,10 +807,11 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 			      VSC73XX_MAC_CFG, VSC73XX_MAC_CFG_RESET);
 	}
 
-	/* MII delay, set both GTX and RX delay to 2 ns */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
-		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
-		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
+	/* Configure RGMII delay */
+	ret = vsc73xx_configure_rgmii_port_delay(ds);
+	if (ret)
+		return ret;
+
 	/* Ingess VLAN reception mask (table 145) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
 		      0xff);
-- 
2.34.1


