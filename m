Return-Path: <netdev+bounces-24642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04263770EAD
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3559C1C20AC2
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57179E6;
	Sat,  5 Aug 2023 08:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034C1FDD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 08:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD433C433C8;
	Sat,  5 Aug 2023 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691223012;
	bh=b3lFk+3qxJar1a/a6y8htzcysOKtSt7NnVMDTyzWGAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGPdHloRUkJXgp/bDsVFAZiLZCIxsalDyraQ+xKiUbIVnjSjg7VenFnhwopnFnKwt
	 g6sam34Nqwoz3Yqg0R16TgRpYackurW5z+mXq/JcLItBmci6DNy8f+kwcyqQp6QOf/
	 EZ7byJ93eXrWRCZ06W0NgHW2Cg+qsQ0yZKyXpjOzcwbC6b2MEJPHWjrZzkQWs0Iaet
	 WRjSun0SQwgek63toZbThEPN4hdnIVRTbe7DMwZ8VsicyhU/p48PXwr1u4UAIEMH+P
	 mSERX7+SQEm6Ah2Wp/5Adi+MGSrG39XbNB3h+NmXH1YN1R3LWpyX2bKKERr4yLZicv
	 BkTYVOZALGjvw==
Date: Sat, 5 Aug 2023 10:10:07 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister()
 under rtnl_lock() on driver remove
Message-ID: <ZM4D3/ZKI80MLSDU@vergenet.net>
References: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
 <ZMwAImhL8nH+6KLf@kernel.org>
 <20230804111045.rk3yvo5xb4wxyvoa@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804111045.rk3yvo5xb4wxyvoa@skbuf>

On Fri, Aug 04, 2023 at 02:10:45PM +0300, Vladimir Oltean wrote:
> On Thu, Aug 03, 2023 at 09:29:38PM +0200, Simon Horman wrote:
> > On Thu, Aug 03, 2023 at 04:42:53PM +0300, Vladimir Oltean wrote:
> > > diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> > > index fd7eb4a52918..9a3e5ec16972 100644
> > > --- a/drivers/net/dsa/ocelot/felix.c
> > > +++ b/drivers/net/dsa/ocelot/felix.c
> > > @@ -1619,8 +1619,10 @@ static void felix_teardown(struct dsa_switch *ds)
> > >  	struct felix *felix = ocelot_to_felix(ocelot);
> > >  	struct dsa_port *dp;
> > >  
> > > +	rtnl_lock();
> > >  	if (felix->tag_proto_ops)
> > >  		felix->tag_proto_ops->teardown(ds);
> > > +	rtnl_unlock();
> > 
> > Hi Vladimir,
> > 
> > I am curious to know if RTNL could be taken in
> > felix_tag_8021q_teardown() instead.
> 
> Negative. This call path also exists:
> 
> dsa_tree_change_tag_proto()
> -> rtnl_trylock()
> -> dsa_tree_notify(dst, DSA_NOTIFIER_TAG_PROTO, &info)
>    -> dsa_switch_change_tag_proto()
>       -> ds->ops->change_tag_protocol()
>          -> felix_change_tag_protocol()
>             -> old_proto_ops->teardown()
>                -> felix_tag_8021q_teardown()
> 
> where the rtnl_mutex is already held.

Ack. Thanks for confirming.
In that case this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>






