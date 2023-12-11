Return-Path: <netdev+bounces-56056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D684080DAC8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148581C21457
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7A52F79;
	Mon, 11 Dec 2023 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO2GCzu2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B1DB;
	Mon, 11 Dec 2023 11:23:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33622099f23so1083364f8f.0;
        Mon, 11 Dec 2023 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322627; x=1702927427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMAmnGozTmnOuA6RhURhtT7TCK/lSA6JNDgFDLoxOaM=;
        b=XO2GCzu2aKGwSH59OF95+AMmxDmdW5F40llusnpBoYk+VsIf+BdnKzTNfnM19Vb2U6
         S/1oAbH7BEAECd2ZpHrTV717E0hzMRMuNLF8u555PdsB2S1i7XR0B9EaBCLTltXDrCeW
         zbjyGz5NUTgWN+DNQYXpEtZYOTnqOK0MFqmRXz0B/+N5F8SzbV21YPPGJ4yM1pagff9T
         LftoB4OcxbHdCKiAaxhK+bIYUu7q4bZW8W5p8mqK3yz/P0/0GML+GLBEOlviy+0UTkHI
         Mg3J72dKDLs5ph28RCa50t+VPvJNfvobeKRk1hyj4iDgesI17txUtfrn2hKyIMHg9pdU
         Lvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322627; x=1702927427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMAmnGozTmnOuA6RhURhtT7TCK/lSA6JNDgFDLoxOaM=;
        b=WTahHYYgRlphN24LAQvSZbN3QM7jjvukapGj7/Qja/TLPTLPz6EoIkbyBBtygNqJVA
         EQk9Vru52JRqhr8APOwJ5E4wzHwk59lHme08D/LJfnu7u5OzaDqXWBnxOkc7rUdOKAW+
         gGsGwMg6THnhcrj7mzE2Sl27s9t+JR4BxyFinvCqh+7WmEDA2rDzFwYNekI5fGoHGOlc
         gWCU/I0Z9XezjJWbyWgREWSYjwIVfU2+jYtIz0DqExcO8R25iISLE6D7oo0JzA/qhp3m
         WxLVAIVeqF/bZOX0k7YKUdFL0saI/n/wpKIR1tz/5+2g29dBV6zHbYf7V5NceH6r2Nua
         GgTA==
X-Gm-Message-State: AOJu0YxnNn1n8sSXIneCnv+BuTDclVy4DhIL/yIV2+AYBdPhrAxpfubO
	nmwxcuAWcWVgk8pDNk9HM9w=
X-Google-Smtp-Source: AGHT+IFtdmo7V/lmVkSCPQOJpqTTDOnuKNEbSMdpyKAg5ARSKciKs28W9+CZtYd0k9trC6ofTaFqMQ==
X-Received: by 2002:a1c:7213:0:b0:40c:25c8:12e1 with SMTP id n19-20020a1c7213000000b0040c25c812e1mr2282910wmc.12.1702322627280;
        Mon, 11 Dec 2023 11:23:47 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d16-20020a5d4f90000000b0033349bccac6sm9325197wru.1.2023.12.11.11.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:23:46 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 1/4] dt-bindings: net: phy: Document new LEDs active-low property
Date: Mon, 11 Dec 2023 20:23:15 +0100
Message-Id: <20231211192318.16450-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new LEDs active-low property to define if the LED require to be
set low to be turned on.

active-low can be defined in the leds node for PHY that apply the LED
polarity globally for each attached LED or in the specific led node for
PHY that supports setting the LED polarity per LED.

Declaring both way is not supported and will result in the schema
getting rejected.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add this patch

 .../devicetree/bindings/net/ethernet-phy.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8fb2a6ee7e5b..9cb3981fed2a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -213,6 +213,11 @@ properties:
       '#size-cells':
         const: 0
 
+      'active-low':
+        type: boolean
+        description:
+          This define whether all LEDs needs to be low to be turned on.
+
     patternProperties:
       '^led@[a-f0-9]+$':
         $ref: /schemas/leds/common.yaml#
@@ -225,11 +230,26 @@ properties:
               driver dependent and required for ports that define multiple
               LED for the same port.
 
+          'active-low':
+            type: boolean
+            description:
+              This define whether the LED needs to be low to be turned on.
+
         required:
           - reg
 
         unevaluatedProperties: false
 
+    allOf:
+      - if:
+          required:
+            - active-low
+        then:
+          patternProperties:
+            '^led@[a-f0-9]+$':
+              properties:
+                'active-low': false
+
     additionalProperties: false
 
 required:
-- 
2.40.1


