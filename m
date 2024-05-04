Return-Path: <netdev+bounces-93411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA9C8BB995
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 08:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBAC2831E1
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B264A32;
	Sat,  4 May 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KR5THNZq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8CA4689;
	Sat,  4 May 2024 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714804922; cv=none; b=tYsgNN5+bMdebdl3kjEa8Dg/ZCtvxKZVr4Ro8mow27KxhcI1r5mHrjQ86XcBzcXQIicv8VbMLHk6PJKJD8FG/ArzLa30RcSfgSqSXxFeElfUGwo/hPee5Cn00vVsyEaIcgeTcLG88BjmOpwtt8Cb2auc3Rjp7yvQcg3OVRsZKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714804922; c=relaxed/simple;
	bh=uV0LJSID+R0gchn39+HEynwC5xW+dxbJ4FYEUMiKNrM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mlb87xXjJPqMiEt5WPpk7T3U7IkM0HIdrmYrunwgvV0TYzqqjcJw7/vRSDFtYNLVFzwSLDsrq+Lmn5i6+iCxu72neQ3KqG5p2QdNjpJaD0+RQF/fu/8eryXpSt+PVKST7Zv8DqpBit283bEJKfC0gz4WiHhMJI+t/M/sPzRLQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KR5THNZq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714804911; h=Message-ID:Subject:Date:From:To;
	bh=jFazqI/3JXT8wRCfnlNfMfUz2mLwm6uGeeP6zZyNSQk=;
	b=KR5THNZqvxc1SZlNm/P2pG9vooIGNnOsmdzUNhj3hKnYLh0G0GFJZ1eOV9RqGc10cxI5PUPHOfGXDi/7mu8FLjxBc5hF37yiYd+mRa2ZswAyV+y/IlSOxmqHnO1FLLo219tgWvXR95Ikk3kbUf5TaXaqZzKalwSNXvGmwbpa8Xk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W5luBzi_1714804907;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5luBzi_1714804907)
          by smtp.aliyun-inc.com;
          Sat, 04 May 2024 14:41:49 +0800
Message-ID: <1714804375.4746933-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
Date: Sat, 4 May 2024 14:32:55 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <20240503135244.GV2821784@kernel.org>
In-Reply-To: <20240503135244.GV2821784@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 3 May 2024 14:52:44 +0100, Simon Horman <horms@kernel.org> wrote:
> On Wed, May 01, 2024 at 01:31:34AM +0800, Heng Qi wrote:
> 
> ...
> 
> > diff --git a/include/linux/dim.h b/include/linux/dim.h
> 
> ...
> 
> > @@ -198,6 +234,32 @@ enum dim_step_result {
> >  	DIM_ON_EDGE,
> >  };
> >  
> > +/**
> > + * net_dim_init_irq_moder - collect information to initialize irq moderation
> > + * @dev: target network device
> > + * @profile_flags: Rx or Tx profile modification capability
> > + * @coal_flags: irq moderation params flags
> > + * @rx_mode: CQ period mode for Rx
> > + * @tx_mode: CQ period mode for Tx
> > + * @rx_dim_work: Rx worker called after dim decision
> > + *    void (*rx_dim_work)(struct work_struct *work);
> > + *
> > + * @tx_dim_work: Tx worker called after dim decision
> > + *    void (*tx_dim_work)(struct work_struct *work);
> > + *
> 
> Hi Heng Qi,

Hi Simon,

> 
> The above seems to result in make htmldocs issuing the following warnings:
> 
>  .../net_dim:175: ./include/linux/dim.h:244: WARNING: Inline emphasis start-string without end-string.
>  .../net_dim:175: ./include/linux/dim.h:244: WARNING: Inline emphasis start-string without end-string.
>  .../net_dim:175: ./include/linux/dim.h:247: WARNING: Inline emphasis start-string without end-string.
>  .../net_dim:175: ./include/linux/dim.h:247: WARNING: Inline emphasis start-string without end-string.
> 
> I suggest the following alternative:
> 
>  * @rx_dim_work: Rx worker called after dim decision
>  * @tx_dim_work: Tx worker called after dim decision

Will update this.

> 
> Exercised using Sphinx 7.2.6
> 
> ...
> 
> > diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
> 
> ...
> 
> > @@ -134,6 +212,12 @@ static int coalesce_fill_reply(struct sk_buff *skb,
> >  	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
> >  	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
> >  	const struct ethtool_coalesce *coal = &data->coalesce;
> > +#if IS_ENABLED(CONFIG_DIMLIB)
> > +	struct net_device *dev = req_base->dev;
> > +	struct dim_irq_moder *moder = dev->irq_moder;
> > +	u8 coal_flags;
> > +	int ret;
> > +#endif
> >  	u32 supported = data->supported_params;
> 
> It's a minor nit, but here goes: please consider using reverse xmas tree
> order - longest line to shortest - for local variable declarations in
> Networking code.
> 
> In this case, I appreciate that it's not strictly possible without
> introducing more than one IS_ENABLED condition, which seems worse.
> So, as that condition breaks the visual flow, what I suggest in this
> case is having a second block of local variable declarations, like this:
> 
> 	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
> 	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
> 	const struct ethtool_coalesce *coal = &data->coalesce;
> 	u32 supported = data->supported_params;                  
> 
> #if IS_ENABLED(CONFIG_DIMLIB)
> 	struct dim_irq_moder *moder = dev->irq_moder;
> 	struct net_device *dev = req_base->dev;

Note: The line above depends on the line below. :)

However, even so, I will try to make a change to keep "xmas tree order".

> 	u8 coal_flags;
> 	int ret;
> #endif 
> 
> Or better still, if it can be done cleanly, moving all the IS_ENABLED()
> code in this function into a separate function, with an no-op
> implementation in the case that CONFIG_DIMLIB is not enabled. In general
> I'd recommend that approach over sprinkling IS_ENABLED or #ifdef inside
> functions. Because in my experience it tends to lead to more readable code.
> 

As discussed in the previous replies, IS_ENABLED(CONFIG_DIMLIB) will be removed
in the next version, so we'll do not have this problem, but your suggestion is
good.

Thanks.

> In any case, the following tool is helpful for isolating
> reverse xmas tree issues.
> 
> https://github.com/ecree-solarflare/xmastree
> 
> 
> >  	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
> > @@ -192,11 +276,49 @@ static int coalesce_fill_reply(struct sk_buff *skb,
> >  			     kcoal->tx_aggr_time_usecs, supported))
> >  		return -EMSGSIZE;
> >  
> > +#if IS_ENABLED(CONFIG_DIMLIB)
> > +	if (!moder)
> > +		return 0;
> > +
> > +	coal_flags = moder->coal_flags;
> > +	rcu_read_lock();
> > +	if (moder->profile_flags & DIM_PROFILE_RX) {
> > +		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_PROFILE,
> > +					   rcu_dereference(moder->rx_profile),
> > +					   coal_flags);
> > +		if (ret) {
> > +			rcu_read_unlock();
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (moder->profile_flags & DIM_PROFILE_TX) {
> > +		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_TX_PROFILE,
> > +					   rcu_dereference(moder->tx_profile),
> > +					   coal_flags);
> > +		if (ret) {
> > +			rcu_read_unlock();
> > +			return ret;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +#endif
> >  	return 0;
> >  }
> 
> ...

