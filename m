Return-Path: <netdev+bounces-214477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6BB29D0B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBF6206615
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392E30C365;
	Mon, 18 Aug 2025 09:02:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972827453
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507759; cv=none; b=j/cIjlJz7cPm3mIznz7TfkFKnPT1T7xjkCS/FTPlvcGfqRQLa0rllHvkWEMsDU4hK644xoJz8PSHEy3u4gZIYxqH6NOoXu7Z+Hk9tWVWrZ1qwlVEBmtUwYNiBaeq4kA86DAP+OaCfVz5zivRaSj2ixSwxeLKlT7urxQhOZJ5rYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507759; c=relaxed/simple;
	bh=qALKcs2I9DsQXdi+amMeBicjXd8u1yrHnBOjvx/vG9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4UW0PT4oA8pd73BsYLg/Igl3XaV+fC3DzTGXkSRiXvOFLIzstbPZpZqhUPSHynZYh8bIEcCs3TrvAG/DuarWKY4HOhqMSAxJ16QcG9UReWiM8zIOQQubSwG2kyGMID+U3E8vZ5k+7MFDmFqCsZQojQLwmRU96mwq6M0Fsz1y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1unvky-0003N3-Rd; Mon, 18 Aug 2025 11:02:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-000sBC-2J;
	Mon, 18 Aug 2025 11:02:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-00Bhgp-24;
	Mon, 18 Aug 2025 11:02:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 1/3] net: stmmac: Correctly handle Rx checksum offload errors
Date: Mon, 18 Aug 2025 11:02:15 +0200
Message-Id: <20250818090217.2789521-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818090217.2789521-1-o.rempel@pengutronix.de>
References: <20250818090217.2789521-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The stmmac_rx function would previously set skb->ip_summed to
CHECKSUM_UNNECESSARY if hardware checksum offload (CoE) was enabled
and the packet was of a known IP ethertype.

However, this logic failed to check if the hardware had actually
reported a checksum error. The hardware status, indicating a header or
payload checksum failure, was being ignored at this stage. This could
cause corrupt packets to be passed up the network stack as valid.

This patch corrects the logic by checking the `csum_none` status flag,
which is set when the hardware reports a checksum error. If this flag
is set, skb->ip_summed is now correctly set to CHECKSUM_NONE,
ensuring the kernel's network stack will perform its own validation and
properly handle the corrupt packet.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9a77390b7f9d..75d8d8042316 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5733,7 +5733,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
-		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+		    (status & csum_none))
 			skb_checksum_none_assert(skb);
 		else
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
2.39.5


