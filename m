Return-Path: <netdev+bounces-180798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA491A828AA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B93B95FB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F57266B56;
	Wed,  9 Apr 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTX3oRsM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEA2676CF
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209797; cv=none; b=YsGGQY9L7ryo+te+Y98UVwbDAwjGayn2FkIWva3APMU/DEa/UKQHCVTlQNyvknhFuEF2w1V+j4unnjuRUIY3+zJO1Bs4PqRpwjzprY0cqY5QQBSPBuxoBg/byoOkTBD88NYW+QsFLewYnYaYy70duaJDQiIgDzbWAYMfKiSx/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209797; c=relaxed/simple;
	bh=fLnaV7zXD2IjW2nx2g41NhprpGYlyL4IchAJ6441HmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgSaL2zBk8pMZ+nBB+QEJY0jznFF8hvwGsIPXHF/A3j47y+V6NGs44JFvW5Hn17PJ8eHlGq614nQC15/6jrqUEMY9nORnsp898i8isVjwF/ytXoKMOvcQj+cdYRTg49nVgDxgcsy9HxX1/RJz3U2wUI11fXFkorKIkPV+4lresM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTX3oRsM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JDlW8tt6yVi6KMPRNCNHobfAgfgzth8hI0bFx8/cus=;
	b=aTX3oRsMmj/lhu5HQXRCw4SFOkxkd7VabCBJWFghRFAORF2m7O9Rj2o1dvwKpaOIFTw0hU
	9Hu2SCAqmdmF69ktlz0iKg0TfrmktMcGVLZ+FWmczoVPWLL95qOG+S5YJuiIDsUB/vcmQ8
	lHR5PlBncqazyqJakMgnCPNe5+EoAVM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-qW7P4HNBP2iWMRsNuQZvuw-1; Wed,
 09 Apr 2025 10:43:09 -0400
X-MC-Unique: qW7P4HNBP2iWMRsNuQZvuw-1
X-Mimecast-MFC-AGG-ID: qW7P4HNBP2iWMRsNuQZvuw_1744209787
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED4D19560BD;
	Wed,  9 Apr 2025 14:43:07 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96EEC1801747;
	Wed,  9 Apr 2025 14:43:02 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip Azurite chip family
Date: Wed,  9 Apr 2025 16:42:38 +0200
Message-ID: <20250409144250.206590-3-ivecera@redhat.com>
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add DT bindings for Microchip Azurite DPLL chip family. These chips
provides 2 independent DPLL channels, up to 10 differential or
single-ended inputs and up to 20 differential or 20 single-ended outputs.
It can be connected via I2C or SPI busses.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../bindings/dpll/microchip,zl3073x-i2c.yaml  | 74 ++++++++++++++++++
 .../bindings/dpll/microchip,zl3073x-spi.yaml  | 77 +++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
new file mode 100644
index 0000000000000..d9280988f9eb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/microchip,zl3073x-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C-attached Microchip Azurite DPLL device
+
+maintainers:
+  - Ivan Vecera <ivecera@redhat.com>
+
+description:
+  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices that
+  provides 2 independent DPLL channels, up to 10 differential or
+  single-ended inputs and up to 20 differential or 20 single-ended outputs.
+  It can be connected via multiple busses, one of them being I2C.
+
+properties:
+  compatible:
+    enum:
+      - microchip,zl3073x-i2c
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/dpll/dpll-device.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dpll@70 {
+        compatible = "microchip,zl3073x-i2c";
+        reg = <0x70>;
+        #address-cells = <0>;
+        #size-cells = <0>;
+        dpll-types = "pps", "eec";
+
+        input-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@0 { /* REF0P */
+            reg = <0>;
+            label = "Input 0";
+            supported-frequencies = /bits/ 64 <1 1000>;
+            type = "ext";
+          };
+        };
+
+        output-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@3 { /* OUT1N */
+            reg = <3>;
+            esync-control;
+            label = "Output 1";
+            supported-frequencies = /bits/ 64 <1 10000>;
+            type = "gnss";
+          };
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
new file mode 100644
index 0000000000000..7bd6e5099e1ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/microchip,zl3073x-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-attached Microchip Azurite DPLL device
+
+maintainers:
+  - Ivan Vecera <ivecera@redhat.com>
+
+description:
+  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices that
+  provides 2 independent DPLL channels, up to 10 differential or
+  single-ended inputs and up to 20 differential or 20 single-ended outputs.
+  It can be connected via multiple busses, one of them being I2C.
+
+properties:
+  compatible:
+    enum:
+      - microchip,zl3073x-spi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/dpll/dpll-device.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dpll@70 {
+        compatible = "microchip,zl3073x-spi";
+        reg = <0x70>;
+        #address-cells = <0>;
+        #size-cells = <0>;
+        spi-max-frequency = <12500000>;
+
+        dpll-types = "pps", "eec";
+
+        input-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@0 { /* REF0P */
+            reg = <0>;
+            label = "Input 0";
+            supported-frequencies = /bits/ 64 <1 1000>;
+            type = "ext";
+          };
+        };
+
+        output-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@3 { /* OUT1N */
+            reg = <3>;
+            esync-control;
+            label = "Output 1";
+            supported-frequencies = /bits/ 64 <1 10000>;
+            type = "gnss";
+          };
+        };
+      };
+    };
+...
-- 
2.48.1


