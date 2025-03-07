Return-Path: <netdev+bounces-172986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B5A56B94
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9C23ACF08
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60521D3EA;
	Fri,  7 Mar 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP3O49lT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4E21B9DA;
	Fri,  7 Mar 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360457; cv=none; b=Rmqsq83U3nWfnZ6lddBhejmOOh4ouyqUqiywLcXlhZls3CHbJplnYw9FltfRJR2+Yiovdl0eqa9aNMMkkkafq9zs7AOeS55oLvvHJubzAWWnc92pGa6v7yqCIzb6hrpUktKOTNleqLQWQ9uedDegiSnwR4S3Ikl3wnl1kM/2EEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360457; c=relaxed/simple;
	bh=umsaWF2jkAUH5epAcAYe4Rwh8ZURewWs90LsiduN1og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcPo8RSsqmzhpCHX8uBPKjN7RvnNbdkfLSrgqWRRQtele65CiFBRVdO5lpWdO/4MR4tQUeI6shazi/hCTb0wx1+jDBDyRBPPUgLTrXF7WLF1CkMnYDqNYCegtt2I+jEfM6N8Bvl3R+s2H7WjLTDrSHxqoVtGEQWg4vPl4giUpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP3O49lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05E5C4CEF8;
	Fri,  7 Mar 2025 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741360456;
	bh=umsaWF2jkAUH5epAcAYe4Rwh8ZURewWs90LsiduN1og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fP3O49lTMhH/bbfeIsgTB3q8YTREC4rz+pSHVu9sK55nGpQby3oFEmE//RJrgDVUG
	 VWKSKJ7gitZermCbYbNXjJhA8fG0XhXswR8cES1fpqjH1NrMMsRFQaOMgOjDZDjq9q
	 mCE3cdtNf3prA9Ufj/z98FzuVF4eWp9NkwVziwX5bZ2/AKRqCSh11ALYtze4MomcB8
	 LWXis6vmyRDd+mK0IQ+kJUV3Fc3idIVkOMink99dQv/SWVb5yv5CbbxwY3VsE1K+MJ
	 K+7Dx3n/surWG08UEv+1OvsVOEuBTgpMWrL0K0WjvtXEK/Vitqn1N20pQzqKduypWZ
	 I5/VZ5SN3FwWQ==
Date: Fri, 7 Mar 2025 15:14:09 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next 1/7] net: ethtool: netlink: Allow per-netdevice
 DUMP operations
Message-ID: <20250307151409.GJ3666230@kernel.org>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
 <20250305141938.319282-2-maxime.chevallier@bootlin.com>
 <20250307122119.GE3666230@kernel.org>
 <20250307141819.55e42ccd@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307141819.55e42ccd@fedora.home>

On Fri, Mar 07, 2025 at 02:18:19PM +0100, Maxime Chevallier wrote:
> Hi Simon,
> 
> On Fri, 7 Mar 2025 12:21:19 +0000
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Wed, Mar 05, 2025 at 03:19:31PM +0100, Maxime Chevallier wrote:
> > > We have a number of netlink commands in the ethnl family that may have
> > > multiple objects to dump even for a single net_device, including :
> > > 
> > >  - PLCA, PSE-PD, phy: one message per PHY device
> > >  - tsinfo: one message per timestamp source (netdev + phys)
> > >  - rss: One per RSS context
> > > 
> > > To get this behaviour, these netlink commands need to roll a custom  
> > > ->dumpit().  
> > > 
> > > To prepare making per-netdev DUMP more generic in ethnl, introduce a
> > > member in the ethnl ops to indicate if a given command may allow
> > > pernetdev DUMPs (also referred to as filtered DUMPs).
> > > 
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > ---
> > >  net/ethtool/netlink.c | 45 ++++++++++++++++++++++++++++---------------
> > >  net/ethtool/netlink.h |  1 +
> > >  2 files changed, 30 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> > > index 734849a57369..0815b28ba32f 100644
> > > --- a/net/ethtool/netlink.c
> > > +++ b/net/ethtool/netlink.c
> > > @@ -578,21 +578,34 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
> > >  	int ret = 0;
> > >  
> > >  	rcu_read_lock();
> > > -	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> > > -		dev_hold(dev);
> > > +	if (ctx->req_info->dev) {
> > > +		dev = ctx->req_info->dev;
> > >  		rcu_read_unlock();
> > > -
> > > -		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> > > -
> > > +		/* Filtered DUMP request targeted to a single netdev. We already
> > > +		 * hold a ref to the netdev from ->start()
> > > +		 */
> > > +		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
> > > +						 genl_info_dump(cb));  
> > 
> > Hi Maxime,
> > 
> > ethnl_default_dump_one_dev() is called here but it doesn't exist
> > until the following patch is applied, which breaks bisection.
> 
> Yeah I messed-up in my rebase and bisection broke :(
> 
> I'll send a new version in a few days, as Jakub said, let's give some
> time for the netdev_lock series to move forward and go through CI, I'll
> need to rebase on it at some point.

Thanks. Apologies for duplicating Jakub's comments to some extent.
I only saw them after I'd sent my previous email to you.

...

