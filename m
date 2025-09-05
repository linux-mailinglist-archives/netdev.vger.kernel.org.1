Return-Path: <netdev+bounces-220462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1359EB4620F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE4917987E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0E26FA5E;
	Fri,  5 Sep 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POFVfiDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24926F28F;
	Fri,  5 Sep 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096273; cv=none; b=Us7sVnEKV/gRh6YRtBhS7OLi+FVpZ9LFaCQwTqWV+Ua9DbPoKymfqlWv3HfudKA/GxmWvhv/+2IzTtmldFvSfAZ49pYXzkNtbVsUMS+HBcCoP0WozoS9wML1FmjazwYBymqabi1M/pPbdlozp7kucEtx2PsqIKvdSFTi5GvQcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096273; c=relaxed/simple;
	bh=8oP/KHoh/0OB5U9GAwKMQMTl8V+JdjQMnkNXVFeBf9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1gnHnMZHgdPaVtFHAiC21D+B4Z/WwQl3PrCSzgwhzRUHACztlgZd6vfPcVH+L3NzyQpz8H8vm7RRSNepVnKX4u35ySLjBza2M+Crzrt6qWKLCFpsdBCDERHvK0MLZzcljXXlKVJC0eTtUkKjlQEN3As7PfHS3dLLxpBBSAZanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POFVfiDq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b02d88d80so2153944a91.0;
        Fri, 05 Sep 2025 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757096271; x=1757701071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4RN6TwpCX803l0M7xHGRzHAVNXxkwJhNap1NI/5nHc=;
        b=POFVfiDq4POxUTYRFuX45kc94+a5QJtS8KoYKscvnTcnhqYLVTao6gc98JxxN4GW5N
         a6OiH4XmDBpWweTELsiKevR4QABYRhNy2ZXyYMwhdvdKj3V6uob/aEUweMLVklJJgTpK
         7hq8dP0W0V3iEKVdip0zx9Si64h+hZ7yUw55n4vILPeTLrqz3rrobRYHyaQ+DQyg5oiT
         ooWuRrLsw7KzyIkq40shAfeAdC1AxToGCg3C2RHAYHQKBeb/fYC3SCw8ClH+apTT4SYv
         wi/B12haNUYC2XiUeYNmDZUqaEg1YBC18OGSwsCO5USwh5tWwGYMA8s8RVrbmWj2bdri
         ywDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757096271; x=1757701071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4RN6TwpCX803l0M7xHGRzHAVNXxkwJhNap1NI/5nHc=;
        b=lOz3Digqk0jNhPI88HU+nJeOgm1mOVc7biE8zr8F2b370Ko5naE/kIFX5Z849zOP9O
         yoT6JCrjQe6Wff6qoTjx+pXEs3JPEtlBK36XdqdmBPxg6gL+OQKdeK8PhDxJanVf7MMe
         jU9aQHiGKfVQDqPInnw7zJqBo2tSydN9TB72NH2xVpNoovIxhhge+nVCxkLeYjguLWmo
         aJF9HtKz7nlBCDFp7uLrzrql1GsSbyrExRHq29TyRCRjvb5SJUihhvHvqzAUHKvL+Pxm
         Q2iTsDg8cRQKfVV/5UPTM5YWZiRllkMNOEMoGfXoQe/0vmiG6osi9tDDtdnIG1XtWA2c
         XXXw==
X-Forwarded-Encrypted: i=1; AJvYcCU/zz8HHJb2xMxy4WmAhDSmFNNMtLYUHoJmWo848KnCv7UrBLS+nf/FCj4N4hiVJR8aHzV/1q4aTNpKml75@vger.kernel.org, AJvYcCVOp0wu6yG5mZeToleu6nEUbuqX/HMJt9H5kK4p2xJ+e4QJBm8AnHEPGVihRenfNFiKxqQFuYXkYZuh@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkF6akIWpJyG8TELG2QHRu6Y14gdXD1WUnH+YtbFuB2IavyWs
	ycE3lx+ZqfZw4OJuvfhiF0D9K22pcU5z4kdTzyDX4uT8GzfkZpKwxcIcMVm7G/c3LgA=
