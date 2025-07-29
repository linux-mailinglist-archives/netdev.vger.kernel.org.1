Return-Path: <netdev+bounces-210746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C68B14A64
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175B03A31CE
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128F284B42;
	Tue, 29 Jul 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w9hTs92Q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEC221FD0
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778886; cv=none; b=pCTRxHkyPGdTAnPnXeQ+ryTcAidKXHfLltmsH6lgLlhc4DjJS+Xy4qVjcQFBn+xwpIsI4z3aNoixv7Isz7ObmsdWUDazvymXO1oRlVPZifbLIqg93rPGb/j+N2Kmgwl0jp49rYbtIzeVh/Sfr7cW8KwP8HsdW+SU8egczU9OBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778886; c=relaxed/simple;
	bh=tyYuT4uDzx3BJT+IF5rTiFFudkRf52hYO6lYK9ugZow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRWPTxBDJOqqTKz3FoI3EardsTGuFBlqYDBUdQ+tzc35HiKKyd/+i7X4hN/E8XbovoYjYIFXH3qgrZGb5vMO7frb9hMntJjl+k8NZHYQgBtZtJsHJeTzeso11nY5A7Y9UEVtKfuQ4UBf01G9cBDOEl/nqCJvTB96AbBP9Qrzvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w9hTs92Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P7oOJG5KTLIajgCuDI26bWwy2UJFAttGvQUBB26YlI0=; b=w9hTs92QWrfKsmkOfTZU3IzEK9
	/NKQF8UfFxhlytprmFOCd75wSELHVG+RUGnz4wM7Dx+2BPss78SGmtPdHHKqXTVoV+8J/kyMTLg/I
	hRViRpc1b1w3DMsWnVpCv6p54buc+jEfs+NYmwP4vuf7807MxGJTSNKyACuKF7NsdLYmIeK/zwHhi
	6rTY9HECZiKlsvCvt5yr4ekE9YHDNY01jZOJ1qgJQQMG36r0aFS4MlX9ZudxvFrYkCa2Z9Kux6Z8z
	zaUq7ikJI+pkp1WYuCTMqBTlJM0X1inAtGKp0jvRfT3AF6NHz39TTUui2BCr/k4YynT5kjqW0JN+N
	+vUvWBFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47240)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ugg04-0001bH-0U;
	Tue, 29 Jul 2025 09:47:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ugg01-0007G2-2s;
	Tue, 29 Jul 2025 09:47:53 +0100
Date: Tue, 29 Jul 2025 09:47:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 7/7] net: stmmac: explain the
 phylink_speed_down() call in stmmac_release()
Message-ID: <aIiKuVwyzR4ZSitl@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ38-006KDX-RT@rmk-PC.armlinux.org.uk>
 <b612eaee-17f2-4cab-bc37-a1cb9560ffe1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b612eaee-17f2-4cab-bc37-a1cb9560ffe1@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 28, 2025 at 07:29:09PM +0200, Andrew Lunn wrote:
> On Mon, Jul 28, 2025 at 04:46:02PM +0100, Russell King (Oracle) wrote:
> > The call to phylink_speed_down() looks odd on the face of it. Add a
> > comment to explain why this call is there.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index f44f8b1b0efa..0da5c29b8cb0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4138,8 +4138,13 @@ static int stmmac_release(struct net_device *dev)
> >  	struct stmmac_priv *priv = netdev_priv(dev);
> >  	u32 chan;
> >  
> > +	/* If the PHY or MAC has WoL enabled, then the PHY will not be
> > +	 * suspended when phylink_stop() is called below. Set the PHY
> > +	 * to its slowest speed to save power.
> > +	 */
> >  	if (device_may_wakeup(priv->device))
> >  		phylink_speed_down(priv->phylink, false);
> > +
> 
> Is there a corresponding phylink_speed_up() somewhere else? Does that
> need a similar comment?

__stmmac_open() does:

        phylink_start(priv->phylink);
        /* We may have called phylink_speed_down before */
        phylink_speed_up(priv->phylink);

So yes, there is a corresponding call, and it's unconditional, so such
a comment there wouldn't make sense.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

