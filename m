Return-Path: <netdev+bounces-230869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A86BF0C0E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772E4189F6E4
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F712FBDF9;
	Mon, 20 Oct 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBLBrUou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299E25179A
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958706; cv=none; b=OzgySuks0rE1uawoRX65fCOZHyTVsMUXdTGrLXl3S8xvAlAGHGZG0biwJUDdH41SXcgdKKzrobrquor5kz5NvjsdAqOqVJnu/ZOJQBSAOMzNtDgIQ19IWqtfGADDFAAgwb6d7CL6r7BZQYY+xph5FpQYSPG3A62lnJpKbfNXajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958706; c=relaxed/simple;
	bh=crtsan/85sYEtw+IXIdIx1+xhGDC/R5MM3pBFiVg8CU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To9q+BoTMKB88K4hbr4dVtFlSUfcrxsLdexD9fQWBTiFOMlNFFWxkj6RmtDjYjS945AeHdg3b/oTZIHziJ255Godk4+v3z5Dmo45DIjtiNx2TrjTCRP06QYrd2KxjTK5f9rvQ93jUan+tiiGfgbD2L+U+MAh44kkQJmTuyrkjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBLBrUou; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426ff694c1fso3327604f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958701; x=1761563501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET/WdgCX7blN4pSkYOyw5+NcHdAYpJFzGJ0hMhYQ6fk=;
        b=eBLBrUou5ESVx0C5jUOarV6hMOLQNpstgEby4j08LQkas9V6rSK3sAC8rFAU56Czco
         oLFAl01/GO09rqu2eyXkundb6kGDTbFXGC4Z3Pevylx8ONoDijxtVvoXnCufXoNRnpJh
         xlYDZo6hkOIrHvrkdVM/PLtGer8nNJoSmGOoZVtLSwm3xoCbffywppQtsre8Eizb+MF1
         Ub1qoxaT9dX4WW2F7abx9ZG0sJsYaRQOkvCC7v+SDMN1V58OpzapZwm6EoQd+rk/POS4
         qdmC1Tu+xOXPOKXs75dqKBJUbHCAHLqykd2D4xT2RKmEKK3gZCOJ8SCyknKcsPuiv3p5
         ZcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958701; x=1761563501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ET/WdgCX7blN4pSkYOyw5+NcHdAYpJFzGJ0hMhYQ6fk=;
        b=GkotKYnA8IPijuH+WsQ4mhPbT3boyZHyYHXG8IqrHP3N7qCGymJZOUIRgBcC+1ojPn
         8rMpsg3BuceDlefXRGmJpPJLPDEa6FaeXNdd12IBkNDsNuZZoAJvg/vGvPbyJRKriuBk
         d5qPZ9ymuA5X05NmNACPQBef8Cb9AUfUGimLor1w8QRPJaLiSH0Er+0n4Te+iofKPvt8
         1KIRs3Iw8n8VwZRhptH2vtvn37qlTh5g/QpfKLTrygw1RW5dekWnbn0qLgx8du3G6pgy
         SrQ8N8igoAx4ecSGJwzF+1yPe9ZvfhGyYBem5QZwa4S5zqPAZyMJCHd9f3X1DaVwNeYy
         7iZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXBZibyVs50rS0qI4Nv/LNtxAF0g59A3rWTQZyh6GkyhTLYQ1MSzOH4ANScUA4R9tnVxq8nm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7EbxDQVWlLHuquluHaZP4BpvaJZG8nsIH27CF/UNR3omB7WI
	RLib9IJmuvheTZx48krgWyzD2qmAay6hVz8s6PelrX+AJV9lwQL9gWcb
