Return-Path: <netdev+bounces-222140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF6B533FE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C516587DDA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A60A335BAC;
	Thu, 11 Sep 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGJ1bk2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692832ED49;
	Thu, 11 Sep 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598007; cv=none; b=mGdsI3u0+U1WyE4OSsgPyF43TKYq5FSYza5SpcQKMi41Ra0cQp5PurMtff5JW9362iAGJ31vn+XNVBehRH63lQGk3aEzMJNgUaxYglvn2y+G0AjhT5H+bCsa1RzPYHklh2ZGUDDc0jRZANwQn+jn0vIAmi4NhfcHWVaKWLNllRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598007; c=relaxed/simple;
	bh=MZ6PxAvurXG1uH1QIJpzbJ63J+I3jr0ROI56K6VM/XA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+ub/OUT+B5Ce3PW6TVaE5bd/OxT2NeNnmaUeANm3bdqtpQXcFstGHFfvsXkHcKCNw1bPNfBqKcGDRB3US3VAJ1TiFn9eCQ05rEMZIAtgbDTV1T8rjSMzQqr41UJ0S6Wrkfo9AKI0oVunzTEjEZ77iO9GNmV7HVgiDbn6c3aSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGJ1bk2H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so6744245e9.3;
        Thu, 11 Sep 2025 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598004; x=1758202804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=QGJ1bk2HFw5+2mtGYen0jiMsmcqCmhpSs2wLkJkWSUz6FyefemVHd2EIbmnkv0xUUr
         Vh8r5L0COR0Zlk1hLKRduLttL+IW/HwpHhFAIw5qmQeeG/VNRSR9pqYkqLcgb6bXVIwX
         NqDMGZUDN/DZ40upc7KAdKem4ZzDjdt04oxFhfuitEZBixSt9h5tlga+8qeGmNryLsT9
         e9NpvAqIxr28wKW7HLV6XnixTKTD4hRwOtIcV2e8F/TSgotKC3VSTKWxZY+AGogN5LP5
         JvkvtSdCpxUTjjIqMNu4y634PqgQPk0SN/X7Guy1M/3ooIWtlyl8KbRA6HHu4D7C2oi3
         t45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598004; x=1758202804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=lNwulRlTjy9XDZDJle5SSqv3N33TOblK6x2zi6dRZeXGSlWHkR1NbEFHsjAaOr3TmS
         xr3icyH/6OlKdeTc4UtC2OeWhxaHaSQ5INRG0jisEQpBR6//iIvNKetzBiXamvNkIzmT
         f9NHHBfzSGqfZJpgYFS1Or7hTTLdyqDgVJ0CAYCifKIl+XNvGAvJfhwOG7T6klijQR2m
         zldU1JDLj2pk8CwzQ8T6NTkKn4srBgmNrWEIu8EzPN+f+tzZaKV+BrENiaCs4zI7xfB7
         TLZkXTWxmj0d7CxWnO89mpU744o6EKJ9igmtkjipMjgiWfCnPSZpW4e4yAsBhvMjwCdP
         yakQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcgeaVssmxCvGWw8d3nb18MNiq374ATc9rYgGd0bn3UOlAWnrNmkboTLg2Yaw7t37Wt5DRmGXL4O0v/Gn@vger.kernel.org, AJvYcCV7ZNuUDQyN8LiDCYi9EqNzgfkZKQBAUZaj0Olmp0y1FgCMffLyqx+BhD16aGXhp9sKTwQLT1Jb@vger.kernel.org, AJvYcCXU4uRNuBniONMno9O0UcCP52tJa4DQzwqP9C3wBw4DmHzRDu/XlHgCayK85o3qoDG605QoGGs5bmFy@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcrqB8hwBBuhNyeMBBrSQWGmVkpJTt6yFL1d7GtR+0Ry3myKI
	eF8YlFyZyZr4YqaVsHwbrydoj3dLBE1w0z5Min720KI2wWmrczKUEKFo
X-Gm-Gg: ASbGnctOM9y1pY+fZY9CtSWzI6kq7e3TXwcTHWTshXUAs9+gWnjfA0j/qyv61BqGBYI
	6C9nRHXLt+2lL7gMKFIa5uyA9O/7m2BN1h82O4YuHLfMNE1uTzeDfzEIY93zfIrHbin+9WS8Kao
	fyAXvKmIqs1AoDDtDMvKtStnyktPEh8n47KcRILupxGTnRDZuPwJJXGAJSrE4SdhxCYxrejBlqV
	Ta1WWpvM8eDoJNYKEu/hvjii39Wkq4WMKNVkX5cyibR5Hq7gKQ+dRMYFQZKRxm1RZszyawh6TzL
	stXlZOQOGjerUdJwxdm25fHnKXMP/xswvjzO/7seM028ECjKO0JwqVKDu2vPaZZd9B38GkkuLpN
	nFD46iX1P1xh/5TQHIMYafIcH8S/5XYhw3kzLJ4EzxNGNgGousisXcNgZvSspqItNS7oWbHGu8O
	S/To+e2g==
X-Google-Smtp-Source: AGHT+IEQnbZAkH72KbH1sWGy7Aob16nrc/vZyq1pJwWibaA0QKysjGacWDJPdgyCWOflwP6r6uEoFA==
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id 5b1f17b1804b1-45dddef7fdamr162292265e9.31.1757598003714;
        Thu, 11 Sep 2025 06:40:03 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:40:03 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v17 2/8] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Thu, 11 Sep 2025 15:39:17 +0200
Message-ID: <20250911133929.30874-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133929.30874-1-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for AN8855 Switch Internal PHY.

Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
PHYs on the MDIO bus.

Each PHY might need to be calibrated to correctly work with the
use of the eFUSE provided by the Switch SoC. This can be enabled by
defining in the PHY node the NVMEM cell properties.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
new file mode 100644
index 000000000000..d2f86116badf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch Internal PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
+  PHYs on the MDIO bus.
+
+  Each PHY might need to be calibrated to correctly work with the
+  use of the eFUSE provided by the Switch SoC.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-idc0ff.0410
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: phandle to SoC eFUSE tx_a
+      - description: phandle to SoC eFUSE tx_b
+      - description: phandle to SoC eFUSE tx_c
+      - description: phandle to SoC eFUSE tx_d
+
+  nvmem-cell-names:
+    items:
+      - const: tx_a
+      - const: tx_b
+      - const: tx_c
+      - const: tx_d
+
+required:
+  - compatible
+  - reg
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
+        };
+
+        ethernet-phy@2 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <2>;
+
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                          <&shift_sel_port0_tx_b>,
+                          <&shift_sel_port0_tx_c>,
+                          <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
-- 
2.51.0


