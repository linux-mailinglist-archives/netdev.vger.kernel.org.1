Return-Path: <netdev+bounces-306759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WvFIFsn6UWoiLAMAu9opvQ
	(envelope-from <netdev+bounces-306759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:11:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC957740DA5
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pigmoral.tech header.s=zmail header.b=m8Y2rSDv;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306759-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306759-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 643733019F34
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A613C37F75B;
	Sat, 11 Jul 2026 08:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D652FD694;
	Sat, 11 Jul 2026 08:11:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783757507; cv=pass; b=cgFIRu/JmPuFol/r5/7w+atMOaNxRQ0Xqm0GQpkZKDLupf4vxFxNLd2843FDrkYKcUchteCLMoRcVdmPZ5CRNcfjFJb0CRL6vSqGR7SmDEYFk083gEI7+el16mrUsVw9iKK6lb1cvHTTWHKIkeNWOMWbf3dT+FHr03TI65fRkNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783757507; c=relaxed/simple;
	bh=C4/qzNHgAQL8cgNF9m01gDg70Z4cEsgSM7Av3F+071A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aT0FTzWl5PJY53hLTkiRltbOOn7Mcq7bCDGkHhHl7X9Y/V8f05KDVYXITGD358e+ZLg5JQD1IDtVmh+SgCNhy4uJm3HZNDLKjs8P/Q8q8Q7AJfgeoji21RAI+u+y6Uaz/L+yxhp4MYgc4msvHKLtaG98ItwwHddrSh/7EjKj8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=m8Y2rSDv; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal: i=1; a=rsa-sha256; t=1783757468; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vp84AO56jRRT0ZQ9JWyaymHr1uGFyI/D7Vj31wvH1Rz+js/bE1WcoB5nBKEI4n+pFeJF0nH1LnenHxjHTymeBFUZLWEfyw6Pi4G0eKBnie7xojv4DPhhdPLqil9nwMIHMnI8vIdqhFcJTMfw4QsjpvMc7NFV3evVaJXdHMZ2sAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783757468; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jyzBEPuIilIp5vlpq1+O3NegYQSfadwH2sc1+j1+Ngg=; 
	b=W4dbxzu89yigXajnMtawGCTizlPgz61Ew2O5Da/8k4UOES4wXsrhyiXa5lTmxfBVp3rXNKG5LrJUAd4E9Pa7fcvltGltzUGxD1eTqB06k+nLMj4ONuw56J98/F7iCbpRCU1yfwYMr4HEU9SyNTafDjA/oPY2aeL4R/dMo9vjZ8k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783757468;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=jyzBEPuIilIp5vlpq1+O3NegYQSfadwH2sc1+j1+Ngg=;
	b=m8Y2rSDvrdU4Iw2dpCtIEo/BycS6EHwBz6R641v9p9WDf7GQZLMdNoGNAjbgB1gb
	kzQNUAv39v4MWKyP6US2Ko8xxXSlH1GmlqM8DAc47FifSFLxivw1mWNtLVTDiIpZxQv
	W0fvf5oSLX7Qz5GmJ7gFniaHZwTf2UzsMGPuIhP4=
Received: by mx.zohomail.com with SMTPS id 1783757465990476.2860850817026;
	Sat, 11 Jul 2026 01:11:05 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
Date: Sat, 11 Jul 2026 16:10:26 +0800
Message-Id: <20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMQQ6CMBCF4auQWVsztBWCK+9hWJQypRORkpYQD
 eHuVly4meSfvHwbJIpMCa7FBpFWThymHPJUgPVmGkhwnxskygrzEaZWStjxIbDXziKaxjUW8ny
 O5Ph1UPc2t+e0hPg+5LX8fn+IKvGPrKVAoapOU9NJrS/1bebhGaIZzwtZD+2+7x+tk2VtpAAAA
 A==
X-Change-ID: 20260202-a733-clk-0d4fc00a9f9c
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783757449; l=3794;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=C4/qzNHgAQL8cgNF9m01gDg70Z4cEsgSM7Av3F+071A=;
 b=owef9gnwxUPldZnALee1bOMiT2P4HbKPi5VdAYR4Oyw8i/dhVZVODKcuh/PWpayDV07gjftiU
 LJ8e/kSmDDiDFHenfID0+du6wCn8UFbdBU7o1blvMUJiKKZ/vgB2yyA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:junhui.liu@pigmoral.tech,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:jbrunet@baylibre.com,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[pigmoral.tech];
	FORGED_SENDER(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306759-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pigmoral.tech:from_mime,pigmoral.tech:email,pigmoral.tech:mid,pigmoral.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC957740DA5

Add support for the main CCU and the PRCM module (R-CCU) found in the
Allwinner A733 SoC. The clock architecture of the A733 is an evolution
of the previous A523 design but introduces several significant changes.

One of the key changes is the introduction of a "pll-ref" clock that
normalizes the physical oscillator frequency (which can be 19.2MHz,
24MHz, or 26MHz) into a consistent 24MHz reference for the entire clock
tree. Additionally, while the A733 inherits many module clock structures
from the A523, the MCU_CCU has been removed, and the overall clock tree
has been expanded to support more new functional units.

Also update the sunxi-ng SDM (Sigma-Delta Modulation) helper to support
a new dual-pattern register design. On the A733, the SDM enable bit has
been moved from the main PLL register to a second pattern register
(PATTERN1). The driver is updated to handle this register layout to
ensure accurate frequency synthesis for "pll-audio0".

The parent clocks for several instances in the main CCU are difficult
to determine as the user manual provides limited information on their
specific clock sources. In these cases, the implementation follows
vendor practices and previous SoC designs, generally defaulting to
"hosc" where documentation is lacking. The bus clock gates in the PRCM
(R-CCU) are explicitly defined based on the Memory Map in the manual,
which clearly associates each module with its respective bus.

---
Changes in v2:
- Rework the clocks property in DT bindings to source hosc directly from
  the oscillator to adapt to the new RTC binding
- Clean up the SDM dual-pattern helper macro and add the missing enable
  parameter for pll-audio0
- Number single-instance clocks with 0, e.g. GPU0, VE_ENC0/VE_DEC0,
  DRAM0, NAND0, GPADC0, THS0, etc
- Correct 8x PLL post-divider names to 12x for video and DE PLLs
  (pll-videoX-12x, pll-de-12x)
- Drop gic, cpu-peri, nsi clocks
- Rename clocks: OWA -> SPDIF, USB_REF -> USB01_REF, HDMI_ESM -> HDCP_ESM,
  PWMCTRL -> PWM
- Mark bus-dram0, ahb-store and mbus-store critical to avoid DMA, MMC and
  SPI NOR failures when unused clocks are disabled
- Switch PRCM timer clocks to P-only helpers
- Fix bus gate bit positions for UARTs and correct the sysdap register
  address
- Interleave bus clocks into function clocks
- Link to v1: https://lore.kernel.org/r/20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech

---
Junhui Liu (8):
      dt-bindings: clk: sun60i-a733-ccu: Add allwinner A733 support
      clk: sunxi-ng: sdm: Add dual patterns support
      clk: sunxi-ng: a733: Add PRCM CCU
      clk: sunxi-ng: a733: Add PLL clocks support
      clk: sunxi-ng: a733: Add bus clocks support
      clk: sunxi-ng: a733: Add mod clocks support
      clk: sunxi-ng: a733: Add bus clock gates
      clk: sunxi-ng: a733: Add reset lines

 .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  |  107 +
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    4 +
 drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c           |  273 +++
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2360 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.c                     |   51 +-
 drivers/clk/sunxi-ng/ccu_sdm.h                     |   29 +-
 include/dt-bindings/clock/sun60i-a733-ccu.h        |  290 +++
 include/dt-bindings/clock/sun60i-a733-r-ccu.h      |   39 +
 include/dt-bindings/reset/sun60i-a733-ccu.h        |  129 ++
 include/dt-bindings/reset/sun60i-a733-r-ccu.h      |   23 +
 11 files changed, 3289 insertions(+), 26 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260202-a733-clk-0d4fc00a9f9c

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>


