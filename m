Return-Path: <netdev+bounces-194172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A8AC7AB3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6BB166835
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9C21B9C0;
	Thu, 29 May 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GaPZpePN"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D521B1AA;
	Thu, 29 May 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509658; cv=none; b=uMjppxIRTefGt/jozNZYMK/RreTsJqsRkkUh2XlhxX3LpqwSIvKoYn+AbrLvDOG3KjBTs/iSxZv0TeP8SD2UXScZCmYv3Y2fkcYXmP9De4kgW8BpWSdCGgVVCUh4AhJ01bezkPB+v7n60tBxE5oUD9SbBx3RxfM/0VNAwsuQdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509658; c=relaxed/simple;
	bh=KEumXAZHtIdByXzdtyPyruQVUSJnwTNNkGkXKtpL1rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtJnuTif0mSAjxGGatCQPDPvTKwYGO3fZriMDbCTtmqewXCHShfb4zgqlRMnhlchv8NeTPAkdL8hObb2CNfooi32s9AOML/3aUS3HpJMuDwM4/U/qQeGcA3vvybdu0R1nJNtHNh60Sst0Dq/tJ2fnsJihfd+0Sk7u8i1a1l8/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GaPZpePN; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F30EB432D3;
	Thu, 29 May 2025 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748509653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZ5g3I4d37jxzucB0S/BPKc0rUivwWTnKR29i4Eh0CA=;
	b=GaPZpePNw8prIZNu615qj2NhtPPgDuotlWnLtfK9GciP0L/HMGKJmp4FcRVimc19LNoCMk
	E2apjGAw+tRO/kImXPRfT8tPyVJW+CBl5rii9heI2tD/UyC9mqWmLdaZhNu/19DAHN5o53
	Xp3ZFZZIgELwmgdUNCp0SoxBPIa1QcRcx6IROnpwjV4j+Df6LaxigZqWMgclPYUVhDAp2/
	wAAJ4/zCkb0EZpBGJ5LZcR+nBydiJgkVzaKrW8zHVaheCVlZ0yqqW1SW3ZG/YHSogunXy/
	o6B9X7ZtmmSonLPAbdB46yXjspTPWQiCrYFjp+n38HOHrxYZTUN3+257hx8jTA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 29 May 2025 11:07:23 +0200
Subject: [PATCH v4 1/2] net: stmmac: make sure that ptp_rate is not 0
 before configuring timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-stmmac_tstamp_div-v4-1-d73340a794d5@bootlin.com>
References: <20250529-stmmac_tstamp_div-v4-0-d73340a794d5@bootlin.com>
In-Reply-To: <20250529-stmmac_tstamp_div-v4-0-d73340a794d5@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheejfeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrvddtkegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehmtghoqhhuvghlihhnrdhsthhmfedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhop
 ehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplfhoshgvrdetsghrvghusehshihnohhpshihshdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhorggsrhgvuhesshihnhhophhshihsrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

The stmmac platform drivers that do not open-code the clk_ptp_rate value
after having retrieved the default one from the device-tree can end up
with 0 in clk_ptp_rate (as clk_get_rate can return 0). It will
eventually propagate up to PTP initialization when bringing up the
interface, leading to a divide by 0:

 Division by zero in kernel.
 CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.30-00001-g48313bd5768a #22
 Hardware name: STM32 (Device Tree Support)
 Call trace:
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x6c/0x8c
  dump_stack_lvl from Ldiv0_64+0x8/0x18
  Ldiv0_64 from stmmac_init_tstamp_counter+0x190/0x1a4
  stmmac_init_tstamp_counter from stmmac_hw_setup+0xc1c/0x111c
  stmmac_hw_setup from __stmmac_open+0x18c/0x434
  __stmmac_open from stmmac_open+0x3c/0xbc
  stmmac_open from __dev_open+0xf4/0x1ac
  __dev_open from __dev_change_flags+0x1cc/0x224
  __dev_change_flags from dev_change_flags+0x24/0x60
  dev_change_flags from ip_auto_config+0x2e8/0x11a0
  ip_auto_config from do_one_initcall+0x84/0x33c
  do_one_initcall from kernel_init_freeable+0x1b8/0x214
  kernel_init_freeable from kernel_init+0x24/0x140
  kernel_init from ret_from_fork+0x14/0x28
 Exception stack(0xe0815fb0 to 0xe0815ff8)

Prevent this division by 0 by adding an explicit check and error log
about the actual issue. While at it, remove the same check from
stmmac_ptp_register, which then becomes duplicate

Fixes: 19d857c9038e ("stmmac: Fix calculations for ptp counters when clock input = 50Mhz.")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Changes in v4:
- collect RB tags
- rebased on net/main

Changes in v3:
- remove now-duplicate check
- reword commit message
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 085c09039af4a5ebfbb86a3743960d9747367588..1369fa70bc587e5c9e22fc33f69bc9ca0774be86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -805,6 +805,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
 		return -EOPNOTSUPP;
 
+	if (!priv->plat->clk_ptp_rate) {
+		netdev_err(priv->dev, "Invalid PTP clock rate");
+		return -EINVAL;
+	}
+
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 429b2d357813c8023fc853299f206208f15642e1..3767ba495e78d210b0529ee1754e5331f2dd0a47 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -317,7 +317,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
-	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
+	if (priv->plat->has_gmac4)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
 	/* Update the ptp clock parameters based on feature discovery, when

-- 
2.49.0


