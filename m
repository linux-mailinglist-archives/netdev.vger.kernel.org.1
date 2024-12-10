Return-Path: <netdev+bounces-150700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBD9EB330
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25C8162311
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A41AE843;
	Tue, 10 Dec 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pkzwFEux"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930521AC450
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840782; cv=none; b=OJFeCK9CoNCtWksX4dyga8GW07yrOPjrHOAJmSjsmipapFVf5EtWXFV4ENF04v4wyz5yEdOY25Gh+PhC+EBWKMHCfHeJgFgJk5zX+ScFMNcLGY0UH+r1WWmMAzSfdJLZF8BFKxjuuDy820ZzXY6rSj+CPW42iKT0V7kp0X5AbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840782; c=relaxed/simple;
	bh=YzpJ5Ech2tFBRwr/fykFM9OhktbULEwUTNk+beKXWC0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tC7jxwmA0IlD9ls+F5AIyBQvyfpoxTyRSFqdajvZxUr1gGHO0WKYl3nDeDVouJmNuB7j1OgdoxWbkoo48eM0eSGFSalZ6G51FeRvFfnWrpP7hfsCNKVvZ5jE0jsmXYcRUrGCtPnaY7U+h94+wkSI5zUMIYGT1XG8IeK6BKrNlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pkzwFEux; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=id/jB4M6wcjUq20SRtsYBj8Ele73YRBxaOIY46wXcf4=; b=pkzwFEuxQQmiRhV9HJtbLr7E8h
	Vi0vY/wRxmIPNz2hHWHAS1rXfiiQu5tVzfaYBcmIPhohOUKqGtJyUXEwBIKVQJxs18sms+SsUk0xK
	560CIU9dAyfEio9PdKOshwzT4tmAcKjWWyJQd9P7bQG054UlmgMVn5nHx5JROZPaw+dQHMJ18x/j3
	FFjLYR9BE6t8vx39uvGp92MQhyPOspKAbRDeZzJKergIDh+VfO68eBfkIDfTh+LOPcIFTdlvLDBcG
	6US9QOJ/YGodFWNYvmXU80Mv6jw/MxsaaFIZk/5s9eWQXNz+L66EuzOH0QG0bfaTB21fZxQo7yRhY
	4Z0CsfVw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56478 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1Bn-0002XT-35;
	Tue, 10 Dec 2024 14:26:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1Bm-006cn4-Gr; Tue, 10 Dec 2024 14:26:14 +0000
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
Subject: [PATCH RFC net-next 1/7] net: dsa: ksz: remove setting of tx_lpi
 parameters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1Bm-006cn4-Gr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:14 +0000

dsa_user_get_eee() calls the DSA switch get_mac_eee() method followed
by phylink_ethtool_get_eee(), which goes on to call
phy_ethtool_get_eee(). This overwrites all members of the passed
ethtool_keee, which means anything written by the DSA switch
get_mac_eee() method will discarded.

Remove setting any members in ksz_get_mac_eee().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 94f9aa983ff6..9a48b4438a6d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3480,14 +3480,6 @@ static bool ksz_support_eee(struct dsa_switch *ds, int port)
 static int ksz_get_mac_eee(struct dsa_switch *ds, int port,
 			   struct ethtool_keee *e)
 {
-	/* There is no documented control of Tx LPI configuration. */
-	e->tx_lpi_enabled = true;
-
-	/* There is no documented control of Tx LPI timer. According to tests
-	 * Tx LPI timer seems to be set by default to minimal value.
-	 */
-	e->tx_lpi_timer = 0;
-
 	return 0;
 }
 
-- 
2.30.2


