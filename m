Return-Path: <netdev+bounces-89248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6828A9D7A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D37B25D73
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF1433BF;
	Thu, 18 Apr 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPgyKKxY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57815E5B0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451614; cv=none; b=Lpf3cgIgipVUp9AXeZ+iFgYQJ7kzZxrLJoZ9Z/VXvoF4dHckT+aQPJ1M9MarEwrK2GjV/l3ALjHG19LSio+RdI94G66GWiSGNyHh+7zahkm7O6MJKRBQ/LmrbwTxnMAXooWfYIUZT6dhpMoW82/Thjt5OJcpWoi+I8dlx06XGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451614; c=relaxed/simple;
	bh=3goLA/LDs/swhXhob3N4VYmH4WhAH75ffb2SGuLSFZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWLThvQx2U1HwfwJ0aXAAEDTJWuORkmVVnpCqsH1pci07MyxSCh8v1tDvMur4FWhAIwcA+6PrMKTKEkqibnnt1rWagypMEofLN4ijx/F0UeA6sLj9dVfVTDuQFsDiquEvL7CYYp5siFIfFxJkVuWxfNnoRwt8iAv3c/D5jjrblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPgyKKxY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713451613; x=1744987613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3goLA/LDs/swhXhob3N4VYmH4WhAH75ffb2SGuLSFZw=;
  b=hPgyKKxYEw7f2L8I4lEZdmFr7xl3X+lF0k59/OklOr1jRc5l/zqMFr+v
   5r/m0lJZmNUfqZyqbYtSl7tT2i32bxnXGheX4gR1euhfPEt1KCSL686Aq
   FPnPFN33Z0P/hPfirNm0RCS9cKvVSmDeISmrK2+Bk3ool+QQB01CFdv//
   yhhakpY++kNe5++MeU1w36xlE/L0k5tv1OuXf6FcXHcZSQHBjhzjLdYX0
   iWZ438Z5nTxOyWtdZox3C5HF0CtMKLVjB5DGo+CClIEO5kKcAl/buQMSK
   jYu8bGub8h0aIQwWotjwGTFlG7nfQGRz+RwOarQyh46ozccES/0Ajj2TQ
   g==;
X-CSE-ConnectionGUID: 6i7Pj2PhT66bNNUYosdZnw==
X-CSE-MsgGUID: fYffty5+TD6XDpiEpSa2Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26461366"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="26461366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:46:53 -0700
X-CSE-ConnectionGUID: r8nwLN+HS5yQx2yEsGB8Wg==
X-CSE-MsgGUID: bMgJDw1IT0G4L5Q7ldIoOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23615599"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:46:50 -0700
Date: Thu, 18 Apr 2024 16:46:23 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiEyP+t9uarUrLGO@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
 <ZiEWtQ2bnfSO6Da7@mev-dev>
 <ZiEZ-UKL0kYtEtOp@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEZ-UKL0kYtEtOp@nanopsycho>

On Thu, Apr 18, 2024 at 03:02:49PM +0200, Jiri Pirko wrote:
> Thu, Apr 18, 2024 at 02:48:53PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
> >> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> 
> >> [...]
> >> 
> >> >+/**
> >> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
> >> >+ * @dev: the device to allocate for
> >> >+ *
> >> >+ * Allocate a devlink instance for SF.
> >> >+ *
> >> >+ * Return: void pointer to allocated memory
> >> >+ */
> >> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
> >> 
> >> This is devlink instance for SF auxdev. Please make sure it is properly
> >> linked with the devlink port instance using devl_port_fn_devlink_set()
> >> See mlx5 implementation for inspiration.
> >> 
> >> 
> >
> >I am going to do it in the last patchset. I know that it isn't the best
> 
> Where? Either I'm blind or you don't do it.
> 
> 

You told me to split few patches from first patchset [1]. We agree that
there will be too many patches for one submission, so I split it into
3:
- 1/3 devlink prework (already accepted)
- 2/3 base subfunction (this patchset)
- 3/3 port representor refactor to support subfunction (I am going to
  include it there)

[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/

Thanks,
Michal

> >option to split patchesets like that, but it was hard to do it differently.
> >
> >Thanks,
> >Michal
> >
> >> >+{
> >> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
> >> >+				 &ice_sf_devlink_ops);
> >> >+}
> >> >+
> >> 
> >> [...]

