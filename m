Return-Path: <netdev+bounces-138114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4759AC019
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C25E1C202ED
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7A15350B;
	Wed, 23 Oct 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2e3wquT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC53A8D0
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668064; cv=none; b=YQYf9qSO7E2Ku0V23Bgy/H+fHgeNM+/8D5vDgxz5Cx1wVIxIAPvhFG6Eiy7o8nZmSGlEqVv611Bn2WbbMTaLIEgIYFU+V13SMY5tSY19YQKRHZ+7h7k2qXXyslk1Lp9b1wctg/7EDnaw1J4uBhjufq0opqKGEWRQX0axFEHqPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668064; c=relaxed/simple;
	bh=9lEGaxY+Lh9tuFwrLh09Xs9uWI18TVqbHDoQNZ6hhmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y48Gdzk14zJ2h/NG60xE2kvtnoiZJZfIKLbwG7G1d40WqHpPDEh6HfaW02ktC3jV3775+YrZVlBmDMdnbrjxXMEJl0DBoHjUAX7ggUEwve+28oy7IFAAidiTolnK5PScB0hMMonUigE+MhkKcs/QYnlWv/1nJb9z/OT8llaoK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2e3wquT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729668063; x=1761204063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lEGaxY+Lh9tuFwrLh09Xs9uWI18TVqbHDoQNZ6hhmo=;
  b=j2e3wquTsCvmvAjJyO2OA4NHokHjnVmwxOcNpZA4rO47Yik2/YA6Qfok
   fiyA4nxHNSSoKZMTAo7nwHYOl1rJ7nlYKTacBp+Vj20xj7yoHDV0ZdRPn
   tl0ua9hPzlnwj90TygK6B5zFrs5s6kcr+vuZAifNzzBSGEzf1s3gkUQR9
   cZFNPuseWIXDzwcHSHE8SXPBR9Gz0y7hcAq1DiCDKUqlragCIXL3/Mlb7
   AC7TlnADc1cB/ZMyIFpr7JpW/w5pXtUAPGlFRVO9yeoufjqhf3MABPS0y
   TU5iYTyhvL0W3xdVg+3qRHmuY9tWvWHChWaIR14bZNfTrHpcGF4VQhR3M
   w==;
X-CSE-ConnectionGUID: usirx8xLQvmmQcLM/AHGKw==
X-CSE-MsgGUID: jOEmsLYIQtqrFnM/SQ3VQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32935695"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32935695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:19:36 -0700
X-CSE-ConnectionGUID: lk1904+xSmWQ/pdMWDShpw==
X-CSE-MsgGUID: 4j4Fdq5JQZixQ9GuuxUnWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80522555"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:19:32 -0700
Date: Wed, 23 Oct 2024 09:17:03 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Laight <David.Laight@aculab.com>, Simon Horman <horms@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pawel.chmielewski@intel.com" <pawel.chmielewski@intel.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"pio.raczynski@gmail.com" <pio.raczynski@gmail.com>,
	"konrad.knitter@intel.com" <konrad.knitter@intel.com>,
	"marcin.szycik@intel.com" <marcin.szycik@intel.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"nex.sw.ncis.nat.hpm.dev@intel.com" <nex.sw.ncis.nat.hpm.dev@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>
Subject: Re: [iwl-next v4 3/8] ice: get rid of num_lan_msix field
Message-ID: <Zxii7w4TpJGBL4g3@mev-dev.igk.intel.com>
References: <20240930120402.3468-1-michal.swiatkowski@linux.intel.com>
 <20240930120402.3468-4-michal.swiatkowski@linux.intel.com>
 <20241012151304.GK77519@kernel.org>
 <636e511e-055d-4b7d-8fdb-13e546ff5b90@intel.com>
 <3e015d17e53f4cdd813c88c93b966810@AcuMS.aculab.com>
 <534ab479-29a1-4a95-a9e1-d068b5290ebd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534ab479-29a1-4a95-a9e1-d068b5290ebd@intel.com>

