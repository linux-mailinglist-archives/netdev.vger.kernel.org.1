Return-Path: <netdev+bounces-246261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE43CE7F49
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A097530AD020
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEED337113;
	Mon, 29 Dec 2025 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="EtboB3HH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8A335555
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033621; cv=none; b=rG0Afy+I/jWoWK+luoUuwrIcB/fgURFIoW2arpGZNJjCYf39SA/vFBLdr2Wt/UeNT56naE67BaD6DNSjmmsawyzYI5iJw461IfPRqAwm6yPnpwZUZzCQ5886+EUHjXHObk0uvt13nosREIYSxa7mkZ3eMllUj2+F97jcT8wl+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033621; c=relaxed/simple;
	bh=lnkhvIt3TrOEyzf6TQ1BG1hfakQAvNrAup7QLQoickg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1ZrAvitOCbMYqgKITm/KDXOS8kzDopnKYFAWKlxMFNCUFCXl6E6J3WnTMGK3VcaF8zCZjkpp4ECcIp3Y1vutuO6JJhlLE9Jmup5ldTdX/+L08mpNk9h3DyJBRVlw7NtDE2dSEgvnYdmoDx73NJvLkaA61XSvDteM66guuMOppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=EtboB3HH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so22430205e9.3
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033617; x=1767638417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=EtboB3HHe08w0XqyvQc3lIhAD3Wrb3A+jSxyRDBnGZHNNGsDYTpopftjz07wgCqGTg
         wVeB0SBg0sYtcFqQU94CuwWFrINZ8JOPcHYxaQ6Eqrk7RF9dttwfVjkFrtKvAte42QKe
         r+FYs+x/gVWoMwshb1deUAAslnK41Cwlqc6VYn9NzC9sJc0HbsKoDjg1tHFyEjsIuV1E
         ATaaF/DfSISmFUI6qUXqycxRqvEHQLBI94pKcPYVDNRLhHS4veRqPGH7ev44aJH8hGtb
         2pYEvIocOndgsPPLrTFgpsyOh5/kaYmScXGx3p7T8JaO6Sc3tDW4z8sPJigQKU51gN30
         qWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033617; x=1767638417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=wQGkSoljTH3A2io7nvHn7E7cRXWG39hbkQXvXCKhvNmI1ozL5BPg4m2F9LzO35Ohqk
         L+VP+AP2FJS6aqwU4cbrgQv8eGrDYbSZ4KlhPIgf8Rn70iJVVfgHJFuoXfE0M72PK/og
         08hssfW83G/fQ0nD6aO2E5dm+Wpipn/Jf4WI+1Ja5mC5m+dhAXjeHCE9+KcdZWal+x+x
         fcx3mOsNd7esbMT9yWHBDhimqnXSH4TmORpvr6ScAea9lQ0UwXPuqXNtkoPwRVm2Ip0H
         1zTlByx1u5+M+ZdfSpd9pLkpbPjx7AkjJ9pz9spmWIGypuHEvJusw45KkB4YJimlG3mn
         MYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAIeV7MmoLF1Tzrp8x4TKgiL1/o7RYo8P1bPLFQHxSgOGg/4Qa4SMMrTwp8FmAuc4whTHFm2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43qwv4ZH4dOa+QxQFIEclQyBda8jJiEurb2/MEufxCdbgaAOk
	Z8/uJq6b9VAhUcDLZemWwRY28xIJ8U0f0mso8KcuoJKciRNt92gjhxujN4e0YCrUcLg=
X-Gm-Gg: AY/fxX52J0KaWBzDRMs9nNJoXy+amCqPEf37oC/nY+Tzb5Cul1IbPTrwdjkL6uGlZjT
	7Q4GD6hZ1BFoI+GgFm5nHimZWz5nwKRcRBPov4ZUCJB/sewwZSNiG8NnGPSzBFPgz5lt76ebKwa
	xBycdGbjJyyLP5wBHFtmh6Es/X2bYV6sVtY+txfxly9Kulgsm+43XLgBK8dHxd6zLZUnb7GoWgW
	3358RiNXcwSrs1x+OmUzEv0F40I8mhKxhTE72cfTTgPZoufzl9TvRLu+drkbtbCzF7VzfNkAmUb
	MDSSwZt1xJrSUrti1yAXXl4N+pgeg+B/d9tg4ypqpHItzRiLEJqYoGMDyReFSk25mY9HmiE/JwC
	W5XgXeXI6hLahL+iEK2rvvXUwdJq8TYwadSqyExHaFkund2G5nezGx2imbUtij287WuT3g3qwnT
	kRz6ZBuYUlXlFskcUvyy2t/JjnolxRi+a6WXm4W5nKskK2XVPQQsnGKOU2paxg4+AC43LmQLlSh
	ATsx0QX3kZQcdYrQha+KoAwATp/lTc69b8bWhc=
X-Google-Smtp-Source: AGHT+IGjzQS21rGuoSBITpTDpuhXFeVyR+ePrw+9us1bVyog91e0BDAjrgenQhgGZwBix2fL5K0wjw==
X-Received: by 2002:a05:600c:1d0a:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47d1959f72amr367970555e9.30.1767033617043;
        Mon, 29 Dec 2025 10:40:17 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:16 -0800 (PST)
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
Subject: [PATCH v4 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Mon, 29 Dec 2025 19:37:43 +0100
Message-ID: <20251229184004.571837-3-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index c7d6cf96796c..5e5dec2f6564 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -20,6 +20,7 @@ properties:
       - const: atmel,sama5d2-flexcom
       - items:
           - enum:
+              - microchip,lan9691-flexcom
               - microchip,sam9x7-flexcom
               - microchip,sama7d65-flexcom
               - microchip,sama7g5-flexcom
-- 
2.52.0


