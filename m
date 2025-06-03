Return-Path: <netdev+bounces-194842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEBACCE6E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF1017672D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14552255F57;
	Tue,  3 Jun 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekgY4VZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1425485A;
	Tue,  3 Jun 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983757; cv=none; b=I37lXRDL/MlKuQGUKRKzhO5np8C5L2qBJ/UGUlUctEEyuvCmMQnahvq5ElqKnwjI5EF6emxLT4XptKb4IZz0r0OViDyUJ6biR/tqSXuWoFx9N49LC/LBqTSfcujzYRCDsra3xFmSd5+53gBMg9Ss4YbRUhFus+cDWEJ36BL0FAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983757; c=relaxed/simple;
	bh=W7udOWw1v+LTQ6uO16H4YPvSI7aqLfB9vzSb+0XQ7/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZsVl/PC4b8ClXU6qYYNLWBfFfRumFUMK9K56II2SNIzJYY3r0zrDgK3Vmr9gKDguPvvfvhQEgR1MctcEbV3p0xA3MWzGvg6m6u+w7t22ansWVlEOWWCua13ksGZKPf8rJP5G/BgCVQs8Nt289ug2IJIqzeQAoirKhprZ+F7OLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekgY4VZx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so39726415e9.2;
        Tue, 03 Jun 2025 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983753; x=1749588553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nJaL741oCxwloVL8uy8t6yLuzw4na0qNUKiNxjWzvM=;
        b=ekgY4VZxRP5Z+eEk/Ir0eFME8Qv8ge1mkbFiflSp3kXP/h0a4ZDt002pL2N1M/WJIe
         +f2DhiwqhvxOWFOEJ1wpBBjjX6+v/f0duvP123gPG+SJT5OxxaDgYbYIgwLfS/G6fIMO
         YwJMNoxyeCi0jrAt94XJLUkAGXvZ48Ul1sR3iem5ADUw5i2WW1qmVi9G4FASITCbWrul
         vta+eN0x8j7qzH/m++Y4tH7Y6ubLiLysTxQ7KQcGqKudeaEJddxrnBmudMcCTlNdtZwL
         Zv2EpYUmu2Rem/LFQ6wWbN6ydXw9mR41Pq8sAjlSrQ5bKdn1XwiHg2OXHXOZWpDbVjZm
         HzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983753; x=1749588553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nJaL741oCxwloVL8uy8t6yLuzw4na0qNUKiNxjWzvM=;
        b=G/l6yuY9xvqCGVt2F5Tmq45D6YX2AcMth1sCp1QF60LzCjBVPTD/KQDOatYDGQ+qDZ
         wee14dGRWPKqBSIDcqjPStEVVUDbSaEoFKbNviKpJpfJ7vCHZPh0/lrGLYIOnluwKZNx
         ykVCkrnO4RNHbvbTUxSSMSprP8fUQprz3yh3VrlToUxNWDrSWdVCUqvCz+vEBHG2cPru
         gVyBEFeZtGpqkOIbTBeqI9ZLgmyEDBRDZJp/+9791Z1BbOrKBfLDErtFctt8/biF6VIU
         JJ6OXupzs/gg+Lg1Nyp+xNJMy0Cc+7syJrJZwTEs3V5KMrKt7Tr0sf1+fdyHQvNDZDTN
         +yUw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ccn75meD4SVjd/mrXIjXlViIsDzRSYW+25I7pmWIrtek0CF2EOtAkP2KmaUJRAZCTbqFTQQz@vger.kernel.org, AJvYcCUV+jTqKDmTcJzd6NkmwY/SbghBYC24kIJSMiIlKay9kvOR6f560LIjk6uukbLL8f3Inu/WuqIizRKfn7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwsQ0nbO5ptHhjDJlNNRZlBmRyEtpi9NnjtzDcgbTvBHrEUCY
	fJxVcVCnHLW9K5pcGSjtmDyEqfw2g3hzIEQy/QySGTjht9YaBA2NPiP+
X-Gm-Gg: ASbGncuUMQrUoEaBXkWQuxWRdh48Ee+JnYGqS150TlP8QtOb/cNQ2JyZoQnguwwjG2T
	OvxsAcG2iTwpGliVDqTiFcFXD5IGlm0Rr7li+4l6JCeMD3XMuwLYgJn+HVWXFGtdvac8ZI5XJKX
	NJlENuzJswlRDoaEDRIwG6Rdqg6ZZ8ypD9FXnD67nSz1ZlweBh0mbht6WUYiTJFatJLuYTUml38
	+lyKh53jSNLDJ/7uc3DzFSbBAUrIeG3CqCEV1qWcMsvfPUGnwQcK2T6Zu08gGVbkaHJQO9iBruz
	j5J/jZJ1/LJ1tWvm+E0YpMBXp9Ek/OU+H59X9bdIix7ZiqyU13WebPUSb2dne596qZkibRKW1QD
	4j2tu3B25zJGI0o/lCUKnpTZp+CRqIEfs2WDR4YzYWH2TXVufwXlC
