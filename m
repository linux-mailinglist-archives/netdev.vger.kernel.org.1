Return-Path: <netdev+bounces-223036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF9CB57A00
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805E11888C9C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D23054EF;
	Mon, 15 Sep 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hp32/q8O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A28305E24
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938225; cv=none; b=ta8BHrNfH3B7rpa7Siv+rrc493PGR/6iLZK3vgL3kV0PjVBNneDp1IPT99XgQv6q/gO7jRCF+nizMh02tNPKQmltYcClPd1i92TnordurenYFQOJ4S+cCnt8Jp1dnYAZAktBhD5F8Wr1Q8uTT1sjgD+ulNXbO1l3oUOwYhVWrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938225; c=relaxed/simple;
	bh=4gYGz8FOI/3cQIhfzCfqFVs938meQzpWpNAO1LH11sA=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=SL9FVfGsLBPIRpLfGkNJW775Q436Ui0ifm7/y75p1Kp3DlZj1ChiYOEGXdzu6X4EMC1a8PbpUmXP7LZ/9QQkbnqe4+9VLybT9lu6Aw1uRNW16IcElmfWbnOONfsVtvH8cgnYDmDyd0soU7yju4v1FwvCxtckxHQMm+kA0UklrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Hp32/q8O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sQx5saqZIaEHifjngqi/kxmKHGd9S+alLpY+t/N6rUE=; b=Hp32/q8OXogCKNkDXSY5LKP3iN
	vdtpxGQjhZdUcwQ5VxEDkX5n4bFmcaSk+sZb9I8Zpq5f9wWsz9MXUjzTnodEwiepxNhXP5YLyZ5fI
	O6pnXalL1U0Zb8LKk+XXZfPX35RteYBP+A57FtkZcmBhiFCjIkYHHC9cWpVpYmJJ/AHYzb3AY6xI5
	qDkM3jZMTD1F2IARB4Qmq73jM0zrR9beMA9vymMXOo/34Mnyh9bCXzkmR0DGbLKkHgvbWWQSAOvq0
	V4dl/Ur/Rlb0q5yAOIayVH+DGq45bZd9ZBUCiKk83pJxBH3u5L5ZB4OF/j7gM1zpjx02NwR+C4ivA
	6fGjYF+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56066 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy82E-000000008Tf-46VX;
	Mon, 15 Sep 2025 13:10:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy82E-00000005Sll-0SSy;
	Mon, 15 Sep 2025 13:10:18 +0100
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: mvpp2: add support for hardware timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uy82E-00000005Sll-0SSy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 13:10:18 +0100

Add support for hardware timestamps in (e.g.) the PHY by calling
skb_tx_timestamp() as close as reasonably possible to the point that
the hardware is instructed to send the queued packets.

As this also introduces software timestamping support, report those
capabilities via the .get_ts_info() method.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 35d1184458fd..ab0c99aa9f9a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4439,6 +4439,8 @@ static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 		txq_pcpu->count += frags;
 		aggr_txq->count += frags;
 
+		skb_tx_timestamp(skb);
+
 		/* Enable transmit */
 		wmb();
 		mvpp2_aggr_txq_pend_desc_add(port, frags);
@@ -5252,14 +5254,14 @@ static int mvpp2_ethtool_get_ts_info(struct net_device *dev,
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 
+	ethtool_op_get_ts_info(dev, info);
 	if (!port->hwtstamp)
-		return -EOPNOTSUPP;
+		return 0;
 
 	info->phc_index = mvpp22_tai_ptp_clock_index(port->priv->tai);
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_TX_HARDWARE |
-				SOF_TIMESTAMPING_RX_HARDWARE |
-				SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			 BIT(HWTSTAMP_TX_ON);
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
-- 
2.47.3


