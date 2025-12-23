Return-Path: <netdev+bounces-245902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588DCDAA62
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 22:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5BD03084F20
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858834EEF8;
	Tue, 23 Dec 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZccbyyzW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6534E25D
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521243; cv=none; b=JdH1rUGPg2d02SJ3r3Y2u4H20W7N40YBlPyGAZPE058bDsF1ckvim3eN90KTuHtuzbAY2g/FoSHTccZ0ebk9pB9Mh9omIC2f+DlOGMqXTsLgOv7TjIZmro8NWdLBX+o1to3NkQuGzV2N/ECAP9LRtOhnJr1YQOPrzLt7BlK6UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521243; c=relaxed/simple;
	bh=FesjP41xiT0Kda2nCLhQhKtJNrqGgysPl3yJ23vj64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+lJj9j6udZIwaFpZuk64WGqdJmQ5DfzuuBlBHMuSBAVJu1hrax3zIetT8Mkdrwcz1LKOIb051KnmxUOIMgOhm5gF7THSnMa8LAD+SU9O+FG9Jinhdjyugah5ZInejWMy+ts0r6/QFeXbFS0UEvk0cXSTwrAuQYV79dauAU4Z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZccbyyzW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5735199b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521241; x=1767126041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClyoGQdLbQ+NSakHU5SbIxGsiXAmeIUAvdUGZfMfHas=;
        b=ZccbyyzW2lxJMbJYlm/wBafWsE2XB2bAypOFFnOukvOGI4F8bnHvNijeGAjtavqUGB
         p0NANjErF7ofDVkrLy/JmBZttd7li18QNaynTXMtfLOpiv0nuWEKeVd6DYSHktO1ISNl
         6HyxFIVBPwLfGivhk+/vTFkVzBO162ZkHkA0Jkp141/OWZ4XiUFeOAFelEoZvX1rskGB
         Wmk7CX8M65WvlFHXo4cHRpqzkjaDkKV3yp4+zvmH9jj17QAzZ6OaiuFPVXcNUQshasmH
         a2wdlKOVQBgvLOgq5SEy9w7xvNTCfKQBAhS5xqnESy2htUeDknWhV2G8qFo/rgWWwYNn
         KE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521241; x=1767126041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClyoGQdLbQ+NSakHU5SbIxGsiXAmeIUAvdUGZfMfHas=;
        b=e3Bw/gBWZBgf2nye7lM6AquXFs6K+WVH5UV/VW27TfuDTszC1OakzPs8hR1R6gH+Ev
         TuIgCGymNK9K+kmYEU5W8SD2Dojp7f/u3HRbP08No1vRUuSi2PbwDjnytJtsjafi0s2/
         JA+5TJMKTMNhYIN1EzSY7jyhup19sVcL7K4YDDwOAE4EgN4CT4ttB4KGrbZFc9N8tTV7
         uvdDKTbl0rbyA7cgBtcZTJXqSHanmO0ZjHmO+7N2chTWmdpN40sTXL8ffu4Kb0gD0YBQ
         dg0mVOmEKlliIskOp3UNWeBHrTzqc1lxtpmVEyScgK1xZpeGKbbYsMlpZF3fRmMqxJ17
         ZZWA==
X-Forwarded-Encrypted: i=1; AJvYcCU42iA1NV+2ZITHcEi0GSXM1Cogq8lv/D6RaOkTGknrBgyADn8WOuN6Us3RewPnathmUtZ+6Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOviTDMpjF26pTzdf+iEWejqROdn/idEis6CwjM4jL/L/9PCw
	4bC35waa3yRgBjHqZhD/1tvJzfuLSf5oUjNOTPmF80pXSTU8QOxPFMzZi/6yphOsYdY=
X-Gm-Gg: AY/fxX4fQ/coZwCZH57SotI6LXyh7hZfgi39pJUxmeQR32ybvTBwuYZMoVgpwfyjY/5
	JPBeyu9WxPT8Oz1EXhvtojeQUGSk9WZV3BXc0s9smCYOWn/csy6/96zpIOKIaZl+YAgKhPCLWIj
	V0E46zpFFhdcLWdy0YqRyiFGWmk2sTy++AzAWwuFYNgFJMuRPV3Kb+P3JXnEs1QzFeLcHGlGPQ0
	Tc7tZcRXlhYmCPDkHXcBZq6kpA9VbYqwy53a4h3zZ5D9jozYFOWnQXTHEZuwrITxtlOOlYRE6EW
	xuUz4jst05+GaoG1VFZC5utF2GaapZ3fhvheV6q5teKctMyMeUYhX4cgWKQig414r3KYceqSWvF
	8UgjLLKP3NsmsZ99B0n3qTFumOnT3uHLLv2mzBZYfp1Xm58g9iEQPRB6Qfk2vHNG/AVa9+oq47W
	qy4F+m8X2Yn7zixMdF/x3W/QCQCUaR5mifC9Xj4LJxbVmUI+MdKhcVD7IiolEmXqTpp3m3LB2D7
	IJ08zO2
X-Google-Smtp-Source: AGHT+IGuoAHYa6yGZT2xpCk4O6bUCM8poDOiYCaAoun2Nvyagb0buXaCaJOvoitd+kEUFeEHxHKv2w==
X-Received: by 2002:a05:6a20:9185:b0:343:af1:9a57 with SMTP id adf61e73a8af0-376aa8e98d6mr14530108637.56.1766521241361;
        Tue, 23 Dec 2025 12:20:41 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:40 -0800 (PST)
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
Subject: [PATCH v3 07/15] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Tue, 23 Dec 2025 21:16:18 +0100
Message-ID: <20251223201921.1332786-8-robert.marko@sartura.hr>
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

Document Microchip LAN9696X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index f78614100ea8..3628251b8c51 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -19,6 +19,7 @@ properties:
           - microchip,sam9x60-trng
       - items:
           - enum:
+              - microchip,lan9691-trng
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
       - items:
-- 
2.52.0


