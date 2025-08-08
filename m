Return-Path: <netdev+bounces-212240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A77B1ED50
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29DC18C5F39
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBDD2882CF;
	Fri,  8 Aug 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ocfN7Liq"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C97186E2D;
	Fri,  8 Aug 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671969; cv=none; b=V4YxNd68Cl+pDTXILpN2igSLdaSrScu0t+3sqVqMcHWtfUGNO0hFZsQVPRXepoQcGyGnfw6D+FMWSlDzeBd3jUAYEalhL/z79twGzjFOOchrAXwI221a6NLAQ+DffcfAz2z7wL5jPWXtCGyXilmyOAioJf3doFG6AEQ1/aODGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671969; c=relaxed/simple;
	bh=BOTS+Lke2sbFxgmXDJJFMru6cbhm5/8d0mZnWPAAqpw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LfjUlEWgyeV9QyQeGzGspqyADy2qne4c+hDPY9EDVD0EbKds6GqKJjYIp4SZxo23GtLNwKAf32P17xxFddRjEfYyZy+uaJvd2sU/xeNWgHRTEBpNilFaVDSTRr2vwHsqiHvZevT2FUDGxHlLvllfeVkuGO2Ift8URD46jjQo89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ocfN7Liq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62A03442D1;
	Fri,  8 Aug 2025 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754671958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wx0vM9bvExmbOh7SawY7AU8GQ9du5el6HIq4+h5fLtU=;
	b=ocfN7LiqVi6LRkGyP8+O7u1eKTyUcvPVji78k6lSYYlxpAV2ORpAeibIgyN7JD/zMU+btP
	MSSHW2pBYJ5/N+KH3xac/9P1K4VREsEjP1HGT6Zf2uWoHduaGPAS7+fsy9/XB+8vYMaigK
	EHETtRBSEG53F5V1v5vTC8zbIy71dtVxpQLFi9TJolXd2ubj3X1khTaHQlxCtu4xOHKNOz
	HoEcGoKVFBIRQZNjnLTIrghIzEbjFXl4lQE673C+biiwvJDIQIIQIoB3lAjY44cNKlF+EH
	6tfWIhjv3WF1jAskubvWcrxZaGMqLTqGM1cIhrbBttJW1FZ3810PmdEL5dTLIw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v3 00/16] net: macb: various fixes & cleanup
Date: Fri, 08 Aug 2025 18:52:32 +0200
Message-Id: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFArlmgC/x2LQQqAIBQFryJ/naC/ougq0cLsVX+RhUYE0d2Tl
 sPMPJQQBYk69VDEJUn2kKEsFPnVhQVapszEhmvTmlZvzo96lhtJg+e6MbCWK0t5OCJ+kfueAk4
 a3vcD354mPWEAAAA=
X-Change-ID: 20250808-macb-fixes-e2f570e11241
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepvfhhrohoucfnvggsrhhunhcuoehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffejfedttdelteffudetkedvueeitdfhhefgffduhedufeehffehheegueejveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemieeigegsmehftdhffhemfhgvuddtmeelvghfugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemieeigegsmehftdhffhemfhgvuddtmeelvghfugdphhgvlhhopegludelvddrudeikedruddtrddvvddungdpmhgrihhlfhhrohhmpehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdhfv
 ghrrhgvsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriiihshiithhofhdrkhhoiihlohifshhkiheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrdguvghv
X-GND-Sasl: theo.lebrun@bootlin.com

This is a split off my previous series on MACB [0]. The main goal is to
add EyeQ5 support, but there was a lot of independent fixes/cleanup.

Overall, it is fixes first so they can be applied swiftly, followed by a
series of cleanup patches. To clarify, nothing critical. It mostly puts
the driver in a better shape and prepares it for EyeQ5 patches.

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v3:
- Cover letter: drop addresses that reject emails:
  cyrille.pitchen@atmel.com
  hskinnemoen@atmel.com
  jeff@garzik.org
  rafalo@cadence.com
- dt-bindings: Take 2x Reviewed-by Krzysztof.
- dt-bindings: add Fixes trailer to "allow tsu_clk without tx_clk"
  patch, to highlight we are not introducing new behavior.
- Reorder commits; move fixes first followed by cleanup patches.
- Drop all EyeQ5 related commits.
- New commit: "remove gap in MACB_CAPS_* flags".
- New commit: "move ring size computation to functions".
- New commit: "move bp->hw_dma_cap flags to bp->caps".
- Rename introduced helpers macb_dma_is_64b() to macb_dma64() and,
  macb_dma_is_ptp() to macb_dma_ptp().
- Rename MACB_CAPS_RSC_CAPABLE -> MACB_CAPS_RSC.
- Fix commit message typos: "maxime" -> "maximise", etc.
- Take 7x Reviewed-by: Sean Anderson.
- Add details to some commit messages.
- Link to v2: https://lore.kernel.org/r/20250627-macb-v2-0-ff8207d0bb77@bootlin.com

---
Théo Lebrun (16):
      dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
      dt-bindings: net: cdns,macb: sort compatibles
      net: macb: remove illusion about TBQPH/RBQPH being per-queue
      net: macb: move ring size computation to functions
      net: macb: single dma_alloc_coherent() for DMA descriptors
      net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
      net: macb: avoid double endianness swap in macb_set_hwaddr()
      net: macb: use BIT() macro for capability definitions
      net: macb: remove gap in MACB_CAPS_* flags
      net: macb: Remove local variables clk_init and init in macb_probe()
      net: macb: drop macb_config NULL checking
      net: macb: simplify macb_dma_desc_get_size()
      net: macb: simplify macb_adj_dma_desc_idx()
      net: macb: move bp->hw_dma_cap flags to bp->caps
      net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
      net: macb: sort #includes

 .../devicetree/bindings/net/cdns,macb.yaml         |  10 +-
 drivers/net/ethernet/cadence/macb.h                |  75 +++---
 drivers/net/ethernet/cadence/macb_main.c           | 288 +++++++++------------
 drivers/net/ethernet/cadence/macb_ptp.c            |  16 +-
 4 files changed, 174 insertions(+), 215 deletions(-)
---
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250808-macb-fixes-e2f570e11241

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


