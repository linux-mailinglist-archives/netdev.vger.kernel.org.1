Return-Path: <netdev+bounces-185630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D6A9B2DE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94771BA054D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D128137E;
	Thu, 24 Apr 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFpvHO1s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98051280A5C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509672; cv=none; b=loB9EkDeaAz0K7fQ0IxxyfpCJUjsdQwxWmMvMwnLEmC4RtPop/lXJPC4fTTCDnmre/ucrp5VVHPE9J5xIcmRHUm5R0ZnZGt1F8TbA10Dp88F1XYeQLlz61Z6CrYfmgBazrOSImD+/QtsmXwIrafpRW0oMMSjhSzjBemIimwMyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509672; c=relaxed/simple;
	bh=B6YBiM56eg0Dt0AGx+vyVZYlQet7Z+4qVVpMh+9K57E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdxajknhMQu3P4yax6NQwFx82BpByANYOaOQHvDU47+D5Ij4ZeuHE0qbyH9r4dWXS2ZgVLhh8sagCTQrBEBHac9Qx7GkwBvButoC0bQ93QAcU6AS4f+FfWyArjmYUKhYSsUvnu1dzdQfEfDASSzvgORr63bQCY6hbxkrHrUrrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFpvHO1s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0fIsOje45OUb2OvocagFYlUiuVKp10dIdSTH0OhtnQ=;
	b=RFpvHO1sWQ+BT7be6QgMkChu8J95izlu20W9P9/XFdt2FlE31ZTll5xAFTankaD5nDrg/y
	z4AX16qU8kWvbWIX3naMeXxigIxQwSqITcc/rNd3l7HmBUzXYIU2mLdDZ7k0tDnZbacHSN
	IWUj1rv24MLtoJFv6YUMm8odkxDjTUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-J2V5N355PLe5vXLnabRM1g-1; Thu,
 24 Apr 2025 11:47:43 -0400
X-MC-Unique: J2V5N355PLe5vXLnabRM1g-1
X-Mimecast-MFC-AGG-ID: J2V5N355PLe5vXLnabRM1g_1745509659
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 925F31800374;
	Thu, 24 Apr 2025 15:47:39 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5DEE19560A3;
	Thu, 24 Apr 2025 15:47:34 +0000 (UTC)
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
Subject: [PATCH net-next v4 2/8] dt-bindings: dpll: Add support for Microchip Azurite chip family
Date: Thu, 24 Apr 2025 17:47:16 +0200
Message-ID: <20250424154722.534284-3-ivecera@redhat.com>
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add DT bindings for Microchip Azurite DPLL chip family. These chips
provide up to 5 independent DPLL channels, 10 differential or
single-ended inputs and 10 differential or 20 single-ended outputs.
They can be connected via I2C or SPI busses.

Check:
$ make dt_binding_check DT_SCHEMA_FILES=/dpll/
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/cera/devel/kernel/linux-2.6/Documentation/devicetree/bindings/net/snps,dwmac.yaml: mac-mode: missing type definition
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  DTC [C] Documentation/devicetree/bindings/dpll/dpll-pin.example.dtb
  DTEX    Documentation/devicetree/bindings/dpll/microchip,zl30731.example.dts
  DTC [C] Documentation/devicetree/bindings/dpll/microchip,zl30731.example.dtb
  DTC [C] Documentation/devicetree/bindings/dpll/dpll-device.example.dtb

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3->v4:
* fixed $Id
* dpll-pin type property renamed to connection type
v1->v3:
* single file for both i2c & spi
* 5 compatibles for all supported chips from the family
---
 .../bindings/dpll/microchip,zl30731.yaml      | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
new file mode 100644
index 0000000000000..17747f754b845
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/microchip,zl30731.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Azurite DPLL device
+
+maintainers:
+  - Ivan Vecera <ivecera@redhat.com>
+
+description:
+  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices that
+  provides up to 5 independent DPLL channels, up to 10 differential or
+  single-ended inputs and 10 differential or 20 single-ended outputs.
+  These devices support both I2C and SPI interfaces.
+
+properties:
+  compatible:
+    enum:
+      - microchip,zl30731
+      - microchip,zl30732
+      - microchip,zl30733
+      - microchip,zl30734
+      - microchip,zl30735
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dpll@70 {
+        compatible = "microchip,zl30732";
+        reg = <0x70>;
+        dpll-types = "pps", "eec";
+
+        input-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@0 { /* REF0P */
+            reg = <0>;
+            connection-type = "ext";
+            label = "Input 0";
+            supported-frequencies-hz = /bits/ 64 <1 1000>;
+          };
+        };
+
+        output-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@3 { /* OUT1N */
+            reg = <3>;
+            connection-type = "gnss";
+            esync-control;
+            label = "Output 1";
+            supported-frequencies-hz = /bits/ 64 <1 10000>;
+          };
+        };
+      };
+    };
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dpll@70 {
+        compatible = "microchip,zl30731";
+        reg = <0x70>;
+        spi-max-frequency = <12500000>;
+
+        dpll-types = "pps";
+
+        input-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@0 { /* REF0P */
+            reg = <0>;
+            connection-type = "ext";
+            label = "Input 0";
+            supported-frequencies-hz = /bits/ 64 <1 1000>;
+          };
+        };
+
+        output-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@3 { /* OUT1N */
+            reg = <3>;
+            connection-type = "gnss";
+            esync-control;
+            label = "Output 1";
+            supported-frequencies-hz = /bits/ 64 <1 10000>;
+          };
+        };
+      };
+    };
+...
-- 
2.49.0


