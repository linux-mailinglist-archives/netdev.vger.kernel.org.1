Return-Path: <netdev+bounces-201086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9938AE80B7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5201189BDDE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7582BDC10;
	Wed, 25 Jun 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fax0+P82"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C22C08C1
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850073; cv=none; b=Dxyp5E0QgkAwBemLKNcHbu2sdZY/93OzuFYYGNkImPODX5CdAy1kZbI3u+jm6rKz2P2zTQxJwpdBGIhQ7TPA+0aR4uxuii1fslGPlbYFiVtSXsLfsTGzW12SlBo2ShV5c+1/Q5vjCTs+tbyF1ibKF6RHE3N3HMrsicjsaTg8sC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850073; c=relaxed/simple;
	bh=2u/uQdt6j4aCNAtZeJHsfD+OM1eawjFzCDHyY3UJ7WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKb93RtK7tZ2mbJMc9ryyVeUlhYYaZniF3ktLE+YmDeAERLY5wxIWDVbfqLjsee1FqZTRZGbyHxV/6kJWXwUxvrdzueAdAZ/I6AnmK9mxleRJ9ZbS3CFxgVUwPrWFkmtBvWjoKLCBgbWs/HLCc7suIbkeDWO+qU9LwKpnIgyJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fax0+P82; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750850072; x=1782386072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2u/uQdt6j4aCNAtZeJHsfD+OM1eawjFzCDHyY3UJ7WA=;
  b=Fax0+P820Qm5tlWD7VlRZnY8gCeDq25xAa1hv9J4/TUCWnurOZEkib2n
   ZlmqPze8WeHsTsJ7p87GiuUZ303NJAxB0fRhRzNdIxLLztChtruzGTIqI
   tLl0o2enRUrZYXsb2tDUYtg+8gwhWUUJOf99i1fYavlPQpP5sGXHci8Qh
   2Nzmq09mVH6QkAqIYw6SvmmKF2wzmCq7aPA/RE+1Yiu55GJkCjxeJtD+F
   cw0C/VhsQDU+0s60Ci/AlSYoJfyE5WosFMXweR2x0rkGBghP0IV6dBQfv
   XpToYJCuKPGITpmyd23gjWvnXzIbiz366A+BANCLr2SVD6EJhpNx4s5PZ
   Q==;
X-CSE-ConnectionGUID: Xr0peSZgR6upp6pW8+nzdA==
X-CSE-MsgGUID: nnIxYoAzRB6KTuRfDU/Rdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53180548"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53180548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:14:31 -0700
X-CSE-ConnectionGUID: o80/7OMJSOOXqA3R827V3A==
X-CSE-MsgGUID: sPqdtOMTTqGkdcCbC+TtmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152319529"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 04:14:28 -0700
Date: Wed, 25 Jun 2025 13:13:38 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Michal Swiatkowski' <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net v2 3/3] net: ngbe: specify IRQ vector when the number
 of VFs is 7
Message-ID: <aFvZ4miOKWbj1Xvp@mev-dev.igk.intel.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com>
 <20250624085634.14372-4-jiawenwu@trustnetic.com>
 <aFu6ph+7xhWxwX3W@mev-dev.igk.intel.com>
 <030e01dbe5b3$50ee41e0$f2cac5a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030e01dbe5b3$50ee41e0$f2cac5a0$@trustnetic.com>

On Wed, Jun 25, 2025 at 05:27:05PM +0800, Jiawen Wu wrote:
> > > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > > index 6eca6de475f7..b6252b272364 100644
> > > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > > @@ -87,7 +87,8 @@
> > >  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
> > >
> > >  #define NGBE_INTR_ALL				0x1FF
> > > -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> > > +#define NGBE_INTR_MISC(A)			((A)->num_vfs == 7 ? \
> > > +						 BIT(0) : BIT((A)->num_q_vectors))
> > 
> > Isn't it problematic that configuring interrupts is done in
> > ndo_open/ndo_stop on PF, but it depends on numvfs set in otther context.
> > If you start with misc on index 8 and after that set numvfs to 7 isn't
> > it fail?
> 
> When setting num_vfs, wx->setup_tc() is called to re-init the interrupt scheme.
> 

Right, maybe to be more clear you should use wx->msix_entry->entry
wherever misc index is used.

