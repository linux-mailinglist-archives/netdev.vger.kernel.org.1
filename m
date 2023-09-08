Return-Path: <netdev+bounces-32558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC6798660
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EC11C20C1D
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C554C9D;
	Fri,  8 Sep 2023 11:21:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8284C7D
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:15 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74991BF6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YK6ztRqh3NayYUC/LdR0oXCI6nVH9KznqHgmWUMtyiw=; b=GWSjlTIGRUMmgOiAuxnJCUXVbu
	mDSaYOMhOLvjpHkxu3aMqQIwX35sIJb5IxHfv+lezUBhAEwCGj5aIezJKAv4t8dxh69k+TViIqoFX
	SYRe/Fdtc5Q1u+Wlr4jAPcEVvNxR4YuVz0ik6lMIAQk/Gt8EXRR/Q7cA02BIrTuzXmiYQ6ME8pdbC
	c9cjzg6AZuWhci+SV8cbbhp+/Xd6fPxmKfguKFgiEg/4cN1sfsGAPmtKiyke002kEfBu5Z1u1vAAn
	A53T2oiGab2tnkT7ftGsVH8dVsSzvLnzZO094Cmm+QxSPNeSAfCh6LzryhEsB2rInkxnA5uItWW98
	gl5DjZHg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58830 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZXd-0004sW-2W;
	Fri, 08 Sep 2023 12:20:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZXe-007G4J-CU; Fri, 08 Sep 2023 12:20:50 +0100
In-Reply-To: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
References: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jijie Shao <shaojijie@huawei.com>,
	 shaojijie@huawei.com,
	 shenjian15@huawei.com,
	 liuyonglong@huawei.com,
	 wangjie125@huawei.com,
	 chenhao418@huawei.com,
	 lanhao@huawei.com,
	 wangpeiyang1@huawei.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 2/7] net: phy: call phy_error_precise() while
 holding the lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZXe-007G4J-CU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:20:50 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the locking out of phy_error_precise() and to its only call site,
merging with the locked region that has already been taken.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 1e5218935eb3..990d387b31bd 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1231,9 +1231,7 @@ static void phy_error_precise(struct phy_device *phydev,
 			      const void *func, int err)
 {
 	WARN(1, "%pS: returned: %d\n", func, err);
-	mutex_lock(&phydev->lock);
 	phy_process_error(phydev);
-	mutex_unlock(&phydev->lock);
 }
 
 /**
@@ -1503,10 +1501,10 @@ void phy_state_machine(struct work_struct *work)
 	if (err == -ENODEV)
 		return;
 
+	mutex_lock(&phydev->lock);
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
 
-	mutex_lock(&phydev->lock);
 	phy_process_state_change(phydev, old_state);
 
 	/* Only re-schedule a PHY state machine change if we are polling the
-- 
2.30.2


