Return-Path: <netdev+bounces-55227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F26809EDF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F5D1C20A0F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F27125A5;
	Fri,  8 Dec 2023 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VJ0w6Znj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677871984
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:10:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316c6e299eso1864565f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702026634; x=1702631434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8Iep3f8IbW9XJUviPCyqs/DBfreAlewexDEpMRvmDo=;
        b=VJ0w6ZnjVKt6MhKaUStqAuoi5BSIzu5jdAY91BysvaRIBaReglZTVsLbpUwZKeynt7
         wQFjh/bcTogW4rSuMVOl0Nd4AmLUozSeZRAPKK7IquP+xDzo6Bvymt73KTO0jdtwnNin
         fhixc9ndY/c1LlpMNXltsiFbtMQ2A7e+gndwLvkJpvFj1so3mzlo0PGkk1ohr1O4woNE
         XFe/fg2gzgeYhzT8wwppFX0593QEqZAQsT/ac5Ad6IwbRMo2OIHZnx14J1X9+uWqI+Ha
         tI39gi0I9FrYApCzbR5H7G7/hY8pNx6uqCLxw04zKiAAe9hfZSuR14TOTyKMCOnjzghq
         gGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026634; x=1702631434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8Iep3f8IbW9XJUviPCyqs/DBfreAlewexDEpMRvmDo=;
        b=Z1B6bpp4tmOtqznIyH7OVSpaCSG8Dy9W0jV7VpIKA3UIocL0NU0QRXjoebG3ZokU+k
         QvYCxlhW37ETAKRbTb1gUvGij4DYnnIkI2E2bneAa7a8JbS8tdkM66ue47qpxjU7rQTP
         Si2JRLok2+pABpSZjtDNPptyi/DFGUVSOdMqGFKtQGqhoRdX+GD69h+cdoroFo0QyCkF
         LpmfxpnNmyda27z37XgpqeSAAnZa98hwt9uXLvI8g6LVZpyluqUOle/c4MUjq5Cl83uf
         Y6WqVd2n67hp9DymvLJ2+b1wH/crLV+P44bJp+Xg1FmnPsyewEjlR6cApv6uTdm9N5nu
         F/bg==
X-Gm-Message-State: AOJu0YzoGU9n0NNZ1KPmqbeXzqAeyLWJCWI2GGk4dLd08jISq24/cMnm
	yMA1EffFtAeUWkE+dR5gbIox5Q==
X-Google-Smtp-Source: AGHT+IE5yiWOW3V/0jZ7GyAH0GNBRyOw6I1JKNqqH+1aLNtnO/MpQBXJiomZQ7a8GifGEgcagWthvA==
X-Received: by 2002:a05:6000:b90:b0:332:e68b:416c with SMTP id dl16-20020a0560000b9000b00332e68b416cmr1461221wrb.26.1702026634271;
        Fri, 08 Dec 2023 01:10:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm1572705wrt.22.2023.12.08.01.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:10:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 2/3] dt-bindings: net: bluetooth: qualcomm: add regulators for QCA6390
Date: Fri,  8 Dec 2023 10:09:35 +0100
Message-Id: <20231208090936.27769-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208090936.27769-1-brgl@bgdev.pl>
References: <20231208090936.27769-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add regulator properties for QCA6390 that are missing from the bindings
and enforce required properties for this model as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/bluetooth/qualcomm-bluetooth.yaml     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index ba8205f88e5f..861663f280eb 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -65,12 +65,21 @@ properties:
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
+  vddpmu-supply:
+    description: VDD_PMU supply regulator handle
+
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
+  vddrfa0p9-supply:
+    description: VDD_RFA_0P9 supply regulator handle
+
+  vddrfa1p3-supply:
+    description: VDD_RFA1P3 supply regulator handle
+
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
 
@@ -180,6 +189,21 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p9-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qca6390-bt
+    then:
+      required:
+        - enable-gpios
+        - vddio-supply
+        - vddpmu-supply
+        - vddaon-supply
+        - vddrfa0p9-supply
+        - vddrfa1p3-supply
+        - vddrfa1p9-supply
 
 examples:
   - |
-- 
2.40.1


