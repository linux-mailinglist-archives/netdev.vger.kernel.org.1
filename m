Return-Path: <netdev+bounces-250127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A553D243AE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42E65306595C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF737B3F8;
	Thu, 15 Jan 2026 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UVcP/v20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C132E739
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477248; cv=none; b=ORhvGQc+17kMgYHIYC8byqhmhivOZfP0LE/zEecwIcIUi5ASraLjBPCTLnXb/TGUeGEGZMLLKFbLTuOIeTF95ja7wVjPfx7XrvqTcIV2j78k4DSFZwyRTUvdrfLlqLFUnEJqASM3EIdMvMyknmxS1PZAH7vcbyhpd9Ycv3A63BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477248; c=relaxed/simple;
	bh=WWvO7fvS51VGIasNJgUp3QyEPuObUZpxHbR7pn28FTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY6f81Fmbr159wriL6HuLExZV654EP+nExJ2+RVEtc1D5/o1Vdt2F9rO0Y8VDigwDZ0uUE5CgLpFjTqncGs19Fe5ZTLiyi6vCLxP7b42kBWiaRdOKX3jmj3sesQGb17AdUYHf3SChXSDKIBsGbuFOgjG7+2j9dAPm4V5VmyCQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UVcP/v20; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-123320591a4so789738c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477246; x=1769082046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEJGOG9KziC5WmpmFadtMIPKcgD9jyuKUB8JZhjDo5k=;
        b=UVcP/v20an1Ri/KQX0pwKtk8IAvtwsby0xjBw61cKlNrVlC3TDhaqpNaluYDS/2jIM
         BWRr1w+09ZCctBa2GQGQxakTSqfDNXYv3gb9kcXbnYzK/j3ghIrArgDxhs6vWGUp8+oz
         8LISVjzM+5XaCtbqkAGVoGpwEvW6JpAY2v1pvUMP1+rMTXo3eg4HGJn1CxRU2zsaJeGx
         hvT4IEdvfB/SCQiQLmtXEG5pFMpWDJRIQvvpl4zxcqkYCpHN4rAu2SCJ/cI6615bsSsL
         suoU/9ddLvKABiycIMuTvbtzXnKVugaz1cHH7XQ61XUJVkJFz4lhWMBiVYPlKlSIoXT0
         2QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477246; x=1769082046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tEJGOG9KziC5WmpmFadtMIPKcgD9jyuKUB8JZhjDo5k=;
        b=Dp/GELIDP57cGs+LyNyHzflb/plqvVblTXSQ7xCP2q6+I+EA5zKaxTWz7y4VNCaA33
         DrcWyOqY3F6SihIn1GDXTn6G8v9VhK+HPPX95UJK4c5lSMYk0N54+jWpfK5bl5HCCkoo
         Gf5Qvr+BHZsM+moh1oam+elqPixLvORe8RSjkoXd6/YVp21eF7KChJuqNuX6Y11Pltc8
         e8IPNDHvuQqHlZLaXo/H32rP86yduPoybwa1RXJntAza0QBUYqAKTGXIo/26lDlVl43F
         H0poKU06M2qlbpZxgoGzdtUYJHlu9J+yRZZH/bcbvleoznSCJepO+qixQO/BdRjTTpcx
         lojA==
X-Forwarded-Encrypted: i=1; AJvYcCWabNZinyK+9vyuYC75UthXoKIKp7iXL6CxhG2ByOZt0AS9+NAgH0CH2L/YMs7MjGVwpAmZdjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dzSfHz6pqdoL10qqvF7gxd0KC5iHX3scw0Jmto7KV2zg0OgU
	maWY4ZPmGPW4qy2rfmk3TLfb8Am/l7UE3wDsVbYfAtYCcmafhBFbb2Ijjz4NDhc/QRo=
X-Gm-Gg: AY/fxX6MpDNWVvkVQFRhzKyyIvQUZ91pj517ammXRxlNrTBcEZb1MAmpK9ldxuyLRtR
	AugcauyMfLLmNWrAcRZtGUhInbG+ndbbtwb9GIYK6Sbzh13pjLJmx3BWBk+Jn59uJ3a716vfhbe
	BMlBauETP57j6REj0Gh/mjeTH1D7EkWauqYg54AvouQ0NL2nu85bXEW9EQQGdXnsTb/8StsFRau
	VfDFC+xLS7FgKBSCyoAL8NX1gi9plsnw8wOuZ7iJmp3YZa01LPb1nRXshhDOlcOD84SfYxN5UsR
	DGTlYgKS6cSjqDqy/ys3skSz0SsX2P4HDAGpaAwOBcx04KnGQxtAnmrbRBSmJq9KQU33PtiqA2e
	3KwI/Ea8lMR8dejvSZDm4IxYXhCvn4elI0JdZ5ro8JvSQ3Fi6Y9mQ2C0t3VQB7y0aj1MlmusQWI
	UVjf+qTrf/uryA6zCHM/Y9hwKEHPPfEliFOGGycvK8tJb5qTRBtdhHgMMgfKaCpMUf3eq0kskZL
	VRO5u9u
X-Received: by 2002:a05:7022:4392:b0:122:2f4:b251 with SMTP id a92af1059eb24-123376fccd9mr8604410c88.21.1768477245907;
        Thu, 15 Jan 2026 03:40:45 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:40:45 -0800 (PST)
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
Subject: [PATCH v5 01/11] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Thu, 15 Jan 2026 12:37:26 +0100
Message-ID: <20260115114021.111324-2-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

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


