Return-Path: <netdev+bounces-250130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FAED24408
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35B233026294
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BC37E313;
	Thu, 15 Jan 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="O5lnGvCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D83793C0
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477273; cv=none; b=mpxr6rnfcT10RYW9hgQOkxNHgS9HpAAkoVEK4e7/PCfQKhUIKICcn/YDUNHPrZdfOFnutaBYXdgrk9VNpzmhN2+3geNiyKWD3vQOL6crQyh7twUWMSA81jtllDTok37rZX2ZlAPfwN6bdwYvZuViVVJa859OCt0iN0Q59DKRkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477273; c=relaxed/simple;
	bh=ooKaWydLYAU6ZinUS3YSKV/BPM0KTw6HZzaYhJx/zZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1IvLs+lhaOOBY0Tde80HCGwx1kuSsWPpU+ofuYFrYw0Gmdx/kg3wVzyfT7d0MGfNzg2pHvJM+TqakEXnFUYlUq5xu9aGcBHqFi1yBbh+vpVofUSy81F/VU/66LiZo3s7KVI2lFh5cF9RWZYNJAj3kgwp0aJaXeSnR1DNEOUFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=O5lnGvCp; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12332910300so2054022c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477270; x=1769082070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyqWPUPdksTIWYuKZmgo4nd2lHSjHXcu6SXb4jlQ4Xc=;
        b=O5lnGvCp5bru6pC2QaWeoBDVHfK15uwu/E3xAeyAUrr9SjEKNdMJFD808ELIWWp8/P
         cT1hffs6A20FXgIcfPjrhRBE/hnQ4mT7Cdn5difSKDrwyd2hfnL+VBgve9xW0YEZo/mK
         BWpmhZEsY0pVJb3Ze+8VNhQ3fjwCJFeMmyElICoDzR9t7Tm46dWQKLCA3fYhx4CQVHT2
         qxTosX+FWOY8D4BqXIDxbpEGADEzw9xh+L8NnwM67RGSd7pTqsiUedvqnRJm6445hNaA
         pK/cG0ss6J5hDKrm1Ag3z2x/qoAeHC3xbnYbZ8jcUMwAMJUqeCEBR1fGzp9vT/vOqmX6
         FI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477270; x=1769082070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jyqWPUPdksTIWYuKZmgo4nd2lHSjHXcu6SXb4jlQ4Xc=;
        b=XSVb15nDYejUoJvWymzaM6wuN4r9TE202egPAe+w1woXh8aLEAvZTtwVGoW1bdli/c
         rRLBpqNQPvXq4gwOHDpZms6cS5MKwIuhazI97WG3LT2MmPVDEUVvO1PRNIBLClfeUVS3
         KD3tLEaIGuBFd7npkxvq3Q8HWiYXBbWxWB/KWtyFEEyuHWA0W/bZk0Ved4ZIn6X8Jhkw
         yyln+FDOi7A9rQ9ERjEdpXwSoxodXh+gJTbuYzawfYJLTT49KG+xZOHPwyxvAAkdyalJ
         ZDF3O8JXyiZ1v42wSTdi84eaconeJlaL+1PP8UJQGbJ8aT53j8eB/dzWOToo9XhAA2UY
         jlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5VktoFw9T7xe90Ub9FpWmfTxF3jAkM92AG2UqIPOKQtD4t9IukUeoFOQOL5sruWdJEBsrHvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GpFrsxlBh/MxLJDyE0PpZ8DI1CYSOXM4lRjZFkQ+5yqYQCS7
	nqEadG5SL93g0O7k0UQN5kwaASuR8P4GbaL2xVLIy9R4MXFwhc896/jarAEYASt57dM=
X-Gm-Gg: AY/fxX5fvVsmXiz4DQsQvCAfAalKDNfmNjrnC/p5eUbkFU8jTKdaBfzgD1/g4qSwch7
	9CLf1o9drXsrhkDu0JbbyVHgZiUa/gFXVFU1SaSjXjZrSDuK/NDEE1Ygb6GMtH4NojL7ZZqgifC
	CApC28I6/KA0XN10FPk58FvxBU32z9F+8wBSE+ZA3uhy9O17R70UAGLRBnCylohBgZfj73j+nto
	KDyZ16q1+UVV7br4bVMnJq1h54MiGb+LP+v9iCChV/BytiDMVgwr/kBOtGGHQKR3HgJEFKbu05H
	ZZK/AWtZnlqifPFD4RmZitUQMn/k1lGDFJ9AjxayLC+0lD8gLTt9qKJ72zKGTDQVwhyLPjPNBic
	MGmtcGBism9SGCE8IT+FtP15EO9FdnTiPwWSc9B0abu5uwpvelQPVEkHLEPM7oVSaQIOJ+YEAae
	pj3POeUFJGBA/tVX3j/gJ1BjImqnVuTYTjGChe1REp056vvLdFe/rCCQ/QP5hUotZ4irn28PADW
	6cOx7c6
X-Received: by 2002:a05:701a:ca0e:b0:123:2c98:f6af with SMTP id a92af1059eb24-12336a45a0bmr7461678c88.14.1768477270097;
        Thu, 15 Jan 2026 03:41:10 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:09 -0800 (PST)
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
Subject: [PATCH v5 04/11] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Thu, 15 Jan 2026 12:37:29 +0100
Message-ID: <20260115114021.111324-5-robert.marko@sartura.hr>
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

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0


