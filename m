Return-Path: <netdev+bounces-129962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9A987337
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 14:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5691F23FAF
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837B15B97B;
	Thu, 26 Sep 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x0p4i8za"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2A1547D5
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352180; cv=none; b=mmW6l4/aDXTdzQQ57qAiFm/Rs7tQII/4IyIyrfF/Vw3HUOVFr+01NaaSwVSYRvF9A/Yx2k3Kc/C0Zn66FRIWEzoVJc+woK0MfR5ihvxjbFwMgJcETM/5BJRpLw4teUQGmY5vXRNW3fWeNFan70tNjaiewkWU5mr/lNZ6Tb4hOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352180; c=relaxed/simple;
	bh=wxt6hYAoUlIzHTgP/3UIdF1S7gNe0nDK70xlymcjQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw8WxT3Fx++JU43StOMe03mdNRAvJKH7cOhS1+YJ8ch9KozKix/PmH2JZPDhJM2ZNZ5rgB+XRv9CJDmw3QsXIQcNa2dQxWCZQpi45b8FvJr4RkzULNhttW4YGUZoj6W0kFdP0BxQYF/xuTl6wPWMdilc1KwCD3RQC0C7qLruXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x0p4i8za; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WYYHaHC3yYNJYLN4CApnoOkWKsFh2EHIy2WfmkUP9Uk=; b=x0p4i8zaQ+D2Whmjo/HvditnuO
	wXG7j4IkFcJh4xgLcsgNIf+EqXcKbqEk5c30E1O0yn/ULpgMaWVe/VMMClwXSP7QTlli/b9gT6dPd
	y3veq8GOqLohWO5z7Gfkb3WtOzMID70MoRGoBHLmK+3Ir3qtUur/TWg6/l+eK4I2+C6G3nA92PVZn
	26ubyWwrpph/GMRb68LoXztr+hBAs7EiHpPi9HU7HeqloOtK3g0AD4iVMylseciKMwV1uQCHiKkwe
	JTFQwFhXNNTjyBtyl2owbuE3O7BdIjjQFdJYuL7gxucrCTGKWsRod8rOZVTirCFmXy3pnqdhSr+sc
	So/pTPWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48756)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1stnCk-0008AL-2g;
	Thu, 26 Sep 2024 13:02:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1stnCe-0008Iy-0C;
	Thu, 26 Sep 2024 13:02:36 +0100
Date: Thu, 26 Sep 2024 13:02:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 06/10] net: dsa: sja1105: simplify static
 configuration reload
Message-ID: <ZvVNWxIRhKyNLM/J@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>
 <20240925131517.s562xmc5ekkslkhp@skbuf>
 <ZvRmr3aU1Fz6z0Oc@shell.armlinux.org.uk>
 <20240925211613.lmi2kh6hublkutbb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925211613.lmi2kh6hublkutbb@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 26, 2024 at 12:16:13AM +0300, Vladimir Oltean wrote:
> On Wed, Sep 25, 2024 at 08:38:23PM +0100, Russell King (Oracle) wrote:
> > > There are 2 more changes which I believe should be made in sja1105_set_port_speed():
> > > - since it isn't called from mac_config() anymore but from mac_link_up()
> > >   (change which happened quite a while ago), it mustn't handle SPEED_UNKNOWN
> > > - we can trust that phylink will not call mac_link_up() with a speed
> > >   outside what we provided in mac_capabilities, so we can remove the
> > >   -EINVAL "default" speed_mbps case, and make this method return void,
> > >   as it can never truly cause an error
> > > 
> > > But I believe these are incremental changes which should be done after
> > > this patch. I've made a note of them and will create 2 patches on top
> > > when I have the spare time.
> > 
> > ... if we were to make those changes prior to this patch, then the
> > dev_err() will no longer be there and thus this becomes a non-issue.
> > So I'd suggest a patch prior to this one to make the changes you state
> > here, thus eliminating the need for this hunk in this patch.
> 
> That sounds good. Are you suggesting you will write up such a patch for v2?

Actually, the three patches become interdependent.

Let's say we want to eliminate SPEED_UNKNOWN. Prior to my patch in this
sub-thread, we have this:

                speed_mbps[i] = sja1105_port_speed_to_ethtool(priv,
                                                              mac[i].speed);
...
                rc = sja1105_adjust_port_config(priv, i, speed_mbps[i]);

sja1105_port_speed_to_ethtool() can return SPEED_UNKNOWN if
mac[i].speed is not one of the four encodings. If we can't guarantee
that it is one of the four encodings, then SPEED_UNKNOWN may be
passed into sja1105_adjust_port_config().

Similarly, as for the default case, we can't simply delete that,
because that'll leave "speed" uninitialised and we'll get a build
warning without my changes. We could change the default case to
simply:

	default:
		return 0;

but that just looks perverse.

So, I think rather than trying to do your suggestion before my patch,
my patch needs to stand as it currently is, and then your suggestion
must happen after it - otherwise we end up introducing more complexity
or weirdness.

Hmm?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

