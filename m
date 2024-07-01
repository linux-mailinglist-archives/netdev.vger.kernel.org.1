Return-Path: <netdev+bounces-108048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF891DAAF
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A5C2842E3
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9384A32;
	Mon,  1 Jul 2024 08:53:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36C839FE
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824033; cv=none; b=a6a2iQ0ud2PkHgT3aJlt2V7mWuRxFSZ+Robq0EzNTSatpD6togPArWqVpOJPZQRF2lMucyq2n8ctdDuie9F7+Jlg//KPQEVez18yGvEsh3524EKleS6m8ZNcX+4OWY/QFKg/MFrYq7UUrBKyntKHdJEzam3kOHl9/o1oojO/peA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824033; c=relaxed/simple;
	bh=yJv2lcMEVjKb92g/50GWfPdl0XxhueWIqPtDJJ/xLG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPAX7SsFEw2fUk6Kz26Sc4CPDFDa4ragtgneIisWCepxuX1ST0pymWtpPjnhnEiEZo3cCNEZkCe/iPQ3NPKvGEB6EhtanSc+IfQLNlwYUbejP1hdmePbJCpTDkARptxziN7if5Q0ryRI49b+/GpLpsV6GmLbE1EWrHsaEQwWVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnB-0006bD-91; Mon, 01 Jul 2024 10:53:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-006Kdo-JL; Mon, 01 Jul 2024 10:53:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-00ClWE-1i;
	Mon, 01 Jul 2024 10:53:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 2/3] net: dsa: microchip: lan937x: disable in-band status support for RGMII interfaces
Date: Mon,  1 Jul 2024 10:53:42 +0200
Message-Id: <20240701085343.3042567-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701085343.3042567-1-o.rempel@pengutronix.de>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
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

From: Lucas Stach <l.stach@pengutronix.de>

This driver do not support in-band mode and in case of CPU<->Switch
link, this mode is not working any way. So, disable it otherwise ingress
path of the switch MAC will stay disabled.

Note: lan9372 manual do not document 0xN301 BIT(2) for the RGMII mode
and recommend[1] to disable in-band link status update for the RGMII RX
path by clearing 0xN302 BIT(0). But, 0xN301 BIT(2) seems to work too, so
keep it unified with other KSZ switches.

[1] https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- use ksz_set_xmii() instead of LAN937X specific code
---
 drivers/net/dsa/microchip/ksz_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index baa1eeb9a1b04..b074b4bb06296 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3116,7 +3116,8 @@ static void ksz_set_xmii(struct ksz_device *dev, int port,
 		/* On KSZ9893, disable RGMII in-band status support */
 		if (dev->chip_id == KSZ9893_CHIP_ID ||
 		    dev->chip_id == KSZ8563_CHIP_ID ||
-		    dev->chip_id == KSZ9563_CHIP_ID)
+		    dev->chip_id == KSZ9563_CHIP_ID ||
+		    is_lan937x(dev))
 			data8 &= ~P_MII_MAC_MODE;
 		break;
 	default:
-- 
2.39.2