On Mon, Oct 14, 2024 at 03:23:49PM -0700, Jacob Keller wrote:
> 
> 
> On 10/14/2024 12:04 PM, David Laight wrote:
> > From: Jacob Keller
> >> Sent: 14 October 2024 19:51
> >>
> >> On 10/12/2024 8:13 AM, Simon Horman wrote:
> >>> + David Laight
> >>>
> >>> On Mon, Sep 30, 2024 at 02:03:57PM +0200, Michal Swiatkowski wrote:
> >>>> Remove the field to allow having more queues than MSI-X on VSI. As
> >>>> default the number will be the same, but if there won't be more MSI-X
> >>>> available VSI can run with at least one MSI-X.
> >>>>
> >>>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >>>> ---
> >>>>  drivers/net/ethernet/intel/ice/ice.h         |  1 -
> >>>>  drivers/net/ethernet/intel/ice/ice_base.c    | 10 +++-----
> >>>>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  8 +++---
> >>>>  drivers/net/ethernet/intel/ice/ice_irq.c     | 11 +++------
> >>>>  drivers/net/ethernet/intel/ice/ice_lib.c     | 26 +++++++++++---------
> >>>>  5 files changed, 27 insertions(+), 29 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> >>>> index cf824d041d5a..1e23aec2634f 100644
> >>>> --- a/drivers/net/ethernet/intel/ice/ice.h
> >>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
> >>>> @@ -622,7 +622,6 @@ struct ice_pf {
> >>>>  	u16 max_pf_txqs;	/* Total Tx queues PF wide */
> >>>>  	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
> >>>>  	struct ice_pf_msix msix;
> >>>> -	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
> >>>>  	u16 num_lan_tx;		/* num LAN Tx queues setup */
> >>>>  	u16 num_lan_rx;		/* num LAN Rx queues setup */
> >>>>  	u16 next_vsi;		/* Next free slot in pf->vsi[] - 0-based! */
> >>>
> >>> ...
> >>>
> >>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> >> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> >>>> index 85a3b2326e7b..e5c56ec8bbda 100644
> >>>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> >>>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> >>>> @@ -3811,8 +3811,8 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
> >>>>   */
> >>>>  static int ice_get_max_txq(struct ice_pf *pf)
> >>>>  {
> >>>> -	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
> >>>> -		    (u16)pf->hw.func_caps.common_cap.num_txq);
> >>>> +	return min_t(u16, num_online_cpus(),
> >>>> +		     pf->hw.func_caps.common_cap.num_txq);
> >>>
> >>> It is unclear why min_t() is used here or elsewhere in this patch
> >>> instead of min() as it seems that all the entities being compared
> >>> are unsigned. Are you concerned about overflowing u16? If so, perhaps
> >>> clamp, or some error handling, is a better approach.
> >>>
> >>> I am concerned that the casting that min_t() brings will hide
> >>> any problems that may exist.
> >>>
> >> Ya, I think min makes more sense. min_t was likely selected out of habit
> >> or looking at other examples in the driver.
> > 
> > My 'spot patches that use min_t()' failed to spot that one.
> > 
> > But it is just plain wrong - and always was.
> > You want a result that is 16bits, casting the inputs is wrong.
> > Consider a system with 64k cpus!
> > 
> 
> Yea, that makes sense. This is definitely not going to behave well in
> the event that one of the values is above 16-bit.
> 

I blindly copied that, thanks for pointing it, will fix in next version.

Thanks,
Michal

> > Pretty much all the min_t() that specify u8 or u16 are likely to
> > be actually broken.
> > Most of the rest specify u32 or u64 in order to compare (usually)
> > unsigned values of different sizes.
> > But I found some that might be using 'long' on 64bit values
> > on 32bit (and as disk sector numbers!).
> > 
> > In the current min() bleats, the code is almost certainly awry.
> > 
> > 	David

