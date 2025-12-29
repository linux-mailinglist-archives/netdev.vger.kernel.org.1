Return-Path: <netdev+bounces-246273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C9CE7E7A
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8476D3038698
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51933E352;
	Mon, 29 Dec 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="eDl6YqTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34533D6DA
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033644; cv=none; b=nhK8t12XEU6IEkQ5nQGzehQAMapaa22Vs0Wb6v0QvnUvR6ShG72O1+dH/fE6qLpIMAtBwmxJRqt25SbRpGKWEThUS4p65I629aK42fU3/jJD4vlDQkknAsQP2DdibvpnCnSCaWYB07M8/UAhaDm045umpY8mvYB9wBT1b01QWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033644; c=relaxed/simple;
	bh=XoF0Eovrxm1txLTrLfP7MB7ayo4/Y25gdep/95xkk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc+je59WHqJArVhgNclpDFcpDCmGZY38mtLmUfGf2GQG9PXR0RRHHimqtPCZIazmtKmlYEiocKKBkD+Kf/PZk5vOa5RO2ptuDYtSJMzd1Z8yf216q81kjBw8FmxgXr1BSY1Wi/9ZDq8YRHPiHqKimFEznXvWJxuzQClM6BZKSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=eDl6YqTI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so98481225e9.2
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033640; x=1767638440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=eDl6YqTI35mE7mdIDYxmhJcA4HqpioN6T+TrIWpO7rhwFXtvwMqpaCt2rVWa5KOT3Y
         PzQmjNcD3ZrlKKrL+sLhAkAO1G+9JFeLQ6HfZ4RLRD+vGzqZ8nbHnAvPszy0K7JPB4H0
         5i9ecXb3tDLcQBOFCP5IF14KvLKRYmOOE1wWHk18pvjPph5g85omJIHxFYCFgCNgFzc5
         rRMoxkFKU+zAxax3cIGiVYf33wmRRaGswKq8m8cmtly5hnQJEOUTlktu8+2f62IgiqfW
         u/Neehn5EO2WPKUDyLjLyQBW3zkSTpdvIy0w+c2swIdgRBGSJSsWnY55ywc/rwY0oCsw
         nL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033640; x=1767638440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=aWjLDTuNyaGul3CRM7xZIjP0bQfcdXgUiApl/Q429LMxu9EZ94yKzLGMlLu9I09upL
         ldwLpX2aPQ8ctyk6JBllEEnfHMbBGjQjYExyiXyXuAQohl+9v/XBhJsmiDkwFrM5+Rq5
         8VJjTCZhUA6738DCIB6eKCu0XdUhz4d9iznaph8rJJobZKiLPZyAC0kOlvprvTQgCrbL
         WZo8R/7x7xFQu0I8So+OtzXXB1W2ajjRF0Zcxm6xnlAx9tbFrWigdHDyCNHT8K0342p8
         3vS2l6u8a937aREB1nPL8R4nycLuBCG2Q2X4AcJP4gq1lXwY2RqPIUDHKy4mXc7IQ+y6
         hSzw==
X-Forwarded-Encrypted: i=1; AJvYcCUzuNGxw8LUWNnAIYJlOlALMTYg8lQf8WRU10kvs1VFEvQCxocmjb/de6J55Se56LVjrZWawic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPr/D3QTmTSSOhdxoIRc3wAR9kuIiYiiHRe/sImfBXLr6gMnM
	9Sk9nGijavg/FIFZ5jL+uXM0cpTrk1oDic6W5Htv+5jRzZSHNzPziu31OpnKF5uTKNc=
X-Gm-Gg: AY/fxX7UfuoqKlC4Ordk1Dktwqh4eFdmGa7lnLqg9JroKLpCXe9z5cOHXrgsOQgeCEr
	ZWJ78+Axt+uDd8PeSU4o91YrQCQ2K5KA/5Y0xIfRwiU1P5zzuej2+eJOEx40ipp3F2EmHiU5sjZ
	iKW/H5iph5A7Ch7r8MDtbTypcYYbQ90beAsXDw9s+YrdQ7oT1sNVFnlqfzZWqDxKVniF+EhpbHC
	BJajkfiwvUpaJl8E14Y+KW7bxybodq1OpJmzDPtUabmJpyI4dflKvmdLRLCbEXs7vY1QrjpQDDa
	QumxIP491/EdVwYT1nDDtctwZh/8eJ/IgDYDyqUsGqRaEkd3bTuZ7QpyoC+7j+wc2xG45WEdB7S
	rib1M85WM4sJgbs/DRPu+bNUS4154mCBcIIZwqIrouy98Nz/weDGihIQnoA1uUpmew29PC4dmZf
	RsDjUTozxETNFNr8TxWjXmIXDc4UZYqBhOiwj455VGPJAR3XnJWH1jlAoDJ1xKfn83gp1o0zg8E
	eKkx/WuJzFJ9SPSIZuT8xslnTnT
X-Google-Smtp-Source: AGHT+IHW2rHrGjnHbMx7gSl8Rbl6YVS9e37XXYhb9JI7btIp7PDkapkLHawpn2EWrbvZF2/0cVQnBg==
X-Received: by 2002:a05:600c:8595:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-47d5d272cd4mr3349085e9.26.1767033640044;
        Mon, 29 Dec 2025 10:40:40 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:39 -0800 (PST)
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
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 14/15] dt-bindings: arm: AT91: document EV23X71A board
Date: Mon, 29 Dec 2025 19:37:55 +0100
Message-ID: <20251229184004.571837-15-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
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


