Return-Path: <netdev+bounces-179492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92FA7D10A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD244188E94F
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFF22424E;
	Sun,  6 Apr 2025 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuPQIdGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC90221704;
	Sun,  6 Apr 2025 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977719; cv=none; b=QcoW1bl4oe81JBA8hwmoiueCUmTQYyGsJL20iihBHXNTXoH+5mNFytV3JB56v23u5o4a9zybXTO14wHdlTJJZI+NI8yDi+z95oWEBPzxmgTWuR3EbKgHWZG92jycJRj46wsOy/q19YIWv1hmlyeh6J9NE0VaviZFPHay4aOzU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977719; c=relaxed/simple;
	bh=9kaMiYXQvyNED200/XpcNR4N6R3qrDBJya3ZAUhzEXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtEOtWLVREIXWp9IgZEE5OnNsKHvNc7htYSrQtv0YixnCV9nl/y9tSeCsNui+oCsujCPbz+QtffxkZXkLTffcR83VjN9GtFwczMVvdQkPo/b3/y8oi3IkYxs4FzsUwcYVxDbc8j8QTcDpnKHP1ckwJ5BfL1GzTQTiKo5OdC1F5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuPQIdGG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so24973215e9.1;
        Sun, 06 Apr 2025 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977714; x=1744582514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGytfW8G6gwhO327U2YL1/GYm/l6ThozJnofzfzJ7Fs=;
        b=SuPQIdGGXoGFBKxwPaJAuHwyBct5gw7SZrfRh0+xUXC5nhjfDwLyhybnu2eYnzTJB7
         rlHwrYC5G/8WB24nT2tpBIIwRCN8etn1aRj1v3vcHyf65chrauOmBAiKpAy9pd/3Jsik
         SzWniHn2/mp62NcFOW4sB7gu1FdomaM7wOvsq+m3lDZQ9rbMEVKd+bneqt3AGygQ5dLT
         YPCuvkxmcohaHMDpof8haSkyOYMJVAeo5lt91t7Y9Zdvrdc/IBc2wilKaSDMuXysUz52
         3dxTf5BlCo7bLzgNzZ/7pQFWdGbrEb29/bDZvEQsEkVCyXY54BrYVGAxx97NpTqU6VsP
         rkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977714; x=1744582514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGytfW8G6gwhO327U2YL1/GYm/l6ThozJnofzfzJ7Fs=;
        b=CH5Jo29wuFDS0axrhVxY4u4jI17EkEg8Zhrs3EeyH5J1WGOJLYh/8Lvj87R4KXtESX
         zSger1s99D6N5EyDCEB5tgykPHaRNCT3WfRuEnNEIyisB73MRRg/3x16ms82dektODAl
         W/ivWrCZO/9l2jGSRg/a9lyrqpPg0HAWnUJ+e1d4El9LfmDGJqouXsZvtp2VIwSMAbw8
         5HwnBMWaRSFXVMlxz0lBP7wxFslr/hD2xpaYrrsi0Whjntx9bMsOUX+GJNjaEeiVuPSG
         0BbnF2rjj+15CvuWqnolMkE/0l7zh9Ua0ggqHSpWvspZGytaxpZh4P5chvx0hEtVrdKX
         Ge2A==
X-Forwarded-Encrypted: i=1; AJvYcCW9b6WFP66DDJ6FueYGUgtjXtOO5d7ZKkiyyPnAfexcgjxtq7ZkuILdze5fZ6UOW9dXBniSgfHu@vger.kernel.org, AJvYcCWmilMYNMXg+VhtZNQUP4ki53pzesRBgvaOgSC/3hHnOQJ/2EmmpXPlpet/3nOpLD5Vs9Jn5Dt3CL5bIuCM@vger.kernel.org, AJvYcCXVR7aDmT9wvoWdGghf6ASGU5t/OpiY0yERu3NIEdowvBKZgmSp/jbYfSd1/IvmhI/0Ha09FWZ4S/gH@vger.kernel.org
X-Gm-Message-State: AOJu0YxHlSZiRKUJ6eLxSk1W/OfOMH8DDF8S5HtsEYUOCE5vZlLapM2y
	7oN6UBL2Z6m9GKF+eTxn3+PxwFkLuf0Lx4p9lwMfdNJCvWpCxzNr
X-Gm-Gg: ASbGnct7A+Eo1VDv/9N7Q998saaNQjpWeFIaDfkbCCVFTBfu990GiiViglmj1wT7z82
	Nt5b8QCZlVAG+6uExI9/UWVTo/VB8B+nJb4lQGkpdCWRyQW52pTqYTzD40YhwkjAOQ9YXuWeRaP
	ItcgxXCBqAdGlCo/947x1m2oZFHvf0JXqk9nLpJqT+KWiXNUXt3IKxW8gFkNz6CjLUMktCtvpDB
	/KnWU39k0ErTKUI2rLCXvPgFOyqTZ9quIEmnofE+f6bD9u3dSOcRwH0XaLOkfIaozsrh+y/qXSA
	GhAQyHTxGB9Wd6XdckUun/qWqZM04bYgAC+Ejf7hLEnvT6AJwmd4CokkGn28kiU/7RbXBPh4vhs
	41Rk2b0smVWIBmw==
X-Google-Smtp-Source: AGHT+IHf3hR2LUO2pSoHA5YRJXlajHrhcin+0UjxBL/5XqhdoqEDVFhBZWmKSGSo0LJNPC3tk0VNsQ==
X-Received: by 2002:a05:600c:4f4f:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43ee076d88cmr58173825e9.26.1743977714232;
        Sun, 06 Apr 2025 15:15:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:13 -0700 (PDT)
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
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 10/11] dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
Date: Mon,  7 Apr 2025 00:14:03 +0200
Message-ID: <20250406221423.9723-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
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
(for Rob, I didn't ignore the comments, just want to
 make sure the driver side is done, please ignore)

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


