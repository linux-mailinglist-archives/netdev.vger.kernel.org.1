Return-Path: <netdev+bounces-154903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD05A00463
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC741883922
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CE1B6D0F;
	Fri,  3 Jan 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKDqBfNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FA1B4F21;
	Fri,  3 Jan 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885993; cv=none; b=acZDR4aIuGzWtQd3jB+cnpxqCwjBQfXoEp9bvkvIKyPInqDEf4aKCbm6pwMv9gvJ8WnuDv3HfJRwMlwAe7FumoNsXWgejn2AsN3JWqdWgpvWiF+TDtn+A9/+zSUHQVi/Oq5L9e0O6N0RIkEajFM/LO71BdySz4msrLa1MjzGJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885993; c=relaxed/simple;
	bh=yny0NlIdMZcnh9SPksE3fIPfMjVhWTQRP8RvSOm/ffo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhnewWSih4Kqpsa675Z6Wz5tVNutK6M9036I3mj9dQO5ILxHBkM4O143pfFLCEyA0MJzPYtv+BIWZ8dReMeR4j2PinEz+mxLV9/wE57MDLtegP2NJpJPzRbMVwIcCxn6TZefzRmqbPDLvD+jqe4sZI0wGQQIEjuG5mYweJRQAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKDqBfNd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f441791e40so13563352a91.3;
        Thu, 02 Jan 2025 22:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735885991; x=1736490791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dW9tSKSb3CcOFy1YNdY01ABpN6qWxIbLh8Rm1LEF2s=;
        b=gKDqBfNd3xfJS7kdPbH52bBxZayv3FQTr2vxcCwpg1J5rnBB7dUylK3L1hweo5xuTZ
         UvRne1iHwbAH6EOmkJQns6TMvwSWmcC9GEgpCaKHqc/RFzxxfXNjaNTSFDIukL1ywir4
         1lBeIgAsSimqAWH/jout5zE3DdFAn2lmVJkr+jsWFvaKDMNTE9eP2+PWggTdfViVzO7R
         hVXNUATjD378RUxoz0jqt9F2MhcRq6MpwkEAFYV5W2+znudok54dT/m6NyK7wn4an0EC
         IYiSieZ9knQAkK0hpPUM8SaUZWXi4847u+HLGbEGCmJfdEmJc3+4DqI341U/yTcQbJiM
         s8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735885991; x=1736490791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dW9tSKSb3CcOFy1YNdY01ABpN6qWxIbLh8Rm1LEF2s=;
        b=S6WKrMjtWHcL1lnmEn50pMfGpbSQhX0h4aB+Z9I6/MLry2vOJ29x1UxjHIvVUro62f
         QSPTKZoq3dv8oanZqP46gvhCx+fKlZ91mIwOvYU0MzD0gHoGKHtMY7Z+miTd4VDllBwZ
         yBu+jd7N/24xz4mENisu5C8Le7SqQ8E328ON4rNOLQ4WHKH/J2SHuZt2R7mADtSpMsm/
         faM9XEQBBwP7gsLPjm7AiiRXNq0zTvhjdsOZkoUHRdd8jTi+SfhO9Kmft1A2najj4FBB
         z+dVgZ2Nl3RfEc9C6hRJznMoVaR9y8CnVM/pXwt4d42HVckkhM+BxbYYAKOxWlexHMv6
         U4/g==
X-Forwarded-Encrypted: i=1; AJvYcCUG3KAEHbHE17fPCGXIpQfxlS6Iy4vH1ZWHbOPnYpUnkHYdw/f4Ypdb1TyTv874BIC/GyhHLz2x9j5R@vger.kernel.org, AJvYcCVf2Eg19350afW0/6D1Ku8M1gTiPtGdZVqiisLO6gC+c46tPHuV1ZKce0RNDhub4U0xP9PuOt+cvVGM156+@vger.kernel.org, AJvYcCWuigz8/AqFfjvPAnp/tm5lT8hbpBzjf822L6BVSF2KR6oTMFPy3tU3Vd3zzSMlV6Or++sEjMHF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/hwgQRDYESke8fk80vSnx92YXNmG5rWK1R9+Rjgb2XHYCjJQ
	BVK2Gs1UW6XgYLeq4LtcZgE0omuhtazEFhS/0dvs/BciKnVlQCEG
X-Gm-Gg: ASbGncva+Q0dOW800VZs34y692iD/GN7lwaIPzYCRWVFlIXyQnK06JjTGzx1isihKvC
	H93YGpNNbTPTaW5Ewz6CuPSZ1LW3XhtpW0PKsgYxbCxe9OL3pBiflqfFK3NGFG0VEygZ2bxnJuA
	AtXkqB29guSwu2ZB5t6sXuZEgmh2zEMq4mW3iutKat45lD6vJyta8gSIo+ZmShNA9kcGtbLxyxH
	TVWSgPJEBepO1f7O2Jz/x7TZ+dA/b1WJ1+2a5rgHnYDEfd0pb370qnrPi1hJDe+mtkARt5l9zue
	DtRXdmqKAvWqlfA5pfL4bg==
X-Google-Smtp-Source: AGHT+IEiOFe4evfri1nnuFO6yzTBznHLXu75pnxX+t4aHQDSqgiu6wv6g4L6GtYLrIIjCWk7VdcMRQ==
X-Received: by 2002:a17:90b:3d50:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-2f452e458ccmr71154893a91.19.1735885991475;
        Thu, 02 Jan 2025 22:33:11 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26d89asm29427805a91.46.2025.01.02.22.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 22:33:11 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net-next v6 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Fri,  3 Jan 2025 14:32:39 +0800
Message-Id: <20250103063241.2306312-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103063241.2306312-1-a0987203069@gmail.com>
References: <20250103063241.2306312-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..c3f2ad423cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton DWMAC glue layer controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.73a).
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,ma35d1-dwmac
+
+  reg:
+    maxItems: 1
+    description:
+      Register range should be one of the GMAC interface.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: MAC clock
+      - description: PTP clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to access syscon registers.
+          - description: GMAC interface ID.
+            enum:
+              - 0
+              - 1
+    description:
+      A phandle to the syscon with one argument that configures system registers
+      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  phy-mode:
+    enum:
+      - rmii
+      - rgmii
+      - rgmii-id
+      - rgmii-txid
+      - rgmii-rxid
+
+  tx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII TX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+  rx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII RX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+required:
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+    ethernet@40120000 {
+        compatible = "nuvoton,ma35d1-dwmac";
+        reg = <0x40120000 0x10000>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 0>;
+        resets = <&sys MA35D1_RESET_GMAC0>;
+        reset-names = "stmmaceth";
+
+        phy-mode = "rgmii-id";
+        phy-handle = <&eth_phy0>;
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index eb1f3ae41ab9..4bf59ab910cc 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -67,6 +67,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,ma35d1-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
-- 
2.34.1