X-Google-Smtp-Source: AGHT+IFYfiBBW4r+w05kNkE1fPEAuh6HUwhqbHJ732NmY8EMizB2mgDVAvOEriL4FgWCPDyq9xx3MQ==
X-Received: by 2002:a05:600c:3b9b:b0:442:e9eb:cb9e with SMTP id 5b1f17b1804b1-451f0b27e55mr937095e9.26.1748983753360;
        Tue, 03 Jun 2025 13:49:13 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1500-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1500::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e58c348asm26258225e9.3.2025.06.03.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 13:49:12 -0700 (PDT)
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
Subject: [RFC PATCH net-next v2 08/10] net: dsa: b53: fix unicast/multicast flooding on BCM5325
Date: Tue,  3 Jun 2025 22:48:56 +0200
Message-Id: <20250603204858.72402-9-noltari@gmail.com>
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

BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLOOD_MASK
registers.
This has to be handled differently with other pages and registers.

Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port flags")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 60 ++++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_regs.h   | 13 +++++++
 2 files changed, 55 insertions(+), 18 deletions(-)

 v2: add changes proposed by Jonas:
  - Drop rate control registers.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 4cee69f29cf8d..d7148f0657563 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -559,12 +559,24 @@ static void b53_port_set_ucast_flood(struct b53_device *dev, int port,
 {
 	u16 uc;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, &uc);
-	if (unicast)
-		uc |= BIT(port);
-	else
-		uc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, uc);
+	if (is5325(dev)) {
+		if (port == B53_CPU_PORT_25)
+			port = B53_CPU_PORT;
+
+		b53_read16(dev, B53_IEEE_PAGE, B53_IEEE_UCAST_DLF, &uc);
+		if (unicast)
+			uc |= BIT(port) | B53_IEEE_UCAST_DROP_EN;
+		else
+			uc &= ~BIT(port);
+		b53_write16(dev, B53_IEEE_PAGE, B53_IEEE_UCAST_DLF, uc);
+	} else {
+		b53_read16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, &uc);
+		if (unicast)
+			uc |= BIT(port);
+		else
+			uc &= ~BIT(port);
+		b53_write16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, uc);
+	}
 }
 
 static void b53_port_set_mcast_flood(struct b53_device *dev, int port,
@@ -572,19 +584,31 @@ static void b53_port_set_mcast_flood(struct b53_device *dev, int port,
 {
 	u16 mc;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, &mc);
-	if (multicast)
-		mc |= BIT(port);
-	else
-		mc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, mc);
+	if (is5325(dev)) {
+		if (port == B53_CPU_PORT_25)
+			port = B53_CPU_PORT;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, &mc);
-	if (multicast)
-		mc |= BIT(port);
-	else
-		mc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, mc);
+		b53_read16(dev, B53_IEEE_PAGE, B53_IEEE_MCAST_DLF, &mc);
+		if (multicast)
+			mc |= BIT(port) | B53_IEEE_MCAST_DROP_EN;
+		else
+			mc &= ~BIT(port);
+		b53_write16(dev, B53_IEEE_PAGE, B53_IEEE_MCAST_DLF, mc);
+	} else {
+		b53_read16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, &mc);
+		if (multicast)
+			mc |= BIT(port);
+		else
+			mc &= ~BIT(port);
+		b53_write16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, mc);
+
+		b53_read16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, &mc);
+		if (multicast)
+			mc |= BIT(port);
+		else
+			mc &= ~BIT(port);
+		b53_write16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, mc);
+	}
 }
 
 static void b53_port_set_learning(struct b53_device *dev, int port,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index ab15f36a135a8..d6849cf6b0a3a 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -29,6 +29,7 @@
 #define B53_ARLIO_PAGE			0x05 /* ARL Access */
 #define B53_FRAMEBUF_PAGE		0x06 /* Management frame access */
 #define B53_MEM_ACCESS_PAGE		0x08 /* Memory access */
+#define B53_IEEE_PAGE			0x0a /* IEEE 802.1X */
 
 /* PHY Registers */
 #define B53_PORT_MII_PAGE(i)		(0x10 + (i)) /* Port i MII Registers */
@@ -368,6 +369,18 @@
 #define B53_ARL_SRCH_RSTL_MACVID(x)	(B53_ARL_SRCH_RSTL_0_MACVID + ((x) * 0x10))
 #define B53_ARL_SRCH_RSTL(x)		(B53_ARL_SRCH_RSTL_0 + ((x) * 0x10))
 
+/*************************************************************************
+ * IEEE 802.1X Registers
+ *************************************************************************/
+
+/* Multicast DLF Drop Control register (16 bit) */
+#define B53_IEEE_MCAST_DLF		0x94
+#define B53_IEEE_MCAST_DROP_EN		BIT(11)
+
+/* Unicast DLF Drop Control register (16 bit) */
+#define B53_IEEE_UCAST_DLF		0x96
+#define B53_IEEE_UCAST_DROP_EN		BIT(11)
+
 /*************************************************************************
  * Port VLAN Registers
  *************************************************************************/
-- 
2.39.5


