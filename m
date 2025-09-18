Return-Path: <netdev+bounces-224559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE4B8643A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8127E0628
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C7E31961D;
	Thu, 18 Sep 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nO1bJlSg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F52BE051
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217153; cv=none; b=Lh3nmMHdkdbCe9sc0QESfXgRlZixOyS2DxIIJw5ss0soNeOx892fH7NlFZy/oNnEq/Yf8qOIdfR2/D74aUL0qq/5CpPaltLY8SjkAsSs2KrtfbpEaWHd6hk0NWJJ4JtqL7AKHqNQ1EArHihXkgomT8ju8ifbJ6G0BfaI3fRPgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217153; c=relaxed/simple;
	bh=KZ+Ajgt4VhnXPSXK/9wy2V/i06t2yaahpjMvKCibqv4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NLwI5/B9LXz49tjvwy7z8b7+Rf6d8jSp2fd9hqv91XVfGgwv7URqVRMSaETb9Oh3hWfgPqx3VKBA0HRXI7tLFw5xnynfY8eFLV3/6n6cYYPZpeGSWC4fFqyxpYDuRwVLv/MxoF6PpcH9Q0mHwhBAOBBsLmySMBvJ4aQsZi4ydmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nO1bJlSg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cpenaHGKXtthLGX5IYsjJnOgVqsZljJdfGvPMWtJJoc=; b=nO1bJlSgCcfYsl5X7TC+Ri3jM+
	vv2jTKf6kbwWlzO7vStjj1Wi9ZaVkqbsEQ8ZpgicLsLp//88RFUbm4hp6m64CXYQO9md6WNATBO+N
	w5idcNxmpAFS4oPSHsdWOlVBzZE7FIOIDiAHGLU+98McGx1WLpmZuR40xRudBlOBKhnqmkUfqPO/E
	/vw+3sbrRZLZknKqiK4aHJ82zCj/r+x0WV8fONck13+fmTfVrq9N4hfyu4cfgJpM5FxOEn6NWKZwk
	C5gEB0UPAm6zb3w/m7tbU88kMEVNgtc0uVt5Ysf4Y4ldmrMulF3r3W70J2M9Z7/5Ca/U9vwwZbFcV
	P2LRmcuA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52206 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIb1-000000001aS-1OqM;
	Thu, 18 Sep 2025 18:39:03 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIb0-00000006mzE-03Vf;
	Thu, 18 Sep 2025 18:39:02 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 02/20] net: phy: add hwtstamp_get() method for
 mii timestampers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIb0-00000006mzE-03Vf@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:02 +0100

Add the missing hwtstamp_get() method for mii timestampers so PHYs can
report their configuration back to userspace.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c           | 3 +++
 include/linux/mii_timestamper.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e046dd858f15..b028c53c459a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -476,6 +476,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
+	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get)
+		return phydev->mii_ts->hwtstamp_get(phydev->mii_ts, config);
+
 	return -EOPNOTSUPP;
 }
 
diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
index 995db62570f9..a71f03d1585f 100644
--- a/include/linux/mii_timestamper.h
+++ b/include/linux/mii_timestamper.h
@@ -55,6 +55,9 @@ struct mii_timestamper {
 			 struct kernel_hwtstamp_config *kernel_config,
 			 struct netlink_ext_ack *extack);
 
+	int  (*hwtstamp_get)(struct mii_timestamper *mii_ts,
+			     struct kernel_hwtstamp_config *kernel_config);
+
 	void (*link_state)(struct mii_timestamper *mii_ts,
 			   struct phy_device *phydev);
 
-- 
2.47.3


