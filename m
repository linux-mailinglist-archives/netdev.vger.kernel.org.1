Return-Path: <netdev+bounces-244804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE63CBEF2D
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E2183015127
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB732E74A;
	Mon, 15 Dec 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="NsVvFFhS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8D32FA2F
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816719; cv=none; b=Ama+F+nVbHpyyekrV7Q7CpE7EyQoa6INviXIv52dVgolHtZ2WkBIHvjtayrC/h/L7/umnyOHr4R6d2UpsQeFkgP36BgqoThgmzZKPyVGevPELjndPRXLxd2K2nPH45wKADHiaGTgefLR1wvZEXyNgRAvNmSij4v4Jf6u0QkQ2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816719; c=relaxed/simple;
	bh=QNwkm9U81awz7MWrlZNJ8gv2P0ICIp/KsNuSQyBzV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFOOGJLUHoh3oq4Gj2qDCK81uLW8U3VQaxlZsSqTfzEKoevkYWHondbjFDV0D1IbnbXWz0AAo7Lsn6QStP3c8GvHfhDPfkdcLhat+S5q5qWO32X5DgyWBAHDJdKPZN8Hxb5/EH3Lf/a09m45ENSngp3u354Oy01cuaCMLSCEkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=NsVvFFhS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47118259fd8so37291695e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816714; x=1766421514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxaNMbhOAlt3TDMVPp5Rm4PIt/K6yh2QHyxLJcGOJ5Y=;
        b=NsVvFFhSrTcmsEq+9aWzF4cCJXY3RNtfTOELWK/X7PK6FcAKCiLKNqtYjY2FMogtrO
         PLt8Wd3BJ2nN7qhu9uLiiubIO820dt42IeB40vKIzDQhYuvBsk2DodCyA3iNPLJG8Pmz
         KGhKAPGRnkY7L2iWfDIL8RhdqfuuBSwBNYa33s/hhufc5wmQ8rjIih/h41yQ9unmNYFW
         HXB0GajUAQJZ/S6eLuOag6yycLOYvqFT3BOCA6pV+RziKUHaUgAy5tRVSj1xOK2iW2LV
         /SJzx0opgUKWAysIRljHP/gNLyBP1exfX27FAnuEng7fgZdfuN5YjJuDd20q495urx7X
         l/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816714; x=1766421514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxaNMbhOAlt3TDMVPp5Rm4PIt/K6yh2QHyxLJcGOJ5Y=;
        b=Ywoibz65gIg9joyWeFX37erTNIuAOvltZFw5StpUThSJshiwOCU8oZ6HkmuqKgQzdP
         V3QZRsSPwH4EQJwDqicXn26lSVakYrMIzPKyMjy4iJN6O6kF15TxRhBwTwtLfJs7QMLb
         AJoALI7hUWSMm3CDhOSvz3Yr6GTiVpYh1QbnK/BZPg+XQ25hbbigH1I2F64BaxjJYh09
         UTbpEHFN5a4+PAev55oC4RXIXK9sh7LxaAegJpfBmN1uIT1WWEkzJhRNnwW5mWxBCD7K
         uJfCfDq+4egEpzD0S8XwhB9+cbm8VLRe6b0W52lcAwWeEqLu6s+D+D0/8QqEfaahrChv
         VZmA==
X-Forwarded-Encrypted: i=1; AJvYcCVWLwzR/t9q9rEDEC0WC7HBW6bTuAYj3vgWHHOLpqM2frzVKoLbUDv2H/rKvGpjrIevH92sPX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmYZGwHgToCRQbNFEsAI+n46UYwkH5VjkUt+YbXPnqYYxxcRm
	YqMu/B3Xcms2+gBEJo6oAbe85AyJ/lxAWcWdAt+wxzSSbtfdruok84CO84MyGCAq/wE=
X-Gm-Gg: AY/fxX4HK2TQEiopgYTJLbILBhfUp9PEO0f50/CxuU3O13dOF6mDHE2ugc9HqYlIoFZ
	YJr9tq9qufZiWrRd35bfu9zGYCM4FGZ1GD9HBydjIE0VlU/lSbV0GvvR/v3yYqP/NJvZ5Cc9BUc
	Jpp97ocOgHMbttfJEu6nLfjl0JWpjUlDtQoVBIKaMLjUoBRGI141NUEGVJAzKyJGo5PwhQLNLZG
	YFMkZKIgbD7eXqjog+8KBdhhaxecfirQ/hBLZ9vfLgyZOS1jCZZhg6t1okeybaigmCwN/O/RQV+
	cMLz7Dg6diTybVSTl7cL3AnELw2e6oz3r/pB6/OpD3lBK5Bs1cvgenG75L9sbfy5BlDKBHebVrD
	qNyJEyKPurTBCO6KaHj6XPhEQ3nv99EIGtRqnxyqOXQSK0xXq7TrWxgQ0swTt+Lq+Mby3c9eHa1
	wWA3a4nOnmGtWv62nxnM85AkHv9f8TNPnuEHSyy1SGGt54
X-Google-Smtp-Source: AGHT+IFmd5yjjsN4pJIoEKmwS1dt07aTMkZ4FgJk47aEX+6lFjDEQnmHIR80M20dZsQbY4fZQ9SOEA==
X-Received: by 2002:a05:600d:6443:10b0:477:7b30:a6fc with SMTP id 5b1f17b1804b1-47a8f90f371mr103502135e9.30.1765816714084;
        Mon, 15 Dec 2025 08:38:34 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:33 -0800 (PST)
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
Subject: [PATCH v2 03/19] dt-bindings: arm: AT91: relicense to dual GPL-2.0/BSD-2-Clause
Date: Mon, 15 Dec 2025 17:35:20 +0100
Message-ID: <20251215163820.1584926-3-robert.marko@sartura.hr>
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

As it is preferred to have bindings dual licensed, lets relicense the AT91
bindings from GPL-2.0 only to GPL-2.0/BSD-2 Clause.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 3a34b7a2e8d4..88edca9b84d2 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
-- 
2.52.0


