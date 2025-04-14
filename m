Return-Path: <netdev+bounces-182277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BCA886C1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD70B1906D0C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138A25393C;
	Mon, 14 Apr 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJfSIJQa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2C253938;
	Mon, 14 Apr 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642583; cv=none; b=iLfck13ZK5+J2Z1T1MAGpdpnO11E/Z3cJT9LcAt27DB2tFNsbzaBgKKfU/r1rje8bFRhEGizcWhhrgA+PoHe7qpREfCEuH510qGAkjzmMzTrellPlO7waaEJcvkRyTeA1UGqE1KqqtuSaZ0lrJPcEH4BT2YDxumnZGuWlOtmbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642583; c=relaxed/simple;
	bh=/+KzxU3SusXWp92KzuMJ++Y/W5d77A6Q+OcRUfcO6pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6kJHOuweh2IpemqLmVmiun8xRrjNILwhDgDEWMuuEZV8tkxXeBVxztOYGj9yBbwZUKG14jsT/g+6SOCbdE+FdT47RBZ/SB/7+cGKJvywbJ6ELom/jZXBVyluMyM2TjvdCdqyVhTE9ZGN5DfvRCxI5/Om/DA300geWz3tuY5e4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJfSIJQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C520C4CEE2;
	Mon, 14 Apr 2025 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744642582;
	bh=/+KzxU3SusXWp92KzuMJ++Y/W5d77A6Q+OcRUfcO6pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJfSIJQa3ybGg9UxPWnPDR92SYCSbIaPzr/UGLdVNDaPEjpWGVmTzfxcEw/V2sOjh
	 ULurohArcfkceUDbLHKk31VW4K+rXxzo270QkZohQLbyhJQaYFRAnaYg6X09w5Tga8
	 zHAcNoLizzvaoyOJkVrWDdvTGJ2pgXbpo7TlN0ktMuS2QgJtFEwDl18pm/rh+Y/CGf
	 UHQH7zf67cZ1lVk2TRnYuxrimEXYe88L/t691pjN+BiHrnXcd7srTIYOA4Q9Q4KPmW
	 4WveGKZSGWFd+fTlZZICv7CjWlDBjMVSMCDlqnSXWly1b8sjLcxkjx0AdOcswUgrWH
	 GvRkz4Hk5zQxg==
Date: Mon, 14 Apr 2025 15:56:18 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Vishal Kulkarni <vishal@chelsio.com>
Subject: Re: [PATCH net-next] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
Message-ID: <20250414145618.GT395307@horms.kernel.org>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
 <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
 <20250411145734.GH395307@horms.kernel.org>
 <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>

On Fri, Apr 11, 2025 at 09:52:29PM +0530, Abdun Nihaal wrote:
> On Fri, Apr 11, 2025 at 03:57:34PM +0100, Simon Horman wrote:
> > On Wed, Apr 09, 2025 at 05:47:46PM +0200, Markus Elfring wrote:
> > > …
> > > > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > > > @@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
> > > >  		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
> > > >  		if (!eth_filter->port[i].bmap) {
> > > >  			ret = -ENOMEM;
> > > > +			kvfree(eth_filter->port[i].loc_array);
> > > >  			goto free_eth_finfo;
> > > >  		}
> > > >  	}
> > > 
> > > How do you think about to move the shown error code assignment behind the mentioned label
> > > (so that another bit of duplicate source code could be avoided)?
> > 
> > Hi Markus,
> > 
> > If you mean something like the following. Then I agree that it
> > is both in keeping with the existing error handling in this function
> > and addresses the problem at hand.
> > 
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > index 7f3f5afa864f..df26d3388c00 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > @@ -2270,13 +2270,15 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
> >                 eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
> >                 if (!eth_filter->port[i].bmap) {
> >                         ret = -ENOMEM;
> > -                       goto free_eth_finfo;
> > +                       goto free_eth_finfo_loc_array;
> >                 }
> >         }
> > 
> >         adap->ethtool_filters = eth_filter;
> >         return 0;
> > 
> > +free_eth_finfo_loc_array:
> > +       kvfree(eth_filter->port[i].loc_array);
> >  free_eth_finfo:
> >         while (i-- > 0) {
> >                 bitmap_free(eth_filter->port[i].bmap);
> > 
> 
> I think what Markus meant, was to move the ret = -ENOMEM from both the
> allocations in the loop, to after the free_eth_finfo label because it is
> -ENOMEM on both goto jumps.
> 
> But personally I would prefer having the ret code right after the call 
> that is failing. Also I would avoid creating new goto labels unless
> necessary, because it is easier to see the kvfree in context inside the
> loop, than to put it in a separate label.
> 
> I just tried to make the most minimal code change to fix the memory leak.

Thanks Nihaal,

I agree that your patch is fine as-is for the reasons you describe above.

Reviewed-by: Simon Horman <horms@kernel.org>

