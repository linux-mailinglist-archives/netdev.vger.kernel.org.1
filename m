Return-Path: <netdev+bounces-214076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF846B28267
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622AD188DDF8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C4277CA2;
	Fri, 15 Aug 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0+wZ4aQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886D230BFD
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269274; cv=none; b=LRrDBDUpgEPKsXIJ0/f+EJFJTv+F2w3pSZxQb9PfWsPLWk37U9s11SIslJCqUrVVG44Hj4Eta84AUKwvPV7bmzd8HwwJ2qEeBH6CTtmyFdVFtwAUY6EZu/SF6QONN7vENj1vbZuaODVF8sztt3jMJGuseainYrPFtmI4A60X2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269274; c=relaxed/simple;
	bh=LwC42usex+8ylvFt4aTbq/GyJFYNsHX5kH2ui/VE6nY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ri0EdpZEv2jxYx1E5FHFa+ncCJM8W/OCSr4SqORrbqDiBApefAbh5Gz3/bGTIllDb5mHZUQGpCXLDfdF/zdleIzKEPEVA1rrHxe07/WE5SkF2xCnCTYhJEuVX+2Z41RQPMQA7DwI3r0dlEK6oZckql/DvUd3n/nAo6UNBuvensI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0+wZ4aQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755269271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sg1fwPS7sBPbcXc/VRMT8Ax3SswWQxZY6NUgMTsaTNw=;
	b=J0+wZ4aQQi0GZlKb+sNzVZKbrFbog0sehsY/j84ssvOZ9C273wlI+UWJ11XkxTpblPYgwL
	YrCuZiuhEMhDMhismgLw/Kp6VqElEeqnzD7DKU0iOBTNkyZtqcaHK9TSxOitJW95MJrIJe
	NJDcSlFs2Sk99BTI5piiFjVB9dZyA5s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-LDJkOuj_Ms-GMEMsX_2qtA-1; Fri,
 15 Aug 2025 10:47:45 -0400
X-MC-Unique: LDJkOuj_Ms-GMEMsX_2qtA-1
X-Mimecast-MFC-AGG-ID: LDJkOuj_Ms-GMEMsX_2qtA_1755269264
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271CD18011D2;
	Fri, 15 Aug 2025 14:47:42 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79F5930001A6;
	Fri, 15 Aug 2025 14:47:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: mschmidt@redhat.com,
	poros@redhat.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet reference property
Date: Fri, 15 Aug 2025 16:47:35 +0200
Message-ID: <20250815144736.1438060-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In case of SyncE scenario a DPLL channels generates a clean frequency
synchronous Ethernet clock (SyncE) and feeds it into the NIC transmit
path. The DPLL channel can be locked either to the recovered clock
from the NIC's PHY (Loop timing scenario) or to some external signal
source (e.g. GNSS) (Externally timed scenario).

The example shows both situations. NIC1 recovers the input SyncE signal
that is used as an input reference for DPLL channel 1. The channel locks
to this signal, filters jitter/wander and provides holdover. On output
the channel feeds a stable, phase-aligned clock back into the NIC1.
In the 2nd case the DPLL channel 2 locks to a master clock from GNSS and
feeds a clean SyncE signal into the NIC2.

		   +-----------+
		+--|   NIC 1   |<-+
		|  +-----------+  |
		|                 |
		| RxCLK     TxCLK |
		|                 |
		|  +-----------+  |
		+->| channel 1 |--+
+------+	   |-- DPLL ---|
| GNSS |---------->| channel 2 |--+
+------+  RefCLK   +-----------+  |
				  |
			    TxCLK |
				  |
		   +-----------+  |
		   |   NIC 2   |<-+
		   +-----------+

In the situations above the DPLL channels should be registered into
the DPLL sub-system with the same Clock Identity as PHCs present
in the NICs (for the example above DPLL channel 1 uses the same
Clock ID as NIC1's PHC and the channel 2 as NIC2's PHC).

Because a NIC PHC's Clock ID is derived from the NIC's MAC address,
add a per-channel property 'ethernet-handle' that specifies a reference
to a node representing an Ethernet device that uses this channel
to synchronize its hardware clock. Additionally convert existing
'dpll-types' list property to 'dpll-type' per-channel property.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../devicetree/bindings/dpll/dpll-device.yaml | 40 ++++++++++++++++---
 .../bindings/dpll/microchip,zl30731.yaml      | 29 +++++++++++++-
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693f..798c5484657cf 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -27,11 +27,41 @@ properties:
   "#size-cells":
     const: 0
 
-  dpll-types:
-    description: List of DPLL channel types, one per DPLL instance.
-    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-    items:
-      enum: [pps, eec]
+  channels:
+    type: object
+    description: DPLL channels
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        description: DPLL channel
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description: Hardware index of the DPLL channel
+            maxItems: 1
+
+          dpll-type:
+            description: DPLL channel type
+            $ref: /schemas/types.yaml#/definitions/string
+            enum: [pps, eec]
+
+          ethernet-handle:
+            description:
+              Specifies a reference to a node representing an Ethernet device
+              that uses this channel to synchronize its hardware clock.
+            $ref: /schemas/types.yaml#/definitions/phandle
+
+        required:
+          - reg
 
   input-pins:
     type: object
diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
index 17747f754b845..bc6d6cc1dd47f 100644
--- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -44,9 +44,26 @@ examples:
       #size-cells = <0>;
 
       dpll@70 {
+        #address-cells = <0>;
+        #size-cells = <0>;
         compatible = "microchip,zl30732";
         reg = <0x70>;
-        dpll-types = "pps", "eec";
+
+        channels {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          channel@0 {
+            reg = <0>;
+            dpll-type = "pps";
+          };
+
+          channel@1 {
+            reg = <1>;
+            dpll-type = "eec";
+            ethernet-handle = <&ethernet0>;
+          };
+        };
 
         input-pins {
           #address-cells = <1>;
@@ -84,7 +101,15 @@ examples:
         reg = <0x70>;
         spi-max-frequency = <12500000>;
 
-        dpll-types = "pps";
+        channels {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          channel@0 {
+            reg = <0>;
+            dpll-type = "pps";
+          };
+        };
 
         input-pins {
           #address-cells = <1>;
-- 
2.49.1


