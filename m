Return-Path: <netdev+bounces-189461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B1AB236C
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607C71BC1F25
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7082475E3;
	Sat, 10 May 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKgsnFLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270424679C;
	Sat, 10 May 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872683; cv=none; b=u/zWptBVNCpv38veeB+8zzGqubaM/dn4bpafFd9JiptVBvjeJIlp3m606fveHIpWp94e0gx9+9NIZQd9EKP1K6joHIuBgQjrwWEKJLnTHQrSRffqrhtkuwmgfvfeifhZ2FVuDMNf+yMPGibllUaXu/FegLqy3BhriNebWLKrTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872683; c=relaxed/simple;
	bh=jFcXF/4dVf1e7vAXuyL5qekxKu5hoLO5I3j0YrY52CI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7jSBcGSq4rpJ4SnDpDyDuhcTfhdCpp79n//sHMxy88zwEwpPZTZxlhxzXxeYlsRLU/pja4hbF29DSnkcfmkONi907Nhx7P2dYKOE8U7R+13L3KNTLsjaB3tRKZmRLlfdy9QiIGyVXAnFSX1jhhaGB4zrOJJ7nnB+dcPEHJsBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKgsnFLm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso19561965e9.0;
        Sat, 10 May 2025 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872679; x=1747477479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cwoa6YEoLumzQE8cS+ad1dIlqWJKYevB3c6NtJXNM8U=;
        b=gKgsnFLmK8Kpl5teTFeUL9qgqmcdjPPQfmVmT0yi28T+EtxJr09nV9ZdKfiak+ZZC3
         QL1gdIfJ7Hxi0bKxk47m4qyp9dkQRdx9Da8+c2x4kwqaUsje4z6jMaRt2C8jy3SNEoGT
         9u2cADSXgmrDETtJ4If5dDdBY5TM04IPmFjC/tfWfzBlPQ+4enSEYcgh453WZJT/VAm7
         OoR1nxiQVi6AhMtNa/HeDbaNVgpmXpCx0SKi3p+mZsAx+DV9EJS09e0fpUl5HEonxGO0
         SEJp5funz0rIMPJO/VUcRo0zddcQRdwmfRASgQwSKiEIDjTyLv8JXeevKr9nHm/ZjVzv
         OIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872679; x=1747477479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwoa6YEoLumzQE8cS+ad1dIlqWJKYevB3c6NtJXNM8U=;
        b=IQ/Djsg9xdNla/YpcJBCYGj2iiU9VNjYM6epsLoHvcrDm5u5KZ/zxw6oU173A/ehsw
         LOAoDGRr9fINgVNlFqC9w2/O0712XzErymFY/4mdLOKCQmwdMa0/TSrzw/4dfUpfhoI9
         h2pXMszd4RfXhr3I7A336Dhp0HwkufEOXDvjyG2MNfZc4XKbNWdUGNPB+xI2UJp82bsO
         iG+6Auq2RQp17nPXF2W/9AjUyMGvR4HoxPVIvEYNHQOcg2k5SHHXH/qTSAxROJzrGfhj
         J8InmH5IG1u5Dm8mB3NuTPV4UHabj+Hyi9cTiQzNwNG8nXfP072G2utMBqwBNeFF9kCd
         WXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeNbz54hVDo5c1STE9/4zLUH2NHDkxH8SUoOIvfkOL1wFqy+yFe94fBU2TOx44WO4mrtFHZvLglVkRn1Z5@vger.kernel.org, AJvYcCVEwgCx+3tFcgkskY3vl6QWZcMzkiYKzb3N1+K2gqIAHQGQnSomu2exNjGh24TrA5HL99jGzKgr@vger.kernel.org, AJvYcCWkmC0z2+mW/Fk9SI43XvmHRnD2yYkrlhE0BsOjnI5Txo/OMQHY6XCF3ybxvsMtA5BBkEgypGDCNw0q@vger.kernel.org
X-Gm-Message-State: AOJu0YxBeMiErXM0myNjDqsqfQNkSQadUAh6i8XhUyayO9HaZxDEHB4l
	SOkgvBLrYdMDWsRPgBy9S7fsasRK4foDJkvOqCgvDASgcOJJKA/y
