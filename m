Return-Path: <netdev+bounces-186061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BFA9CF2F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BB57B354F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E71F3D45;
	Fri, 25 Apr 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcldm8HJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79C1F1300
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601001; cv=none; b=GUTlFss2lmh3sRNtcQyNtPfNt5guAYQswdZkO/ARh98dSANTAAu9nqG9IVTrfnUjjWKkEWq43xHNCg+kc0L8/OtDrWQjen1w+7DS5X8f53aPRff/Hv2Aas8o4NULNJyU54qB/6s/9Rmcdb5OiNBf+uQ6kqXjFiLBpy19QuBw/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601001; c=relaxed/simple;
	bh=DciTJaRm7DGg3I9gZE4J3T39Ysb3C1JromC0yRlbfvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dae8FHomvfqTh0go/eWiu2p3OT0CicmNhenjLLTEJdwTPx6Ef1J+uq4FZi4AawP8SPD5TRNpaL8r2ZGNVl0nMBGWCf7h4RZdUNY5K7MCv8PpYbprJGyvssgHpRW5LjD83w6zU1F/eSa9KWZTPj8QPAgBkfLqIDm6KZEV5lagLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pcldm8HJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745600998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a098JNBt01UrV9dk7g52h5zH5zs0OxsxWoIdz9lDtIM=;
	b=Pcldm8HJ3IFAmvtWQq+iUnmKWJKgUzUIFY/cl0wwnJc9YmYGmzdBRCgTYmkv1rebA7dMa4
	aqW9XJkX2hsDXaU45qM5nOnrXyv21Xa+5Yp29ZpvT8+K+y5AoYiUBoT+4k60SwRJI3JfVT
	weKw3HbPfTwLOHog/AEgrc5pOyUYrx4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-QnfWmOHTOEqZBZHBlRfjPg-1; Fri,
 25 Apr 2025 13:09:55 -0400
X-MC-Unique: QnfWmOHTOEqZBZHBlRfjPg-1
X-Mimecast-MFC-AGG-ID: QnfWmOHTOEqZBZHBlRfjPg_1745600993
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDF081800ECA;
	Fri, 25 Apr 2025 17:09:52 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CFF71800D9F;
	Fri, 25 Apr 2025 17:09:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Subject: [PATCH net-next v5 2/8] dt-bindings: dpll: Add support for Microchip Azurite chip family
Date: Fri, 25 Apr 2025 19:09:29 +0200
Message-ID: <20250425170935.740102-3-ivecera@redhat.com>
In-Reply-To: <20250425170935.740102-1-ivecera@redhat.com>
References: <20250425170935.740102-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add DT bindings for Microchip Azurite DPLL chip family. These chips
provide up to 5 independent DPLL channels, 10 differential or
single-ended inputs and 10 differential or 20 single-ended outputs.
They can be connected via I2C or SPI busses.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v4->v5:
* removed compilation output from the description
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


