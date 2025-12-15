Return-Path: <netdev+bounces-244809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B94ACBF020
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B61F93018EF1
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569333858A;
	Mon, 15 Dec 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="f/Uk4jf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC773346B6
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816734; cv=none; b=gqdEK+cp+s6MLt4ZQF4gB3JuITFvGF62ZCMfFCx3+uixJ3Ty/lg0N+dLPzQw4XXTDiCqdzx83z/S40lVZe2mFQ6pLmnvESErJoxCuhGQNzLV0SQJM6LLxpnksPbKpNSjdAfJMRWKxR9NBF5sKY7Ik4O3z18bIZiX5Rl9KUOAMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816734; c=relaxed/simple;
	bh=scXnJzjuPLNSqcnBYVeFur/Bhfo2CWH8BsQkTIJqlg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkMLia4bcXq4mdlEc+o3JS6kRsP+1BMRpxPSLKhqWu7AzdI+pek0NBct1NWkvf3ZnRCY/K4kh2T956/B+pZhobaHFTv6+rgbNSkUEvzbRG8dyqjoqXTyoBGXTRbZheGv2APb17BfSu+dLn7A8ygm8jE4lgktdXR0R7hzQ5uDHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=f/Uk4jf/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so24009165e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816726; x=1766421526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPjIyKwQFm6/JfqeS/3dLKxm8lxQV1Fis85PngA8h68=;
        b=f/Uk4jf/MCQ7QC0/lGEeRSSR47tTDriJfcTMv27DyQbaioho2/kAASrIt4a5+bYcYp
         ZJgpkKLA0nJDcMozIad6cn7rJdLc8Tm2E1zkk7ff/1FaOdqF6orReOxSR6o9vC5O1ckZ
         lZ9v2aWwesGBbtKVw8svbs7pCmctke6m6FrgROnx6TyUHDH7tYZCV89BQ7uHWWPIfCyj
         4CPf0hQ7/AU3x6gjMkqA/nU8pR9spOwxinJhS1d59wtu9cEJrWe623vqvNQad+4XGDc+
         z0nYFmsZ5fenhMoFo4LqgmQjgdpmhimZkSqa2fAEsMpfbFFZXZ1Z/36xrTxv6Fyz1wuX
         7d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816726; x=1766421526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPjIyKwQFm6/JfqeS/3dLKxm8lxQV1Fis85PngA8h68=;
        b=uv1tBRywZhvnINNdM+uWYDVU/W0f3rYiPjcfy53CE36QIkkOdL6wgMec468d+RQlcD
         KmwliFBt9ilSn+de5lafSyi5jcUZQ3GEsRnTZmqLh2wA6U47KZvBcflmA4s2JHRA5Fk1
         9VJiMBr4+8eag4kKLFVJLyt/uHPIooVdR4Tknc+fDStiDMKs2oG7p45spRwpJFgHPOgS
         c8DQWFpHND2hNJi5xDuNkZykdBYpEZ530Q44e6cza+8BO27SajPOnyvJQBgAqXEj5ZIh
         h3iqZPWuPoFDZ/RMxJoQV4ERPqrEgFuCbZewDgqXRgSRfD9SH0qSBGt9hV1UTgw5/rJk
         ibXA==
X-Forwarded-Encrypted: i=1; AJvYcCUFN5ex1a4Xw/76oKj9S5fgLZQGqhhVxG3dgef98yXm370w7dyKMZtCTvfaoB4EuLtMLd9IIFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8LSseM8pkYCRBKpR7dbuG4gLO7KlCN+qO6AG2L5kMtB635nR
	TkrEt49/+NMTt3gamO+QKGf1LytLCaJN5aMKaaVey0NPd1x2sq6Ey2TujDr0p5mdmb8=
X-Gm-Gg: AY/fxX5MmOoMyHFYd1PXPNFCatCBT+szC8wOs1FOCLhaMuaW2V9eq+aOlJOgPcagFJl
	zKv0njS5PZMIIHMNki8fLJNrNzmTQjSTO0A006rB8Gnb8/5MhKM/nBbqVCQnyKMoRykKU1CTCO1
	whMUDRmNVZ/2XNm7CFMdj1CXVxsaVjDRJvSFPRZ+ydArVEYj8N1qa8KhZ/HdpjEA3Gf2coDgKGy
	0QP5jbKxnofGpfG6OCx6rz5cyYwJI6Vn/3Oornn72bIF2XhJwdHCaHPlNhlntuBkkZSHM4t7F4Q
	E0fvjqxXZkkG2YXADSNSf7UQT5Nk/fAdXJwl795G4v4vMxJVB0I7H19yVQ2uDRzeFE4Xc9IVNNL
	17WxrfEPrm/me6x0JmiRqg9JR3rbarQi3Jht65+onWlVKFEq145zLGmtfyeQN6gxUOxZrcw1O8K
	YGTlqlwNE78cTMB8dYAhJwvaOwQC6y2WqLwgO/3HlhSfka
X-Google-Smtp-Source: AGHT+IG3as62jY6VN+R9xsd44rJLyQGjfxg1Etzm6TzvOyKAMBySitGXaUcEuYOfJtLLJDAMKGWwPg==
X-Received: by 2002:a05:600c:1c29:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-47a8f917acdmr137389255e9.35.1765816725969;
        Mon, 15 Dec 2025 08:38:45 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:45 -0800 (PST)
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
Subject: [PATCH v2 08/19] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Mon, 15 Dec 2025 17:35:25 +0100
Message-ID: <20251215163820.1584926-8-robert.marko@sartura.hr>
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

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
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


