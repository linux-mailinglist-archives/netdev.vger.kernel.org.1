Return-Path: <netdev+bounces-196851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33FDAD6B12
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA223AB39B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C723C510;
	Thu, 12 Jun 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Az5nf+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5923AE7C;
	Thu, 12 Jun 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717490; cv=none; b=JP/5mdGikdxBfUrbkYGWIoiRmZdonfkh8xuKUmfxNZf/GLIbU36Gb8oFE3HgxfCBv6mjR1TAXT907fE44maypwywCACi/05d7E2GWb66hwOIwC6jFZBOx3U+jAVaqJis/is6qrEwBj3Q2RQpXR+EbdA01sTfuwVWGo8oMOJ8x4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717490; c=relaxed/simple;
	bh=dfvvOJtgmo7uVHROv+tK7uPwhE4O3p+WvW10g1VWRK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+Ooo8zqcgMKmjGr8p+tw48KE1vbESRsZJFUx21WvmbttOQrK8hY6H1Tr3eI/KVn+oxTzOOIYR4ZRShh/Y5XDDlfIojlWkJLN86mcbI8mmjurz0GeefQoCGlLOtjTm2T7QIhHclUEGjtFnybvmZlmVZ0OZ48QIo9ccBk7EyLyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4Az5nf+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso5447995e9.2;
        Thu, 12 Jun 2025 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717487; x=1750322287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdmV9T8PMH27bsi/E/KTDvhysrg64/shEp9442bFwW0=;
        b=Y4Az5nf+OOApthkNxa1Ux611pAhwmZobrSCKPpJTRsWFQekTZh6TnxYyBtunkmMQd+
         /e6fotfDdcO1UxfcPcbr98f7XDsskuwJInNkVOdqAq0MvKh7icyuBWEYPRRq+3+QN/Xi
         HLo2HSUktj6kfioimBNJV9jq8rdo7SXJaNELd4aolmj5mKM8qtMzWq9euOq/BnPPadvx
         j4YC1zjJr4rOXINKq3YyfAI47nruuGEjoKybYTqFEy0Q1f5jT0ziHhByVsHi+nbEWmVT
         upWrpggYbvqLpwy1ETtWIzbzAqgihjIwPwd7LBAYDEExRV/MWB8E/5AH0pbE0gZ2KIFH
         zY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717487; x=1750322287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdmV9T8PMH27bsi/E/KTDvhysrg64/shEp9442bFwW0=;
        b=qJknjNaXTf5ZPJARAmFjNt8PLb8Hp6ukR+37KAPbAPlaky1mkvHTuVH6Oe2mHJ1TqC
         c2Zr4z7PIQiuy2GmqIgRmnhArM5skxIzgkopljvYpDMXmBKcZNLqUrWeruJgWnAzyZtS
         eeG3bUI6rKQxc/tUT2kHDtrAdtW2wuKV6GFaIWznTyhgXJ/5615l3alrmAZ7VClQyB5i
         fd47FgbIH9POXEuxGb019LOSLTlB+JH6PkU9DjWoagk55QWBWoX/67UvzL07S1a1D+nJ
         4+UO3IZ2s0xFVuZ8GFQvamiLxP6UiyCQBKShkca0v5KrIec9BTyifJRqgL4KkjD3Tmo6
         +pSg==
X-Forwarded-Encrypted: i=1; AJvYcCU5UdblgduOhbpxrJJ0rHyjKqBlVk5rg5r9nGjA83JxUOJDUXCTulvAOCfNGKzscQ0db+xsDct3@vger.kernel.org, AJvYcCUjcpqAFHCjUBfdZLj1OLXUN+hbwVYxxZSKu74SuJii0Qy3/xGp2jfQkvF7yCm5QSnOVzBCLwV0cSa+k/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygj6F8vbwz+HTxvYTPCS3hywkhwEBR7gxu0V7tyjIe6TuPessd
	cUUfQ4nZRixsFyLMCwd3K9V/WuleqfdPmVttDhqSojw43lLH0R0Zeo1L
X-Gm-Gg: ASbGncveRWi1fYyGMILyNs6SmXi7vGhBV0JDUWw8uF5Ley9goePiN3nQ4AvYkIZkjj2
	wO9ubsFQD2PzJaV9z/sRy92/NwKuoGMZp+V+BY01/Xx2s0kF05N3RBRFIWtze4xRa/0IFzWt/kY
	1OVrIrR80yM1yXD/px9xn6VDxF1uokMuj1ijotRiOlQQc/r3Hhbn1yXXm6GzFuywQb2HS1Swx05
	YPwuW7ykeX8Ao+vyHN7raWT8mFKvNt6ZQlNymZBrlX85DvqWCsWOF4gPjP2C4G+Bai7yrLk0J4A
	G0U1nz37UZERCWOB0kPYqJ4Y7Liuk6HF96Dzt01Qe4xC8QbFyQebw440k2uM/6SqPofpT3vEGe2
	e8ehGb4GazmHBDpO6Mzhz2KORAKE963TXDcDZxInK8D3elsVPErCU8hUGRoZ93UaypwwTYIXaKQ
	svSA==
X-Google-Smtp-Source: AGHT+IGiaUi9uqAkArO1sEbgmkI2ft1r/OgtCQWyexyGjTIm7faJ3qKYSvusS/ZBGaUPR0OBnvrCdg==
X-Received: by 2002:a05:600c:358b:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-4532d33d8ebmr18019515e9.21.1749717486906;
        Thu, 12 Jun 2025 01:38:06 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:38:05 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 12/14] net: dsa: b53: fix unicast/multicast flooding on BCM5325
Date: Thu, 12 Jun 2025 10:37:45 +0200
Message-Id: <20250612083747.26531-13-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
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

 v3: no changes

 v2: add changes proposed by Jonas:
  - Drop rate control registers.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 74e3b6bd798e0..409336d380bcf 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -560,12 +560,24 @@ static void b53_port_set_ucast_flood(struct b53_device *dev, int port,
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
@@ -573,19 +585,31 @@ static void b53_port_set_mcast_flood(struct b53_device *dev, int port,
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


