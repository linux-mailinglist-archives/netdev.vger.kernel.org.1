Return-Path: <netdev+bounces-178875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B3A794C6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CD43AD39B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2F19005D;
	Wed,  2 Apr 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tlBGkHXJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896721E89C
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616937; cv=none; b=gEHqzPGYz9zaG6leI2ySo0I5zeS0lEO69YNk6KeA9CCae9NEWORGG/u6AX7TnqbQT8m9jtFzt9csRIzt9kIqcjTgILvimpfgLvcTDgLrrmeuf77nqxCwmNiluVq/gs9cpuSLGd5KwkbXFCi9bLRIfLKdEP5U6yb0zeknwRbH5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616937; c=relaxed/simple;
	bh=gYczceAqHzDk2ELbVcTJSWecBAjZGC23tqtmFSHUBfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLliQF2jI+2SxgcfV6L1KsBfr8N5ZFPnhFx7oIEswN2obVERRNTuBEhxb+Sa6VZLXhCV/dcUOyU0peHnJZfXKwe1Ormnw6M6EgcMetg0kgk34DFkdl207IOVn3lX6/Np52UN95GJrWOKWeFHmpoebSA3QZ3mVlVTQurhRD22ER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tlBGkHXJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZxnsPdg0hx1/3ld6mtD7WZtnwL/QnwlLJacCHW01Akk=; b=tlBGkHXJGXCU2kO+p3Nmj6RdxI
	BIz+D3oLfBermYX1JV4e5VJLpMGJVABIYGY292BS+I36HXSiezO/ka6+kIRddFhI90ELE5egGUTju
	Y6utzYOhVqjWNZtj9Qyi0u3FtF9cQdjMMBmZw32GTRze5vYcV3ZgJOcxlKeN8vmxW5oUskavu8230
	J5qbjK6WpFm1/kwTIfJAewJ+c64Jj1snufBXHCBlSuwcvpv4s5PVfKfKhP/wmP7gI0upUxBqb0pA3
	f/vI+kVHxve2iFOToWWzqUfUjHJj76y2ZPtD2OjlbhbvgmxOTGQ3tm0mr+9D7llsLz0OVprQixX0/
	fuOoWFkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41976)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u02Ph-0007y9-21;
	Wed, 02 Apr 2025 19:02:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u02Pf-0003ui-0B;
	Wed, 02 Apr 2025 19:02:07 +0100
Date: Wed, 2 Apr 2025 19:02:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Subject: Re: [net PATCH 2/2] net: phylink: Set advertising based on
 phy_lookup_setting in ksettings_set
Message-ID: <Z-17nu2epjG1EiAd@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354301312.26800.4565150748823347100.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174354301312.26800.4565150748823347100.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 01, 2025 at 02:30:13PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> While testing a driver that supports mulitple speeds on the same SFP module
> I noticed I wasn't able to change them when I was not using
> autonegotiation. I would attempt to update the speed, but it had no effect.
> 
> A bit of digging led me to the fact that we weren't updating the advertised
> link mask and as a result the interface wasn't being updated when I
> requested an updated speed. This change makes it so that we apply the speed
> from the phy settings to the config.advertised following a behavior similar
> to what we already do when setting up a fixed-link.
> 
> Fixes: ea269a6f7207 ("net: phylink: Update SFP selected interface on advertising changes")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/phy/phylink.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 380e51c5bdaa..f561a803e5ce 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2763,6 +2763,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
>  
>  		config.speed = c->speed;
>  		config.duplex = c->duplex;
> +		linkmode_and(config.advertising, c->linkmodes, pl->supported);

I had thought that ethtool provided an appropriate advertising mask
when aneg is disabled, but it just preserves the old mask, which seems
to be the intended behaviour (if one looks at phylib, that's also what
happens there.) We should not deviate from that with a user API.

So, I would like to change how this works somewhat to avoid a user
visible change. Also, interface mode changing on AUTONEG_DISABLED was
never intended to work. Indeed, mvneta and mvpp2 don't support
AUTONEG_DISABLED for 1000BASE-X nor 2500BASE-X which is where this
interface switching was implemented (for switching between these two.)

I've already got rid of the phylink_sfp_select_interface() usage when
a module is inserted (see phylink_sfp_config_optical(), where we base
the interface selection off interface support masks there rather than
advertisements - it used to be advertisements.)

We now have phylink_interface_max_speed() which gives the speed of
the interface, which gives us the possibility of doing something
like this for the AUTONEG_DISABLE state:

	phy_interface_and(interfaces, pl->config->supported_interfaces,
			  pl->sfp_interfaces);

	best_speed = SPEED_UNKNOWN;
	best_interface = PHY_INTERFACE_MODE_NA;

	for_each_set_bit(interface, interfaces, __ETHTOOL_LINK_MODE_MASK_NBITS) {
		max_speed = phylink_interface_max_speed(interface);
		if (max_speed < config.speed)
			continue;
		if (max_speed == config.speed)
			return interface;
		if (best_speed == SPEED_UNKNOWN ||
		    max_speed < best_speed) {
			best_speed = max_speed;
			best_interface = interface;
		}
	}

	return best_interface;

to select the interface from aneg-disabled state.

Do you think that would work for you?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

