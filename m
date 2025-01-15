Return-Path: <netdev+bounces-158533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC9A12657
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C061677C9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814EF1292CE;
	Wed, 15 Jan 2025 14:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997A24A7E1;
	Wed, 15 Jan 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952218; cv=none; b=ZArLcjGZ2haQ8+IiXiBDfxIPKvRGDbz9GXbezh9guMwiQMyIFhYsS6jHonhe3z/xIajj3+IWZMmSgk7Da0NOo1A7eDDJCKiJeae734yJfhTVxQ7LwHRKjKw1lkCWmwa3Z2ShuC3JogcHJsH5LhSDHfGsPoeix401e04FudsPWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952218; c=relaxed/simple;
	bh=xnOxfyk5tk3vQWH/7rCmunOnasL4TwI1A7iKjnCtwCE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Im4w5fdVsCG9YuWgOhYlk1N3BpCFuERkzRH2Xh4zxmrpKIgbD6dwA5cva8Te7h8f+E0BbjiwulnOJY6d0WDDMcfvpHcbKbsz3KdyjA2bKSINBiHnVOGaLqTU9iCtLAxn4q7tVvqaa75Z82WKG4/cITPukJ3btKeqcdZH4KWOaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tY4cC-0000000021h-1jAb;
	Wed, 15 Jan 2025 14:43:28 +0000
Date: Wed, 15 Jan 2025 14:43:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: phy: realtek: fix status when link is down
Message-ID: <cover.1736951652.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The .read_status method for RealTek RTL822x PHYs (both C22 and C45) has
multilpe issues which result in reporting bogus link partner advertised
modes as well as speed and duplex while the link is down and no cable
is plugged in.

Example: ethtool after disconnecting a 1000M/Full capable link partner,
now with no wire plugged:

Settings for lan1:
    Supported ports: [ TP ]
    Supported link modes:   10baseT/Half 10baseT/Full
                            100baseT/Half 100baseT/Full
                            1000baseT/Full
                            2500baseT/Full
    Supported pause frame use: Symmetric Receive-only
    Supports auto-negotiation: Yes
    Supported FEC modes: Not reported
    Advertised link modes:  10baseT/Half 10baseT/Full
                            100baseT/Half 100baseT/Full
                            1000baseT/Full
                            2500baseT/Full
    Advertised pause frame use: Symmetric Receive-only
    Advertised auto-negotiation: Yes
    Advertised FEC modes: Not reported
    Link partner advertised link modes:  1000baseT/Full
    Link partner advertised pause frame use: No
    Link partner advertised auto-negotiation: No
    Link partner advertised FEC modes: Not reported
    Speed: 1000Mb/s
    Duplex: Full
    Auto-negotiation: on
    Port: Twisted Pair
    PHYAD: 7
    Transceiver: external
    MDI-X: Unknown
    Supports Wake-on: d
    Wake-on: d
    Link detected: no

Fix this by making sure all of the fields populated by
rtl822x_c45_read_status() or rtl822x_read_status() get reset, also in
case the link is down.

Daniel Golle (3):
  net: phy: realtek: clear 1000Base-T lpa bits if link is down
  net: phy: realtek: clear master_slave_state if link is down
  net: phy: realtek: always clear 10gbase-t link partner advertisement

 drivers/net/phy/realtek.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

-- 
2.47.1

