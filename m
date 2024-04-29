Return-Path: <netdev+bounces-92228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F318B6067
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78461C21937
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B65127E1C;
	Mon, 29 Apr 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3C2jFcH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB133127B4E;
	Mon, 29 Apr 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412863; cv=none; b=H3IMmGqPm4FqlSF62hljPpKJxSkU2KxA7yhE7oeo0KmNekfFBYyYkYAwg3lu7PxN/ijfKS/82m2ojVSXmWjwguAPIJqaVD6Qd7jobYVml7lkY9Ie0HM/gsxySNZhGiWlTuGQH/IK4yw5+iR4syTPCEAvQXE+QhmKlDvU0/Iopgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412863; c=relaxed/simple;
	bh=4ScIUAaRVdRkwTOSUNbhTjra3ZYbZILZeUgAOUlkqNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnQ94XyfarbEsDiRl85iT+y8LEuYtVsKUYJIbV8RiBlU43v8gPlOM8gzbgvPrkRhsZuHaJx5eevS3sjNuyoEBnv35MYo2ymjQH0QpwbXo5nfPoRHc+qAZj8C9aqQEjMoU3yhbP0XxHzLdyAcISRYfuPsUG7FVqr4cVhaL/KP/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3C2jFcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D24C113CD;
	Mon, 29 Apr 2024 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714412863;
	bh=4ScIUAaRVdRkwTOSUNbhTjra3ZYbZILZeUgAOUlkqNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3C2jFcH2t1Y4FVliyl7rv9dAfLKy+iOHER8FCl0XC+aoUY0hSM+g6Hw51/0V16w8
	 gfB578VqlthsnJ8Xgqk+g2JMLgq1XZLn+eICcFlTTRC7bbg7m/jnTOlJ452mFXfxEf
	 QEU3OczMg0XXq+SiA1WKlruvYDdnIAk5ZZ/cDlxDNfkhEu6LJa7zJqcz4BuB7viNm9
	 ceCbnvpo9o2JDs1zVxT2ll9CWqrCQM+uNGGM9l2InwFrQdKJO8Cpq8byg7rf5UX5gr
	 MpMxSigNWwEPCGcdCbKFfDQQLnAdPUGcj/pR0EJKOgJ7M6tq6kr8DW1Uo02fQJ0IXS
	 0vDWUv33xY7zQ==
Date: Mon, 29 Apr 2024 10:47:41 -0700
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
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, "justinstitt @
 google . com" <justinstitt@google.com>
Subject: Re: [PATCH net-next v10 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240429104741.3a628fe6@kernel.org>
In-Reply-To: <98ea9d4d-1a90-45b9-a4e0-6941969295be@linux.alibaba.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
	<20240425165948.111269-3-hengqi@linux.alibaba.com>
	<20240426183333.257ccae5@kernel.org>
	<98ea9d4d-1a90-45b9-a4e0-6941969295be@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 22:49:09 +0800 Heng Qi wrote:
> >> +#if IS_ENABLED(CONFIG_DIMLIB)
> >> +	if (dev->irq_moder) {  
> > This may be NULL  
> 
> 
> Do you mean dev may be null or dev->irq_moder may be null?
> The former has been excluded (see const struct ethtool_ops *ops
> 
> = req_info->dev->ethtool_ops;).
> 
> And we are ruling out the latter using 'if (dev->irq_moder)'.
> 
> Or something else?

Hm, I must have misread something here.

> >> +	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION, nests, rem) {
> >> +		ret = nla_parse_nested(moder,
> >> +				       ARRAY_SIZE(coalesce_irq_moderation_policy) - 1,
> >> +				       nest, coalesce_irq_moderation_policy,
> >> +				       extack);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		if (!NL_REQ_ATTR_CHECK(extack, nest, moder, ETHTOOL_A_IRQ_MODERATION_USEC)) {
> >> +			if (irq_moder->coal_flags & DIM_COALESCE_USEC)  
> > There are 3 options here, not 2:
> >
> > 	if (irq_moder->coal_flags & flag) {
> > 		if (NL_REQ_ATTR_CHECK())
> > 			val = nla_get_u32(...);
> > 		else
> > 			return -EINVAL;
> > 	} else {
> > 		if (moder[attr_type)) {
> > 			BAD_ATTR()
> > 			return -EOPNOTSUPP;
> > 		}
> > 	}  
> 
> Maybe we missed something.
> 
> As shown in the commit log, the user is allowed to modify only
> a certain fields in irq-moderation. It is assumed that the driver
> supports modification of usec and pkts, but the user may only
> modify usec and only fill in the usec attr.
> 
> Therefore, the kernel only gets usec attr here. Of course, the user
> may have passed in 5 groups of "n, n, n", which means that nothing
> is modified, and rx_profile and irq_moderation attrs are all empty.

What you describe sounds good, but it's not what the code seems to be
doing. NL_REQ_ATTR_CHECK() will set an error attribute if the attr is
not present.

