Return-Path: <netdev+bounces-151438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A064D9EEEEE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DADB166BAF
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807AF22333A;
	Thu, 12 Dec 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jdG5GLlq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C225223C49;
	Thu, 12 Dec 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019008; cv=none; b=Uyxir5MpmNAgP0lqQ7omCmrNUx0zz2bprd/xIx5II8CE1iVcxyGNAjDsHssOXKfwJm/1W453LKvT9FsmXSEJsWEwidmzYZVD7rgXhG14GH6leBTclJ4aDlwvrenhF35H1ETFw/IC0fjorEbtnh5+FaaqjfE1vKwp2KKH78vgwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019008; c=relaxed/simple;
	bh=viU2z5ww8SGpckEb5uDkQ/hhkagL4yv7HyEWdggMAYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1F/n7xolBNarlbGEPCBEEZKVVwTqltGNO25cWAsV3x136NCpiztZR2hwDVkoYhtaG4jSoH6iKDw3wU2CmnJRO9upazRUz92HCGVG+jZfsu8sF8LeZiOQlhpVzICeoW+RInYzR17VU8ZQCTa4GJaTqHMbXLq5oFVH6TDIkyN9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jdG5GLlq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YFoc339tueLvMa87D9wphRrOL+Jf750+sCI4ejb2O2w=; b=jdG5GLlqv715NSU8j27fuWpLHW
	kigi2RfcQvZ4u/uRVVfbY51jyao9dxnDsZj9o9m6Q7FDMQlxGaAuov2VQ+Ocx9QRKFXWyJU2h0Jej
	MXEE7SoYtYUY4ehVa2o34aNo9sO7xCL7YMAeaigzSwQMYQIx4YGR32l0BQ4ltouwiDZlcsZ0dxk6d
	XTOH0AOfcJZWkIqFIBTdo48ENeghKuw2m2euy1a4hdbD9b1YIC/knJzidbDcqDVQMMt/8g7yLY8MO
	wWvDOyTCsXwV3EWJ4nVKXrVkxeRsPv9uIK94Kqe+VrVNwseCgg5sEMuc2XnSulQxO3GT/EEuaiLSE
	w/dXEV9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46612)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLlYP-0005Rx-0u;
	Thu, 12 Dec 2024 15:56:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLlYM-0005RO-0B;
	Thu, 12 Dec 2024 15:56:38 +0000
Date: Thu, 12 Dec 2024 15:56:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: dsa: sja1105: let phylink help with
 the replay of link callbacks
Message-ID: <Z1sHtZXuOvJe3Ruu@shell.armlinux.org.uk>
References: <20241003140754.1229076-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003140754.1229076-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 03, 2024 at 05:07:53PM +0300, Vladimir Oltean wrote:
> sja1105_static_config_reload() changes major settings in the switch and
> it requires a reset. A use case is to change things like Qdiscs (but see
> sja1105_reset_reasons[] for full list) while PTP synchronization is
> running, and the servo loop must not exit the locked state (s2).
> Therefore, stopping and restarting the phylink instances of all ports is
> not desirable, because that also stops the phylib state machine, and
> retriggers a seconds-long auto-negotiation process that breaks PTP.

However:

