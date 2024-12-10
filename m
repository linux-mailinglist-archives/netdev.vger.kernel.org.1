Return-Path: <netdev+bounces-150690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AD9EB2F9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF019285B23
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127AB1ABEBA;
	Tue, 10 Dec 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g7O5fXsT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6481ABEA8
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840310; cv=none; b=o50i25mXm/VKyV5pHe983o+oEGq66NJOgKQOK0BzEBwe4WxJdkSBKe5uPSOlVQ0+xikE5UFbad1B9hZdJ7ru5L+8UIWQNdVt+/PfSZM/GSe+xxtVaxfrwj+F/JScIA4BQkytzSreD14e4B4yEu6+QtksEUjedS786oUY5cyk84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840310; c=relaxed/simple;
	bh=wfckIHVfFQq7caFl7mX5nJMOh4dw9qtUZFjncSeEUpY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=p6nqhMv5kywoyNmRUVE1MLyItXAT5bftkRqTOnlvjp7oOmu5GlEPOjsY5lZBMbvr0VJlY9OY+t/cUNG1XEZxguRxgycE6xsb3EdaPyEopRr2EXBqK1dQw8sMZB2InMBDMjVRJsfcSvLrWBZF8AygBGyPEkYbRElTG2fKqq2c414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g7O5fXsT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gZeUKmjTWrPxI3nhYuZ5sil5KUc6LYRAxvBAbVkyF2w=; b=g7O5fXsTSYslmoYkIrplDjGH9+
	SoGILQDnbkvlyF/XdP3Cexmqb40R1sGBKHta2hHotDaEM/Ce9b0aW5p0N3LelyAo2BkaT3sx0wB1R
	nVdG0eew6kyRAtaeREHtXZFwzNeH2oENELF4vnqIwNjOWWdsixmB0FQ5Qmb86xLQCHmNjeLS4w5w1
	tXykbrISXcMzQb2hIrrmwWp2phccFOQmehVXvaZu6IWNWAfIyD1BXCbFcYpNdPu0pGJLLJimwyxSI
	1oiGtl9uXB042cceIuC4YdQQAdVo7KmPrhtXiMhjGwxHTZzITXhDfzUjUOhkm3+aOJclRJX7L/uPp
	bMXJgjLw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38252 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL145-0002Sq-31;
	Tue, 10 Dec 2024 14:18:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL144-006cZD-El; Tue, 10 Dec 2024 14:18:16 +0000
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/9] net: dsa: add hook to determine whether EEE is
 supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL144-006cZD-El@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:16 +0000

Add a hook to determine whether the switch supports EEE. This will
return false if the switch does not, or true if it does. If the
method is not implemented, we assume (currently) that the switch
supports EEE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h | 1 +
 net/dsa/user.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 72ae65e7246a..aaa75bbaa0ea 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -988,6 +988,7 @@ struct dsa_switch_ops {
 	/*
 	 * Port's MAC EEE settings
 	 */
+	bool	(*support_eee)(struct dsa_switch *ds, int port);
 	int	(*set_mac_eee)(struct dsa_switch *ds, int port,
 			       struct ethtool_keee *e);
 	int	(*get_mac_eee)(struct dsa_switch *ds, int port,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 0640247b8f0a..b54f61605a57 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1228,6 +1228,10 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
+	/* Check whether the switch supports EEE */
+	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+		return -EOPNOTSUPP;
+
 	/* Port's PHY and MAC both need to be EEE capable */
 	if (!dev->phydev)
 		return -ENODEV;
@@ -1248,6 +1252,10 @@ static int dsa_user_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
+	/* Check whether the switch supports EEE */
+	if (ds->ops->support_eee && !ds->ops->support_eee(ds, dp->index))
+		return -EOPNOTSUPP;
+
 	/* Port's PHY and MAC both need to be EEE capable */
 	if (!dev->phydev)
 		return -ENODEV;
-- 
2.30.2


