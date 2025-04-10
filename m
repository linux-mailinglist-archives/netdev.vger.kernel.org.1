Return-Path: <netdev+bounces-181443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE325A85040
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F667A447C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81891F17F7;
	Thu, 10 Apr 2025 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vvn2sJYl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B433F6
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328778; cv=none; b=eru25rGJCtjf5HriEEd+lUt36eGoAQbBwVp1O2ox1ccShU6uAR0gg0u5oTg9Tk6wDhJ4wK7e1IO37m8uWdiKbT6t7r8DtQ6DMyP9CGmeTCdpkA2+L111FCTN1F9X8JBFT6knKJRyZh62sLuTw25riCx09ENgMxdDnXyFgNDS074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328778; c=relaxed/simple;
	bh=m3dOhnIL9ETuUZ+j+3c3p/+LRtyR64+jdyPBn9jvqwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIGZmoSpO5WmCPARFPsxvZ8Yx+JGdS9Ilj0uaBdsVhKfdgYQU9g7wCZDum9r8O4iIWSwgTx4ioQaCl0oIlh+Ay+HGo3JFDp3u4Ojeh8k1hnQqRY0RZSXRlgeNEcTMkyvyhQAtsS5zBo3v/xkREvHB+Zs7Uqttu24Q6HermIoZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vvn2sJYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5978AC4CEDD;
	Thu, 10 Apr 2025 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744328775;
	bh=m3dOhnIL9ETuUZ+j+3c3p/+LRtyR64+jdyPBn9jvqwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vvn2sJYlWmDIx3EzmXxU9Ys3jEeGHI2j3fvVhVAlCWLkg4qXM9WS6lUgCjmjX9C+/
	 azL04lXUV8a/WgifvRZoIgqs719zun7KilW7/VhlyvDnRSh+I9f6+eUQTVE+0rSz1Z
	 5a837nYCX8Lc9E067s+phUPYivnBYiCl2A4fOw4hSXlb50XjEicXhqODhlcKCYZ52j
	 SciWVi9Lz+FE57UHClFVs+mObHIc4xnW4XbMnhZ6/7aSoNBXJaiuutMT+fWVbAC5cV
	 79lUTa3ErAuwzSkNprU0CLNXKEpnrVtaRkaLRI1yPjfUfvjoAETTeb4xvQzR/8zYiB
	 iA3ZJqbLW/mbg==
Date: Thu, 10 Apr 2025 16:46:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <sdf@fomichev.me>, <hramamurthy@google.com>, <kuniyu@amazon.com>,
 <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 8/8] netdev: depend on netdev->lock for
 qstats in ops locked drivers
Message-ID: <20250410164614.407e6d98@kernel.org>
In-Reply-To: <a2768226-854e-464d-8e76-240f7c76e987@intel.com>
References: <20250408195956.412733-1-kuba@kernel.org>
	<20250408195956.412733-9-kuba@kernel.org>
	<a2768226-854e-464d-8e76-240f7c76e987@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 22:23:28 -0700 Jacob Keller wrote:
> > +struct netdev_stat_ops
> > +----------------------
> > +
> > +"qstat" ops are invoked under the instance lock for "ops locked" drivers,
> > +and under rtnl_lock for all other drivers.
> > +
> >  struct net_shaper_ops
> >  ---------------------
> >    
> 
> What determines if a driver is "ops locked"? Is that defined above this
> chunk in the doc? I see its when netdev_need_ops_lock() is set? Ok.

Yup, it was hiding in the previous patch:

   Code comments and docs refer to drivers which have ops called under
   the instance lock as "ops locked".

> Sounds like it would be good to start migrating drivers over to this
> locking paradigm over time.

At least for the drivers which implement queue stats its nice to be able 
to dump stats without taking the global lock. 

> >  	if (ifindex) {
> > -		netdev = __dev_get_by_index(net, ifindex);
> > -		if (netdev && netdev->stat_ops) {
> > +		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
> > +		if (!netdev) {
> > +			NL_SET_BAD_ATTR(info->extack,
> > +					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
> > +			return -ENODEV;
> > +		}  
> 
> I guess netdev_get_by_index_lock_ops_compat acquires the lock when it
> returns success?

Yes.

> > +		if (netdev->stat_ops) {
> >  			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
> >  							    info, ctx);
> >  		} else {
> >  			NL_SET_BAD_ATTR(info->extack,
> >  					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
> > -			err = netdev ? -EOPNOTSUPP : -ENODEV;
> > -		}
> > -	} else {  
> 
> But there's an else branch here so now I'm confused with how this
> locking works.

The diff is really hard to read, sorry, I should have done two patches.
The else branch is _removed_. The code is now:

	if (ifindex) {
		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
		...
		netdev_unlock_ops_compat(netdev);  
		return ;
	}

	for_each_lock_scoped() {
	}