X-Gm-Gg: ASbGncsyV5qTPyrF+tR5ZKL+ABtUlbOk6VKMYzHmZinpkMCT357AN25YmeXCCFNRPhh
	14vhfSb19VtgTw8xy290L+EJ/NIgJ/b/LzWFyrON/Cwz0dU2x+Yh+UEdDVHrAhKGIQsT/d/RtDd
	ug2KplMuKplNCnYGtuWOunnHsC+GPAOFtiTClefkO2IWTLNP72V/kk0ZXLpmcWSnpPm5md/iuxy
	HXXmLAh3BV+BKaxKms+6ObR18ExddjV9AVXMMksnG+Tv72DizmdBClG4vPNj/lpj/crr3DNhA06
	bROMJ2B+1A5TOZXuvwsUeV9//9Vwq5MaIT4hsbzx91rk/t3rSmxSinrmyoUkgQBvLwNaxgBvfMP
	pfRRd7g5oLPgjwlLD9kL7ZDknHE23hc0doTyXLcJVd1Ajhs4k2NsMgBTbECq1sLJFUg1HNW42ed
	v06wv9KLZ6rn+sFkkJ1UOHQyDldliIagSc1fDP7Tchw2o=
X-Google-Smtp-Source: AGHT+IGsJGvpzKiDD8jBDErgrAbR7/9scZteiyrQ3aNod93FKhU/9cKG3+ipZMkoOjySRQFgqGSHww==
X-Received: by 2002:a05:6000:2389:b0:427:151:3db6 with SMTP id ffacd0b85a97d-42704d8e226mr8837205f8f.24.1760958701102;
        Mon, 20 Oct 2025 04:11:41 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 2/5] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Mon, 20 Oct 2025 13:11:06 +0200
Message-ID: <20251020111121.31779-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
binding.

Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
PBUS csr property to permit the correct functionality of the PCIe
controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/mediatek-pcie.yaml           | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index fca6cb20d18b..0b8c78ec4f91 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - airoha,an7583-pcie
           - mediatek,mt2712-pcie
           - mediatek,mt7622-pcie
           - mediatek,mt7629-pcie
@@ -40,6 +41,12 @@ properties:
       - enum: [ obff_ck0, obff_ck1 ]
       - enum: [ pipe_ck0, pipe_ck1 ]
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: pcie-rst1
+
   interrupts:
     maxItems: 1
 
@@ -55,6 +62,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to pbus-csr syscon
+          - description: offset of pbus-csr base address register
+          - description: offset of pbus-csr base address mask register
+    description:
+      Phandle with two arguments to the syscon node used to detect if
+      a given address is accessible on PCIe controller.
+
   '#interrupt-cells':
     const: 1
 
@@ -90,6 +108,33 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie
+    then:
+      properties:
+        reg-names:
+          const: port1
+
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: sys_ck1
+
+        phy-names:
+          const: pcie-phy1
+
+        power-domain: false
+
+      required:
+        - resets
+        - reset-names
+        - phys
+        - phy-names
+        - mediatek,pbus-csr
+
   - if:
       properties:
         compatible:
@@ -104,8 +149,14 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        reset: false
+
+        reset-names: false
+
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -119,10 +170,16 @@ allOf:
         clocks:
           minItems: 6
 
+        reset: false
+
+        reset-names: false
+
         phys: false
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -135,6 +192,12 @@ allOf:
         clocks:
           minItems: 6
 
+        reset: false
+
+        reset-names: false
+
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -151,12 +214,18 @@ allOf:
         clock-names:
           maxItems: 1
 
+        reset: false
+
+        reset-names: false
+
         phys: false
 
         phy-names: false
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -316,3 +385,54 @@ examples:
             };
         };
     };
+
+  # AN7583
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc_3 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1fa92000 {
+            compatible = "airoha,an7583-pcie";
+            device_type = "pci";
+            linux,pci-domain = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            reg = <0x0 0x1fa92000 0x0 0x1670>;
+            reg-names = "port1";
+
+            clocks = <&scuclk EN7523_CLK_PCIE>;
+            clock-names = "sys_ck1";
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy1";
+
+            ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+            resets = <&scuclk>; /* AN7583_PCIE1_RST */
+            reset-names = "pcie-rst1";
+
+            mediatek,pbus-csr = <&pbus_csr 0x8 0xc>;
+
+            interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie_irq";
+            bus-range = <0x00 0xff>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                            <0 0 0 2 &pcie_intc1 1>,
+                            <0 0 0 3 &pcie_intc1 2>,
+                            <0 0 0 4 &pcie_intc1 3>;
+
+            pcie_intc1_4: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.51.0


