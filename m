Return-Path: <netdev+bounces-159719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C197A16A03
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292941622D1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61061B3949;
	Mon, 20 Jan 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gcOAsWT6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50F1AF0DC
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366867; cv=none; b=C1n6glfSXbkQhlxxUps+936R/oqbQ3g5TG+gmcQ0w/Gd8N32ckTK9aQy/pRxkH/9VOUrB+69NdwQ7Xj/5uw181xstPSiEJZm7blTP6ZKp6hlgxPJmEzxomfCgeNvBi/lnzQKeMfEJqAkR/minPilrDQmOFEI5YP5+3PYObLiTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366867; c=relaxed/simple;
	bh=xqPLTjlnYlzhtKQVM06oqAXX0ionVcb4Ki4CE9T7mbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5Uz2u/HgKqq24R8NLku4BDqTTZ7usx7VGI7z1gWinjM2/xyIRtKhSj9YwsaPeRbKpeEstRoPOKLcFOkdQwa4oHf9NyLoVXtGE7Q/HRfZaA8D8ms+tH182+o2hv6UGlxsyRb5B5lzAzvfFBnQM3cD3pvoQjOwCWI5qwBKrJ/VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gcOAsWT6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J9qCCKssPFOhNE2Q6kDpYoA+uFQ9qxMGhFoj3QIqWXY=; b=gcOAsWT6tsh6Zg0srbvfzKTGfd
	jyL0hmH29wdmm5FcCL0Q7b7Uvm3jGaCHg5p1N3oH2HFvIXwNq+x61zL2Kau1DZUlWq4RcY0DlnN0i
	lfxWXsKWUZxzAh8xjGiGKke/p/jYMsK8xWT/ljhwnEdLWawXonXWpH+koy5pijI9KSP3H7OtwwdKH
	1gMspWSk8odUd3VXLc+2kBuZgG8r1GblfLoQ4/WRbNSM87noB4toSJy0LUcOFqI1tnS7eONFygrGu
	aC9fFbAR9yhUCEsJyZy4nEx+8uPUUG7QZdLRLt8ORQa2zt+S6tXEVpN9XJCQcDqHadDo57Bu1uN3N
	Yt0UaE4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tZoTw-0005zi-2P;
	Mon, 20 Jan 2025 09:54:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tZoTq-0002lo-1n;
	Mon, 20 Jan 2025 09:54:02 +0000
Date: Mon, 20 Jan 2025 09:54:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Andrew Lunn' <andrew@lunn.ch>,
	'Heiner Kallweit' <hkallweit1@gmail.com>, mengyuanlou@net-swift.com,
	'Alexandre Torgue' <alexandre.torgue@foss.st.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	'Bryan Whitehead' <bryan.whitehead@microchip.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	'Marcin Wojtas' <marcin.s.wojtas@gmail.com>,
	'Maxime Coquelin' <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org, 'Paolo Abeni' <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 0/9] net: add phylink managed EEE support
Message-ID: <Z44dOlfRN5FmHcdS@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <06d301db68bd$b59d3c90$20d7b5b0$@trustnetic.com>
 <Z4odUIWmYb8TelZS@shell.armlinux.org.uk>
 <06dc01db68c8$f5853fa0$e08fbee0$@trustnetic.com>
 <Z4pL3Mn6Qe7O45D7@shell.armlinux.org.uk>
 <073a01db6add$d308af40$791a0dc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073a01db6add$d308af40$791a0dc0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 20, 2025 at 09:51:29AM +0800, Jiawen Wu wrote:
> On Fri, Jan 17, 2025 8:24 PM, Russell King (Oracle) wrote:
> > On Fri, Jan 17, 2025 at 06:17:05PM +0800, Jiawen Wu wrote:
> > > > > Since merging these patches, phylink_connect_phy() can no longer be
> > > > > invoked correctly in ngbe_open(). The error is returned from the function
> > > > > phy_eee_rx_clock_stop(). Since EEE is not supported on our NGBE hardware.
> > > >
> > > > That would mean phy_modify_mmd() is failing, but the question is why
> > > > that is. Please investigate. Thanks.
> > >
> > > Yes, phy_modify_mmd() returns -EOPNOTSUPP. Since .read/write_mmd are
> > > implemented in the PHY driver, but it's not supported to read/write the
> > > register field (devnum=MDIO_MMD_PCS, regnum= MDIO_CTRL1).
> > >
> > > So the error occurs on  __phy_read_mmd():
> > > 	if (phydev->drv && phydev->drv->read_mmd)
> > > 		return phydev->drv->read_mmd(phydev, devad, regnum);
> > 
> > Thanks. The patch below should fix it. Please test, meanwhile I'll
> > prepare a proper patch.
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 66eea3f963d3..56d411bb2547 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -2268,7 +2268,11 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
> >  	/* Explicitly configure whether the PHY is allowed to stop it's
> >  	 * receive clock.
> >  	 */
> > -	return phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
> > +	ret = phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
> > +	if (ret == -EOPNOTSUPP)
> > +		ret = 0;
> > +
> > +	return ret;
> >  }
> > 
> >  static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
> 
> Test pass.
> Thanks.

Thanks, I guess that's a tested-by then?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

