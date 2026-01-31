Return-Path: <netdev+bounces-255539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHAVJfmRfmkjawIAu9opvQ
	(envelope-from <netdev+bounces-255539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:36:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8BC45B1
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050E5304139D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFB38A9C2;
	Sat, 31 Jan 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hZo6cIy2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tAtGoI5P"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404538B9A1;
	Sat, 31 Jan 2026 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769902543; cv=none; b=jMp3QnFumM3Iyxuc5FtiRICP6R5X5hr6+4gPoMMmqV/gSPMw+U0LByf6/vLot+fLxeKM2V17d3dJCZ+FKJjL9erE63MRBiABpNP+4hPd/qwL9Y8XO31JGa/hXtpRpojnP49OytgOc0V/k6nnEtGl+ChDwVAiaZokYOlyGpJkwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769902543; c=relaxed/simple;
	bh=d9KDAPLaqr5lNQg/4YQRImcu3UBr0xieBivweRNR6sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcRUWIvbAjw5LWKobcQapsGJpHJymnpupI2lS8RqaT2I8Gtqw0BIGq4IvhYAZKX8QeA7ISBRKptZt18QO1sq+LcmI1yixQXOJVx7n8/fOZrgsYGBjVe3srJuOTP1FpSqgOPJQn8Nu6XtHioPUXAvW9AAgIZDXajFbXPF9XePo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hZo6cIy2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tAtGoI5P; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f3TlB0sxlz9tkg;
	Sun,  1 Feb 2026 00:35:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769902534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhyHduAmoAQIL7YhVVlAUTqh1T7oCN7Ok89ILNNkwEk=;
	b=hZo6cIy2WEWI95Oa4ZkAsjIkn0a14DrNyMItPc/4ea3irY5JQ+LFTzaVvkVBnljeHczXFH
	IJZpiBytIaElFn2LwnHElytI3cktKlSHg5WUvbXw7fgBBmRe+YHARnjF/PLyXUI+/r/Ej7
	6Q5jAb+4kznM74X2vQM0mmdrgcrC60TF0x7mwfQ0xM65m9GIzmO2yffNCI0s6UGkK7mLTv
	WCzgru7G9lPu0GW1ebX8lYv5hqyTrdUtinuMp6PlTv9Ih7LzzUXA4OrVdW5NLzYNuESWdu
	+gIaZH2CWPy92x60cHDc4EJcdeBF0Ty+cplhLxY7Wlhb5B9Ae0kF9YttZiNAGA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tAtGoI5P;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769902531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhyHduAmoAQIL7YhVVlAUTqh1T7oCN7Ok89ILNNkwEk=;
	b=tAtGoI5PYj6Ac5uNytVa6RHtutCcNuk+HK8L2OuFrZu7TcigObUoM/rfPawlh4DB1hAbCn
	ZYY9bHyyPr6xVEvDeE4YztFHrYJ8gv9+TpF26ScANoLetL/J3uzFj6tsJZsRqEJKBRg5/x
	zlKVxCHiCmCVOrODSEkcrKGS5TwarSf7iKa1DQi/7A3JTuabwbspbPEai8FEuJHiQa4yAq
	1P8fBjzWMRxaXnk0zGHSmkV7h5OXW5Dtj9hFMtlL1Rhk9MMFTd8Fy51cO69KSO3FqnXicM
	6By2IERLc7Jp5X5nHMSet1ZLibvo1n304vRj9jrPGfA97K5GczWpCENqrW1mZw==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v22 1/7] dt-bindings: net: Add MTIP L2 switch description
