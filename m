Return-Path: <netdev+bounces-34626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47E7A4E40
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77691C20B8F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF221377;
	Mon, 18 Sep 2023 16:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01161D686
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:07:55 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242446AA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2D0A941kWzO8SqVobC80GHz9ouHUnRp6nlBz+6KUEAE=; b=uAYaHFv4MJ98GdYW7lwjZ4QGuK
	PmzMQyeV7v+L97ji2M7SU79WNWxoOA9R42P0rpV0B4J/X2ZZSEs0gmpomNp/zQVQBaKJKbMlqqXO5
	te5sIWrh4oFzaQV0TspeAxsf15gOw8tm64e9cKv6zBB6h8zgDYTio6OHAMg39ahWWaRaUbYv5fw+t
	5RgVH29RgqokN7/iLeSXxWVWPMkortzZHg3VQg4pox60M1btz9gJp2j9iJWSD1RI92QBlyvE/9Bu1
	5+ZSMNRn1vvtCyCjycn0phzUQ32h53CdBTkm38waKD4QnZliiVI+romXBNYFZLZuW6reYqgFKlMMI
	x0sW4xDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qiDxN-0000HB-0R;
	Mon, 18 Sep 2023 14:06:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qiDxK-0000Ud-MQ; Mon, 18 Sep 2023 14:06:26 +0100
Date: Mon, 18 Sep 2023 14:06:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jijie Shao <shaojijie@huawei.com>,
	lanhao@huawei.com, liuyonglong@huawei.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
	wangjie125@huawei.com, wangpeiyang1@huawei.com
Subject: Re: [PATCH net-next 1/7] net: phy: always call
 phy_process_state_change() under lock
Message-ID: <ZQhLUlw452Ewu7yi@shell.armlinux.org.uk>
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
 <E1qgoNP-007a46-Mj@rmk-PC.armlinux.org.uk>
 <CGME20230918123304eucas1p2b628f00ed8df536372f1f2b445706021@eucas1p2.samsung.com>
 <42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ef8c8f-2fc0-a210-969b-7b0d648d8226@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 02:33:04PM +0200, Marek Szyprowski wrote:
> Hi Russell,
> 
> On 14.09.2023 17:35, Russell King (Oracle) wrote:
> > phy_stop() calls phy_process_state_change() while holding the phydev
> > lock, so also arrange for phy_state_machine() to do the same, so that
> > this function is called with consistent locking.
> >
> > Tested-by: Jijie Shao <shaojijie@huawei.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> This change, merged to linux-next as commit 8da77df649c4 ("net: phy: 
> always call phy_process_state_change() under lock") introduces the 
> following deadlock with ASIX AX8817X USB driver:

Yay, latent bug found...

I guess this is asix_ax88772a_link_change_notify() which is causing
the problem, and yes, that phy_start_aneg() needs to be the unlocked
version (which we'll have to export.)

This should fix it.

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
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

