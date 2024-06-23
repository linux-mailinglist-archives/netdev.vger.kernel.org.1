Return-Path: <netdev+bounces-105949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC9913CFD
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC1C283513
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95B183089;
	Sun, 23 Jun 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCauEOHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A08F5B;
	Sun, 23 Jun 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162589; cv=none; b=NcqxUqCvB2GwwmEzYxkE4nOT7MJnJH9Gq7n8kobl0Bb8Z2H5zCOVlqWsElRuTcFWu7gkl5Qx0LynDCvHqaCDiGRbkKKrd7tpfX4NEgJXtio9ZkIs9x1GaUy2xKvmbukj1/FFJkOMGuhb/sFf91ZRCSK7Dkhy0EUKOYWyI+N5PJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162589; c=relaxed/simple;
	bh=tQkkahnYieXy88Qh4CeUGjNNp7ssw8YuvBevUMbs1jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gduCwKwXFzHIxo5ZQj7L95bSE8uSX3L4fSyRshZBQgSsWWqqDrPO+LIf/4Ha09Z4UwDxwjX9ycM23aopgNjDOrJ+ROMPnwsjVA/iHqXSyazdKHVXJd7tPqf1OEWf+hb44DDQFrt8GrNTUsT+3YNzzFoX2pKqreR3GmCb0nFBA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCauEOHD; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3b36cc47bso2202939f.0;
        Sun, 23 Jun 2024 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719162586; x=1719767386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jFqQ9m9baI0PMnMyszCHoX3PO27F3E3H83bwUdNQUg=;
        b=KCauEOHDDePYZB8213TQ+eTHXvl+7PNq3dkJr6CsEyyIJeJktzoyo6QqbJj7SqKciK
         DctoxgqDpt3H+7tNDrMFfOySDKEbijYV1JjyireYOBIDQMyJimegXkvXeIhzeVnkbhBU
         Ok/mm6DXWpi6LRZO/WyswkzYJn/IhvOXdUrIxZQZW99/jP+2CLBL3Zs9afqWxdCcJw1N
         RuC22TEdPc8woGAxcGZlKj5EYzYWaRnUxOxRqVFwOCEmS3lZClRLCjzc2D+0GgzSbqKW
         Z5Hcu+jYS0u67tS0QkBCDxK3NhuP2daW2hKORyzHHLK5UbPyU+EmnPbKdGyKnoO4lBtr
         mAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719162586; x=1719767386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jFqQ9m9baI0PMnMyszCHoX3PO27F3E3H83bwUdNQUg=;
        b=jlv6RVHKdIJAMN8PkwBuzEPfKclUKUjo9B+BLlU3ilouza1UW7Hb2SyOAGrvPBDW23
         DTZVUZQ0RTqN9gyplgn7s/pUWOu3+Ph9bo/MlQwb077Ass5iz/sTkU4eoI1G+fYrE7D+
         oDwUcRACEJCuR7Txjo2aVHC/49XnbbT7eg3Mywl7G9j0xpwwEJmfayt/Onjo+AGGG2jq
         gCDoDowGLoFKklqFjn52XL02uB9H7IkMecUb31NYqhw9qGqZRgt2NLaiFuNNyeCR2SHj
         mGhDvKDxOuoAfx9mQguBAhX2tXvok3u42Rn5bZYfg8q97FTuhfrmCFfkYuBmo8EzXd+p
         IPvA==
X-Forwarded-Encrypted: i=1; AJvYcCUeeP8tq40vzacYl3MqVUU81Qk0hTkKdgId0i4/hViFyULAe7kp6y/lrIPuqmsR09xdslSktT7jjPFkwN+0Xt6MDz2qQUMJZJKR9ep1aFpOXeU/iDCfKn+AAM2ufjMyqprolbVt
X-Gm-Message-State: AOJu0Yy9/hXwiF1yBJtozmYfGv3ydYpnusBTeuY1zspWQhylsZco3b0V
	Phc/OErpgRAFmeu88Mww0RG95HRVI7Kl4g0blOe3lFErcj3vWhI/qWYPpQ==
X-Google-Smtp-Source: AGHT+IEyqlDrKAjXC7OKyz6JG7m/0yE9wGhkb0TPQKZzzavCexRQvIYnrIbTnuIVyT4Fgu6dniZY8w==
X-Received: by 2002:a05:6602:6419:b0:7eb:b36f:b4e2 with SMTP id ca18e2360f4ac-7f3a74be868mr271263839f.10.1719162586012;
        Sun, 23 Jun 2024 10:09:46 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:7f0e:d47:475:ab36])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d41612dbsm1480959173.4.2024.06.23.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:09:45 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: devicetree@vger.kernel.org
