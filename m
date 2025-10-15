Return-Path: <netdev+bounces-229460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74698BDC992
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F422F407C84
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44BD302CC2;
	Wed, 15 Oct 2025 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyFcMZs2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F62302153
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505992; cv=none; b=kxVPVimCILMdgxusTYar150y66Iv0jQeBBcOnwIvcXP/e9oEUkAyGJkimJJgu2vJP8uy2vfyoiCWa+bWIGAdtng2yV23d8By7whXmMHTjgPrIoANYsSByzT6MaPkitK0l3euCnqO7l7e40YzW21EaNB+5oRraeUatZakbtNQbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505992; c=relaxed/simple;
	bh=hrl3vFnKAOqCCVFG9AbVN3NMQWug1hhBxWaMMxlGFJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOZ/10LWXbLCN5r3h6aIWH29JKINRg4pk8wqmhyd3bK31ba/DXuAC1Lx14yZsR9txmf7iI8YYqZWIYQcyapC2m4CcFkbA/XDC52+6ksmss+dqOP4bQHy+OX/doUkoDMznKU4pBIUsYz3kGZOIWFGiog5ZZYM//VsTrasrFhH1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyFcMZs2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760505991; x=1792041991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hrl3vFnKAOqCCVFG9AbVN3NMQWug1hhBxWaMMxlGFJI=;
  b=YyFcMZs2ax1FEEFlOxbYuPAjJbWrsBtdZG/WxSyilZn8mwx7jjybblkT
   pkLnpm1r+LlSmhWvEjaWcakdJA2La71Y89yryrdzoMqLhVkQu+iTGZa8Z
   VjSq0aESdnHVWFhdNjitw4K2r5kiyNM75qepVbN9YJPSKwvYNCYbsKAu7
   1zFNW6Z3dMfcDBkPN5QXvKi4lWSKxfJn1ZGHcC9DdpM3hDXutzppdkygD
   zWtmQBbmqOqwPo7JVEHWpvdHOVdFchBckHVhgrTgjhjX2cmQEJP9eCRk4
   jujnuOsN606xQ2O4S1nv3mOU2bfAVb09/MBtSU2OxDqXk8XHWlyEuuJf5
   Q==;
X-CSE-ConnectionGUID: nxvRxY+ERrC951qQTFsT6w==
X-CSE-MsgGUID: ojPfmGo/QR+GozBiRDFkOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62568944"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62568944"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:26:30 -0700
X-CSE-ConnectionGUID: Gm74usyYTzy8Qm24W+ta6Q==
X-CSE-MsgGUID: 0YHKjawzQ5eRor79W+kOCQ==
X-ExtLoop1: 1
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:26:28 -0700
Date: Wed, 15 Oct 2025 07:24:30 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: guard fwlog code by
 CONFIG_DEBUG_FS
Message-ID: <aO8wDmPWWEV6+tkZ@mev-dev.igk.intel.com>
References: <20251014141110.751104-1-michal.swiatkowski@linux.intel.com>
 <11eac3d4-d81c-42e2-b9e3-d6f715a946b2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eac3d4-d81c-42e2-b9e3-d6f715a946b2@intel.com>

On Tue, Oct 14, 2025 at 04:41:43PM -0700, Jacob Keller wrote:
> 
> 
> On 10/14/2025 7:11 AM, Michal Swiatkowski wrote:
> > Building the ixgbe without CONFIG_DEBUG_FS leads to a build error. Fix
> > that by guarding fwlog code.
> > 
> > Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> 
> Hm. It probably is best to make this optional and not require debugfs
> via kconfig.

Make sense

> 
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 ++
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > index c2f8189a0738..c5d76222df18 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > @@ -3921,6 +3921,7 @@ static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
> >  	return err;
> >  }
> >  
> > +#ifdef CONFIG_DEBUG_FS
> >  static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
> >  			    u16 size)
> >  {
> > @@ -3952,6 +3953,7 @@ void ixgbe_fwlog_deinit(struct ixgbe_hw *hw)
> >  
> >  	libie_fwlog_deinit(&hw->fwlog);
> >  }
> > +#endif /* CONFIG_DEBUG_FS */
> >  
> 
> What does the fwlog module from libie do? Seems likely that it won't
> compile without CONFIG_DEBUG_FS either...

Right, it shouldn't, because there is a dependency on fs/debugfs.
It is building on my env, but maybe I don't have it fully cleaned.
I wonder, because in ice there wasn't a check (or select) for
CONFIG_DEBUG_FS for fwlog code.

Looks like LIBIE_FWLOG should select DEBUG_FS, right?
I will send v2 with that, if it is fine.

Thanks

> 
> >  static const struct ixgbe_mac_operations mac_ops_e610 = {
> >  	.init_hw			= ixgbe_init_hw_generic,
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> > index 11916b979d28..5317798b3263 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
> > @@ -96,7 +96,15 @@ int ixgbe_aci_update_nvm(struct ixgbe_hw *hw, u16 module_typeid,
> >  			 bool last_command, u8 command_flags);
> >  int ixgbe_nvm_write_activate(struct ixgbe_hw *hw, u16 cmd_flags,
> >  			     u8 *response_flags);
> > +#ifdef CONFIG_DEBUG_FS
> >  int ixgbe_fwlog_init(struct ixgbe_hw *hw);
> >  void ixgbe_fwlog_deinit(struct ixgbe_hw *hw);
> > +#else
> > +static inline int ixgbe_fwlog_init(struct ixgbe_hw *hw)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +static inline void ixgbe_fwlog_deinit(struct ixgbe_hw *hw) {}
> > +#endif /* CONFIG_DEBUG_FS */
> >  
> >  #endif /* _IXGBE_E610_H_ */
> 




