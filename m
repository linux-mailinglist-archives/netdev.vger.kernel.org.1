Return-Path: <netdev+bounces-250132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E583D24461
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AB4C30C3C54
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB823803CF;
	Thu, 15 Jan 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="HH1xjzbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5F37F74A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477292; cv=none; b=cjzmQmq2CFwIojxYN64HucnVocSbPRcNdtsJ/ISdsHaz2PgPL5G3ClHOK7M9sSPkpBpgzcDE4GJEXNqZEnYk8Xuz9ahHqju5Ly6bLvHtgu2NhNBDRinQ7LDofDSTku3cmfV0FQeZJpLoTbmOdvBNwlfQyiwEfq6u/0DkHipS2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477292; c=relaxed/simple;
	bh=93VOl//T1710gnGzUbrxwFAJf93hjOVK3YA9kMeokWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2UGrTR02jHTraPVXdO9yQJq3LepP3FkrT8s61h2UnJvaUWEn0Vv/4naVYBkpwmujumBOITvVR9RECEUczh7NDYXTQHE30QXLmP18zFddJIHdTOqdLCLPBTmwcr8WQiPIlWel4TquL49jdMKYeilxYPLixWlIgPIfJKlC5w0ik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=HH1xjzbj; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233b172f02so964593c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477286; x=1769082086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HFCj5ztGvyCwGgMLXoFCMYjN9FIM/YL2Od2IwlkeWA=;
        b=HH1xjzbjFzEvFTuYaEQ5nW7+KnA4ufCUvTIGdO29F+2BByw6owFoSV5LFqgnJqmNP+
         PzIW/fii97DhSeFAVfcwYuCOKxpaYUsHwiQxuv+UoIrs9wLZiWaLsyIRlMwIarYpuXae
         c/whJBTFucAhJaV2k4amzhKN0SdMGQR3+1hRKwV96f5MKZPVhJGTk7oQu+n3IXxG74+x
         fP/OpGTKm5VSFF8Z0q3KjOfyokSoN65OXNkmggxmxdvt6HdVfaaiV0rPoB7Z+fuuUPNo
         S/eBQHnZ3qh9P/HhTViiSs9a3tqqOd1iDTGx7bUjTM6hGqdbtwlg95BySgWqt9GcdjNN
         kbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477286; x=1769082086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HFCj5ztGvyCwGgMLXoFCMYjN9FIM/YL2Od2IwlkeWA=;
        b=SCLr/JOoB67zYUJFkG3nJcX0isAk3kbiud+SFA3HYvHalit1bHAO2GMnnEJcKWKX+8
         goYT3ykIwwoKjB0SqFwEXZ5v0xdiDzvBdkYBN3gEvTdJ2+Wz5Al2YtpUeh0HopARmNQO
         b0+58Fss3CwqxvqgxTouBXuI4e81f5JmoXw4VqZoftT87c5dYAuZGDQNUuaIGDq+c3h6
         oWgdOxW7blnx4XEpq3dxXmwAvRcM4BWD1UASjSS84+HzXKCpbBSPNeYqRgxZ92cojlcU
         PWYnV4OhyWF9/lQ7bKEISIZxLa2xnXDgzz26CrwTLccXJ+y5ezyB+6KpF0Xz74zI4LMd
         9TOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjSF9ZqQUAPIXWtHvJWOPxPH7K+BCmIn3yJEDD6WwvYyYy5bO+R6lBRfHTPhsx53GuYv/a0eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwixuegVZLgpe26zBm5GPjSMbY6+FlfX6XKKasq6HimWj9aTB
	ffupoP/6NrydoLuQMl83xXvn64xRHTXUL1zA2LVOSRpC96Gep8WsVV3imA6qLFmrrjE=
X-Gm-Gg: AY/fxX57YSYLumxZUsvvYafPKsdh3pnRai1syqLn2pdzHBRDd2zxS2NJigNL8+eBj6v
	2cHuD5ASDTiwW8t34mYGineouYv6KSk7EIBVW7hmUCq2Px49XhdWlx2pbIDTjae5WRBC2KG+img
	sQPufVwNSVI4pdXqhp+Dedt16MxQF7hP9XCgNNFGztCv1hyBMaNgc5Iqk37YVQyyd8pwUqnDfUk
	3YJa4fSQEVr8qu3+fs05q+zHtojCEc9nzSpipDIMIPq30nOuj3dntUqzSA8Jv+s9ktBqmZ82oSp
	QIVVV7P/liMyO5LKD/UscZ1G2KCO7FLf4dpQbr4b8s0w5jiOyLzVVXEIo01e1SYCRHvEbgIDuYS
	XtPj6CJFMGWl2437kkaLPmmCU98TgrI6tFHZaDcS7iLmSdFajRIrGwOi1phdAb6FfSQE6puvke3
	5d0Mo8JHCW0/SyOOTBXoBKdB+uqofCHPycqgkKUP8afc/qB+aKtjB4gsX6wHS0zlR52sCMdXkbH
	zHxvS6I
X-Received: by 2002:a05:7022:1719:b0:123:35c4:f39c with SMTP id a92af1059eb24-12336a67900mr5434114c88.26.1768477286121;
        Thu, 15 Jan 2026 03:41:26 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:25 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Thu, 15 Jan 2026 12:37:31 +0100
Message-ID: <20260115114021.111324-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../pinctrl/microchip,sparx5-sgpio.yaml       | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
index fa47732d7cef..9fbbafcdc063 100644
--- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
@@ -21,10 +21,15 @@ properties:
     pattern: '^gpio@[0-9a-f]+$'
 
   compatible:
-    enum:
-      - microchip,sparx5-sgpio
-      - mscc,ocelot-sgpio
-      - mscc,luton-sgpio
+    oneOf:
+      - enum:
+          - microchip,sparx5-sgpio
+          - mscc,ocelot-sgpio
+          - mscc,luton-sgpio
+      - items:
+          - enum:
+              - microchip,lan9691-sgpio
+          - const: microchip,sparx5-sgpio
 
   '#address-cells':
     const: 1
@@ -80,7 +85,12 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: microchip,sparx5-sgpio-bank
+        oneOf:
+          - items:
+              - enum:
+                  - microchip,lan9691-sgpio-bank
+              - const: microchip,sparx5-sgpio-bank
+          - const: microchip,sparx5-sgpio-bank
 
       reg:
         description: |
-- 
2.52.0


