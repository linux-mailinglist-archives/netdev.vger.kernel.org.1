Return-Path: <netdev+bounces-32562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B9798666
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33642281A2B
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045584C77;
	Fri,  8 Sep 2023 11:21:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2E567F
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:35 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831B11B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WY+bgrVOm+y/PmPw8ddL21bvHH5Y6vOp3D2FYDnaxjo=; b=B6Y3lQM/B04eg1FwL7iWm0P/QC
	atFRq2DMH9EG17dAmT3jmzJu07/u+IKFvMLkVAfn1zXy7N8Z4VpZYgVgySXpPxuOyIUZRnPZU4tI0
	vh9zD+GkYXqJNjt2GjPAmlo9hefjPdBnpfQxTExW52i4rIjWPGLu0J4h6B4mkT80Ro7U5MEuzplT1
	5gUBiw+qdYIeKBbbuuK90ia1vcEZHJ9/TLE1wp5sKgwn3v+5jk4tAecLrMtvnNrDKQEnFnKc5TkvI
	rtl49KAF2Vj4B5KxgqnQzcn8o5psU3MCiBhWBRDA2a2xyMWBQdH4M/Q3e70s/O9rHSHImGN+sAg5F
	ZKRDsp6g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45748 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZY3-0004tu-1a;
	Fri, 08 Sep 2023 12:21:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZY4-007G4n-2Z; Fri, 08 Sep 2023 12:21:16 +0100
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
Subject: [PATCH RFC net-next 7/7] net: phy: convert phy_stop() to use split
 state machine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZY4-007G4n-2Z@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:21:16 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert phy_stop() to use the new locked-section and unlocked-section
parts of the PHY state machine.

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


