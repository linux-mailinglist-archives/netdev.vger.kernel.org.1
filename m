Return-Path: <netdev+bounces-179798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A863A7E877
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AD5188D402
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71DE221DA1;
	Mon,  7 Apr 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNv0adHu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5222A4D5
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047162; cv=none; b=a+jG/q05NyDgnnKHtQAfXfEXlJnDXeKQXUdinsSFPY0XF6saaty7q2v2RpBAWINSGtJBvOz/UhZ8aFI9wxa6QrsYvC/LGAt9IoM5Y/VIWiYMk5yBbhIYMWhH2b01LipznJKXKG8HBDidhNmJRu7YkHZsvdpENKN3HoM0kkfN/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047162; c=relaxed/simple;
	bh=fUWtEZtchgf52Hg+WQ+sPgT+xDS2yWU+wTpYDGEVStY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+8W7Ov4b+HDHMJ3EDAisXxK0C6fAJZ8S8O9IsOlnm0e0Ere4w+QQZmdK0zlPILY3tDWj1CfFLa0vyx97LwNDaZOyw6J9jMEwoAKELuzwJLW5nXG6q8A9KmLHlW6m/Wy1+TCTsNR6g2rQuTe8ZSyN+kOwbD+cHD+dyep7JLhQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNv0adHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8RER3e3u7RBnYnapJ8mt6emEOkYYUHBX8SC+kNOU1g=;
	b=PNv0adHu+kxik+P45fQfvRfMd2c4aAUqKjY27V/Kf5/iw6isVjaxOEpL1cwhn0WoBmcgwp
	GxMyDuzYv5YOeAttPKSPf48MNeYmtXOL4GJCsSZHz9SqzXc6wUP74x/m5iCbeEosUVzzlR
	b1UjedmBsLLhV6JIE+zTJChnp6Ava+w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-VlIneVjJOfOUZfkAFySvjg-1; Mon,
 07 Apr 2025 13:32:36 -0400
X-MC-Unique: VlIneVjJOfOUZfkAFySvjg-1
X-Mimecast-MFC-AGG-ID: VlIneVjJOfOUZfkAFySvjg_1744047154
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF60B180AF55;
	Mon,  7 Apr 2025 17:32:34 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CD711956094;
	Mon,  7 Apr 2025 17:32:28 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 16/28] dt-bindings: dpll: Add support for Microchip Azurite chip family
Date: Mon,  7 Apr 2025 19:31:46 +0200
Message-ID: <20250407173149.1010216-7-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This adds DT bindings schema for Microchip Azurite DPLL chip family.
These bindings are used by zl3073x driver and specifies this device
that can be connected either to I2C or SPI bus.

The schema inherits existing dpll-device and dpll-pin schemas.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../bindings/dpll/microchip,zl3073x.yaml      | 74 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
new file mode 100644
index 0000000000000..38a6cc00bc026
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
@@ -0,0 +1,74 @@
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
+properties:
+  compatible:
+    enum:
+      - microchip,zl3073x-i2c
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
+  - $ref: /schemas/dpll/dpll-device.yaml
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
+        #address-cells = <0>;
+        #size-cells = <0>;
+        reg = <0x70>;
+        status = "okay";
+
+        num-dplls = <2>;
+        dpll-types = "pps", "eec";
+
+        input-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@0 { /* REF0P */
+            reg = <0>;
+
+            label = "Input 0";
+            type = "ext";
+            supported-frequencies = /bits/ 64 <1 1000>;
+          };
+        };
+
+        output-pins {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          pin@3 { /* OUT1N */
+            reg = <3>;
+
+            label = "Output 1";
+            type = "gnss";
+            esync-control;
+            supported-frequencies = /bits/ 64 <1 10000>;
+          };
+        };
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index eaf2576a9b746..ec86bec05c40c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16001,6 +16001,7 @@ M:	Ivan Vecera <ivecera@redhat.com>
 M:	Prathosh Satish <Prathosh.Satish@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/dpll/microchip,zl3073x.yaml
 F:	drivers/dpll/dpll_zl3073x*
 F:	drivers/mfd/zl3073x*
 F:	include/linux/mfd/zl3073x.h
-- 
2.48.1


