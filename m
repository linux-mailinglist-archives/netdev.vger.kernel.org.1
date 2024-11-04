Return-Path: <netdev+bounces-141519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203379BB35B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8454284ED6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82DF1B3945;
	Mon,  4 Nov 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l25Z6U4O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119001B3932
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719643; cv=none; b=fXe7S0zozCzBoItdM5RTAcZUDkvIBMd5Ksr7kmEbnRf6QxNYt2J+blT7vH9rcZhWH3eJHQCX+F2eKF+czH5TNfwetcuP1Fl3niUGD2AnjkmRleyfejGtLOtFihPIDSZmOdQdIyd5xg3ov43ggIRfBCeNF4FjDLPFhoG8nbhgjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719643; c=relaxed/simple;
	bh=Fry7u0FCV7hEmGhDdvK6TiCYO+iZUrJRnhJBv25/1aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eua+QY6lu5msPd8J3PZZ3nm6oyM6rJrGTfZbpJuj1CAV+0aJRnvvGOi810QhfviOfziovfm9EeuBG5E1y0nMjHVCsHuZxWvOwuT8dcwTQQFbM94jYiGdELbzHWnS9z5+MH+JLaC1Vxv6ltonE/Evr5VvolN4s8+dEV8RHyAEoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l25Z6U4O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730719642; x=1762255642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fry7u0FCV7hEmGhDdvK6TiCYO+iZUrJRnhJBv25/1aQ=;
  b=l25Z6U4OUlcVA4esnEEAfDrj7K5uABteHXTRR7A2uinba0bv9Vr6Omat
   UViUj+TJag3R7AAOQLxp6+sJkJ6UzMgtnyyoxE4Uf2OA0w3yaov2UhKkc
   nGgI6HYmsTJN3Sia20nZsLkE+UzK41vxMqwL2ZJR171aO2Tc9UgD5ndF5
   ECOQwiru095FOPLvZUJEG5f8Ft5Dj4ejRxamDdl9yyhVx09Ex2QYhTggV
   xVytFN7ig+QndktCR1xAr0zceOtiVE70OXEIBlTAAAqPPr5QU0WL95rZ/
   qR46Jhlhq/sSNYSVm/yOjeaAZtfOajcUcBqtQrnVe+6Qkp3U8goXMm9ZV
   A==;
X-CSE-ConnectionGUID: 5pOWh/G3TxqEe1Q0ylLjhw==
X-CSE-MsgGUID: Q/amOyHoTsGdzERYAcsUkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30589066"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30589066"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:27:21 -0800
X-CSE-ConnectionGUID: 6dM8c9XQRPa5zvtVi6vc4Q==
X-CSE-MsgGUID: /SqGGiPXQHuBuF+PQwm5GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83559045"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:27:18 -0800
Date: Mon, 4 Nov 2024 12:24:38 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: David Laight <David.Laight@aculab.com>, wojciech.drewek@intel.com,
	marcin.szycik@intel.com, netdev@vger.kernel.org,
	konrad.knitter@intel.com, pawel.chmielewski@intel.com,
	horms@kernel.org, intel-wired-lan@lists.osuosl.org,
	pio.raczynski@gmail.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, jiri@resnulli.us,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] Small Integers: Big Penalty
Message-ID: <Zyiu9phq8/EchHxd@mev-dev.igk.intel.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
 <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>
 <ZyhxmxnxPcLk2ZcX@mev-dev.igk.intel.com>
 <ad5bf0e312d44737a18c076ab2990924@AcuMS.aculab.com>
 <840b32a0-9346-4576-97ba-17af12eb4db4@molgen.mpg.de>
 <478248d8-559b-4324-a566-8ce691993018@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478248d8-559b-4324-a566-8ce691993018@molgen.mpg.de>

On Mon, Nov 04, 2024 at 10:12:14AM +0100, Paul Menzel wrote:
> [Cc: -nex.sw.ncis.nat.hpm.dev@intel.com (550 #5.1.0 Address rejected.)]
> 
> Am 04.11.24 um 10:09 schrieb Paul Menzel:
> > Dear David, dear Michal,
> > 
> > 
> > Am 04.11.24 um 09:51 schrieb David Laight:
> > > From: Michal Swiatkowski
> > > > Sent: 04 November 2024 07:03
> > > ...
> > > > > The type of the devlink parameters msix_vec_per_pf_{min,max} is
> > > > > specified as u32, so you must use value.vu32 everywhere you work with
> > > > > them, not vu16.
> > > > > 
> > > > 
> > > > I will change it.
> > > 
> > > You also need a pretty good reason to use u16 anywhere at all.
> > > Just because the domain of the value is small doesn't mean the
> > > best type isn't [unsigned] int.
> > > 
> > > Any arithmetic (particularly on non x86) is likely to increase
> > > the code size above any perceived data saving.
> > 
> > In 2012 Scott Duplichan wrote *Small Integers: Big Penalty* [1]. Of
> > course you always should measure yourself.
> > 

Yeah, I chose it, because previously it was stored in u16. I will change
it to u32 too, as it is stored in structure that doesn't really need to
be small.

Thanks for comments and link to the article.
Michal

> > 
> > Kind regards,
> > 
> > Paul
> > 
> > 
> > [1]: https://notabs.org/coding/smallIntsBigPenalty.htm

