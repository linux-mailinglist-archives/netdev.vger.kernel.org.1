Return-Path: <netdev+bounces-117519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E894E28D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C681F217AE
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E515C14E;
	Sun, 11 Aug 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/IQgbUK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3D15854F
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400246; cv=none; b=gqv2Ch0fcESDsD4IMlxlTc17ZXr3d/DwoetRFMwaUp1vtXnGLI4bppL+Tb64WbBUd8kR1tcfHL15m1DQfwxaWKNNqs0iux2C1EJUlrK/FIpAtMFlodLRZfEqHRBGfnGAO2VQewvxym2HFx2qOtYHC2NaXuTK6OoYy9dHfvNPXFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400246; c=relaxed/simple;
	bh=fCBvR5l2kfQnmClu3hY5hsw9S1f2r9uHvUNX7tLyV3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnEN7dD5Tm6GwQUlduFyy9qYM+DHZr7Ba7ZBaqgIOsaPGu2CFphljfcoRax+8nXDallk5RhRCgRycThuTR86hvOfOQ5lEI7DSlQTL0sLXCp8IDu/gSfB6vS1R1pcOZDh8SE8VKA62oh2aUfyDIYRxMQ4/4QiCb8z3TQPpsPCs+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/IQgbUK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so4529029a12.3
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723400242; x=1724005042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+nOiSZVTAGXNGH6eneUy74cyMDNkjNt6P9eyPr5+K8=;
        b=x/IQgbUKazj7fLz2dhV4HTTqjtTr9ufLyIaNSwec+cBkubwBvRR4WAJ011aC0ClEkh
         wwf5ybFPYS5E9NnHIp/wmcAIuv0AQwJIsl9fM1ixIPPv257APkKM1h24JlH+5baV8qtW
         Wbna4HrmLuY1mK1fBDl6mkh9G+acihwZBgb440Wz1n6yVzt1zz/VZt4j7QrRXDuOGcIx
         If2GPuetaRBF8b5X2GIkTkhq1dYHYW+pzJr8BiYPQjrdwj3qexba65+Ax1SaW+3XELN3
         ApNO7YuvDr/PxRK19Stmo9e/OaD5YxDZRwQ81O4E1KRhEvgiLR5MwcCkD0qiFB4JHiBJ
         t9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723400242; x=1724005042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+nOiSZVTAGXNGH6eneUy74cyMDNkjNt6P9eyPr5+K8=;
        b=aAiKk4Bxo22jXAyIaXIxUlL5ldCsAJhsPjkbQYCbxCEbidwZpSt8D9Zyb+H+O9+E8E
         0v7OYent+ML4NIDIxq9VWXdiA3t7XFSyUwmaEv6Mb+5BcQc9msp8Ai6r98ZBvQt8wxsY
         PnIKdfcZ5OCVw0jZOtGH7qn7emYiqMKYDkKNSobS20DCWE0TaRfBnRsiXcF1enMSuTAt
         HpafmrFMeGmPxZBvLs0SLgNZMDGDYrUv8UQ6F0qMLwjzo8CIzdrmi4/JcjrQmAQkXTRb
         ivVgVKtCboF3EUlGsqXAENtjQ7V+6hJbQAMYxAj0bRHckFXo1Zf7w5osOBjLFboLLAQc
         /qQA==
X-Forwarded-Encrypted: i=1; AJvYcCW9aWmBc/XNvZUXmT8LHQ8RIF3OxqoTfzXHTcj8giGJlALxsMpimZJtVy7oaEdyPlxpqkFTy7KAekK72txUbhnyGyaZIKos
X-Gm-Message-State: AOJu0Yzl2/8fIBPvf/O6rYZCC6ygv1PKS7JRAwxlhUeuUwnk2IdpQTuh
	AREypa1r+PxAqFdnpBjWWc0DOoWTpiQp+emBBMjuQQ8Bq8OeuSJIdKZ48lnRZ7Q=
X-Google-Smtp-Source: AGHT+IE4wd/lzE9MdP0YQr2O7QtAWAX9rdSp6E7hYtxz3L9YKcOJCmCuv9Yp3oMvUw/jaUEBy1XhwQ==
X-Received: by 2002:a05:6402:40d4:b0:5a3:8c9:3c1d with SMTP id 4fb4d7f45d1cf-5bd0a598365mr4773119a12.14.1723400241969;
        Sun, 11 Aug 2024 11:17:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a6032c1sm1610593a12.92.2024.08.11.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 11:17:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 11 Aug 2024 20:17:05 +0200
