Return-Path: <netdev+bounces-131907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3B98FEA3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7241A1F256ED
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8613BC1E;
	Fri,  4 Oct 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lv2RMRLX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411E8120C
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029338; cv=none; b=DvGYSF20JMhI3CN8ED9k3+dYR9NClG5HniE5tkiXnEgmLJ7sEDeQSVZBSVZ8HETv4Ye8sq9u9XIh6PedGGQQSq6qjT5Ez8edpuiKkTu+ejKzVEJosGXfDYikXaFUVIgIpo4puZ4uzSLKxYXTamDw0+7wEErKBhtgX+DMyN1wrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029338; c=relaxed/simple;
	bh=7xoDIx4XuNoY1uZ9PXp0eWKAcuu/mlxTKzPDB8kSZjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W1fM2+s/B348TyyWU96dJu4FYGKmZ2w5OK/Cmpea9EZwVmh+ergbb73XoqUElHN676cNhVNXBsdSxEPni1ugf+LP0Dh+mNj9cSDcjBWgHV0vkabnf4RUzAncugLlzoYzjCfegMP/22vNIUdGue9iDA2NYjW3kjxkpstBNN/ocVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lv2RMRLX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8844f0ccaso2279214a12.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728029335; x=1728634135; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0ItRyPkw3RtC0lSHNVDwNzhe/I7oWN44mlp1bu6JAY=;
        b=lv2RMRLXnuYd3bZybYL+TgvTfXMTKQUDdWC+rXd+1RqnTx5k51VrVJHsXahoMfNnU9
         EY0IUEA9xNsIBQ2c8KfgM5ZXw4eIFl8d2BQv0v6JTt2xFUTQcaGr3h5QtyepxMwU5vTc
         cPhiie8gDM/t1jG7cHCwy7+Nen14XGmBXKAsXm/5eEmmppAHT0UtG42/NXUJXzYru858
         Fs6QBE85Oeonflb02SnV09P7588DI59xEeipBgaATdNq4/BGMIsApcV0TXVBH1O50poE
         AoOyT3oPwxV5qrk81vYm8tzYJpn/rkZ3xGC8FaA9ZXgPT1g7CvJyBLG8sjG8tKcF/j7p
         qnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029335; x=1728634135;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0ItRyPkw3RtC0lSHNVDwNzhe/I7oWN44mlp1bu6JAY=;
        b=wVBgDnWUDgIrZHuEUIvp2qqSXHMgl8ytF06up7CnqfWconrAhSt7YgfWkXlaNcloUS
         NUbAVbeCXojSvPdR1AhJ8QwyaPKS5YST5weLC9qwm0Vw8IXtgzi3L0jFN0rdQ0mGIU4f
         hYWHpr44POMlPzWEG1lgcEEWAXOIGKevSthJcrQR6ZXOKIGRSYYqdFrkdrKVjXASIXwz
         xkgCvppVhZrwuVm3bXgMsZj61hR4+6nlMFAeCnJ9pzmAPdRztGNvH6lBy7UuUGVthRw7
         64+Z38Q/XIWs7tTdUf1KqegjHfbheb3Wb+bavcWAQFxM7E5xtsYrIwZMklg3DXRPuDFH
         WcBA==
X-Gm-Message-State: AOJu0YxKZn8MWVZzkrP7Kwn3cEpE/f3TC2mTeBBJ2bi3p1IszrbejVVj
	j2CZ19LQJiKR3t+zAxyTy9im8/1BAUaFT1qzCdazM8ZIn7YUUpo7v5Y8+u8KeEc=
X-Google-Smtp-Source: AGHT+IEzdJmHXWVlDxj15H3eMX3/swAX2rbbEMWO0ZW4CXbVp1zQ2rJDw1p5g2NPjWiXBazjXGu3jg==
X-Received: by 2002:a17:906:dc93:b0:a99:bb:737b with SMTP id a640c23a62f3a-a991c077e09mr211318066b.55.1728029334855;
        Fri, 04 Oct 2024 01:08:54 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a625asm189895266b.87.2024.10.04.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:08:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 04 Oct 2024 10:08:50 +0200
Subject: [PATCH net-next v2] dt-bindings: net: realtek: Use proper node
 names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-realtek-bindings-fixup-v2-1-667afa08d184@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJGi/2YC/4WNQQqDMBBFryKz7hQTCmpXvUdxkZiJDpVEJlEs4
 t0bvECXj8d//4BEwpTgWR0gtHHiGAroWwXDZMJIyK4w6Fo/al23KGTmTB+0HByHMaHnfV1QuZa
 s8apz1kAZL0JFXOE3BMoYaM/QFzNxylG+1+OmLv8vvilUaNXgG99QR+ReMwcj8R5lhP48zx9ND
 CgExwAAAA==
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

