Return-Path: <netdev+bounces-173862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272DA5C091
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072123B4A33
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43217221F17;
	Tue, 11 Mar 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwQotIIg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96764221F3C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695173; cv=none; b=YtZytmw4wsDvlUlCEyeERT6XUETnZwHVkKDrX1ePX90uBKmtt0LaBp/GLThM2bDWNuYIG+Iggj5MsMqZz3RDbLMVKo+oJmz5X7tKlGYuxfQv9kzyrCxSwA8rf2m4dTA7K8HhI5E+SeAPbpToJmU4qaeS8pEJ2lc4SzzL9Nwb8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695173; c=relaxed/simple;
	bh=8Akx9xfIHaoFx+B9BGpXvkvAx6ZL7g/6u8CiSjKDhhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBb8NkIpE5K2rQbMZofho4H6JH732SjNV5v+sv+ZP85+xtey5TvpV7ezfkxZaij3zTSuKiZ/UEK+AGMBqRRlQKZPhNiFbIasYKb5QNMaLZBS3qpSHFytq7szrq4dMZ/IAGvTPHsWwyrxULKnpi4C7QSLDPqK4n8f4q2EmbevXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwQotIIg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741695171; x=1773231171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Akx9xfIHaoFx+B9BGpXvkvAx6ZL7g/6u8CiSjKDhhA=;
  b=lwQotIIg2tQ6ufiDSL+aflH/xwZ4JBfmfa+LRCUpcpSddh8ElPc7/93I
   5QuFFemuN1ncmHjckrO3MmVMhdnQLHkfGiV8BKLjJx43X/MrThfgkSdd2
   O3NNu6wQx3L6UXP7mg2v77pfbXIBOoKxGbGPMTo8PNGzmOgqvAo6+8cWe
   4Dl36G7WK6tTirkqZDwFZ4ay1f9Wp89D2+Xzfv9COyevcIHpV25daMn6K
   tNmfpBJ1j79Sk/ItnN1jW/E8tXK97ip0AP785CNx6aIJva6Ycuf7wg0Vj
   zRgYTt915xJDuwPg/elQKbfqH90Vf5rWDby6JrXhoerwkmtbHrWAhGzgv
   g==;
X-CSE-ConnectionGUID: EcepKxH+SK2rkBLSr2H08g==
X-CSE-MsgGUID: 6KRB6kbJTZ6DIlx/TkGu6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42606026"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42606026"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:12:50 -0700
X-CSE-ConnectionGUID: 45elzWrBR5mpOfr2/r+0jw==
X-CSE-MsgGUID: uJoCNx5RR1incKUhsNIAcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120792144"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:12:48 -0700
Date: Tue, 11 Mar 2025 13:09:01 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pierre Riteau <pierre@stackhpc.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <Z9An3SRbPWRKVqMc@mev-dev.igk.intel.com>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
 <c22f5a47-7fe0-4e83-8a0c-6da78143ceb3@redhat.com>
 <CA+ny2sxC2Y7bxhkO7HqX+6E_Myf24_trmCUrroKFkyoce7QC9A@mail.gmail.com>
 <Z8//h7IT3cf01bxB@mev-dev.igk.intel.com>
 <3ff973e5-5474-4112-81ad-46b745edd6a9@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff973e5-5474-4112-81ad-46b745edd6a9@stanley.mountain>

On Tue, Mar 11, 2025 at 02:49:43PM +0300, Dan Carpenter wrote:
> On Tue, Mar 11, 2025 at 10:16:55AM +0100, Michal Swiatkowski wrote:
> > On Mon, Mar 10, 2025 at 12:42:13PM +0100, Pierre Riteau wrote:
> > > On Tue, 18 Feb 2025 at 12:56, Paolo Abeni <pabeni@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > On 2/14/25 2:58 PM, Michal Swiatkowski wrote:
> > > > > On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> > > > >> On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > > > >>> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > > > >>> from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > > > >>> devlink_rel_alloc().
> > > > >>
> > > > >> If the same bug exists twice it might exist more times. Did you find
> > > > >> this instance by searching the whole tree? Or just networking?
> > > > >>
> > > > >> This is also something which would be good to have the static
> > > > >> analysers check for. I wounder if smatch can check this?
> > > > >>
> > > > >>      Andrew
> > > > >>
> > > > >
> > > > > You are right, I checked only net folder and there are two usage like
> > > > > that in drivers. I will send v2 with wider fixing, thanks.
> > > >
> > > > While at that, please add the suitable fixes tag(s).
> > > >
> > > > Thanks,
> > > >
> > > > Paolo
> > > 
> > > Hello,
> > > 
> > > I haven't seen a v2 patch from Michal Swiatkowski. Would it be okay to
> > > at least merge this net/devlink/core.c fix for inclusion in 6.14? I
> > > can send a revised patch adding the Fixes tag. Driver fixes could be
> > > addressed separately.
> > > 
> > 
> > Sorry that I didn't send v2, but I have seen that Dan wrote to Jiri
> > about this code and also found more places to fix. I assumed that he
> > will send a fix for all cases that he found.
> > 
> > Dan, do you plan to send it or I should send v2?
> 
> Sorry, no I didn't realize anyone was waiting for me on this.  Could
> you send it?
> 

Sure, I will do it. Thanks for clarification.

> regards,
> dan carpenter
> 

