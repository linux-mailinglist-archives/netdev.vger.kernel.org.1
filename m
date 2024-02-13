Return-Path: <netdev+bounces-71246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3798852CF2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A3B1F22347
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978D5338B;
	Tue, 13 Feb 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yzh56/3M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794A5338F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817388; cv=none; b=N8P5vi1gI5gXHFYEFziTSZ24Kfn+5HGWj22TnXzINQDWRSfYXZR6JSXSrVSjStEGcUjtHO1g6o9fioctizXFlyHjOew3NOiXOWng9A8hNXEBfvXHrwXtxICibN1TDI7MU4D9sKtR42y28p2vULDNu7mpNm9vg5Zpf5ipsD4j3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817388; c=relaxed/simple;
	bh=AQvTYTQ/t0R+kM1G0adoFJ97oIMfIbtMuUoQfoCLQoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obRZUsunH9AF8sTwfSaSoWLwpj3YHBd6C7/pweARHHXTUEABbHu1ynz/5S+FTWiW0F/rzDmi3JV7BdwxjZTDu/gHobf729dd8+3WqoESZHRkfb6c6hkLgr1nBnXIeiKG+um7A0bHUcwGc41gFXfnny8VNL4q9uj/8HO8ipYo2bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yzh56/3M; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707817387; x=1739353387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AQvTYTQ/t0R+kM1G0adoFJ97oIMfIbtMuUoQfoCLQoY=;
  b=Yzh56/3Mt0pNqd5QSv4OY5ifB4gHuRGgYBvbAtGJCAfpxMHXbQhicBSb
   3JkVcg/e54spOlcHiho9UPGcFmRCgZnTaVZAtFhjFzjipPVKyBut8aUxw
   eogXhNNaCOIA6pD2rI5acgFtX6IG8aXegMJC093HMD8oIqF3EXVlo8/Rm
   VeN0SqCmGhqi9hEsu3b0VIR4OPpsbJ82fV/tJaML8+uKwvjxl7fdoLayz
   IUEpVL41a6/v77iwmavJHoHruomi4Skrjb5HkglEc7riB2Ped2xetye1y
   1kboPYv8eXIHcxgianCDcnWOjK3i6ZcWB6+KwtNGU0Leo2TBsQs4I9EZ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1967956"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1967956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826064172"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="826064172"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 01:43:03 -0800
Date: Tue, 13 Feb 2024 10:43:00 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 06/15] ice: add subfunction aux driver support
Message-ID: <Zcs5pFtmXzTxWO5s@mev-dev>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
 <Zcsu6MCX-XkS8bki@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcsu6MCX-XkS8bki@nanopsycho>

On Tue, Feb 13, 2024 at 09:57:12AM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 08:27:15AM CET, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Instead of only registering devlink port by the ice driver itself,
> >let PF driver only register port representor for a given subfunction.
> >Then, aux driver is supposed to register its own devlink instance and
> >register virtual devlink port.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../intel/ice/devlink/ice_devlink_port.c      |  52 ++++-
> > .../intel/ice/devlink/ice_devlink_port.h      |   6 +
> > drivers/net/ethernet/intel/ice/ice_devlink.c  |  28 ++-
> > drivers/net/ethernet/intel/ice/ice_devlink.h  |   3 +
> > drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 214 ++++++++++++++++--
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  21 ++
> > 7 files changed, 302 insertions(+), 31 deletions(-)
> 
> Could you please split this. I see that you can push out 1-3 patches as
> preparation.

Do you mean 1-3 patchses from this patch, or from whole patchset? I mean,
do you want to split the patchset to two patchsets? (by splitting patch
from the patchset I will have more than netdev maximum; 15 I think). 

Thanks,
Michal

