Return-Path: <netdev+bounces-164054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F53A2C749
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404927A3A8C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C4238D50;
	Fri,  7 Feb 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QXJn9+pI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1644238D30
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942457; cv=none; b=e4yNqeliVpTMnzk7qj+gBU7odyE5LsnY2bUWrarZv217g2b3gdFj6f1vKQHLvVH/KQ6GTZXY6M2JkXR01/w6Lg9TD1qTNRYDj71oQzf03KIaBDUWkPwTarB3iWNbeOgVBWl5jTDC051gDeHP+Jf9UIH1F0cO5UKOBMxXqNXCaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942457; c=relaxed/simple;
	bh=QdBMV6xl03WvysrFlwNC70YTYa1Qt0Jj3FeUjlhP64A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKdZcC4wLtOyM8HSKr/xX9tpeVgyzbnH656nWdowtg5+NfXPMqKhg1md/0x+aokEG/1zU96lHfsBcIhEB1qnWShkNFku+wWMR7P9RZANmHYI2Ynh3DUoATzXPxd4XCIBMxlJExw6nUUca9cuQNSwSwC6w873YjkvzfzNNdTx8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QXJn9+pI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lIvRVDhUAojUHbrCWzuM16eBFe9BZTzTrRg0NCgYhfw=; b=QXJn9+pIYGKd03PucI01BeMp8Y
	5trHss2ZdbBc3MQKAMPhqcoHCp+wJjozpeWlHkvJZJ5XFbCIils23LS3gU+n24HqCkhbfGGYeL8IN
	TIGwsyHhqyiOBU4YyPWfS19Zz4ZF3DMWez5Saro+smM5hZ6Yr2yqWJ6Y4V0orqCBPlCumiZkqCfdy
	uaLGSHQeWcdIBRfzAVDISDxzqwu8BNguF19exj8Kh5VUEF+7hTUxDtWy5OPwNIzp6hYRQmUwA9lp4
	Cte5hU9GaMVnsY/gxp3+TFMdBnAfmRo7cxT6Z/6Sn2WRgib+jCRwRVHjy0SvHmBu/vx+0XOWGzSir
	FEsQGZKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tgQMb-00065K-0Z;
	Fri, 07 Feb 2025 15:33:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tgQMU-0004YF-1T;
	Fri, 07 Feb 2025 15:33:46 +0000
Date: Fri, 7 Feb 2025 15:33:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow use of phylink managed
 EEE support
Message-ID: <Z6Yn2jTVmbEmhPf9@shell.armlinux.org.uk>
References: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
 <E1tgO70-003ilF-1x@rmk-PC.armlinux.org.uk>
 <20250207151959.jab2c36oejmdhf3k@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207151959.jab2c36oejmdhf3k@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 07, 2025 at 05:19:59PM +0200, Vladimir Oltean wrote:
> On Fri, Feb 07, 2025 at 01:09:38PM +0000, Russell King (Oracle) wrote:
> > In order to allow DSA drivers to use phylink managed EEE, changes are
> > necessary to the DSA .set_eee() and .get_eee() methods. Where drivers
> > make use of phylink managed EEE, these should just pass the method on
> > to their phylink implementation without calling the DSA specific
> > operations.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  net/dsa/user.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index 291ab1b4acc4..2e0a51c1b750 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -1243,16 +1243,21 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
> >  	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
> >  		return -EOPNOTSUPP;
> >  
> > -	/* Port's PHY and MAC both need to be EEE capable */
> > -	if (!dev->phydev)
> > -		return -ENODEV;
> > +	/* If the port is using phylink managed EEE, then get_mac_eee is
> > +	 * unnecessary.
> 
> You thanked me for spotting that this should have been set_mac_eee() in
> the comment, but you didn't update it.
> https://lore.kernel.org/netdev/Z4bC77mwoeypDAdH@shell.armlinux.org.uk/

Bah - actually I _did_ update the patch, but in a different tree:

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=2ee2b1d5f0f8cee7dd748cfae9c20af429d5a4c2

I'm now looking at this wondering what updates were made in each tree
and therefore what I need to pass across between the two trees...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

