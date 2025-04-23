Return-Path: <netdev+bounces-184988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12FA98026
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CADE189F077
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C25266EF7;
	Wed, 23 Apr 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MpXO5NI0"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32228F1;
	Wed, 23 Apr 2025 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392344; cv=none; b=cfHe9hutao6XIFqOFQUQIb9nUw709d55zoa9LZjtL98MNc5yJRKyDgZAZJ3CsWIMJ3hemiK9Hf+gpDIyTuEMUJlRCIsTUAw+Tg0crjLzVn01jIADQ1GVVlUjdDAC89OQNaL1tPcpp2QssMNLt2d7p85wQ15r/B121Ar5RISXAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392344; c=relaxed/simple;
	bh=jkrACJE2d+d8mv+ZcK+lLYOcnpIzrRL386CdU37AKoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siagvEn9k3VwSuTwLjkIJN34/DNEqXLcO6cnyuIQZH3l9l9EwYiAKJCpod4t8pN2W3h2Csljk8ltdBDKfoy+YBkUbDKPo9WoPs6zwDA7F3ZrW6Gg9BYRyPjKmiQEN4G12Bz/pexNUpQ6GBwCXpFN5b3vRe2Vx1EdKJLRq2XRqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MpXO5NI0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CDFF43A36;
	Wed, 23 Apr 2025 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745392339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkjBpj7wvMxsVfxHzks1lri0zffcvGGh+bHSb8/6KeA=;
	b=MpXO5NI0S0uqAIOfOq71TlNJIo/ygPFDHO68GFpxyoc+MkBSWP1roW4BBVRB5QMozRNtUA
	tNC14wqLbfYp9xTUPJuOjj+D66+tRFwKDk1K1rBDmrWThhWIYIU+ZMauyR2tMOIgbDGlkr
	kJaq+33VxEAiW+KUdP8ofRE/TGBs3oO7rWkdVbGyo+/q8ECIZMVjdgHz/+sJiAitHXY87u
	+ZQnwDRwDTb53AiplHwtX4Sva+gEWY4ZGZ+Tj1FDmJTfheYZcu1SURL5rASsw0e1SaHM3W
	82mjxbVNmpNKEFQGzBhFlVmqioeSuevcwPp5u5YL4BsF5xQVudZeBSk9kke/Pw==
From: Alexis Lothore <alexis.lothore@bootlin.com>
Date: Wed, 23 Apr 2025 09:12:09 +0200
Subject: [PATCH net v2 1/2] net: stmmac: fix dwmac1000 ptp timestamp status
 offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-stmmac_ts-v2-1-e2cf2bbd61b1@bootlin.com>
References: <20250423-stmmac_ts-v2-0-e2cf2bbd61b1@bootlin.com>
In-Reply-To: <20250423-stmmac_ts-v2-0-e2cf2bbd61b1@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhgvuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefudfhgeegtdekvdeujedugefhhffhfedtgfetffevveekfeelveejfffhjeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhmrggthhhonhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhug
 iesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

When a PTP interrupt occurs, the driver accesses the wrong offset to
learn about the number of available snapshots in the FIFO for dwmac1000:
it should be accessing bits 29..25, while it is currently reading bits
19..16 (those are bits about the auxiliary triggers which have generated
the timestamps). As a consequence, it does not compute correctly the
number of available snapshots, and so possibly do not generate the
corresponding clock events if the bogus value ends up being 0.

Fix clock events generation by reading the correct bits in the timestamp
register for dwmac1000.

Fixes: 477c3e1f6363 ("net: stmmac: Introduce dwmac1000 timestamping operations")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 967a16212faf008bc7b5e43031e2d85800c5c467..0c011a47d5a3e98280a98d25b8ef3614684ae78c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -320,8 +320,8 @@ enum rtc_control {
 
 /* PTP and timestamping registers */
 
-#define GMAC3_X_ATSNS       GENMASK(19, 16)
-#define GMAC3_X_ATSNS_SHIFT 16
+#define GMAC3_X_ATSNS       GENMASK(29, 25)
+#define GMAC3_X_ATSNS_SHIFT 25
 
 #define GMAC_PTP_TCR_ATSFC	BIT(24)
 #define GMAC_PTP_TCR_ATSEN0	BIT(25)

-- 
2.49.0


