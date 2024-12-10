Return-Path: <netdev+bounces-150701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD29EB332
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB8165CF8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC11A9B3F;
	Tue, 10 Dec 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uzf1Z5S+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C91AF0D4
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840787; cv=none; b=pY7920B2Uiry2qkvA3PAwY3GRhQewfJ84WHcr6/QrCxp8A7akGQ4pwpZzaICSVCMGzL7F4o/kdjuFXpEl4RIeEVFv4nXFlLNqKnrzaE1W9ItBpac0rVrHVtYozU4dUH/R4LbfzSbWzlxuUwg1XI9FlC3TIMxG1vpGYbPtP6hHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840787; c=relaxed/simple;
	bh=3602MzZdwPzpCopK5RcCRGLU+UA2OARQRwHQT373Hgo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=f896ZWGc41uPjDlNjx6P0t5gSe/kSBukSUaw0M7dWjklcb+kAO+r6kHjO22QOgxC+T5S7noB6+u3183i5uILLcT0wbhWtmoCl54G/tJPWF3Xd6545DAay0I+0RFD2z/HrH29spmAh0NsH2+9jHmv6lgwusrZnewhnmQyMmv08uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uzf1Z5S+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B4OyUUHYIuqjy441HVi5jgLLiexrDfZmmrvvYn9QIIQ=; b=Uzf1Z5S+u2+um/+JgXPSby6giW
	2x2WpnC8Zd9XnsqhUeM39sEY5YHr7TSCk/49McBvaHfViQBStz1TV5IQeMwh/aNEKAjUSzwS0H/7f
	M+7Jks5xmfPxGyu5rZxdMK1QMHb36nq5nsArRr8aMlYlXMOrB6bm6+7E50LpjRmf4/+V+aIQ8i+PX
	EGR36BEXlRU7ckrrMhG3WWrjiQuI8apdISDutb0X9rH1Y/+BYNr02PigDn/JLrn/bi3KQinmtb42/
	6uNkvnCklaj5cl8HfY0lHhGnakEC0dtNTU6CI1Mb4QNmSKIJgsT/CSPTiXBdEWsCmjmmxqLA8LRN+
	6WpXrEeA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44522 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1Bt-0002Xe-06;
	Tue, 10 Dec 2024 14:26:21 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1Br-006cnA-KV; Tue, 10 Dec 2024 14:26:19 +0000
In-Reply-To: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 2/7] net: dsa: no longer call
 ds->ops->get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1Br-006cnA-KV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:19 +0000

All implementations of get_mac_eee() now just return zero without doing
anything useful. Remove the call to this method in preparation to
removing the method from each DSA driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 4239083c18bf..fb38543b29db 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1250,23 +1250,11 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
-	int ret;
 
 	/* Check whether the switch supports EEE */
 	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
 		return -EOPNOTSUPP;
 
-	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev)
-		return -ENODEV;
-
-	if (!ds->ops->get_mac_eee)
-		return -EOPNOTSUPP;
-
-	ret = ds->ops->get_mac_eee(ds, dp->index, e);
-	if (ret)
-		return ret;
-
 	return phylink_ethtool_get_eee(dp->pl, e);
 }
 
-- 
2.30.2


