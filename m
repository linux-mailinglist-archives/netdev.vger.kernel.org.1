Return-Path: <netdev+bounces-194501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6AAC9A7B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0081B4A3999
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03A23E353;
	Sat, 31 May 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViTUJIq7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76A23E347;
	Sat, 31 May 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686409; cv=none; b=Sg8ixCs+IofpJXf5KV34LecfszvbRb3O+zKMHi5rK5lnp3JGy8v8RrxH8pnoXkZ7CwmbI1uvWA23IgxZ6pDjPEgB5Xo3VppsWrqaOIxL3QJzcLxEYHljy40dZJtP8AMBBawxOScHKIvO6iCrYw3QJNMdWo9c7NqXZ0uORJc+A8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686409; c=relaxed/simple;
	bh=bD4v3rEjOHD7pBG0pLzi4E/mT/KKCwu/auYMdQPIe/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBuQCkn/x7UbP6JHgEmzZI0PQynceWD58nKS5uhjDC5Txhim9VFOOZmsxZEIBW3hbljsSvwIMy7M4+TIoBkcWpsFhv3lf/ab6JJx8xRku7S7TPY7n/73VV5Wjx+5LoQVwjQ2DQ0EYrFRyA2aY3VfbmQkG/ux2B2jsIZt4/qmdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViTUJIq7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a375888297so1662956f8f.1;
        Sat, 31 May 2025 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686405; x=1749291205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx4iJkMCoRJ2ebLIbOi4KlVLh5jV2VPfAaSVfx0MI7k=;
        b=ViTUJIq7aUz+bfbL7ehCEljMZw/bfIojsyIcTWQBus/7NPll5Dt5vGncKaTm/TUHK2
         /HyGDx/Z7lzd80s2GZeYV7amcoODFjlMr2HywIf4r/j7ia/BbPleh1JJqg+x5AZVFvs5
         1/95HhXoWOAjxHzol2OGX4FbSBXnbZ4GFvJVf+0Z6PmT0FGtL5SsGlomrRzEntfpFTeS
         M9tEzdJRQV3rZ3tSc0I//99ovCDBHugXf4oiJhkHalqWKBr8Q/gicEPqIzvqQTgktKEs
         VlGHTEOoXmOdNIzucCH6Cf2lhUChzQZ/obxzR0HwV02NS/fHTkiIq58EUHgQ+TK9cCRb
         cnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686405; x=1749291205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx4iJkMCoRJ2ebLIbOi4KlVLh5jV2VPfAaSVfx0MI7k=;
        b=Y9NLjpZHbAeTf3/FTA1tQWxmPyNfu9BooCcNpButYeMdBbxl4sFVz0ANb6Sz6olMb1
         EDslFzByUO0ET1IhjfiS6QRmhLlSgOzFR35l1lfVf9BQQdnplVDzqDyFQpxOieDqa7+5
         Q8YFdRZfMMeRI4m5Qf4aoLThvdINxgJk7hWbWpsKm6G7ClJP0ZVywuw25bQ4YHMO4Rn9
         9oFyX/jmtAFNbPv9o4fe6IKc/kdOWpWlnEdSeQLYhLZDHNI+15DxRkuruZRwrJmdjDAm
         cqotSZ14GJ7QQfWiz1CK1Rl4KLA9zM+HEsr1MGHUCdATD8+P9EtTMl26+D7Hu0SSedIl
         IYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNTseXOUk+Bd98JJkCAIZCZ8uNaaYQ94BuNxhgaiB6PreWqrLvy8zZK+L9Xm7cQdKH/LfGLe6C@vger.kernel.org, AJvYcCX+aq5ho/PKrTpE2TdRCHW4t31pn1ETmDf5/n82gdrM+KNWZZnEOF8/TPnmjzj9svU9Liy1P5l9OGbXhYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUCB/uHh/T6ewFG+AefbwFox9DBKfzh65Ux2dGYiXE6C7Acfq
	C9xVNKiJNMZMu1V2NbEZ1kf4BL1nqzeh0kFXMGjlRKlKpL3inqSIyMeY
X-Gm-Gg: ASbGnctjOCt2dl1yiSzqjYv6+qjZ0Qx3O0x7FiKYA0tSc016DJS5sj4+/kmBPZFhcwp
	aMV/UOMalxbwYgJIHNnt2etmFSt1P/+YWqrk/NwCzwc+3rNmH48LIyZkU5YFqenZUTnBo2rOQx/
	/4QRWhorLFS4kZpDHp43YU51d+DVNGNg5ln2eInU3GkUWSJ01A/8fC7J7EAHnC/njy2At4L8nCB
	L5Ep4kui3saFecW5gvvx+AaTCbSXdY2xnadMLLyPcP+244nppHpLxm9ZKR99h5YlrZnJljlTfIP
	DgIm4fonb2Q1Qq9ggmTlQzKRwzaZtOe6WPvbtSEQIdmhDVpVttf3rfLz/UKb/KpGnr9uZnaKfL2
	BdPwniM6RBLp1O3St5N7uU3Z4k1GJLwQiyrQUxjkbaibqaOnsmypDDttSGWitCxw=
