Return-Path: <netdev+bounces-180124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8445A7FA68
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0947A9F30
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C526771B;
	Tue,  8 Apr 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI6obIRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5026658E;
	Tue,  8 Apr 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105942; cv=none; b=eYoxNZE7q7z5/Ch8muQlqX28/xxg9MY/i8jeJZ4rmQltUdZ16hfosOxR8t5FhIxu5r7+5kxxhWyXMlnjRpR4N85hKmsHp7NHU+qZbhBlBd8/4TDJ0ZQG9Joov1jPbVsx/ft2hG0WHlGpRpmOp5YAtLoKgGN6MmdW0WQqNvmG59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105942; c=relaxed/simple;
	bh=+pieVBMn7QfjdokldPhNPVxrqCi619G+B46duDbn4f0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTGoRZK3CLyd+uInyoMQthKPzOm781wmD9Y2+wBvVCD+ca2Sq+yH+sDmOshn1Frpz9gcEq/tvcCpQg1NFVrRr5+lPDO2I04yKgTgokwQ5lfbEtn9cZKb9JuykT/zH7YIc3JDgAu1/ZKm/r25bivG3i+/QzibTLsRIivfymP+Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI6obIRN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so3278862f8f.0;
        Tue, 08 Apr 2025 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105937; x=1744710737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMfOxJ+ivVKCbrvfLFliBdEaPDrw2fQxzA5hHL8RHBE=;
        b=PI6obIRNIVmJmjqWbfbkhNUMqVT9WXchW9bOXwtgdXIvgUiaPcHgMvt5q1kwoLcJ3Y
         G/0Xgvk4ctv19XkBsXK9boD6AZYYIpkN/uGVdbbw801W5HlxcOtRIe9mz8xJLSXyeyRo
         sYc4kJLrgMHVlLThRGr5LW9SF1zPsnVb9X8lHTz6FrQVCrZ28F9yShVVAFE6KyOrOEoi
         1DbMG+Ijd6D9VJNtZ6YtxbRn19isbeo12DY6xQyYlT/oHG/8Sr+cMp2uvoPX9HSW6fY9
         ydKs+aay87OD6uucpilKjyb3j3WRsNZ7ecFYAzunqVbZnhWcOvGXEzJI8JPRGQHgStKu
         /ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105937; x=1744710737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMfOxJ+ivVKCbrvfLFliBdEaPDrw2fQxzA5hHL8RHBE=;
        b=ZUJFetFPq9ed/tZ3sVwG5wGIKonUj8PyrqyIlFyaCogwdJ7yLhtyJztM3UqD+/W07k
         p61V+N4NG0JoKAkFY4fNLnhgejXTMzH3G++3/hUVqbPBNt6c+ZWYhikf5+DuruayCFFO
         F6flRgJ2le/vpIUF9TGVF98ar/cVqlLAohYtaLTg2xlGtNf3FwHONJXntE5Yr6OwedkL
         aTV8tyUoySUHUaT44ZUbZrWhbJyFCK2sdCaQpg7S+qPo9Q3ZPorPQDTxTsu03N6gnw2x
         365JRfPl4E7UVNOsw9kwqJ3V055Ezc9tevs4/8T6ecAh6v2wv+LcfXcou6g6mnlP5SUy
         cJvA==
X-Forwarded-Encrypted: i=1; AJvYcCVifPlMl3wqjRj6RpOkzD94CrgFnfF7Nv6jCEN0M7+TlhzQQcRGaZnPzkcwoIjeM3odsmusttiq+AKq2/U1@vger.kernel.org, AJvYcCXoeq27ZoaMAhNcrrRvBQ+ucicWDkDv1NnCLXgbsHYFmnCcBK8LqJowB7a27KTOfMfH0RFicclj@vger.kernel.org, AJvYcCXvTBlq6LtR8IMm4hrRHTNDwgVvmYCx0dDHAMoPps6pSJCUWabMhdPokRIBp8CB3k0WxULA6L57ijVv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+j99zw8Gb0dj7bb8A/NB/xgPsl+tL45CY9zVmdtt1Y1A5OKV
	pLy4ziCwPo+qQFzCohbeUVo2RoYEaPzgl+ha4D4XezDgPJ0OVtCj
X-Gm-Gg: ASbGncsyQG21IKVmMiSrvCK6oR/zo6c0PYuuE3gH902B6VWVDANkmTY39n1BNhLD1qg
	B9OG9NCJm5MgZbwvWvajtxaV7BZBDpieL6qK1zatM4TZ41rxrh9dXtBc4ROzmC6HTfy5JLSExpy
	iza+ztxFN4dxqL/DtlsCWrx/fZRQ5cwpsqrwhHpm0A1UqirZRI24U/0xymN80Lez8EF/97oa9ay
	vqVUX2Iu3Qq8JjjOV8FjHaq7FnKgR7gINwca1QpSvUmkpFoYcvuNzmBr/WKwgPUMr3EfyHau47f
	uIaGQCVIcYkcyfE4O1LNvKEGBLRkwuLzenWT2kLJ1gi76JzC5Pl45/tSmKcsXbrhlvyre7ZfVyd
	E5SULyGVDT6yEAg==
X-Google-Smtp-Source: AGHT+IEXwpGN30PUlfHaaWGCiZEymBLvKdCoOgEM1azp0/BEOQhn10oJuQ7dwscnj+583gxofkLISQ==
X-Received: by 2002:a5d:64cd:0:b0:391:2f15:c1f4 with SMTP id ffacd0b85a97d-39cba93d7e4mr13535785f8f.55.1744105937328;
        Tue, 08 Apr 2025 02:52:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:17 -0700 (PDT)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 04/16] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Tue,  8 Apr 2025 11:51:11 +0200
Message-ID: <20250408095139.51659-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
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
2.48.1