X-Gm-Gg: ASbGnct0gWYplc1dGHHxUxy6h7HG0hJ/Z/A7OdNZNa/HYjvM4pk/VT91w+khXufqvyP
	/g+v527Ys6T2H7rDAIJk1QTxtB+1kM8GBI6ERwazWLeljqIphYwQA/YP9tG+wMyWbB5ipujrQ3Y
	fJa8bLOsftWr8Bvkxc8Km5GnLomy9fi3oF/eXxoIYiD4/aYPueWeCwrLtsCuIIbjbmIkAlSlAiv
	OQHWxCLfy8T8Hr9ZC6Kat6Uwm6y5TDqbbBeCktbiVyxiZIzcBM9NG7AmNPwGBj5K2uDMKemj1Ni
	6oG58xd+vSzX3jfT2DRPbjoT7shFc42losbb2oqU4iM3w54GiBeMvwmaSwvC3YdZ6AMbGTECBDt
	cGqQ3gKb6egyUs1ESG1RGdknv2mYRC9lOW4qfCCm9Mr3ueaBHIEk=
X-Google-Smtp-Source: AGHT+IEid5yAYCZQaLAW4YP2/rbtb719XQYJOtxNDDtIo5bw3nVVaXmokLuGMGp9uFkWQu+KaHBj7g==
X-Received: by 2002:a17:90b:2685:b0:32b:9f1e:ef0e with SMTP id 98e67ed59e1d1-32b9f1ef0demr7601037a91.23.1757096271205;
        Fri, 05 Sep 2025 11:17:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3282dd2sm19964031a12.44.2025.09.05.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:17:50 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v7 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Sat,  6 Sep 2025 02:17:21 +0800
Message-ID: <20250905181728.3169479-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905181728.3169479-1-mmyangfl@gmail.com>
References: <20250905181728.3169479-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm YT921x series is a family of Ethernet switches with up to
8 internal GbE PHYs and up to 2 GMACs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..275f5feb0160
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorcomm YT921x Ethernet switch family
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
+  internal GbE PHYs and up to 2 GMACs, including:
+
+    - YT9215S / YT9215RB / YT9215SC: 5 GbE PHYs (Port 0-4) + 2 GMACs (Port 8-9)
+    - YT9213NB: 2 GbE PHYs (Port 1/3) + 1 GMAC (Port 9)
+    - YT9214NB: 2 GbE PHYs (Port 1/3) + 2 GMACs (Port 8-9)
+    - YT9218N: 8 GbE PHYs (Port 0-7)
+    - YT9218MB: 8 GbE PHYs (Port 0-7) + 2 GMACs (Port 8-9)
+
+  Any port can be used as the CPU port.
+
+properties:
+  compatible:
+    const: motorcomm,yt9215
+
+  reg:
+    enum: [0x0, 0x1d]
+
+  reset-gpios:
+    maxItems: 1
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: |
+      Internal MDIO bus for the internal GbE PHYs. PHYs 0-7 are used for Port
+      0-7 respectively.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: |
+      External MDIO bus to access external components. External PHYs for GMACs
+      (Port 8-9) are expected to be connected to the external MDIO bus in
+      vendor's reference design, but that is not a hard limitation from the
+      chip.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@1d {
+            compatible = "motorcomm,yt9215";
+            /* default 0x1d, alternate 0x0 */
+            reg = <0x1d>;
+            reset-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                sw_phy0: phy@0 {
+                    reg = <0x0>;
+                };
+
+                sw_phy1: phy@1 {
+                    reg = <0x1>;
+                };
+
+                sw_phy2: phy@2 {
+                    reg = <0x2>;
+                };
+
+                sw_phy3: phy@3 {
+                    reg = <0x3>;
+                };
+
+                sw_phy4: phy@4 {
+                    reg = <0x4>;
+                };
+            };
+
+            mdio-external {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                phy1: phy@b {
+                    reg = <0xb>;
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy0>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy1>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy2>;
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy3>;
+                };
+
+                port@4 {
+                    reg = <4>;
+                    label = "lan5";
+                    phy-mode = "internal";
+                    phy-handle = <&sw_phy4>;
+                };
+
+                /* CPU port */
+                port@8 {
+                    reg = <8>;
+                    phy-mode = "sgmii";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                        pause;
+                        asym-pause;
+                    };
+                };
+
+                /* if external phy is connected to a MAC */
+                port@9 {
+                    reg = <9>;
+                    label = "wan";
+                    phy-mode = "rgmii";
+                    phy-handle = <&phy1>;
+                };
+            };
+        };
+    };
-- 
2.50.1


