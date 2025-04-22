Return-Path: <netdev+bounces-184722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DDA96FFE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205AD16BE31
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19C28F94A;
	Tue, 22 Apr 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IzuQtJHk"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAC284B5B;
	Tue, 22 Apr 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334488; cv=none; b=gIHJA/gr7gE5WK34m4AqdS1Hxk5mj3CbL9I3y7pqh8OG80zkP1RkdC+VWsiPx/Fww+D8Jwx200mTwlY+JRorRmPCeUx9ewPj4BCmo6GzcA0dsK/OnrBwS8QkfLS9xPAixbKfNhbLU4u06K6dXLjaWmx0DFYHYmfJRu1OxUoU+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334488; c=relaxed/simple;
	bh=AHZaZUsr4DPTBZ80zjQhTttqoC74cFQHMwz+oExB/4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6KlUq/ZJxh+A9dNf7aIK9XcuhBp2t+W3PyMFshGDf5YUC3Pz6w3rur/NJPGAm1jfl7bzuT7N6KGy1ztKYUL7a7uSfwj9oqMjFWXsAY1Z0hdOCAXYpmVNauWdiuLqZuqKO5nTzm2hrCzLutGQu4XHw+JFCkOWF7iI+VD4GP8f/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IzuQtJHk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7E7543A3E;
	Tue, 22 Apr 2025 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745334478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRcZcJeqXe3bZ8BydUxdPRAg1PRktnOnWrwURyrXOHk=;
	b=IzuQtJHkjpr/eiSJK2AczFT9xNq4AUt+9Db9jV6u/eXqZe/xJVmDCmiAQpDRjnLIbFuBzh
	9VpX5AD5Dq51LK+mevlQazB1jH+55sv2mwwKpX12wHYWJKAP3Pq4RZkG4OM5vLpXJx7XcE
	kquo80h+KxGnpsdyZtVq225Q53uLhqEfJpxrh6UydkMGFjcM1gRqEOSbdEvxjhPLu0+/ST
	BlyHFXozSnRzQhDEjYh9ZO2f9uLL1QOuR5z0NTe4BAODmgoEibM3+9osK2/kUrY6+Yf9pR
	TddWRW8hP0GItWlSq1D2jOvB90wPMYdZknqVapV+Ovps+MvsO9+1EAl6bUEFgg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 22 Apr 2025 17:07:23 +0200
Subject: [PATCH net 2/2] net: stmmac: fix multiplication overflow when
 reading timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250422-stmmac_ts-v1-2-b59c9f406041@bootlin.com>
References: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
In-Reply-To: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeghfetffeuhfehkeekleffffdvuefggfevjefftddvffduheettdeiveetteenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgdujedvrddujedrtddrudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopegurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
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

Fixes: 19b93bbb20eb ("net: stmmac: Introduce dwmac1000 timestamping operations")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index a8b901cdf5cbb395a0f6b4800ad6f06c6e870077..43b2b3377136f2d9c717f85cba6a452e7a178ad7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -553,7 +553,7 @@ void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time)
 	u64 ns;
 
 	ns = readl(ptpaddr + GMAC_PTP_ATNR);
-	ns += readl(ptpaddr + GMAC_PTP_ATSR) * NSEC_PER_SEC;
+	ns += (u64)(readl(ptpaddr + GMAC_PTP_ATSR)) * NSEC_PER_SEC;
 
 	*ptp_time = ns;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 0f59aa98260404bece530f505500f13d35884d0c..1950156f6af6f6f13ebdc1c04f01a862b664bc9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -222,7 +222,7 @@ static void get_ptptime(void __iomem *ptpaddr, u64 *ptp_time)
 	u64 ns;
 
 	ns = readl(ptpaddr + PTP_ATNR);
-	ns += readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;
+	ns += (u64)(readl(ptpaddr + PTP_ATSR)) * NSEC_PER_SEC;
 
 	*ptp_time = ns;
 }

-- 
2.49.0


