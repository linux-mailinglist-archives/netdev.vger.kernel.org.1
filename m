Return-Path: <netdev+bounces-201682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D74EAEA8C1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDE01C4498B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212B26F477;
	Thu, 26 Jun 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBt/3o0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA702673BA;
	Thu, 26 Jun 2025 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973041; cv=none; b=B7JG4bnZ4cF1RtHPa60vjGXDkaHVLxeMyiCv9CoV5CzBiIN3O0KA/4vXP0dP8YLatzpMAo/BIT6t7vNNCIPxlfZzA9xSOB+yPVpe70l2KrU++Yq8yDJRWNJOjbYESy/tHCGiTdttFj3E5pzeME27d0LgquPXHxboGZt7hjjhl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973041; c=relaxed/simple;
	bh=+pieVBMn7QfjdokldPhNPVxrqCi619G+B46duDbn4f0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb31NY+KGJYOr25kMU0YwRuCLTzt/6pRPRSmUXtLeWwSFW09PfzCtbQk3DBElGL0gjid1mCvOfwbRBB4w5F/qK1bjwgPCBTkYUi7PWXGBWM29uGYG0MXveloE3SAEZP8NYhlZY4fSxuuqFurMj5c44W/C3h4iPNqkR2M4NGzOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBt/3o0Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45348bff79fso15203275e9.2;
        Thu, 26 Jun 2025 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973038; x=1751577838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMfOxJ+ivVKCbrvfLFliBdEaPDrw2fQxzA5hHL8RHBE=;
        b=HBt/3o0ZBd0+AVwIr93u2/U8ZwVBB4M9GHDRbBkdoFtnoxbVewGKgeDsKXLKkbyII0
         duHP5WG8m7twhIRBvbsn+IYgh7pfnHlFwB/4kyHnC5qeSgC5KrODq462vBDAJUmpX/V0
         h9Ua59E2cYC7EXKuvD8pEouELydwPnfs2N7tNG3MqF3e469a+8PvUwGEGO3aFtXi5l9N
         EcpXkS8sxxZtk/rQlXECaWHMk1JCD1YzBALT4e2lciO5K2YGD6YMb+pnE1K/oTm+GvNA
         7sn1qkohb/I0sTo94jPbBB9RQRzq2pKXbfIDbQIO//I6266ee+KMgCuFFHmCSz+PtAkg
         5WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973038; x=1751577838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMfOxJ+ivVKCbrvfLFliBdEaPDrw2fQxzA5hHL8RHBE=;
        b=LrD3Bq0BQ79DHaSvDOAf+LeXjUtvpGfsSFWb4+txOkyvxf8EDEOL4H3WuOFwaIEjUa
         mM/8Sw8dLUry/qmyJz9FuAHOakkYwu+vfx4v3EcuXosCatsGT5aO10eg3N01N6v0LyNu
         /h3TWH5sCwjIPD0HGEHAxzmsaf8vwETLB3XuBrLLPO0W7vkYYa7Tiw/eZVfYK4I5KHvF
         D0xiS8w3l9ElazRPF725wqb/S5wDTdnJtL5CYosYlq8A753i2GXuF+NWQDb+STYFy7Rj
         K+V9GU4wU0nD8dQlruX2sa8/Q80FKu3aRFlKWQFDp8EGAL4Y0hkso0nYpHa1BCLt3jwf
         9FAw==
X-Forwarded-Encrypted: i=1; AJvYcCVa8/BsQ/7/MitgbuOqA3J5os7KSDNghnjJlhAbjFHGgy4uwnQpJCnV2B1zJsgQYm/Pf+NwGe0K@vger.kernel.org, AJvYcCVwSxOaVehwBHlZxM7ZgEieZnuWMvLozFS6NMmnaqLE8BC6zEzh5s07eOy3HU2LN+a9s/fOHRqObJPg@vger.kernel.org, AJvYcCXU1KZY0287s/TOQ4qfaZnUuvTsv6DhEMrVYqlqc6P2mTyXBY6At4td0LslS87YpdjkXgo//wZNTtxX8nos@vger.kernel.org
X-Gm-Message-State: AOJu0YzRRfmBw6pF8qai/EwfIgESbtafgIDGPvqIKLcFCO0fqNCpmeM5
	VpMQiPai8x4OjPfylYEwBOvZFLGgBm03vnARNonZL0mGvvNZqONxcjyskhddHQ==
X-Gm-Gg: ASbGncs4OQrTWi19rT8NYQDglfjxoUkwczzrn0w290gp0OFR8DuxYtH7aVooZbOtcrw
	XnBNC6ekjY9E1NAU+m1tLdluPr8I+DRVIzZiNhTVi8ZdTCHzPGFYwB40IAOlRgBY/ZykuDCXiat
	2NO/G/zQ4qaFWrUdyBUQc/V3ntPA0Q454BbxIVJL+CIQYvs9YR3cGCw5CwZ6Ot2FAMtH5zz3RYQ
	S34/o1j3aGHN4s0bhF0uyHa3TJqEn5IzPZ3LR47gJW82c2atYCfltyddkefJODPTjHCD7qlDFU4
	fVJlOs8/8+P8aAgHKi5LTSJoyP6n0KfpzitR8vaLnUY+pPro4EecM40dKGDlV2nwDl8nbgcrV7w
	1jSNAf9DQlb60VCHzQBRYLdcLNrdyRTg=
X-Google-Smtp-Source: AGHT+IGhiPIiYSVT+g62FYh7vURDOXyt91H1CCIt26M2s6cmJxn56lND29qLfLVxj+JI6H8LgREtuQ==
X-Received: by 2002:a05:600c:5249:b0:450:cfe1:a827 with SMTP id 5b1f17b1804b1-4538ee95284mr10310995e9.31.1750973037935;
        Thu, 26 Jun 2025 14:23:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:23:57 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v15 04/12] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Thu, 26 Jun 2025 23:23:03 +0200
Message-ID: <20250626212321.28114-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
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


