Return-Path: <netdev+bounces-48666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45D7EF27E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CA91F26F57
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8724330D03;
	Fri, 17 Nov 2023 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRrg83rH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61130662
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF32EC433C8;
	Fri, 17 Nov 2023 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700223494;
	bh=WnhCZYkPXtS5MLDKBrXmXcdTGW8FI0vCOXfio8BzzM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRrg83rH3yeWbGrZDy9V4lmq8r0fXbVaEGB1TjNeUM+S0pxtDdaZVKwQEFNh1qg27
	 COmS9gClLsgB91XKmiW04iINeynxFxu5QSJESUIdI7jRTCREOJsX+M4nKShVcaFjlh
	 Oa7ftJ369Y2sPV99Lo0ZT6C9njM4XY0wrbd/rINqnWvt400T1+edLfCcwHc5ZhfAe5
	 V6B9xbAik/RVxgQ4PfwGqVOSvZ1AJnzZwpmWtq0gImN1xB/fXqAo0Ezb2ylAXcxN9h
	 k2ejnhc6iowZhljPQU0oLGu7q+9gY0yNVXgJdSEe5QpVCSSLZnDZ9FkhrzWoXEF4NY
	 ICTaQkp1aQ9yQ==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	andrew@lunn.ch,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 3/4] net: ethernet: am65-cpsw: Set default TX channels to maximum
Date: Fri, 17 Nov 2023 14:17:54 +0200
Message-Id: <20231117121755.104547-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117121755.104547-1-rogerq@kernel.org>
References: <20231117121755.104547-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

am65-cpsw supports 8 TX hardware queues. Set this as default.

The rationale is that some am65-cpsw devices can have up to 4 ethernet
ports. If the number of TX channels have to be changed then all
interfaces have to be brought down and up as the old default of 1
TX channel is too restrictive for any mqprio/taprio usage.

Another reason for this change is to allow testing using
kselftest:net/forwarding:ethtool_mm.sh out of the box.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index adb29e8e8026..78b3e69fbccb 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -136,6 +136,8 @@
 			 NETIF_MSG_IFUP	| NETIF_MSG_PROBE | NETIF_MSG_IFDOWN | \
 			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
 
+#define AM65_CPSW_DEFAULT_TX_CHNS	8
+
 static void am65_cpsw_port_set_sl_mac(struct am65_cpsw_port *slave,
 				      const u8 *dev_addr)
 {
@@ -2894,7 +2896,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	common->rx_flow_id_base = -1;
 	init_completion(&common->tdown_complete);
-	common->tx_ch_num = 1;
+	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin = false;
 	common->default_vlan = 1;
 
-- 
2.34.1


