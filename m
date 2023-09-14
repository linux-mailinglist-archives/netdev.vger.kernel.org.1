Return-Path: <netdev+bounces-33908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9627A098A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7AEB20C78
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D0250F0;
	Thu, 14 Sep 2023 15:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADB10A1E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:35:59 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAC11FD0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t26CLbX1MWgAEwYjLRM8G7h4VbkzoB7fg+lDXEq42i8=; b=C1zzwQrSlVM0/ChEFQugLcZ/sc
	jkxWt+Wtr1yAnNG6nAYLWLs8C/pF4uHSitiLVHSmfZbrjkrYHlkLncnBGGtCQYMT+7QpphYpJ72Tr
	/XCAzCKBbUPgs/0gKnR1eu1yBop8rcZyVMXOMii9tDsX8jk/JduSS8aAlLDm7hJHEZB9bJhXR9HYl
	i433C2EYR5i6Aydj6UWdktUlziu6Joko46yajs+3xrxYJk2LcHJEgM9WslgYnIcBkEWZj9EER1arM
	JkE3R7LWUCdqKITxuESrPbIRFzyGaMsE+IPJOtV8YKRv0+u5lT/ksvXpHBXDtMPb+OstBC55fgSkg
	pR58gxeQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46322 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgoNe-0004Wc-18;
	Thu, 14 Sep 2023 16:35:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgoNf-007a4O-47; Thu, 14 Sep 2023 16:35:47 +0100
In-Reply-To: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Heiner Kallweit <hkallweit1@gmail.com>
Cc: chenhao418@huawei.com,
	 "David S. Miller" <davem@davemloft.net>,
	 Eric Dumazet <edumazet@google.com>,
	 Jakub Kicinski <kuba@kernel.org>,
	 Jijie Shao <shaojijie@huawei.com>,
	 lanhao@huawei.com,
	 liuyonglong@huawei.com,
	 netdev@vger.kernel.org,
	 Paolo Abeni <pabeni@redhat.com>,
	 shenjian15@huawei.com,
	 wangjie125@huawei.com,
	 wangpeiyang1@huawei.com
Subject: [PATCH net-next 4/7] net: phy: move phy_suspend() to end of
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
Message-Id: <E1qgoNf-007a4O-47@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 16:35:47 +0100

Move the call to phy_suspend() to the end of phy_state_machine() after
we release the lock so that we can combine the locked areas.
phy_suspend() can not be called while holding phydev->lock as it has
caused deadlocks in the past.

Tested-by: Jijie Shao <shaojijie@huawei.com>
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


