Return-Path: <netdev+bounces-89704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8D8AB44A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D90A1F22390
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23BC13A3E4;
	Fri, 19 Apr 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZ+iOCSh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04E139599
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547380; cv=none; b=B6K56btCLJqCaRDznmGxTf9fY2oJNtK9EfCNs61uggFG+3v0Ai3WnPzz0ij3b8jffClBjnvOkJZMVkgTmYRmUVs5FhH1fxdtuJb2T/SS3tlbVu2qOCS0Xs0lm3ZR4T5mPioIk0+k28gtorObHmX3iuL2zRDyG+mMgaMQmSJMJo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547380; c=relaxed/simple;
	bh=EdUArIxLmi4/cUNcCa5z9WDKuFyxGLnYbAFYnofKHqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBFNqXbG2x/WMLM03GmXjCUZIBd/JeIAd2u2eVpZ+WWkXwL+uETfaV55GDsVGxdxThhRhq9SGiEi/zkQgPgP+tVsitrJMLJHFC1VAEMuuNSTwA8Cke3CPz2AGieOqa6rckFz4LW3rsgwTWRVUtuRqE305V/vmTlNy/Qy61yuyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZ+iOCSh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713547379; x=1745083379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EdUArIxLmi4/cUNcCa5z9WDKuFyxGLnYbAFYnofKHqc=;
  b=YZ+iOCShp1fMTHALscCw2aYxsP/+fV9ZR+qdFVTDIYsPtIC5FDeQMh5f
   5qOdst45ecfdfyMeEP5Miad62yqgDRyXi6GxWLUE7quXwDuFQH1eTJUaT
   Zz56sKMSsNAOu4sQH0KkK2KUFr6ilwsSR3fMlArwgQTfeAipc0KguzrMp
   VHJ1L921y61F/z3s0XNrY9ESqGjxfzIxTw/AUz+sa3x1nBM1ltJuK6l/x
   XTxhaQQdzySoBXzcZNXp73v4gm8mPX7pZ9We1S88E+Jmiipu19enDcu+u
   zTA+kmg4dQ9dpmP0xLqZyMwazkzSTLKhClvJvWQ6NB4vD/zuxXY3of2uZ
   A==;
X-CSE-ConnectionGUID: bQ9ulHIfTSyBvbNcnT/jnA==
X-CSE-MsgGUID: +clWCx0qRg6NyHeX0jG4sA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12102606"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="12102606"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:22:58 -0700
X-CSE-ConnectionGUID: gzAPrmMVQBig+ZiEozCUbQ==
X-CSE-MsgGUID: +b4NXs07R6m9hOAvrYTgFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23839109"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:22:56 -0700
Date: Fri, 19 Apr 2024 19:22:34 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiKoWmX34QEdEgJO@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
 <ZiEWtQ2bnfSO6Da7@mev-dev>
 <ZiEZ-UKL0kYtEtOp@nanopsycho>
 <ZiEyP+t9uarUrLGO@mev-dev>
 <ZiE_nUEsGT8Cd3BK@nanopsycho>
 <ZiFGOkSMWs+/N2vI@mev-dev>
 <ZiFXj-58u2shLL3g@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiFXj-58u2shLL3g@nanopsycho>

On Thu, Apr 18, 2024 at 07:25:35PM +0200, Jiri Pirko wrote:
> Thu, Apr 18, 2024 at 06:11:38PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, Apr 18, 2024 at 05:43:25PM +0200, Jiri Pirko wrote:
> >> Thu, Apr 18, 2024 at 04:46:23PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >On Thu, Apr 18, 2024 at 03:02:49PM +0200, Jiri Pirko wrote:
> >> >> Thu, Apr 18, 2024 at 02:48:53PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >> >On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
> >> >> >> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >> >> 
> >> >> >> [...]
> >> >> >> 
> >> >> >> >+/**
> >> >> >> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
> >> >> >> >+ * @dev: the device to allocate for
> >> >> >> >+ *
> >> >> >> >+ * Allocate a devlink instance for SF.
> >> >> >> >+ *
> >> >> >> >+ * Return: void pointer to allocated memory
> >> >> >> >+ */
> >> >> >> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
> >> >> >> 
> >> >> >> This is devlink instance for SF auxdev. Please make sure it is properly
> >> >> >> linked with the devlink port instance using devl_port_fn_devlink_set()
> >> >> >> See mlx5 implementation for inspiration.
> >> >> >> 
> >> >> >> 
> >> >> >
> >> >> >I am going to do it in the last patchset. I know that it isn't the best
> >> >> 
> >> >> Where? Either I'm blind or you don't do it.
> >> >> 
> >> >> 
> >> >
> >> >You told me to split few patches from first patchset [1]. We agree that
> >> >there will be too many patches for one submission, so I split it into
> >> >3:
> >> >- 1/3 devlink prework (already accepted)
> >> >- 2/3 base subfunction (this patchset)
> >> >- 3/3 port representor refactor to support subfunction (I am going to
> >> >  include it there)
> >> 
> >> Sorry, but how is this relevant to my suggestion to use
> >> devl_port_fn_devlink_set() which you apparently don't?
> >> 
> >
> >Devlink port to link with is introduced in the port representor part.
> >Strange, but it fitted to my splitting. I can move
> >activation/deactivation part also to this patchset (as there is no
> >devlink port to call it on) if you want.
> 
> You have 7 more patches to use in this set. No problem. Please do it all
> at once.
> 

Ok, as whole will still not fit into 15 I sent preparation patchset for
representor [1].

Now the patchset based on this preparation have 14 patches, so I hope it
is fine (including linking that you mentioned). I will send it right
after the preparation patchset is applied.

I am going on the 2 weeks vacation, so my replies will be delayed.

[1] https://lore.kernel.org/netdev/20240419171336.11617-1-michal.swiatkowski@linux.intel.com/T/#t

Thanks,
Michal

> 
> >
> >> 
> >> >
> >> >[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
> >> >
> >> >Thanks,
> >> >Michal
> >> >
> >> >> >option to split patchesets like that, but it was hard to do it differently.
> >> >> >
> >> >> >Thanks,
> >> >> >Michal
> >> >> >
> >> >> >> >+{
> >> >> >> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
> >> >> >> >+				 &ice_sf_devlink_ops);
> >> >> >> >+}
> >> >> >> >+
> >> >> >> 
> >> >> >> [...]

