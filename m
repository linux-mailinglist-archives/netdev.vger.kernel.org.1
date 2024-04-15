Return-Path: <netdev+bounces-87788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA88A4A5C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC361C213BD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF58374E9;
	Mon, 15 Apr 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH5ZAPPY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D86374C4
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169801; cv=none; b=ZTUrWNOlk5Sh1OqNrSunyeykFNrVfOm6a2K+Yx+yufXFc6pSyWgWdCbjjz2om+GY4U3Sd+Ogn8Kl5nYrfHmdZYk/C4GDvtD0epifyYgozZfFR+eIIP+B+eMX8T9k94tjQasI4jLeLGCvNl6Kc5slJMu/K28Z3YQ4LKwoasYBEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169801; c=relaxed/simple;
	bh=E0+wF2svgj0A6HgZD/KpDdEaWwyfj1+v8zzDw1IfaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We2r7tctzwrr+Dfj+MrU/LtvPB2YKfdYrY8vKNut9S0+22wPPoVGQzi+YrZfIWPKeRWvHhz0+fbNt8G16Q/INNUX0EA+Rw5GU0sqt39m9M5BX8ZoJETkV3DCy9VZFVSI/qq0ud/4w+u/1EZE8bZunAKhZ8Jwv+pXeLOhgGRsz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH5ZAPPY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713169801; x=1744705801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0+wF2svgj0A6HgZD/KpDdEaWwyfj1+v8zzDw1IfaKA=;
  b=iH5ZAPPYeuhofe2YT+55NRQP+a4nNKvqhgfSAPuLgL7S/QAHTPCZ1X6j
   AE2/ZNEMb3wvKgXupglTNdfuazztVpSwuDxr64Y3llnDDiSicoUzVPfgd
   EruLXAfuKxavaM5pxWWWIR/zFaiLps1JbSZFhduZdbv6fIFluvvYx6c++
   GVeQ7vjRpZjB6IJw2fbSzEaZaszSBwT3kuEHsg1bJEpABvL1i9hu7j0rh
   zWp77qIpFNFrr96/dmDxUPdXRUE4vzYUq7bMhqnxWvMKt7SZN4yJdPT4X
   uhj3YtLihGEHDuL90F7b8bPlgarWyMlvS0hZt37otMi/iU/Az6xJ5q3IE
   Q==;
X-CSE-ConnectionGUID: mt0l6bdkQ+OJH6sm5FAguQ==
X-CSE-MsgGUID: 56aC7+RkRfGNnOqpgZx1ZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="31027111"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="31027111"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:30:00 -0700
X-CSE-ConnectionGUID: AxTRTaxVRy2bEsm/vr4VXw==
X-CSE-MsgGUID: mkrMqJzjTcy38PltZX/q/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="53053271"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:29:56 -0700
Date: Mon, 15 Apr 2024 10:29:33 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com, pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 5/7] ice: base subfunction aux driver
Message-ID: <ZhzlbSHw17KEvSvB@mev-dev>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-6-michal.swiatkowski@linux.intel.com>
 <da5f3048-e90b-4e34-be23-602c8a9edeb2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5f3048-e90b-4e34-be23-602c8a9edeb2@intel.com>

On Fri, Apr 12, 2024 at 01:44:45PM +0200, Przemek Kitszel wrote:
> On 4/12/24 08:30, Michal Swiatkowski wrote:
> > From: Piotr Raczynski <piotr.raczynski@intel.com>
> > 
> > Implement subfunction driver. It is probe when subfunction port is
> > activated.
> > 
> > VSI is already created. During the probe VSI is being configured.
> > MAC unicast and broadcast filter is added to allow traffic to pass.
> > 
> > Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/Makefile     |   1 +
> >   drivers/net/ethernet/intel/ice/ice_main.c   |  10 ++
> >   drivers/net/ethernet/intel/ice/ice_sf_eth.c | 130 ++++++++++++++++++++
> >   drivers/net/ethernet/intel/ice/ice_sf_eth.h |   9 ++
> >   4 files changed, 150 insertions(+)
> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> > 
> > +
[...]

> > +/**
> > + * ice_sf_dev_remove - subfunction driver remove function
> > + * @adev: pointer to the auxiliary device
> > + *
> > + * Deinitalize VSI and netdev resources for the subfunction device.
> > + */
> > +static void ice_sf_dev_remove(struct auxiliary_device *adev)
> > +{
> > +	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
> > +	struct devlink *devlink = priv_to_devlink(sf_dev->priv);
> 
> RCT
> 

Will fix

Thanks,
Michal

[...]

