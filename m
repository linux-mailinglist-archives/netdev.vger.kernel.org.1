Return-Path: <netdev+bounces-246264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2490CE7D63
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A03BF301E1B7
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2033984A;
	Mon, 29 Dec 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="DTGNbyn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF3337BA2
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033627; cv=none; b=FXtkh83QsumLs1IR51mxofu7GNXgw1pS/ITQAmUtaeQoFkmIs0eIHDea5jcV9KoAv6gaCK92dlF+fPN5Rg1nHAx+053UgUi4dbj4qOSbw3s8uY81lR2xJjQnvev1J8o1jwcNplErPtxc1CssQQKEEzPXsClGccA+ITiNRMLijbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033627; c=relaxed/simple;
	bh=Y4t8u2qiojJWvI6jSs6aku7/F91jF6sH7EKzFpxgIB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOB+NbieOS1EXpIoyj8SrmjQ2T/jaPhyaTLUQMDfZX91XQN7jMeyk217kjYjn1sjqmE3IldyEHGRpnYclTMUH55h7jvw8bFMgbXXRkXzfxgPvglDpspIZ5tyobkYCr2WtzcLOd1cJQvzyoedV9dCmCBJVEhoFItlVR6pIdN1Ag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=DTGNbyn1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so57267275e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033623; x=1767638423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSHOwUHbn+hH9B++ik+7Uc56KzBi+PoNlqJWxebInus=;
        b=DTGNbyn1RSBQrO0sxPeaM9ygJowJFoE/5rjCT21ixYEfmXuifBUDxBFEdbW710F9r7
         BzGQ0ds/Z99A+mHYr9XZSfY1ZqWHUgMzKIKU42UbJHATo25po45+0UrhGJrNOdvu+FnN
         zHyjWWkiPuJl4Zb15uDtY7Nb9KIuYtpsGspxS9NbgSXVoWgTKBsb/jNYe31Ezz30gGsi
         I6pb/O4Q6dGSnlbH6PsJJhy1rYr8KKVRjxy/T3M3BSyE9xpciJlHvWpQI353EV+Dzisk
         YHPNIBv5qfw8Bx18a9eXJf79fy5nyXJyYv+zmS3RcfsH+ZVIgaAexO6xlnIVT2cEXaM2
         rBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033623; x=1767638423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSHOwUHbn+hH9B++ik+7Uc56KzBi+PoNlqJWxebInus=;
        b=FLWngvD3Emp6R6dWjNjnBrEJuKzWPEjSf60XFOUkBx5ZRjbmwVI2hsCI0oNyG8xnm0
         WOB6lqz9v4/TUf1al3/s4erMpNs/GIS+6plcvfkRNExBZdOTM3r8YEIGK/R6echtRit0
         h7bpPLbaaKnlGZWshYDd8Ru/wzIRAQEDyINjwjiVopicjydrTE6p21uJhoLCUBpVRSHd
         o0YHBDFLA0KTNnmlbuWrQ33vVddc8WXsexdAYXjyldlAdJWmx+mMbnhi7U/E0jD6BuRV
         BlFidx0RUZ2gkUmj7hjx9JGNfX9R8E2ulnYF1Y1fOYjXN1FZ+OQeU3CgQJbb2mTmBZuH
         eevA==
X-Forwarded-Encrypted: i=1; AJvYcCWWNCmjNyEHDhys+rjJIFbhL2NDUnUo97wXmGXaF7CHnAbNdj8nY3opPDWPpoO+NchHYfGAeqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3b163E7uokLvtPsechwp5eBJYGJq9YMAUr1brws7LLpTdKHG
	bI05G/v8/+4qh1iBf2jiCfUIERnA0yC4l6f9/cAlq7r4CBnJLiPcfTing7Cai4XDh+U=
X-Gm-Gg: AY/fxX6w4nsNmAch/phR7g4WGq3NdQfGV1bjh7tkE709UEQm3fw5zbJcQXpUivC11Xo
	1BMMQFARjW1h/ec54B03aSVgbXgNb04GZdWxbEjzzERzypbkXRdfvBpMuRXVaTXKiFVhqbX88Js
	YKv75sBJewiJ9WjtbAr82rzpbi5VB7ZDB6q0qWxO4qSzkH4gVEIWb5DBkNfTNUdaT02ck6HbCOV
	l+zlR0yxwJmw2NHyM9VuWVlIlsKLAmQOQJaGMyY3UGfu7uQRaNHxP0srsRjrGqgWoKDp7I00eAR
	N9WRQur5iYbpDiK6edSmG1JSnDB9dMIYa99BSjhq/47Dba8RlzrJ47CfpCJTzzdE6obHAoiBUTe
	v/scphN9X3BVrPwtlfdNYysPjbS/LvmxAx7jkORueBZTjIqGW1uqVDz2iEGxZiqcIrTE2IN2yJ/
	CXWvevOhGxzLzkBHjnxFrd1Roaw1wSDzz8n4VMM+53YgCvY8wg/yQpY1h+BGn8/SxNsZfRB+iCS
	ho2sLP5C/l3z8B6pOVTFeDNAUPuVYOTtMaam+w=
X-Google-Smtp-Source: AGHT+IFdXHJQRkzLbrbudz/rrSLgg0wPVHDz1vodIiRpC++haL2go1AcyrpRC3xryHs5U31bxn6MLw==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47d18be89d5mr452022195e9.17.1767033622859;
        Mon, 29 Dec 2025 10:40:22 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:22 -0800 (PST)
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
Subject: [PATCH v4 05/15] dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
Date: Mon, 29 Dec 2025 19:37:46 +0100
Message-ID: <20251229184004.571837-6-robert.marko@sartura.hr>
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

Document Microchip LAN969x I2C compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
---
Changes in v4:
* Pick Acked-by from Andi

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
index e61cdb5b16ef..c83674c3183b 100644
--- a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
@@ -26,6 +26,7 @@ properties:
               - microchip,sam9x60-i2c
       - items:
           - enum:
+              - microchip,lan9691-i2c
               - microchip,sama7d65-i2c
               - microchip,sama7g5-i2c
               - microchip,sam9x7-i2c
-- 
2.52.0


