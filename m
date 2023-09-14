Return-Path: <netdev+bounces-33911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90F7A0992
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62783281661
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580A262A9;
	Thu, 14 Sep 2023 15:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967310A1E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:36:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9005A99
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w6DYQ4Tr/hgf6iH5FvGhSf7jS+ZW/b324HPwDoHeoag=; b=HL7BXe8LpTm7U34UIO2LEQ3g/M
	kBqS9QTvpmrzl8RsfppNkq1/5NXYDVfTwhLYxD/Z+TC/M3hjQM9ifAMr5jY7Cvs538d+yXXtLbftI
	XCbVekB5p/LkMQy1vFJWLUDymzcP89dhdiuaQ/ZPC42UeUneMPrn9JjKDtGHLplUtdczoMRo55ZhN
	gkKpsgNGzJOJtp/kuN/7XRbnRHuxdof7bF7wavXrh3ugCueByZsPNTR6QcwA433k89B8YX00b75ER
	6DoZ2kKHY36ERBqtbAwUXpU169dT1KEfO6ociZLEGggDtupQ5bdF0Xcd49TR+Q2A1v5oD2zoJxYBC
	GoOZ/IGg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47394 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgoNt-0004Xc-2V;
	Thu, 14 Sep 2023 16:36:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgoNu-007a4g-Ha; Thu, 14 Sep 2023 16:36:02 +0100
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
Subject: [PATCH net-next 7/7] net: phy: convert phy_stop() to use split state
 machine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgoNu-007a4g-Ha@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 16:36:02 +0100

Convert phy_stop() to use the new locked-section and unlocked-section
parts of the PHY state machine.

Tested-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d78c2cc003ce..93a8676dd8d8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1467,6 +1467,7 @@ void phy_state_machine(struct work_struct *work)
 void phy_stop(struct phy_device *phydev)
 {
 	struct net_device *dev = phydev->attached_dev;
+	enum phy_state_work state_work;
 	enum phy_state old_state;
 
 	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
@@ -1490,9 +1491,10 @@ void phy_stop(struct phy_device *phydev)
 	phydev->state = PHY_HALTED;
 	phy_process_state_change(phydev, old_state);
 
+	state_work = _phy_state_machine(phydev);
 	mutex_unlock(&phydev->lock);
 
-	phy_state_machine(&phydev->state_queue.work);
+	_phy_state_machine_post_work(phydev, state_work);
 	phy_stop_machine(phydev);
 
 	/* Cannot call flush_scheduled_work() here as desired because
-- 
2.30.2


