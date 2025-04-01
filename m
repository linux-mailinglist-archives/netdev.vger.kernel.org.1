Return-Path: <netdev+bounces-178576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA4A77A02
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B731189002D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266CD2045AC;
	Tue,  1 Apr 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewBH0D1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F38204098;
	Tue,  1 Apr 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508019; cv=none; b=fBXyo6Ksvrb/vx2ZxV7hj3D1nJSeVu+6rbQjbd1v0dkvxq2D2k9h7Gl6EfIidExD43DULuSUJZco9CmufCa/SpCwkeGhE0FT7RPqdq4Xkv9f9gmQNUB19veENOMEN4nsLWjTZn3EcBdX9nFNt6ETUFH4oh/8mo6jsIZvAPcgzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508019; c=relaxed/simple;
	bh=4THuh4l2cNhIbqy6HlF/J7Hc+TBYJG/XLk/3DEKuZfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+z2761lW9aTAJ7bCbBvQYDi1yaMoY/WvWsxLlr3xmR1xijH/PTcTNvQI+j80C1ilVVhuwRiOXXUBJAZrEBLvsAS6gUM5lIxFehhUhrH8Lh+OCZThrXK48Gu6CDMv82otNbgAtyn2rZ5Y4LKaXDE8U0UVjKoUFOh7mZhOPMbKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewBH0D1y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso24931165e9.3;
        Tue, 01 Apr 2025 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743508014; x=1744112814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XrhBUQXr1bVfeeEaE7z+isBFAKnFsoBJygdtgcyNsY=;
        b=ewBH0D1yOLtVc7ULAh5fwUBFzWVbixVbkBq9vbUFCuDU6+NnVUiWhiHTrngGvYAQi1
         Wu1KbikOY2zeX1n+kUF4nrQNhjl7ZxtCnHeHCBlCs7RZ7GGdKehmKhIXpENBaML4haTT
         v7Fh1fZkyvhj0SWrAfZt5kiYAgAaMYoAWOICCl6kGDKP3kynompF9Da2CNJ1k1Ib8JZ3
         /nXDs0ehmqtUcuxjUrtPhJ0LDxzooNzjqh2m9Qs0rvuQ2B5KEzClt+0pQ94eAV2H3z5s
         jFxQ77PsZ/dKJhgDZXIjngCqWsFa9lZ+Zdmv+7t8q6B8F2RxGk+Y9FGwWt4zy3SDdDbL
         CM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508014; x=1744112814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XrhBUQXr1bVfeeEaE7z+isBFAKnFsoBJygdtgcyNsY=;
        b=hpJPLwk+GJcYVha3+RTul76XDy0zVNBzSo67AXWAxjyvicBuxFRd/WHMjS/XSj0OM9
         NZw83SXTOf8h1l8JdicIK2y5FmhqxDng+QJNEvpxtgbhG70AivQ4+W3lsjYGai9W+2Uz
         IW/uV5d+zh9C4aAZSQYOF0u88vpksCVLxAtQMLDDH0etuf4B7JqNGGvA3wVD7wx2kRqM
         Avol91dQqD6aPNo6BtC6j2srNifijVY/gI/ulKPZq/ZlcneTOQ7LinNDQbsFWOFP+Zw8
         yjRnDOFzvTdEm4Tgn4nKwd/19gL/gucSzdwukubWNzfPfcSz0+DASYa3WaHcBm2wyjOM
         1xYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbpi0O4OeiORhSSngd8Xzd08yy1cMkeeb+1qZl2qW5mrkdX2fObCHKLSDk03hgfRpnQaDvlYZfSIQi@vger.kernel.org, AJvYcCVD4nZisD+S5plZqGzgFDhPMnMmqgDofQUgMfwdszxRm3CMIbR8jwC1z9pj8FcbTqt8RJ702wZk@vger.kernel.org, AJvYcCVrEXXaNYGVrv81s7LfKdiZRjxeJuYoT7R3jydDP+E8icOIEiurOq+Odz92pAORLN6dGNgVWDj0icQuRZjp@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAJyomOovqLEiP2lwFixQ8aecpekAMnkxSRURmqdVVqzSuSkx
	LmWcu2A8Xlcew4ALv8eFRsa/z+ep0mKGHKyvCdVjIe7FNnnRoPHa
