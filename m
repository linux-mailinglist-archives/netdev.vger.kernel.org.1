Return-Path: <netdev+bounces-33907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD27A0989
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CD2B20C46
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BCC22EE4;
	Thu, 14 Sep 2023 15:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733010A1E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:35:53 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C21FD2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nMutxIrHlhXRAUV+OH7tmc0TFKN6ouT1rlfPfWqZ7O4=; b=v2khi2gA/qIUmdSZ5H9DVZlzrr
	vNvcEei20PirUz1b3sZGCMvCMxzt8y5HQNX62wjOyVhoJ9BIiiYo07J/1QXsU9RgNH53eRWI4U7fc
	p1N7emibR5eKdeklX+6aAfQLRtEq6t8tdl+V3shXEh6QSvnLdQIppAzeYRyeyFaScWRTOKL1nvgPj
	wGFOyp5miqe1/YAvqUVSKVG3zpeYfIvr+sqESoKMEtGfpCj9ZfpoCOAihKNgJThRGiYzKMpZ7AmBa
	CvQeSNhLeDgHWtNx5LM2TjdorSmFzz7qJ2OiibpOv2Uoj7Tbl7osN/SmUdEacVWDwT9C1uMrd1YxY
	7qEETXKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39450 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgoNZ-0004WJ-0g;
	Thu, 14 Sep 2023 16:35:41 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgoNZ-007a4I-W1; Thu, 14 Sep 2023 16:35:42 +0100
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
Subject: [PATCH net-next 3/7] net: phy: move call to start aneg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgoNZ-007a4I-W1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 16:35:41 +0100

Move the call to start auto-negotiation inside the lock in the PHYLIB
state machine, calling the locked variant _phy_start_aneg(). This
avoids unnecessarily releasing and re-acquiring the lock.

Tested-by: Jijie Shao <shaojijie@huawei.com>
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


