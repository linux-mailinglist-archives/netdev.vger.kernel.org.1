Return-Path: <netdev+bounces-175061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA37A62F72
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FF73B97EC
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8D205ABB;
	Sat, 15 Mar 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhQIXQPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319C204F6A;
	Sat, 15 Mar 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053489; cv=none; b=D+4KgVL87Izncppz8NQMz6nvd23TPtSnJNfxYiy2hscsRHciqUHRdDQHGCpTNM+HBSzszy3fqEaLGRDXnYFXiHr9Fk/Pd5TD3bxqZ9+cU1FaA5o6I0OKxf7nug+H6GMN884a3qfvaFgRvUl8MC0hmF3dBlA3VCi1mseghWfmFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053489; c=relaxed/simple;
	bh=8dsRuLd0LysJEgpsjxxs6MsuytnmpN1lRPgtZV4EjX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCo/QZ3EWYkGa1ImjBulhKV+5+eE+Y1G0/xLACPXwGcczZjfuU+9b1cXMi/nG9GNrVH2ezYWl5G7Jf6Xrhczea0geQff2pTKINHu/5emOKV8yocUbLiSTVp5p16t2voNs9fptPB0H2s7U8t+0OzIJYY18RziDoSboDwoxdRLWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhQIXQPo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0a5cfd7dso4746765e9.1;
        Sat, 15 Mar 2025 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053485; x=1742658285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOSxaiCNgkguMhmOsgtIM1pXf1qRsgQMSyGwNzCSHvc=;
        b=LhQIXQPoP9u0BLY2hFex9ix9+QUayQFqXDCKgQNLNy6VGrTPTAD5SWU54SQzzHGTbu
         Xz0yIJ4Cw9u4etWPFwdp2UyP9JbaHh609X7AyHWTaYun/W353iS7xSmj5uYVtQTJ2X/8
         /kU0biXMqjRIndto7FP0Idw3DQPaE/U3KoB6uHP1gRwbOhlkT5YJaxYhwjU/+J7CLUb1
         F7KCCNJlaNxTuZLeWJVGdV9SVEh4IH2Dd4smdld9beLEuCbjTqt5rfePbmXGqOkTzEaV
         P//DbHh70gR9uWN8OQS0BlXUd6p8XxGkfahZrQIvr95YzPTPQ1ZtmEfpekuvKMeqQEKo
         diQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053485; x=1742658285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOSxaiCNgkguMhmOsgtIM1pXf1qRsgQMSyGwNzCSHvc=;
        b=KM7oGXFQH3k1Q62gWI55ypSnV27ZdHcWYqOKsn5Sw06aNiMOfCn5U7H+IRy6haiOkE
         wXg7G3cu7p2nOfNDI3zi8zFma1AuBqsJ0ifc6s+sU4NCDToAyEQr0Br29KUb3z++rmyV
         CqvNRzbjwygNnnaUDmCtRPd0JPznWpk4e76yKgzVLeGasYQXAFMNjPEQXhHbzAWH5wHd
         PVh++ZZ37upWipFXv6+HQuhJh5Ow+URiuCRoXmHBfIzd73opZ1jNIR2+00p9JVEjI8bA
         HPSvNPsKHHWda/gRhAGBTqZHz9vfYXPdpZw6YlN9GzH4Bmt4LQXYTgANcTOZ6n6rBjJ5
         jRjw==
X-Forwarded-Encrypted: i=1; AJvYcCUu0AfXciSXGqu8wlxB9NWaq32TwDllC7o9vYJ7AZLN1/iTM7U7lQC1JWeNSQaONvsa0y/qDeV2lNV8@vger.kernel.org, AJvYcCVnDgr1o3oNbd5R0dgKc0an/RFfCr0OIn9pjU74bmdUxL0K2epFUFN5BhNoeP2kNNxaZe7MXMdD@vger.kernel.org, AJvYcCWPqu/87/LZMPpKqXIn8CIVwOs6UFtI2az8FnU4+GoFi9IjIWhCRnZVkQzIn98q+F78j086xGtI8yOPbXij@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ij2PQfMb8npLoF5MpxrA8ghdUBVvJEBVJO5pUzU04OGa42SX
	5fdYyzgpddtHrxDIpUzI+WuoXYvDAafrh3eBhBISWtCxdUM+KVyB
X-Gm-Gg: ASbGncsW+ghQs52rgiq10uOaFy1pnaYYATXkuSDjrKRcC3OMgwac2uCiBE4Pa2cB8LO
	uP3OBf9vBrl3TEepSdQWL2PEOC6hUxVxGV5PApGRWlbl8GlvkhxewCxmyH2M6rU2W/C+trPELDA
	IqrU4v6V82TypMesh+3Spqiczn0gYtisR4+15N8iXI0oVjhm32fbkdcM6m6DUEVsXBqG28lgJtJ
	5vRjIhQfhl+BhToZpuCFxwo9WtmM1TCp+ISrKHwqpPdgnc6A2MDO9WkviFDb1ar3s89rMw7uIIR
	xDUKmL++09NAQpO9zW9dIO/e2RJTCLLkvwt8qLC6GiT5s5WdpTbodKSlfnXNGY0bOCROviZzOUW
	01xeu+PKIHvxQOA==
X-Google-Smtp-Source: AGHT+IGsWcjc1hDGEO8cxnzByykp8hNWR+gBAlcKe4nhtYmqVcy+n+X4aKOrFdK8VFw4PIbyBeMzjQ==
X-Received: by 2002:a05:600c:4f0d:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-43d1ec71e13mr74675115e9.8.1742053485345;
        Sat, 15 Mar 2025 08:44:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:45 -0700 (PDT)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 04/14] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Sat, 15 Mar 2025 16:43:44 +0100
Message-ID: <20250315154407.26304-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
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
---
 .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 84 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 696ad8465ea8..45f4bb8deb0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,6 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
-- 
2.48.1