We eventually want to get to a place where we fix all DTS files
so that we can simply disallow switch/port/ports without the
ethernet-* prefix so the DTS files are more readable.

Replace:
- switch with ethernet-switch
- ports with ethernet-ports
- port with ethernet-port

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Rebased on v6.12-rc1
- Updated committ message.
- Link to v1: https://lore.kernel.org/r/20240208-realtek-bindings-fixup-v1-1-b1cf7f7e9eed@linaro.org
---
 .../devicetree/bindings/net/dsa/realtek.yaml       | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 70b6bda3cf98..f348e66fb515 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -147,7 +147,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     platform {
-            switch {
+            ethernet-switch {
                     compatible = "realtek,rtl8366rb";
                     /* 22 = MDIO (has input reads), 21 = MDC (clock, output only) */
                     mdc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
@@ -163,35 +163,35 @@ examples:
                             #interrupt-cells = <1>;
                     };
 
-                    ports {
+                    ethernet-ports {
                             #address-cells = <1>;
                             #size-cells = <0>;
-                            port@0 {
+                            ethernet-port@0 {
                                     reg = <0>;
                                     label = "lan0";
                                     phy-handle = <&phy0>;
                             };
-                            port@1 {
+                            ethernet-port@1 {
                                     reg = <1>;
                                     label = "lan1";
                                     phy-handle = <&phy1>;
                             };
-                            port@2 {
+                            ethernet-port@2 {
                                     reg = <2>;
                                     label = "lan2";
                                     phy-handle = <&phy2>;
                             };
-                            port@3 {
+                            ethernet-port@3 {
                                     reg = <3>;
                                     label = "lan3";
                                     phy-handle = <&phy3>;
                             };
-                            port@4 {
+                            ethernet-port@4 {
                                     reg = <4>;
                                     label = "wan";
                                     phy-handle = <&phy4>;
                             };
-                            port@5 {
+                            ethernet-port@5 {
                                     reg = <5>;
                                     ethernet = <&gmac0>;
                                     phy-mode = "rgmii";
@@ -241,7 +241,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     platform {
-            switch {
+            ethernet-switch {
                     compatible = "realtek,rtl8365mb";
                     mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
                     mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
@@ -255,30 +255,30 @@ examples:
                             #interrupt-cells = <1>;
                     };
 
-                    ports {
+                    ethernet-ports {
                             #address-cells = <1>;
                             #size-cells = <0>;
-                            port@0 {
+                            ethernet-port@0 {
                                     reg = <0>;
                                     label = "swp0";
                                     phy-handle = <&ethphy0>;
                             };
-                            port@1 {
+                            ethernet-port@1 {
                                     reg = <1>;
                                     label = "swp1";
                                     phy-handle = <&ethphy1>;
                             };
-                            port@2 {
+                            ethernet-port@2 {
                                     reg = <2>;
                                     label = "swp2";
                                     phy-handle = <&ethphy2>;
                             };
-                            port@3 {
+                            ethernet-port@3 {
                                     reg = <3>;
                                     label = "swp3";
                                     phy-handle = <&ethphy3>;
                             };
-                            port@6 {
+                            ethernet-port@6 {
                                     reg = <6>;
                                     ethernet = <&fec1>;
                                     phy-mode = "rgmii";
@@ -330,7 +330,7 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
-            switch@29 {
+            ethernet-switch@29 {
                     compatible = "realtek,rtl8365mb";
                     reg = <29>;
 
@@ -344,36 +344,36 @@ examples:
                             #interrupt-cells = <1>;
                     };
 
-                    ports {
+                    ethernet-ports {
                             #address-cells = <1>;
                             #size-cells = <0>;
 
-                            port@0 {
+                            ethernet-port@0 {
                                     reg = <0>;
                                     label = "lan4";
                             };
 
-                            port@1 {
+                            ethernet-port@1 {
                                     reg = <1>;
                                     label = "lan3";
                             };
 
-                            port@2 {
+                            ethernet-port@2 {
                                     reg = <2>;
                                     label = "lan2";
                             };
 
-                            port@3 {
+                            ethernet-port@3 {
                                     reg = <3>;
                                     label = "lan1";
                             };
 
-                            port@4 {
+                            ethernet-port@4 {
                                     reg = <4>;
                                     label = "wan";
                             };
 
-                            port@7 {
+                            ethernet-port@7 {
                                     reg = <7>;
                                     ethernet = <&ethernet>;
                                     phy-mode = "rgmii";

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240208-realtek-bindings-fixup-1d8ebaf19dba

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


