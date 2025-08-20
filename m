Return-Path: <netdev+bounces-215309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75910B2E01F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957653B249A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1183322C6F;
	Wed, 20 Aug 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sEAKzLHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92B322A20
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701762; cv=none; b=NMJ3M5P+SV4tx/bm0IajdK9IzqG7QUlLAdJmAm0a1NOKpy7/IlAV6uoLOG/0SqqlQu+Ucr6WI7HYu8VcOBYP3cl4AVyIiuhqgAQry+YluYriUnzbXwA19ykCG2RUGhDeQ+gIbe9ZOweYIfQzGKrth25p5h3exr1F0yyG5RHmhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701762; c=relaxed/simple;
	bh=FnC+p/sUSZ/8vypJY90CDETgjSq0rMg4Fj0Db5/cyk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJByTPB6bP2RU0Z7xmgDL4nxFF1CjZDfGkJJfIrqmYGQUXfPQtotLuuqgMJBOowq5mkmoTgkp/03p9B014goO84h+D1Ec8XW76WgEtmo0QAZubeZzhVqkC/ZmMjL1srP+7lTSvdd0aR1B9ZGX8XzU0B4u5doBt/sIDiYuvLbasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sEAKzLHg; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BE79CC6B3AF;
	Wed, 20 Aug 2025 14:55:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68B75606A0;
	Wed, 20 Aug 2025 14:55:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30F841C22C74C;
	Wed, 20 Aug 2025 16:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755701758; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I8FcTJYmvlUFZA4Oe3duQag7ifxxlbPmqhzgDbiK/Sw=;
	b=sEAKzLHgMzI2aggcBjUCOnaVGFJs5Ula33FZzNZuDTacfbYeMncsSRgjkb+xX02xF6MDhB
	Ad5DLw1nbLhezr8ONWHfZHOlQBCqoLQAb74r/2NGdtqELH72kCzVfd8WjtSflMC8aleOdy
	S9+kqiSm+QyF2I1Il2WzoBybXLSZmidLqkI/MBnAH26BwzwxVrOMdRCAeVQNY7T91i/UhP
	nOjATVBWSD6JFtDleLZ/k4LRofeReJ0yHA/OK9kDMMGHyd4GuhsqO2zjCqnFJjjIzucVo5
	LPlkmtYgm0v/u04PoAt4h9Yv3/PZ26gsv97fUGwV32XHlhAcUjssh8wYJOMaTg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 20 Aug 2025 16:55:09 +0200
Subject: [PATCH net v4 5/5] net: macb: avoid double endianness swap in
 macb_set_hwaddr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-macb-fixes-v4-5-23c399429164@bootlin.com>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
In-Reply-To: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

writel() does a CPU->LE conversion. Drop manual cpu_to_le*() calls.

On little-endian system:
 - cpu_to_le32() is a no-op (LE->LE),
 - writel() is a no-op (LE->LE),
 - dev_addr will therefore not be swapped and written as-is.

On big-endian system:
 - cpu_to_le32() is a swap (BE->LE),
 - writel() is a swap (BE->LE),
 - dev_addr will therefore be swapped twice and written as a BE value.

This was found using sparse:
   ⟩ make C=2 drivers/net/ethernet/cadence/macb_main.o
   warning: incorrect type in assignment (different base types)
      expected unsigned int [usertype] bottom
      got restricted __le32 [usertype]
   warning: incorrect type in assignment (different base types)
      expected unsigned short [usertype] top
      got restricted __le16 [usertype]
   ...

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7f31f264a6d342ea01e2f61944b12c9b9a3fe66e..fe319d77f2a8f6b1f3b698e0d11781936345ea8f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -274,9 +274,9 @@ static void macb_set_hwaddr(struct macb *bp)
 	u32 bottom;
 	u16 top;
 
-	bottom = cpu_to_le32(*((u32 *)bp->dev->dev_addr));
+	bottom = *((u32 *)bp->dev->dev_addr);
 	macb_or_gem_writel(bp, SA1B, bottom);
-	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
+	top = *((u16 *)(bp->dev->dev_addr + 4));
 	macb_or_gem_writel(bp, SA1T, top);
 
 	if (gem_has_ptp(bp)) {

-- 
2.50.1


