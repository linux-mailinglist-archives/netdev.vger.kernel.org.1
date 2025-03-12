Return-Path: <netdev+bounces-174340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7BA5E55E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C381897BAF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A291EE7C6;
	Wed, 12 Mar 2025 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="TVtfaYQ4"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC815CB8
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811426; cv=none; b=Bq6ZWU3C1KKYGV6F/esMtph3JzgefN+xZZi735mf03NbyG2VuH2KXokePR0JcFuEthNcuMUgP80iH4skJMIb7ooB35KkdWTOyRY8zRLwxuzugBKh5AvVSsttVKENFG8T4lZLcj8GVLT9b+ruNV31gOVVixMfOGGsGcdWi47g8jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811426; c=relaxed/simple;
	bh=4ogX7RFdvu4TTo9qCrdhqjjFbPbdP6vivM0+8oH7yUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X46pt6rmtf1xACG+yCDr1KHZVFnYrtwwERD1qon3qEMf/QMjs+4RmD+nxScfWz90i1gmfp38rwHG+pGm1I9UVZk7t5kQAZGg2FaUJ7bPCDDqvPKtl5K44jSNALLfytkSiFSlPcPxGufrqJCO1Uj2gDEPZv6PHktoE+hj4AB5n3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=TVtfaYQ4; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O07meAWtc4kVfQwq8D1jUyN4qCDpemrqEsL48GLM6FI=; b=TVtfaYQ4zxqtPDzzLHgKVO22Pl
	G4Id6A/PyTXuznNYTvvkFSFq88CNgQmp+Y5Jw6rifGTYvTE9czWbr6kPxwSHsFhi6Ay0h9Rz43Td4
	O/q3GtcOcRAEesMgfVJoUCwYb2d/t2arj3YOU7NqDV/HRHPlDH7Cqepna+MXqALCmZYo=;
Received: from 80-121-79-4.adsl.highway.telekom.at ([80.121.79.4] helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tsSia-000000006Ue-0yz0;
	Wed, 12 Mar 2025 21:30:20 +0100
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
Subject: [PATCH net-next v10 5/5] tsnep: Select speed for loopback
Date: Wed, 12 Mar 2025 21:30:10 +0100
Message-Id: <20250312203010.47429-6-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312203010.47429-1-gerhard@engleder-embedded.com>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 48b279fb73ac..61a23413b577 100644
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


