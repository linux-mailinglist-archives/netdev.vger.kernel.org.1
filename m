Return-Path: <netdev+bounces-212248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAE2B1ED70
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F82D18813FB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3828A70C;
	Fri,  8 Aug 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gHzNnLdN"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD66288C3A;
	Fri,  8 Aug 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671973; cv=none; b=h+F46peLgQO7KoFKdc3k4gDf4sOPyvcYUqn6qWKhZ49LJOH8TCPTT/BWbyUcdI2GKTq/V49Iqn5SgQEXrZZluVFEFm05R0I5MqmVle35kyofKoKDe6NviqUdBHnqtI12zKLvwPAY2TVGG/aAjH5xRCXGoVmHVdx2ke9Xvd29cTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671973; c=relaxed/simple;
	bh=8IE9QHAIUObwIV/HwEsLYyQTxAWBN0yBBXMSF/TIBCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2dPgDwMuyF0aNjOlxFAzmvYH1FybH7HtbB/a4v+qd0eRMB8qCkQ4Zf+x5UMRgysysFQgoyYxZm3UKoiZMfLh/uQvDkouOOZxZCh17M5EogGnI0vU0vktpN9ZZKhlayTzJrUjD3FACIep+D4Xf9JdASQd6NdDY6bQPRcSY/sItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gHzNnLdN; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57B7C442E4;
	Fri,  8 Aug 2025 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imrhdc9yfbCCwsbSbUFh46GGjQWhAJDcr6uFv++Yd7Y=;
	b=gHzNnLdNz4al7jaWBVADKhfQaT3tvxBW7qcOE9Yy99M2uiQKIa4b9hv7N1cqgzJ85dtLIp
	3e9FE4nFqEEY0P7cx9LrTS4IinTuDbUtwUA9xd/uMhLPMDTysfrXMlHqvmDtftVm1eXZm7
	uYS52fgmhd2bIRYAE7h/detnLDatZVWThePz8ndd/+f92PZBCQP8XkunKcRpmgyYIa410G
	sgy8qJhU6SeGRuRgWjt5Uq+IeUZdvTIq1430qfYTE5rsZaON5F09JED0Hup9jf6XV/Sl5b
	UHURYsZf7fJNVaf3U04zMF8UTDhpKl795BFqQqXKDnO84jzroU6UtMyIfQQw0Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:38 +0200
Subject: [PATCH net v3 06/16] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-6-08f1fcb5179f@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelvefhkeeufedvkefghefhgfdukeejlefgtdehtdeivddtteetgedvieelieeuhfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplgduledvrdduieekrddutddrvddvudgnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghom
 hdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtlhgruhguihhurdgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

If HW is Receive-Side-Coalescing capable, it cannot add dummy bytes at
the start of IP packets. Alignment (ie number of dummy bytes) is
configured using the RBOF field inside the NCFGR register.

On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
be done if those dummy bytes are added by the hardware; notice the
skb_reserve() is done AFTER writing the address to the device.

We cannot do the skb_reserve() call BEFORE writing the address because
the address field ignores the low 2/3 bits. Conclusion: in some cases,
we risk not being able to respect the NET_IP_ALIGN value (which is
picked based on unaligned CPU access performance).

Current hardware (assuming it is working) falls in either category:
 - RSC-incapable or,
 - RSC-capable and NET_IP_ALIGN=0 (arm64/powerpc/x86).

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 20 +++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a7e845fee4b3a2e3d14abb49abdbaf3e8e6ea02b..a773d640d4738f158649e225ae4257164a6ef809 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -527,6 +527,8 @@
 /* Bitfields in DCFG6. */
 #define GEM_PBUF_LSO_OFFSET			27
 #define GEM_PBUF_LSO_SIZE			1
+#define GEM_PBUF_RSC_OFFSET			26
+#define GEM_PBUF_RSC_SIZE			1
 #define GEM_PBUF_CUTTHRU_OFFSET			25
 #define GEM_PBUF_CUTTHRU_SIZE			1
 #define GEM_DAW64_OFFSET			23
@@ -737,6 +739,7 @@
 #define MACB_CAPS_MIIONRGMII			0x00000200
 #define MACB_CAPS_NEED_TSUCLK			0x00000400
 #define MACB_CAPS_QUEUE_DISABLE			0x00000800
+#define MACB_CAPS_RSC				0x00001000
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index aa0b5aea48888eb2d1aa3edef45c804ae519f70d..1e19ebcaf3810ca87729bad0ef0e13db49c548e4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1332,8 +1332,18 @@ static void gem_rx_refill(struct macb_queue *queue)
 			dma_wmb();
 			macb_set_addr(bp, desc, paddr);
 
-			/* properly align Ethernet header */
-			skb_reserve(skb, NET_IP_ALIGN);
+			/* Properly align Ethernet header.
+			 *
+			 * Hardware can add dummy bytes if asked using the RBOF
+			 * field inside the NCFGR register. That feature isn't
+			 * available if hardware is RSC capable.
+			 *
+			 * We cannot fallback to doing the 2-byte shift before
+			 * DMA mapping because the address field does not allow
+			 * setting the low 2 (or 3 if DMA) bits.
+			 */
+			if (!(bp->caps & MACB_CAPS_RSC))
+				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
 			dma_wmb();
@@ -2814,7 +2824,9 @@ static void macb_init_hw(struct macb *bp)
 	macb_set_hwaddr(bp);
 
 	config = macb_mdc_clk_div(bp);
-	config |= MACB_BF(RBOF, NET_IP_ALIGN);	/* Make eth data aligned */
+	/* Make eth data aligned. If RSC capable, that offset is ignored by HW. */
+	if (!(bp->caps & MACB_CAPS_RSC))
+		config |= MACB_BF(RBOF, NET_IP_ALIGN);
 	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
 	if (bp->caps & MACB_CAPS_JUMBO)
 		config |= MACB_BIT(JFRAME);	/* Enable jumbo frames */
@@ -4139,6 +4151,8 @@ static void macb_configure_caps(struct macb *bp,
 		dcfg = gem_readl(bp, DCFG2);
 		if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
 			bp->caps |= MACB_CAPS_FIFO_MODE;
+		if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
+			bp->caps |= MACB_CAPS_RSC;
 		if (gem_has_ptp(bp)) {
 			if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
 				dev_err(&bp->pdev->dev,

-- 
2.50.1


