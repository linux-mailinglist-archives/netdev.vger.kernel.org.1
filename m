Return-Path: <netdev+bounces-256351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGv0Mo0ggmlIPgMAu9opvQ
	(envelope-from <netdev+bounces-256351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:21:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C62FDBD6B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A39FF306DAB6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04F38E113;
	Tue,  3 Feb 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4Rt6+Rs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AC3BFE3A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135563; cv=none; b=sxgfdumQePWvyW2tpD79JMWWdQv+kScZC40d/lTy3TWXSQJhGSiirCFR65Dj9H22g9qFZh0wmvQ/xcALlYwTJGJ7WzaBiLA8xVe/PRI/mzCYw2WVOTwzedgMJQtgbL94hogAV7b/7yAdFzoJzk4ElEb1qGjla9+qkt3dzFLQ9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135563; c=relaxed/simple;
	bh=HzBu2NbGKcOQwsBSue+2sXgdaUYPXA/eSDYmPrHSRrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLx6YDk5A0Q1aHfoIZyK7/34w5mXOK+fg9wUHlDCCugMTcY6uaTyQpqE0XxEOlIk9+Q2QCJoMzdgv+JSpvncFzIF1CQR/DJuCLGtVT0iPv6CKAwGeEi0HL57v2k7ii3C2tr1s4elwnSS+SyCDdGT/7Lpg4ozbe/jiZGMSJwBkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h4Rt6+Rs; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4805ef35864so50853125e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770135560; x=1770740360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3Z4Yd2fRXfRsRi8a3YRl2niiXC4DwI7ABHuLbV15ig=;
        b=h4Rt6+RsjtNKfurCPZcgm8jMatIpGD/b/WzNU3lr1gs5EztHor5LYpiE4YB9Eg8T6J
         Mf56lEsFZMihGcPZ4edGVn74syYMKbgFS2NpEYpLaxC7s/Sn5nXFZjShm+E/wAY4I+1H
         1Pr1Dgpyyaqm1+se3QvcENj8RekbnO/tpb8bFqGtOITMuDzSQ69RoOMrE8LW9J6o+i7k
         dEG/6rzkhrIvAmsQOyX96rUYCKod0Z3kqrZjpOrxZCo/iniw8P10fP4lvrg9WzYTmsmI
         fmnLNJyNipkOHOHdNSWTCt2UDL4kFiy/xJ+Tuju8NyZIkfe5I4ZEEo9tSwYcnk/6oSIP
         4Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135560; x=1770740360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j3Z4Yd2fRXfRsRi8a3YRl2niiXC4DwI7ABHuLbV15ig=;
        b=afnUGbpQ0Cv3CMYUp5HTktNecpjX2EIUpPmxlYa+/HVwDuSTFPuZkW6762IvXyRMfQ
         08oAiIx2DtKg35eT4wFPK+aEgJ2Bqn0Wh+USzrdTbU6pD7kbzoSCG/vdwY7CfQK4QS7e
         FpzXP3IEdAhJDDTvenBxj4LptOTtID9G+PmtUjw3jsRZn3VeMmV6cSy1aFSNlYKo4SrK
         JEZ2uEHd1HQoTC/X/P1OTKIRd61pjJaoM1L5/l5Vku+Dqh1S9cd7GZI4w7bWMv6jOS9S
         pZuPkkghwlOH1qVoDPYhHFXq7r7eXPvKaVaD6iibOPFJrCWjE71wyBXShJ3R5LKFjtOT
         Decg==
X-Forwarded-Encrypted: i=1; AJvYcCV5LSK8hnvrxFWuDwSY8h+R5VRw8+kRwn+d6+2CJDPsmX8k9iC5d29PDB+ud9geebDebIaBapE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFs6OHHp+L0J3AUw/dIJv1uMcb5FgBnL4iPXHUFAity4SiL3z
	b5wo4FgUqEeaePrZmPWg+dD6oMoqJbIy5DNRYdLe0NN3MuUZqxYHBA5n5S55hQflRGw=
X-Gm-Gg: AZuq6aKYMFSs+ANjSd6GzFlm4NjiZV9pOkYsSmuw4uhY1ZfD0Amq25cga1P19QyJ3vR
	ltNCeFiWd2BdqQv7eM19Tuc2jtJg3D70xcldOmFOsN9EjWhfGS80H77pmZBk5dLH50nfSnbwAWO
	M5+LXg9Lb2NVam//6lKJf88A1Hq2xdTu2/6d7mZ9KrHZ9BbtJyGmgUSAnWzJh2WnB0+9/GFDfw6
	knquVs7OAS2d7jnSzQUQtt5hf6oWxAiPn8RTAY9pIADG9TTeaUsUOFtDh0i+JEDr1e+kjKBHRsa
	L5Aip6Br2MkaNbdvetAa6SbaLDfuS/GB4FXxsL1LHGL6iRIC96+u14PHPLeIAkS/uGXNI3V3WLa
	wpKVPucZtsh1uWtRvN0s00dY5oKoQS9PlOtS93/g+O/ItFGEDt0nOVqMifkI0iSAhmkLUu7jQUR
	WNbTBZdtnXmQZaF2cJpwY=
X-Received: by 2002:a05:600c:8489:b0:483:ea6:8767 with SMTP id 5b1f17b1804b1-4830ea687b8mr681395e9.36.1770135560329;
        Tue, 03 Feb 2026 08:19:20 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:81d1:b874:c1dc:42e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd21f5dsm144120785e9.8.2026.02.03.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:19:19 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	p.zabel@pengutronix.de,
	linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com,
	Ionut.Vicovan@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: Frank.li@nxp.com
Subject: [PATCH 1/4 v2] dt-bindings: serdes: s32g: Add NXP serdes subsystem
Date: Tue,  3 Feb 2026 17:19:14 +0100
Message-ID: <20260203161917.1666696-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203161917.1666696-1-vincent.guittot@linaro.org>
References: <20260203161917.1666696-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-256351-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[2.105.173.0:email];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,0.0.0.0:email,linaro.org:email,linaro.org:dkim,linaro.org:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 6C62FDBD6B
X-Rspamd-Action: no action

Describe the serdes subsystem available on the S32G platforms.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 .../bindings/phy/nxp,s32g-serdes.yaml         | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml

diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
new file mode 100644
index 000000000000..fad34bee2a4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
+
+maintainers:
+  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
+
+description: |
+  The SerDes subsystem on S32G SoC Family includes two types of PHYs:
+    - One PCIe PHY: Supports various PCIe operation modes
+    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
+
+  SerDes operation mode selects the enabled PHYs and speeds. Clock frequency
+  must be adapted accordingly. Below table describes all possible operation
+  modes.
+
+  Mode  PCIe	XPCS0		XPCS1		PHY clock	Description
+                SGMII		SGMII		  (MHz)
+  -------------------------------------------------------------------------
+  0	Gen3	N/A		N/A		100		Single PCIe
+  1	Gen2	1.25Gbps	N/A		100		PCIe/SGMII
+  2	Gen2	N/A		1.25Gbps	100		PCIe/SGMII
+  3	N/A	1.25Gbps	1.25Gbps	100,125		SGMII
+  4	N/A	3.125/1.25Gbps	3.125/1.25Gbps 	125		SGMII
+  5	Gen2	N/A	        3.125Gbps     	100		PCIe/SGMII
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,s32g2-serdes
+      - items:
+          - const: nxp,s32g3-serdes
+          - const: nxp,s32g2-serdes
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: ss_pcie
+      - const: pcie_phy
+      - const: xpcs0
+      - const: xpcs1
+
+  clocks:
+    minItems: 4
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: axi
+      - const: aux
+      - const: apb
+      - const: ref
+      - const: ext
+    minItems: 4
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: serdes
+      - const: pcie
+
+  nxp,sys-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SerDes operational mode. See above table for possible values.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^serdes[0,1]_lane@[0,1]$':
+    description:
+      Describe a serdes lane.
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - nxp,s32g2-serdes-pcie-phy
+          - nxp,s32g2-serdes-xpcs
+
+      reg:
+        maxItems: 1
+
+      '#phy-cells':
+        const: 0
+
+    required:
+      - reg
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - nxp,sys-mode
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        serdes0: serdes@40480000 {
+          compatible = "nxp,s32g3-serdes", "nxp,s32g2-serdes";
+            reg = <0x0 0x40480000 0x0 0x108>,
+                  <0x0 0x40483008 0x0 0x10>,
+                  <0x0 0x40482000 0x0 0x800>,
+                  <0x0 0x40482800 0x0 0x800>;
+            reg-names = "ss_pcie", "pcie_phy", "xpcs0", "xpcs1";
+            clocks = <&clks 1>,
+                     <&clks 2>,
+                     <&clks 3>,
+                     <&clks 4>,
+                     <&serdes_100_ext>;
+            clock-names = "axi", "aux", "apb", "ref", "ext";
+            resets = <&reset 9>,
+                     <&reset 8>;
+            reset-names = "serdes", "pcie";
+            nxp,sys-mode = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            phy_pcie0: serdes0_lane@0 {
+              compatible = "nxp,s32g2-serdes-pcie-phy";
+              #phy-cells = <0>;
+              reg = <0>;
+            };
+            phy_xpcs0_0: serdes0_lane@1 {
+              compatible = "nxp,s32g2-serdes-xpcs";
+              reg = <0>;
+            };
+        };
+    };
-- 
2.43.0


