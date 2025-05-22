Return-Path: <netdev+bounces-192799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA4AC11B2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23783ADC08
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52D2BD593;
	Thu, 22 May 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRDr7jXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3462BCF71;
	Thu, 22 May 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932837; cv=none; b=dRVGv8AC3oborA4FWnq96GZWKUEGpfGJtLF1fhGJH8D8E4fkdtiUthUUQIbV9QTcJ32pNFNvP+ZwDSn3YjSOTvPmr6NOxzp4KV9fK0mVpPJP7GRNpYbB9DnpKpMafyrTpzCmeHczIfima7vaKO55n0PPH5kWzgSaZmjhVTSa+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932837; c=relaxed/simple;
	bh=4gyWnd/4zsl0E05B/FGdAYmZpRpL0zCQ1NcV33DaRgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTf0JQT1FE3J2Wv1HlWfevFRhQJ2rbXTDOTB2q2bGYmxo6S3X9e+eVph3Vj5hQSUj999hkV2FjoZ18w6oc4pNJZWdvBIyePdxZ0e8I2agDlXLKxgcq5Wi6kn4Peu2aY3msYm20fI+n1scIojsFLTe8yFTNW51XV3YBOuXVcLQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRDr7jXA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-44b1ff82597so3192455e9.3;
        Thu, 22 May 2025 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932834; x=1748537634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mPWUWkwmmObY+Ge4/3GNYHR3RTsnlUqPRmRgUCBL5s=;
        b=SRDr7jXAd36dpbpgYyD28TZsSVRN+BNXjSRQ98GXRpU4xQKti6K3IKxr/FxJguSqXi
         D4BsW/kNgp5fAwI5+4j+Jejg7d7ps2dcotfm3fhEdXhb0NrJsRtnuznwOkWUOVIwRjMw
         QLoBE+r17DTCt0hN0q8KFKHUmHaLWgGHrxzRsUCL1VwA82ZSkcIENPffCHMaMxxgeW4l
         8hiYg74JrUH+DztLgrL0iO153NOTmxx1ba2uh3aoty7Cz9sn9cFPOcrkS6nzeNKLigi9
         LYgt0KWhx6lvdc/VD99So5rXA8He+1j+igYNeNOshUD6FDP7p0JNiJauL4xyVkN7WgMX
         QVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932834; x=1748537634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mPWUWkwmmObY+Ge4/3GNYHR3RTsnlUqPRmRgUCBL5s=;
        b=XDmD/v0v5hwUsjrOEG/aVD2f4ZLiPR/eqfjwiSJehdjoWFBRXkynAkuY7heQOa9Acm
         vMQff2BXO+nvlYlxSlIqxupVQRO3Mor4ICmg7Ut2W1j7X6DeN0fS2uNFqQjvMalowUv7
         jf91Ze0U0E9+pVejG7xwTietZXh1lK6JFBhmPSWe32FLQGQuJlWJTZQEiBbIxhgx+LVl
         QHBEAGhF063MCj4UGRnKv+XYxbyyAGajJR4UGrJUt8y3PuYvy4FmV1WSLI2kho358Mu0
         JXklsDtkcmIKGdA3vxeEUb+6VgAOS0Xem5TgIYkcKHssy+6B13Cm8QmhEzctROkEiLZ1
         mqRA==
X-Forwarded-Encrypted: i=1; AJvYcCU2a9/GEaCNCtzyokpx8NTtSJ5+tOBiTrtXZ3bh/pdxpgFHEtX6oV71Cmjnq7jXSb4ytMxcjfCsoO7a@vger.kernel.org, AJvYcCVRPG2/G1ReACpuKGobT/5E2aY6eINM3xgZmYzqPKWVkj1vevfu19uWa/ovvkeKc7rZci4/Rw+s@vger.kernel.org, AJvYcCXI0JwD2q4/Ko9Q3ZbfdN0o+c7aPPGulYNQREAUoaccCRb52uUsBYmCmuk6KZyLFx46WKkhrN3QpvkMZCp5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xwmhdp5rNY/3DlGeZrrAD45FqOX6Vh56kBPP++1vvP7uYpZ2
	+W5bnTHZHtO4vHiE7zMPXN1vj8in3ZRjkgZj8O5i3T0JCqitrRGvpV+U
