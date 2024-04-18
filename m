Return-Path: <netdev+bounces-89304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67488A9FB6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8DB2865F4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2B16F8E6;
	Thu, 18 Apr 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJEGcUd+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD0156F54
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456727; cv=none; b=E8yDtcw8S6qOJw4qN/P0YBBV9mU4HFLhL36Gk2WMjN84rDE6EgJevn5sm1fdEGlS8X4BrcRGueP9Lf5uH8PuGARYygbAT8LNJUwPdYb8GlBxv6LgWUgrubD33oJKWH0zN5EBw5RMBBFjc3Yx28iz9t1uZgcXoWzafMfOWcb2ZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456727; c=relaxed/simple;
	bh=JCnrU8c7Zw1AtPOyyKJXkJJ32vAKwkBAsO6pur/ATc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC+ZUpkeBAauk6XAU14Vz4Ni0y8GeRgnkrgiOgbTvuW2bRDdYdNelz5yCVd7ZtYL7UAQRPI9r1IaZsNjdmAz09ji6Zm9KrBrQ+GkZnDy7HrR9jNDy+CrOiQEHXYyx0s4q/muSJEyt9GmvvuUA7yHGnfh1KkwvVwvToT+M4zVUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJEGcUd+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713456725; x=1744992725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JCnrU8c7Zw1AtPOyyKJXkJJ32vAKwkBAsO6pur/ATc8=;
  b=OJEGcUd+SheglxZbVnkEsax2zearTLOI/RU++pJYjNw55AmZnQhRXsAo
   B2WtGDLRE106AB/FtDKOf/8VF0d3szey9rkUWncniScZfnJRzUJsYxluV
   yii1VnAUKDqZ6PUlSxW3g95VUD08vU2PW3M2uumFAXoRZ+80WnzNOllh7
   o+ijEmuRcoQPVqqp+emC2wvFuK36ongIDyVcNzf03+mk8WO9gFb9fhpXt
   m8Ma/dK3MbCt8m+GVRIkr9psu/5RWF7JhX86Fgolz1QTJq3joIp9wxy+e
   xCShhEUvRc29wNOUJqcDj6ndg6qYg1ujgHfaiVhSXnwWykRyJ32wWoz2x
   w==;
X-CSE-ConnectionGUID: LGkkbiVKSIG64fDi66UecQ==
X-CSE-MsgGUID: 1Vqz0t4sR+CfObl2ZCZ/OA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8885863"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8885863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 09:12:04 -0700
X-CSE-ConnectionGUID: uYtWlc6xSjGS2nDDTbNzXg==
X-CSE-MsgGUID: JqkKWJdxQVqjGgARR9DC6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="46316502"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 09:12:01 -0700
Date: Thu, 18 Apr 2024 18:11:38 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiFGOkSMWs+/N2vI@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
 <ZiEWtQ2bnfSO6Da7@mev-dev>
 <ZiEZ-UKL0kYtEtOp@nanopsycho>
 <ZiEyP+t9uarUrLGO@mev-dev>
 <ZiE_nUEsGT8Cd3BK@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiE_nUEsGT8Cd3BK@nanopsycho>

On Thu, Apr 18, 2024 at 05:43:25PM +0200, Jiri Pirko wrote:
> Thu, Apr 18, 2024 at 04:46:23PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, Apr 18, 2024 at 03:02:49PM +0200, Jiri Pirko wrote:
> >> Thu, Apr 18, 2024 at 02:48:53PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
> >> >> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >> 
> >> >> [...]
> >> >> 
> >> >> >+/**
> >> >> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
> >> >> >+ * @dev: the device to allocate for
> >> >> >+ *
> >> >> >+ * Allocate a devlink instance for SF.
> >> >> >+ *
> >> >> >+ * Return: void pointer to allocated memory
> >> >> >+ */
> >> >> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
> >> >> 
> >> >> This is devlink instance for SF auxdev. Please make sure it is properly
> >> >> linked with the devlink port instance using devl_port_fn_devlink_set()
> >> >> See mlx5 implementation for inspiration.
> >> >> 
> >> >> 
> >> >
> >> >I am going to do it in the last patchset. I know that it isn't the best
> >> 
> >> Where? Either I'm blind or you don't do it.
> >> 
> >> 
> >
> >You told me to split few patches from first patchset [1]. We agree that
> >there will be too many patches for one submission, so I split it into
> >3:
> >- 1/3 devlink prework (already accepted)
> >- 2/3 base subfunction (this patchset)
> >- 3/3 port representor refactor to support subfunction (I am going to
> >  include it there)
> 
> Sorry, but how is this relevant to my suggestion to use
> devl_port_fn_devlink_set() which you apparently don't?
> 

Devlink port to link with is introduced in the port representor part.
Strange, but it fitted to my splitting. I can move
activation/deactivation part also to this patchset (as there is no
devlink port to call it on) if you want.

> 
> >
> >[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
> >
> >Thanks,
> >Michal
> >
> >> >option to split patchesets like that, but it was hard to do it differently.
> >> >
> >> >Thanks,
> >> >Michal
> >> >
> >> >> >+{
> >> >> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
> >> >> >+				 &ice_sf_devlink_ops);
> >> >> >+}
> >> >> >+
> >> >> 
> >> >> [...]

