Return-Path: <netdev+bounces-170466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA84A48D4D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D82C1885570
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097FE35957;
	Fri, 28 Feb 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5j59+lx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D977219E0;
	Fri, 28 Feb 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702469; cv=none; b=aUORPkb/shXFDK4WvpRTOAkf4RQGYMfZE2z3HHZYw+G+K/p8oRX1XkUDjB75ZWWbF/VJ9WWcvaVR8izV7M6u2rkZ27tH23DlBK6fzNXcyIeeJPf8v4RXz6rzbo8fYawHBXZ0vApLyG137D86D8zG0H+nQnU+i4TM1vH+1C7171A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702469; c=relaxed/simple;
	bh=jB+SAxV67/XkLO7Ja8VKYB3BnV/TpONenLjNMpQ2DpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D03OZk7EnQpJJi2/g/WiPAmL2qN44ZRmGqGFIT6E/75KaESmB0kmbXzsBo0yl2Ncucly42N84kbty0dUIbwv+5Or5MMjwqSfAErBzUQAbQdE5O/lNR1/LfwtYbQx7yUSKem+sU8ihVntCUfZqF84H3kqQHnjpoHbqklKowE4ICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5j59+lx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso2643278a91.1;
        Thu, 27 Feb 2025 16:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702468; x=1741307268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNmAyfWjthm2OoYu5rb89I5Fn5ozA8/1Vp5gyVNMnWg=;
        b=j5j59+lx2mqOZxbvHgCt0HKTBhHtCjkXMVv0qjmRMPrrbeau8jZegZEgX+pUuK/fC8
         q0Xd1ahoBBF6vWmlzEzWljauIzSmynHKqpA4tSojifNMkku7SUkabVlDm5OneCIOihN1
         R3KhOS/R3kaFo35qWjfalrEzeFH2tQ2VCOy1c2ayIGjdoEiqxZnHtFfVKlJsnfNcqc+n
         Uo6DtV9cg39zk9dDWF7FROvacDzDq7eMaP0PeJJQ2I/iKh4NCtIW/9eArIPoynVXXJHC
         7ef5A8V29owXVInO5bjRvmBdlk/+9l3sOImmuB8qSs0cgDvpu+4mKw/XdIDlLh3/Sujg
         3cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702468; x=1741307268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNmAyfWjthm2OoYu5rb89I5Fn5ozA8/1Vp5gyVNMnWg=;
        b=hhuK4wGRZr0myH4pXenlYLRK1sBJZqmI00y5khyWVpPVoPwBop3YiLI/xl9+XfMPsv
         e+fDJ/PpinqM5+bO9HDaWYHfoyRsxEMTav08dxsJAGCWuJFGNFBkMQrjdGhH8ftzO67x
         67HqtD/nZ3jJNAYa0lDYYicMRxZBnRBEBvkF8U+hLiO1eJNCcdqD/4BIs/kcohNIp86U
         4w1QXrYc/kduCUseUEqx44ZYwjAbK21GcbWIt3iDC4RIXxuJj4jJ51N/uFR7E50GRbSo
         Sfyn0WqvlVTiW7z29ekFZ82Ec5oUqffuB27NbfuKdc6Aqg8KUth7wTTN0UWqkWefSuvs
         vAbA==
X-Forwarded-Encrypted: i=1; AJvYcCUL4ZMfPq2+JxsfCxV+xXnpoKT0yj3OPNUa76vaL3mMMsG/SBI/qRHMsVIYiTG5exCaOoILTSqjLd1W@vger.kernel.org, AJvYcCVAMNeMJ12m6PdNGFUyMJ5ZcdwRguVmsYUmD5RfH5ZfmjBVC9zCS99+4XYmQT7+PKH/evoZ6yJ6@vger.kernel.org, AJvYcCWyNT7HIbFqY7aHa7QMfC84f2sa6dQRI/QiTw7CyJwlHhGeoE8WbXxqZqdrxmKfLayEm+W9SI0HNU4Lmiwb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0omVh1nzDQLhcTG0NlKiwUzDYgJxremRfqz55fhQTR6lzbkHj
	ztG1xjEcKn6afDEKhqlFFBBVdR4DxmzCRHPJ3SLcHS10W6LSevH3
X-Gm-Gg: ASbGncsqay9T4ivcn9izx29cJY9xG68lKZP9IJji5WBrxBWMxw4lfoaKLDgRdJuldjH
	Xd/OtDxRZo+e31oh3aOX22top7GaaRolyQ+Sr5QM4axp0aKpZyrc2GZdUD2HGbE3VlKjhMxogvV
	KKZk6xtl+LR7+5g6nvLimOtlr+9MFDhmo89NyYfGb6SyUhwWMv0/+DOrR0zYLPgpgUJEHLrjb0/
	Cg2s1YY3WPoJbKMkiZq9Sw3NeYN9O3rb7mXZF8IDDNhg5qSA/XH9z6S2J0U/JOUvGtSptjMUFwV
	4NZU8c7t0IJV7nsB4yk9dmq7RuUTgQf1WQfXolP0TVVpbA==
X-Google-Smtp-Source: AGHT+IHcY4QlT8cAxugFV8WCU3egvKbk9zyBB4GG47s3eU1WQL4g0KlF3Tu7NYaZxcMaA34hB7oN8w==
X-Received: by 2002:a17:90b:2688:b0:2ee:d7d3:3008 with SMTP id 98e67ed59e1d1-2febab5bdf4mr2554961a91.12.1740702467674;
        Thu, 27 Feb 2025 16:27:47 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe82840e62sm4511094a91.34.2025.02.27.16.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:27:47 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] net: phy: enable bcm63xx on bmips
Date: Thu, 27 Feb 2025 16:27:16 -0800
Message-ID: <20250228002722.5619-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228002722.5619-1-kylehendrydev@gmail.com>
References: <20250228002722.5619-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the bcm63xx PHY driver to be built on bmips machines

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..0f2956ba472d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -156,10 +156,10 @@ config BCM54140_PHY
 
 config BCM63XX_PHY
 	tristate "Broadcom 63xx SOCs internal PHY"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	select BCM_NET_PHYLIB
 	help
-	  Currently supports the 6348 and 6358 PHYs.
+	  Currently supports the 6348, 6358 and 63268 PHYs.
 
 config BCM7XXX_PHY
 	tristate "Broadcom 7xxx SOCs internal PHYs"
-- 
2.43.0


