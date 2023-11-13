Return-Path: <netdev+bounces-47328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E927E9AA8
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C281C20749
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996911C6B3;
	Mon, 13 Nov 2023 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcVyKSso"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F0156FA
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58709C433C8;
	Mon, 13 Nov 2023 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873643;
	bh=sHCRpYWlwN1++CWChUaVlOJq1vUhjh4oC5rKbeN65HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcVyKSsoOi4EGz1SVIaJoOdWkdYgJk+eGaUMj+OhwJibXvmBRYctyYYSwGm1ecXWS
	 VeRffEN7ClWQZBmD1mfCZHzqS2wEHQGjHUh4FzGxxi9ebmRXRBVum/KCcwfjPb5AXe
	 b7FyTWeVQXayqLvsOxk1e0p47dNGOIhislNZw8zZ8aeHULkHNw8U2BIhlFI4OLk/Wd
	 wYAvUQ7x9YVvW59RgRmWdXhS2JwDBNRBvpPe8rKTcDxF60bDu+lUnVhaTKXt/JF1g7
	 iZICMGQcBk4OPfJFHborcOpAb0FG9cxWf85cDpI2HHS7S3TtNdF0AFPPaiArgG/s6b
	 gEEb7QXjhK5xA==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	srk@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 2/3] net: ethernet: am65-cpsw: Set default TX channels to maximum
Date: Mon, 13 Nov 2023 13:07:07 +0200
Message-Id: <20231113110708.137379-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113110708.137379-1-rogerq@kernel.org>
References: <20231113110708.137379-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

am65-cpsw supports 8 TX hardware queues. Set this as default.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ece9f8df98ae..7c440899c93c 100644
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
@@ -2897,7 +2899,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	common->rx_flow_id_base = -1;
 	init_completion(&common->tdown_complete);
-	common->tx_ch_num = 1;
+	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin = false;
 	common->default_vlan = 1;
 
-- 
2.34.1


