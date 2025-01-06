Return-Path: <netdev+bounces-155425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3095BA024AE
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAE11885E79
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A21DDC09;
	Mon,  6 Jan 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WgrrSjPD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584A1DDA35
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164772; cv=none; b=cuslo0zpx7AOAfej/UYTq8XZ3TfSFx2AQOSgccdSwK+X/EbekaI7+I52+AcNo61LagcsKY3a1SyiGAtIBh2W8vwi/h+tfAlDPObEwWcssLMOizrqooYHLS4Mmfwtt4RWnFkL/B5QfPDqkrGSvQ5DJZofX35zEQkI7V5fl0Vs7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164772; c=relaxed/simple;
	bh=dHJKANPxXhPG23OAzxgyAfOncgPjN4jT8yXgcOOR6i0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bkAEo9ESA8/ykgUC2ppd18kjfs7mJpoL7ut9rs8HGv6cjrH7y9EDHwsIN3zFVIRuTN0nsrjAJLh30//7ylkDxgGaxqVlOED+dKm+Bo8mhtRkD1egHsSGXTEDhPk1T3Dcv7Jd+W6V0xg7SgY0uXZW3TFvD4xEhkLLdVTYveB6PXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WgrrSjPD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EFr9aVqtLCB1+vJB287VPT2vK1AUEy2cORlV5lLd8nU=; b=WgrrSjPD74YNdTA8CMHeKfrAxC
	MsDhNcRI10VChUGPh65N6RLbRe9SO19PyZkVZGSz74Iijd5P8vh1azs9qQPYqDL+azErOGvT69NLN
	mKe5RhPXC21f40o7DPCA4KRCXmLnZPc81UV2/7vzMHeASAlSOCagWDT4zTtZBsjZ/1JYWNd4BHlj4
	/nrpA9rNp6Jmo8wyAZBHIoObHl9OjyzX6Dr6+YfihuYeXFQO/vGdK2RiYQ7XuJ0u9RruLn6hS5UoY
	ypfD7AJ0ZbR8kHgxi007J3mQGI2HetLxTDsvz2Vp7vsW2AYCh8g6BsY9fzO68Lh8sMO6ErxcJeIDY
	5Mi8qn+A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37120 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUllN-0005ll-1x;
	Mon, 06 Jan 2025 11:59:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUllK-007Uz9-D7; Mon, 06 Jan 2025 11:59:14 +0000
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
Subject: [PATCH net-next 7/9] net: dsa: mv88e6xxx: remove
 mv88e6xxx_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUllK-007Uz9-D7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 11:59:14 +0000

mv88e6xxx_get_mac_eee() is no longer called by the core DSA code.
Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 570c8642d387..35ae084af166 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1513,13 +1513,6 @@ static void mv88e6xxx_get_regs(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_unlock(chip);
 }
 
-static int mv88e6xxx_get_mac_eee(struct dsa_switch *ds, int port,
-				 struct ethtool_keee *e)
-{
-	/* Nothing to do on the port's MAC */
-	return 0;
-}
-
 static int mv88e6xxx_set_mac_eee(struct dsa_switch *ds, int port,
 				 struct ethtool_keee *e)
 {
@@ -7100,7 +7093,6 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
 	.support_eee		= dsa_supports_eee,
-	.get_mac_eee		= mv88e6xxx_get_mac_eee,
 	.set_mac_eee		= mv88e6xxx_set_mac_eee,
 	.get_eeprom_len		= mv88e6xxx_get_eeprom_len,
 	.get_eeprom		= mv88e6xxx_get_eeprom,
-- 
2.30.2


