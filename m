Return-Path: <netdev+bounces-194171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165EAC7AB2
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5493BE809
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD73F21B8FE;
	Thu, 29 May 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GjSyVNNh"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FE21B8E7;
	Thu, 29 May 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509658; cv=none; b=XxK9tZBQyqyhaI7YZwPWO3JGB7bTnxeEYZfAyPPTPFutZxROPURe7pqn+1jfYleOeKjYx+HEH+x/rKtwObLiwvWe4YjO7DiFk584PiOGXacYzy6oLsAGPX0CwSPYPgmp/vu733i3OdCkyI+weR4IXiGwXcjw5lU2TGDXk1VKq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509658; c=relaxed/simple;
	bh=kt06qG21bNiOO3942z5f6u5otZChTpCNpMBVPfOTL4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RwqI0ecXKEdUa4rNdChpxdnnFBgTzcZmSnLdFC0ArUbprJSWO+RkrSFyf+NfAJ0aJ0nKsSd0hbjSawXGnc3zMW850qH5IS9he87H1/0lJx7aKf6DoVD4LC9GZbRdpbneCfsuK4qoD1jYMJnnNoH4P9ayvO2ceAZo68wbAUjugBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GjSyVNNh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D39D3432F7;
	Thu, 29 May 2025 09:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748509652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mPkPFeJr+GG2QcllwMOxn9k+r0jQZG2uRhor86+okS8=;
	b=GjSyVNNhLuWD0eGfSgz+3Na5WuC2OLzLh+5UnSJNzmVrch94OoeOIFQsbUUciQ5mVMulgU
	+QFiWpUrs3eTBRdCWjtrqiIWAj36uYmsahEcEjnm8tOxk/lEiniaH/9BTj1vf5is09GDXs
	QPbSLpgKtUIPgHaUY8tGCqdYrdu4eLsPs7hI6I/dU8hb065JCHL5il/ka5TewcMuDSQZq6
	6IRdyaD40n/GlpN7kwPFjaCuPnEDyVd2PPjEwaSf0GTe3aHp05g1uua356TOMb1nwSn53v
	/7x3obzzl3JCMiCjQRlmex//ESAt1MC5dqgiGZaIkGiEfRUE0TZPmFZNt9izoA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH v4 0/2] net: stmmac: prevent div by 0
Date: Thu, 29 May 2025 11:07:22 +0200
Message-Id: <20250529-stmmac_tstamp_div-v4-0-d73340a794d5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMojOGgC/23N0QqCMBTG8VeJXbfYzjxqXfUeEbLNmYN04sYox
 HdvCoGRl/8Pzu9MxJvRGk8uh4mMJlpvXZ8iOx6IbmX/MNTWqQkwQIYA1Ieuk7oKPshuqGobaYP
 IOTQsZ3Am6W4YTWNfq3m7p26tD258ry8iX9avJna0yCmnSstSohQyK4qrci48bX/SriOLF2FrF
 HsGJCPPBSBXQmEG/4bYGuWeISijCgGNrpu6zPSvMc/zB2EIctk8AQAA
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
 Jose Abreu <Jose.Abreu@synopsys.com>, Yanteng Si <si.yanteng@linux.dev>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheejfeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffefvdelledtfeekudelvdekvdeuffduieevkedviedtgeefueehgfdvuedthfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurddvtdekngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtoheprhhitghhrghruggtohgthhhrrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrt
 ghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeflohhsvgdrtegsrhgvuhesshihnhhophhshihsrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohgrsghrvghusehshihnohhpshihshdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this small series aims to fix a small splat I am observing on a STM32MP157
platform at boot (see commit 1) due to a division by 0.
There is no functional change in this revision, this has just been
rebased on top of net/main.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Changes in v4:
- collect RB tags
- rebased on net/main
- Link to v3: https://lore.kernel.org/r/20250528-stmmac_tstamp_div-v3-0-b525ecdfd84c@bootlin.com

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
base-commit: 271683bb2cf32e5126c592b5d5e6a756fa374fd9
change-id: 20250522-stmmac_tstamp_div-f55112f06029

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