Cc: woods.technical@gmail.com,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adam Ford <aford@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: davinci_emac: Convert to yaml version from txt
Date: Sun, 23 Jun 2024 12:09:33 -0500
Message-ID: <20240623170933.63864-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The davinci_emac is used by several devices which are still maintained,
but to make some improvements, it's necessary to convert from txt to yaml.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/net/davinci_emac.txt b/Documentation/devicetree/bindings/net/davinci_emac.txt
deleted file mode 100644
index 5e3579e72e2d..000000000000
--- a/Documentation/devicetree/bindings/net/davinci_emac.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* Texas Instruments Davinci EMAC
-
-This file provides information, what the device node
-for the davinci_emac interface contains.
-
-Required properties:
-- compatible: "ti,davinci-dm6467-emac", "ti,am3517-emac" or
-  "ti,dm816-emac"
-- reg: Offset and length of the register set for the device
-- ti,davinci-ctrl-reg-offset: offset to control register
-- ti,davinci-ctrl-mod-reg-offset: offset to control module register
-- ti,davinci-ctrl-ram-offset: offset to control module ram
-- ti,davinci-ctrl-ram-size: size of control module ram
-- interrupts: interrupt mapping for the davinci emac interrupts sources:
-              4 sources: <Receive Threshold Interrupt
-			  Receive Interrupt
-			  Transmit Interrupt
-			  Miscellaneous Interrupt>
-
-Optional properties:
-- phy-handle: See ethernet.txt file in the same directory.
-              If absent, davinci_emac driver defaults to 100/FULL.
-- ti,davinci-rmii-en: 1 byte, 1 means use RMII
-- ti,davinci-no-bd-ram: boolean, does EMAC have BD RAM?
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-Example (enbw_cmc board):
-	eth0: emac@1e20000 {
-		compatible = "ti,davinci-dm6467-emac";
-		reg = <0x220000 0x4000>;
-		ti,davinci-ctrl-reg-offset = <0x3000>;
-		ti,davinci-ctrl-mod-reg-offset = <0x2000>;
-		ti,davinci-ctrl-ram-offset = <0>;
-		ti,davinci-ctrl-ram-size = <0x2000>;
-		local-mac-address = [ 00 00 00 00 00 00 ];
-		interrupts = <33
-				34
-				35
-				36
-				>;
-		interrupt-parent = <&intc>;
-	};
diff --git a/Documentation/devicetree/bindings/net/davinci_emac.yaml b/Documentation/devicetree/bindings/net/davinci_emac.yaml
new file mode 100644
index 000000000000..4c2640aef8a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/davinci_emac.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/davinci_emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Davici EMAC
+
+maintainers:
+  - Adam Ford <aford@gmail.com>
+
+description:
+  Ethernet based on the Programmable Real-Time Unit and Industrial
+  Communication Subsystem.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,davinci-dm6467-emac # da850
+          - ti,dm816-emac
+          - ti,am3517-emac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ick
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  local-mac-address: true
+  mac-address: true
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the global system controller on
+      to enable/disable interrupts
+
+  ti,davinci-ctrl-reg-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to control register
+
+  ti,davinci-ctrl-mod-reg-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to control module register
+
+  ti,davinci-ctrl-ram-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Offset to control module ram
+
+  ti,davinci-ctrl-ram-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of control module ram
+
+  ti,davinci-rmii-en:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      RMII enable means use RMII
+
+  ti,davinci-no-bd-ram:
+    type: boolean
+    description:
+      Enable if EMAC have BD RAM
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - ti,davinci-ctrl-reg-offset
+  - ti,davinci-ctrl-mod-reg-offset
+  - ti,davinci-ctrl-ram-offset
+  - ti,davinci-ctrl-ram-size
+
+examples:
+  - |
+    eth0: ethernet@220000 {
+      compatible = "ti,davinci-dm6467-emac";
+      reg = <0x220000 0x4000>;
+      ti,davinci-ctrl-reg-offset = <0x3000>;
+      ti,davinci-ctrl-mod-reg-offset = <0x2000>;
+      ti,davinci-ctrl-ram-offset = <0>;
+      ti,davinci-ctrl-ram-size = <0x2000>;
+      local-mac-address = [ 00 00 00 00 00 00 ];
+      interrupts = <33>, <34>, <35>,<36>;
+      clocks = <&psc1 5>;
+      power-domains = <&psc1 5>;
+      status = "disabled";
+    };
+
-- 
2.43.0


