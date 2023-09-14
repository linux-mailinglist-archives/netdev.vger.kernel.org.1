Return-Path: <netdev+bounces-33906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9077A0981
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CF91F243FB
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF14B2137E;
	Thu, 14 Sep 2023 15:35:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1C2111C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:35:45 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD701FCC
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nMT3CQ4SM6FC47ttg/I22XHquugVOypHrE3B/XErAlI=; b=LMMoa2/qxe27BXEyewUvpQ0qUZ
	LwrJ0gsMaQ65DO6cUWd/VbcGupVsJskqLAt6Jvban7TP4dtSOy/L7j0YA1cR9anUiF11gTikaT3L0
	qkyFPOu42zrGjJQyRjXH+Gfjswj57GWiMbe7Q/QgaRmtDphfO/CbgPVNtZbGJD9PqrLWAmaUZmdoc
	+ZLo2e3/CXZNoTuznTM61w6bfpmX526fAwfkJOQmLUvQJI7MqajnJ2W2SwXgGGQY5OxwmN7eP68K3
	vx0XWtkA6njrC6bkv5675QAAZmcq8ow5CG65ianEhyxBoDp++kXMeWD5lebtUYCL7Eaqxl9t96Hrv
	WDXQkbsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39434 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgoNU-0004W1-0G;
	Thu, 14 Sep 2023 16:35:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgoNU-007a4C-RJ; Thu, 14 Sep 2023 16:35:36 +0100
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
Subject: [PATCH net-next 2/7] net: phy: call phy_error_precise() while holding
 the lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgoNU-007a4C-RJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 16:35:36 +0100

Move the locking out of phy_error_precise() and to its only call site,
merging with the locked region that has already been taken.

Tested-by: Jijie Shao <shaojijie@huawei.com>
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


