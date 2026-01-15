Return-Path: <netdev+bounces-250136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50503D244B2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9308304286E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417153815EA;
	Thu, 15 Jan 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="zqtLJLd5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1883803C9
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477330; cv=none; b=mPPtXl3veUhz1AK0G21755DYeXhHN+VA4NFnTyE0dwpZ3QQnU2ZY7Myj2wXl8CyhOQmO/wA8z9GvYsiSyz1W472TCu9pP0OxrozNqpzgHoy+R2VDwvqhnIVlNN+W7iofUcKGCe13dyT5m3Uz+L72n113D1sHh/eLM/LxjfojR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477330; c=relaxed/simple;
	bh=Wp32ITHx7s2+X+835Jbu4gJ7F+S1PggViopmVDWASsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8v9t+diSt7Yv/sRO3y2RhKJas++UzruaAIsAQcKHrTMX6dlihYtnDYJlJOsWjIRBk6+GBGDzjQqVAl1A1Blk0+fUm/L68W3ldoFwpHrk0o+85SiTiLflqMTGy0K4voUpUTk/jmxgQjv0L1m+9MKWJ9ZsaSwWZJU8p92FF/6nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=zqtLJLd5; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-121a0bcd376so2136393c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477310; x=1769082110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6BNeAKcW11oL+iAABviMYbNNLfmxyGYsliVava+u3M=;
        b=zqtLJLd52zChUvs4oYWUJHIMhxUAmPvrUA/0RxveUEHPvgdR011hU/GyGExJrIAUtw
         ovZapknkgFlI5/Zy7PYrplN8lb0nEvwlrB2bitjgOHP/9PAg1nrZA9Fj3UIvooQSj2Eb
         aOmSZy9AaiWsrmQA8A5g+8gR30/6QW10C906so7KV/BSfppbdAkUBExMMWuejC1oyg8a
         hS1eVLAVKZ6isDD7pGVC/rjV+tM4j3B2ep3BO5FIQk93c4p82HoWhGA3oGp1gXkRV+Fx
         7lVupRmwIN+TVrcbFZYu3fb4M/QxwuuB4FgD5JB2r/pXEiPUEbhi6FRsYlGJffrqypV0
         R7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477310; x=1769082110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6BNeAKcW11oL+iAABviMYbNNLfmxyGYsliVava+u3M=;
        b=YkeLZIdjSyTkay9y7BgbP7Oc7P0bOyIG6UQTQ4GSl+qiihvP1C/bSRKXfO5ZH6hnv1
         VvL4fGfgyf/Lz9FMPwPT2kna0BDpIlMJdiYJElOkVm1jGDRxuLHo/HbrWHQHIdMmSt35
         xQeUziQfDAeZq0JnHtYARYergmPyE5ZHLhlP+LdrD0AmumC+Gw/atPz8RIVN5syo3060
         a9Ie3g/ebXMhku87XVoNOf707lbstx98VVpTDnd9YcR2YM0z9CZ85fh9SNCPjoJGbVwe
         dxfqwHRuEKcJiukI9SpDUUzfa5StA+9qZGGWsI/vGWsCOHSpsGxEUfKN4MBBlNQtte6V
         8/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVrO2x12w0kSjOoADJ6hKimRnI3A4P92OK84cs/CtUkup5s+NhMdODIMIgxl7VPO9h17V/LE2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFr0HYkMEzfkUwO+FB8bxJTrWj6o1J5L9i/rEC5NryLWXr+b08
	YpMUcEoXYhBeYLCwT7vxwu3Qtc48FZPAl6ifx5DjSLMije+xuEZtVII0qknrHfGEokA=
X-Gm-Gg: AY/fxX6BRnp3fZyDj1hG4G8ogpUI+ympvAkRKWoDEpLZi8UFJKt1gKWVAdLrZoXPHJn
	qrsfxsSzFOqdz5MyjTyDpFVEPwFTaFE2i058vG7469m1DZ696YlESuErOE/JSC8r4pe1iKSFUL2
	+8zGe96l5YUDNgrXipeYo/dUrNw5iOD7CG4QnuMSGw2j0LDPDvzxhf8fc8mpOYJdwu2oAt70Tie
	9+Cz1yQECYA0iVCPrZd187QpCipLEcboaq9s1YdYQ70e1YZCE2KJIiaTu6ZAY7HodBQbe1VgoJH
	F/7FKrpbGbRshCRGLnzx0mihJreeGnTacezsiETfcubbaWAutu2Ufq+upSyqANrxyQh5tTIAJ3m
	ePi5EnDcirBBj54g3ti2xDkyjPznh7R41a3Dueb9pEcRhnxCP37UkF+nI/T876DZUgllrKygPop
	y2/TpdTPgyDAJTF9K5ykV0fr3CRy/5GRyo5fBuFy+27dtanmz5QCNALDVCR8GKuy0NHDBXyjyxJ
	aJyRw3q
X-Received: by 2002:a05:701b:2715:b0:123:3461:99be with SMTP id a92af1059eb24-12336a38feemr6814416c88.21.1768477309977;
        Thu, 15 Jan 2026 03:41:49 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:49 -0800 (PST)
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
Subject: [PATCH v5 09/11] dt-bindings: arm: AT91: document EV23X71A board
Date: Thu, 15 Jan 2026 12:37:34 +0100
Message-ID: <20260115114021.111324-10-robert.marko@sartura.hr>
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

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Acked-by from Conor
* Pick Reviewed-by from Claudiu

 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 68d306d17c2a..bf161e0950ea 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -243,6 +243,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.52.0