Subject: [PATCH 2/6] dt-bindings: serial: add common properties schema for
 UART children
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-dt-bindings-serial-peripheral-props-v1-2-1dba258b7492@linaro.org>
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Kaehn <kaehndan@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4392;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fCBvR5l2kfQnmClu3hY5hsw9S1f2r9uHvUNX7tLyV3A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmuQAoN9Yt8uNW6oM1DQmDpVszXdEiFyOz3K0sA
 EqCIJvkLqKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrkAKAAKCRDBN2bmhouD
 1yCPD/9U+1jRz1m9m7eSRZa9w5LcjzvIpO5u0gAUYN2i7+4oSzeapPYO1x3GLVZXs+CNtSqnGsa
 CVg8HZ3UA5a2m/BeSUdEYBEIBVAF2hiQMop7GNFrAh/i4ci0knu/KnN8OhbFoEAgQFDh4r9ssvT
 9b7riBq5tjmjBJlKOOEGFSjdxyutpeR0nS/h56HFwHEPJ0p0QagC9u9PGUtQ7r4bHHl5Lod1Ifp
 4Q4n6xQlYvEp2/B8I+elkuoJX6xcPMK7OA7JuhtiLmyxD6yrlx3KGt5LuFOxZuFNW44Vulk0f13
 030ZkZqEnSMeYzOIxNLO6gKBYScLItTPL6bVll9dCm6p0aHOF6NSqZ2I2JZ2pDh36j3S93As6/J
 j2xkLjLf4UtuQsJLE7ff4XvgN4WOf7jGvh9em4o+X5tMOm3kXQY1r9tXg1L7ChySOd3Rm6Eb1s3
 /1MNOq9SdUoQkxEEEO7aYSceeyYVrydUothpc1cai6L38N8ebsNym42PeKhzLUVv9Gwjuw374ez
 RJNHdgRRD2obRNRIlm5dksIrJYR0zBl5BwQ0Pq0JrUS0SYBC8Hq6CVgbgaB4NOaAT6L0n+/hBl1
 PztglQZlN6QhDSheKlYJ+kl5JR/mAxi2Q1TlFIzySPqSQsE48lMkRheqw9IZiutKMXQK81xF16r
 1VCwrDNITQCU+jQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Properties should be defined in only one place, thus add new
serial-peripheral-props.yaml schema with definition of common properties
for UART-connected devices (children of UART controller): current-speed
and max-speed.  The schema can be referenced by individual devices using
these properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This patch should probably go via Rob's Devicetree tree.
This is the dependency for all further patches.
---
 .../bindings/serial/serial-peripheral-props.yaml   | 41 ++++++++++++++++++++++
 .../devicetree/bindings/serial/serial.yaml         | 23 +-----------
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/serial-peripheral-props.yaml b/Documentation/devicetree/bindings/serial/serial-peripheral-props.yaml
new file mode 100644
index 000000000000..b4a73214d20d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/serial-peripheral-props.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/serial-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Serial-attached Devices
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+description:
+  Devices connected over serial/UART, expressed as children of a serial
+  controller, might need similar properties, e.g. for configuring the baud
+  rate.
+
+properties:
+  max-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The maximum baud rate the device operates at.
+      This should only be present if the maximum is less than the slave
+      device can support.  For example, a particular board has some
+      signal quality issue or the host processor can't support higher
+      baud rates.
+
+  current-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The current baud rate the device operates at.
+      This should only be present in case a driver has no chance to know
+      the baud rate of the slave device.
+      Examples:
+        * device supports auto-baud
+        * the rate is setup by a bootloader and there is no way to reset
+          the device
+        * device baud rate is configured by its firmware but there is no
+          way to request the actual settings
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 40e05dd37826..30c85768d980 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -93,6 +93,7 @@ patternProperties:
       type: object
     then:
       additionalProperties: true
+      $ref: serial-peripheral-props.yaml#
       description:
         Serial attached devices shall be a child node of the host UART device
         the slave device is attached to. It is expected that the attached
@@ -104,28 +105,6 @@ patternProperties:
           description:
             Compatible of the device connected to the serial port.
 
-        max-speed:
-          $ref: /schemas/types.yaml#/definitions/uint32
-          description:
-            The maximum baud rate the device operates at.
-            This should only be present if the maximum is less than the slave
-            device can support.  For example, a particular board has some
-            signal quality issue or the host processor can't support higher
-            baud rates.
-
-        current-speed:
-          $ref: /schemas/types.yaml#/definitions/uint32
-          description: |
-            The current baud rate the device operates at.
-            This should only be present in case a driver has no chance to know
-            the baud rate of the slave device.
-            Examples:
-              * device supports auto-baud
-              * the rate is setup by a bootloader and there is no way to reset
-                the device
-              * device baud rate is configured by its firmware but there is no
-                way to request the actual settings
-
       required:
         - compatible
 

-- 
2.43.0


