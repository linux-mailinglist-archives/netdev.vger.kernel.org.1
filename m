Return-Path: <netdev+bounces-187249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F22AA5F17
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3972B171826
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75DEEBD;
	Thu,  1 May 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE8dhfOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE712DC76A;
	Thu,  1 May 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105351; cv=none; b=X02J6GbdCvwHdB2Z6uHO7S7D6+96P1mx7/oqya1Il5jE3WQq0raP9v++fNZt+0ZVJP8zitokzngGYH0snGFsxQsltjoA9e4GLLe+k1wTtObp/JXuoUgo8engYYT6a68Y+fo4fyqnSJ/KARgw8tIIs9RduDpReIBMczpvA6SLiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105351; c=relaxed/simple;
	bh=vG9RNDUsdMKUtcPNh3JTEqrqWWFL/iIruqjQNnXSe2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT9sQNf2pCmkEvdbtgsiu8n+E2W9zveLUYzPdYHRRa0kGsTqhVc4YXM7GpQwfFlok4DMxupXNh9xc4W3HRqXHU/JKYruRWuvPWsITpBt9MDE+hzBikxN44LcVoWx41AJgnEifdTkiWZ429a83o4V/8eFscGb1AW/bnec/XhImdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE8dhfOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E936C4CEE3;
	Thu,  1 May 2025 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746105350;
	bh=vG9RNDUsdMKUtcPNh3JTEqrqWWFL/iIruqjQNnXSe2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZE8dhfOB0DRQqBSkFEh7Qhc0AbapWsMOLtOEowe066a90UYLToaMHAjsN9EBiGjQ2
	 K+vcftRYrPjRsbUO11ldjBXnn5Vz9fL1XUX6dTANVJTxH/ykYg9IuOc/gqIFONvcqh
	 rcT/HkYnOzyOKQCIBXx34Z8f0iZLXDpFYlrXIWX2WHaDJypw2wCcc0v0C2CMJd9t1N
	 QbEjslSC2xs3IHPb+uRHRJWtP/47463ZTvcYoO77bZokGZNyn10q0dcIrsifSXlwOr
	 0OALCVuwygFsNMnIB0BE6dKtS4EP6AgUQj/YCpB6Uv8YpR/ReiutWFhC6ctxSQeyOU
	 wtD5/K+TKjWZg==
Date: Thu, 1 May 2025 06:15:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250501061548.38f7479b@kernel.org>
In-Reply-To: <20250430083220.5fba6c32@device-130.home>
References: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
	<20250422161717.164440-2-maxime.chevallier@bootlin.com>
	<20250424180333.035ff7d3@kernel.org>
	<20250430083220.5fba6c32@device-130.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 08:32:20 +0200 Maxime Chevallier wrote:
> > > +/* perphy ->dumpit() handler for GET requests. */
> > > +static int ethnl_perphy_dumpit(struct sk_buff *skb,
> > > +			       struct netlink_callback *cb)
> > > +{
> > > +	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> > > +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> > > +	int ret = 0;
> > > +
> > > +	if (ethnl_ctx->req_info->dev) {
> > > +		ret = ethnl_perphy_dump_one_dev(skb, ethnl_ctx->req_info->dev,
> > > +						ctx, genl_info_dump(cb));
> > > +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> > > +			ret = skb->len;
> > > +
> > > +		netdev_put(ethnl_ctx->req_info->dev,
> > > +			   &ethnl_ctx->req_info->dev_tracker);    
> > 
> > You have to release this in .done
> > dumpit gets called multiple times until we run out of objects to dump.
> > OTOH user may close the socket without finishing the dump operation.
> > So all .dumpit implementations must be "balanced". The only state we
> > should touch in them is the dump context to know where to pick up from
> > next time.  
> 
> Sorry for the delayed answer, I'm still wrapping my head around all
> this. calling netdev_put in dumpit() is not correct, but won't moving
> this into .done() make us subject to the scenario you described to me
> in another mail where userspace would stall the dump operation by not
> calling recv() ?

Good catch, for the filtered dump you'll need to look up the netdev
on every dumpit call.

