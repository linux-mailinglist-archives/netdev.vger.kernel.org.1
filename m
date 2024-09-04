Return-Path: <netdev+bounces-125220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A3696C536
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B561F28F8E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE61E4114;
	Wed,  4 Sep 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H9HXXRE6"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956631E1A29;
	Wed,  4 Sep 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470314; cv=none; b=jxa5hL0x3JDgkYrKqsPhXVOTZFdQodN7G3xvOpXf6jtNoyhykhP/WgRFzvY8GNQW4on72k+Hc2vWmboetBI2y07AYHQwmwAFjcR+QuVmYtIFAZh7zXt9xwCtvBHlhr5Tb2tyjaEL7zAD1JPkH/b3zA4po8YC/Uj2fowSyuJZEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470314; c=relaxed/simple;
	bh=iKRX9MFjfFKPGpAC4p5yXE3AQjwCy7NcFH/pikbmoIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHzXGFNjJBXCjaKBKH1w3H89IAOG/apyO+mNovKWJeUXjDEI7G8M5SYbDDI+6Hkwg4vtAi9a5N49wza0Anb6LeoM65mHFwoQfL795Anxa6i19AvZNQoDLZBg5Y9v9WSNJaEur1GiJ++mzCzVuBlgDOeMT/KtHs1Yo2sJWR8rUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H9HXXRE6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D29B1BF20C;
	Wed,  4 Sep 2024 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725470311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kGq3499FtlBClmzbPXpk3ZXJBn56yooNXdhMBe0V80=;
	b=H9HXXRE6dBQd93wIULJuyRW9j/G4me/9hMba+GAOzBYwVihWR8xecoivAtWhgGx0TP5yMj
	xtHVpqxO8HyXzuFpH+5eWI+Y58RiySnQtF2avwp0aQ3Qy1u1hGFcqyoaS/ljwmX6yCOB2M
	5UqUPYUcBXxi3c2Zs/JwYWw4d/8cyZP4O4mUJlCHABg55So+aKI+HDe62CZ8gZyqW8qxMb
	HTbvHYnAIz1LB1v5vqwbQNX11I38VCMHnW8Q8kF2dcEZaBtm/jbc+/XZdfnfHQ8WWCN6hE
	hQ2I8ryv8BVYng7TCsKZLC5h/mD+93KOweyzgMgk9arBzIaUNpMV6aqTienCmg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 7/8] net: ethernet: fs_enet: simplify clock handling with devm accessors
Date: Wed,  4 Sep 2024 19:18:20 +0200
Message-ID: <20240904171822.64652-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

devm_clock_get_enabled() can be used to simplify clock handling for the
PER register clock.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/freescale/fs_enet/fs_enet-main.c    | 16 ++++------------
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h |  2 --
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index c96a6b9e1445..ec43b71c0eba 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -900,14 +900,9 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	 * but require enable to succeed when a clock was specified/found,
 	 * keep a reference to the clock upon successful acquisition
 	 */
-	clk = devm_clk_get(&ofdev->dev, "per");
-	if (!IS_ERR(clk)) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			goto out_deregister_fixed_link;
-
-		fpi->clk_per = clk;
-	}
+	clk = devm_clk_get_enabled(&ofdev->dev, "per");
+	if (IS_ERR(clk))
+		goto out_deregister_fixed_link;
 
 	privsize = sizeof(*fep) +
 		   sizeof(struct sk_buff **) *
@@ -917,7 +912,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	ndev = alloc_etherdev(privsize);
 	if (!ndev) {
 		ret = -ENOMEM;
-		goto out_put;
+		goto out_deregister_fixed_link;
 	}
 
 	SET_NETDEV_DEV(ndev, &ofdev->dev);
@@ -979,8 +974,6 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 out_free_dev:
 	free_netdev(ndev);
-out_put:
-	clk_disable_unprepare(fpi->clk_per);
 out_deregister_fixed_link:
 	of_node_put(fpi->phy_node);
 	if (of_phy_is_fixed_link(ofdev->dev.of_node))
@@ -1001,7 +994,6 @@ static void fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
 	of_node_put(fep->fpi->phy_node);
-	clk_disable_unprepare(fep->fpi->clk_per);
 	if (of_phy_is_fixed_link(ofdev->dev.of_node))
 		of_phy_deregister_fixed_link(ofdev->dev.of_node);
 	free_netdev(ndev);
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index ee49749a3202..6ebb1b4404c7 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -119,8 +119,6 @@ struct fs_platform_info {
 	int napi_weight;	/* NAPI weight			*/
 
 	int use_rmii;		/* use RMII mode		*/
-
-	struct clk *clk_per;	/* 'per' clock for register access */
 };
 
 struct fs_enet_private {
-- 
2.46.0


