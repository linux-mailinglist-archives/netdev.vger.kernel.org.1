Return-Path: <netdev+bounces-184721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC4A96FFF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FA03ABCB4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056628EA70;
	Tue, 22 Apr 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OYwnFVQA"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22928EA5D;
	Tue, 22 Apr 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334486; cv=none; b=ErVDNpttUBWVoDdbOupwruGiq7j66hpGJG3zKKQ8d3OzUZEsxJGR3TBw6i3gZH6tmWZzTPyIdk8HQ1qjCHJJc+Zi0SuFoEOo09iihxuWVL14vm6M6tn5kOnXb5fvrL3ibwVf2HJS9A1bUE+ag+gO8qwIg2K2zh8J2tcF3jSdq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334486; c=relaxed/simple;
	bh=fhFfeO1UKRiVvRhUYTOkLZmxX3UWNOcjR9tT/+BB1jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFyOSOtM5TfiW/UFlgcRHg8QD3boBilWeLS34tNhb6OWwhmHp+XneKzarCcuWf31SpUQhS/Tr3WmmpX0/+VbMzOZ6AoIsjFE4twtHbZO943QEwWWlny1KJrRAUgSzQ62as1ZxfCUIPZyZnAhzhngvgrC7e8N2HjDTAuQN406bI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OYwnFVQA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE1EA439F6;
	Tue, 22 Apr 2025 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745334477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv05jOSJ6xc00eTPXgNHRvsKAXEfKlZvJUZ4OUiKUQs=;
	b=OYwnFVQAZcZEoI+rYV4eM26gGChn+jEPACAHPdCJihqM7V88gUroJFpnBFYkrEFGl5dN2I
	FEBT+F0F3V7QCNarRFhd3EWbNG5uxB8DLAPcqMxv6T9JUFMiy03fNgiEDCuUTjyOlON3rD
	ySU2E6zlyoSop5Dlh0KvSqivEg1Vqmz5yWWjKEK6SAs1yUtaxRqMRk3JmRlQvcsq94uqF6
	nAsaq9tXBn3LTeOOPPBRKRfJatOsq+m58nUFZ085aejv6CUmpLG8bj0T/MjwkM/kb3cJFd
	jIN+aX8RtYSXoYMwp7383VYkT4yOf2zN7EhYkG/Gpjgw9RbGy4rAypeFAxCL3g==
From: Alexis Lothore <alexis.lothore@bootlin.com>
Date: Tue, 22 Apr 2025 17:07:22 +0200
Subject: [PATCH net 1/2] net: stmmac: fix dwmac1000 ptp timestamp status
 offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250422-stmmac_ts-v1-1-b59c9f406041@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhgvuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefudfhgeegtdekvdeujedugefhhffhfedtgfetffevveekfeelveejfffhjeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgdujedvrddujedrtddrudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsthhmfedvsehsthdqmhguqdhmrghilhhmrghnrdhsthhorhhmrhgvphhlhidrtghomhdprhgtphhtthhopegurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
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

Fixes: 19b93bbb20eb ("net: stmmac: Introduce dwmac1000 timestamping operations")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
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


