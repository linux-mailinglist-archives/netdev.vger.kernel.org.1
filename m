Return-Path: <netdev+bounces-250128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA6D243CF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01FF30133F9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113D37BE7E;
	Thu, 15 Jan 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="BzmUI76H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73E37B419
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477256; cv=none; b=g88G7bqvyX9TSHfKrd2LD7dG7ETqBSdqSfPozMvUXX+rR7QiBTJrXT8gIKlqmKstf4xpV93WfaoSxBWQzo94bEn4Z8Skb8p6R+lILiM7zXzt6Iy/Ir4Ss/m6ZI95Nlfm7oFaspd4Rzg/eXAEewB2kuqupu1x65wCs0AwAz3H/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477256; c=relaxed/simple;
	bh=b/54xVwD9NWBApT/YlbKlATwkJX1Z2JAQOFmiza0IIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhEvq88N08pwZAlfgSeXZNCbeng/6FFJl+IfQad1/D3pghPegFGXIKH1dD5kiSXje8721I917UEmEkS0NvgrC9dXJo/muH/0/o4LtIVHor01eMIt4y7WD8vGjiy6mBwfT667S1Hiz+++zLN7SgtzsJIPr7fbdu1iKG0EzbLb8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=BzmUI76H; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121a0bcd376so2134433c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477254; x=1769082054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3+In9zGTnNVCdfWyUqUmvhLH5cDZ41X5IQo0vghvEY=;
        b=BzmUI76HFoIf+H2p1c/j0xVbV4COe063YZKargTzFj/IGBRMeJPYbUTaHaxA3d45xG
         z8lSpJ8fz9wv6JQE09xRzLQTKoktg6GvXS/a8od588oaSVTo+xhBZ4Fqb74NiN6xvQZl
         HtsQUCSb7ngWotCTs5g2GJnkserXtPybEEXO1A2is6tuUeQVQ9jfHuQZVE8uX/IxPmM+
         KVHrgxVVvGxbUYvzt2bh43cxu90LawRwhWUJdAaZRIBmJZl91t5X4KDK98mBFre5IhJh
         k1dZtAE8z0oetFMzXE/+2TxlBijLZAi0Zr0lKGTLzrmxY51ROW2ekXGE3hQheRXpbNd2
         9xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477254; x=1769082054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3+In9zGTnNVCdfWyUqUmvhLH5cDZ41X5IQo0vghvEY=;
        b=Ym4xlEoROi2cZrlfPRVjatx+0qG/5+bRRqDUYXpRKofgH726CSOe+xNrJHIckmRp30
         9Lguxf1+2d3wajFZnkMTWoyRSj5Ly5WxiYHizYhP7JDNGUfx0ZOCgJ22mUx6eMEiyti+
         9S/HE6xN05Ijuy1YBIQeStaWY2tDvIC1/aDxPa9dQsxncwambYrebxjzCX7yM/rUh/hr
         BlX14BCbEyggjlBdcToguPW2t+iplirbCtlMQ4mO206BNLEUwD4QKCXSt7+GjJTRaj/a
         cWhDTP4llZaVbeX7nqwU0TfbL+GySE+Rts8BbHjMm62nsekoMLEd1vOA4XVACsFsw+3U
         6wvA==
X-Forwarded-Encrypted: i=1; AJvYcCWz1WK/7xO2m7cL6slYd745kADNx4Xwb9nwxuJDU9H+PaBsinpwnCckvZ+l1lnRoz8494FzL5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCzIM+4O2/KvpHha+NAMz02+VubgCaZfd/eUac0vdaFEFXB/x
	+aHQkHrmUWOxxUGcwi8zj2yrv4xfrezDZWLiDhjXvKrUzDrPy69LR1fvc4r+4Gji6Bw=
X-Gm-Gg: AY/fxX5aOrN9S00OW+tru3n3/99JBSlEa2W4K/MmsjNRL6byxEKbYoSyD3rO8nDABKW
	hA+ZpKEwlOGI/w/cM9Q507Tu1rRvq9tQxXpGdrwPMo1+EOjxDPYbYEbdsBmM0Y3Zv7S7cpt0Xr/
	02OzIZ8wF3aZwKyAMTut0925AEmcgCyal8tYp0FSp5/Qq+B/uxODRSupALEfJtIt+tkFfVdAHWM
	bCXH28xaKz3umBGlynFjIG6tiMTlUNXchQpxCjJNwRez+cKez98T4Kimltn51RL8vLBiXlgIBP8
	TNTGTsGc6anFP/WX2fEHXlbhrkS7HvTisg2qZJKZQwJ68RXe6/77MJrUyVxfuow5XpvhWDQGzhe
	iS6uqmWBqaVGItPSqP5HHwtRpIPzz2TaV+UXL2us0F2lwTI70mcAsJiJKCs+SB9w4kmuon/BX1E
	5NPkKLcsOxFiP/1rk1S1NPIryXypQ8N0gChPq49w1eMFjxH02wPlls3i8piqOYB58se4P/qzPGW
	ABNIIO4
X-Received: by 2002:a05:701b:2715:b0:123:3461:99be with SMTP id a92af1059eb24-12336a38feemr6811395c88.21.1768477254152;
        Thu, 15 Jan 2026 03:40:54 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:40:53 -0800 (PST)
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
Subject: [PATCH v5 02/11] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Thu, 15 Jan 2026 12:37:27 +0100
Message-ID: <20260115114021.111324-3-robert.marko@sartura.hr>
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

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 087a8926f8b4..375cd50bc5cc 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -24,6 +24,7 @@ properties:
           - const: atmel,at91sam9260-usart
       - items:
           - enum:
+              - microchip,lan9691-usart
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
               - microchip,sama7d65-usart
-- 
2.52.0


