Return-Path: <netdev+bounces-197730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C97AD9B2C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D8A1BC11AD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E27220F41;
	Sat, 14 Jun 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCUlt3NX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156771F5849;
	Sat, 14 Jun 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888024; cv=none; b=Cbru8Ie5dN3WPwwu7C+onpwHDEDWzGBZAVQobVkZQW8yJWcucbB1WmDb6bTNER9/KgkM5RryTr8HAoEBSqdM8uDWfX455fvsjppxdp6qcEIiN7//DrWycAOrapfRVueSFiez9NxWB7amDFnvMroZKpN5RfnwbeZ/31cRsJHBRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888024; c=relaxed/simple;
	bh=Mv6g6TqRLNW7IwtjztJXy3aVpVK4bDlV6PSv29TrdPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEu+dlOT5ekeLz6d7b+OLrMUOFGMcIgKJiEM+CpAHdOAA9ZjtBxFLWK7exaNInqNoN1T+fGhho2HvqOMpfWDO7OQiJWqwyI3t6LnMvbTCCoIIa5he0j0tPlO2sjCEmY1XGNfWpHGutf3blr7n/hGbuztsVrS0JajYvQt3aRwtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCUlt3NX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so16492475e9.1;
        Sat, 14 Jun 2025 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888021; x=1750492821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MDXKYAJLJXTLaUVqxsoo9KWgHVtsh4pL8lt56oK4Pk=;
        b=QCUlt3NXJKLr7vc6wEvXXtb7veLgfybnzXrwx2TSe1f8BsnGCyT9ZhU8BvXVw+b6SJ
         ZfaxtFgotIw+9j3EDu4Kh+iCLKbBLY3wiqpyBIegKeoNUEypvEK1uHzymiBIYWgekwG0
         HFfCSqX6uYSVaY2Yfj4LYh76/lWIrMB3uskGkX2UOs74Wu65NMhukxI+IHUqVT29y4YG
         7EEecgkg9UiSf4j5PZYvmt6JIoz+00g1NxGxB/9mWO3w3OoCSI021oq791hQ4AiXvkCZ
         N3w2UGD5Ho+25HsJThSG4xANzA5eyoPT6lHbTIGpVwDINHA2BDk9nfzl4A964JWtn5hg
         eB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888021; x=1750492821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MDXKYAJLJXTLaUVqxsoo9KWgHVtsh4pL8lt56oK4Pk=;
        b=clrIJ8/IRJqhq1Min5ZHVjm5e929aqy6tYfB+U+NGPshlaTPIF64yncC2cv033oZZo
         IHjpClDvBq+l2KG8wev3UakJ5EQBvnHFfeloBeT3CEFYj8MMGcZJdb3PztS6fNuuNFjL
         o8sj2djxwsKsdtLrxnmOZJVcyzOm/nY+N7vcEh8LMSH5p/+mFL13Yc9fauMWZwYXfV94
         vr1gG1z2zu1EqTuSgKb8p6uY6WbXwkf/6GEOr/i/DVHeD10QVhzXt06tNkM85yrEnrFm
         ItIHsnKmLbpzh48ob3djuonPu0Azy90iSSUGJhcD5fKwhUfz6Y47qj3Cv03XXkQQFEE8
         +3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVK37oQcvFX1MfEb0UyZXqiLJEpJmtv5qVi0cI7XWcjbwpYGdGFxD3BaWi5n0Shhui3APVbXv3l@vger.kernel.org, AJvYcCWdogdQVHHDXEIMFM6K4seAPVbcOZoEV9MTTngzBL8B+atisyg270/VLnQgvmvgLnVhkyIjfpnXte8nLV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+3spBCr2uc3PeYji2QvThSMMEw5pifr5J7EKyJ0lRelsYdgL
	rCiRDyK8ylwbZjQjbqA+EslPKKUpLZI5ETLIsfA3EaL4aTPpdQtkBZgl
X-Gm-Gg: ASbGncsOZ05pcPWcVIwXhjLpXsePMFf1xLJsWPMnM5T4SjNq2UmAosZWqjuTW+7Uzjo
	qAqP519O4Imrnfv1WydoaUudtpCTjwZESungHdTAgow77fi8VVkIGammoLX4ggJGKJ6wDYPMzUl
	Lw971b5r/0WzLKW6GgLGPSwCKzpNFh7cQ/ReqbxqsAz1EuFwhL6aj8k9taQ2QCxblufGnmJxZTj
	qC+4D70JROCItSo6+XAgEn51Wz6hyebWBSRYXSEPpDbI7El2QAiyvU95dRmaqWIdJOG5pHL48qc
	nZpzjLCx/TEh4W20b1laXrf95Z9BFKd7kWPxoHlpjWW9eaPHqDwlPOsyF5PLukqj9PGgC2/8Tv5
	efXgtru0kyTnN5lux/C0unj4ZQRFOnoBvQQaaXEYqUwv3T5cxe9gWkb8nkFVyRYE=
X-Google-Smtp-Source: AGHT+IF/kAWmcubIrzJUlbfKoUrB4ad6zjuqAbzVMto7JjdG0ILB6dBICai5prB1d4NZz9pQczgjyA==
X-Received: by 2002:a05:600c:3f07:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-4533cacc591mr22027615e9.33.1749888021335;
        Sat, 14 Jun 2025 01:00:21 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 12/14] net: dsa: b53: fix unicast/multicast flooding on BCM5325
Date: Sat, 14 Jun 2025 09:59:58 +0200
Message-Id: <20250614080000.1884236-13-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
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

 v4: no changes

 v3: no changes

 v2: add changes proposed by Jonas:
  - Drop rate control registers.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 034e36b351c9..6aaa81af5367 100644
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
index ab15f36a135a..d6849cf6b0a3 100644
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


