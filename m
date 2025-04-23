Return-Path: <netdev+bounces-184990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4EA9802A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6819401AC
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E8267716;
	Wed, 23 Apr 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bGfCmCgB"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BB22D793;
	Wed, 23 Apr 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392344; cv=none; b=LRhKTowZb3uxWBmn5rFYJIoHJDpkNDmDWvZ2ubt40Vi2AVfBRfdHoP/0OtnqSxKK4/QwccimKyOY6OfWUdBAjCknw9mKdJ7FJaok7yvQxLfmQyokV8VY/nhV4jqH7PW1FbR2sQpJm5JA4h1zUf8FJi2BISvV70A2Xh6AUAd/8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392344; c=relaxed/simple;
	bh=2jV62OjI4EGwSMWVYUa63VPh+aP1JMgho08Ke8TykIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyFPuNyX2UhADoW98vMj8bblTyUgSiocBrVTV9/s2BeIzKWCmiAAkI9bLj8EWiUar09+IT3R1ithiGfShrLK2RwTG2x2HaqoDuX+s/G7A4YChHDpVZS5tWkn+hIeiUm5LTFzU7pSD+ruWF2w+pl2skVVCjrshQI2Je63JCnCIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bGfCmCgB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B21743A53;
	Wed, 23 Apr 2025 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745392339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLySCWSlH0Sb9P602cy0L3AE+j4XwAS06FELO6RcWVA=;
	b=bGfCmCgBvq/udV2NrOkw1l1IoijqGAVUUvhC/kg58tPe+68ZZg+XtvprSk+iataEHjYyHm
	0pUkiZctX9u/H3QvrA6zIoi2adTyRoffwWJKjWz28eeBgFRfr7K8Qyf5fjsNwHbW5JuScJ
	d/WcNIS12Y2Zbu/iN9vfM0KdEvgZ6iG+YrPuGZKYRJJF7rVua2iEhUzHAbM3cIdhHr8rFN
	vVQmVwIv0Ti6GkGUfRpL3KgygwWusBeeNt42HxCSyS0Atu3ToeQ1qdDBi1UoTg8EVBUlfv
	PccLM0CIq1MklC53ycV9zGXWiI5LTKuQKxygUoHNzIhv9XNrVv0nmuErV2O5Kw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 23 Apr 2025 09:12:10 +0200
Subject: [PATCH net v2 2/2] net: stmmac: fix multiplication overflow when
 reading timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-stmmac_ts-v2-2-e2cf2bbd61b1@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeghfetffeuhfehkeekleffffdvuefggfevjefftddvffduheettdeiveetteenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhmrggthhhonhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhug
 iesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

The current way of reading a timestamp snapshot in stmmac can lead to
integer overflow, as the computation is done on 32 bits. The issue has
been observed on a dwmac-socfpga platform returning chaotic timestamp
values due to this overflow. The corresponding multiplication is done
with a MUL instruction, which returns 32 bit values. Explicitly casting
the value to 64 bits replaced the MUL with a UMLAL, which computes and
returns the result on 64 bits, and so returns correctly the timestamps.

Prevent this overflow by explicitly casting the intermediate value to
u64 to make sure that the whole computation is made on u64. While at it,
apply the same cast on the other dwmac variant (GMAC4) method for
snapshot retrieval.

Fixes: 477c3e1f6363 ("net: stmmac: Introduce dwmac1000 timestamping operations")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index a8b901cdf5cbb395a0f6b4800ad6f06c6e870077..56b76aaa58f04a6f01eb56c7ad6aa135a7f76c96 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -553,7 +553,7 @@ void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time)
 	u64 ns;
 
 	ns = readl(ptpaddr + GMAC_PTP_ATNR);
-	ns += readl(ptpaddr + GMAC_PTP_ATSR) * NSEC_PER_SEC;
+	ns += (u64)readl(ptpaddr + GMAC_PTP_ATSR) * NSEC_PER_SEC;
 
 	*ptp_time = ns;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 0f59aa98260404bece530f505500f13d35884d0c..e2840fa241f29121c4f074872c4986906201cb57 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -222,7 +222,7 @@ static void get_ptptime(void __iomem *ptpaddr, u64 *ptp_time)
 	u64 ns;
 
 	ns = readl(ptpaddr + PTP_ATNR);
-	ns += readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;
+	ns += (u64)readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;
 
 	*ptp_time = ns;
 }

-- 
2.49.0


