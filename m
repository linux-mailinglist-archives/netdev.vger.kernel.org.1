Return-Path: <netdev+bounces-59003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BB818E9A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED00EB22C67
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0623D0A3;
	Tue, 19 Dec 2023 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="bUXTNPRh"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567363C09F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231219174634051dd142011dd95b83
        for <netdev@vger.kernel.org>;
        Tue, 19 Dec 2023 18:46:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YA9kxXyTpKbUvAn5fk/7icCgdnpCMYJTim3PliscYAY=;
 b=bUXTNPRhEhqRbjbsl+OVO9bgMJNhEDFMxWUCtDAOxz1Igk7PYEoeT5PiTqLiY+rrwsusvQ
 RH2ZOdLOjod4sT7mlH5TQ4amYNLhQvlfWcRA07U9aA8tGOuW8pqfDaR584RhCISEiW+yxiwl
 r1CKEhn4Nmucw3UWe3Xc7SM5c6oaM=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	grygorii.strashko@ti.com,
	andrew@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC PATCH net-next 6/8] net: ti: icssg-ethtool: Adjust channel count for SR1.0
Date: Tue, 19 Dec 2023 17:45:44 +0000
Message-ID: <20231219174548.3481-7-diogo.ivo@siemens.com>
In-Reply-To: <20231219174548.3481-1-diogo.ivo@siemens.com>
References: <20231219174548.3481-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

SR1.0 uses the highest priority channel to transmit control
messages to the firmware. Take this into account when computing
channels.

Based on the work of Roger Quadros in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index a27ec1dcc8d5..29e67526fa22 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -141,6 +141,9 @@ static int emac_set_channels(struct net_device *ndev,
 		return -EBUSY;
 
 	emac->tx_ch_num = ch->tx_count;
+	/* highest channel number for management messaging on SR1 */
+	if (emac->is_sr1)
+		emac->tx_ch_num++;
 
 	return 0;
 }
@@ -151,9 +154,12 @@ static void emac_get_channels(struct net_device *ndev,
 	struct prueth_emac *emac = netdev_priv(ndev);
 
 	ch->max_rx = 1;
-	ch->max_tx = PRUETH_MAX_TX_QUEUES;
+	/* SR1 use high priority channel for management messages */
+	ch->max_tx = emac->is_sr1 ? PRUETH_MAX_TX_QUEUES - 1 :
+				    PRUETH_MAX_TX_QUEUES;
 	ch->rx_count = 1;
-	ch->tx_count = emac->tx_ch_num;
+	ch->tx_count = emac->is_sr1 ? emac->tx_ch_num - 1 :
+				      emac->tx_ch_num;
 }
 
 static const struct ethtool_rmon_hist_range emac_rmon_ranges[] = {
-- 
2.43.0


