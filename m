Return-Path: <netdev+bounces-173230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C728AA58009
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 01:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0085116BD30
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6282D4C91;
	Sun,  9 Mar 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY3TuekF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E574A07;
	Sun,  9 Mar 2025 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741480398; cv=none; b=SkN5MEUerOjEIhaGidC83AMS+PWj/qA2ecl4VblxD7j92WTxlCqG8B+UX1TYXVEAFUgP67oKBG0sOD+ToD5FfKcJA7fdDeyQipc7LHNqeKRoWxQ9LPRKUC9Y3sydwIKawxi3wfU+HyCY0aRDaXxX+n40nRDy5O0qCTtRV0TXawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741480398; c=relaxed/simple;
	bh=H5vGGdWJkwimPxQknMpb14wXFyU4qmgXRHQJ9Ps5V7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfFNu+39sk2PozKA5Zr3AKCVaJi+HhYoB/8trZ10COX8vpqOWQkJbQQxocSekmLV4e2Gstq53ddZbj1mdKovfGL686PTjN3KroBNwnInegdYOhc30xJKeZUXRGRRVOr9kqumlw4jqgh3q4PyjlKA5YDSfN4Iivv6RHL1IP8D5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY3TuekF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1609256f8f.2;
        Sat, 08 Mar 2025 16:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741480394; x=1742085194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPD5zeaLyTv7Qy4hdBTQxNRUyG0FnO7mcXkBMLrnQgo=;
        b=YY3TuekFIqkBenIBILtjB9Dog1kMoR14a/1PYOXbJb/yKELoA2RXGE+Y3CbJlA6pqM
         DCt9o5cPjth4dihCaR7upYS5CEARwa6be1sgfyifIqD31izO1OiDSZNEnxCJqS1vZ4JQ
         w2xEQ7Ian1RJHCr8012Zdn60dUSSYk7dpg3hw248jxYiAFCcpbJ6FF2CxZKFsZ8l8Qnt
         1yzl8Ozcdr8i+3LwloxDFa6nb73vJB3CBUtvqu0spEk4yX74O3r79myXbIP9FJplfaee
         +wD3VwjY0zzOnHuEr4X8Ax8np2dKfqCOnrF4U28GqxA6lNDsHpuXfoDXbyrB5P3xqrAZ
         pf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741480394; x=1742085194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPD5zeaLyTv7Qy4hdBTQxNRUyG0FnO7mcXkBMLrnQgo=;
        b=isO0sUwkvQxLsCzasz5MAMc7fDyilq6/n4jmBgrb9PeTu8gAMNf5a9zeeM1ifIZDX0
         6pfJVWV5TpkFH4PXOgHP5H4qPetnKXGMtz0fGsfGTR8Edd+kAqAblBg3HEmp49eshHF8
         na2bc1sGVcX1BMktlhqlHfCI6bokKzYgZTLSNxiPVMRg8gQDXKKR8fRNK45EduBVGRJS
         icFi4WhqbffVMTZFiy87fBontViesRSVKu02YBsERALWxUW/rgU7CAOkBeEuUS98+//6
         0rhktEPxfE/9ZyAvIIdvYKXX3hRZ4YAkj66orCf5ctnYV2vIvOQ6KJAtjsRhZEjU3d8R
         t0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8vUs+KXkrwAjpWAHfBiNlN3kWjJTehMaiGZTrAFZWZ7A+8Lal71/GeT/9zOlO3cDk+KMY+Tj7@vger.kernel.org, AJvYcCXIItFLpb2lxU/v4idg4C+B86OZxw95uurun1fl/80e27Ibmoi9pNgtehCSPWstNpjUYNEB0X2p41Yhp08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvAHNEyTEbdOm44/+fMvcPnSjwJAqtamncuFKiyOOl5cTcKPHZ
	pLlMtPFOmFRZHqW80oGZ2egG9Gitx4VP28RDJctagvkN4axmDqaJ
