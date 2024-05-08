Return-Path: <netdev+bounces-94661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFDF8C017A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECD91C24963
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C8128368;
	Wed,  8 May 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xhiLGgkb"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56D127E34;
	Wed,  8 May 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183604; cv=none; b=RTydQg8IQPBZC1CIL2Cib2f/iuflkwDaCkzqGexEn55wzhoVoBweOxpSpONk4MI2llR2C6cuaQrlLTo+of47aNsoEJywaprPJ4R5TjB/oKDU0PyLLyIXvdVt4ySW3yFoolmIeLfwe1uIw0y24v47+TIbkkDpXdcrfqJdPsAOqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183604; c=relaxed/simple;
	bh=blXBDFniuX+5PbDGWWQnYwb4VIxupmq1l9wrvD6U1+A=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jFEsz+4ApQB0OWNGpb7jFhekldaa9MifaE1Bm9AK4YKGYb6cG4vFy7OXnp4LIOEPtF4S83wnqoCaXp6H5s5eR5UJ7VxNXe/ms+I08Prs2o+ofUmmVVTVfodcp2vHt6OKJn3wUdrX0KNYIe+ZA5ixGUoALlqVyxAvObFbaSspExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xhiLGgkb; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715183599; h=Message-ID:Subject:Date:From:To;
	bh=4Hv1i7knTXV0jVDzONFoH620SU1ZuBVwrX2QxekucVk=;
	b=xhiLGgkbGyRvzwm//d09xFNRAONaC0L8c/bl6Bw3ODQpXqR5NM+Iw3dUBCdqLnTd5gYZKcjy0HwCrjPHbsxoul4HOAzhbH2llLQ52SfjuAwFX78HFQfXMFahX+66dlTSNBoflQOmEi7ykmYKaf3lwvsyeOs1Y6lphuDdb2pGktU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W64-EyS_1715183596;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W64-EyS_1715183596)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 23:53:17 +0800
Message-ID: <1715183551.9560893-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v12 2/4] ethtool: provide customized dim profile management
Date: Wed, 8 May 2024 23:52:31 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S .   Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric   Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S   . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh   Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal   Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul   Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 Simon Horman <horms@kernel.org>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
 <20240504064447.129622-3-hengqi@linux.alibaba.com>
 <20240507195752.7275cb63@kernel.org>
 <1715174806.2456756-1-hengqi@linux.alibaba.com>
 <20240508081139.0a620321@kernel.org>
In-Reply-To: <20240508081139.0a620321@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 8 May 2024 08:11:39 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 8 May 2024 21:26:46 +0800 Heng Qi wrote:
> > On Tue, 7 May 2024 19:57:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Sat,  4 May 2024 14:44:45 +0800 Heng Qi wrote:  
> > > > @@ -1325,6 +1354,8 @@ operations:
> > > >              - tx-aggr-max-bytes
> > > >              - tx-aggr-max-frames
> > > >              - tx-aggr-time-usecs
> > > > +            - rx-profile
> > > > +            - tx-profil
> > > >        dump: *coalesce-get-op
> > > >      -
> > > >        name: coalesce-set  
> > > 
> > > set probably needs to get the new attributes, too?  
> > 
> > I looked at other similar use cases (such as wol, debug) and it doesn't
> > seem to be needed?
> 
> Sorry, you're right, they are propagated using a YAML alias.
> 
> > > > +static int ethnl_update_profile(struct net_device *dev,
> > > > +				struct dim_cq_moder __rcu **dst,
> > > > +				const struct nlattr *nests,
> > > > +				struct netlink_ext_ack *extack)  
> > >   
> > > > +	rcu_assign_pointer(*dst, new_profile);
> > > > +	kfree_rcu(old_profile, rcu);
> > > > +
> > > > +	return 0;  
> > > 
> > > Don't we need to inform DIM somehow that profile has switched
> > > and it should restart itself?  
> > 
> > When the profile is modified, dim itself is a dynamic adjustment mechanism
> > and will quickly adjust to the appropriate value according to the new profile.
> > This is also seen in practice.
> 
> Okay, perhaps add a comment to that effect?

Ok. Will add in the next version.

Thanks.

