Return-Path: <netdev+bounces-173805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFDA5BBEA
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C73188B02D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083A1EBFED;
	Tue, 11 Mar 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8jLv+lx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DF1E32D6
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684851; cv=none; b=TrKJNlZit/oxYsOpowRXQruZ/Lyzr9ROFBi0wIhwTOWxdUGOW+aEJxYIHwRvnntAQOuNMUlkimvGoGy5lK4xLCTOw7f/2ieSJNXQcvkOVcI2MjqzX1OnoKQK5VV9PzgcCfhR93u9xW0lByjBa78c++V62NWYQl9874pR0F0ekKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684851; c=relaxed/simple;
	bh=Eitzj/kDcL0rzS7h1KOU4+wpLzl1Qpg7WKR2rHgnWdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfI4XUvqK1JXxyUyzYnK1Z31IJlzOx9cpqGgdp263WqdrBgRnRFoZ88oBUE5hVZMuyenJvh0q5wlCDq/iZWAk38w7yW2dl5U7KEbDc0wEhCh/g4UPEEznnjLaebFwdWkVT5KtQAChzql6hkPH49872rK32WLALjfN2GsbjDfOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8jLv+lx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741684849; x=1773220849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eitzj/kDcL0rzS7h1KOU4+wpLzl1Qpg7WKR2rHgnWdE=;
  b=X8jLv+lx/WdXZRtlR3AjT1Rxl/VXKvYfE+0Pq6Q9UZYRw9ml5Fbv264N
   vcS99jf5C5ONjVLANgyjZWSWoJI9xgLnR4th/FLhX69vU27ibrRnCpQN6
   GNeloObff45t2J28GnnjFslDzpYDNa15UDxkjtGQh7TQnFLcyo03wfp9r
   Z6M+Bh/LrPntLYNgt+FL5ZRFY6gRMXJjoP0/bkYU5UgX6mbxKhM9jgKGh
   RLzdG3nH2q9hNijv8yZGI2aTA7R5vnZZd/DxJz76wK+jF6cJ0sZTcoLAm
   BW6oKgYpnI3/BcjxmKcvMynJkVNFy6QVjWNYw6cLMrFMchC+RWxLa6zhL
   A==;
X-CSE-ConnectionGUID: cMKspIUVQT240PslZOPo+w==
X-CSE-MsgGUID: We/j8mS4Q9yY5XJo4jED9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46360869"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="46360869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:20:49 -0700
X-CSE-ConnectionGUID: Lk4bLG3sQ4+JDLrx7MzvGg==
X-CSE-MsgGUID: Yb4aYY9CQB+XmigzkorN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120187881"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:20:47 -0700
Date: Tue, 11 Mar 2025 10:16:55 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Pierre Riteau <pierre@stackhpc.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <Z8//h7IT3cf01bxB@mev-dev.igk.intel.com>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
 <c22f5a47-7fe0-4e83-8a0c-6da78143ceb3@redhat.com>
 <CA+ny2sxC2Y7bxhkO7HqX+6E_Myf24_trmCUrroKFkyoce7QC9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ny2sxC2Y7bxhkO7HqX+6E_Myf24_trmCUrroKFkyoce7QC9A@mail.gmail.com>

On Mon, Mar 10, 2025 at 12:42:13PM +0100, Pierre Riteau wrote:
> On Tue, 18 Feb 2025 at 12:56, Paolo Abeni <pabeni@redhat.com> wrote:
> >
> >
> >
> > On 2/14/25 2:58 PM, Michal Swiatkowski wrote:
> > > On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> > >> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > >>> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > >>> from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > >>> devlink_rel_alloc().
> > >>
> > >> If the same bug exists twice it might exist more times. Did you find
> > >> this instance by searching the whole tree? Or just networking?
> > >>
> > >> This is also something which would be good to have the static
> > >> analysers check for. I wounder if smatch can check this?
> > >>
> > >>      Andrew
> > >>
> > >
> > > You are right, I checked only net folder and there are two usage like
> > > that in drivers. I will send v2 with wider fixing, thanks.
> >
> > While at that, please add the suitable fixes tag(s).
> >
> > Thanks,
> >
> > Paolo
> 
> Hello,
> 
> I haven't seen a v2 patch from Michal Swiatkowski. Would it be okay to
> at least merge this net/devlink/core.c fix for inclusion in 6.14? I
> can send a revised patch adding the Fixes tag. Driver fixes could be
> addressed separately.
> 

Sorry that I didn't send v2, but I have seen that Dan wrote to Jiri
about this code and also found more places to fix. I assumed that he
will send a fix for all cases that he found.

Dan, do you plan to send it or I should send v2?

Thanks,
Michal

> Thanks,
> Pierre

