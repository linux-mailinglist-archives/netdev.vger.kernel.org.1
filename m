Return-Path: <netdev+bounces-250129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDA4D243DB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B744B302233C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC537BE67;
	Thu, 15 Jan 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nKo4jwJp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020937A498
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477264; cv=none; b=P9MEPmL+9FbNunoJYYZ47YpCfbbKCDox5+X+ydN2AmYzGiLW0l84Bcq+Q1n0hjAsRnZH3U7mGV30hGVCGxStLmXkdW3ERhdz/KkYZBeXl6FMKAjT2ezTdQYQxpu4t6OMtlpntGv1FA8VyIS6bqiSTjM1S17YBT+/R59S06HMUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477264; c=relaxed/simple;
	bh=duZt8ClU+VlM+r6OEAYG4uNskSnrTgaQSTmGeRNkhp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkpfOFS+j1BSanMS62KjdUQLWkJPyS4KZ81XwWPpgCgLjm8nvSYpoqjr7AR5vUyiJwExrxyqe45Fzr0R418UaSYASwXhEQ5ppVCtAAU/spNmS2o+GmVfqJSh4jOtCJ3VGGxC5/QYGfFaTokC+2BqpV7gCdLZtpwrlrbzlwXBH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nKo4jwJp; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1233b953bebso1971536c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477262; x=1769082062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYThfrCqrT00LXV0OTAO8hRxDqFU2JdJDLnv+fTCySs=;
        b=nKo4jwJpMnc4Vk0Ox8Q6P8HgOkyIt7RA3SGsOkDD/t/5UYaonkGKrfEOmFfvso2+y/
         Ddn+Z4sVa4c2JpWnMSgyX9reJAkW/cGFScBU8vOjaivnM037CYI8EBlQzhc+Qtzi86iJ
         UNljlu4EIFyalv9hFGxHJmEO2WbSkxMU0kdKyffPzcUdAplNOWmSp59ancih/1AqtHzC
         OOE1V9SXAU0rOCvTnhNxGRVkZ6fIhOYp+C4Yg9iT0DkyZrvpnwRC5vS3iGCoMygMW7ev
         jq2QTwA3WiPq41HEAZOZk0J5z0vlNzB4V2+oHt9iISFciWMdNkunGhmHovIHc80BP3Ue
         ZaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477262; x=1769082062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYThfrCqrT00LXV0OTAO8hRxDqFU2JdJDLnv+fTCySs=;
        b=ZNTB/sY9OicJ3Kx0aG8ZDD0rKYmWxtpKMYq/pOCaBZM6mN9w8KRyPcadRYe0lUEZ0O
         Dxxxpgxf7MWmfT6F/eXnh110thF6fMIq4XfiGe15NNv2kRzq2ALEaw9cm0KHaFpUmVOY
         E9bh0YOWP+Np3II5XBQ7ZS/EncPb3IWvoNkGnCP5+U45yH+b+q0B4YZQgCchUXYUHb3i
         qB8R2bt7PBdHt+SrVW099w5uY+yZQMigys8WjyO0Z/UVMF4L18zFECaDMqikVRfwoE3G
         Waua1S76KydIT+fpND10SctHNm2ImZRYHyGZIynTD4Asgh+fuk9wdPtr55F0RmzKfxE0
         ryrg==
X-Forwarded-Encrypted: i=1; AJvYcCWlluhC70LoZx/P3v9I5rUIA5AEMhUDbV8rwIYhWNrcF8PBU8kyTqwUwVsbXDkGwmgIaTkrHNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzht2WIXmAne5tVg+8NuBBAIIDhh5tr3/jBkvdi2NVmqFRPN5E5
	+4H3SEf4GwxI5HbjkD1Q25vdtbC6eNWkJqC+cwVgkawF+ZpfI9qdowU7/x1Q4TrVi4o=
X-Gm-Gg: AY/fxX5Koz5AT+GXdP+JH8EWs9GOdkPmnCOPY0QVJtoFfgxHXX9yb3NCJZvaPk8fA1c
	kjO+S5WGiYN75K/IiYDBi0GJ5EKN+sZsPiXCm41m+MYmBr4TU8OGmaxhX5003PYkUd3uCOXDp66
	O++UrBvdfqYGqHZe4qZJ7JgdEUT6KbZRyRVp1H7zt1n+UYZ9YAiS1ZmOAG3NuzuXAxfDrxXnD6H
	1SUt/py2DLcC5nQdivd2yxhbdREKYjubBGrhdQA8aFG/+/V2R1dFkoO1QU/TqciJ+KvSN5qCP9r
	rh8XZc7hzAJMIsKDFmjoJG9DXa2UZLDfLZTgBXMN5JPv4X/8/H0gKjTH9vGEyQ/S8Lo4UlmMgU1
	j7X7KoUO4oum2aFqI80B7ct4onz2aY01yUrJTTh5hz+1egAq9F3qKfBz+JoQSOKvxYOHmmzQoOq
	lqudpKMz2iyF3Piypm2JmFsNREzRhvgDOS9+BQJgPD2l5Is42iz8boyzqHykq/+H7uuN4hucf4D
	Qtl39gN
X-Received: by 2002:a05:7022:1101:b0:11e:353:57b0 with SMTP id a92af1059eb24-12336aabde5mr4547440c88.50.1768477262077;
        Thu, 15 Jan 2026 03:41:02 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:01 -0800 (PST)
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
Subject: [PATCH v5 03/11] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Thu, 15 Jan 2026 12:37:28 +0100
Message-ID: <20260115114021.111324-4-robert.marko@sartura.hr>
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

Document Microchip LAN969X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

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


