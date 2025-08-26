Return-Path: <netdev+bounces-216965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45374B36B1D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA29C1C45747
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C7350851;
	Tue, 26 Aug 2025 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tB4vy3ww"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6419352FD4
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218651; cv=none; b=TcL3mXnPfCCQYISkDhiA6bgAu3GBnm9LEQyRcWPm/bfjE8gqz8X+EWRODOBEkwK73yyTh5k4v9nGpCblk+U7GL6jEtUB+nwQjbfJhiR5YzZAU6/JLBJk3PZallt/IoiV+48lF8P0412xhF2B/XbeLKy1LyU2MYkwabyAXzXF7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218651; c=relaxed/simple;
	bh=uXNI4bQ3AbAZOS1zgTjXD+zsVVSXdhhuIZU4+M2tGY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szo30eozaz1FqhLtfqOQIRe/IA7PS/8gKYAlZjnHKo1WScMnn94JJ9pXEH4vVK6ob+HaVO3IyMFuNYGqKEF8xPCaDLzioUNkQt6bsXwz+yCrV8DnMTo+Ajs03F9fnJFJ0JBkCI1F4+SX9+YPxyE2bO5dgd2M1RXQPN58ATttdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tB4vy3ww; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756218636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6JxtbOXSRkomOfuA5EBVABjJNq8UxfxHsZRgnolb+hM=;
	b=tB4vy3wwusGXq053PKnR5gdPrRrXzbC78L5W5PE26X3GDLFbORyAOpbAMGn+BHKXCPoiCD
	bdOMUq1Fcw49OgJosrAdUhFezjYlR78GPimmDuJ+0590MrjKr+f5kq2V5mZZgVGrmSahkB
	+dwkagCbOK80tHFERB6r/mDLFTEKU3U=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	Neil Mandir <neil.mandir@seco.com>,
	linux-kernel@vger.kernel.org,
	Harini Katakam <harini.katakam@xilinx.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2] net: macb: Disable clocks once
Date: Tue, 26 Aug 2025 10:30:22 -0400
Message-Id: <20250826143022.935521-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Neil Mandir <neil.mandir@seco.com>

When the driver is removed the clocks are disabled twice: once in
macb_remove and a second time by runtime pm. Disable wakeup in remove so
all the clocks are disabled and skip the second call to macb_clks_disable.
Always suspend the device as we always set it active in probe.

Fixes: d54f89af6cc4 ("net: macb: Add pm runtime support")
Signed-off-by: Neil Mandir <neil.mandir@seco.com>
Co-developed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Spruce up the commit message
- Rebase

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b29c3beae0b2..ca9f671d971f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5404,14 +5404,11 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
+		device_set_wakeup_enable(&bp->pdev->dev, 0);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-		if (!pm_runtime_suspended(&pdev->dev)) {
-			macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk,
-					  bp->rx_clk, bp->tsu_clk);
-			pm_runtime_set_suspended(&pdev->dev);
-		}
+		pm_runtime_set_suspended(&pdev->dev);
 		phylink_destroy(bp->phylink);
 		free_netdev(dev);
 	}
-- 
2.35.1.1320.gc452695387.dirty


