Return-Path: <netdev+bounces-32557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284979865F
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A263F28196C
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D034C6E;
	Fri,  8 Sep 2023 11:21:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CA4C6D
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:15 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F81BFA
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hE/rKmpHmo2vicBj4jxfZULGMGoGG+uUDivYD6dMMjk=; b=RIhNq+aUE/xcuEDrnfwfZQ/+8F
	Mq/zn333whfSNFhxEteJbXCj5JHq0D+JpNEvcl4JA4yuRB+jXeJ3R/wLUuXeJ57CGsckqu3m5xJUZ
	dhTTmf4MZigFjhlwHvalrAxGg52kGfhqEx44oeYsTy2GePhPzIXnefrC5UUr1S1qYclsTppqCJjKA
	FDjTu28YkMOWtQWzCIUcy0Me+kkBCWXG2DmLXZHj1QdHnhD/YYTeyXfBKPQNnCatxf0DIHlJ8ahSc
	C9Yw8MTY/LsHmxJn7wlCx7iysmhP1KKxO8j2ReeOJ/dYXrgJ+GjsyTsS1hbXHgcgJhirbo3+ifZir
	tXagTWeQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58822 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZXY-0004sL-2B;
	Fri, 08 Sep 2023 12:20:44 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZXZ-007G4D-7w; Fri, 08 Sep 2023 12:20:45 +0100
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
Subject: [PATCH RFC net-next 1/7] net: phy: always call
 phy_process_state_change() under lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZXZ-007G4D-7w@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:20:45 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

phy_stop() calls phy_process_state_change() while holding the phydev
lock, so also arrange for phy_state_machine() to do the same, so that
this function is called with consistent locking.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index df54c137c5f5..1e5218935eb3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1506,6 +1506,7 @@ void phy_state_machine(struct work_struct *work)
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
 
+	mutex_lock(&phydev->lock);
 	phy_process_state_change(phydev, old_state);
 
 	/* Only re-schedule a PHY state machine change if we are polling the
@@ -1516,7 +1517,6 @@ void phy_state_machine(struct work_struct *work)
 	 * state machine would be pointless and possibly error prone when
 	 * called from phy_disconnect() synchronously.
 	 */
-	mutex_lock(&phydev->lock);
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
 		phy_queue_state_machine(phydev, PHY_STATE_TIME);
 	mutex_unlock(&phydev->lock);
-- 
2.30.2


