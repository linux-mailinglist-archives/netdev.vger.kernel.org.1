Return-Path: <netdev+bounces-246894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B36CF222A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D6403018437
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8532DCC04;
	Mon,  5 Jan 2026 07:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E5286408;
	Mon,  5 Jan 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596972; cv=none; b=dN2NKoqyPJetSjZVGWB8CKQPgukW1uYToHs+/vQcS7pVtbL3QM5+dZZAUVfmKr6TlWjqG25Nb2pQjA3d9kdPVfs6B4MPCY9hDHx9pUIxOjy4wBnxQ4s30wNIluFynbpkiPOQJJkYtJR5rNUOGdez6RjDfEMKXx2lviwkHJSSxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596972; c=relaxed/simple;
	bh=PrAJ4wQMmXJcV1h0udjZuA4xTtpeRqTZg4dLRIzZaww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c+HMOai7eg5G8vKt0VFZFM+TCoNJQBx24HHjxzzhEQwMOdcJojmojc1AVuHWC1bFtTdjYJpQkhta2dEaV48evHcjNx+SdnPWvhYW1rnRrz5S7BU4y9OBZcWoPeTfWGLig1nTlfB0O3nwXGd5fJrVnwlBDc5MQQh0CwNl6WXiRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 Jan
 2026 15:08:53 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 5 Jan 2026 15:08:53 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 5 Jan 2026 15:09:00 +0800
Subject: [PATCH 14/15] net: ftgmac100: Simplify condition on HW arbitration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260105-ftgmac-cleanup-v1-14-b68e4a3d8fbe@aspeedtech.com>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767596931; l=1216;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=fYKQ5LeYKEpuI1fnPxPK8Gt5GiBUBdPOZZycvwLxNlE=;
 b=U4o9xmQsCGgYf2HtIIawDYn/aUnfrKm9E27sFEa3MrJVBdxua8FMRU6+7EEypVYk6NG/KLwn1
 8RfgBjsjYLpDPHJi9nNKXwLQEDh2EqoAmYB82m0+F1mOFKDDatmAsis
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

From: Andrew Lunn <andrew@lunn.ch>

The MAC ID is sufficient to indicate this is a ast2600.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 982944ab1ff1..38e7ac6628d5 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2031,13 +2031,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
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


