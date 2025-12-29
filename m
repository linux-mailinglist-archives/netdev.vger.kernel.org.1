Return-Path: <netdev+bounces-246263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E64CE7E86
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09C5300E7EB
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7096338932;
	Mon, 29 Dec 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rAN65fHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528C3376B8
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033625; cv=none; b=SHW0D7tHtXo1ZAre2DjmI+RNo/zLatsgww51chisyc3N9XkAatky/PI8hX5zoSMxu61ZbC3/hhwBxRmuE+c7a+ru5yFui1vK6BVVbz0bqPldkL24PzxAoryl7aFcNoGTj4cH86wMa9hAkNsZwE6pjTJAzbW45vfZQkvytNF62pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033625; c=relaxed/simple;
	bh=HaP35Mv3tJhzA+ZM5JG9j+YNJFp/ZeK++35o7px2hP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx/M5H4XCOdQyywdcphEed+QUSgJuH0XASylZ5CJruNATW98AidFyk+APZNe7fHNtZMuTuSNnBNTuzmsLaCLJRR+uIVxwdhTayUyAg3Aae4vlqfdlUFUwD9dcNBcF0IKlZBYi7v6dr4ed/syeJ0DmrzF6w8ucg7LgOcXj0jFoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rAN65fHm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477563e28a3so57266945e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 10:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033621; x=1767638421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=rAN65fHmKfnf747fiu0xJKX4ZKtSEl85xWTiGHh2yK9PtFAx5rmx7at2Nv7gLO78W7
         OV4InTTTyHBGYPT8exXPdlhA73vU6K8k8ehNW80AtuAZWhI1VAHB2A7XIaQS3VOebVD2
         eCKbab9bNCQbsVlYjDiH24VxJtGk0lSD/m1iujnc9X/vX1z/w9yiMNpiMYIk3+hGuAe5
         mnxWz9YKwF1WWCodx3w4jMIzYRIE6ONts/UGsLU/+TlbLQ83X6Q0V6T5aQaK1rXQ71ca
         AaChK8GuJubAbAwuq9xpkAeyY2reuKT9cDw01CTLf0Zdt3g7cZNoTPXe+4pbanqELASx
         ba3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033621; x=1767638421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=tiFbrqQW/OmdAz4Lkq9RjSaoiKABHT1acQfeVQPyydq/Bms5M/WyrnQH9L29MYcqNR
         qEnyypBxm7aamJ7Htg/peojZDtmuolQkvLLrfkhybvwCtdngNax3AJZVBsGFsS6cGIMQ
         l84hWXJVWjvZ1bePJ2VGYffrm3iw0KSkfCcRFemHawCyqXL9nPFAd2DlhJu/1nCfNj34
         WUFgiRvDvfiJazz1Se5W5pMkdjtyyZ62evCuDNsnn5kO3StqlhlBgrXuN2YRSbc01B5c
         +7HxI8rM6lepbtvqgSqD3eq2xMCR15LkmkbOATu9J/4rIzVbg2R+Q+uTMQ1wkusHzIUA
         vmDA==
X-Forwarded-Encrypted: i=1; AJvYcCX3b6vY6R1P3QvRa/m//txR5M0UdH1cMLkzcVCjmNga8tEdCpRx3avmuxDEzVlMISTBFy6MgTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuxk3jpnNqlADn0zHg+yzkkjHQVWGYGRSSZkcF+yAI1uZVof5A
	v+qsgZwVvcSlAXgDzPGsCVFf4qVji3UPnZSMS7KK6v3hF4VNIdUCD+zFOMOdHZV0DOs=
X-Gm-Gg: AY/fxX7BOXGWpCUxqPK4ZZePoeMp90X8nfeKs7hY9Zv/gHf9CcR9kwhjRoYY7ODfO5o
	XsAgiU9t9tcLOSGHL/SXUR8moXgJiecHeN7FbpYr8f+6CZppKUgI9Jzc5LmemyTUFi2IBmXfE1B
	CJvqm7/ZE7sGO5DGdIa4/BbLRrS7UwP2Nm55BsAvglIpYcdZMEMEM1eVRJZuWAzRT1pLrYV0jXA
	3v3qEXEAyh49D0Dn9SSN1kogg8SCKs0FFGLIJkdRuUYEuASoHzUMk4Ds/OfryXbd8lCcTlfPPvm
	4sbU9bcUn8rAL1oBj0SNpB9yttkHxCjxH8Es1hoqZgJoYH45ANxpqfX0S/oe74zMUZXln11Awt9
	gsJTc+3RZAeX9uM6Ggh/iS06gNC8b/+g3dyBCWPT7nJpAKTn78Iw5VLvySi9X++gle3VSBnQBG5
	HU943bZYFeILaKa5US3jpbVPgoVn2pW7URrY7QQopNynMt6H3/7GAX35cKQXlwUiAABW3PCFye9
	WYM9GfTfhxPDCOiBnQ/UHULnPAA
X-Google-Smtp-Source: AGHT+IHraG/JyQO9QwP0oXSI7eMgGvD7CgkRfD8/mVOlJdqCEGZOX7/g3w8MfUOgGbFTAvRzzainqw==
X-Received: by 2002:a05:600c:c493:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d18ba7befmr332757985e9.8.1767033620871;
        Mon, 29 Dec 2025 10:40:20 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:20 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 04/15] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Mon, 29 Dec 2025 19:37:45 +0100
Message-ID: <20251229184004.571837-5-robert.marko@sartura.hr>
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

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 11885d0cc209..a8539b68a2f3 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -19,6 +19,7 @@ properties:
       - const: atmel,at91rm9200-spi
       - items:
           - enum:
+              - microchip,lan9691-spi
               - microchip,sam9x60-spi
               - microchip,sam9x7-spi
               - microchip,sama7d65-spi
-- 
2.52.0