X-Gm-Gg: ASbGnctjvCc9W/OATk4elH+X1YeiJNe+vDvKJT3L6/FNizHFS8MQoOFFN1QkGNtmESd
	8/xrxdo+JWww+aQ5g1dMKG40+gN5fTuoDmdGqjdqNivanjvCkO1B8/ITG1OVAFNakFzAySN+YFg
	bv8zLPrtViQev6149VBlY62YbkFoB397cgj0n9fkDPaD2f2ux+DXTWdnFSgEyTp2V8ICJWLWzX7
	2aGMsfPwnpO0Rd83dZNZcRUBO43s551L4CyN92QHE+oNxL/iy+D1klEjstyTj9KGoCZ0NPRSQr0
	VoRotv/XfKjoj95yK7YkBwrtXc3clouMnVCFMUhraUK35WFlpGkcuM1MLKEbdsU9c+ThIoQ8vBu
	bkW6/S2GzmWtUITxVZ5AK97dZ
X-Google-Smtp-Source: AGHT+IH6dilQJLlHGgeFR3Ax8B3Ld3g5aXQaayD1pRKUbQJUZ4aGA9CVqtKPy6UCRne+8g3E6M/oRw==
X-Received: by 2002:a05:600c:1f89:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-43db61fed40mr104748755e9.13.1743508014190;
        Tue, 01 Apr 2025 04:46:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ead679894sm8148175e9.40.2025.04.01.04.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:46:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v5 6/6] dt-bindings: net: Document support for Aeonsemi PHYs
Date: Tue,  1 Apr 2025 13:46:07 +0200
Message-ID: <20250401114611.4063-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401114611.4063-1-ansuelsmth@gmail.com>
References: <20250401114611.4063-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aeonsemi PHYs and the requirement of a firmware to correctly work.
Also document the max number of LEDs supported and what PHY ID expose
when no firmware is loaded.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x9410 on C45
registers before the firmware is loaded.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/aeonsemi,as21xxx.yaml        | 122 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml

diff --git a/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
new file mode 100644
index 000000000000..69eb29dc4d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/aeonsemi,as21xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aeonsemi AS21XXX Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Aeonsemi AS21xxx Ethernet PHYs requires a firmware to be loaded to actually
+  work. The same firmware is compatible with various PHYs of the same family.
+
+  A PHY with not firmware loaded will be exposed on the MDIO bus with ID
+  0x7500 0x7500 or 0x7500 0x9410 on C45 registers.
+
+  This can be done and is implemented by OEM in 2 different way:
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  Each PHY can support up to 5 LEDs.
+
+  AS2xxx PHY Name logic:
+
+  AS21x1xxB1
+      ^ ^^
+      | |J: Supports SyncE/PTP
+      | |P: No SyncE/PTP support
+      | 1: Supports 2nd Serdes
+      | 2: Not 2nd Serdes support
+      0: 10G, 5G, 2.5G
+      5: 5G, 2.5G
+      2: 2.5G
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id7500.9410
+          - ethernet-phy-id7500.9402
+          - ethernet-phy-id7500.9412
+          - ethernet-phy-id7500.9422
+          - ethernet-phy-id7500.9432
+          - ethernet-phy-id7500.9442
+          - ethernet-phy-id7500.9452
+          - ethernet-phy-id7500.9462
+          - ethernet-phy-id7500.9472
+          - ethernet-phy-id7500.9482
+          - ethernet-phy-id7500.9492
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-id7500.9410
+then:
+  required:
+    - firmware-name
+else:
+  properties:
+    firmware-name: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1f {
+            compatible = "ethernet-phy-id7500.9410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <31>;
+            firmware-name = "as21x1x_fw.bin";
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <0>;
+                    default-state = "keep";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 53ca93b0cc18..310530649a48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -650,6 +650,7 @@ AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 F:	drivers/net/phy/as21xxx.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
-- 
2.48.1


