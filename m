Return-Path: <netdev+bounces-129834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CC98670B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A6E1C20C84
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F221428F3;
	Wed, 25 Sep 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dB4xz0D+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD2145324
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293137; cv=none; b=hB255/Uvf2SgCGl35AOLaVDZB0g8hMfULthGW/mRz6IAx2mfjg7Qy88Z8CsRkC/JOTIeVKVcD3dOI/2J/Fa1oR8lMamE+DNlsB0LNXhjlpfmJIMLY2fII7W7+4cLob51CjyAjG7h7KK/c8hAyzIfRuDgxyLiM0csTA/htHNR78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293137; c=relaxed/simple;
	bh=ScGp1WuPU1OKx2Ga8HODg6qs1dyhUw7LVDKDB8Dl9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMbe2hw9JP9qo8JC6iNxcVPbZnbuLbGPNHEgCE5qPr08CZ7ruYqmICV53DPCZdpgGA88th89NY/1sZGXjrUzzww0Ew0ppwmrnLHrdOuoUbRiLgG0STAjnL2QmoIoe/syvzvXeD65FWZzGiAe5+/4LLU9wLlk1nVvs/K3opVFzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dB4xz0D+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WjdEpakeAEueAFF38g825g9x6ZCC7yRWFkL/TDSCzf4=; b=dB4xz0D+ZLsZ8rRZRuHk2g7f0F
	om8LUD3GKpWwh2Fs3G+4EdP2q5XG9Yz8gjo2G7DEG1f4Bd1JMACALUonuEavPkLlVPPyA1xG2FS6I
	YcEPo0BdJgmWGPwQAGeRzveSDy9jrICmq+bDQ5kiaARL9eHZKgJwsXB2kqeA7motkxvr86YlPHUYE
	QdcJaeLGrMUYxDdgqpMGAjohUyzfCRInu5FqJo04rczLL1VDqd6fXb7t9VEUUJlPY6rEujKppCpu5
	9t7/oMgI0pqFFUtir6y1iPINXshZIY6vIePXkf3jyA+fmiGxzikOGI4H37jYDSI/nMe4GenncV4Zn
	fzc2N26g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35972)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1stXqJ-0007AJ-1I;
	Wed, 25 Sep 2024 20:38:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1stXqB-0007bY-1T;
	Wed, 25 Sep 2024 20:38:23 +0100
Date: Wed, 25 Sep 2024 20:38:23 +0100
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
Message-ID: <ZvRmr3aU1Fz6z0Oc@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>
 <20240925131517.s562xmc5ekkslkhp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925131517.s562xmc5ekkslkhp@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 25, 2024 at 04:15:17PM +0300, Vladimir Oltean wrote:
> On Mon, Sep 23, 2024 at 03:01:25PM +0100, Russell King (Oracle) wrote:
> > +static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
> > +				  int speed_mbps)
> >  {
> >  	struct sja1105_mac_config_entry *mac;
> > -	struct device *dev = priv->ds->dev;
> 
> I think if you could keep this line in the new sja1105_set_port_speed()
> function..
> 
> >  	u64 speed;
> > -	int rc;
> >  
> >  	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
> >  	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
> > @@ -1313,7 +1295,7 @@ static int sja1105_adjust_port_config(struct sja1105_private *priv, int port,
> >  		speed = priv->info->port_speed[SJA1105_SPEED_2500MBPS];
> >  		break;
> >  	default:
> > -		dev_err(dev, "Invalid speed %iMbps\n", speed_mbps);
> > +		dev_err(priv->ds->dev, "Invalid speed %iMbps\n", speed_mbps);
> 
> you could also get rid of this unnecessary line change.

Yes, maybe I'll move it to another patch, but the reason I made the
change is that I don't see much point to the local variable existing
for just one user (there were multiple users prior to this patch.)
However...

> >  		return -EINVAL;
> >  	}
> 
> There are 2 more changes which I believe should be made in sja1105_set_port_speed():
> - since it isn't called from mac_config() anymore but from mac_link_up()
>   (change which happened quite a while ago), it mustn't handle SPEED_UNKNOWN
> - we can trust that phylink will not call mac_link_up() with a speed
>   outside what we provided in mac_capabilities, so we can remove the
>   -EINVAL "default" speed_mbps case, and make this method return void,
>   as it can never truly cause an error
> 
> But I believe these are incremental changes which should be done after
> this patch. I've made a note of them and will create 2 patches on top
> when I have the spare time.

... if we were to make those changes prior to this patch, then the
dev_err() will no longer be there and thus this becomes a non-issue.
So I'd suggest a patch prior to this one to make the changes you state
here, thus eliminating the need for this hunk in this patch.

> > +/* Set link speed in the MAC configuration for a specific port. */
> 
> Could this comment state this instead? "Write the MAC Configuration
> Table entry and, if necessary, the CGU settings, after a link speed
> change for this port."

Done.

> > @@ -2293,7 +2294,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
> >  {
> >  	struct ptp_system_timestamp ptp_sts_before;
> >  	struct ptp_system_timestamp ptp_sts_after;
> > -	int speed_mbps[SJA1105_MAX_NUM_PORTS];
> > +	u64 mac_speed[SJA1105_MAX_NUM_PORTS];
> 
> Could you move this line lower to preserve the ordering by decreasing line length?
> 
> >  	u16 bmcr[SJA1105_MAX_NUM_PORTS] = {0};

Probably didn't notice that due to not having full clear sight for the
screen yet (a few more weeks to go before that happens!) Thanks for
spotting that.

> > -	/* Back up the dynamic link speed changed by sja1105_adjust_port_config
> > +	/* Back up the dynamic link speed changed by sja1105_set_port_speed
> 
> Could you please put () after the function name? I know the original
> code did not have it, but my coding style has changed in the past 5 years.

Done.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

