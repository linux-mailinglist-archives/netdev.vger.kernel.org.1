Return-Path: <netdev+bounces-85312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF8889A26D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AD7283FE9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064816FF4B;
	Fri,  5 Apr 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ADT9PwQT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F04171086
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334246; cv=none; b=pR1/lkGfhU0Z2xInzHRVgx1RXeJOEhTeTggo+YjK0ouQ+CzkfxO1N/sAIelIKl2pNWK/KPgsHXf2EGsPipqjZLU2xd90ncwQiR6rYLweJCikSEnQnJbr8IXB/EGi8NpUVvq1HtT9VGMIoPlmAyFvDjOmeqBcovm0aRAeshmg1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334246; c=relaxed/simple;
	bh=tgY6atk0yb1/mbWX32UKF+DBy+asAtZ9eUVnvpD6MI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9GMHoAGx5egYhIewOZGhIziEtuN5iIUYy7m5PqoUkbo6LYmfadhOb5w8ZasHJ+Zh1uiH9fvWUnj8cw9fpw0Pzn1SQuh08AUguOL2mY5xh1oUWKeP7UcvvS19Rs/+a+oFERbVxyK8KemQWhAyMgH6SBYA1QO2PZP8zWfiV80erw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ADT9PwQT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BQT4MjIGz4qm2BkBBD6iExq2GzhEG9nvf782Gwn6ql8=; b=ADT9PwQTCpDrEQCTZr/DrDeCSY
	USejWWvexaGp80QjMAHJqSjLViw37XVrHra/CFy/1WGPWsiwhbGNGyE+xzTmiqatqoNIwXybqPgTh
	NfHiCPYTXalLe6I7IWtGjMu91DCr61QRdqKJCo7wyev+sSrA6PZ4AP/lpmN0MpIKk2tKFdJlQjdxI
	7rs6gsY3IzIXLj7Dkaq3OaT6Fjs5BSw+g8ppzeeriIp6i5zi3WOdeMYI39TEZPbmeJIPaOrlm0CWV
	+Z8BiqaCMMiMVweD5pHPdDnnwdHjrCXzNkgMaTgl/tGWpQMxRoT2sJ5TQxJz8p+7U7VXYDSECIOUs
	8CzqwVhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38788)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rsmM7-0002ct-0J;
	Fri, 05 Apr 2024 17:23:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rsmM5-0001Ve-Qj; Fri, 05 Apr 2024 17:23:53 +0100
Date: Fri, 5 Apr 2024 17:23:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <ZhAlmRQ0pz+ibqGB@shell.armlinux.org.uk>
References: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
 <E1rs1Rp-005g7S-3j@rmk-PC.armlinux.org.uk>
 <20240405162100.5iy2k66bqnhprej4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405162100.5iy2k66bqnhprej4@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 05, 2024 at 07:21:00PM +0300, Vladimir Oltean wrote:
> On Wed, Apr 03, 2024 at 03:18:41PM +0100, Russell King (Oracle) wrote:
> > diff --git a/net/dsa/port.c b/net/dsa/port.c
> > index 02bf1c306bdc..4cafbc505009 100644
> > --- a/net/dsa/port.c
> > +++ b/net/dsa/port.c
> > @@ -1662,6 +1662,7 @@ static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
> >  
> >  int dsa_port_phylink_create(struct dsa_port *dp)
> >  {
> > +	const struct phylink_mac_ops *mac_ops;
> >  	struct dsa_switch *ds = dp->ds;
> >  	phy_interface_t mode;
> >  	struct phylink *pl;
> > @@ -1685,8 +1686,12 @@ int dsa_port_phylink_create(struct dsa_port *dp)
> >  		}
> >  	}
> >  
> > -	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
> > -			    mode, &dsa_port_phylink_mac_ops);
> > +	mac_ops = &dsa_port_phylink_mac_ops;
> > +	if (ds->phylink_mac_ops)
> > +		mac_ops = ds->phylink_mac_ops;
> > +
> > +	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
> > +			    mac_ops);
> >  	if (IS_ERR(pl)) {
> >  		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
> >  		return PTR_ERR(pl);
> > -- 
> > 2.30.2
> > 
> 
> This is not sufficient. We will have to make DSA call the driver through
> the mac_ops it provides, rather than through ds->ops, here:
> 
> dsa_shared_port_link_register_of()
> 
> 	if (!ds->ops->adjust_link) {
> 		if (missing_link_description) {
> 			dev_warn(ds->dev,
> 				 "Skipping phylink registration for %s port %d\n",
> 				 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
> 		} else {
> 			if (ds->ops->phylink_mac_link_down)
> 				ds->ops->phylink_mac_link_down(ds, port,
> 					MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
> 			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 			return dsa_shared_port_phylink_register(dp);
> 		}
> 		return 0;
> 	}
> 
> Coincidentally mv88e6xxx is exactly one of those drivers which needs the
> early mac_link_down() call that isn't driven by phylink.

Thanks for the review, I'd forgotten that this path exists!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

