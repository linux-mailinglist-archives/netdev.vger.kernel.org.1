Return-Path: <netdev+bounces-193758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2FAC5C3D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B47F3B50C5
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D50213E89;
	Tue, 27 May 2025 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLNDKE9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63C12B93;
	Tue, 27 May 2025 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381734; cv=none; b=d3kdR0YSJq0qsNZFP/OExhz2Mn/sr0oAN1PtEUHgECK5Bt9TwuR27Sl7vIHWYldrD1bFjJ8PqOCULjdsRM9SNL/hz6G82xV88wMvnEl+CYKfDWpQf5ZAHdH3EdqnuB1FwYdtwz3Ust/7gSAeTuEB28lHzSPZ1UQAMd0bwV3cPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381734; c=relaxed/simple;
	bh=Z7Bl/YNaGSfvAgSx3PTLMkr8IM9olOBYAL6p1ul+YOs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HeIDx9+w+cyHt0bXLY/7PP6wnuHDEdkOjLUPsjb7qPupsUy63VLx74pE8okvnLQrbm0DVWNPZlgF3PDkmzK+P7QOa1XZMICoSTnIrib+DIc34pm1ipxO/26rNtKoq1izW3zedCHdmoMBygC8xfBAhQDlMxuAkfedF8dyjCDWdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLNDKE9u; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4c95fc276so2135557f8f.3;
        Tue, 27 May 2025 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381731; x=1748986531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Arg/9Cw6SGE8N326LAp3C57EtyZUmN4Wr4OqxUcOTAg=;
        b=JLNDKE9udHm8toTvfrXJJpblmOzK0QSWcyDziizs6XLwFbM2fGed018dm/fA9GVtbz
         /JApxcbVFw2XSpbUv7Dxa3+byn1dA/5UcqNTt5I5lfF3hyejJiuh/KhfPXb3L5JMkVJk
         c8w1Lm7ds15nDZvqwr1e9rKGjx00wrG3ziI20zrEGJwXZoSv9xil5Qtpf2Ea4oKzvE8a
         LaXLqkyo0TZxQX3DbM5IKVytRGtSYL3EAG5cC/QkuDnTsvSNZM14wRD9l2LoGpp8aBIR
         oWEneJ50FTXGEHywJDHQ7KJPd3dI1bP5JoDddTT9Rs89HGQ1exboH4gQ8ask9U2+K5r+
         5WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381731; x=1748986531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Arg/9Cw6SGE8N326LAp3C57EtyZUmN4Wr4OqxUcOTAg=;
        b=FKkH3MWmPfDi4E3oAXJfofAX+CmX3tX5qs+o3f7VWQmFLI56g4A/bzve4enlUZqum+
         GGpzsmcwkWGf2p4ui5kOXb3OMYz6Lqa5l3AMiLGwlIHf7nQlqdbcY+thozZWWTOWRepX
         bkq01yHXy0LKcbV8uQZvIjCw5SLup9fNih5T3zcItTNX9YzOFe0yRExEl7BvJ0zn3Xno
         BAw7l83M1uh3WUy3zyru6R2r8PnixOtzKPvcTyGlOot0DRSqDNML9rwhS1PbpQzi/VRS
         wMbK6BKKtPpU1urKJR+msT3YwlC4Vz2u+AtpKrhJKI9GKsR2Px6Nmgilnhc7Q9sXOco5
         ZS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8fkspd+W4Q0XQ6k4pkKqBm2wQLTV3GQYjYpV3SH05OqcI3wKv80y8BYjaIuTBUGKTosl0kvI4@vger.kernel.org, AJvYcCUOW5JIK/rSYpbms3xUXhB9feIUhnNINQYB23XDaEeIhiQbhNG2dmgX1VQeEGAtgjGndXj82xj2DhYr@vger.kernel.org, AJvYcCUn/9gXjpBHGHTRHS6wrwmNPrsfxDktKrWhZcXXqhcRQYPTFcJHISjzlKxh7Zp1MDWjFVQCoNJdKjDOwURP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xUVdA71bwruN7YO7WC1ZR99vzCimnbvYL2o1FzeP2UQUHifS
	ZIt4JKIuimhtKhaBI7htqgTmtzByDle/0ONf4SNT8LINuqly29vgBZGgegioxg==
X-Gm-Gg: ASbGncurZA0+JxbvyM8XptxB/aZZSEkYlD2fERWQ6YNVjhEsNvJc7VbVTruikZgOu94
	+P3rzIa3vBEXTEKpdOd46B5olS4yoA6tnBdzYSPK/iTxonx7s8l2wSTXtaCAcSRTycRc1ntk2qF
	4v7orEPf/NRnA+LNl4O7Lv/adVDQ9cjpvJrYiWLmZZWjc82vWh8WRYhQTBuFcm6lVbbzdBQhWgT
	pMl6pBW1kWo1qIuZjQhQy/ez+493gKUJQY8qjr9tx+ZTY7yS1oCb9Z8WgzTtRJPlZ1nlL3rrrKy
	1+oNIB/Z8K4pz3SfbcGBpVD9NkCf2y5GbtNziMpxu8VJkEefilFVTwSLDZeuT7mwIn6WCNF10Sp
	3gfiKIiaCw1i5zAenCgRL
X-Google-Smtp-Source: AGHT+IGhQHQqaj95E6fuBpFOajcotVNDs1UVszp9NIpRNs8lvcg7mtrkmIkOtdwGtHQUX4n9xF3rpw==
X-Received: by 2002:a05:6000:2888:b0:3a4:dff9:e6aa with SMTP id ffacd0b85a97d-3a4dff9e824mr4175946f8f.55.1748381730491;
        Tue, 27 May 2025 14:35:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b9a7adsm165671f8f.57.2025.05.27.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:35:29 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 1/2] dt-bindings: net: Document support for Airoha AN7583 MDIO Controller
Date: Tue, 27 May 2025 23:34:42 +0200
Message-ID: <20250527213503.12010-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha AN7583 SoC have 3 different MDIO Controller. One comes from
the intergated Switch based on MT7530. The other 2 live under the SCU
register and expose 2 dedicated MDIO controller.

Document the schema that expose the 2 dedicated MDIO controller.
Each MDIO controller can be independently reset with the SoC reset line.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/airoha,an7583-mdio.yaml      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
new file mode 100644
index 000000000000..2375f1bf85a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an7583-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN7583 Dedicated MDIO Controller
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN7583 SoC have 3 different MDIO Controller.
+
+  One comes from the intergated Switch based on MT7530.
+
+  The other 2 (that this schema describe) live under the SCU
+  register supporting both C22 and C45 PHYs.
+
+properties:
+  compatible:
+    const: airoha,an7583-mdio
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  '^mdio(-(bus|external))@[0-1]$':
+    type: object
+
+    $ref: mdio.yaml#
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+      resets:
+        maxItems: 1
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mdio-controller {
+        compatible = "airoha,an7583-mdio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mdio-bus@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@1f {
+                reg = <31>;
+            };
+        };
+
+        mdio-bus@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
-- 
2.48.1


