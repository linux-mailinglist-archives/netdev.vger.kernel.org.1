Return-Path: <netdev+bounces-199779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A1AE1C63
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08FD3A88FF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DCC28DF2D;
	Fri, 20 Jun 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY0ClwGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174D28A41B;
	Fri, 20 Jun 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426925; cv=none; b=Nx3B2CbUTw5h0JW1f55pEBU6LoLUeOn6yve0kXjMRupVGuUtHazEAjUn7tx/1XUfcq8Zm7yBYTPbCSaEF4UiaWNsR7Ifc6rprxkvop9h4nEuurKkQkeRZBsz9TU/bw68sig7kU9DH4+qjwZ7xjld9AeLFnK6XK3lYtUo70u/HQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426925; c=relaxed/simple;
	bh=2Z+6ava4xwu7u6Yc1S3o+CtXLhSW5qVEEE9nA1nMS5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMlm3u7JoUej1Cj+T0w4UKY6b/Qa7zx7i2bVTfYF+Wuw8uBB1DwgGjfSji7QBaDEI9024YDbZ+EfViomLdZbmNCS2LOkKePrwpJC0J1VFbbphLfG2xj4C6hZce/GXPfq1JbmGYTcMcAZHetG6IHdZVyr9KWJHKyfymZwuVH0icY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GY0ClwGu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2366e5e4dbaso15177025ad.1;
        Fri, 20 Jun 2025 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426923; x=1751031723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X25TgPjcZ3fkjftiPDPm5horCo+r7wLhcQXafmRaqwU=;
        b=GY0ClwGuKIswkSh/UGkrxGwDhOSvo22mhLoUXXDN3yXZyGZOO3pFo4Mh2dAkzegzCH
         hIJ8dmzurxmUTPeI+avyq7wOypeFfnIda1Ts+RWgABHM/fO3Y+EsHe8vUdkmnRVsQMyL
         pvT0cnq4MFQmMHtEDbpHvd9VozxAeTKqFRLLtm1Ky9ai62f4dPip1x0waxkeop0zlwT2
         C04QxzASznaFoIJKJzr3VPLZz7PdSLEJaRSJIiynUIkHKqZWQq1V3XulHiq44kIV5Xmi
         OkrVOMtOwf+Opj5ObsanX+8IzIpV4UDle30u/65mx2v79Viy4xH3DhXvb66Rnap6yoTE
         zDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426923; x=1751031723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X25TgPjcZ3fkjftiPDPm5horCo+r7wLhcQXafmRaqwU=;
        b=myVTWtcXn/wrR52xC2Zy3c8/1M6WoVypq70f/syPmvCR0TReG+s8kEfVJRvK8PZcrk
         ryBaVIwsyPLofX7GYd93ZQfXN8CNSkLryu9EEg1e+msaq/0zDE40ErWGbr9EaBNI8gUk
         ttg8J2gWMoH7Y130gxRo5gh4r9hGn46siRaLloEJ5e9UQLJ8NJayBfuAl7xwk8/ifOn+
         0HmGOGHKj6NUqr51uxAXGKCFQC5hBuPVjTkOqPz2zWly8uIHJg0XDzXc0yghbWpO7j+O
         7Ga4luYVtnjjCNF3q66vYVVnj98WG0eaVwALKXXc2+d4EbSpeA2SC3g2dy60Z2aafWAf
         7+bw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Z+zbvv2kJT/QCu/Mw0lU0bYZ1HXnQUaavdBGogfjUNTvy+ztYA2MYkrgnIL/sSVVL/J4YC6N@vger.kernel.org, AJvYcCWpPuxP6qAjhSM9xcPvX8j6lgk8pPpS1GCdehd4Vza+8fI7H8jDIkSnc8vJYe3XpJQ8vLtZBgNM2R5P@vger.kernel.org, AJvYcCXQpEeVUGDLcC39HWbfA0EixRnj1fYzL4d5tLE4u2aT0zq936I3tliOB80TEajWnzHg5blz5nylkijdAdNL@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAU+I/cYD/44MrtfhFOwVna8V08X66b/wCNSQLtQBOFlTe7V7
	usOVbaSWipd3iWSVzKzh1DAIiydO3oleusahXeeSqRWVczlK+QLStUxff58Cig==
X-Gm-Gg: ASbGncv2HMWGzWrn4LuiEGZrnssHPDIhJ8HjS4gwCW3SDNTvjQT4ERSzIKnCQFjMx2m
	esFIipFZDAjnNFSbKOzEAcYkGuEVlm336BejV3U8tE/73+YgzWxQTQm8OdOJWqo2vc3sI/mFbCq
	AoehONjBttnc9P5Il3BMerCtpLdDaRGedYwdQhf8ou2YpKUP/Cnt/542geT3u2h8xW7edmWJVUZ
	B/L8AEhGI1C5oJ8CWR2yGunvCZLy+7grLFfgG395JjN2je+UgU2AoPPcgS/cmJQww3nl882yaSS
	+7B8EBrtzHacCyy1J+Vmzl47FiOlxDcz/SmUZmEvzmzAkkFnWjiDf6mqzjTKu8wP0wM3txjje0b
	SZN+d
X-Google-Smtp-Source: AGHT+IGVQoPnTB3eOnpmUR2wC3PM3oLPk2qxLsbvkYkciaQQOhUeGguncgOfH5RL+kzct7DVDiY9Og==
X-Received: by 2002:a17:903:1665:b0:231:d0da:5e1f with SMTP id d9443c01a7336-237db0d8ea3mr39963385ad.21.1750426922647;
        Fri, 20 Jun 2025 06:42:02 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:42:02 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/6] net: dsa: b53: mmap: Add reference to bcm63xx gpio controller
Date: Fri, 20 Jun 2025 06:41:17 -0700
Message-ID: <20250620134132.5195-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620134132.5195-1-kylehendrydev@gmail.com>
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On bcm63xx SoCs there are registers that control the PHYs in
the GPIO controller. Allow the b53 driver to access them
by passing in the syscon through the device tree.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index c687360a5b7f..a0c06d703861 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/b53.h>
 
@@ -28,6 +29,7 @@
 
 struct b53_mmap_priv {
 	void __iomem *regs;
+	struct regmap *gpio_ctrl;
 };
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
@@ -313,6 +315,8 @@ static int b53_mmap_probe(struct platform_device *pdev)
 
 	priv->regs = pdata->regs;
 
+	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
+
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
 		return -ENOMEM;
-- 
2.43.0


