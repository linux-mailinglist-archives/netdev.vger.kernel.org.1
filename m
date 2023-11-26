Return-Path: <netdev+bounces-51136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4277F94D3
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4721C208F5
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6561095C;
	Sun, 26 Nov 2023 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xi3WSI6u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B2CA;
	Sun, 26 Nov 2023 10:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+6LrOr5Z575YRueK+NEQTn+R3XWM1OcPUfOAnH1ya0I=; b=xi3WSI6ug2PFJckDjMZoigHVCP
	JWQehRJbPd/WqUPLCmwWDq7kwxAngHAgkfaoJGiHtMSoU6SWZ5wCT0tQxxZ5WvcDVBs66Unk08BHn
	+48k8l5Wuyzi4TkrTyzJoYWPx2RoI9n7l5g8xBTKR8CmqiPpClyT5kPi4VE7d86Q9Jg0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7Jiu-001GRD-Sk; Sun, 26 Nov 2023 19:19:16 +0100
Date: Sun, 26 Nov 2023 19:19:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: extend PHY package API to support
 multiple global address
Message-ID: <240c0d9a-38d9-44fc-a56d-cdd88d9144a9@lunn.ch>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
 <65638967.5d0a0220.28475.43b3@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65638967.5d0a0220.28475.43b3@mx.google.com>

> > static inline int phy_package_read(struct phy_device *phydev,
> > 				   unsigned int addr_offset, u32 regnum)
> > {
> > 	struct phy_package_shared *shared = phydev->shared;
> > 	int addr = shared->base_addr + addr_offset;
> 
> Isn't this problematic if shared is NULL?

Duh! Yes, it is. But why should shared be NULL? The driver is doing a
read on the package before the package is created. That is a bug. So
an Opps is O.K, it helps find the bug. So i would drop the test for
!shared.

	Andrew

