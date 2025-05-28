Return-Path: <netdev+bounces-193919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDFDAC6482
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815781883872
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B3156F3C;
	Wed, 28 May 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P7aRpHv7"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96144268FDD;
	Wed, 28 May 2025 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421009; cv=none; b=sph9DAvI6B9FnUKPSlxQMH4tq3ZlSzdDwtaD7wQ1le01BpaCGOXAx9aBC+kLD23WxTTPtFPutvdk2LtDHN04kJ6605L43VsAjhRkE7zMY8I4dNzW4TBXrTL0Hluhlyb8eC9ggz6yzKPWw7K/p+Z7qSB8CQuRhogqZInqIVWpDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421009; c=relaxed/simple;
	bh=T3lD6gZ98QUASETxVSn3qZ/GWqCoVzjcL8V3LnhqE44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JEFzmbICbdxNyH5+BVjH85Dv6MeIyWx8wluvgsRtvNrjI21kG7VPWEXNi1MNSVIAU+nX0xs0HrWRFHGYuV2Uzc1Spsxzj10/O6FbHP4cUt8LMx6y0nDTPMolp4kK73piBoG+vMKSMbBDniSIaT9S7zHeiaJepN+1+5cii1fqhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P7aRpHv7; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A2A743153;
	Wed, 28 May 2025 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748420999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NdtCm4KeLnVfdZbdleEEAwUOA4JSpjcY4XsOVNaCHbA=;
	b=P7aRpHv7sMWWrZgOxiKy1icjDjdNKPlrhclj5/VB53qk4dbSNWVQoiwJRhv8erY0AQcw1D
	I4VB4G1QvEcmKyuxr9+CNXY/N/IkfahRsO70dhKZIo7AvRTMUHIhlcyrgfsxE+X+N6fvNS
	kPWL9uB0+1RclnJDiq/3XiSiGjGivFgDLf7JBujpLMw2zeaLZ99v905KZlEVsdwGMEqrYV
	zbFbwyG6IVPGuB9n+FZ4OyM3m0JkCWwLI5gakTFl3bSTTxGg/dd3CesKN5CZy0SihhDSJL
	9dskNPfyLFiJtnMcb4DCDmxTZOPtqu+Td0sI/q8V7yBqy7BIATfIn/qW5S5qiw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH v3 0/2] net: stmmac: prevent div by 0
Date: Wed, 28 May 2025 10:29:49 +0200
Message-Id: <20250528-stmmac_tstamp_div-v3-0-b525ecdfd84c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH3JNmgC/23N0QrCIBTG8VcZXmfocW7VVe8RMdS5dqDNoSLF2
 LvnBkHBLv8fnN+ZSbAebSCXYibeJgzoxhziUBDTq/FhKba5CTCQTALQEIdBmSaGqIapaTHRTkr
 OoWMVgzPJd5O3Hb4283bP3WOIzr+3F4mv61cTO1rilFNt1ElJJVRZ11ftXHzieDRuIKuX4Neo9
 wzIRlUJkFwLLUv4N5Zl+QDThLVm+AAAAA==
X-Change-ID: 20250522-stmmac_tstamp_div-f55112f06029
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Phil Reid <preid@electromag.com.au>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdejkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffefvdelledtfeekudelvdekvdeuffduieevkedviedtgeefueehgfdvuedthfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvudgnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrv
 gessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtoheplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghplhihrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this small series aims to fix a small splat I am observing on a STM32MP157
platform at boot (see commit 1) due to a division by 0. This new
revision add the same check in another code path possibly affected by
the same issue, as discussed in v2.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v3:
- remove now duplicate check
- add ptp_rate check in est_configure
- Link to v2: https://lore.kernel.org/r/20250527-stmmac_tstamp_div-v2-1-663251b3b542@bootlin.com

Changes in v2:
- Add Fixes tag
- Reword commit message to clarify the triggering cause of the issue
- Link to v1: https://lore.kernel.org/r/20250523-stmmac_tstamp_div-v1-1-bca8a5a3a477@bootlin.com

---
Alexis Lothoré (2):
      net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping
      net: stmmac: make sure that ptp_rate is not 0 before configuring EST

 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: e0e2f78243385e7188a57fcfceb6a19f723f1dff
change-id: 20250522-stmmac_tstamp_div-f55112f06029

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


