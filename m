Return-Path: <netdev+bounces-70396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A1B84EBC7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46771F2A1ED
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A77350253;
	Thu,  8 Feb 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h49ZYYJR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC450255
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432040; cv=none; b=iUJEh+FKe6Es3F6UNyTyDBdGy/Ksmy+CL6C31VqQfyzkX3xohVmaFvT7mLXZhnnNHKV4QiNuHocSzmvIHpx0qdAApffuPcjVb6arfSbJwbxn+ETlupnrzf669gYAh01kyq2vFhA8YoQa6JgnFvl4/QNxlJzMfdedBFObgB09j54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432040; c=relaxed/simple;
	bh=Z1bQz0sR/8sF+fGRm3k16unqn3qiVVBjHfu9ZS2SXVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rp/iwjFRMXrGrSxMV+Vvspky1MhK//EvFdwG/8J6Btd0yo0ZClovysK7HTAWvnwPnAQxEPx29KZld5xO4MAaaxS+RHb1Yckc5VWxDDzE8oXn4qX1qhlmLsBV8g/AUNJnaaBn27v0JWpKtTvEW9iDmDPekHq4cZb0rWjvOpdXNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h49ZYYJR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so369622e87.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707432036; x=1708036836; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DMz+clbkBzw5kmOkNiPQdWqo+n21lhmKzZ0h+DrZ60=;
        b=h49ZYYJREpHrysCPY91alYTC7PfJad7EKMplAA7H+JI3nMi5a/sMaBp8O7/uefWgFV
         SLppp4NLOLlgjh4AoouiAt0EgaBC0QLDYI9XfAfjD01a2fMz9Hw72RbmBIP4tlKbgcWg
         Pma5qNRSsT32mnCJRpPERsOJ8uwRDNQK8+2wQjmy1SBdebLEE1rf/Z+lfn3Ng5LjRkXU
         8ljsV4AIKnB9BUNQo9FkxBaxxUJP1QM7QJ0QBDdWD2gbRWuQeBz9FPqGg8ktMVSzsjI8
         7MkDaIJTklDrg018yjRi7Rivwc9za3Xpsn8RJ2HiHmueTGVZO2Kl0vEf5IjlX4gDQov/
         LEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432036; x=1708036836;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DMz+clbkBzw5kmOkNiPQdWqo+n21lhmKzZ0h+DrZ60=;
        b=VaHkFELJe5fm5fpXfK5jleaS3nYtVpZPizttyZ9oqMkuX+ricRPFN7LjMNBDQXVENh
         ytloButa7pVdGbLoVZ+6u8RQeKR3wZ7ePEIkCL0EVQH5/R/ADDr81fXxOzKeV9XblOAP
         4U75NbKgNpG9Txt6GGUhS954+G8zlP53I9LyDsRNeVLOj37+G7WAWNJj9ZqJaMjnaxUT
         BAp874u7HwOO0fhWSnlECz7mvmZcpwviv0psS25Ji8Ho5tWn/mlRUlqloOmbnsdGGZf2
         BdZ/Cw5qhOvEkoGZ/k8HwhIq6/eFjq+1k0dyNLEMrujST2Ank3uN5Cym7R8h4hXEejB7
         3zqw==
X-Gm-Message-State: AOJu0YwF/NfC7mbG3KLcrD0dxwyYaIadVVlWvzzUjDLac2SMEVZu23ZY
	lhnDx9gll4UqxM9MM4ss/1V9imDkKleBuY9cEQDSHVQX/59CT44DDkH/ILCt6yE=
X-Google-Smtp-Source: AGHT+IFoBM3tLY5z7WB27zNlX9wIwsWV/ahGe0KNK8CD0wKS4NChc9G47lgxgPfwPaD2xhjJsJGtaQ==
X-Received: by 2002:ac2:4d84:0:b0:511:61ab:406e with SMTP id g4-20020ac24d84000000b0051161ab406emr413745lfe.28.1707432036121;
        Thu, 08 Feb 2024 14:40:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXuNNa6lLA4f8wORKdX7lRpg3i5L+9fKXIq2Ian8KIddY6qopz+yn6ALiS6CfjbTiVgCafNjJAO8vU7I3Ahw8lHE8PFl5gU6FDluvqsl0tV605diwzSdq+v4J1AF/CQVRIgL3wwFitlqZRYYvzUTkiM2lOxgxtCMvM92x0PIYQXPcPY+cCBb4DeR6KXGfiBbM+eyh4DSF7QWkawnGzAvugSUO7jL2nGJBwRy34Y7A/DkjC8ckxun/IJeF3dRJAn4gY9oDLpaWaYXyoghYbELF7xHG6gWmQqoKdCZnVtQXSqxHjBJrkzY2EE2aWAxD4HZQGzJuM39t9WfjdTid1VgmZ1Ezc72ENh1Cd4PRSEoqK2FjBN4+rLBWtRzcLaXvqMGfrNbq1dnZA4xn6X0/z/moSHYuSsUxmUw==
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n12-20020ac2490c000000b00511767de71bsm22098lfi.291.2024.02.08.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:40:35 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 08 Feb 2024 23:40:28 +0100
Subject: [PATCH] dt-bindings: net: realtek: Use proper node names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-realtek-bindings-fixup-v1-1-b1cf7f7e9eed@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFtYxWUC/x2MQQqAIBAAvxJ7bkGlg/WV6KC51VJYrBVB+Pek4
 zDMvJBImBJ01QtCNyfeYwFdVzAuLs6EHAqDUaZRRlkUcttJK3qOgeOccOLnOlAHS95Nug3eQYk
 PoSL+cT/k/AHaqySqaAAAAA==
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Replace:
- switch with ethernet-switch
- ports with ethernet-ports
- port with ethernet-port

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/net/dsa/realtek.yaml       | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cce692f57b08..4971dac6a233 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -145,7 +145,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     platform {
-            switch {
+            ethernet-switch {
                     compatible = "realtek,rtl8366rb";
                     /* 22 = MDIO (has input reads), 21 = MDC (clock, output only) */
                     mdc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
@@ -161,35 +161,35 @@ examples:
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
@@ -239,7 +239,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     platform {
-            switch {
+            ethernet-switch {
                     compatible = "realtek,rtl8365mb";
                     mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
                     mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
@@ -253,30 +253,30 @@ examples:
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
@@ -328,7 +328,7 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
-            switch@29 {
+            ethernet-switch@29 {
                     compatible = "realtek,rtl8365mb";
                     reg = <29>;
 
@@ -342,36 +342,36 @@ examples:
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
base-commit: 618b16bbf071a7e8d9601f7ba259a00a169a3937
change-id: 20240208-realtek-bindings-fixup-1d8ebaf19dba

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


