Return-Path: <netdev+bounces-184591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917CA964FB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CB33B1632
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786F3202998;
	Tue, 22 Apr 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ERqujlM/"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC71F1909;
	Tue, 22 Apr 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315244; cv=none; b=m9nAL5xkGSitKRzKKl7X1UKQTIyvmwwAOdHgpz1f2I71mhFdX2UNhDLwgE6/CGvIXxw6yjCzcLe+vifTzIogT/9NYslrvQR8pMCZcACEq2D+nO6qNL3hJunieWa7hlBq6zAWKyIRC67Rwx5jYbaqdvI32BKm/GA9SQR5UYMvMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315244; c=relaxed/simple;
	bh=3lSdy8EzxVOmuuVCSV9qU2SdEBAnF/V1ykKqrIW2Cdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpQS2l4V12VJUakbDMkppBUIc1UWKFqs/hWzfaFaTfYC0ffXnYsSj4v5arbJLhX+OgvLrwFf2t/uxuNKPZJguHpxGblc0L6UlYSaTnBXz3zIyHli7K0kBarvdJGkMO4VqtAop1ejPqWEgJeq9gFsgGMKen/3V2QNznU4ShoGz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ERqujlM/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C260043305;
	Tue, 22 Apr 2025 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745315239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMRZ/nAaAeNPv9wwBFEXUEGanmmzjiz1coElczHCTLU=;
	b=ERqujlM/jg+ImxXcI66I7sXIW7x4rAHBIMW5bMjzKOnmPQB5jkcur7x2aW5Z4So2FYdES4
	rMPqKSFYHNdLJC86u8h7n3WO1t0JFVK/3/QoAr7hG8HnejRThTREpewPPoi1ocmZ48OHdI
	Mfrj/GjeJ+njc/x1O9tiJKEVFj7PjvfuumAxcY/KylFP/kYPzxwc0f7St4qqGE5mmG2Awk
	TOe/mPemOSL0XaV/6hsjz/D1NHzEC9VwEhfQDN2cAp+C1lhzu4YQ2/Gcj2Pbs2U1btPvq0
	u6AYMOhEJpDOrzcObWmVCGg4ZMnhgvhfgwSLPSJJl/RBOKZKskkEdhe1ctkQrQ==
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
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net 3/3] net: stmmac: socfpga: Remove unused pcs-mdiodev field
Date: Tue, 22 Apr 2025 11:46:57 +0200
Message-ID: <20250422094701.49798-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
References: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmegtkedufeemgeejtgeimeejudelrgemlegusghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemtgekudefmeegjegtieemjedulegrmeeluggsfhdphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

When dwmac-socfpga was converted to using the Lynx PCS (previously
referred to in the driver as the Altera TSE PCS), the
lynx_pcs_create_mdiodev() was used to create the pcs instance.

As this function didn't exist in the early versions of the series, a
local mdiodev object was stored for PCS creation. It was never used, but
still made it into the driver, so remove it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index cc9946b58236..cecfe77c8b72 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -59,7 +59,6 @@ struct socfpga_dwmac {
 	void __iomem *sgmii_adapter_base;
 	bool f2h_ptp_ref_clk;
 	const struct socfpga_dwmac_ops *ops;
-	struct mdio_device *pcs_mdiodev;
 };
 
 static void socfpga_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
-- 
2.49.0


