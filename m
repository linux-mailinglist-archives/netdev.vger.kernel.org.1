Return-Path: <netdev+bounces-125230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E996C59F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BD41C220B8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11491D88BF;
	Wed,  4 Sep 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iS+NWWZ/"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192984A27;
	Wed,  4 Sep 2024 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471918; cv=none; b=XMlZbSDTqgHfNJHtDgPwEsGqcokJY8n6HQ65OEQw0zfKApTwzXrRAuaXFqKK+GNc+Wurr3Evxn87+gix/XMkERwqMCXd8bNrl7qq/GBkBNhS6z9DrZNurfE+meGkO1pBEyntax3xEFCLUceeQHryGih7W627ldWi1HlJBcL6KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471918; c=relaxed/simple;
	bh=bvzUcP1tYrdFCtBGn4lYsTRlG+3Ph+qu3SH9Bn2FN9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOI8dsN2A4pI7mWw96l/HfheKLgaR7ch0dw/TuEC7Uf04IfEu08qsnT/dLfGwVjZyENCdlnN2YHeoirqX0T3o389ZzxF0Yz1tAeVfr4BNh6XTelzT/f5dKouYgHQLO/ICg7oH0WQCw3e7np23ar1+N12QDx6+GlH0sE5bW+6AIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iS+NWWZ/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1CA360006;
	Wed,  4 Sep 2024 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725471907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR+gSSCn3dh6Z4eIR/edtipFavfpSPefYQsgu2j7UZY=;
	b=iS+NWWZ/SZprfKVKBgY2M02Zhh59DjlhlAmWMUvyq0NF0NJkMe6NDx7sxUNHP+dqvdHegm
	eAqK3Qhz4Jxc5JPKRMU50I59tybX9l6M8lZ3JQsnhTGq5ogfRQWh7QNMnVoWjtUpR4mBlq
	8Y+xBGOQJCV/fdEuJJxiJwJPB08tR3efumrAgrzSTX6bJemTsg0SGuDlMzXX+4ESgWOkCq
	3SLOuPMzzQ0aCM5vLjC1cHjFrxNVDdQcQ1nCWwi4LH5DP+ZBRHFVLIP2yvGiyzrWhe0hlg
	Zq2DYkhjJAuz7Yr2ssOD0YfYHW/1V6sPoYyO591j7gsPNzY4TRZB7G3KwlLCwA==
Date: Wed, 4 Sep 2024 19:45:04 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jonathan Corbet
 <corbet@lwn.net>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ethtool-next v2 2/3] ethtool: Allow passing a PHY index
 for phy-targetting commands
Message-ID: <20240904194504.44071f11@fedora.home>
In-Reply-To: <bwh3s7vcingnkhnnvucak656sj2u2vikwupysgihvfdcshixtf@nymosaa2eth6>
References: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
	<20240828152511.194453-3-maxime.chevallier@bootlin.com>
	<bwh3s7vcingnkhnnvucak656sj2u2vikwupysgihvfdcshixtf@nymosaa2eth6>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Michal,

On Mon, 2 Sep 2024 00:04:39 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Wed, Aug 28, 2024 at 05:25:09PM +0200, Maxime Chevallier wrote:
> > With the introduction of PHY topology and the ability to list PHYs, we
> > can now target some netlink commands to specific PHYs. This is done by
> > passing a PHY index as a request parameter in the netlink GET command.
> > 
> > This is useful for PSE-PD, PLCA and Cable-testing operations when
> > multiple PHYs are on the link (e.g. when a PHY is used as an SFP
> > upstream controller, and when there's another PHY within the SFP
> > module).
> > 
> > Introduce a new, generic, option "--phy N" that can be used in
> > conjunction with PHY-targetting commands to pass the PHY index for the
> > targetted PHY.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  ethtool.8.in         | 20 +++++++++++++++++
> >  ethtool.c            | 25 ++++++++++++++++++++-
> >  internal.h           |  1 +
> >  netlink/cable_test.c |  4 ++--
> >  netlink/msgbuff.c    | 52 ++++++++++++++++++++++++++++++++++----------
> >  netlink/msgbuff.h    |  3 +++
> >  netlink/nlsock.c     |  3 ++-
> >  netlink/plca.c       |  4 ++--
> >  netlink/pse-pd.c     |  4 ++--
> >  9 files changed, 96 insertions(+), 20 deletions(-)
> >   
> [...]
> > @@ -6550,6 +6559,16 @@ int main(int argc, char **argp)
> >  			argc -= 1;
> >  			continue;
> >  		}
> > +		if (*argp && !strcmp(*argp, "--phy")) {
> > +			char *eptr;
> > +
> > +			ctx.phy_index = strtoul(argp[1], &eptr, 0);
> > +			if (!argp[1][0] || *eptr)
> > +				exit_bad_args();
> > +			argp += 2;
> > +			argc -= 2;
> > +			continue;
> > +		}
> >  		break;
> >  	}
> >  	if (*argp && !strcmp(*argp, "--monitor")) {  
> 
> Could we have a meaningful error message that would tell user what was
> wrong instead?

Good point, I'll add one.

> 
> > @@ -6585,6 +6604,10 @@ int main(int argc, char **argp)
> >  	}
> >  	if (ctx.json && !args[k].json)
> >  		exit_bad_args_info("JSON output not available for this subcommand");
> > +
> > +	if (!args[k].targets_phy && ctx.phy_index)
> > +		exit_bad_args();
> > +
> >  	ctx.argc = argc;
> >  	ctx.argp = argp;
> >  	netlink_run_handler(&ctx, args[k].nlchk, args[k].nlfunc, !args[k].func);  
> 
> Same here.

Indeed, I'll update accordingly.

[...]

> > @@ -159,7 +151,9 @@ bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
> >  	if ((devname &&
> >  	     ethnla_put_strz(msgbuff, ETHTOOL_A_HEADER_DEV_NAME, devname)) ||
> >  	    (flags &&
> > -	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)))
> > +	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)) ||
> > +	    (phy_index &&
> > +	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_PHY_INDEX, phy_index)))
> >  		goto err;
> >  
> >  	ethnla_nest_end(msgbuff, nest);  
> 
> Just to be sure: are we sure the PHY index cannot ever be zero (or that
> we won't need to pass 0 index to kernel)?

I should better document that, sorry... The phy index assigned starts
at 1 at wraps-around back to 1 when we exhausted the indices, so it
can't ever be 0.

The netlink code in the kernel side interprets the fact that userspace
passes 0 as "use the default PHY", as if you didn't pass the parameter :

net/ethtool/netlink.c:

	if (!req_info->phy_index)
		return req_info->dev->phydev;

I'll send a patch to document that behaviour, thanks for pointing this
out.

Maxime

