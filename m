Return-Path: <netdev+bounces-194052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D53AC723B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 22:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31CF4A307F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92082220F21;
	Wed, 28 May 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="H/pj6v40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2E205E25
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464321; cv=none; b=RE/O0O1+liKFBTiWSbBxbeI6efdkDMYgjoZTifgc5ojUDjk84YZ3ZnBkxsg6LTMWigo0V/d+aC2uo3FJWKTidapDtlxP69BgkzFMWgyazjcLnabLBkWYxL9IDu3RBdi9YIDydocVTjUS4ry5z1joGZAhO0QNzc7s/ZVDrrfFQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464321; c=relaxed/simple;
	bh=BrBbR5CbQI4aYUBRypucmSqCUVq5TrcbJLGOVPXbW0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jtt9GpsGZNZ8+Zoc92bF/ZQCIlgxSPle+wEF12UyFzgLFGC8LX6AMOCkCzlP6kuZGUHr8z+AFa7QKgj/bnQ6RxwkjEDf8noeZpIjSxKziB+lTYaXxD+rFAglGwDydc9jX5i/hRfdecfS5yx4RlYT/wUavGz1Ui/9XWOu/sBP5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=H/pj6v40; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a361b8a664so204035f8f.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1748464317; x=1749069117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSWXgr0Rc+W5KMUBLUdxw5Riulc06AxCHfqoKhxLOoQ=;
        b=H/pj6v40epSxPzsz5NOLTEW4bEevGT4CPwr8NtlX9ehbR5H/6Tj4P8D8mkVOsOaL0Q
         W0TvAf60MD5WKVjfx9y2t3uQ1XP0Hl7rpNyrK0VqVHWF+H8XRS/1jL2eG4ePBTESzMdu
         ojveZz2CbqP7rf95JslNfNh1M2o6NHXJEZOzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464317; x=1749069117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSWXgr0Rc+W5KMUBLUdxw5Riulc06AxCHfqoKhxLOoQ=;
        b=g2X9CBU3xDCR6Aor1M+CRpfoMLblpyOxOso3IxmPeY0gz2u1d2/CWRO3tPDbLF5yPb
         ZXPZ925uq3bCRt49lTDAuVbK4N5tdssGBsPEg9mkpG1eYQrGJaVDqkk9R2SVZ315iVx1
         FX0vuTocR6BDhBJBFeXO0MiVfF6cmfJGi/bkP+ELSQRKG1bCZD338dDOIjcJ/XKd1ev8
         2ocP2gv1ri6tnd7tIUurRn4xRgeJuswpjUFO3Js9DjlUpzMz/6HBN7Xj4HR6kxo2bBM3
         Mj2oPc31Y/tU5IS/ezi+/SB3GpxUZZ0dXc8h3eGTO3+ndFb8jMbqkU60bV20UK4KEhWU
         bCAA==
X-Forwarded-Encrypted: i=1; AJvYcCXJfwksoSOlV/WXCqoADg/Qqq1nSIC+iJ6J7l02ksOOKu8OEuhh6rBjmIQHTl/0NOm9Tqkay9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/1suFX4L+YI072CjZmGNMJPWgJijvm//z1TyUlIH+OPFxR0v
	8fx+x3Kepk1wjufn2k+AOdbbrBnRVrkoGZnVJ5ynz4xCBnYoyogzLwIVyrQQmsbCy3Y=
X-Gm-Gg: ASbGncvRP8dzN0vSTTvtXZo3F8q2fGTlGfGA1hBM4WAmyaghOQHn3xEF1CHefh8KRzz
	l/BeoARDcSkQE2XZm50HqC/e/HuE4ZfA86yhnvOkrIIGu4ABc1UUwU1DZBrIHzPqVgJ16h0qOOc
	LbKa6iiAQEMEbEjCiTtrgMVDF1FlPtGF5BWZVE7+q9P0L6ZdXuRJsuaqQha9AcckNrbvPHBLs6/
	s2x13tU6PmOj80CtEZ4a48fT3anFappkvVcxulq1F7CujTPACrCcG2oFeorV3k9oXXTuCyxnFjF
	pgWISiWZj1Qd0JPqP2IlCJLXN+blv3tYcNY1piTUai7cVSg7QaHvP8nFTaoNoNg=
X-Google-Smtp-Source: AGHT+IFQ2szQOUKTYzQfDg5v2dEo7jM5cHq832S17GBiq2kI8tiPg0A1o7C6s+Meugy/KOsjoVv/2w==
X-Received: by 2002:a05:6000:2087:b0:3a4:e706:5328 with SMTP id ffacd0b85a97d-3a4e70655cbmr4586644f8f.48.1748464317574;
        Wed, 28 May 2025 13:31:57 -0700 (PDT)
Received: from heaven.lan ([2001:861:3080:b0f0:6448:db2c:bea7:b817])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eacd8f0bsm2391181f8f.75.2025.05.28.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:31:57 -0700 (PDT)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>,
	Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: dsa: microchip: add bit-banged SMI example
Date: Wed, 28 May 2025 22:31:51 +0200
Message-ID: <20250528203152.628818-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KSZ8863 can be configured using I2C, SPI or Microchip SMI. The latter is
similar to MDIO, but uses a different protocol. If the hardware doesn't
support this, SMI bit banging can help. This commit adds an device tree
example that uses the CONFIG_MDIO_GPIO driver for SMI bit banging.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../bindings/net/dsa/microchip,ksz.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 62ca63e8a26f..6cab0100065b 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -242,3 +242,60 @@ examples:
         };
     };
 ...
+  # KSZ8863 with bit-banged SMI
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    // Ethernet switch connected via SMI to the host, CPU port wired to eth0:
+    ethernet0 {
+        phy-mode = "rmii";
+
+        fixed-link {
+            speed = <100>;
+            full-duplex;
+            pause;
+        };
+    };
+
+    mdio: mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "microchip,mdio-smi0";
+        gpios = <&gpioc 1 GPIO_ACTIVE_HIGH>,
+            <&gpioa 2 GPIO_ACTIVE_HIGH>;
+        status = "okay";
+
+        switch@0 {
+            compatible = "microchip,ksz8863";
+            reg = <0>;
+            reset-gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
+            status = "okay";
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                lan1: port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                };
+                lan2: port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                };
+                port@2 {
+                    reg = <2>;
+                    label = "cpu";
+                    ethernet = <&ethernet0>;
+                    phy-mode = "rmii";
+                    microchip,rmii-clk-internal;
+
+                    fixed-link {
+                        speed = <100>;
+                        full-duplex;
+                    };
+                };
+            };
+        };
+   };
-- 
2.49.0


