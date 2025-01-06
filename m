Return-Path: <netdev+bounces-155420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B33A024A5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5031F7A2708
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F21DDA1B;
	Mon,  6 Jan 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oKKT4Yfx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D81DAC8E
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164748; cv=none; b=mJTmMwVGqaSmqyybnoia2csZSZKfq2dHMO0Pm8W6hnWGJ480V6NntSr2PmQA2zHndq63R8LaZmEd+h6TKw39MtUJ7rjuCx+2JtrdmypgEGXI6bPHGDC04Pk71hN6UJYwoGZDDxWTotekk8KQHpI76QnAgvYfeLKBTsfS79vQDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164748; c=relaxed/simple;
	bh=HDDa+4AsHJFymOAgct0Zs7BEDMsGvCeDzd9LZDjpbo4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QR0uDK4jqGvKwEwLtI+HW+90SEm4e0Tyx8IZTZNN7i305Dzgbh+UUQGEkAVo9GYE+gu7xfboPAIUHjDQbNazENmwrpFrLZ5RdDfIKYR50esBh4d5EaUN29xMWCbrf4ur/HCcfmmVeyj5jBZWLUZuWETqOwMQPRpl6FP87adqgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oKKT4Yfx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aVjjOeVo8Ce/t55+rQVszo5wPlO5d2hOsrXlSpvC7mI=; b=oKKT4YfxbWhUxoDLZSBzfK+lqz
	17rq6kc5RsA+Oi3YMKsANec3Le4fCnGQOnKAlWpCxjtz6HNSxcbc50e/bBt243XG3n6aQg64W9Q30
	GNnHtJ7dHUSbP7rVvTB0IvdjnirMEeB9yDHVg3MQ9Yn476K/0B7VF7uroevYF5RA1cfbScnE8+zpz
	9+A4QBgXuuBZWzLV/uCn3BCltzkyQa3iqUjTDRuLPZNg4JBjnQ+TJX8Xi9zIMwYBhAVYdAU5osB4M
	5FWV0wVXf1u9PNpQiGs+pR78UKEFYKsMxL24WpOTZtxGstXtsRRNBVXoRz9dVekk6i8enTNTSz6ED
	KSQP0IHw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52332 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUll2-0005kU-2w;
	Mon, 06 Jan 2025 11:58:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUlkz-007Uyl-UA; Mon, 06 Jan 2025 11:58:53 +0000
In-Reply-To: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 3/9] net: dsa: no longer call ds->ops->get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUlkz-007Uyl-UA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:58:53 +0000

All implementations of get_mac_eee() now just return zero without doing
anything useful. Remove the call to this method in preparation to
removing the method from each DSA driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/user.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 4a8de48a6f24..c74f2b2b92de 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1251,7 +1251,6 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
-	int ret;
 
 	/* Check whether the switch supports EEE */
 	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
@@ -1261,13 +1260,6 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
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


