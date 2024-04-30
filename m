Return-Path: <netdev+bounces-92302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FA8B67D9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDA71F22BEE
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBDDDA9;
	Tue, 30 Apr 2024 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M23WbWHW"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E88F6F;
	Tue, 30 Apr 2024 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443237; cv=none; b=bqqxGHuHcFqLSANVKyO05z6hTUwbQ6qs0B2GOXgxEIQnNn2QuXeiGaANF4kdu7GMaHtMVzW1KFxRbDCIYmezh73ti+9gXYaaQkHKsOR4KxDjAQ85H0gZUrQ7CayTU5ZbO4WSazP9Efvc1R2Nq+WgmKKM0ZPlIjUgkgdsAkzNlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443237; c=relaxed/simple;
	bh=8sbxx22xmGWgECxkXVi/5b28FpNr1fg/fRLgHhiSgQE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HBCWbz072rfaM7XUER86iZFMBJZiSbTvSHdW9ox/x0yuSvmSXo3/9pOib17s/mvykCTFMhoqL8jFJrV0q7kkqIPRomnavcizxsO0RNibT9Huzx6kyZbA7nMQXu8KV9PWGB08kHgqKvn2RggHeN/xDO+raG0fPMRq6VdHr1qe048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M23WbWHW; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714443227; h=Message-ID:Subject:Date:From:To;
	bh=y6BHbK1lWejK17N+PEG4y4GRz35g2lrll3r6j9O47ps=;
	b=M23WbWHWhuG/M3daJPJcwdTdwSHdJefhEj71ZcoFmMDQEbSQIIlmIuZYkCB4RL6EDfttABeeG5tz78XDEs9aJXvoI+1c8gaG4kdEgo7DMIKUnb4C4uFBI1JoQGajno0W6JQLzLBgFjWyZMbAC4lSCL3hs6EV5LwW+NnB5BUWj8w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5ae2VQ_1714443224;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ae2VQ_1714443224)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 10:13:44 +0800
Message-ID: <1714442379.4695537-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v10 2/4] ethtool: provide customized dim profile management
Date: Tue, 30 Apr 2024 09:59:39 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S .  Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric  Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S  . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh  Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal  Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul  Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "justinstitt @  google . com" <justinstitt@google.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
 <20240425165948.111269-3-hengqi@linux.alibaba.com>
 <20240426183333.257ccae5@kernel.org>
 <98ea9d4d-1a90-45b9-a4e0-6941969295be@linux.alibaba.com>
 <20240429104741.3a628fe6@kernel.org>
In-Reply-To: <20240429104741.3a628fe6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 29 Apr 2024 10:47:41 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Sun, 28 Apr 2024 22:49:09 +0800 Heng Qi wrote:
> > >> +	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION, nests, rem) {
> > >> +		ret = nla_parse_nested(moder,
> > >> +				       ARRAY_SIZE(coalesce_irq_moderation_policy) - 1,
> > >> +				       nest, coalesce_irq_moderation_policy,
> > >> +				       extack);
> > >> +		if (ret)
> > >> +			return ret;
> > >> +
> > >> +		if (!NL_REQ_ATTR_CHECK(extack, nest, moder, ETHTOOL_A_IRQ_MODERATION_USEC)) {
> > >> +			if (irq_moder->coal_flags & DIM_COALESCE_USEC)  
> > > There are 3 options here, not 2:
> > >
> > > 	if (irq_moder->coal_flags & flag) {
> > > 		if (NL_REQ_ATTR_CHECK())
> > > 			val = nla_get_u32(...);
> > > 		else
> > > 			return -EINVAL;
> > > 	} else {
> > > 		if (moder[attr_type)) {
> > > 			BAD_ATTR()
> > > 			return -EOPNOTSUPP;
> > > 		}
> > > 	}  
> > 
> > Maybe we missed something.
> > 
> > As shown in the commit log, the user is allowed to modify only
> > a certain fields in irq-moderation. It is assumed that the driver
> > supports modification of usec and pkts, but the user may only
> > modify usec and only fill in the usec attr.
> > 
> > Therefore, the kernel only gets usec attr here. Of course, the user
> > may have passed in 5 groups of "n, n, n", which means that nothing
> > is modified, and rx_profile and irq_moderation attrs are all empty.
> 
> What you describe sounds good, but it's not what the code seems to be
> doing. NL_REQ_ATTR_CHECK() will set an error attribute if the attr is
> not present.

So here we can use:

+ if (moder[ETHTOOL_A_IRQ_MODERATION_USEC]) {
+ 	if (irq_moder->coal_flags & DIM_COALESCE_USEC)
+ 		new_profile[i].usec =
+ 			nla_get_u32(moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
+ 	else
+ 		return -EOPNOTSUPP;
+ }

instead of:

+ if (!NL_REQ_ATTR_CHECK(extack, nest, moder, ETHTOOL_A_IRQ_MODERATION_USEC)) {
+ 	if (irq_moder->coal_flags & DIM_COALESCE_USEC)
+ 		new_profile[i].usec =
+ 			nla_get_u32(moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
+ 	else
+ 		return -EOPNOTSUPP;
+ }

to avoid missing information set in extack?

Thanks.