X-Gm-Gg: ASbGncsMyv8ZtXr3v6w9dBtmqmXIEpWdu+Ae64Q2ltH0hg3jr3wwdeQJgr2vF0MDn9J
	XFLuH7LDseIJGsQIfd260T391iIhLqdWZQMICuwjSfhV8wUcJvDJtgj+hIsvHkNy6YfNvzu8aLq
	3VwImbOa/CmCQm379BIBJ6cGMobA///QSP5cDkyo+OS7pOJtqIZQ0zBAcnlHBgluFGT0IgtjQON
	dHIwOLYQhYrvCehVAPH8lYZ9heL67fzfBnqEVSiU4+cgdkjNqKFOQVDa8lQMskWcRGxr8HHz6v3
	UjER/4xLePv2e2Y/g6mmI8G/vFoHC93GIBaVsYza7J0rCZKdmdrhTTUY0IymS7oZmxreZsrj0YX
	axk8zz04nekiOBSwDFJoe
X-Google-Smtp-Source: AGHT+IFmR4PB7sf4/6zd128WxYGdEUHoGzx/c9HXM4LqXrQuqXcb1xnJb7dY9wh8h9zgkCfv8xuaYA==
X-Received: by 2002:a05:600c:8507:b0:43c:f597:d582 with SMTP id 5b1f17b1804b1-442fd608753mr236599325e9.1.1747932833793;
        Thu, 22 May 2025 09:53:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm118737525e9.6.2025.05.22.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:53:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 2/3] net: dsa: mt7530: Add AN7583 support
Date: Thu, 22 May 2025 18:53:10 +0200
Message-ID: <20250522165313.6411-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250522165313.6411-1-ansuelsmth@gmail.com>
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7583 Switch support. This is based on Airoha EN7581 that is
based on Mediatek MT7988 Switch.

Airoha AN7583 require additional tweak to the GEPHY_CONN_CFG register to
make the internal PHY work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530-mmio.c |  1 +
 drivers/net/dsa/mt7530.c      | 24 ++++++++++++++++++++++--
 drivers/net/dsa/mt7530.h      | 18 ++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 5f2db4317dd3..842d74268e77 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -11,6 +11,7 @@
 #include "mt7530.h"
 
 static const struct of_device_id mt7988_of_match[] = {
+	{ .compatible = "airoha,an7583-switch", .data = &mt753x_table[ID_AN7583], },
 	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
 	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
 	{ /* sentinel */ },
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7361380ffb5f..df213c37b4fe 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1298,7 +1298,7 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	 * is affine to the inbound user port.
 	 */
 	if (priv->id == ID_MT7531 || priv->id == ID_MT7988 ||
-	    priv->id == ID_EN7581)
+	    priv->id == ID_EN7581 || priv->id == ID_AN7583)
 		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
 
 	/* CPU port gets connected to all user ports of
@@ -2612,7 +2612,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
 
 	/* Enable Special Tag for rx frames */
-	if (priv->id == ID_EN7581)
+	if (priv->id == ID_EN7581 || priv->id == ID_AN7583)
 		mt7530_write(priv, MT753X_CPORT_SPTAG_CFG,
 			     CPORT_SW2FE_STAG_EN | CPORT_FE2SW_STAG_EN);
 
@@ -3236,6 +3236,16 @@ static int mt7988_setup(struct dsa_switch *ds)
 	reset_control_deassert(priv->rstc);
 	usleep_range(20, 50);
 
