Return-Path: <netdev+bounces-95343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE68C1EFA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA4D282723
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA7B15ECEC;
	Fri, 10 May 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dL9r9ZWC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1D15E810
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715326312; cv=none; b=Z4CfOCqezMihKiY7K1yZxGQeaKi0CDTOXtLwkTCJYcgFu1UYOpw4NpyAkymp5KRt4+sXVIpbiXQO3P9PegHdGejgHCutkuf8fyYnmDZLgqoyu5W50fX42cNOn1a2gz9IfeCg6Dny0BSS1es6AdKX8XYSP4yiFSLAj/+C3zQRkYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715326312; c=relaxed/simple;
	bh=OAlirC+gOM9PRA8w/mTLy087HEypbm6XLwuNEFoWgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUZE9D02Obz9m3T2g8gKFBC9Wqsr2DrSVxILprkxxVHv1xkngP9jybNC3X8ZyzXbH+iM9QwN1JzRV70b5jOytLNvYPya9K0rMpSmKdmYFGEjm2rm+7PdNON80VfnTGzjIREMCkLmou2rzkvibE7q3lBXG+fSZ0e5PQgm9GuOQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dL9r9ZWC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715326311; x=1746862311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OAlirC+gOM9PRA8w/mTLy087HEypbm6XLwuNEFoWgWY=;
  b=dL9r9ZWCK+Aapk/PqfQ13MYHydN3DBZPNibSP1YUWgKWtNkkim5rmVli
   GbFBu/YjwtEbffBPm7j437Q0760uRiyKRdwZWfj8T0B9xz41XVPrGUut0
   X1SdamJ5KQNTBU8ZBOAHWc8oGFRbo6yPwcZtwdHN0pnF9LgjcWQgX9YsU
   4rvhmTKZvD0VKCcEtALKVJ3OJKP9yGu3AjLvDolWq3OPgAN2/bFD/B0dq
   8HOXPav6TnJAjLrNx7UL2jMSkODpftWzmUN269ZALD6vN5T2sow/QnZiT
   tu/EiuhPBndqzK/0xG2rXJWI79BVGd5RcRUc8YY5ecPG9jQnvpvp/hOTp
   w==;
X-CSE-ConnectionGUID: qw6iysvlR2+Q11/aTDmPHw==
X-CSE-MsgGUID: RfcTXRDmSm6J3mIPp53yiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21965487"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21965487"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:31:50 -0700
X-CSE-ConnectionGUID: z0ndINDHSoSj337AvYImAg==
X-CSE-MsgGUID: 4Jd23kDZRk+YaMH5xlz0HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29906290"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:31:47 -0700
Date: Fri, 10 May 2024 09:31:15 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 08/14] ice: create port representor for SF
Message-ID: <Zj3NQw1BxqtOS9VG@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-9-michal.swiatkowski@linux.intel.com>
 <ZjywddcaIae0W_w3@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjywddcaIae0W_w3@nanopsycho.orion>

On Thu, May 09, 2024 at 01:16:05PM +0200, Jiri Pirko wrote:
> Tue, May 07, 2024 at 01:45:09PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >Store subfunction and VF pointer in port representor structure as an
> >union. Add port representor type to distinguish between each of them.
> >
> >Keep the same flow of port representor creation, but instead of general
> >attach function create helpers for VF and subfunction attach function.
> >
> >Type of port representor can be also known based on VSI type, but it
> >is more clean to have it directly saved in port representor structure.
> >
> >Create port representor when subfunction port is created.
> >
> >Add devlink lock for whole VF port representor creation and destruction.
> >It is done to be symmetric with what happens in case of SF port
> >representor. SF port representor is always added or removed with devlink
> >lock taken. Doing the same with VF port representor simplify logic.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../ethernet/intel/ice/devlink/devlink_port.c |   6 +-
> > .../ethernet/intel/ice/devlink/devlink_port.h |   1 +
> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 +++++++++---
> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
> > drivers/net/ethernet/intel/ice/ice_repr.c     | 124 +++++++++++-------
> > drivers/net/ethernet/intel/ice/ice_repr.h     |  21 ++-
> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> > 8 files changed, 187 insertions(+), 80 deletions(-)
> 
> This calls for a split to at least 2 patches. One patch to prepare and
> one to add the SF support?

Is 187 insertions and 80 deletions too many for one patch? Or the
problem is with number of files changed?

I don't see what here can be moved to preparation part as most changes
depends on each other. Do you want me to have one patch with unused
functions that are adding/removing SF repr and another with calling
them?

Thanks,
Michal