X-Gm-Gg: ASbGnct/07ARu1jvrrHbo18g2NflLGW5G1HZAf2opsGVPSNXdeJE0WjYy9KA1C2fmuL
	GaU4aaXnAP0bpGeklg9j/qDtak7I+OBG93RttWhea6nkwScPSS95arVpDEpHxrt7weMQ7lE4VVP
	o60vSPFy/H10o5erPQjrvhVYvXm87QNvJeBosSEkofJpB6+s0CPROKtsS/pCOhIUdvJaqQXZgXI
	dDw8BMIKpkdBNm+m1wdRyPp9Vdo2yhqrP3fXlGC7WUtd3SBp8/iPwjuR8mWCnLo9ywqeonBV2qX
	JKIQhxx7bM5zviYAZCATJATLVU7JOItpf6OTnzeIpmEr4gxxZ54RdJtMboETCdQF6RMXJxudmQ=
	=
X-Google-Smtp-Source: AGHT+IH28MQPA+zgYnEC4J5mfzAYw/utosENTHqe/I9TDxz+92mmLwx5LY/MLbLi26Rzp9G7AsQlAA==
X-Received: by 2002:a5d:584f:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-39132da08b4mr5384923f8f.40.1741480393495;
        Sat, 08 Mar 2025 16:33:13 -0800 (PST)
Received: from prasmi.Home ([2a06:5906:61b:2d00:238d:d8a2:7f2b:419e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm9976382f8f.89.2025.03.08.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 16:33:11 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Linux Team <linux-imx@nxp.com>,
	David Wu <david.wu@rock-chips.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-mediatek@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next] dt-bindings: net: Define interrupt constraints for DWMAC vendor bindings
Date: Sun,  9 Mar 2025 00:33:01 +0000
Message-ID: <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The `snps,dwmac.yaml` binding currently sets `maxItems: 3` for the
`interrupts` and `interrupt-names` properties, but vendor bindings
selecting `snps,dwmac.yaml` do not impose these limits.

Define constraints for `interrupts` and `interrupt-names` properties in
various DWMAC vendor bindings to ensure proper validation and consistency.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

Based on recent patch [0] which increases the interrupts to 11
and adds `additionalItems: true` its good to have constraints
to validate the schema. Ive made the changes based on the DT
binding doc and the users. Ive ran dt binding checks to ensure
the constraints are valid. Please let me know if you'd like me
to split this patch or if any of the constraints are incorrect,
as I don't have documentation for all of these platforms.

https://lore.kernel.org/all/20250308200921.1089980-2-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers, Prabhakar
---
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml   |  6 ++++++
 .../devicetree/bindings/net/intel,dwmac-plat.yaml      |  6 ++++++
 .../devicetree/bindings/net/mediatek-dwmac.yaml        |  6 ++++++
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml         |  8 ++++++++
 .../devicetree/bindings/net/rockchip-dwmac.yaml        | 10 ++++++++++
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 10 ++++++++++
 .../bindings/net/toshiba,visconti-dwmac.yaml           |  6 ++++++
 7 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 798a4c19f18c..0cd78d71768c 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -152,6 +152,12 @@ properties:
           The second range is is for the Amlogic specific configuration
           (for example the PRG_ETHERNET register range on Meson8b and newer)
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml b/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml
index 42a0bc94312c..62c1da36a2b5 100644
--- a/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml
+++ b/Documentation/devicetree/bindings/net/intel,dwmac-plat.yaml
@@ -41,6 +41,12 @@ properties:
       - const: ptp_ref
       - const: tx_clk
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
 required:
   - compatible
   - clocks
diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index ed9d845f6008..3aab21b8e8de 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
@@ -64,6 +64,12 @@ properties:
       - const: rmii_internal
       - const: mac_cg
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
   power-domains:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
index 87bc4416eadf..e5db346beca9 100644
--- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
@@ -56,6 +56,14 @@ properties:
         - tx
         - mem
 
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
   intf_mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index f8a576611d6c..891396140a7f 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -58,6 +58,16 @@ properties:
               - rockchip,rv1126-gmac
           - const: snps,dwmac-4.20a
 
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
   clocks:
     minItems: 5
     maxItems: 8
diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 85cea9966a27..987254900d0d 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -54,6 +54,16 @@ properties:
     items:
       - const: stmmaceth
 
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: macirq
+      - const: eth_wake_irq
+
   clocks:
     minItems: 3
     items:
diff --git a/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
index 052f636158b3..f0f32e18fc85 100644
--- a/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
@@ -42,6 +42,12 @@ properties:
       - const: stmmaceth
       - const: phy_ref_clk
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
 required:
   - compatible
   - reg
-- 
2.43.0


