Return-Path: <netdev+bounces-150703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52559EB331
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2537F18861B9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3793F1AF0D4;
	Tue, 10 Dec 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CEi7nUBb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821B1B6539
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840797; cv=none; b=YuhjtuWI5o44kgr/+etb2E+5llcjXjTPJZMhjGd2WCxx8USSpI2Vd6Sg00YIHgQMbgdSA6TTWHXocYZqFdHPievNxv5LgGa9BgO8v2Umx80HoiMFjayhmwrltsTqBKBOEaP1AC7QmVKmrBKlPo3oi2MLAn/wXUmgOCKjYGK+OcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840797; c=relaxed/simple;
	bh=L6r0mw0fOkSALhi4Db3ctp0gYZxYehJ0K+gV4X0Il/k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jqKQGxkcw1A/EQppEHMyWP4GsasWfUBOq9XCrrgHFakTKpoJeXJZkNetWcy3eb0TjPnZ2WZPjWrR7PaSJlw7t0pa2wIPx7fddYNPK160D+36efSGUkCXJIMRlNs91SSGbje1kpz3xe5TjtgYZnin/DMKFETRDIDVpesIsIqJQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CEi7nUBb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cvdvBlA9Ko6LAHPWyefb3uu2oXGYH3k/JYtRhZiz8wI=; b=CEi7nUBbPaNQwdh/WeyCdGUXaK
	cBjc+pt8eXjb6mqBcgKjp3+4zrqwtboexfC+u7M85qBZ6Xc7v0FYxH28/Bp6KuLj07apc4N6K5DkH
	B5EVeR79ksjwSPujBfYYD16eDcPI37f7kRGPMgOjFQpx7UsnDqjUEJykhVhTZ5rj4HSBY05wPWyC7
	G+fi1OgZ1ntD9ndLQyzsnsJXrxpFupbgwUn1AwDJdZuUHShDiVivzyf317PSPiZExsK2hqBZC/+vr
	AtgoyQEGIQsSg3jtnlGMvWlveEGAo/Z373+l2OJmbJK1JsQ7y7XDRjYcHpWhoU4IcCroTy03ui0ld
	KDHjDU3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35626 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1C3-0002YA-0q;
	Tue, 10 Dec 2024 14:26:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1C1-006cnM-S8; Tue, 10 Dec 2024 14:26:29 +0000
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
Subject: [PATCH RFC net-next 4/7] net: dsa: ksz: remove ksz_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1C1-006cnM-S8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:29 +0000

ksz_get_mac_eee() is no longer called by the core DSA code. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 9a48b4438a6d..807a37112a00 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3477,12 +3477,6 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 	return false;
 }
 
-static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
-			   struct ethtool_keee *e)
-{
-	return 0;
-}
-
 static int ksz_set_mac_eee(struct dsa_switch *ds, int port,
 			   struct ethtool_keee *e)
 {
@@ -4633,7 +4627,6 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.cls_flower_del		= ksz_cls_flower_del,
 	.port_setup_tc		= ksz_setup_tc,
 	.support_eee		= ksz_support_eee,
-	.get_mac_eee		= ksz_get_mac_eee,
 	.set_mac_eee		= ksz_set_mac_eee,
 	.port_get_default_prio	= ksz_port_get_default_prio,
 	.port_set_default_prio	= ksz_port_set_default_prio,
-- 
2.30.2


