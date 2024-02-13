Return-Path: <netdev+bounces-71334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04F853011
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5561F253CD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116438DCD;
	Tue, 13 Feb 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5lnKAOp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB9383BC
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825821; cv=none; b=ZF1cheBEBkF+OX2dhxHYfFxNqha80iTl7StjWLuxOROumk8Zu3JWTGcstqcWBPtnc3KhV3f6znNluQzu+Yrezg6ot5tiaVV9VOJz8B9VyRWLHTQ97vyGl1ODBIcvSI9wJhSgVqEv2FdWebW4XuehOwMPkkuXxUu88d2Yzt7UUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825821; c=relaxed/simple;
	bh=jPD6VUJO3XrE6zwrOjtPDfOxslEHv4Z7+L1r1W3Bxes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ra7LSIDuhCnQM1+JdvRDAnI156Te5KmtfSenLkV8lO3Hzu4TykcRbD5/HmhNq3JVYG7Hn3CyqcRQlbAVS4t8pOuSVZB5iOYx4rabTbHUBZzyS17ydbjdEYTv2t+kHbFD176wua1Vqg/SS+pKI5R1UjgE75ssdhOnwTBETiCDNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5lnKAOp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707825820; x=1739361820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jPD6VUJO3XrE6zwrOjtPDfOxslEHv4Z7+L1r1W3Bxes=;
  b=Q5lnKAOpNNxYSQDkeEbsPgYzEqMRQK4lJA3nGkTWgrc2GBEoFsetNU6J
   jZWK7U/EiAQybfWKK0NjB33iLNqXewBncFD+yOORidN1BLw5qvDHwuKzo
   8XZDaZ4/S2AhYrBRQ3phUsCZ9RCWQXbsuFB9mLhS/Ai7LTFTQZYu+h5Ou
   /vbeU+tKmCFlMFI2uabYdWD5YowAFQWPruddCO/NrlJueroHMLK2NULuj
   3KCFQWur78Hhck+uwfKtAvYjaO4Ns03+rxv9rgQNw5nGzEVFChz9z+AFG
   N/mUvc51O1YdoX4zLOyNidu7XnnN3LGgQDICirGugwQFUtV+lD3N/GbU5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1704563"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1704563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935338476"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935338476"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:03:37 -0800
Date: Tue, 13 Feb 2024 13:03:34 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 06/15] ice: add subfunction aux driver support
Message-ID: <ZctalmPA/b+VBZC+@mev-dev>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
 <Zcsu6MCX-XkS8bki@nanopsycho>
 <Zcs5pFtmXzTxWO5s@mev-dev>
 <ZctSU2cJHVwPhyhZ@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctSU2cJHVwPhyhZ@nanopsycho>

On Tue, Feb 13, 2024 at 12:28:19PM +0100, Jiri Pirko wrote:
> Tue, Feb 13, 2024 at 10:43:00AM CET, michal.swiatkowski@linux.intel.com wrote:
> >On Tue, Feb 13, 2024 at 09:57:12AM +0100, Jiri Pirko wrote:
> >> Tue, Feb 13, 2024 at 08:27:15AM CET, michal.swiatkowski@linux.intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >
> >> >Instead of only registering devlink port by the ice driver itself,
> >> >let PF driver only register port representor for a given subfunction.
> >> >Then, aux driver is supposed to register its own devlink instance and
> >> >register virtual devlink port.
> >> >
> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >---
> >> > .../intel/ice/devlink/ice_devlink_port.c      |  52 ++++-
> >> > .../intel/ice/devlink/ice_devlink_port.h      |   6 +
> >> > drivers/net/ethernet/intel/ice/ice_devlink.c  |  28 ++-
> >> > drivers/net/ethernet/intel/ice/ice_devlink.h  |   3 +
> >> > drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
> >> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 214 ++++++++++++++++--
> >> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  21 ++
> >> > 7 files changed, 302 insertions(+), 31 deletions(-)
> >> 
> >> Could you please split this. I see that you can push out 1-3 patches as
> >> preparation.
> >
> >Do you mean 1-3 patchses from this patch, or from whole patchset? I mean,
> 
> This patch.
> 
> >do you want to split the patchset to two patchsets? (by splitting patch
> 
> Yes, 2 patchsets. If convenient 3. Just do one change per patch so it is
> reviewable.
> 
> 
Ok, will do that.

> >from the patchset I will have more than netdev maximum; 15 I think). 
> >
> >Thanks,
> >Michal

