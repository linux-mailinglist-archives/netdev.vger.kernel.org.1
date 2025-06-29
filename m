Return-Path: <netdev+bounces-202267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBBAECFE0
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5733B072F
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB9523ABAE;
	Sun, 29 Jun 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9eCm0jT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05C19B5B1
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751224284; cv=none; b=p71Up1TCkQCCEMFYaoQzXY026Ar45ho8xmhTmXvjkRb6wBZZb5V/893uttU4PbB3pJz0jQZyN4Sa3a7TU4dKhs26KDzQPx4lpm/u3sQuUaItG8rOmV/Y27J1Q5HSVM+GZ3s11NBzGq/7JXVc7e4FWv2i1dcapPAkQTjMBqlblQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751224284; c=relaxed/simple;
	bh=kP7sCxIkgE77aJqMYZ3BvMf06yDuAxed/D+Rs7aRy2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwN9i8S++AB71eC7mNUFi/9YPcTa7bp7Txehdt4naWqYFE7igPYY6eiNxEpcZ95eQQmNUXUO0HgZ4P1IY13E7BmYhI4klnt/ZqYkB8dMbUKm/Wfc07qpyKXlXzOIUYLDCeu4pA6l8lpNbtUzJ4BcNoVMBCG5Z7j0N6Sw0lcw/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9eCm0jT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751224281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCZqqC+G2dbS5TS/FUu98apFIkbaphiOjY1kYdjuiH0=;
	b=M9eCm0jTfF/wMxn8SH9H93ALfRnfzTid4rQ1U0QngvdE5qZproXfxMenZQPR5QG7aXG0w/
	JtSXQL0pR8qJsF+eFJRYlAKj2m0rRugjNk/akXvB7cGw4SHS/P96vTo5vxi39dXC8+9Tz5
	n4FlCYObp1ZR29xXMzbYNFn4f7FEQSc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-GDZvsKOCM6CXxC2Rs8yBsg-1; Sun,
 29 Jun 2025 15:11:17 -0400
X-MC-Unique: GDZvsKOCM6CXxC2Rs8yBsg-1
X-Mimecast-MFC-AGG-ID: GDZvsKOCM6CXxC2Rs8yBsg_1751224274
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CAB81800289;
	Sun, 29 Jun 2025 19:11:14 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21636180035C;
	Sun, 29 Jun 2025 19:11:06 +0000 (UTC)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v12 02/14] dt-bindings: dpll: Add support for Microchip Azurite chip family
Date: Sun, 29 Jun 2025 21:10:37 +0200
Message-ID: <20250629191049.64398-3-ivecera@redhat.com>
In-Reply-To: <20250629191049.64398-1-ivecera@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
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
v9:
* no change
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


