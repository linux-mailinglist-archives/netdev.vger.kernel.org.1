Return-Path: <netdev+bounces-96268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19388C4C42
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F31F216BC
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950E1CFA9;
	Tue, 14 May 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDYdqOSi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E21BF3F
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668079; cv=none; b=tRdPrPitYbuFS6nX4E87bP04wkuUKeoYM++6ssaAO1c4eUEtF/4kglU86/bwHTfVOeVGQJYvQX0yNs00wncOBfhFlOQ4u4AgjFTTgzNM2rihiFdK9JVn4DDXvpQMFCHxnLFN/K5tu8f930ngfNKeIpHbiCDRQp0/b9Rheg7LWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668079; c=relaxed/simple;
	bh=5m+xGYlMBwxNRJDWZERhtAnbSDV3/VyF/8EZ/X++y9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHciivS7D9T2BlO9JzEq5GDShsxfYrwlfVLcOEu8yG5q7MSC0InxCiY6PpsLs4hQwRj3m8eMG7QWQhwKCgUYcZGssMItI0Pq5IqAky3VuzZzZyVvBhnCRI85UMjv0xVaJsmP86UxjkDd56Rb7ic9Rb4HUTZp8ev9jVHeeNOVUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDYdqOSi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715668078; x=1747204078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5m+xGYlMBwxNRJDWZERhtAnbSDV3/VyF/8EZ/X++y9w=;
  b=QDYdqOSiQEiwS0MQAkKX7juRTkG8LcGoy5+HYn0dUkNG961X05DkDVCa
   3A+/iTLvFE6cO6gny93IA4yD2tYJmiBddC9BUNpXIWu1+XhWDvYjqtqja
   H5dXSdZuErfLYhGjE5NiInqm5BEEqh6S0ncVsmJnXYiM2/Uz0bjFG3oyz
   0gXYe//RBooVoXpZ3NjSjXJlyHorgmLxYURiPQpINNoveVeruIYK2wJbB
   izgtcky46+PHB7J/U+aenVVIrseq7NTsr1V4KAUVKNC1QjRV18dvMrEFh
   qZcG8AXRVaIYFXbhauQSUzzecs8VZHBTJEew0NTdkymIlcszUGldLwP9D
   g==;
X-CSE-ConnectionGUID: w3VyE3wFTR2+qj70LHmayA==
X-CSE-MsgGUID: +Y18y0bpRsmddSh2qqZWYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11847424"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11847424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 23:27:57 -0700
X-CSE-ConnectionGUID: c/U7QafnSAiVHGH/v6KDnw==
X-CSE-MsgGUID: M26YKeuXQC2oV9oJNWM6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35125409"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 23:27:54 -0700
Date: Tue, 14 May 2024 08:27:22 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 03/15] ice: add basic devlink subfunctions support
Message-ID: <ZkMESjRIQc2fHF6M@mev-dev>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
 <20240513160551.GP2787@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513160551.GP2787@kernel.org>

On Mon, May 13, 2024 at 05:05:51PM +0100, Simon Horman wrote:
> On Mon, May 13, 2024 at 10:37:23AM +0200, Michal Swiatkowski wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > index 9223bcdb6444..f20d7cc522a6 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > @@ -4,9 +4,42 @@
> >  #ifndef _DEVLINK_PORT_H_
> >  #define _DEVLINK_PORT_H_
> >  
> > +#include "../ice.h"
> > +
> > +/**
> > + * struct ice_dynamic_port - Track dynamically added devlink port instance
> > + * @hw_addr: the HW address for this port
> > + * @active: true if the port has been activated
> > + * @devlink_port: the associated devlink port structure
> > + * @pf: pointer to the PF private structure
> > + * @vsi: the VSI associated with this port
> 
> nit: An entry for @sfnum should go here.
> 

Thanks, will add it

> > + *
> > + * An instance of a dynamically added devlink port. Each port flavour
> > + */
> > +struct ice_dynamic_port {
> > +	u8 hw_addr[ETH_ALEN];
> > +	u8 active: 1;
> > +	struct devlink_port devlink_port;
> > +	struct ice_pf *pf;
> > +	struct ice_vsi *vsi;
> > +	u32 sfnum;
> > +};
> 
> ...

