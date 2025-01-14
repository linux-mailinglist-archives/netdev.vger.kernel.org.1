Return-Path: <netdev+bounces-158179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F4A10CB3
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70C51889C2B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C81CDFAC;
	Tue, 14 Jan 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sQyC6mG6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB005232459
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873479; cv=none; b=S4aHWeZhepyAIX9QvGDzsiV/PdWfbESxHneXVVj7BB3oqBJNnKGSju6LfYCuo7X1kYauQXVbWU8m57LKYiTT91KVtCKt8sSg+0qebhVnpF21XjhsPi6ThBpW/s68fJGzsPYpF3iZH7Mh4+t+o7JFWaskONXwKNAr5NAj16TU2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873479; c=relaxed/simple;
	bh=kxwJ6ZLf1F2kRoZrAiF1HSoEtcU5OHUSCywmpVYXh9M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Xk1pgFEm0D2e86oqazSejly1+iBwUH22Vn+HKXh6nNvzyYI4TC1fji+ZvPnTtxxXuK0usNdOGKOjS6+dCTnoPg09A7NguN/9t8AknqekCJKNbDwI6Cb5jgdI9yKEdNy7Kx9A5SliOhngPq0ZoLMueTaTxxWg8SdN5UL0ERvyQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sQyC6mG6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OaAYO4ab4fITs7juBW/FSfIp2nYrOC6gWB66JY5AddA=; b=sQyC6mG6GYkQpMQJCf3tH3J2qu
	0bmlYAeqFJV56qZFSx5sFae82oaTOpFYZBbJ+RKILWO9DsR3eUvWNEkSCDkMpNeJyBXVx06E22SHV
	mCROmSLv/eRrYGL5JqYZqRQgMETl8nAKDIt+C4EDyKH6moTECilzVAwT8lH+iFK7u/+7lKfmz5u84
	YRj6vI74B4pL7WEf1/QjH2xDSk4P7yAuJGfeIwn0aM1RCLzlvU3Qp8NT5SldDuNLH860z212FpuJE
	/4lCcJX/4hw9G8dmpWKNadAQZ4frmaAL1hVkXAe5Q8nd1clH/lqxMWq6GDPw3OmZ5jGriNbMbzCZS
	5rjH5I+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60486 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXk8G-0008O4-0P;
	Tue, 14 Jan 2025 16:51:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXk7w-000r4r-Pq; Tue, 14 Jan 2025 16:50:52 +0000
In-Reply-To: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	bcm-kernel-feedback-list@broadcom.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: bcm: asp2: remove tx_lpi_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXk7w-000r4r-Pq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 16:50:52 +0000

Phylib maintains a copy of tx_lpi_enabled, which will be used to
populate the member when phy_ethtool_get_eee(). Therefore, writing to
this member before phy_ethtool_get_eee() will have no effect. Remove
it. Also remove setting our copy of info->eee.tx_lpi_enabled which
becomes write-only.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 139058a0dbbb..5e04cd1839c0 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -364,14 +364,9 @@ void bcmasp_eee_enable_set(struct bcmasp_intf *intf, bool enable)
 
 static int bcmasp_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
-	struct bcmasp_intf *intf = netdev_priv(dev);
-	struct ethtool_keee *p = &intf->eee;
-
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->tx_lpi_enabled = p->tx_lpi_enabled;
-
 	return phy_ethtool_get_eee(dev->phydev, e);
 }
 
@@ -394,7 +389,6 @@ static int bcmasp_set_eee(struct net_device *dev, struct ethtool_keee *e)
 			return ret;
 		}
 
-		intf->eee.tx_lpi_enabled = e->tx_lpi_enabled;
 		bcmasp_eee_enable_set(intf, true);
 	}
 
-- 
2.30.2


