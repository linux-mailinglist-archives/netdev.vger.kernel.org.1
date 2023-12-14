Return-Path: <netdev+bounces-57585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F507813855
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D2D1F21605
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6F65EBF;
	Thu, 14 Dec 2023 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QS325jey"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985CB2
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gQRcqD+oO5SxNU1D/n416RLrhl0dHK82hC/Rdojs4QA=; b=QS325jey6fGnw48/3mG3d9nEa6
	dWFMer+GFEAf08zqSZf31dBnu3HblZNK8lGdcaFuYx6Q32mYmvl0Yg+M4dJbRjedGKVA7pvCQOo5F
	Z6dQMMT4XGlDZwV5euOu2+g8ENiDfHRIiZuWWL+JXlm++icgW8axM5QoT2NRCbLpS7rMINMOjE+tT
	K5T+j4szY+kgO5HOAub+T4uxFFmVOaRYh7IKG3OmhAWVmajrXQrvwIRLB3Ah6LSxopjFa5o1R3ARc
	dIfhaW5pFKDYDybyLGFVp3hbi+wOK8aZup5IqC9zYU8AfwwSz1iw/ZcOtn2E621+7il448tz1sWnU
	NgDVJDNg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33014)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDpM1-0001l0-2p;
	Thu, 14 Dec 2023 17:18:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDpM3-0002jG-TM; Thu, 14 Dec 2023 17:18:35 +0000
Date: Thu, 14 Dec 2023 17:18:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next] net: phylink: avoid one unnecessary
 phylink_validate() call during phylink_create()
Message-ID: <ZXs467Epke85f0Im@shell.armlinux.org.uk>
References: <20231214170659.868759-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214170659.868759-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

I'll say this for the benefit of the netdev developers - my time is
currently being spent elsewhere (e.g. ARM64 VCPU hotplug) so I don't
have a lot of time to review netdev patches. With only a few days
left to Christmas vacations and my intention not to work over that
period, this means that I'm unlikely to be able to review changes
such as this - and they do need review.

If I get some spare time, then I will review them.

However, probably best to wait until the new year before sending
patches that touch phylink - which will involve adding stress on my
side.

Thanks.

On Thu, Dec 14, 2023 at 07:06:59PM +0200, Vladimir Oltean wrote:
> The direct phylink_validate() call from phylink_create() is partly
> redundant, since there will be subsequent calls to phylink_validate()
> issued by phylink_parse_mode() for MLO_AN_INBAND, and by
> phylink_parse_fixedlink() for MLO_AN_FIXED. These will overwrite what
> the initial phylink_validate() call already did.
> 
> The only exception is MLO_AN_PHY, for which phylink_validate() might be
> called with a slight delay (the timing of the phylink_bringup_phy() call
> is not under phylink's control). User space could issue
> phylink_ethtool_ksettings_get() calls before phylink_bringup_phy(), and
> could thus see an empty pl->supported, which this early phylink_validate()
> call prevents.
> 
> So we can delay the direct phylink_create() -> phylink_validate() call
> until after phylink_parse_mode() and phylink_parse_fixedlink(), and execute
> it only for the mode where it makes any difference at all - MLO_AN_PHY.
> 
> This has the benefit that we issue one phylink_validate() call less, for
> some deployments. The visible output remains unchanged in all cases.
> 
> Link: https://lore.kernel.org/netdev/20231004222523.p5t2cqaot6irstwq@skbuf/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> The other, non-immediate benefit has to do with potential future API
> extensions. With this change, pl->cfg_link_an_mode is now parsed and
> available to phylink every time phylink_validate() is called. So it is
> possible to pass it to pcs_validate(), if that ever becomes necessary,
> for example with the introduction of a separate MLO_AN_* mode for clause
> 73 auto-negotiation (i.e. in-band selection of state->interface).
> 
> I don't think this extra information should go into the commit message,
> since these plans may or may not materialize. They are just extra
> information to give reviewers context. The change is useful even if the
> plans do not materialize.
> 
>  drivers/net/phy/phylink.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 4adf8ff3ac31..65bff93b1bd8 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1620,10 +1620,6 @@ struct phylink *phylink_create(struct phylink_config *config,
>  	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
>  	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
>  
> -	linkmode_fill(pl->supported);
> -	linkmode_copy(pl->link_config.advertising, pl->supported);
> -	phylink_validate(pl, pl->supported, &pl->link_config);
> -
>  	ret = phylink_parse_mode(pl, fwnode);
>  	if (ret < 0) {
>  		kfree(pl);
> @@ -1636,6 +1632,17 @@ struct phylink *phylink_create(struct phylink_config *config,
>  			kfree(pl);
>  			return ERR_PTR(ret);
>  		}
> +	} else if (pl->cfg_link_an_mode == MLO_AN_PHY) {
> +		/* phylink_bringup_phy() will recalculate pl->supported with
> +		 * information from the PHY, but it may take a while until it
> +		 * is called, and we should report something to user space
> +		 * until then rather than nothing at all, to avoid issues.
> +		 * Just report all link modes supportable by the current
> +		 * phy_interface_t and the MAC capabilities.
> +		 */
> +		linkmode_fill(pl->supported);
> +		linkmode_copy(pl->link_config.advertising, pl->supported);
> +		phylink_validate(pl, pl->supported, &pl->link_config);
>  	}
>  
>  	pl->cur_link_an_mode = pl->cfg_link_an_mode;
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

