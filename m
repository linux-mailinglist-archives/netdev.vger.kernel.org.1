Return-Path: <netdev+bounces-244814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB5CBF44C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 18:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D880A301FA5E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1833B6C2;
	Mon, 15 Dec 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="HO5Ey94d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10E339B37
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816750; cv=none; b=ICSRcVTVI4eUPl277xfnHjzbWat9AIEGUeFy2sH7zPHN+HUZqetgjTx2Xf49QYhh0sy/QaYbpVOv5sPVIfG6grT5qVIW9Zvsjzn7HRio2LOccoNG8/KJ5Yu8UmG87TTa8yGHYs0FpCgiyeZqxf6wVJqKCSPN1yXSlSBbTVZEg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816750; c=relaxed/simple;
	bh=aWtpS5ukM6OTjJwDQlBjaGNr3tNfLPWIVyHdFTQw0ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIlCzEATXoGiwXvZy5rdzTYsKuiEQMLQczo5V22/pYqCVfGpQ1yDRy6SKonXN8I3HTPjezKDMSp+iOJwM8f0o9gkpGJ4H4dd9Ktn4cXGV51qxj4i0NT/0F80vSr2Cwt5HHdQaJWgQ1yNP/PNZIrWVTzsfgBaCHQ//n4klMHRBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=HO5Ey94d; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso28048795e9.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816738; x=1766421538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzTS/0ZyMqSoKPg7ITuPysU9ip6EyV6+iAiPmDW2/tU=;
        b=HO5Ey94dpj6zWOoz0L5L0y8X69hFWvbeT04BkwlyT15jYCnbM2FPY47xRyxUSuPqq0
         CJYW5lrSNVziP6MP42xtzYz38MBnBl+eQurdkmVKST3mU2BBuppssWyfRd1DJcAkyG5o
         nLiKHlcX3Ds2BaedHt4ULkda+iLUJ7HgaENTayK0zbAufiulvaxMUHf/zJoJY50jgaPy
         vf3yqbvNxTUMYaeue/9jMOH6gOiWO9r5tXQDeePfB6H6ovEP277cbCOC+Se54QTf2bvp
         Q52StpqomWhNzdtWO6Nw007VnuvwxvRYkKBjjmLU5SY5IHblpNiPFHBan2jxZDCBPbZF
         zUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816738; x=1766421538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzTS/0ZyMqSoKPg7ITuPysU9ip6EyV6+iAiPmDW2/tU=;
        b=LdTnMT/karj3GI6nUJm7rnrjdJy9bVWbkqRP23Ptk0Rv5tyxYYJGMNQOE17wqs3u3O
         mgN4TvDndVp5bbqsh++e7ejdP70j5wnhGvoIouO8gX3VfZEQgoVtN7Omyz8qCt1rlZkM
         yIlFe4iuJskvoOfWSSc+DqMu4rNSQUYKso7ho15hobc6BSr4DE8bFbVFJuFQZoxVJ1cV
         pMPvrKvuKU5AeBrd4N+j8cWOvTBRFGBnZsp873MnrcBsx/BUrtYMS8sDtidhAHdoQgSE
         bHEJNZRXP7X5U4q6ydNVGyJ3NdN6+0S1KLyujfEFvZjVsqZ1Z5XibKLFtEeaVm6HS4HZ
         jJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWyUj4gW8SNPfzfpbzRjprLlkAigh+uQgsyOUzmPLA5tLlOeuLYABIF6cr+TU6meKPsD0HeMis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQq2pjQq0SBErmM3Nz6jD+2zqjTj+R+JzvzHR8+ddH0zfaF8Nf
	nUKme7Z3/wlp7SiuBaTLKSf+RDjWbBU2LXYXV7GpwpELMufMEnzw6Mo4bpG3LiE2Mcw=
X-Gm-Gg: AY/fxX7j/8gNS37uS2mArq5p1J3/DGTDAJeZiklIjk5t907UL0ZH9XI90QoW5JA1gq3
	YOcTUhBM1MkGMmVZXUa4sEW6edB/QMqTw6B8bIK9U3toqMlaIRnK5HN0Q06UQh3UzPW1ia1BzxQ
	sGEyMOnPGGOctZHbi1W6S2nLoGt3mLslOjSljdk2cbdo1rCNsIdGYgtLR1SLBDBqDZHLiFMsj+k
	s6Mvs2VC0Lzq22EFlDipg/c/v4P+WL8+yo2/OKmmC6AWlvhOEeCCwn9fqBsYOEFqTVTIVXGBrHt
	DuYX9w12TMK86XZSGROxyD/RYISbiS0JHz0tqIZF1r/OYcHyE4D1/4V4SpkT3iX3AsH4UoXRvmh
	QLOnu8SM0cdcwRK0MAJmFsAo2NRfhzRUGgHko/AYs3R7cadGCv3pHeib9teSAzIEk6z7W5v45Ln
	z24M+gdu3E+dlvhh/cacPmA1A+mQFJ9U37qrqJqg5toDQ1UWLVj894RA0=
X-Google-Smtp-Source: AGHT+IH2I2yw55Q0CXhaNIPIXzNi6FBLabOFndmnwZCutK6Ow3Ht3tHRyLRJOxKZGFug1XR5+KxRHw==
X-Received: by 2002:a05:600c:3b8d:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-47a8f89c8a3mr129879935e9.5.1765816737723;
        Mon, 15 Dec 2025 08:38:57 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:57 -0800 (PST)
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
Subject: [PATCH v2 13/19] dt-bindings: dma: atmel: add microchip,lan9691-dma
Date: Mon, 15 Dec 2025 17:35:30 +0100
Message-ID: <20251215163820.1584926-13-robert.marko@sartura.hr>
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

Document Microchip LAN969x DMA compatible which is compatible to SAMA7G5.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
index 73fc13b902b3..b0802265cb55 100644
--- a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
@@ -32,6 +32,10 @@ properties:
               - microchip,sam9x60-dma
               - microchip,sam9x7-dma
           - const: atmel,sama5d4-dma
+      - items:
+          - enum:
+              - microchip,lan9691-dma
+          - const: microchip,sama7g5-dma
       - items:
           - const: microchip,sama7d65-dma
           - const: microchip,sama7g5-dma
-- 
2.52.0


