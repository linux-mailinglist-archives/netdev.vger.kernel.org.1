Return-Path: <netdev+bounces-246892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960BCF2200
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DABA13001000
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EE42DC328;
	Mon,  5 Jan 2026 07:09:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7C2C08D0;
	Mon,  5 Jan 2026 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596967; cv=none; b=r2Pc0/vK85slE2cN2R3OmQYiGRRfztTZ+dEsym5l2xEC6E6/cby34gz/0MbKJS/ZTf2+PHVti2YMa6UhzF8EMh3PDrQKMhK22vUhoz6nu6hb5+Q7PVRRZU9tsTf87GkZ4mp3WANL5QBr0Y2kGkV2evr35YIEA+e4li8bMcHefOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596967; c=relaxed/simple;
	bh=N7hQaGmYRSe0yuMHvP9Udy0NJv1QQ2M+XZ7K0zAhWyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J7wBl4pM0W97LtS6gxuE8wc5asSokC8wUKmlSEtHUlDQhzwXZJpA3hNBf43+mECnK+mMsC5DTQ9yL91uB5pjiqvqpKlwzVkjed4JCz93SxuN04YPnp+0qc+zk3SM74sKMiC4uLt4tgDVNXby5VWuwj/wggeydNxRAy9AWiv57m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:52 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:52 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:08:58 +0800
Subject: [PATCH 12/15] net: ftgmac100: Remove redundant PHY_POLL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-12-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=1275;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=OK07WGZywqscNZStTCl8lNsV7v+estKb1ypfM5betm8=;
 b=HZ4ahaO/+dBncU6FR+M+8Oim1k69rCGnUw3cyy9DZcmY0kUspNtuodtXkSs2LIm45piCNKIBU
 CkIe/fYnpnfDedz4HceOT5quSvaZoI/lkJUHWZ7d7a8azO06E0CIxCg
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

When an MDIO bus is allocated, the irqs for each PHY are set to
polling. Remove the redundant code in the MAC driver which does the
same.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index d30b0b050648..23a2212ee3bc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1712,7 +1712,7 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	struct platform_device *pdev = to_platform_device(priv->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *mdio_np;
-	int i, err = 0;
+	int err = 0;
 	u32 reg;
 
 	/* initialize mdio bus */
@@ -1740,9 +1740,6 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	priv->mii_bus->read = ftgmac100_mdiobus_read;
 	priv->mii_bus->write = ftgmac100_mdiobus_write;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++)
-		priv->mii_bus->irq[i] = PHY_POLL;
-
 	mdio_np = of_get_child_by_name(np, "mdio");
 
 	err = of_mdiobus_register(priv->mii_bus, mdio_np);

-- 
2.34.1