> ptp4l[54.552]: master offset          5 s2 freq    -931 path delay       764
> ptp4l[55.551]: master offset         22 s2 freq    -913 path delay       764
> ptp4l[56.551]: master offset         13 s2 freq    -915 path delay       765
> ptp4l[57.552]: master offset          5 s2 freq    -919 path delay       765
> ptp4l[58.553]: master offset         13 s2 freq    -910 path delay       765
> ptp4l[59.553]: master offset         13 s2 freq    -906 path delay       765
> ptp4l[60.553]: master offset          6 s2 freq    -909 path delay       765
> ptp4l[61.553]: master offset          6 s2 freq    -907 path delay       765
> ptp4l[62.553]: master offset          6 s2 freq    -906 path delay       765
> ptp4l[63.553]: master offset         14 s2 freq    -896 path delay       765
> $ ip link set br0 type bridge vlan_filtering 1
> [   63.983283] sja1105 spi2.0 sw0p0: Link is Down
> [   63.991913] sja1105 spi2.0: Link is Down
> [   64.009784] sja1105 spi2.0: Reset switch and programmed static config. Reason: VLAN filtering
> [   64.020217] sja1105 spi2.0 sw0p0: Link is Up - 1Gbps/Full - flow control off
> [   64.030683] sja1105 spi2.0: Link is Up - 1Gbps/Full - flow control off
> ptp4l[64.554]: master offset       7397 s2 freq   +6491 path delay       765
> ptp4l[65.554]: master offset         38 s2 freq   +1352 path delay       765
> ptp4l[66.554]: master offset      -2225 s2 freq    -900 path delay       764
> ptp4l[67.555]: master offset      -2226 s2 freq   -1569 path delay       765
> ptp4l[68.555]: master offset      -1553 s2 freq   -1563 path delay       765
> ptp4l[69.555]: master offset       -865 s2 freq   -1341 path delay       765
> ptp4l[70.555]: master offset       -401 s2 freq   -1137 path delay       765
> ptp4l[71.556]: master offset       -145 s2 freq   -1001 path delay       765

doesn't this change in offset and frequency indicate that the PTP clock
was still disrupted, and needed to be re-synchronised? If it was
unaffected, then I would have expected the offset and frequency to
remain similar to before the reset happened.

Nevertheless...

> @@ -1551,7 +1552,8 @@ static void phylink_resolve(struct work_struct *w)
>  	}
>  
>  	if (mac_config) {
> -		if (link_state.interface != pl->link_config.interface) {
> +		if (link_state.interface != pl->link_config.interface ||
> +		    pl->force_major_config) {
>  			/* The interface has changed, force the link down and
>  			 * then reconfigure.
>  			 */
> @@ -1561,6 +1563,7 @@ static void phylink_resolve(struct work_struct *w)
>  			}
>  			phylink_major_config(pl, false, &link_state);
>  			pl->link_config.interface = link_state.interface;
> +			pl->force_major_config = false;
>  		}
>  	}

This will delay the major config until the link comes up, as mac_config
only gets set true for fixed-link and PHY when the link is up. For
inband mode, things get less certain, because mac_config will only be
true if there is a PHY present and the PHY link was up. Otherwise,
inband leaves mac_config false, and thus if force_major_config was
true, that would persist indefinitely.

> +/**
> + * phylink_replay_link_begin() - begin replay of link callbacks for driver
> + *				 which loses state
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * Helper for MAC drivers which may perform a destructive reset at runtime.
> + * Both the own driver's mac_link_down() method is called, as well as the
> + * pcs_link_down() method of the split PCS (if any).
> + *
> + * This is similar to phylink_stop(), except it does not alter the state of
> + * the phylib PHY (it is assumed that it is not affected by the MAC destructive
> + * reset).
> + */
> +void phylink_replay_link_begin(struct phylink *pl)
> +{
> +	ASSERT_RTNL();
> +
> +	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);

I would prefer this used a different disable flag, so that...

> +}
> +EXPORT_SYMBOL_GPL(phylink_replay_link_begin);
> +
> +/**
> + * phylink_replay_link_end() - end replay of link callbacks for driver
> + *			       which lost state
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * Helper for MAC drivers which may perform a destructive reset at runtime.
> + * Both the own driver's mac_config() and mac_link_up() methods, as well as the
> + * pcs_config() and pcs_link_up() method of the split PCS (if any), are called.
> + *
> + * This is similar to phylink_start(), except it does not alter the state of
> + * the phylib PHY.
> + *
> + * One must call this method only within the same rtnl_lock() critical section
> + * as a previous phylink_replay_link_start().
> + */
> +void phylink_replay_link_end(struct phylink *pl)
> +{
> +	ASSERT_RTNL();
> +
> +	pl->force_major_config = true;
> +	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);

this can check that phylink_replay_link_begin() was previously called
to catch programming errors. There shouldn't be any conflict with
phylink_start()/phylink_stop() since the RTNL is held, but I think
its still worth checking that phylink_replay_link_begin() was
indeed called previously.

Other than those points, I think for sja1105 this is a better approach,
and as it's lightweight in phylink, I don't think having this will add
much maintenance burden, so I'm happy with the approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