X-Gm-Gg: ASbGnctQ93StwABR3ImOQhp9vxH+5lmhyC1hsLupRXxhznYhM/xWVOu1C9kn4xNdDTR
	7bs7ZJw/aWLISWCq85zbnkVxHwbBaUSOBOoERwH2K8EcBofrTZdwtpXfsT4WrHlbBQZG0/p2hZG
	h4N8xaMuc8umyoKgD8kd8zPLd5xc1bk7ciZjo2+rF4TZX3+frdFGO0e1T8rBVe6F00x91RsQ2VX
	G9Tyx5GT8MQsDNmy84HAXkvm3NdQENZ2nlqILDSpGZ8/Q6PjBa1ws4rApz8+TZeTd2AD5KEwyAx
	vBALoZRwAfgR6uc5or/Yo0iA2edXCEabsb+K/a/f7uyHxCTElVOTg2T1cckydb4wCNqOsPW1WNe
	fhv5AIm2rM1AXV8Dt7lSd
X-Google-Smtp-Source: AGHT+IGCyd8ucVTH0Y5FJNtbVJ+m0AnBb3mLqX8BFfgIUed7kPLxXPVGj0x6GaLAbeJ2w658n+z87Q==
X-Received: by 2002:a05:600c:8708:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-442d6ddeb99mr64817685e9.31.1746872679266;
        Sat, 10 May 2025 03:24:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 10/11] dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
Date: Sat, 10 May 2025 12:23:30 +0200
Message-ID: <20250510102348.14134-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha Ethernet PCS for AN7581 SoC.

Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
the various Serdes port supporting different Media Independent Interface
(10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

This follow the new PCS provider with the use of #pcs-cells property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/pcs/airoha,pcs.yaml          | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
new file mode 100644
index 000000000000..8bcf7757c728
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Ethernet PCS and Serdes
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
+  the various Serdes port supporting different Media Independent Interface
+  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
+
+properties:
+  compatible:
+    enum:
+      - airoha,an7581-pcs-eth
+      - airoha,an7581-pcs-pon
+
+  reg:
+    items:
+      - description: XFI MAC reg
+      - description: HSGMII AN reg
+      - description: HSGMII PCS reg
+      - description: MULTI SGMII reg
+      - description: USXGMII reg
+      - description: HSGMII rate adaption reg
+      - description: XFI Analog register
+      - description: XFI PMA (Physical Medium Attachment) register
+
+  reg-names:
+    items:
+      - const: xfi_mac
+      - const: hsgmii_an
+      - const: hsgmii_pcs
+      - const: multi_sgmii
+      - const: usxgmii
+      - const: hsgmii_rate_adp
+      - const: xfi_ana
+      - const: xfi_pma
+
+  resets:
+    items:
+      - description: MAC reset
+      - description: PHY reset
+
+  reset-names:
+    items:
+      - const: mac
+      - const: phy
+
+  "#pcs-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+  - "#pcs-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/airoha,en7581-reset.h>
+
+    pcs@1fa08000 {
+        compatible = "airoha,an7581-pcs-pon";
+        reg = <0x1fa08000 0x1000>,
+              <0x1fa80000 0x60>,
+              <0x1fa80a00 0x164>,
+              <0x1fa84000 0x450>,
+              <0x1fa85900 0x338>,
+              <0x1fa86000 0x300>,
+              <0x1fa8a000 0x1000>,
+              <0x1fa8b000 0x1000>;
+        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+                    "multi_sgmii", "usxgmii",
+                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+        resets = <&scuclk EN7581_XPON_MAC_RST>,
+                 <&scuclk EN7581_XPON_PHY_RST>;
+        reset-names = "mac", "phy";
+
+        #pcs-cells = <0>;
+    };
+
+    pcs@1fa09000 {
+        compatible = "airoha,an7581-pcs-eth";
+        reg = <0x1fa09000 0x1000>,
+              <0x1fa70000 0x60>,
+              <0x1fa70a00 0x164>,
+              <0x1fa74000 0x450>,
+              <0x1fa75900 0x338>,
+              <0x1fa76000 0x300>,
+              <0x1fa7a000 0x1000>,
+              <0x1fa7b000 0x1000>;
+        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+                    "multi_sgmii", "usxgmii",
+                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+        resets = <&scuclk EN7581_XSI_MAC_RST>,
+                 <&scuclk EN7581_XSI_PHY_RST>;
+        reset-names = "mac", "phy";
+
+        #pcs-cells = <0>;
+    };
-- 
2.48.1


