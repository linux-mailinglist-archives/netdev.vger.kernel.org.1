Return-Path: <netdev+bounces-111950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B619343DE
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 23:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF131C21A3D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407618628D;
	Wed, 17 Jul 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb3LDR6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1471DFC7;
	Wed, 17 Jul 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251704; cv=none; b=aNUWUl8AjTLJX37T2ibOjOZL+Hu0Gtf5aL9Bsn2xiej3UB2eCdKni5CY+QSHE6nWgI50dOJaVk7MEdSWvvPvSOdAgUWrAEWr3vxtj6MIBzup/PdVHHuqiwVtSMQnH8fP5aAyigEL45J+IJecJLvW/xut3x+GmjpkabG89grD/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251704; c=relaxed/simple;
	bh=2RcPcpv7SvYe/yZx3nBaPDHt9iQeKnim4PDIKuMXdX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZRyQQ1QdEKZi502xfND25hXPQrWCmqL7dSSUyptT4ZnUoO/c6T8gpK6iTfJMuNrDKrbihxxJd37MZSoiOLZ5cVP9oFBnjPhdt7PicdsayejYmY8rDExashw9ErR6zllEA6yLNs4r1GPn4Q4GbGWMnMRAMrssF8vxnaBPCCOqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb3LDR6y; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a015a79e80so64411a12.2;
        Wed, 17 Jul 2024 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721251697; x=1721856497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yjs0IVdjyDT9iqnwd766psZzpHPEtfCwRohPJnJKSJo=;
        b=Gb3LDR6yq+Yrh175b9WXAAEOlH5TR7a3Ltw+0a8Jdu/O1qe0YVxCxQ/xLAVYHmHFjj
         7tcUaf0UHHzvK7gpsj3+qhSiuESxLw53jOBVPcpMfrUsh09YWfuFKuqe7QpFZOjncxGk
         3OmGNOygFSBMekY87Si8v/gHEjhE4mporFMa7Ty9CkOyvV7y27PLgBtXmg/lmW352nRc
         Mx7Q2O6zozK04pS9siXsZQLgDA1RpkJmY9VMDMz/rXjFHnNPrgLimBFMnBm3X6p0K2B2
         +9XpccyG0pf/cjoVXZ+BsUMl/R5DRLlsPYNesV3wnA6kSzwmWTHKkHdzOQbTrf75vIkN
         gVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251697; x=1721856497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yjs0IVdjyDT9iqnwd766psZzpHPEtfCwRohPJnJKSJo=;
        b=rkuucmjguK7y1cK4FXm/R3K+AdmSXuDwn/TElzY0t8k4dDAxDWwkQan60+x4izInBl
         UQbGS2DoVfUJPzKU/ZfVX0DOv+bI0P1Y4CAjwqgGG4SWNy5XSXTuK96Uq8mQFV9vwGis
         m+PxcUJwybf1v67E+ehDo9p/oAOFEpabFQUIwPWXkxRbJBgmqqfT4yVXuYEP97rPes5j
         k/kUwYG+WN1tdgpXbf9OLlKddRkobeLnMeQgtRz4K5JRm+AuzpjsXrFWbgp8MFr/Bsx4
         mJOiwEw9pSvEGXKD+fMikWCw67VXVt+B4zSI3BZxwXZlYwPeVKPVoiNYSjtEHxzEoCMY
         pZdA==
X-Forwarded-Encrypted: i=1; AJvYcCWuL6yykmASI2wXFtMHKjKusVqhUsgdR5fdU4+xu4Aw6xsoGAoU2sKAuvcmVd6lmBLnJczFoSnJR5kG0G6yBlsweOA85U60b0lhP5FoYV2l6V0pfhpFVEwBQ/9zNY6snJLrMnG3QfcM+A==
X-Gm-Message-State: AOJu0Yz63x/jvlblo8a5DIqQcGeRq9loHTkQeQqMGwQIMCuV1obYBycp
	9DHB9rop6PbDOwOskW4kYgV5+xt27U8iR8wplnzT+lZ81a3SzXo+WBGPgliX
X-Google-Smtp-Source: AGHT+IH+rHLLyjv3frBZs6vGgQE2WEWaswyvjslddLOJk73obLB4gOmnyiZ7G1/ntexebva0w5Fttw==
X-Received: by 2002:a05:6402:2108:b0:58c:7c01:2763 with SMTP id 4fb4d7f45d1cf-5a05d2e006amr2813558a12.33.1721251697326;
        Wed, 17 Jul 2024 14:28:17 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76f02sm7529198a12.2.2024.07.17.14.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:28:16 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net: dsa: vsc73xx: make RGMII delays configurable
Date: Wed, 17 Jul 2024 23:27:31 +0200
Message-Id: <20240717212732.1775267-1-paweldembicki@gmail.com>
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


