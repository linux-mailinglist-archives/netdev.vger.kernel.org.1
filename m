Return-Path: <netdev+bounces-34646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42F7A509C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D787F281F1B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD59266C6;
	Mon, 18 Sep 2023 17:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396B266DE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:07:45 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0B811F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8LWc5MQNkz5rUmJ+1pgTYkcJ7c30vSJmGjNAwciH2lo=; b=CDwqbMLLGxcncN4aVMZnXNRgj9
	t5zl8rmiyo9SnXk5rTpgIJMdrj51TLpWakYEdKtvoJxKo0pD1pBOC3uB62JG57Xwt2qRyE1KDpnP3
	QN52X12dCWJdyW+cvmwfZElko8aDN/fn4Y8Mf3I9wWCMPPPM9LI/fWAkSjt+iD+SAkdE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qiEd2-006nVl-VF; Mon, 18 Sep 2023 15:49:32 +0200
Date: Mon, 18 Sep 2023 15:49:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: fix regression with AX88772A PHY
 driver
Message-ID: <eeb31d51-2b07-4b23-a844-c4112c34ef83@lunn.ch>
References: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 02:25:36PM +0100, Russell King (Oracle) wrote:
> Marek reports that a deadlock occurs with the AX88772A PHY used on the
> ASIX USB network driver:
> 
> asix 1-1.4:1.0 (unnamed net_device) (uninitialized): PHY [usb-001:003:10] driver [Asix Electronics AX88772A] (irq=POLL)
> Asix Electronics AX88772A usb-001:003:10: attached PHY driver(mii_bus:phy_addr=usb-001:003:10, irq=POLL)
> asix 1-1.4:1.0 eth0: register 'asix' at usb-12110000.usb-1.4, ASIX AX88772 USB 2.0 Ethernet, a2:99:b6:cd:11:eb
> asix 1-1.4:1.0 eth0: configuring for phy/internal link mode
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.6.0-rc1-00239-g8da77df649c4-dirty #13949 Not tainted
> --------------------------------------------
> kworker/3:3/71 is trying to acquire lock:
> c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_start_aneg+0x1c/0x38
> 
> but task is already holding lock:
> c6c704cc (&dev->lock){+.+.}-{3:3}, at: phy_state_machine+0x100/0x2b8
> 
> This is because we now consistently call phy_process_state_change()
> while holding phydev->lock, but the AX88772A PHY driver then goes on
> to call phy_start_aneg() which tries to grab the same lock - causing
> deadlock.
> 
> Fix this by exporting the unlocked version, and use this in the PHY
> driver instead.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: ef113a60d0a9 ("net: phy: call phy_error_precise() while holding the lock")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Hi Russell

Yes, this fixes the problem for stable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

But maybe it would be better to move the hardware workaround into the
PHY driver? Its the PHY which is broken, so why is the MAC working
around it?

       Andrew

