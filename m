Return-Path: <netdev+bounces-175957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C231A680FE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF6F3B47A4
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1A214A60;
	Tue, 18 Mar 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBwu1zLD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF04209689;
	Tue, 18 Mar 2025 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342379; cv=none; b=BeKU1UZvTnGPIfH1KFZ2oxly3/s8nz1sKo0v/9z8fABIMItRU9OtacXN1UtWSZWqmKIva+k8Ssgb/5vY6wIbp9hEVklPhqoZmJoLHw+6NSha3L9vUjQaW7SRv98rzhoudZPyrZ4gqy0Lmmo5wQBtbUtRXTPrslCsDKjrCesX5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342379; c=relaxed/simple;
	bh=jFcXF/4dVf1e7vAXuyL5qekxKu5hoLO5I3j0YrY52CI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od/aXmWpZFOXZY6DA/Pve5zt1jA0wz5u2wnFSt9EkgDrzeTxEHuk9R9C3YYUP8zAnTn8znf2Aa9az9ObdxljzFjfseFp4MbAaZFccazjQcwpKkK1W0pUc+8XEgPLVlDqFhtUSRkzmLVeNZVBZXGXIia/Cutgq96rliYg52tMzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBwu1zLD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3914a5def6bso3373767f8f.1;
        Tue, 18 Mar 2025 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342376; x=1742947176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwoa6YEoLumzQE8cS+ad1dIlqWJKYevB3c6NtJXNM8U=;
        b=GBwu1zLDsh3vk/hwlsKsA7RdcSJaP3/Bs7kKVBkDl9VyUD25g+VXNvgGzxTs4WobgN
         k/Ph6jJlMFMwye0B9zgeUNc4K/5/RC3WOUeT26T8jx57R65xUi/TWllt30Dgky2YTUJC
         P8mQYG3UdnwyjaX3/PbgWCOQduO+FhbAzbCp/5SAR2f0C6RyWMiD/7nxbXLbAIf2PDY5
         kolPQNRHjQiA8wMut4ciQGAGtwmCf19mWdHM8eXme9iXf5rKGRQmpvQrEJMG9vJ6H9W3
         86p3RQYyykLlxrNeQkwvqKgSZCTPAIhtQAOKPtYB5kO72RpSevCxziCz9N6eDtTTIwaB
         +oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342376; x=1742947176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwoa6YEoLumzQE8cS+ad1dIlqWJKYevB3c6NtJXNM8U=;
        b=QVTRoBmEWh2zlxn9IzwPwUKXczjtNDOr1AH1ExSrGpGb9/mS9M/DX2yX5lPwlbEqRn
         nrl3+UfW/OgNN4qIy+YwW7b+npTBe8eTysKmIhD4Z9oEoDboHWJfpdLTgLO0svA6c6FO
         tIYEpugwv9kW48UmeWwalCG6PzPpXYS013p3ZcvIhGpJJPCtoc1XBUiUAyBbR0tDtzQx
         L/4eQJgNBKCCQuNTAMvkxyLbmLpkD/yI740tatcGkOjFjT25nLpWOOGvHgDV8HOM98eY
         VbwU4ePt3VND/e/WIOovHDKqRRRr/gPBdh9zicAs0TirLexb9/cAYFUSG9Mt4hWGHvqF
         eeyg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Fa0uYsx8n/wd+py51KqyyIfzJrrMqcGmB2M9ETVN95W3eHl6UUCPSMfMCc0usqw+nCyf6FDHmkrpI5WD@vger.kernel.org, AJvYcCWKt2OcXkTXzDqI2aeRFvLVAb7JhcHrSJSoTdgcYm/YdwdBmxrBo5TzDBLjWk96rTrbP+oy2EEO@vger.kernel.org, AJvYcCXVHxULPiqJ8zcd5BnPNFwlrkt+uChG8n0u6aviiLiidyDbxTbPAqwjffYt+cimKDmzDP3mGhHRE//l@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0lauueUxg+dShi4lmvRYtf0woTLIO4st2XByWYDDTJsWUjD5
	V6DwLcU9JsQ3NhyxcLcM8Cn9BYgRZPnnNY10JOy85/ZOxhYcEVbq
X-Gm-Gg: ASbGncvrVmu9tlffC9+tk41HvsLnR+AGe9UWJr0l0YenIY1MVXFaf2b7lLFDLLxynUq
	+cbGNPQfiUK2PnfPBw1gSMqwj7xq35sQ5SgbTiamEnjRiA7Xlvtrdm4JYnpQf9RHcFpAFdqT7q0
	4kssaZOifiheswbwgRYP0O/yYSj6vQDA5Pt4G8egO6/5l+oTttzBwPUv8mNj7N8nPz8IDIllwt9
	97To4iInglfvvM+ZFeFwqfIfVKBi9wEgGkRTDN63vLcMOmCajLhHxKCdiW8oH3UlC9nckIqaJ1a
	lfjIMTLr6LykxXldYhbIrCUL6YJKJ/3DwG+VkwK9dxi+7Df+iN/jhHWcqeCkwEZONIq/TYqFwTs
	vmEopn7Phmuwkdw==
X-Google-Smtp-Source: AGHT+IERNl/pUPey+/B30c2nHPSjciwnTH0tROmHtboEq+44mcIocSnX3h3zJgIyWPMByWTyzCy1fA==
X-Received: by 2002:a05:6000:42ca:b0:391:10c5:d1a9 with SMTP id ffacd0b85a97d-399739cb99dmr397745f8f.31.1742342376093;
        Tue, 18 Mar 2025 16:59:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm19713268f8f.39.2025.03.18.16.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:59:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH 6/6] dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
Date: Wed, 19 Mar 2025 00:58:42 +0100
Message-ID: <20250318235850.6411-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318235850.6411-1-ansuelsmth@gmail.com>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
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


