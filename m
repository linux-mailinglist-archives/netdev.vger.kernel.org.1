Return-Path: <netdev+bounces-185408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE50A9A303
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D47D448569
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B621F4174;
	Thu, 24 Apr 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QVxFnV4n"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FDB1E8837;
	Thu, 24 Apr 2025 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478764; cv=none; b=kcOE9DA56b+Ov32qncJ/9YPhgmA5+iwD4hW5f+xvBuIJqj7mnpdJkmldsE9gVXCwdSnnDJxQYxTjUGxPILmwdyueJXDEx+RfRhI57a83pu2Et1t3+cHi12rxdXGEY9tbv7rblfFeVc9M082498bhUFZK2afuQF6RyEYettoSIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478764; c=relaxed/simple;
	bh=Nket0V+2rHL7XX8pB1qYdHZxQcoaPLfZHv8WxRVn1SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV/g2uHgku6601kseD0ZX6obqTjR4/C5SpdwNxYQxI8u5Q12depXC4APBnOCPnqr5G+hQD7bbtKiA6/qunDLyHOFY/pN9DJqoPq8SMrOCP1jSkW0uIrcTUPI/dyEtu3TfHQX9i66BJXfJF7/nESCvhYplx6LBLmPzEzEZr0v/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QVxFnV4n; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 950CD43A3B;
	Thu, 24 Apr 2025 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745478753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycgJR5zEjmvD8nS6gQ3Tfwq4cma6r3cAZuNgLAzZkLY=;
	b=QVxFnV4nnmjm0W6PgA89ziic6glf/WhsXppf1wp5l1jwnTD/c5TE9YqEwMubYbqUSQsGSk
	zpfgnzEklh2h+PVnY22d6I2CGvXRkzNBtlKRkfnyLCkBCklpc0rksJndomBtmWzi8q0TBi
	Xk2xQbWFN+j5W74mLv+rkcnnM7/pvW0rHiEaQWwgnTYudMfVtqJRjPXRaKTYXgNCAhh/xG
	TtSBHudzUsIImDHnZmUBMpVItw643TnfefToCCZEXW/NYO48mohjF2OQoS20SN+RbSzUAC
	bqia88SdKtqM1kFLNOm31LIdpZhB6+Mi0AXAnu2Kd0bOxK7AD4AhYmX9eDXLGA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v3 3/3] net: stmmac: socfpga: Remove unused pcs-mdiodev field
Date: Thu, 24 Apr 2025 09:12:22 +0200
Message-ID: <20250424071223.221239-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
References: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeekkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhto
 hepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

When dwmac-socfpga was converted to using the Lynx PCS (previously
referred to in the driver as the Altera TSE PCS), the
lynx_pcs_create_mdiodev() was used to create the pcs instance.

As this function didn't exist in the early versions of the series, a
local mdiodev object was stored for PCS creation. It was never used, but
still made it into the driver, so remove it.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c832a41c1747..72b50f6d72f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -59,7 +59,6 @@ struct socfpga_dwmac {
 	void __iomem *sgmii_adapter_base;
 	bool f2h_ptp_ref_clk;
 	const struct socfpga_dwmac_ops *ops;
-	struct mdio_device *pcs_mdiodev;
 };
 
 static void socfpga_dwmac_fix_mac_speed(void *bsp_priv, int speed,
-- 
2.49.0


