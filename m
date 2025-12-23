Return-Path: <netdev+bounces-245909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA00CDA92C
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B209F3039B38
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B883590C8;
	Tue, 23 Dec 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="tqNu0iNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5973590AD
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521306; cv=none; b=noLQ6UElA+tLG58Xy51QvhdVnBre5o9sMEhqnAl3TRr0Z1sbe+TnByf2T4KO2iPTQfnF71av8ZAbN1c58xQYCg1vB5Dtj61mWBWp3Ql2S4Yfppf8fd/B69eA1wiTyFHbHoqzPBcXn1j11o+OkfsP/+ujTXPWKjskmb7osw33WBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521306; c=relaxed/simple;
	bh=XoF0Eovrxm1txLTrLfP7MB7ayo4/Y25gdep/95xkk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU2IzPNR7ZbDuTKXj6cy1fZtBDxHHe2JJySBYfBndPzdyp646QjELWbhL2nTCuvV62ixUW3Oj1Q7myRqAQlIdqDZPkLHzdYQhdw7aYd61H207ZlPxPskonenMryRDY0+pXemudZ4VDdMghafuQ6YQKBEk/xKnSetgkbtEKqpdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=tqNu0iNX; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so4886715b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521304; x=1767126104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=tqNu0iNX/T8f4ZQ0j/Yobjqpzb43xMAQ24m5BfCOWvdzq3IHmLjeqTBOAgIiE7d5S2
         N5fBPe5y3gl9uLYGhAi4647HW/5fN5LATqcvMhv8qLSObvDo519o4bPtPTd0HcrOtJNL
         +yrIM8SMF0AMAun4zHRZJCoFTQvESD1JZ71NTG7XBB+JBmw6GT/ko8ZiqfMcvI7AT3/T
         fYOEil8UzahtCc/HfhugBjuEHq4Pcujmr1Visr30t0FPiD0JQG5z8cnjJpuD0T4CGuh4
         AzOo/BgdB+0KcAyjo3REQrPASQFRboUdXtpZEUsvwTEelTK2a6yQ1+FXxnZACDRLKtDD
         LFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521304; x=1767126104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=kbpzzWq4q0lt7fc6H2wXIbvHaf87vhJAAW6yCAgBCDqJM96RCIN1XVZYqbHSvZTfdi
         Jcg8B6YqmMwXQ/Zh99Rlq1V/tbwB6ggubSXJiV/+AbMKGmoKT1CCX6sPo5U/Pf9B83AA
         K0LnstFfKbHvNpa3zUkCjqiCLUD4BJvnUge2N5y9zw0igbOJEw8dSlpqafA74xXFJcdp
         mo5be7znUhLHaWlkCCFV4Fl1vHnXPIp8EgbvCoGnSPU/+L3A1QojFPS94cNvqmJEmO2a
         7wx3McTdfdSAMjgrq3Z7VuNeg1u3MuDL5Us8kUH8H/w+d+zPHLwl/05SxgQ7X/sFNHiR
         +NMA==
X-Forwarded-Encrypted: i=1; AJvYcCUcmAQWguU70qy9PLjM7U3d5MzUVo6eqa8FqrkJJaLNdESHTX44J4i8BMpUCXDuLHdvFzjX9K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSz4AP+62Mnu7blfEGPDDdwOoOHVHuVCJVNBPlSOW55kC16ti
	Scz8Y7WjJA58hBSfGznHF2RB/ou4hmCT8xMxR0DLz4GyN8K62cuVGDGwhKAFoFVruGw=
X-Gm-Gg: AY/fxX4WRHlTHYuRCLikfrYd7Ay0/HsPB81nrEQRqPKY+5Whq176izCrlDDbiN5wim0
	HjPE4udt/QshkKiYD1A8c9lE7MVTlobtvD3lzuiFeOko/0l/YRYKl98Y1sqqi7XedbIaQu/cD3S
	SsRIYig1/PWnMXZ3zCD932ZveqnWFwtZGRdjqkBFBJ9c8OD9M6bQMcegbO9sIv3D9OB1TI27TwQ
	Mh/ItfEGPYb3mcDdrxKH14dIbRyj5gVQSo0mi+OhTMdUGwH+pH3V4u2NMgqEH4Gds+ULiy08jF5
	VkWL+0LZgh8A2zrgznnFhlnRh/rAtjQHnb+QG6kFhyVpyoMkwkJqdO+wqRHL9dXcE6NzWoKgZsi
	9ue2hnqBP14APsuCAogcTQTKN6Q8tkXha6FCU93TP9w3/ENVeg5ZQQp60EK/PO+2XN+kU1rN/O3
	a2dElmxtjIWxXPtjySFeUZk33BgtU7NgHxYcoOJtg+ZFYp4s2KW9y3/RRtR63fVVIVcXMr8eduM
	n3m2fJw
X-Google-Smtp-Source: AGHT+IFrLV1OA+vGIt1Qeh3SInjG9m4lWsVJ7UMsa9ff7itN29HXneV9Wlv0pR5HcnrOBgJnEjlG2A==
X-Received: by 2002:a05:6a20:9392:b0:364:14f3:22a7 with SMTP id adf61e73a8af0-376a9de5935mr12020799637.42.1766521304022;
        Tue, 23 Dec 2025 12:21:44 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:21:43 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 14/15] dt-bindings: arm: AT91: document EV23X71A board
Date: Tue, 23 Dec 2025 21:16:25 +0100
Message-ID: <20251223201921.1332786-15-robert.marko@sartura.hr>
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

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 3a34b7a2e8d4..b0065e2f3713 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -241,6 +241,12 @@ properties:
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