+	/* AN7583 require additional tweak to CONN_CFG */
+	if (priv->id == ID_AN7583)
+		mt7530_rmw(priv, AN7583_GEPHY_CONN_CFG,
+			   AN7583_CSR_DPHY_CKIN_SEL |
+			   AN7583_CSR_PHY_CORE_REG_CLK_SEL |
+			   AN7583_CSR_ETHER_AFE_PWD,
+			   AN7583_CSR_DPHY_CKIN_SEL |
+			   AN7583_CSR_PHY_CORE_REG_CLK_SEL |
+			   FIELD_PREP(AN7583_CSR_ETHER_AFE_PWD, 0));
+
 	/* Reset the switch PHYs */
 	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
 
@@ -3344,6 +3354,16 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
 		.mac_port_get_caps = en7581_mac_port_get_caps,
 	},
+	[ID_AN7583] = {
+		.id = ID_AN7583,
+		.pcs_ops = &mt7530_pcs_ops,
+		.sw_setup = mt7988_setup,
+		.phy_read_c22 = mt7531_ind_c22_phy_read,
+		.phy_write_c22 = mt7531_ind_c22_phy_write,
+		.phy_read_c45 = mt7531_ind_c45_phy_read,
+		.phy_write_c45 = mt7531_ind_c45_phy_write,
+		.mac_port_get_caps = en7581_mac_port_get_caps,
+	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index d4b838a055ad..7e47cd9af256 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -20,6 +20,7 @@ enum mt753x_id {
 	ID_MT7531 = 2,
 	ID_MT7988 = 3,
 	ID_EN7581 = 4,
+	ID_AN7583 = 5,
 };
 
 #define	NUM_TRGMII_CTRL			5
@@ -66,7 +67,8 @@ enum mt753x_id {
 
 #define MT753X_MIRROR_REG(id)		((id == ID_MT7531 || \
 					  id == ID_MT7988 || \
-					  id == ID_EN7581) ? \
+					  id == ID_EN7581 || \
+					  id == ID_AN7583) ? \
 					 MT7531_CFC : MT753X_MFC)
 
 #define MT753X_MIRROR_EN(id)		((id == ID_MT7531 || \
@@ -76,19 +78,22 @@ enum mt753x_id {
 
 #define MT753X_MIRROR_PORT_MASK(id)	((id == ID_MT7531 || \
 					  id == ID_MT7988 || \
-					  id == ID_EN7581) ? \
+					  id == ID_EN7581 || \
+					  id == ID_AN7583) ? \
 					 MT7531_MIRROR_PORT_MASK : \
 					 MT7530_MIRROR_PORT_MASK)
 
 #define MT753X_MIRROR_PORT_GET(id, val)	((id == ID_MT7531 || \
 					  id == ID_MT7988 || \
-					  id == ID_EN7581) ? \
+					  id == ID_EN7581 || \
+					  id == ID_AN7583) ? \
 					 MT7531_MIRROR_PORT_GET(val) : \
 					 MT7530_MIRROR_PORT_GET(val))
 
 #define MT753X_MIRROR_PORT_SET(id, val)	((id == ID_MT7531 || \
 					  id == ID_MT7988 || \
-					  id == ID_EN7581) ? \
+					  id == ID_EN7581 || \
+					  id == ID_AN7583) ? \
 					 MT7531_MIRROR_PORT_SET(val) : \
 					 MT7530_MIRROR_PORT_SET(val))
 
@@ -673,6 +678,11 @@ enum mt7531_xtal_fsel {
 #define  CPORT_SW2FE_STAG_EN		BIT(1)
 #define  CPORT_FE2SW_STAG_EN		BIT(0)
 
+#define AN7583_GEPHY_CONN_CFG		0x7c14
+#define  AN7583_CSR_DPHY_CKIN_SEL	BIT(31)
+#define  AN7583_CSR_PHY_CORE_REG_CLK_SEL BIT(30)
+#define  AN7583_CSR_ETHER_AFE_PWD	GENMASK(28, 24)
+
 /* Registers for LED GPIO control (MT7530 only)
  * All registers follow this pattern:
  * [ 2: 0]  port 0
-- 
2.48.1


