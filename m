Return-Path: <netdev+bounces-244816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53CCBF352
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC833017F3C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41833C194;
	Mon, 15 Dec 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rdOSj4wq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D3337B97
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816753; cv=none; b=l59IdLsL19FGmPBNWidT/Iwxfk5uoVxPWqVxul0QrO/xkNL80RRq0q+qiuwg0xXbWCXZBBd6KeqOpwq+Nss9aQyBw3enYfVkZQn4naF/om/5hqqVoFUoT59hKgIPWSv71xBCEyhXSbXXwEdVMTO5dHTn4xdZULpOmPkYzhAN6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816753; c=relaxed/simple;
	bh=VPVs4jF75VJXH8mdDS9PaTAypaYoWoEKaAjTQEnezGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZmJbQatmHqbMjCpbwqP2xmBmr9rwTJ4IrSThXAX4JAwDhpQFTT5SEej2fmGjdrswmkSPns0y4kjOCTh3VPwFXSLtfo9Tjd5y02Vh5GEtpglk5G4d4iktiUhgf0au0e00wTl0Q0t6anhRna4TUm0LaXoy4lhZug7EEo6tqXgvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rdOSj4wq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477aa218f20so24303515e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816743; x=1766421543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0OEssTGK11BYSFNM6Q5GJFG0lDY4xg8K+duT0eXTMo=;
        b=rdOSj4wqrsjjoDrsLWPy/PBwQLp46zl9eEuUKQgb+y97CiS3Cg8IN8y07z8MOSWVc1
         l2asp6kDS3xtZ2aHWxDqaSJc9vzM6urCgjKj3FYekETOV+1LiILxPJWyL2gtrt8MGo+K
         /3DZo5G654tAYzRDVh3YRDCCDX1fVemQc7YykDluElHGw3bboUpWtldcMtV8aXyljH5q
         GmLuQEhS+G1klimLthUnqGQIJYlbBHNXdYMBPG7eToWjw2j85xS38ORYohnLoDRzotK2
         Jby3X/yHHgwTGLmtxQ+/Mq8ph3r61VXRi2Lile9sqUK3tXvGHgU36sifm2l0XlEUijLJ
         EpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816743; x=1766421543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0OEssTGK11BYSFNM6Q5GJFG0lDY4xg8K+duT0eXTMo=;
        b=K2gCQu3MzhgZdiLXTMBdafFjw/8CsF4jpC5WplAhECiALMDBGfw3KAd14V9KR4npyT
         yu5Hk6T1dNl23vRp0G7u9KT++4x3mzYWXboqLVZeZRwv209tosveF3pgWGXtPWibiJ0H
         RzP1msFwT9H+MakIvsYDgJTRq85jXvJvFfIxWPAn2fkjXNBoYJyL39xwhrr36qcIz9NL
         zfFCTNHyBSFdq5Qe4CZz4NG/XtM0YJc2udFl4dxEXsN7LU0zG4TuEf/WcV8fYdISWg9D
         Mn+mPaPqOkghdRYQhE1Syoef7TkuNdlsmhM/Pg3mYsKR5uq8XKgPN+QO8SAUWKjRwYj3
         uPVw==
X-Forwarded-Encrypted: i=1; AJvYcCU6G4qPriDnLXj0FWGVnbDaT4wAnCaVXvEjfTvisU5TgfXHh7K6dm6CfwNmCmC1esyrbhsXxPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qNfgrJcD6wBARExt+ievAGUwMpf1WKwa5OHR1U0cjMx1CMhX
	FWRu5b8EPeRKBCTh/zJsTHSXzcZn1mjxAqxnV3CB3idc38Paktl0PBzPRE69ptgghOE=
X-Gm-Gg: AY/fxX44nkO+5bMhCkQX6ZgEoFk82jHndXboDjR8L8JIMzGBSsaH//G10KbLWbKT/XX
	1/4xvHYJt90amvfJJQ9WTTYGceaauOSF60icGPnzRpZVQNVd4W6PBWVRVMm3MbI3QqX92NMwXz9
	6yEDymhdvqOdqUYkJ6EMXJWnCST3vdvrEMQc2KcQGlmbszaQ4uhrtoielAXb3z1qjB3XTs7t0rU
	+5b/DVMiTqYHD5UC3wp42tEcRMWdFJJFTxnlUAYwydpMPky7C/JvV2nsBHcVm6kiVmHu4flxy8c
	WTIGXTT3CSYrpZjnqBJLE8poTBWqBiPZOvXL0iP70MLN4t7PuiljvfAad5BSrzSrMoW+LooO61Q
	DKz2CI+3m99p0g4r+AXqGmnxRnyo4yvFP1LEd1sP3MS+u53R+PGfJzybnyL+BGRTpy330Pas0gv
	/wwnMs40XwtTOsZmg/2Gi/hIs24lvpzUfsfnC+vGYYtC6W
X-Google-Smtp-Source: AGHT+IGZRk0nLa6XE7JBLcVbJ2etCXd7oowIPMfnZx4Z6qSPahCqU8A7b4zUyWiscDsHFjn+GrD1MQ==
X-Received: by 2002:a05:600c:8b16:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47a8f915711mr129583515e9.33.1765816742452;
        Mon, 15 Dec 2025 08:39:02 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:02 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 15/19] dt-bindings: hwmon: sparx5: add microchip,lan9691-temp
Date: Mon, 15 Dec 2025 17:35:32 +0100
Message-ID: <20251215163820.1584926-15-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LAN969x hwmon temperature sensor compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/hwmon/microchip,sparx5-temp.yaml  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
index 51e8619dbf3c..611fcadb1e77 100644
--- a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
+++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
@@ -14,8 +14,12 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - microchip,sparx5-temp
+    oneOf:
+      - const: microchip,sparx5-temp
+      - items:
+          - enum:
+              - microchip,lan9691-temp
+          - const: microchip,sparx5-temp
 
   reg:
     maxItems: 1
-- 
2.52.0


