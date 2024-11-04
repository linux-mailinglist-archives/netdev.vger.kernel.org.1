Return-Path: <netdev+bounces-141407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACA9BACF0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD3282048
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3716190C;
	Mon,  4 Nov 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuYrAs2r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA617583
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703986; cv=none; b=JTMjsNWp9LufwG2AKvmS8gFIuwW11Be+Z4c2SOgeny8dXKxpgnyIgRSn/nkMoROOGBbohuXFZzk/yijX/4/6WPATTSb7cNCCjDaMbkZhojKdveDljXtR4Hvq9tTOc0rA2LUO/ZEyFALF6mcY/JmG6gVMuywgpbAD7/5JyiwIlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703986; c=relaxed/simple;
	bh=+RAwMr8vrqq84TRRwWGlgaTIO1VwU9BaNK6EaWxUsu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvQMs4twBMNOMnLUJ0YnUFlUkjbbOzlJr8DNclEoRWH19evSpIvJZAuovECZ/gLxkaC1Pq07QXBQviro5A2v8eYzHNQ4FQimJH4PRaxUOU3ltfRUc3uhMeLb8mooEH6+rbrqN7jiWjmzrXODY670N9XTKGfoMxRHUqJPob4YzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuYrAs2r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730703985; x=1762239985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+RAwMr8vrqq84TRRwWGlgaTIO1VwU9BaNK6EaWxUsu8=;
  b=YuYrAs2rkD4ZlLKmGPN5gKkG8I/SAjTZG1EBAMv9nJr3wg5zWfOHOzk/
   mDtgGcAAEpydivtr5P6txq9Upnlfz59YVyGIcOsdvzv5Z1RoJuRRmlS88
   Bn8B+GETFs/pmtZuq5hNYqp0L9rCqS2J/FVufAdVY64AktjuDqG8yqNPv
   sM0X7TX6MIeHAErNmPkFkMLw8U9EPNH5Z5h80GAIFuB7JnomUOC4yejpL
   z2ZgyrWRt66FIfraI8LntQPuBDc7liMOpe/IsMDBKnCwacxK9DUm/Edv2
   U2PMXjui38zSqElYJQ6Ca1BBewnOgonhDKlxgFbFAFVeFzQk5k567wFwn
   Q==;
X-CSE-ConnectionGUID: pq3sMzMqTAS5VfmhGu/ayg==
X-CSE-MsgGUID: sZTAFwGwSy+P1/f71r1qnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29803042"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29803042"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 23:06:24 -0800
X-CSE-ConnectionGUID: oLws9DsbS2OEvLygqrdNZQ==
X-CSE-MsgGUID: GBG8FY2tRG6HbmcNDMAgcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114353201"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 23:06:21 -0800
Date: Mon, 4 Nov 2024 08:03:25 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org,
	David.Laight@aculab.com
Subject: Re: [Intel-wired-lan] [iwl-next v6 2/9] ice: devlink PF MSI-X max
 and min parameter
Message-ID: <ZyhxvW7K6v7QxD3H@mev-dev.igk.intel.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
 <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW1EzEVGZnxEQOUngTRKVnQQnU4mpsOoe_E0SeojcF3D6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW1EzEVGZnxEQOUngTRKVnQQnU4mpsOoe_E0SeojcF3D6w@mail.gmail.com>

On Thu, Oct 31, 2024 at 10:58:03PM +0100, Michal Schmidt wrote:
> On Mon, Oct 28, 2024 at 11:04 AM Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com> wrote:
> >
> > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> > range.
> >
> > Add notes about this parameters into ice devlink documentation.
> >
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  Documentation/networking/devlink/ice.rst      | 11 +++
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
> >  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
> >  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
> >  4 files changed, 107 insertions(+), 1 deletion(-)
> >
> ...
> > @@ -1526,6 +1548,37 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
> >         return 0;
> >  }
> >
> > +static int
> > +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> > +                                union devlink_param_value val,
> > +                                struct netlink_ext_ack *extack)
> > +{
> > +       struct ice_pf *pf = devlink_priv(devlink);
> > +
> > +       if (val.vu16 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> > +           val.vu16 < pf->msix.min) {
> > +               NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int
> > +ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> > +                                union devlink_param_value val,
> > +                                struct netlink_ext_ack *extack)
> > +{
> > +       struct ice_pf *pf = devlink_priv(devlink);
> > +
> > +       if (val.vu16 <= ICE_MIN_MSIX || val.vu16 > pf->msix.max) {
> 
> Shouldn't this be "<" instead of "<=" ?
> 

Yeah, will fix.

> Michal
> 

