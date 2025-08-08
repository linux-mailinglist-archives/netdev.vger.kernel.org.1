Return-Path: <netdev+bounces-212247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F158B1ED64
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0076A4E22C4
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8528A1C9;
	Fri,  8 Aug 2025 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JFXo40aE"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F33288C24;
	Fri,  8 Aug 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671973; cv=none; b=n4Q6fx0ln7Y5kHIqGwP77/DO+sZhA2biMsUWluJVWC7unPSZmTHusz12FKXlvx2SBKJRtNxsasja+tDwfU9SuAKOkFtz1feaiIS6clTKZZkeIWKay3aBxubfooqIZjlbzTxZNm5Sr8EQ4/VqyYRqKl30lOXoTw7+9jEr8cPod2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671973; c=relaxed/simple;
	bh=le0o8Po8o3p/FfIcM1xv4e5RDq5L76dYGm0o7046dqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qS+zs1tdteYrvq5VxMy5mdERzsaqFltW7pdZetHFiZFZSJQJtw0Ib1ravVvFCD8OIbZA/VTiYxxTCXEU7c6QYAekkbZlBm0pW98IEjWj0R4iSMZqQXz09jp1757q5oTSrZ7yPQQ4VuRLUrWxGvhQkBrW0/DeaFw7WNfQ1hpV9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JFXo40aE; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9A2C442E8;
	Fri,  8 Aug 2025 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5d6u3uGQg1DubNdLsV6kUMwGavnwdweMuDIdc8xPzpw=;
	b=JFXo40aEkmEFogvwyM3bsfcaV0e+ggfHijQZd+jN/WvbfwpxSjFIT86R667JLD4J/qJI3E
	0IYP2Nwz2OFkaOoZK7TdfRkqWQeT906jtNjEA4pZVyWEI7AmocrjaYAI3Fo3t8hMgAsrY0
	veryE9zcwpgb7ZCIGd5A6t2kOL6z81CXAGM36hRSL57Bkp2AmDMBivtUQMMmPD8T/EnVc4
	XaVVzL7M51Dr2Pkw0MMenk5IIXq9CGXl6TQAUkksmGgzXbPsgfJNWIl1z6wZOIFhFlFwMt
	a++Dn2ayqHIVHeQ2rbOW1ANTxPSv9rAVTvFBh66o93LiY8aTpULDPswcu8Z7LA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:44 +0200
Subject: [PATCH net v3 12/16] net: macb: simplify macb_dma_desc_get_size()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-12-08f1fcb5179f@bootlin.com>
References: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
In-Reply-To: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelvefhkeeufedvkefghefhgfdukeejlefgtdehtdeivddtteetgedvieelieeuhfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplgduledvrdduieekrddutddrvddvudgnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghom
 hdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

macb_dma_desc_get_size() does a switch on bp->hw_dma_cap and covers all
four cases: 0, 64B, PTP, 64B+PTP. It also covers the #ifndef
MACB_EXT_DESC separately, making it four codepaths.

Instead, notice the descriptor size grows with enabled features and use
plain if-statements on 64B and PTP flags.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 52270b20d9a1818c961525ae6de6f7d0557ddc54..dfa6b6d2cfedc8d240f55a04f2ada9fa28c55309 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -120,29 +120,16 @@ struct sifive_fu540_macb_mgmt {
  */
 static unsigned int macb_dma_desc_get_size(struct macb *bp)
 {
-#ifdef MACB_EXT_DESC
-	unsigned int desc_size;
+	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
-	switch (bp->hw_dma_cap) {
-	case HW_DMA_CAP_64B:
-		desc_size = sizeof(struct macb_dma_desc)
-			+ sizeof(struct macb_dma_desc_64);
-		break;
-	case HW_DMA_CAP_PTP:
-		desc_size = sizeof(struct macb_dma_desc)
-			+ sizeof(struct macb_dma_desc_ptp);
-		break;
-	case HW_DMA_CAP_64B_PTP:
-		desc_size = sizeof(struct macb_dma_desc)
-			+ sizeof(struct macb_dma_desc_64)
-			+ sizeof(struct macb_dma_desc_ptp);
-		break;
-	default:
-		desc_size = sizeof(struct macb_dma_desc);
-	}
-	return desc_size;
+#ifdef MACB_EXT_DESC
+	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+		desc_size += sizeof(struct macb_dma_desc_64);
+	if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
+		desc_size += sizeof(struct macb_dma_desc_ptp);
 #endif
-	return sizeof(struct macb_dma_desc);
+
+	return desc_size;
 }
 
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)

-- 
2.50.1


