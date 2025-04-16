Return-Path: <netdev+bounces-183383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCA6A908A7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7C87A475D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6035213221;
	Wed, 16 Apr 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtpsDvxM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B0212B31
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820531; cv=none; b=K9DBAr5J2nw3a3z4JKEy67x2lDDVXEAM11JF2RaTZjA9LPsydHd6ZF472jAWhyK5UTa+xgiGmlFCYFN3OYX7rrp6BPmDGlPq+v9VRuSVE/DCJh0Ln9H8VwayUJ8z/A5hieFvTRxFTVkAO19BpOt7Vfq9yHykLaUgaiKb+4fe2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820531; c=relaxed/simple;
	bh=aQfGhYphwtdsVQYR1n6GCV280C9Iv47jePw0KVZiRqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhZm0cex+MRDUI35ACVtTtjWaPn0VKESVD3ySgGjIPIUZRNrvi6q0meuMT1jhLbgO/ORdbWpQiBJCXndikxYexfi/qORbBmxU0CvinWFac53ejH2rQSwdOCyvNxBrR9CAqeO42k1QXAvhQPf1+7zw8ueuukXbJJrXBmObar+YYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtpsDvxM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1E5OFYBgnUMUUJtH2lEiHD6dZG1MJrGDVETUsXtNfk=;
	b=EtpsDvxMoZoT1sdTvvlZNPAFzxPH6W/haLgrfC8k5vBLwm7A7DJbtPjL73VxDnCznOy3xW
	QEw4YMlUqnuehMYvHxZPVxJIC5R/6NZLAXDMhX1bv0rbrVz3JBW6qPmZuefQO91nlbJdtZ
	JRsCCvZD/TdmdKUSodqsUT9CzxhgQBE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-N6v62SgwM6ifAzqG-ziAuw-1; Wed,
 16 Apr 2025 12:22:04 -0400
X-MC-Unique: N6v62SgwM6ifAzqG-ziAuw-1
X-Mimecast-MFC-AGG-ID: N6v62SgwM6ifAzqG-ziAuw_1744820522
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDD851956095;
	Wed, 16 Apr 2025 16:22:01 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91FC11800352;
	Wed, 16 Apr 2025 16:21:56 +0000 (UTC)
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
Subject: [PATCH v3 net-next 2/8] dt-bindings: dpll: Add support for Microchip Azurite chip family
Date: Wed, 16 Apr 2025 18:21:38 +0200
Message-ID: <20250416162144.670760-3-ivecera@redhat.com>
In-Reply-To: <20250416162144.670760-1-ivecera@redhat.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add DT bindings for Microchip Azurite DPLL chip family. These chips
provides up to 5 independent DPLL channels, 10 differential or
single-ended inputs and 10 differential or 20 single-ended outputs.
It can be connected via I2C or SPI busses.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v1->v3:
* single file for both i2c & spi
* 5 compatibles for all supported chips from the family
---
 .../bindings/dpll/microchip,zl30731.yaml      | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
new file mode 100644
index 0000000000000..cb1486d140382
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/microchip,zl3073x.yaml#
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


