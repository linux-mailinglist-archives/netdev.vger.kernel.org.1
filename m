Return-Path: <netdev+bounces-162007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34318A25218
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 06:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8071B7A20F7
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398817ADF7;
	Mon,  3 Feb 2025 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XphxbjCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B67154457;
	Mon,  3 Feb 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561430; cv=none; b=oxYlDN/z0E7JkKbg5ebXOkrW/wDMr67ijl310In4uXXxCHxLu10inh1w3b8zSzVLwIdmAvoKNM0+ntQSVAlGT1oPLeDYv0XLz7Kp0/4LStpsl+0prwoJqmXAAAneTvjFjNmrh56StC7rcqmy+IuKurfoV3s2Eu6iaU/hnZbJXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561430; c=relaxed/simple;
	bh=1eDAhLg/uB8BqSxz1fnINyvH5uJswvTw3kizEquhxCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UP2XXo27Qrlxyq+EgDikglwuijCbx4jSyHksN8H2nAoJ5w+MHYRceFvayBkPEsm+zp+TmYC79U4prMt5dMC9Fj3jMIZUxD2Tw0rVNxKh5hJwpUzjrY1U9kGCrBrGe280Ja/J4DJe6XAPBuibt7s+MQllpIENglz+MRX/f21R7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XphxbjCj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso6958609a91.0;
        Sun, 02 Feb 2025 21:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738561428; x=1739166228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ruy9T8+YCMNFZIu2fnBUkNd/IXv0Vs9qPj53hJ7nck=;
        b=XphxbjCjEZ2G9hKAMihkyO4OJb/5Q35Y/B4eyJd6Mq2G6q05UNaGqjtppXTuzjhYu/
         cdlub2QONtdKfJNbZMEzvOaOhxOOuXHFnLPrbk5loYybW2ZbuxMZRzGOmKXWMH9tWw/D
         FTMgImDpWlpHUZh57OV1QYsJG2XX9cY1GssR6+CwjHP5QAhG4zgy8oepDcKP3byAxxgI
         fTM5YSPXuzHUe+9LYwVyzYusw2//YVyBib2sdYWLAUQL+gNjg8caqFdARHnoJpXKlzkI
         niM8/KycSdw0FhaP+w9tM+RsD+1MVLFX1PJi6YrPNl9ADjARP0wQgoCfQ4LbLBnC8coe
         UOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738561428; x=1739166228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ruy9T8+YCMNFZIu2fnBUkNd/IXv0Vs9qPj53hJ7nck=;
        b=arTiwkRd99ksBZF8ZdImaT/4nWA7KdXS4svIxIUA7OrjySy8I/fI5fkrtQA5s4RsVz
         bL74p+uEYGX+TNbDmVJf54F/gS74FngOt9MMmzHb9rt7eRrLmWvUcAKXw/pqYF3HaYJw
         OtoWEW67Qx2TjWP7DhnNs1+pPv9TTEyz5fiv96rAclcvPxlg8MMzwYWZlDoybbfFjtsg
         RxI/ohawSS89uMY40flLNOiepyTWh8mN1S+F7rjXr21rwD8DV1k0l5GxQj2MYf9dUDZF
         c2BCgF3ailPE4XDdF0BACX1UY4InFjnVnQNgkJ4vbd/2DdzCPgjaIeJEDCh45ZvxyTMn
         iv6w==
X-Forwarded-Encrypted: i=1; AJvYcCVhOgWtghGdCZERrpUIJk1yOC5W0RCCmA5+DaVjLpRa6TvaRZ7rBQGl0K5slHqwwNber9E06mN8piq08bhZ@vger.kernel.org, AJvYcCWiWszCrM6KiBFWqpzwOoRYzKHeZmCAOPJBM7jGjPyRQaeqhGUWF9G+1jr3GTZUVnIy/ajgER9kLLqX@vger.kernel.org, AJvYcCXq+hKaYLavN58mYT5QsY6l/9DnS5QB24sfhm6j6oiov+TYvU3nRchadsStSkyIXsoHoiYYcNy0@vger.kernel.org
X-Gm-Message-State: AOJu0YxLh+5oowIkauHC8YOAMJnAB+qamNpjiTDYIpLv/fcCr+9+au1c
	ztAHl3rYHXVEpEqXmtJyxVg2yB7/vk40fZSoMFhPkndbAfSK/Enu
X-Gm-Gg: ASbGncuGCEU+ue0Eg+sKlhGJT954sXqe5LxlAwD9NqsOiMb3xYuMCkZ3/F3KKEhwbm/
	63X2wrKhguxWaWggpUw7MEpbWlPRNbZJm198uBYXSB2k0uSf5ag2sEfSDH4Ro+UU5A0bwa+ZCCg
	95HyLlahsg/21Z1BLUPedaELriqCr9ibE/0A77H/tUSIA1vrMkdTvaV8DZN0CxIY1SnGDniaDjc
	0AE/2KC6Y9uKLdwqJz9xMsTy4qQCi+DtR0P9dbYXMyGFQr13elEwcBYEk4Ju9xErES8IG6HZAqh
	zxihSNCr0LA+NjVfeXTBwQTu+rpzWDknX4UaRumxxNKExeZ9cnwF2LXW
X-Google-Smtp-Source: AGHT+IFgxTohM+aTPsUswT4Bo8XmTsTW2WTDB9DTwTUXt0vxuR95dvrKJqCuVM8BYlZj72Q46ZHtyw==
X-Received: by 2002:a17:90a:c888:b0:2f6:f32e:90ac with SMTP id 98e67ed59e1d1-2f83abdf0f2mr32127614a91.11.1738561428296;
        Sun, 02 Feb 2025 21:43:48 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5fesm66894555ad.132.2025.02.02.21.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 21:43:48 -0800 (PST)
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
Subject: [PATCH net-next v8 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Mon,  3 Feb 2025 13:41:58 +0800
Message-Id: <20250203054200.21977-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203054200.21977-1-a0987203069@gmail.com>
References: <20250203054200.21977-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
index 91e75eb3f329..c43dcae74495 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -67,6 +67,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,ma35d1-dwmac
         - nxp,s32g2-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
-- 
2.34.1


