Return-Path: <netdev+bounces-194844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C40BACCE73
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06711896A6F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D162580D7;
	Tue,  3 Jun 2025 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYCA1Ow9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2E223DEC;
	Tue,  3 Jun 2025 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983762; cv=none; b=JPAK3nhdzHXCo2KP3ZdNm+4Glrtky+siBIFgluoxv3ahvPljo118eW8f06c0tI9LRRoRdhor4nQXpX8JCyoBQJKIgIRFznxfBS20y3WyEw/969+QxTRkVz/eaeszzGDCGjtctfSTsvjW0H90+0lbekhl+DQIInGA3qJoUwyPIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983762; c=relaxed/simple;
	bh=pJeUhTGk2r0dYnI9s7giRBaPfqwvTfhWrM/fvTBAFIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVGUOoG9701g7HULtnENbXc5j28hbzuUCV3rMPwjoaijM/t/FfCrwT4cBsptVBiTWZk9PU/pAWO70ZYENIk/Qat1iXe82LFYujOP04RxDN/IlfA2t7xm5j4x7x+TSXbhErc0y1norsDrq2ZXVKOeSBYd4fqIzmNTZxII0t+NLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYCA1Ow9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so46680305e9.0;
        Tue, 03 Jun 2025 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983758; x=1749588558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52v/QbdUUbBmAHN06fRxKClhmySRdSIjGq59EvdtlaY=;
        b=cYCA1Ow9OyVWFR5iX2YwCxf/65EWiSyAcgJePQAaQMWEW+C2GKd5uKISnth6qqCq6H
         v/GDuKfwisHSjlO82Sib9oSRPwaJxVp0GjXwzPsRBrT+OmZGVmIMkyPf6Jk2b5AmoM/8
         KHsNwzsbD0fK3PIfF5NqwXHHgSpXqSaie+pQeYgtxZNOIqwB7QNGow0NkJ9fvL70HYFx
         dZ+Osx+WvXzc1mMm4kGntryfRRum8mQfflUuuc66RQpdSyPAof/x2Jmmzv8Py/w5b91d
         hXpqKQref7dv54hEx+Ok6mxgoByeBlfSTmufML/0GvR2RXKEKWtV+RdjWX8ALU6RVFCE
         xbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983758; x=1749588558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52v/QbdUUbBmAHN06fRxKClhmySRdSIjGq59EvdtlaY=;
        b=erb8jXf/QOapqdhTDJzpaBPIH5IpRlmDTJW1z8l4T0jX9Vu+aBjDrDC+So5rj+MemG
         5JpV+IsSGeuBXB0NncDdX1roPEqADP3wV6zGSGFv0FTAoCVEsFuWEiwsL9OQ/ZNGpQK2
         YSlQSWSGfno44a1NApiO0FyLgUQU0VGeRfyKARsljmScWACJu13jHIPIqQ52sLoP1jlR
         Xt39QqtSb+KW63PqMJttq8CCz2l46G8ZMN52B1596VJDBU/hGX2ScL/OoGo4E2UguXDn
         VRfCVHNEB1E2pTqPDcN762e+HkJyAOd556fq5LPIF88JkL0jq5jS8B+u02+iAk34Vzve
         UIbA==
X-Forwarded-Encrypted: i=1; AJvYcCVXRrKxkEy2s2cyRbVXpA97nqiUljXd8jike3EvcnWijnlSeGZf+TrGEJCQVLEpq4FZkuOXkIxg6ejjjCQ=@vger.kernel.org, AJvYcCWjJVAfOfoQD16OgqhDN94VykjqQeh5IpMdzyGhuc11rQf1pNJAAIAUEhffedEm+fSBtElwBnmP@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQTNwlQRf9grbMc7SADl9KkvC+N2z43PNzw/4VSDYKuutVNBe
	66ynyoAXYFDxQAQNWqJnGCHIeDs4fKjZ4rpIpQAI21yceQDNDnVovOuP
X-Gm-Gg: ASbGncsKwSNUmf8V9JWQObYxSquNIeuVD66Ifl5WIRp9xZu7kEe8RlcRBGDc0vxaTK7
	J/QtYBHZB5p0Jb+kaZKg9QlhRepAQ7Z9FgGQu01O29/UDQPMQMJ+cSdPZU84k2kIKsvPJ55I14a
	1nsKU2/d4vIYGnwjyq16bjh7yrYVOW/1AH0vGKWmLdw2PAcRGCfWKCNGIPgjO9l0LT1nkzpN8WH
	4IhYTU/u/EBIsh9EJBJoh0g2Dyo8LBVijPHqIVd1N9ma3UPy5QcmzsCvbanUALBrGNjmrxI8iM0
	qqs8EZ8leFLvGIu2rZ70tahzOkZOskS5hrggu/uQKqUwd/J6KJx/ltjv3C7P+xWTmwKZu+reRI/
	qb5XyqXZj2rmFcrkGMxQqPk3wT4P1r9Fk8BZwaW75RpBDbwWGFzju
X-Google-Smtp-Source: AGHT+IGHYkpyvUUrj7nWooHHRmfgpgS7hoX5OXbIZZL5KGDhdzj/iQAOMwGWeClAIz2T3PkaS/r9Ew==
X-Received: by 2002:a05:6000:40c7:b0:3a4:eb0c:4087 with SMTP id ffacd0b85a97d-3a51d93450emr151649f8f.25.1748983757536;
        Tue, 03 Jun 2025 13:49:17 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:16 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH net-next v2 10/10] net: dsa: b53: ensure BCM5325 PHYs are enabled
Date: Tue,  3 Jun 2025 22:48:58 +0200
Message-Id: <20250603204858.72402-11-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603204858.72402-1-noltari@gmail.com>
References: <20250603204858.72402-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register to
disable clocking to individual PHYs.
Only ports 1-4 can be enabled or disabled and the datasheet is explicit
about not toggling BIT(0) since it disables the PLL power and the switch.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++++++++
 drivers/net/dsa/b53/b53_regs.h   |  2 ++
 2 files changed, 15 insertions(+)

 v2: add changes requested by Florian:
  - Move B53_PD_MODE_CTRL_25 to b53_setup_port().

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a9b19451ffb30..38c08f6278d27 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -659,6 +659,19 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	if (dsa_is_user_port(ds, port))
 		b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
 
+	if (is5325(dev) &&
+	    (port >= B53_PD_MODE_PORT_MIN) &&
+	    (port <= B53_PD_MODE_PORT_MAX)) {
+		u8 reg;
+
+		b53_read8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, &reg);
+		if (dsa_is_unused_port(ds, port))
+			reg |= BIT(port);
+		else
+			reg &= ~BIT(port);
+		b53_write8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, reg);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_setup_port);
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index d6849cf6b0a3a..880c67130a9fc 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -105,6 +105,8 @@
 
 /* Power-down mode control */
 #define B53_PD_MODE_CTRL_25		0x0f
+#define  B53_PD_MODE_PORT_MIN		1
+#define  B53_PD_MODE_PORT_MAX		4
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
-- 
2.39.5