X-Google-Smtp-Source: AGHT+IGXWYOmOy4eaq+vw7hMeYOgIea4+jZ3G2ejxJrvD3nHs321mTWGMsM/ADWz9C53sBJ8lJSIpA==
X-Received: by 2002:a05:6000:18a2:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3a4eed99115mr9109768f8f.12.1748686405345;
        Sat, 31 May 2025 03:13:25 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:24 -0700 (PDT)
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
Subject: [RFC PATCH 08/10] net: dsa: b53: fix unicast/multicast flooding on BCM5325
Date: Sat, 31 May 2025 12:13:06 +0200
Message-Id: <20250531101308.155757-9-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
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
 drivers/net/dsa/b53/b53_common.c | 85 +++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_regs.h   | 38 ++++++++++++++
 2 files changed, 105 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 387e1e7ec749..d5216ea2c984 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -560,12 +560,36 @@ static void b53_port_set_ucast_flood(struct b53_device *dev, int port,
 {
 	u16 uc;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, &uc);
-	if (unicast)
-		uc |= BIT(port);
-	else
-		uc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, uc);
+	if (is5325(dev)) {
+		u8 rc;
+
+		if (port == B53_CPU_PORT_25)
+			port = B53_CPU_PORT;
+
+		b53_read16(dev, B53_IEEE_PAGE, B53_IEEE_UCAST_DLF, &uc);
+		if (unicast)
+			uc |= BIT(port) | B53_IEEE_UCAST_DROP_EN;
+		else
+			uc &= ~BIT(port);
+		b53_write16(dev, B53_IEEE_PAGE, B53_IEEE_UCAST_DLF, uc);
+
+		if (port >= B53_CPU_PORT_25)
+			return;
+
+		b53_read8(dev, B53_RATE_CTL_PAGE, B53_RATE_CONTROL(port), &rc);
+		if (unicast)
+			rc |= (RC_DLF_EN | RC_BKT_SIZE_8K | RC_PERCENT_40);
+		else
+			rc &= ~(RC_DLF_EN);
+		b53_write8(dev, B53_RATE_CTL_PAGE, B53_RATE_CONTROL(port), rc);
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
@@ -573,19 +597,44 @@ static void b53_port_set_mcast_flood(struct b53_device *dev, int port,
 {
 	u16 mc;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, &mc);
-	if (multicast)
-		mc |= BIT(port);
-	else
-		mc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, mc);
+	if (is5325(dev)) {
+		u8 rc;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, &mc);
-	if (multicast)
-		mc |= BIT(port);
-	else
-		mc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, mc);
+		if (port == B53_CPU_PORT_25)
+			port = B53_CPU_PORT;
+
+		b53_read16(dev, B53_IEEE_PAGE, B53_IEEE_MCAST_DLF, &mc);
+		if (multicast)
+			mc |= BIT(port) | B53_IEEE_MCAST_DROP_EN;
+		else
+			mc &= ~BIT(port);
+		b53_write16(dev, B53_IEEE_PAGE, B53_IEEE_MCAST_DLF, mc);
+
+		if (port >= B53_CPU_PORT_25)
+			return;
+
+		b53_read8(dev, B53_RATE_CTL_PAGE, B53_RATE_CONTROL(port), &rc);
+		if (multicast)
+			rc |= (RC_BCAST_EN | RC_MCAST_EN | RC_BKT_SIZE_8K |
+			       RC_PERCENT_40);
+		else
+			rc &= ~(RC_BCAST_EN | RC_MCAST_EN);
+		b53_write8(dev, B53_RATE_CTL_PAGE, B53_RATE_CONTROL(port), rc);
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
index ab15f36a135a..b0a7ba3d9b65 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -29,6 +29,7 @@
 #define B53_ARLIO_PAGE			0x05 /* ARL Access */
 #define B53_FRAMEBUF_PAGE		0x06 /* Management frame access */
 #define B53_MEM_ACCESS_PAGE		0x08 /* Memory access */
+#define B53_IEEE_PAGE			0x0a /* IEEE 802.1X */
 
 /* PHY Registers */
 #define B53_PORT_MII_PAGE(i)		(0x10 + (i)) /* Port i MII Registers */
@@ -47,6 +48,9 @@
 /* VLAN Registers */
 #define B53_VLAN_PAGE			0x34
 
+/* Rate Control Registers */
+#define B53_RATE_CTL_PAGE		0x35
+
 /* Jumbo Frame Registers */
 #define B53_JUMBO_PAGE			0x40
 
@@ -368,6 +372,18 @@
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
@@ -478,6 +494,28 @@
 /* VLAN Port Default Tag (16 bit) */
 #define B53_VLAN_PORT_DEF_TAG(i)	(0x10 + 2 * (i))
 
+/*************************************************************************
+ * Rate Control Page Registers
+ *************************************************************************/
+
+#define B53_RATE_CONTROL(i)		(0x00 + (i))
+#define   RC_PERCENT_S			0
+#define   RC_PERCENT_10			(0 << RC_PERCENT_S)
+#define   RC_PERCENT_20			(1 << RC_PERCENT_S)
+#define   RC_PERCENT_30			(2 << RC_PERCENT_S)
+#define   RC_PERCENT_40			(3 << RC_PERCENT_S)
+#define   RC_PERCENT_MASK		(3 << RC_PERCENT_S)
+#define   RC_BKT_SIZE_S			2
+#define   RC_BKT_SIZE_2K		(0 << RC_BKT_SIZE_S)
+#define   RC_BKT_SIZE_4K		(1 << RC_BKT_SIZE_S)
+#define   RC_BKT_SIZE_6K		(2 << RC_BKT_SIZE_S)
+#define   RC_BKT_SIZE_8K		(3 << RC_BKT_SIZE_S)
+#define   RC_BKT_SIZE_MASK		(3 << RC_BKT_SIZE_S)
+#define   RC_DLF_EN			BIT(4)
+#define   RC_BCAST_EN			BIT(5)
+#define   RC_MCAST_EN			BIT(6)
+#define   RC_DROP_FRAME			BIT(7)
+
 /*************************************************************************
  * Jumbo Frame Page Registers
  *************************************************************************/
-- 
2.39.5