Date: Sun,  1 Feb 2026 00:34:53 +0100
Message-Id: <20260131233459.1625279-2-lukasz.majewski@mailbox.org>
In-Reply-To: <20260131233459.1625279-1-lukasz.majewski@mailbox.org>
References: <20260131233459.1625279-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0226c52c5a0d3acbd03
X-MBO-RS-META: yd7rr93swnub53nj6ac34mqoaxrf5f6s
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	TAGGED_FROM(0.00)[bounces-255539-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	DBL_PROHIBIT(0.00)[0.0.0.2:email,0.0.0.1:email,0.0.0.0:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[denx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:email,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Queue-Id: 24D8BC45B1
X-Rspamd-Action: no action

This patch provides description of the MTIP L2 switch available in some
NXP's SOCs - e.g. imx287.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---
Changes for v2:
- Rename the file to match exactly the compatible
  (nxp,imx287-mtip-switch)

Changes for v3:
- Remove '-' from const:'nxp,imx287-mtip-switch'
- Use '^port@[12]+$' for port patternProperties
- Drop status = "okay";
- Provide proper indentation for 'example' binding (replace 8
  spaces with 4 spaces)
- Remove smsc,disable-energy-detect; property
- Remove interrupt-parent and interrupts properties as not required
- Remove #address-cells and #size-cells from required properties check
- remove description from reg:
- Add $ref: ethernet-switch.yaml#

Changes for v4:
- Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove already
  referenced properties
- Rename file to nxp,imx28-mtip-switch.yaml

Changes for v5:
- Provide proper description for 'ethernet-port' node

Changes for v6:
- Proper usage of
  $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
  when specifying the 'ethernet-ports' property
- Add description and check for interrupt-names property

Changes for v7:
- Change switch interrupt name from 'mtipl2sw' to 'enet_switch'

Changes for v8:
- None

Changes for v9:
- Add GPIO_ACTIVE_LOW to reset-gpios mdio phandle

Changes for v10:
- None

Changes for v11:
- None

Changes for v12:
- Remove 'label' from required properties
- Move the reference to $ref: ethernet-switch.yaml#/$defs/ethernet-ports
  the proper place (under 'allOf:')

Changes for v13 - v22:
- None
---
 .../bindings/net/nxp,imx28-mtip-switch.yaml   | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
new file mode 100644
index 000000000000..6a07dcd119ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+description:
+  The 2-port switch ethernet subsystem provides ethernet packet (L2)
+  communication and can be configured as an ethernet switch. It provides the
+  reduced media independent interface (RMII), the management data input
+  output (MDIO) for physical layer device (PHY) management.
+
+allOf:
+  - $ref: ethernet-switch.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: nxp,imx28-mtip-switch
+
+  reg:
+    maxItems: 1
+
+  phy-supply:
+    description:
+      Regulator that powers Ethernet PHYs.
+
+  clocks:
+    items:
+      - description: Register accessing clock
+      - description: Bus access clock
+      - description: Output clock for external device - e.g. PHY source clock
+      - description: IEEE1588 timer clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: ahb
+      - const: enet_out
+      - const: ptp
+
+  interrupts:
+    items:
+      - description: Switch interrupt
+      - description: ENET0 interrupt
+      - description: ENET1 interrupt
+
+  interrupt-names:
+    items:
+      - const: enet_switch
+      - const: enet0
+      - const: enet1
+
+  pinctrl-names: true
+
+  ethernet-ports:
+    type: object
+    additionalProperties: true
+
+    patternProperties:
+      '^ethernet-port@[12]$':
+        type: object
+        additionalProperties: true
+        properties:
+          reg:
+            items:
+              - enum: [1, 2]
+            description: MTIP L2 switch port number
+
+        required:
+          - reg
+          - phy-mode
+          - phy-handle
+
+  mdio:
+    type: object
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Specifies the mdio bus in the switch, used as a container for phy nodes.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - mdio
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include<dt-bindings/interrupt-controller/irq.h>
+    #include<dt-bindings/gpio/gpio.h>
+    switch@800f0000 {
+        compatible = "nxp,imx28-mtip-switch";
+        reg = <0x800f0000 0x20000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&mac0_pins_a>, <&mac1_pins_a>;
+        phy-supply = <&reg_fec_3v3>;
+        interrupts = <100>, <101>, <102>;
+        interrupt-names = "enet_switch", "enet0", "enet1";
+        clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+        clock-names = "ipg", "ahb", "enet_out", "ptp";
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mtip_port1: ethernet-port@1 {
+                reg = <1>;
+                label = "lan0";
+                local-mac-address = [ 00 00 00 00 00 00 ];
+                phy-mode = "rmii";
+                phy-handle = <&ethphy0>;
+            };
+
+            mtip_port2: ethernet-port@2 {
+                reg = <2>;
+                label = "lan1";
+                local-mac-address = [ 00 00 00 00 00 00 ];
+                phy-mode = "rmii";
+                phy-handle = <&ethphy1>;
+            };
+        };
+
+        mdio_sw: mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reset-gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
+            reset-delay-us = <25000>;
+            reset-post-delay-us = <10000>;
+
+            ethphy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+
+            ethphy1: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
-- 
2.39.5


