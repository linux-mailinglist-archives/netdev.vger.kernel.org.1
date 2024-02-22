Return-Path: <netdev+bounces-73979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F885F85D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2237F1F2656E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8F12DD96;
	Thu, 22 Feb 2024 12:38:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3312DDA3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605538; cv=none; b=t3za1AJR0chaCi2gzTXLdVQ+5EE4VxgfqRDgyVSkT39lAOy+4ono3IsnPFBjwj+5Gq57bXlBwzCv2edqw8FzGhg8mkn0TxVBrsrgj+UmJaoopvmVSegLZpTKDqlBqhYswKv0NWZH4ndQeNOlRunt8oJ+45KeLFUBGMcZ++nEHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605538; c=relaxed/simple;
	bh=BgXSG/gCEdxQcMxhZfn7pF1ZUmFlN4Q+NRemkxs/KxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrS0qPUS5/IAbLFjOvGnFJ94yrUfH/CVje7nWDtxNqHQl2BmgA2BMmPy2YdTiX+i+KkRrR7M2IoCxIU0sjZQllXgUUnlG7rFpdbbJMBz2xsh5pyqRYmnQzntZK0QJcId7qBXWWMBKvu1xH3ZKU3HOEXz8NWPQgjeJq8c7lh7TuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rd8La-0004bQ-6E; Thu, 22 Feb 2024 13:38:42 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rd8LY-002EZ4-8G; Thu, 22 Feb 2024 13:38:40 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rd8LY-00Boin-0b;
	Thu, 22 Feb 2024 13:38:40 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 1/1] lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected
Date: Thu, 22 Feb 2024 13:38:38 +0100
Message-Id: <20240222123839.2816561-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Same as LAN7800, LAN7850 can be used without EEPROM. If EEPROM is not
present or not flashed, LAN7850 will fail to sync the speed detected by the PHY
with the MAC. In case link speed is 100Mbit, it will accidentally work,
otherwise no data can be transferred.

Better way would be to implement link_up callback, or set auto speed
configuration unconditionally. But this changes would be more intrusive.
So, for now, set it only if no EEPROM is found.

Fixes: e69647a19c87 ("lan78xx: Set ASD in MAC_CR when EEE is enabled.")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 106282612bc2..7d7e185d7fae 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3033,7 +3033,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
 
-	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
+	    dev->chipid == ID_REV_CHIP_ID_7850_) {
 		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
 		if (!ret && sig != EEPROM_INDICATOR) {
 			/* Implies there is no external eeprom. Set mac speed */
-- 
2.39.2


