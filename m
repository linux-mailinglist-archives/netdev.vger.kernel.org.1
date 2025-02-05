Return-Path: <netdev+bounces-163237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E0A29A50
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAD83A7002
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAD204F66;
	Wed,  5 Feb 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="DtyLteaN"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D751FF1B3
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784514; cv=none; b=STdTgPtxQ3Ra9+8TzV2neb/V4WV3zvSYxQsoRnZeJHEfgx3sJT43LJo+ff4gGK7HEzWkzD0AMrTP/6aXidCsd0ScjNR4a/oLd3BDROV99rdqTjAweMHwBitAf/AZ+FxJB1PqzSOyK5SlTVGbqofQeinYqD9kdaGR8MSXdLuyoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784514; c=relaxed/simple;
	bh=3o17YmOzA7WR7Cr0v92ZJBUQStTL8kr2ScupHii+TQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XD53ppQpCvWwcvqzAftsQ6omAHFmFyzLHp2zpjCgqcSJfLRjAdqAkmSrZ+cGZIsKA5JdQgXwjnTAm9zxsKLxP7XQn9RXIfZXt5l50Pit7eg2+I+2jLDAM5OHUrQZW95YiiPbpWgmpospI7f8phOhD8LxvO+bqYbp5S2j6Pgy6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=DtyLteaN; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ze69fUJSKANAoIvDAXRHBxnEpe6Ys/LNFmN7SGuZ7B8=; b=DtyLteaNjUHBis1MXh0D7ww68T
	9wHiksxuV90jeaFiwhC0oMaG4w/0UtydQMlJETqe4PvZbZ+Q0RBG+1sPGdw7faA2NPHslEsk4Qpro
	dfsgUmyrXyZtNl8MTYrAdiPGmukuApPHUueXc5D7d1XcHuQgjanFKExpgmuys0nKI8MU=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfklF-0000000017b-10aM;
	Wed, 05 Feb 2025 20:08:34 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v5 5/7] tsnep: Select speed for loopback
Date: Wed,  5 Feb 2025 20:08:21 +0100
Message-Id: <20250205190823.23528-6-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205190823.23528-1-gerhard@engleder-embedded.com>
References: <20250205190823.23528-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Use 100 Mbps only if the PHY is configured to this speed. Otherwise use
always the maximum speed of 1000 Mbps.

Also remove explicit setting of carrier on and link mode after loopback.
This is not needed anymore, because phy_loopback() with selected speed
signals the link and the speed to the MAC.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index a16b12137edb..d77a5b423c4c 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -228,20 +228,19 @@ static void tsnep_phy_link_status_change(struct net_device *netdev)
 
 static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
 {
-	int retval;
-
-	retval = phy_loopback(adapter->phydev, enable, 0);
+	int speed;
 
-	/* PHY link state change is not signaled if loopback is enabled, it
-	 * would delay a working loopback anyway, let's ensure that loopback
-	 * is working immediately by setting link mode directly
-	 */
-	if (!retval && enable) {
-		netif_carrier_on(adapter->netdev);
-		tsnep_set_link_mode(adapter);
+	if (enable) {
+		if (adapter->phydev->autoneg == AUTONEG_DISABLE &&
+		    adapter->phydev->speed == SPEED_100)
+			speed = SPEED_100;
+		else
+			speed = SPEED_1000;
+	} else {
+		speed = 0;
 	}
 
-	return retval;
+	return phy_loopback(adapter->phydev, enable, speed);
 }
 
 static int tsnep_phy_open(struct tsnep_adapter *adapter)
-- 
2.39.5


