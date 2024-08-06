Return-Path: <netdev+bounces-115979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F27948A78
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFC1F2335E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C01BDA9A;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A513C909
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930468; cv=none; b=jwLXmFQxQBsArr9h5aiLn6VO9xoaPvssrH6+GnQ23xz0opXP7t/m/ly/bx78RUzwcIE5dzi2DrR46fDOHnQsNfbsDOWBp3+uOhx1klsvQjAdzqXFre1RzkhVmWTFZNEJQCKGZR6fbeC+tWvl+FQMnLuxrUSqT0UVtTPn7oRxmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930468; c=relaxed/simple;
	bh=oTenZEw0y91NOffRMByZkFbTkTce9t97v+R+3ORoKrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsaKwOeQs+kILlPMoxUJq8C6lcTaLEG+Mo5S4fi4DXHq6r7nhsYFnsEmFo6Cns7fNyflNhSzUJ7SCG2xuLo8ctQtFmUy0d+P4FGFDgxWiIknZamXrYC97d2Utrv2qkqusymG/E5Na4YaK0akFFkzvxb2ivY9s32VGk1CYg6NROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv1-00049I-If
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEux-004twG-Hn
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:39 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3719C317A23
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:47:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5300C3179A0;
	Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 81415b32;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/20] can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops
Date: Tue,  6 Aug 2024 09:42:11 +0200
Message-ID: <20240806074731.1905378-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Now when we only got one set of ethtool_ops and netdev_ops, remove the
"hwts" suffix from the struct variables
kvaser_usb_{ethtool,netdev}_ops_hwts.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-16-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 4b6c23121b5d..35b4132b0639 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,7 +753,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
+static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
@@ -761,7 +761,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
+static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
@@ -847,8 +847,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	netdev->flags |= IFF_ECHO;
 
-	netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
-	netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
+	netdev->netdev_ops = &kvaser_usb_netdev_ops;
+	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.43.0



