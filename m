Return-Path: <netdev+bounces-58461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59EC816818
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 09:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A69280D6E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A801094B;
	Mon, 18 Dec 2023 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNXxBIND"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BAF1119F
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF01C433BA;
	Mon, 18 Dec 2023 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702888431;
	bh=6S0SJlUripJgMDU4h59IQMRxeLJODmnZ9gVF+qUmWvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNXxBINDMlki/Tl0E4AsMgkGk7YOYj73aqX77FRDHxY5RCfRxZCilwYJQbzm2bcZ9
	 Yi8mWmOKl04c3iu9U14YEFo7MjE/eV1cvZYJxC/5BrwnAwnnmwnXIvZl/EK6MX5wal
	 l3EGIpqfLcJI6cYXFZfDUNwM/kYxZNbLOuanS+iTOylb+tvuerOhi+2/jCc6lxlZPn
	 5RCxd+imUVrAVpqZhvmCh9r551IEDmOA7qiBDyI/v4JKkEg357czL/o6QR0rV3V2/P
	 1LXnvNLTDvZsfv8/ljkebjz2e1Piy9dsF4l0z7ZN0ph29wG2zD/4Rchgn/Jmm2RF42
	 UJ2SgSIQHREmw==
Date: Mon, 18 Dec 2023 08:33:45 +0000
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/8] dpaa2-switch: reorganize the
 [pre]changeupper events
Message-ID: <20231218083345.GA6288@kernel.org>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
 <20231213121411.3091597-7-ioana.ciornei@nxp.com>
 <20231215114939.GB6288@kernel.org>
 <tkskehfowdrohukyhqu4ae6t56ceuwp6p2mm7r2tfzihladl6t@vxeggsm2ppte>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkskehfowdrohukyhqu4ae6t56ceuwp6p2mm7r2tfzihladl6t@vxeggsm2ppte>

On Fri, Dec 15, 2023 at 02:08:51PM +0200, Ioana Ciornei wrote:
> On Fri, Dec 15, 2023 at 11:49:39AM +0000, Simon Horman wrote:
> > On Wed, Dec 13, 2023 at 02:14:09PM +0200, Ioana Ciornei wrote:

...

> > >  	if (!dpaa2_switch_port_dev_check(netdev))
> > > -		return NOTIFY_DONE;
> > > +		return 0;
> > >  
> > >  	extack = netdev_notifier_info_to_extack(&info->info);
> > > -
> > > -	switch (event) {
> > > -	case NETDEV_PRECHANGEUPPER:
> > > -		upper_dev = info->upper_dev;
> > > -		if (!netif_is_bridge_master(upper_dev))
> > > -			break;
> > > -
> > > +	upper_dev = info->upper_dev;
> > > +	if (netif_is_bridge_master(upper_dev)) {
> > >  		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
> > >  								upper_dev,
> > >  								extack);
> > >  		if (err)
> > > -			goto out;
> > > +			return err;
> > >  
> > >  		if (!info->linking)
> > >  			dpaa2_switch_port_pre_bridge_leave(netdev);
> > > +	}
> > 
> > FWIIW, I think that a more idomatic flow would be to return if
> > netif_is_bridge_master() is false. Something like this (completely untested!):
> > 
> > 	if (!netif_is_bridge_master(upper_dev))
> > 		return 0;
> > 
> > 	err = dpaa2_switch_prechangeupper_sanity_checks(netdev, upper_dev,
> > 							extack);
> > 	if (err)
> > 		return err;
> > 
> > 	if (!info->linking)
> > 		dpaa2_switch_port_pre_bridge_leave(netdev);
> > 
> 
> It looks better but I don't think this it's easily extensible.
> 
> I am planning to add support for LAG offloading which would mean that I
> would have to revert to the initial flow and extend it to something
> like:
> 
> 	if (netif_is_bridge_master(upper_dev)) {
> 		...
> 	} else if (netif_is_lag_master(upper_dev)) {
> 		...
> 	}
> 
> The same thing applies to the dpaa2_switch_port_changeupper() function
> below.

Understood. If this is going somewhere then don't let me derail it.

,,,

