Return-Path: <netdev+bounces-245904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DACDA88D
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB77F309D83E
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8103352F87;
	Tue, 23 Dec 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qEXm32uj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89845352943
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521262; cv=none; b=rN5/UVCqIUc3+fy4r6ulZzHCwQKDLc8r4FhDRhxz+w8Vt/OyjJgvKLB5KIxXMClbYW7F8eYN2Ue3viVyx385Bv0qu+3dJbOgjQSHx3esX3zmNBad2MEAwrd82Zd6Q/zww9XvyMB7hnrl0SlSagFU2tj3z9EY8QJtW5Ad95dzjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521262; c=relaxed/simple;
	bh=7hKH5EzmH1tw2QTQXNXPEJl0sVHK/le/PcpUxmqe6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeWil4jPzHk+npTTpr+f5OiFPznIvaim8zLF8u4Mwpim6KCv64x2+PC4Mp9Q4ALZ+nB72cW/5xJp3YBP9bKDKiTZCiBqRAiEDV3PzhiHI3pkoffHJ1kNEMDD4qE9Pey9Hf34gcbENLkHEJEODlFXo0X8WU0ZZhzdyoz3galCcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qEXm32uj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so4886253b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521260; x=1767126060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=qEXm32uj1+odh+mia+XgDAG39bxsV8BBnWSP0gbyH5RJhUfEzyjInuhiC1FtX9Wppx
         KLxk0YDYruP0rpIpgefdNHqLi8+C65Db06vxmizhWFJNlUeyE4PALzO+idf0NA0jEvMt
         4bfGeG4K9boAoeBljyhuYdHQPXx1fzDNbBeLm+/ymuEu2mywxvu0nFbFozqKna0aW5o9
         UF/l+z+RE/wWwKcEoAMBfnOLbiRWzz5O8Ua1eIoWr08agzCuSQBanUqTE3b4fvbRKl4J
         RwJDjpDIeBb/IhuLWShFAWC3/IHBkQBxlolO5/7LijryExtWwxx8zreGCz/caCv02scj
         QTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521260; x=1767126060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=ECOHPbzL/lXx8/uDdIr5U1nCgsea4aJlL/+eIldP5/We20nnBGE/MfvmtyYlVfXlkK
         0rnrS5wVx+llwbZFbij2UZMvuOMYlur1X8JezURk1NGap5yUrqXnyALFIKR4RwKkX+2e
         FusX1cQ+SpETP3iHM4dzB5IaPIE2E04zlPE4uaARiiB5KKfZOXESt0kMnacDzyrnTwWD
         9YZ37JGmYyDQ+xri5rL39+qKggaMVk9Oph5WooXKELcTOSa7mgsnY0VeeBDiXc2lLdmU
         /uxsS2HknraJjNAJp8H+ihb9q1WGRdUM3I23VGmB/utfzzHTKptONDyWxfJu+UhUWtsj
         mE6A==
X-Forwarded-Encrypted: i=1; AJvYcCVBgMSCEyptQSVIYBY7uCVGSNnIvAcGDw0HilMnBgZ9d8Ojj1/XrRECsy0tYfkdtO05bpB5fKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0IRZhh3HpZuFQEqNf0x8gkuzTbKZLrvZie4j9Ob6Ry4dy4cf
	bzTAMxVWgEh+TVSXVwZrj3U20iAyP4uAaJIBCE2tIlhHUcxXHPDBanQgM1ege2I++lA=
X-Gm-Gg: AY/fxX7NBMxS/n653K5pcN5CNvXRYP+daH31QUoQIMcMNAm/TVEJVpmJfq9YtU1RyQL
	vZ8OCdMYlyuuJkK1iuk2rKqLkxfLiFQ2Z3pWsIBWY45YPgkgTq4hW8zEOPifwKUsc4ZRhnxi7S5
	DU2cbDbMYKUggjv/vDMQUOg5glIymFvVZYu7W2loTW6N985fW0i6i98rlPntrNDkBnifZ6uj3ak
	6Yrkzb19mPGZ62f7ffnkZkRrZ3wsP3AlRkIi0fTrD6PhL4KzyrvuVVFqwg22o+QtA7iyn+yF+Xq
	WGTc60d37qLYSTz2r+7veQr/ioJvaCBjLXBeDc6mmYSCJLIyIw6KwAnXJdhT4XhX+U+6rg1MA1i
	rzLTIt2aLOy2kTR09h91KQOc6Sa2tcukTBBoEd49UNrAYfCSHPo0+3AZV4FXQ73AgLn3OtWSrL1
	jNtXaoBlhwujei11kP4xd64hm5NKs4mHCpXzNzJbVXQoFSlggUAtVa4KW0wvUct12WOvt9dpIK/
	VRJGzKI
X-Google-Smtp-Source: AGHT+IHKfwHDjFbBjFoOP1ZNZG2yYIy8Xdi86MslAqVbrnS76U8emwCJO7CURd8duOcxnItzlu++Ng==
X-Received: by 2002:a05:6a20:7289:b0:366:1880:7e06 with SMTP id adf61e73a8af0-376a5449622mr15082294637.0.1766521260025;
        Tue, 23 Dec 2025 12:21:00 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:59 -0800 (PST)
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
Subject: [PATCH v3 09/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Tue, 23 Dec 2025 21:16:20 +0100
Message-ID: <20251223201921.1332786-10-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0


