Return-Path: <netdev+bounces-212250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC0CB1ED6F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162A7A01341
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3228B41E;
	Fri,  8 Aug 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOnnceHO"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19E289358;
	Fri,  8 Aug 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671974; cv=none; b=stES+wBI62z+BsfH760B+a6XKyM1YAXIopcx7LMW637Jq6QeCvPWN+bsgGBETAUIOgSK0AeGcu4vMQzB/XtWaYuUm4lsnro791N24pLLLpufl+cQhozx/j/Xo0EfUTlrdZEVkcglDRPT1TgQFHYaVXr9zHIp9KK08h5unI7CBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671974; c=relaxed/simple;
	bh=wWxw1zqOxfhTMJBCsJ80BVvUh99lXkWx9aE9ViPsbXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkgsvJprTDBk9YEvurR+0/K+VWJGbYvmbmbWJ/1AoAZjajv6UozdO9kYmWVMCQaymjVM40WY/IqLSPyisu0idi1y7OjAn9EQCEIIaecA4w5E4K5Sux/e8PFoAryAYAoMzB985yJ4yq9xLxFsvboobp3SjEJQrHvHRnB7+agD8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOnnceHO; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD0EA442D2;
	Fri,  8 Aug 2025 16:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmWKJ8h4sXPk9KSRKagb3SBVcXspmrZ21Rgq9zHnLW8=;
	b=gOnnceHOVC+Q9sPVIqXvNcxZb9yVZcjCSoUGqtw+V12nyMQG9QiKhRki1Mo6431LmFTcIp
	uhINEMBDMovqESLkoMsmy1EyOEiU0vTfJuDgoNcid9cOPB9Typg6iFE3AU93sc1Dsk04VR
	s7rBGyZtu2A7Y10vUyBBocVnUrg5tm49RTsSDjIRcBAl3p3ZjFd7TbQoPea7NZg7Ue4fiK
	NNiiuq9EjP4LX2oS2t6l2EZ9VMOPA4PxevsbXxW8nn3tS/+vaEpUh9Y4jfSxvZ63IoWki8
	RSGMukDX5SMYSo1+pWiHhm3GLLaRGEW0JZHcO9Yiu4uKaixpvvifA/3jN18pQw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Aug 2025 18:52:45 +0200
Subject: [PATCH net v3 13/16] net: macb: simplify macb_adj_dma_desc_idx()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-macb-fixes-v3-13-08f1fcb5179f@bootlin.com>
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

The function body uses a switch statement on bp->hw_dma_cap and handles
its four possible values: 0, is_64b, is_ptp, is_64b && is_ptp.

Instead, refactor by noticing that the return value is:
	desc_size * MULT
with MULT equal to 3 if is_64b && is_ptp,
                   2 if is_64b || is_ptp,
                   1 otherwise.

MULT can be expressed as:
	1 + is_64b + is_ptp

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dfa6b6d2cfedc8d240f55a04f2ada9fa28c55309..e3cf62253bb96ff245e49730dd4c4b232ce89712 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -135,19 +135,13 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
 {
 #ifdef MACB_EXT_DESC
-	switch (bp->hw_dma_cap) {
-	case HW_DMA_CAP_64B:
-	case HW_DMA_CAP_PTP:
-		desc_idx <<= 1;
-		break;
-	case HW_DMA_CAP_64B_PTP:
-		desc_idx *= 3;
-		break;
-	default:
-		break;
-	}
-#endif
+	bool is_ptp = bp->hw_dma_cap & HW_DMA_CAP_PTP;
+	bool is_64b = bp->hw_dma_cap & HW_DMA_CAP_64B;
+
+	return desc_idx * (1 + is_64b + is_ptp);
+#else
 	return desc_idx;
+#endif
 }
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT

-- 
2.50.1


