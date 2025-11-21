Return-Path: <netdev+bounces-240790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E364C7A623
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E48234F19F7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B722C15A8;
	Fri, 21 Nov 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aO0PLSK7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79A28F948
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736913; cv=none; b=R7Comgr0kMaaSIYZx/FWR113I19ESGGi23vCEfU5U7ZCF/Qc6EMOxiaHLPvkLPctk6R3rNxVD0Ii2/dK0cUnV0IfSzGfi2mL20SwWDpTIUEegdDGOD0PxdbHPQzSxFLIX/tb6tsLkUETISg+qUyQdmBonG/1GLjj821gOCECpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736913; c=relaxed/simple;
	bh=dlh6bASO/LSpcl8bYIyBOBl0t/ZbRf5YHXTo0Kzd0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S47Ih44FY2GuSUf+67FPzFFmFUDZjE+qeajI3FJ9Qdhz7vZpO+ISP2riGhv0u5UQES/aH0/NHP5chNKc5tXc4PkCvsQDogObgpCfn36fGgJMJZZZJw8+Vz9QwMtNz/wsPDQCEdlgaqIY3mZYFznx/EKFj4blkBnT0cdky4VL0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aO0PLSK7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cUWCvxpi6yN02JYD/ezJBruMSnXyrEhd3rz8Me29Xlw=; b=aO0PLSK7qfu/FovGYhfLS+dQiM
	jWQuzAs6xPj0Vr0IjwVw3gv6cdQwoc9+Yx0NbvWRI8UwmV3c7fAmavCZLEpmQ0fLazJtH9JTTzKsd
	dKPLG6xN2203lxzeTq9E1Dbb5rC1mGh1yBwhX7Udq2kzTZFv4U5l+7cQNyN1bH5Oi5lt1OzsxGGJt
	ev+SQZ1it8FDnn78f3rejJBbFH8pFxn2JL9qhi3E3E4i0DFoLOMk2l7+YNkAmOUt3nJGwqmEu985C
	6CU8IGKWREZcvV/e4EXDexO8eXzXmqgvtbgvgAQfU0k6FkZf6Tk5bsKXfA+UWeAnCUbXNq4E3guDR
	QECPI58g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59300)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vMSXJ-000000007gY-3h78;
	Fri, 21 Nov 2025 14:54:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vMSXG-000000005Qf-0QYl;
	Fri, 21 Nov 2025 14:54:54 +0000
Date: Fri, 21 Nov 2025 14:54:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: move stmmac_mac_finish() after
 stmmac_mac_config()
Message-ID: <aSB9Pfd0cAd4CQgL@shell.armlinux.org.uk>
References: <E1vMNoX-0000000FTBd-3Oup@rmk-PC.armlinux.org.uk>
 <0423d36b-05fa-4a2b-858c-e6ef5ff1560d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0423d36b-05fa-4a2b-858c-e6ef5ff1560d@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 21, 2025 at 01:03:59PM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 21/11/2025 10:52, Russell King (Oracle) wrote:
> > Keep the functions and initialisers in the same order that they exist
> > in phylink_mac_ops. This is the preferred order for phylink methods
> > as it arranges the configuration methods by called order.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 970c670fc302..d16e522c1e7d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -932,7 +932,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
> >  	struct stmmac_priv *priv = netdev_priv(ndev);
> >  
> >  	if (priv->plat->mac_finish)
> > -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode, interface);
> > +		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> > +				       interface);
> 
> This is just a line wrap, I don't really see the connexion with the
> commit log :( Some missing hunks in the commit maybe ?

Oh, I thought I hadn't sent the patch, but I had... meanwhile I'd
updated my local copy to fix the line wrap, forgotten I'd done that,
rebased the patch and ended up with a patch with that description
but with only the reformatting. Bah. I'll move it out of patchwork.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

