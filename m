Return-Path: <netdev+bounces-32559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B97798662
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14FD1C20C32
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3B4C8E;
	Fri,  8 Sep 2023 11:21:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663C4428
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:18 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97F211B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Cq+dnT8Mi7UVDkZ7VwMUC8qD0fQGq0V6oKtLjz8J4Q=; b=Mo0nw98sIWCAozQSL0XZTYspV5
	SBI0tgLiwHXJZ5rbNSgmtHaihgM1Wbt5OcprquC6zfv00kVcx2d1X92ZQ51Z3qMlDFAzl0a0tNoBq
	5QUbwptQs0TXXXBEgRvwKKzIQkJmrkran/dUD2mVMHv/DwvDu7wp4FF3q46rTxueuegyhAOzVPuib
	w6wUNMJUQ0WyZclM35dd3FI/UuLgUkrvGlrFVTDuQxlVH7TIMXcKVx/ivDpgebZPRfVziNld22PQ2
	aVvdlP4hmDNAMxMly5oBmAT5EwH4joE13WmnQXOsHEtqxgqym9d9/fdyn5bBB/Nw5pJSWQJqtZz02
	nX6Y7sKA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60638 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZXo-0004sw-0C;
	Fri, 08 Sep 2023 12:21:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZXo-007G4V-LF; Fri, 08 Sep 2023 12:21:00 +0100
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
Subject: [PATCH RFC net-next 4/7] net: phy: move phy_suspend() to end of
 phy_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZXo-007G4V-LF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:21:00 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the call to phy_suspend() to the end of phy_state_machine() after
we release the lock so that we can combine the locked areas.
phy_suspend() can not be called while holding phydev->lock as it has
caused deadlocks in the past.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 5bb33af2a4cb..756326f38b14 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1494,15 +1494,11 @@ void phy_state_machine(struct work_struct *work)
 		func = &_phy_start_aneg;
 	}
 
-	mutex_unlock(&phydev->lock);
-
-	if (do_suspend)
-		phy_suspend(phydev);
-
-	if (err == -ENODEV)
+	if (err == -ENODEV) {
+		mutex_unlock(&phydev->lock);
 		return;
+	}
 
-	mutex_lock(&phydev->lock);
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
 
@@ -1519,6 +1515,9 @@ void phy_state_machine(struct work_struct *work)
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
 		phy_queue_state_machine(phydev, PHY_STATE_TIME);
 	mutex_unlock(&phydev->lock);
+
+	if (do_suspend)
+		phy_suspend(phydev);
 }
 
 /**
-- 
2.30.2


