Return-Path: <netdev+bounces-193009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37791AC2225
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00E0189C3C7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F822A1CD;
	Fri, 23 May 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gQ0QqYFn"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32F1EE02F;
	Fri, 23 May 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748000811; cv=none; b=K0q0eOxhhIfMND8Khi5kp3JhPZiH8bCAk9D92LYt+g5QSVTSpnZYCc65gfrLgX1BCHh7KduzB6SqB6KOm8H/VlZGIWlXODIxngUN1lPb6ibp+Y1MPpfUw2cV0Oi+0FdIKtsILUcoT+KN7y5svYF0+gxMU326TjSBhNg6W12LgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748000811; c=relaxed/simple;
	bh=41ZMNv9DZfWMf6Rr7Dfo1K3B4T7MWWsD7qyxjxJCH+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JH3P5G0irCxNGWXVp+cBPP6Fv5i+VYJ1FLE/GjH3naUjXQwGvdd8J0ZwPWk0GFK3eA/fmalvB9LlEVrOi9asvhu5OXC/bR2vH8YsCxKIHnsQGp4IkPByhOGEltUOtERtmRh1hHUUOMB2zoWaLInkaGsWRLhcJw3t8/+EoNVT8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gQ0QqYFn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C47C43295;
	Fri, 23 May 2025 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748000801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mDq6MieyiMr43NuOWTLdL0EFY12TTvHhRagxM34k8EA=;
	b=gQ0QqYFnk9rZG9v1uNDabbudjF8lmrEkamaDERL3owhT5l1lEXeEeiDLkZWrTlZjIbdftK
	YhYFaRMlToVaQzQqLkKEUfVckqMZmXJWuyR2gSCCRBvDd1gMvCwD37tEPc0e6XogAOLzU8
	4QhXenD1cL2qTdRj5oh1MenLyAen378EJQH7AHwYQFEvRTJaf5knDP8/kaWbbEfQM4qr6z
	456/lDSLnd3+1/ukgP+eVu7UCXooOM76pde0n3pTLTtSSs5O8CV1bneZAGw7cq+BYN1B30
	naK1UQZHYDz8AT596kQQDR5KZ3EA97lUifpSXFLqmJZtqtfSaU+3azD9v9/afw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Fri, 23 May 2025 13:46:32 +0200
Subject: [PATCH] net: stmmac: add explicit check and error on invalid PTP
 clock rate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250523-stmmac_tstamp_div-v1-1-bca8a5a3a477@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABdgMGgC/x3MQQqAIBBA0avErBN0wKCuEhFiY81CC0ciCO+et
 HyL/18QykwCU/dCppuFz9Rg+g784dJOirdmQI1WW0QlJUbn1yLFxWvd+FbBWmMw6EHjCK27MgV
 +/ue81PoBTtWoOGMAAAA=
X-Change-ID: 20250522-stmmac_tstamp_div-f55112f06029
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeejucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetudekvdffieehueeugfdujefgtddvgeekvddtieffffelvedtgeffjeekjeelgfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghplhihrdgtohhmpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

While some platforms implementing dwmac open-code the clk_ptp_rate
value, some others dynamically retrieve the value at runtime. If the
retrieved value happens to be 0 for any reason, it will eventually
propagate up to PTP initialization when bringing up the interface,
leading to a divide by 0:

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
about the actual issue.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 918d7f2e8ba992208d7d6521a1e9dba01086058f..f68e3ece919cc88d0bf199a394bc7e44b5dee095 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -835,6 +835,11 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
 		return -EOPNOTSUPP;
 
+	if (!priv->plat->clk_ptp_rate) {
+		netdev_err(priv->dev, "Invalid PTP clock rate");
+		return -EINVAL;
+	}
+
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 

---
base-commit: e0e2f78243385e7188a57fcfceb6a19f723f1dff
change-id: 20250522-stmmac_tstamp_div-f55112f06029

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


