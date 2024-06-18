Return-Path: <netdev+bounces-104396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF390C66B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1843728358C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B211849F2;
	Tue, 18 Jun 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrYQVO54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08074424;
	Tue, 18 Jun 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696990; cv=none; b=SnDK3ZsJ+hNYDVu/zweOLbfvPYg5uyLA/fcqYHsCX4JwD/gBQjOj7NrTcnuA8IhEOUE66IOZMyZrytl1/b97XVa3wlC38m8OguRtf1lX9QXIvb5eA7H/MltPim4edc0qVK9qJ2ndYXCSdKhfiC12nCi7H4tvGyaJZ+S7t+Qr46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696990; c=relaxed/simple;
	bh=ECRzAkevUt8lZBCQ70LHJ/d9Bgo/rhLCsgNc1rHxDdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1t1Lv2ABaNQUTroFXum+W+MYzmb/Kzao2lM65OqtPFUb2fuAfvc7qV2M2yRFoDMGQ/p7CcB99oFG4Ybj2+ae73CF5OfMKsUhDNoIE1YvtOz0Et9ZtEh0ew6dM8X8qH7+DptG0bkzjQPFbWTrYUExh1trT8Lgxwb37zG03axL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrYQVO54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9148BC3277B;
	Tue, 18 Jun 2024 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718696990;
	bh=ECRzAkevUt8lZBCQ70LHJ/d9Bgo/rhLCsgNc1rHxDdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrYQVO54sr+PFcjfTEMmfFkgTvyvR0EG7ZqFg+si5RjpwD0luH5NgxgjEs69r6uLm
	 pOlE2w+RsaPUAQ0Jv1j3f2ynswo44hsE8SY4RiV3UQ12EeOHK1A7XnqNufOX6kSz0b
	 DV1qXYKRogk2lHGJFKP3IqtAcxeO8+oHKs7I2eLvwe6OGFiM1TpZgNA9oZTL4y2T3K
	 qWMsa1SebqkcCN+SlZptjtzGXmT6BMEjDJpA39UAm41an3QeVtJdkAZMWKFAt/48K9
	 a66TDf9lC0Fnri2okEB2nRGC+lRXurS8qM3ngJa9R3sGbFjA/fQkc2ZLupOi7K5QIS
	 QfE21vunzvc2w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	linux-clk@vger.kernel.org,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch
Subject: [PATCH v2 net-next 1/2] dt-bindings: net: airoha: Add EN7581 ethernet controller
Date: Tue, 18 Jun 2024 09:49:02 +0200
Message-ID: <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718696209.git.lorenzo@kernel.org>
References: <cover.1718696209.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device-tree binding documentation for Airoha EN7581 ethernet
mac controller.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on the following one not applied yet on clk tree:
dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
https://patchwork.kernel.org/project/linux-clk/patch/ac557b6f4029cb3428d4c0ed1582d0c602481fb6.1718282056.git.lorenzo@kernel.org/
---
 .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581.yaml b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
new file mode 100644
index 000000000000..09e7b5eed3ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en7581.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Frame Engine Ethernet controller
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The frame engine ethernet controller can be found on Airoha SoCs.
+  These SoCs have dual GMAC ports.
+
+properties:
+  compatible:
+    enum:
+      - airoha,en7581-eth
+
+  reg:
+    items:
+      - description: Frame engine base address
+      - description: QDMA0 base address
+      - description: QDMA1 base address
+
+  reg-names:
+    items:
+      - const: fe
+      - const: qdma0
+      - const: qdma1
+
+  interrupts:
+    maxItems: 10
+
+  resets:
+    maxItems: 7
+
+  reset-names:
+    items:
+      - const: fe
+      - const: pdma
+      - const: qdma
+      - const: xsi-mac
+      - const: hsi0-mac
+      - const: hsi1-mac
+      - const: hsi-mac
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+    #include <dt-bindings/reset/airoha,en7581-reset.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      eth0: ethernet@1fb50000 {
+        compatible = "airoha,en7581-eth";
+        reg = <0 0x1fb50000 0 0x2600>,
+              <0 0x1fb54000 0 0x2000>,
+              <0 0x1fb56000 0 0x2000>;
+        reg-names = "fe", "qdma0", "qdma1";
+
+        resets = <&scuclk EN7581_FE_RST>,
+                 <&scuclk EN7581_FE_PDMA_RST>,
+                 <&scuclk EN7581_FE_QDMA_RST>,
+                 <&scuclk EN7581_XSI_MAC_RST>,
+                 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
+                 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
+                 <&scuclk EN7581_HSI_MAC_RST>;
+        reset-names = "fe", "pdma", "qdma", "xsi-mac",
+                      "hsi0-mac", "hsi1-mac", "hsi-mac";
+
+        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.45.1


