Return-Path: <netdev+bounces-50819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DC7F73C5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69BFB213C7
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC124A09;
	Fri, 24 Nov 2023 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Se2eYYhU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A63BD43
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LJr1iSVWq8TqiWWdywO21vUU4QimKXa9rJRUwI/KOFk=; b=Se2eYYhUoBIqDomScbf0p59iUL
	IJMMcnsjRPbv49s8K9hdviW56u92GA1TCQKzhBnyOMdeAdxul7/Z+lvxmLA46slt4L35LOXj3O9Cv
	fH3Wn9KuDj8HxbyQDSWl4qe71AK23afKSTNw/+OWZqVkkx/eH7AB8mLDTNm/yqQNJn8ySa3gUpPRz
	Zx1jzQTiWmydfsM7KdD9uHx1uTZaFY85sif5IzKJvdWMOcEKRY+ardRvhntV+WTCUQfgOmFnradWs
	pQ43o5XJ8Ymx6yo0p1O2H7iX/Wmq9S5bW5YJsVZHScfBV2fq1IZajw3Sg/cse3tdYu0H0FIKbYOx/
	zUg60InA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36040 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VHi-0002sG-1h;
	Fri, 24 Nov 2023 12:27:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VHk-00DDLN-I7; Fri, 24 Nov 2023 12:27:52 +0000
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 01/10] net: phy: add possible interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r6VHk-00DDLN-I7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:27:52 +0000

Add a possible_interfaces member to struct phy_device to indicate which
interfaces a clause 45 PHY may switch between depending on the media.
This must be populated by the PHY driver by the time the .config_init()
method completes according to the PHYs host-side configuration.

For example, the Marvell 88x3310 PHY can switch between 10GBASE-R,
5GBASE-R, 2500BASE-X, and SGMII on the host side depending on the media
side speed, so all these interface modes are set in the
possible_interfaces member.

This allows phylib users (such as phylink) to know in advance which
interface modes to expect, which allows them to appropriately restrict
the advertised link modes according to the capabilities of other parts
of the link.

Tested-by: Luo Jie <quic_luoj@quicinc.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 2 ++
 include/linux/phy.h          | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 478126f6b5bc..400fb09d9cd6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1246,6 +1246,8 @@ int phy_init_hw(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	phy_interface_zero(phydev->possible_interfaces);
+
 	if (phydev->drv->config_init) {
 		ret = phydev->drv->config_init(phydev);
 		if (ret < 0)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..6e7ebcc50b85 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -605,6 +605,8 @@ struct macsec_ops;
  * @irq_rerun: Flag indicating interrupts occurred while PHY was suspended,
  *             requiring a rerun of the interrupt handler after resume
  * @interface: enum phy_interface_t value
+ * @possible_interfaces: bitmap if interface modes that the attached PHY
+ *			 will switch between depending on media speed.
  * @skb: Netlink message for cable diagnostics
  * @nest: Netlink nest used for cable diagnostics
  * @ehdr: nNtlink header for cable diagnostics
@@ -674,6 +676,7 @@ struct phy_device {
 	u32 dev_flags;
 
 	phy_interface_t interface;
+	DECLARE_PHY_INTERFACE_MASK(possible_interfaces);
 
 	/*
 	 * forced speed & duplex (no autoneg)
-- 
2.30.2


