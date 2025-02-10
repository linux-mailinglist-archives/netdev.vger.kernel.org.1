Return-Path: <netdev+bounces-164649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3776A2E9A0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7281672E4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04F1CAA81;
	Mon, 10 Feb 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QGV6UZRm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48317591
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183829; cv=none; b=HBY6XgG4DrS6aLPtTndYIdZexsRdO7BukoUAQEDbTHHcQ0RkI/VjKBg41LUulg9DYZkFb05QEv++p4AspDaJ1wGTBITMCfZiY2cI7otFf27fWQ1uIZLBugXLnkwf3BXA1BGjT0LmQCwez1y9jm7wPLg3lvPeoLAJ7d815JxXNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183829; c=relaxed/simple;
	bh=xUBb2lVevZ0EdTfrbnadK7sD64R/Zch6QcP9guw5+mg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U2UYq36112begsOPU3YLBdZJ+8mdjmdvgJSw39EaE0JIrPQr1+MC9rcXElBVo0BW9kvxAYgR9LTWJLcMJdBL5IimlP88NqvZ+bZpRUJNwD3kXgidfmCIlCSWQ9Nhw+KTupelSt94A4rraUmDFf2G60L7+PpteUru7ZAUq1Esbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QGV6UZRm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GRXWV3EqF4OGfPClc9MjszNJHA7scoZyknzPOLSe4Nc=; b=QGV6UZRm+YXnJHn/ddiKz4T6CD
	Z/Cbk8QB8HpeAWoPOzJ7CqbRGv0/4jRkW2jTmLfbMYibxJknhgRJCvna/r19ubxWtjF8CEn6nK9K2
	kyQhzBO5QUWXU8Gtd+iWFj6sqj81Y3+49hYOskt2AtvOqnL/VkQuTUh3so43c35kKRmuJfUPjcAOg
	P/ttUzGQ11jxUpFG86mqaQgh/hLS7u+IXDza4jXgBLZJrfNoUwZhM2k7m3FNSddnsWCOVb//RRST2
	hsVFgRzErrAzbIRclEONtug2BaePTvr4MvwD0I/53owWKGI8jypGs8CR3nPIlvbZdCE50Og8n0spy
	srgkDvFA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58250)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thR9k-0006Qq-1B;
	Mon, 10 Feb 2025 10:36:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thR9e-0007Pr-22;
	Mon, 10 Feb 2025 10:36:42 +0000
Date: Mon, 10 Feb 2025 10:36:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next v3 0/3] net: dsa: add support for phylink
 managed EEE
Message-ID: <Z6nWujbjxlkzK_3P@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series adds support for phylink managed EEE to DSA, and converts
mt753x to make use of this feature.

Patch 1 implements a helper to indicate whether the MAC LPI operations
are populated (suggested by Vladimir)

Patch 2 makes the necessary changes to the core code - we retain calling
set_mac_eee(), but this method now becomes a way to merely validate the
arguments when using phylink managed EEE rather than performing any
configuration.

Patch 3 converts the mt7530 driver to use phylink managed EEE.

v2: fix mt7530 build error
v3: send correct patch 2

 drivers/net/dsa/mt7530.c  | 68 ++++++++++++++++++++++++++++++++---------------
 drivers/net/phy/phylink.c |  3 +--
 include/linux/phylink.h   | 12 +++++++++
 net/dsa/user.c            | 21 +++++++++------
 4 files changed, 73 insertions(+), 31 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

