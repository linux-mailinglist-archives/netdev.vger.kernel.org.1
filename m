Return-Path: <netdev+bounces-182273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D263FA88677
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57EB1894949
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F703274FED;
	Mon, 14 Apr 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUI8eINt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1323D2A9
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642351; cv=none; b=jYOVXMbq2p35wCO8ldHqBkE7eRVTlq6ujr/ijhKqyVmUVeK8qJTxYSlTvChGOMwCGrAq6xv+DpwGVlBqTEX6BuJF+YmShpPb6C+GbeVqe2AmcizdAL7LtHA4SujMsL9bHPJ3vJGcKKVncovk0s3mbFlVm5BJkGVrE88zoZF19AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642351; c=relaxed/simple;
	bh=UPG7/oDA9ipmwmGlckQ022DjQGPeo90KhuHOBZ6nUW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENpMV4Udgq7kxl1cnGA1Lx2WiZ0qzY9UHkwoWJXU2Cgs0s19O0HoSDiobsugzMgkGpoGH2rpKq/djlBvGXLHRQU5K6iIj/UhEGgXTrBEas9DDPX4UJRQJAJzjhPPQwKFVB5nLAlMVDLHWiAbVlstQrA3x9ort84QnUPQcCQx1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUI8eINt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD72C4CEE2;
	Mon, 14 Apr 2025 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744642350;
	bh=UPG7/oDA9ipmwmGlckQ022DjQGPeo90KhuHOBZ6nUW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUI8eINtb7lv0UtAKoQvL0X/Ji6029pYQ4W7P1UgXufdlL6+A69usNtPPTvFSYhwO
	 5HrWKvIvJngnOP9PZS585DD+MimfbyEMmpQuqwWxuL2oFKev3wyZJ34DyAi4QMYSEf
	 JigsRAMqHjbbWLyHunSwPGQ4RFogdIkcliOQVOwapMp4nSiZ5uscQeGZzOqVcGLyQE
	 XSvBUSZy10EnfSyu3ieyZjPYJ9fZKQ6fxKTc7giiAoyzqJ1q0BC34mS+C83jmuj/XA
	 lip2xuBoPeJ6qBwPxk6jfA+Dgyvl+F6/lcOfWnUIC86jSbu3rojwIuULnTEVfEjuld
	 l7UCPcct51aog==
Date: Mon, 14 Apr 2025 15:52:26 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2 net-next 10/14] ipv6: Factorise
 ip6_route_multipath_add().
Message-ID: <20250414145226.GS395307@horms.kernel.org>
References: <20250411103404.GY395307@horms.kernel.org>
 <20250411193347.47836-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411193347.47836-1-kuniyu@amazon.com>

On Fri, Apr 11, 2025 at 12:33:46PM -0700, Kuniyuki Iwashima wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Fri, 11 Apr 2025 11:34:04 +0100
> > > +static int ip6_route_mpath_info_create_nh(struct list_head *rt6_nh_list,
> > > +					  struct netlink_ext_ack *extack)
> > > +{
> > > +	struct rt6_nh *nh, *nh_next, *nh_tmp;
> > > +	LIST_HEAD(tmp);
> > > +	int err;
> > > +
> > > +	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
> > > +		struct fib6_info *rt = nh->fib6_info;
> > > +
> > > +		err = ip6_route_info_create_nh(rt, &nh->r_cfg, extack);
> > > +		if (err) {
> > > +			nh->fib6_info = NULL;
> > > +			goto err;
> > > +		}
> > > +
> > > +		rt->fib6_nh->fib_nh_weight = nh->weight;
> > > +
> > > +		list_move_tail(&nh->next, &tmp);
> > > +
> > > +		list_for_each_entry(nh_tmp, rt6_nh_list, next) {
> > > +			/* check if fib6_info already exists */
> > > +			if (rt6_duplicate_nexthop(nh_tmp->fib6_info, rt)) {
> > > +				err = -EEXIST;
> > > +				goto err;
> > > +			}
> > > +		}
> > > +	}
> > > +out:
> > > +	list_splice(&tmp, rt6_nh_list);
> > > +	return err;
> > 
> > Hi Kuniyuki-san,
> > 
> > Perhaps it can't happen in practice,
> 
> Yes, it never happens by patch 1 as rtm_to_fib6_multipath_config()
> returns an error in such a case.
> 
> 
> > but if the loop above iterates zero
> > times then err will be used uninitialised. As it's expected that err is 0
> > here, perhaps it would be simplest to just:
> > 
> > 	return 0;
> 
> If we want to return 0 above, we need to duplicate list_splice() at
> err: and return err; there.  Or initialise err = 0, but this looks
> worse to me.

Thanks. I should have dug a bit deeper to determine that this
is a false-positive.

> Btw, was this caught by Smatch, Coverity, or something ?  I don't
> see such a report at CI.
> https://patchwork.kernel.org/project/netdevbpf/patch/20250409011243.26195-11-kuniyu@amazon.com/

Sorry for not mentioning that it was flagged by Smatch,
I certainly should have done so.


> 
> If so, I'm just curious if we have an official guideline for
> false-positives flagged by such tools, like we should care about it
> while writing a code and should try to be safer to make it happy.
> 
> We are also running Coverity for the mainline kernel and have tons
> of false-positive reports due to lack of contexts.

I think that the current non-guideline is that we don't change
code just to keep the tools happy. Perhaps we should add something
about that to the process document?

