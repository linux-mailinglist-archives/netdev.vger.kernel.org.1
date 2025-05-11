Return-Path: <netdev+bounces-189592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2CAB2ACD
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C2B175C2A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EC267734;
	Sun, 11 May 2025 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rblb+PKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD96266F0F;
	Sun, 11 May 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994418; cv=none; b=uX81RpO0ZSx7sapjga4lR3Pc6Ge/rvQAU6vH38d1pHGXZUGlPE5kVKJ8VTZkihmb2OBMVte1nvxAVrNf2SWhyRgXpRIelMMb9/jyEh/M7LciSk9omEeS8gaKj0Lbv+1BdRmphaMjK7EWY2b2RLYP0RhmXNl3wXkCSfFY+QfNy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994418; c=relaxed/simple;
	bh=jFcXF/4dVf1e7vAXuyL5qekxKu5hoLO5I3j0YrY52CI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck+roy+y3juNAIOr7lnvxjBqGWRYpbNXj2WRBkIomrrYIRQo5gkzymjc2hBJwM1cB98IppwiKDgKCWlAdpfd/ZwG87+LEqT1I/EhjLjl3XpqbNyyjpuj0JVg6u3RQoxBCHOW1AYLpAscQ8nHQv5J+dt6SbZdDkorJLBCmsvvG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rblb+PKm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso28318755e9.2;
        Sun, 11 May 2025 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994415; x=1747599215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwoa6YEoLumzQE8cS+ad1dIlqWJKYevB3c6NtJXNM8U=;
        b=Rblb+PKma3lFLqn1pQ13i1fkwmpFDtiESV5creekZSaLNK2OfYLBbDsWqBtS70e5VI
         OLQN6G/9AnVbEJ8GI1BTFCG7h703UPaI+xes4efg6MqKNCH2zPKFOgSJy63iYUALisFl
         2ie3us21g0b9Gr0/oCfSN/AViAKRh0Bp8buOLZu32AfXqUIW+/gRvGoVqSpVu3wdCKTL
         mZwR2RpYG6yJmo0FeUIWW2A4asekS84ngSL0av9GS8uknPRLdbQdz9wUt0+rbWeaZj+6
         PCgZRe0P/KyA/OrQARNmOOdjwWUGj1VZGwcY2v3kuXwHMlvEzIkXNlDssVQtdessdaiE
         mrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994415; x=1747599215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwoa6YEoLumzQE8cS+ad1dIlqWJKYevB3c6NtJXNM8U=;
        b=KaUrrtehKvFFooEzEdGXNRQzgo5o5Qgqt4bpU8DcwmN9ThnGAYDRDErVamtxDyu4Yo
         eu3y+ZBXthMyH7vgCfFk7n6ynR3meNqyPheKn4+8v/TVVW2Tf8QP39ZbR/kD2X6C2mRa
         sMEohKRxMDgwnke0pCKyBAepBHATgmGkvsHORpsQAZSkpCQ7Ak5NpPSAKgDpwZ3vN7/C
         YTJ8k4uqpX2e9FFBme4C/Z1tMc38YZc03cE3tKTKLPIqDay/p8ZiweAZXnf8WvRcTg3f
         xrxVbJvArs2WaYob1PC2ixXR29M9JkBKDmloQi642nK4k8voMOLYFo/Kv6xLeSwdWjlf
         XWAg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjaNxAJnW2US4WoQLFeD0YmhD1qj/uKULutc4Bnz0zorfODbl32Le6PtvB7/QL1+x4BmK3zlx@vger.kernel.org, AJvYcCVYl3FMV3gSVdf4Wb1muNlIvlelCLrh9PKQL9LIDqeIeiUqoF/pi1wOqOKX/fIWyAi1DXHrLwKwxbXh@vger.kernel.org, AJvYcCVtey/j0T+Zi3bjyAQWUDxjhCxGsGkyLJUtLmcLav+dr+H5wbZdTV4M9XHWQFrqlvJzLZerSHhSum54ISnU@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+V2v+1PBVDoHdyz3HsfW0lSdsc1jw1qE8Al0+5k1GWwwTgQE
	JHn/dijDxqgtwlzHfVVSmJ3fnIx92FO5f/mTHsKH2tAm1VzDkez1
