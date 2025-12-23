Return-Path: <netdev+bounces-245903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88BCDA806
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ABAD30D892D
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255B34FF78;
	Tue, 23 Dec 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JWd8YeUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79434D4E3
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521254; cv=none; b=Uz+4ezBbsTqaStMqJlomy9MLuVEpoEeiZrUieEaHRLXPv+b9RaNftXLonZG2MA8VNN5xzLFsx75eWBLF/EcC+Muf0/jFSVC0xjfUIJugQSHfJeXc+jqaz9pEmLLZIRV++rKcf2DmwoNm07qiZ/C7M0dk8D+Z4DPGDz6PlsIOJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521254; c=relaxed/simple;
	bh=zUvrtsolEdengocgVlyXQxoSJXOg4mGPqcC0PLdIbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4y6PWVNCFuzq0k6rlsthUX66I4dAlY7po0+QgczPmuQbs84GKkbTQtT37Q5cW7zjflGM0fBE5LTfDVveX+OQp3W44vS8VdErC71NcOBMu+/bKiRDOfHZgw4yKiSDgo9MHngz/4wxk3t7d8FidZNMEXmTKKByW7x+3pVUW0sZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JWd8YeUf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b80fed1505so5630283b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521251; x=1767126051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=JWd8YeUfcE2jxi4dlT6RjGrdeqZAThp66WLdnh1AdZbByRtMWbUC3/KQA3vOxoI7rQ
         Nej77PlWwyPaR0CweuAUAHdybLE+chQvK13KAx1PHCFCzP8dqOUX7DNszBLGLS3YPcje
         3obQGC21IXK8hIsdJaIVFWus/hPNRBL0nHrgv8Rk5tPmeAiEGaHpc8i+apiMSFebghNE
         0W0Qy8FfsEMkqnJOoL71GDcIZHE5UqsuPBST8EGPO7XAr1u45JqOy2YCVoY6QZ5iqEaC
         ghB9VRmSjvWVRdEspk9wiO4HaSDvwPHstMR28m2thH4fnj7e8ayv8KKHgpqopigvFmEG
         nQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521251; x=1767126051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=K/qhihDkB1XLi6Kt48/O27oNPiCsqDIbFDyRdtR+jSbqaGtC6tMFmmWap0JwNsdGVz
         n2Xk7zZIo2qs0Wc2RoN6uwC9a+2hxlDvmyzLSHeRkOP4UrSEYwnAcvrC+PZuQ+EO65g6
         I4ly938x+UY13bD0KJtAf5kPUbeJaUJP89lkxPYelhpJ4Lg0KzCORZ5GXONsqY843Qe2
         S/pM6T7M91FiMekA71PxK/folyeLb+pZdZ6Bk5dL+5dX3S8v5v9UwBF1lHf/DMZ3rqvz
         IKqCwyDnxAPvP/ulwVZhibPM55rReSkEKhl+FBtokEtdZvkGGdntRVk52Vq8ClET8PwH
         L9tw==
X-Forwarded-Encrypted: i=1; AJvYcCXXnoKg7VrvkX4QrLFvFc0qRQwaTVi1OtSBvmGN+KRgzm3BlrC0eB3SuFueRT7JnxGSKd2TmSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuN9IkwoOCnEGex04jxoJiqk0k4qEoUPxWjMAhzjJA2U9/cpCX
	M5j4VhD1POKwqL04cEjG64Pnr4MAwScOxee6hShvxNH+OE2JzZc3cGiKbFONFsLFh+8=
X-Gm-Gg: AY/fxX5vj9xJd5CBqzbFsILK03jUsllu7+xQUmbPsZlq+Gf6piWK/HLn4ChdWe0dlnS
	pHqER3QfG008fxW0AayiLOs6GMa92RgBlF6Tr/vWiyBnVDt1ibzq/1QoQ2P+OJE5ctGeXOkyfga
	I9lZ49A1ZmrmhJ+bKKMvI35+qx2OICa4SktCyghVHzv6Vr8y9JkXxfkFSTSmQvcheLwhbMbAH2z
	uoik3v+Q+At/7+6NqqgxqVPr1d2OdKiQF9+AWPt6AlKLt/ZrwJYduniiJPPjcQuE405kIgGURfK
	9ITzMqvUCc7Pw8BFFiXBnpBhqqg7o4uOsVMwH5CAi+yoVBj+0uEBjC7/UzsPSrdeQTfTgxxdQQi
	XuQsCzXYwqDI8BhRvilpCI0TLeeEBxqPUTbq6WSRLWrOizhXpLNGKQ2AKiE2K2vdfLhZ2NiJCC4
	l2G5CjgwBKp4nV3allV8PPUE8dIpXfqyCE7yHiSoAzgIwcz49SazG/9GoZeO6nQTY0qwkA15Lh9
	4Fb7VqVP0/8F5iddwM=
X-Google-Smtp-Source: AGHT+IHKR6G1JkjZPbcb6JKFu1uGkQq63m4FpssJS+cOb3Ug/zNWJVDVvih5redVT4o6Tq4IHHU3Qw==
X-Received: by 2002:a05:6a20:2588:b0:366:14af:9bbf with SMTP id adf61e73a8af0-376ab2e77c7mr15535010637.73.1766521251186;
        Tue, 23 Dec 2025 12:20:51 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:50 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 08/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Tue, 23 Dec 2025 21:16:19 +0100
Message-ID: <20251223201921.1332786-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0


