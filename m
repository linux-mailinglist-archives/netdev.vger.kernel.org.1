Return-Path: <netdev+bounces-162214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B849A26355
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EF218837A9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088120AF96;
	Mon,  3 Feb 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="EZApNg5a"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB31D54E2
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609898; cv=none; b=F8YvdO5Tq7EBfhiztGzWBmuxPn/iVgPcSBUK4B0s6dZIolWiO7lrSYeZSn6nEmFvtDsrmwk84FZTuIB4vvewvYH9ecDPG8eJxiv+cHwK9m6JkEmhQraFOxH36L1ai4Xz0cdTFZ+u1RxbQ0oTA1lqttLZVaReIECnO1jfWneXaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609898; c=relaxed/simple;
	bh=3o17YmOzA7WR7Cr0v92ZJBUQStTL8kr2ScupHii+TQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPrAUl4yMQlQsXGWnfimrhoDTxQgDeWnB3ZHhSDfdUiyUiFj3eROTozBnJXyZpkQekYbJbG8cAL2tkcrMFZyCqEUwcBaimlQENw63AxNuscjJqRXqwQq5rWV3/v/8qTq+Bc/DPl+YR3eD1n/f3kWFZPPQqq0p23xBykJ8UTbFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=EZApNg5a; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ze69fUJSKANAoIvDAXRHBxnEpe6Ys/LNFmN7SGuZ7B8=; b=EZApNg5aXdMgFCPceWizVe3PH4
	/P8HNu+x7WByBtejHRddIy10YMNw+Uv3PF/lkDWi8tdIO6SATUqPdh5ADDoH09ngusDkLAuH4r1L4
	6f48vxs567k2mrt85lJJCd9cGawIiR6AZHNwfiuTHVT1gnWQC5PVbheD+hYusk3xs3xI=;
Received: from 88-117-60-28.adsl.highway.telekom.at ([88.117.60.28] helo=hornet.engleder.at)
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tf1r3-000000004RY-0JYU;
	Mon, 03 Feb 2025 20:11:33 +0100
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
Subject: [PATCH net-next v4 5/7] tsnep: Select speed for loopback
Date: Mon,  3 Feb 2025 20:10:55 +0100
Message-Id: <20250203191057.46351-6-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203191057.46351-1-gerhard@engleder-embedded.com>
References: <20250203191057.46351-1-gerhard@engleder-embedded.com>
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


