Return-Path: <netdev+bounces-64027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB78830B89
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F58A1C20E34
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56412224E7;
	Wed, 17 Jan 2024 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="SbZgm6Xa"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08F22326
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510606; cv=none; b=PqhbOipxHKN0mp4iu7ZEj/B6gXNF92U6EiGDC9+qXxHHZgJTh9QEH/ryX7yubElrFzJCFYYB5p6bRggJ1elWE+lEb9rmwd53j7Rr+iORFqfA7/O1as6nXSAPtzqfGTjK855lQ/i4kJHp8icjgOWB7QK2JK5EJEDE3xq6l85/4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510606; c=relaxed/simple;
	bh=WYWyzujQSKFIzD6IKAkiaGniOmyAmFCW6ClBYD6YShE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID; b=QIp3cSq7A8UDwOQka/8puuA1GJp5D9ugqsTl8fT2ogiX18s9c9zH6eYnO7NE/KQv+keJ6Nn/dnqq/Go0OatGL6ntVZhs9/MavcRGDeXi6Z3+G7dpWPvr340LijL6A97Ukjt0jV2ghSTjyVThKRpRctqeyqVe1jfLlRh6q/aX1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=SbZgm6Xa; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240117161622128e29d8dc56e1b6ff
        for <netdev@vger.kernel.org>;
        Wed, 17 Jan 2024 17:16:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YA9kxXyTpKbUvAn5fk/7icCgdnpCMYJTim3PliscYAY=;
 b=SbZgm6XaDYngAg9dwufQISnkeojje0ki1FWT3za0KTqSUUw68s4j5eqlJw7gDXjhfAQpbj
 kLyM3Ym6857simGsmM5aRYrIVRXySxvpNVeknHl8A4GV4YaHrqqmlu1a3UackqDaThmBRvp/
 BjY0hasNxsfkZjokV3McFCs8r4xD0=;
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
Subject: [PATCH v2 6/8] net: ti: icssg-ethtool: Adjust channel count for SR1.0
Date: Wed, 17 Jan 2024 16:15:00 +0000
Message-ID: <20240117161602.153233-7-diogo.ivo@siemens.com>
In-Reply-To: <20240117161602.153233-1-diogo.ivo@siemens.com>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
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