X-Gm-Gg: ASbGncs2GieGQ1Jvl6iyIWBfwqacCWDaCqj0aB8vEPAlNwgYHuYdhhirBli1IrWxwlX
	RkLednuoTbOUaz+9PsBflicDPhFRxfyRauYg/Tfm74r7ruNAjD7bNOi5rU5qZOomoOc/sgAoNWA
	A+ifg9oAG8xYuouOfeFYIZKP9mLThhzcNjmvSnMBj+sS/lyVq6y9AraaClna5C1Xa2MkSF2xf9s
	MQqQoRZhuXr45hMTP43mK1DxqZ2xhtAEvNggCw5bEYnvRLzqdH5I9D3jhv9quLUT5mz8wKhh8NY
	EQW3RDKw4kITKbQXU406/oy88diJBJEiFQFLtW3X0qwemIZL1nKDeuAUfQHbioEzgjm3DF9ytFr
	5i3n3u00+g799U10xIXQD
X-Google-Smtp-Source: AGHT+IEOWK8ud3qNK29LCO+35MG4PEuwn5Jd54n78utiERk537v3iwnnobOuImhQnqz6zBJyk8U4wg==
X-Received: by 2002:a05:600c:8205:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-442d6d6b6b3mr87886265e9.18.1746994414900;
        Sun, 11 May 2025 13:13:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 09/11] dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
Date: Sun, 11 May 2025 22:12:35 +0200
Message-ID: <20250511201250.3789083-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha Ethernet PCS for AN7581 SoC.

Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
the various Serdes port supporting different Media Independent Interface
(10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

This follow the new PCS provider with the use of #pcs-cells property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/pcs/airoha,pcs.yaml          | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
new file mode 100644
index 000000000000..8bcf7757c728
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Ethernet PCS and Serdes
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
+  the various Serdes port supporting different Media Independent Interface
+  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
+
+properties:
+  compatible:
+    enum:
+      - airoha,an7581-pcs-eth
+      - airoha,an7581-pcs-pon
+
+  reg:
+    items:
+      - description: XFI MAC reg
+      - description: HSGMII AN reg
+      - description: HSGMII PCS reg
+      - description: MULTI SGMII reg
+      - description: USXGMII reg
+      - description: HSGMII rate adaption reg
+      - description: XFI Analog register
+      - description: XFI PMA (Physical Medium Attachment) register
+
+  reg-names:
+    items:
+      - const: xfi_mac
+      - const: hsgmii_an
+      - const: hsgmii_pcs
+      - const: multi_sgmii
+      - const: usxgmii
+      - const: hsgmii_rate_adp
+      - const: xfi_ana
+      - const: xfi_pma
+
+  resets:
+    items:
+      - description: MAC reset
+      - description: PHY reset
+
+  reset-names:
+    items:
+      - const: mac
+      - const: phy
+
+  "#pcs-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+  - "#pcs-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/airoha,en7581-reset.h>
+
+    pcs@1fa08000 {
+        compatible = "airoha,an7581-pcs-pon";
+        reg = <0x1fa08000 0x1000>,
+              <0x1fa80000 0x60>,
+              <0x1fa80a00 0x164>,
+              <0x1fa84000 0x450>,
+              <0x1fa85900 0x338>,
+              <0x1fa86000 0x300>,
+              <0x1fa8a000 0x1000>,
+              <0x1fa8b000 0x1000>;
+        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+                    "multi_sgmii", "usxgmii",
+                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+        resets = <&scuclk EN7581_XPON_MAC_RST>,
+                 <&scuclk EN7581_XPON_PHY_RST>;
+        reset-names = "mac", "phy";
+
+        #pcs-cells = <0>;
+    };
+
+    pcs@1fa09000 {
+        compatible = "airoha,an7581-pcs-eth";
+        reg = <0x1fa09000 0x1000>,
+              <0x1fa70000 0x60>,
+              <0x1fa70a00 0x164>,
+              <0x1fa74000 0x450>,
+              <0x1fa75900 0x338>,
+              <0x1fa76000 0x300>,
+              <0x1fa7a000 0x1000>,
+              <0x1fa7b000 0x1000>;
+        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+                    "multi_sgmii", "usxgmii",
+                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+        resets = <&scuclk EN7581_XSI_MAC_RST>,
+                 <&scuclk EN7581_XSI_PHY_RST>;
+        reset-names = "mac", "phy";
+
+        #pcs-cells = <0>;
+    };
-- 
2.48.1


