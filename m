Return-Path: <netdev+bounces-94647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987FD8C00B1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545AF283139
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D7127E37;
	Wed,  8 May 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMhrX+Iy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64817127E2A;
	Wed,  8 May 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181102; cv=none; b=FFXu9qvLIV9u7C4iJHPFekM/TyDiSVB2BLtGjeGZ42IK2kRTaL8XifNA0UpFUjIqbV3gENUA4u49EVhy4T7pzxTMzckizrOAkriDfzgXreEL+dHFs7+aNq1xlUA3DMdWn61r7HU3m9tcDqRCV4/lyq7v0aiKMJRehh+3xiFExOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181102; c=relaxed/simple;
	bh=wzE43V4PJg/r17fKv05KLqsQb89qt2Tv84peBTaAj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oamKLV0QdS+a4hPXQRI1KlTBXEYghcY1NYZ/SKDzFsobjOQsiqRrkf2PD1zLiMEIcQEAvanRaWyQYL7z82jotDDF8ndjjBjANKfRfsVyPiuWml9nCwtKtLjvugf813oFm2QQMnz5o++2CRTwB87oulFeXu3VlPbi1X/LYka+cRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMhrX+Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4688C113CC;
	Wed,  8 May 2024 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181101;
	bh=wzE43V4PJg/r17fKv05KLqsQb89qt2Tv84peBTaAj6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMhrX+IyAdW405CWMG5slZA5fyyECEBvfUM7VmP2bMPRBjPOR91eDx0hcMIydFNt1
	 RGf1ct1MzIhOTnpnZlQYyR9JtqX9QhjYGaZwM1wc2Dk2dRoaVExvZxQt9QuG6CKz7Y
	 F0yNMmF6Q22qVipxDE5PV1yCvC6bFJXWC6rWHzCRe2d4IIPL19SJbmhPkwoOvH9ZT9
	 x9n/8fHRqjGNsEz3jPraisYPFXNBIZitz3RNU1aenxq6WxBUUinjPxbuYnHrsNHk3e
	 hmz9bYZDpAxgec9CnbXx8cSIGo1bmamHBo0ayRbIl+KK1be52649saQUtPz87mKuSO
	 FxeMXuXcue/vQ==
Date: Wed, 8 May 2024 08:11:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S . 
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric 
 Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>, "Michael S
  . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh 
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
  Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul 
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v12 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240508081139.0a620321@kernel.org>
In-Reply-To: <1715174806.2456756-1-hengqi@linux.alibaba.com>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
	<20240504064447.129622-3-hengqi@linux.alibaba.com>
	<20240507195752.7275cb63@kernel.org>
	<1715174806.2456756-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 21:26:46 +0800 Heng Qi wrote:
> On Tue, 7 May 2024 19:57:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Sat,  4 May 2024 14:44:45 +0800 Heng Qi wrote:  
> > > @@ -1325,6 +1354,8 @@ operations:
> > >              - tx-aggr-max-bytes
> > >              - tx-aggr-max-frames
> > >              - tx-aggr-time-usecs
> > > +            - rx-profile
> > > +            - tx-profil
> > >        dump: *coalesce-get-op
> > >      -
> > >        name: coalesce-set  
> > 
> > set probably needs to get the new attributes, too?  
> 
> I looked at other similar use cases (such as wol, debug) and it doesn't
> seem to be needed?

Sorry, you're right, they are propagated using a YAML alias.

> > > +static int ethnl_update_profile(struct net_device *dev,
> > > +				struct dim_cq_moder __rcu **dst,
> > > +				const struct nlattr *nests,
> > > +				struct netlink_ext_ack *extack)  
> >   
> > > +	rcu_assign_pointer(*dst, new_profile);
> > > +	kfree_rcu(old_profile, rcu);
> > > +
> > > +	return 0;  
> > 
> > Don't we need to inform DIM somehow that profile has switched
> > and it should restart itself?  
> 
> When the profile is modified, dim itself is a dynamic adjustment mechanism
> and will quickly adjust to the appropriate value according to the new profile.
> This is also seen in practice.

Okay, perhaps add a comment to that effect?

