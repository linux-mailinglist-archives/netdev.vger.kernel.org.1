Return-Path: <netdev+bounces-32560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C7798664
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4904328199B
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A25386;
	Fri,  8 Sep 2023 11:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4505385
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:21 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9311B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RrKsgyMyOnilFqqcj3MrXwUCJ/Of0LEJNcP4LCorgHQ=; b=IpgXul0SySP6VJyOG3mptAFqoe
	nWQHoOLeLg/yWLvjh6/IPKWFxMJBHf7uiiXwnITWBAH2clCTu7Pm5pvqCqaLurT1/h7D27bXoWyWc
	6y4L9qrQPKrv1KbK6hST7Q1nnanane5EpdCkeXpQvC79XbYsuzQ9pVEI/N4xlURv5iLuBbGHRSWdH
	qGtgIIc480LrFgoYPFrCdoqU3jrspsCPUSSVYratUwOXqDrgyayj875Q9X7HeyQkJGGrQf/RybiCf
	1SqoTuBH65HQZ8/M9ZtD+N8QE4TXD1O7VyrQl2wi3aWUsDx6I4AZG7c6mDGoIVkattr5fEYgZg4OC
	NO5RigOw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60628 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZXi-0004sk-2v;
	Fri, 08 Sep 2023 12:20:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZXj-007G4P-Gt; Fri, 08 Sep 2023 12:20:55 +0100
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
Subject: [PATCH RFC net-next 3/7] net: phy: move call to start aneg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZXj-007G4P-Gt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:20:55 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move the call to start auto-negotiation inside the lock in the PHYLIB
state machine, calling the locked variant _phy_start_aneg(). This
avoids unnecessarily releasing and re-acquiring the lock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 990d387b31bd..5bb33af2a4cb 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1489,14 +1489,15 @@ void phy_state_machine(struct work_struct *work)
 		break;
 	}
 
+	if (needs_aneg) {
+		err = _phy_start_aneg(phydev);
+		func = &_phy_start_aneg;
+	}
+
 	mutex_unlock(&phydev->lock);
 
-	if (needs_aneg) {
-		err = phy_start_aneg(phydev);
-		func = &phy_start_aneg;
-	} else if (do_suspend) {
+	if (do_suspend)
 		phy_suspend(phydev);
-	}
 
 	if (err == -ENODEV)
 		return;
-- 
2.30.2


