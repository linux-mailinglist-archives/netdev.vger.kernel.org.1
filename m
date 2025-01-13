Return-Path: <netdev+bounces-157588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5FA0AEF9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FC13A6925
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C66231A5A;
	Mon, 13 Jan 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFFTEFE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F61231A50;
	Mon, 13 Jan 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747781; cv=none; b=W3lVPvEsoHuM4PbTf5qgalazzFJ/SG4rydWMhCveJOuJF++dIBk0J0NnNMEl06XkIySSdapg0xG2YwRDmoGHM0PJTRE6D6ZAFNZXExLXp85NNELf0ns/ecfz1lT4pFvCRE0vec21clJCop/q0x0XIr/Y79u5Yjlw+6oPLTiwex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747781; c=relaxed/simple;
	bh=1eDAhLg/uB8BqSxz1fnINyvH5uJswvTw3kizEquhxCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWxWGo5KLEqKbHrrFsxNKygrd6zWNwRfe3ajiEJZIPj9X299s/NYBHNoPJCrTv9G/KTvRLOgo2tz6Yr2lCSYHPlTJTLVaZI3rFrrB2tI+IaOLfoxOP/bEWYyHptijkStBGHqH1O+LQ9nupwitAtajDAO1fQ1lEFVd7GPXVXRH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFFTEFE4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so6585390a91.3;
        Sun, 12 Jan 2025 21:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736747778; x=1737352578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ruy9T8+YCMNFZIu2fnBUkNd/IXv0Vs9qPj53hJ7nck=;
        b=lFFTEFE4QXnXmHrdNNGgkGVr+e/qQePdR2aM6sCNoASxUP7ZSvCyuiMoYAbpc4nUrQ
         325FKPZBQKdOP6G4awkd98JssNkvzYrB3KeINrju4rV62yK1bsGA2BYODGB4xzyMtSXx
         6qgXbiBIUdICJ7h5HUwoVEsVVXgQF29mS46DDrettKQY9bbPxcNVYleDOjQSMC+sdHPo
         tYtNIrQG2X7ubzseZSlb/woDgs9o6U8OOjbmFSuZXpBJPaMHacXunk0RY20Fobqs3b+7
         I/amG7TEc2n2F+a81QdYDcHE5K/Pa2Pb30pcWYcQGPxuG2eXbojpjWySI5u8EDlbkXle
         p4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736747778; x=1737352578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ruy9T8+YCMNFZIu2fnBUkNd/IXv0Vs9qPj53hJ7nck=;
        b=iEoPSzZqAfZg6bj+U0DOPVDEPD13BnX7SYMtdBL92OJOqvw051zVfkFIRkvpTSX+Iq
         r5/GX180u2RgWZogK7tQybpf9q5jfLTjRL+4GVfYAxWgE9RxUFuWfZ9Bcqvj6GAcNBYM
         uv1eYohT7hKtf4XLKhj8dBKxDQH/ewPGXoVz7pY5IrIXr0LmP2gcSjV4T004FrQTZ+Ee
         LFO7+aByUQ4LUunG0mN2dtWkPgqlMi6IP/5ANznfCGCasnUgVEVyuc8VU/Urm0ash4I1
         S90motDlG7VfwjE1LqlchAy+dO4GimXuGgfCg1UKVp0y+62owv4dnwgs6FhGHkjBhCeb
         l3QA==
X-Forwarded-Encrypted: i=1; AJvYcCV20AkrR8/z3myp5xitskV6LbVgV5PWfPgxHYsfPh59haO61IjX/O3CxlZgh2oD9wx6j8KTx4vi@vger.kernel.org, AJvYcCX2JykBxY0xxbtQXyr+460GB4+U3QKJYQljdjyfZ02huuDLVI5zxzLkDmYmjVFRiUf3mJ0FkrutmiBJ@vger.kernel.org, AJvYcCXHp8gTLOJwpmv8uHDd5W7gDkyYCbAFGVFaIxbXOzgnW3eKpWK9YNx3SXVXpxSVxC0pN+fS2IcLZdNxxLsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGESrDS7gOuH+JApUAXP1zDFQalAI6Dn52Z4nSjFfaKwuNzO5
	iA0HI2kRDU0etJxOoWeSx0YrBAj+F0gDhVkIxhXe54TMQq7k2ZnO
X-Gm-Gg: ASbGncvq91iD/3ytCPdNRdTdmapuWyv/KhtR3KZAF/UIvA8qwgH959t+uYVenAlEO9k
	g56ozhPz+VWyVy/jPUfUvE9+kM2F7U9QoGk63FKJnBhcFQQVJcypNiz1kbQTTjWyyU+cwHJLqDi
	EA6eKx3K52TSGN0QyCXEkBX9pPUKDEaioIAKywr19tg4SOOFcZKVGF//enVky2w7icCpgBr5XYT
	RObs7UE3cgq89LmekailVNqI3HJtgVJjs1enEiy52MOmKm3vH3FbW96aFhSP/hluf4QNBxRAv37
	Zvelyqb1MygEaIqwqzHT2A==
X-Google-Smtp-Source: AGHT+IELLG1qqRQ+iIq+SIppUMZASouWezROTI1mRuvbXLFmarI2XwZnJBZzTNIbEvSNR3O+6hTwOA==
X-Received: by 2002:a17:90b:2dc6:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2f548e9f9ecmr26288303a91.5.1736747777955;
        Sun, 12 Jan 2025 21:56:17 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55942188csm7768806a91.23.2025.01.12.21.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 21:56:17 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net-next v7 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Mon, 13 Jan 2025 13:54:32 +0800
Message-Id: <20250113055434.3377508-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113055434.3377508-1-a0987203069@gmail.com>
References: <20250113055434.3377508-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..c3f2ad423cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton DWMAC glue layer controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.73a).
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,ma35d1-dwmac
+
+  reg:
+    maxItems: 1
+    description:
+      Register range should be one of the GMAC interface.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: MAC clock
+      - description: PTP clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to access syscon registers.
+          - description: GMAC interface ID.
+            enum:
+              - 0
+              - 1
+    description:
+      A phandle to the syscon with one argument that configures system registers
+      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  phy-mode:
+    enum:
+      - rmii
+      - rgmii
+      - rgmii-id
+      - rgmii-txid
+      - rgmii-rxid
+
+  tx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII TX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+  rx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII RX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+required:
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+    ethernet@40120000 {
+        compatible = "nuvoton,ma35d1-dwmac";
+        reg = <0x40120000 0x10000>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 0>;
+        resets = <&sys MA35D1_RESET_GMAC0>;
+        reset-names = "stmmaceth";
+
+        phy-mode = "rgmii-id";
+        phy-handle = <&eth_phy0>;
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 91e75eb3f329..c43dcae74495 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -67,6 +67,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,ma35d1-dwmac
         - nxp,s32g2-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
-- 
2.34.1


