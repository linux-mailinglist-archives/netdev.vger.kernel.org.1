Return-Path: <netdev+bounces-250394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90630D29FAC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9417D30BC72D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13533A6E4;
	Fri, 16 Jan 2026 02:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305633987A;
	Fri, 16 Jan 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529428; cv=none; b=dwKYaR+No/9aE20Cg3UzOKOv++RSMxbByTD/0ibUsB3ct2tTemnsf333ytr5A1+cCKlWcUiGAdKe7bshcCdZ0xt/igC3KYZgzsISWejIehxmlWTmIET48DrEk5uCKow97CquKqBsBHGerq/7qeHQby+0J9ZktalhHT3ZSR0Lti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529428; c=relaxed/simple;
	bh=IJWGJK++gRrr1p8ncdINTIwxsbbOJ9lAnFrk7kpdz2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DR5lE2TTALxmbOFcslUTA+ONhpv/alxMoh/Y/Yf3XQfWIEyPZXX643lyibXTDUnOZn18MlFZ8wmQLbBqqHUENKubNhAQzSI6bIXOuvMykm/0VT1IWavKJnNXsngw+BGpyWjT6GHiQ2IhPSeoW/ayX6/OpBWK/n4OSM5u80B+TM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:17 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:17 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:09:25 +0800
Subject: [PATCH net-next v2 14/15] net: ftgmac100: Simplify condition on HW
 arbitration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-ftgmac-cleanup-v2-14-81f41f01f2a8@aspeedtech.com>
References: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
In-Reply-To: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=1262;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=FnxX00AXJj8bmjA76PpH8xwft0nOhpecwQN7ChV7jiI=;
 b=HXs0smQ8pWxoXwQpCKYZheJsdkXdZI9UGhwrr+8RM37/Ez6LQIfFGcCBwh6bq8ld/yML4/qGq
 bIsBfiCrdpBAjXkzplQm+EOd6fD/Fpk7VOSYiagGRRNuM5v2gghi6Tu
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

The MAC ID is sufficient to indicate this is a ast2600.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 93c1ef819abc..d2ebb7360f4a 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2030,13 +2030,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		err = ftgmac100_setup_clk(priv);
 		if (err)
 			goto err_phy_connect;
-
-		/* Disable ast2600 problematic HW arbitration */
-		if (priv->mac_id == FTGMAC100_AST2600)
-			iowrite32(FTGMAC100_TM_DEFAULT,
-				  priv->base + FTGMAC100_OFFSET_TM);
 	}
 
+	/* Disable ast2600 problematic HW arbitration */
+	if (priv->mac_id == FTGMAC100_AST2600)
+		iowrite32(FTGMAC100_TM_DEFAULT,
+			  priv->base + FTGMAC100_OFFSET_TM);
+
 	/* Default ring sizes */
 	priv->rx_q_entries = priv->new_rx_q_entries = DEF_RX_QUEUE_ENTRIES;
 	priv->tx_q_entries = priv->new_tx_q_entries = DEF_TX_QUEUE_ENTRIES;

-- 
2.34.1


