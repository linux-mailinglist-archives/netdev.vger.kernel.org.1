Return-Path: <netdev+bounces-34625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAF37A4E37
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782FD282A83
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10521113;
	Mon, 18 Sep 2023 16:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584201D686
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:07:41 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B0B44B1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wunBUt2qozbDpz79Ng/612G05Tv1L8aX5r/SN9nGL6A=; b=J3DRuO81WE1Y7rNMIxXoc/PqkL
	SAdF1ygHXRVMZZpCiTzV9oq1kIgZnEafE2AkfITf+vtngH3jp/jWAXREcmq9ml7v/eqvzyuy5I3w1
	vzuMCm/iolXach38kgUAipX58/8uxj9rQQD9hdvExTMNFGauRgwfz4yISx0zHzwrGIzTaYtnRcdXg
	C02TQTlfx26JG5oyMvwSqq3tRBL2alQQ4NyiMYJnNthgYL/5s4S984hkAtkLDQuaE+TPEW75QGw81
	aciEMDvMJuIDReSyzKiniH9ckG/k1zpJF3Pt102Wi91XVcQdGbaIU6zs37vP/yssA0u5XuzNIXbt+
	DawW487w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55892 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qiEFr-0000Kj-2d;
	Mon, 18 Sep 2023 14:25:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qiEFs-007g7b-Lq; Mon, 18 Sep 2023 14:25:36 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phy: fix regression with AX88772A PHY driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 18 Sep 2023 14:25:36 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Marek reports that a deadlock occurs with the AX88772A PHY used on the
ASIX USB network driver:

asix 1-1.4:1.0 (unnamed net_device) (uninitialized): PHY [usb-001:003:10] driver [Asix Electronics AX88772A] (irq=POLL)
Asix Electronics AX88772A usb-001:003:10: attached PHY driver(mii_bus:phy_addr=usb-001:003:10, irq=POLL)
asix 1-1.4:1.0 eth0: register 'asix' at usb-12110000.usb-1.4, ASIX AX88772 USB 2.0 Ethernet, a2:99:b6:cd:11:eb
asix 1-1.4:1.0 eth0: configuring for phy/internal link mode

============================================
WARNING: possible recursive locking detected
6.6.0-rc1-00239-g8da77df649c4-dirty #13949 Not tainted
--------------------------------------------
kworker/3:3/71 is trying to acquire lock:
c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_start_aneg+0x1c/0x38

but task is already holding lock:
c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x100/0x2b8

This is because we now consistently call phy_process_state_change()
while holding phydev->lock, but the AX88772A PHY driver then goes on
to call phy_start_aneg() which tries to grab the same lock - causing
deadlock.

Fix this by exporting the unlocked version, and use this in the PHY
driver instead.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: ef113a60d0a9 ("net: phy: call phy_error_precise() while holding the lock")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Reviewing the other PHY drivers, no others appear impacted, just this
one.

 drivers/net/phy/ax88796b.c | 2 +-
 drivers/net/phy/phy.c      | 3 ++-
 include/linux/phy.h        | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
index 0f1e617a26c9..eb74a8cf8df1 100644
--- a/drivers/net/phy/ax88796b.c
+++ b/drivers/net/phy/ax88796b.c
@@ -90,7 +90,7 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
 	 */
 	if (phydev->state == PHY_NOLINK) {
 		phy_init_hw(phydev);
-		phy_start_aneg(phydev);
+		_phy_start_aneg(phydev);
 	}
 }
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 93a8676dd8d8..a5fa077650e8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -981,7 +981,7 @@ static int phy_check_link_status(struct phy_device *phydev)
  *   If the PHYCONTROL Layer is operating, we change the state to
  *   reflect the beginning of Auto-negotiation or forcing.
  */
-static int _phy_start_aneg(struct phy_device *phydev)
+int _phy_start_aneg(struct phy_device *phydev)
 {
 	int err;
 
@@ -1002,6 +1002,7 @@ static int _phy_start_aneg(struct phy_device *phydev)
 
 	return err;
 }
+EXPORT_SYMBOL(_phy_start_aneg);
 
 /**
  * phy_start_aneg - start auto-negotiation for this PHY device
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1351b802ffcf..3cc52826f18e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1736,6 +1736,7 @@ void phy_detach(struct phy_device *phydev);
 void phy_start(struct phy_device *phydev);
 void phy_stop(struct phy_device *phydev);
 int phy_config_aneg(struct phy_device *phydev);
+int _phy_start_aneg(struct phy_device *phydev);
 int phy_start_aneg(struct phy_device *phydev);
 int phy_aneg_done(struct phy_device *phydev);
 int phy_speed_down(struct phy_device *phydev, bool sync);
-- 
2.30.2


