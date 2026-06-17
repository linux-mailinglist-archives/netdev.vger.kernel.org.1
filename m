Return-Path: <netdev+bounces-300141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRCRDsGFMmrM1QUAu9opvQ
	(envelope-from <netdev+bounces-300141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:32:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A09996991A8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:32:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=b5saqkD3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300141-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300141-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C78D7322B32D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBB2FE59C;
	Wed, 17 Jun 2026 11:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E26D3E0236
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:21:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695293; cv=none; b=SFqB0nbU87cSjGGzouovoLLeBOxYKNhr1t5f/XdDnz6gFMIjNYAreukMYopdfPHOojsTi74qreV6P61MjxrPQmWu0hbjRR1EIeFLkANFHSbic7f/o9cOcDQGFzvVOUXXuGERCpG9c2H7hxwiQAgG6v3K6t4VHyXIrtKPHpJi0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695293; c=relaxed/simple;
	bh=tPi/YY4XI5glWepvmBLi0Nv9EYXphd/RdJKzp90WbGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlNHzM4W3IEVBhW6Car0wp3b4YTDIJLPvj/YeGdzjFADPPcL7efPr4uGe8o1bRz0MwiTqhtVbiAb3C9Z0Tz2eLxXnWOvwSw1lSFrgter2nV/QTypOBZnMmh7HeQLNUavjcmfMhyvFgSyYnL+yyn+q7AD1w6ITQ9X3MWRDTQvakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5saqkD3; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781695289; x=1813231289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPi/YY4XI5glWepvmBLi0Nv9EYXphd/RdJKzp90WbGI=;
  b=b5saqkD3n+5NjUn7XYu1IoaUhVDadLIywjz8A9SPlVLRZBrXdZXrgJaw
   DCJq5hCj+BZaCVtapazS9iZwcT1b3xbtIk3bBlgUfJ4WOY6aDDFoceuxj
   20b4n9+ju/m6NYcmvEblgOBVNlThsczdNfmP5Y/2UsX+tGXu+WJiaD1Xa
   /xi0yvJSzAqm2+D229tW7C6R1eT7Tn2BweBx3GbHEDPTHU3Dy6ifxZ6ud
   FwJjDqh7oxtqAyjRTVLKdrPl674S191b9jHXGyDD1//1RBxiorqSOqY6g
   0/fP1emRCRY55GcihMNE5BALUZ025JeKSnndrUwF2H/fid4QoHeFDYb27
   Q==;
X-CSE-ConnectionGUID: 27l+++kYSF65S5jAHFrYZw==
X-CSE-MsgGUID: jM8P8eYrQz6Z/22ZcpSW6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82577240"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82577240"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:21:28 -0700
X-CSE-ConnectionGUID: sL30sF98S1yedT8Chb4VQQ==
X-CSE-MsgGUID: FQ3c1UBmQZWfoA+1mFLD7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="272104368"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:21:27 -0700
Date: Wed, 17 Jun 2026 13:21:24 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, rodrigo.vivi@intel.com,
	riana.tauro@intel.com, dev@lankhorst.se, airlied@gmail.com,
	simona@ffwll.ch, kuba@kernel.org
Subject: Re: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Message-ID: <ajKDNGuBJ9th6-sn@black.igk.intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-5-raag.jadav@intel.com>
 <65752da7-a23d-4495-9863-541bdd3f7888@intel.com>
 <ah16Hfwq7goxBm27@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah16Hfwq7goxBm27@black.igk.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-300141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michal.wajdeczko@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:rodrigo.vivi@intel.com,m:riana.tauro@intel.com,m:dev@lankhorst.se,m:airlied@gmail.com,m:simona@ffwll.ch,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,intel.com:dkim,intel.com:email,intel.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A09996991A8

On Mon, Jun 01, 2026 at 02:25:06PM +0200, Raag Jadav wrote:
> On Mon, Jun 01, 2026 at 01:13:12PM +0200, Michal Wajdeczko wrote:
> > On 5/23/2026 7:00 AM, Raag Jadav wrote:
> > > Hardware errors should be logged with HW_ERR prefix. Make them
> > > consistent with existing logs.
> > > 
> > > Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> > > index 5135e8e4093f..4b72959b2276 100644
> > > --- a/drivers/gpu/drm/xe/xe_hw_error.c
> > > +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> > > @@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
> > >  	struct xe_device *xe = tile_to_xe(tile);
> > >  
> > >  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > > -		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
> > > +		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
> > 
> > function is per-tile, so shouldn't we use tile-oriented logs instead?
> 
> Agree, but then it needs to be done file-wide which I'll pursue once
> the fix lands and propageted.

Even better, there's a driver-wide refactor[1] incoming.

Raag

[1] https://patchwork.freedesktop.org/series/168333/

> > 		xe_tile_warn(tile, HW_ERR ...)
> > 
> > >  	else
> > > -		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
> > > +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
> > 
> > 		xe_tile_err_ratelimited(tile, HW_ERR ...)
> > 
> > >  }
> > >  
> > >  static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> > > @@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> > >  	struct xe_device *xe = tile_to_xe(tile);
> > >  
> > >  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > > -		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > > +		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > >  			 name, severity_str, i, err);
> > >  	else
> > > -		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > > +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > >  				    name, severity_str, i, err);
> > >  }
> > >  
> > > @@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
> > >  
> > >  	if (strcmp(name, "Undefined")) {
> > >  		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > > -			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
> > > +			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
> > >  		else
> > > -			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
> > > +			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
> > >  		atomic_inc(&info[index].counter);
> > >  	}
> > >  }
> > 

