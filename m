Return-Path: <netdev+bounces-293733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO4MFYJ7HWrEbAkAu9opvQ
	(envelope-from <netdev+bounces-293733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B865D61F492
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E1A6302835D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1686737754C;
	Mon,  1 Jun 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kh6TA5Ka"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2485348C44
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316710; cv=none; b=hZAtwaOaqxLpJB9c6AGtCUwDHcNs4X4Sg9FEbl1DGq/DnXLDaoSTwRR7OK3iPg2dGLvMXD+VQTcjiKlDcLeD1xszOWCOFC5lKbtzWg0DHCtErUj2ddUWsrIYfJ7UXZpgtBFUoSOrJ2YPk84HARGw1gMGWN3VcFUuiIVX7v9S5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316710; c=relaxed/simple;
	bh=QBPDWS3w88qu0Bl7I+ahCYWVeJs/wsUdsmC4ZJLznp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAWlMEo77TkMpVDMWqjhrWmU991pQLdiSrLaXpvczChFcNWlgh/QuJRA3QGFXXqfp9QN79jPMrKJ6+EN2KFEDhKv0dQdc6NZgRLkKkVFAOMcx+olEqwb5gzCfZLKhMpJDy7VrxvHe8TrfOc+FaXygCk9dCODR6Wy+0zHJ7AePhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kh6TA5Ka; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780316708; x=1811852708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QBPDWS3w88qu0Bl7I+ahCYWVeJs/wsUdsmC4ZJLznp8=;
  b=Kh6TA5KaARpMgaoyxlXldgrVPo/EvWRDjPv65CKY67xiyOF9fUH3hLMp
   lar6FXskhg58gwO+A9DiSq/aMYTf+2RkqYMudr1/myomuZkRwGkbH33tH
   LJK2lz4eePP4l5bIXOnn0Q9Zv1D0p9BxS/Bm9Uc4y4udedOLfJltalUVF
   YVSNekD/W5I6QWIlAI4HUaojUVw7fabcIJEQP3K6vUfLYKBSyrAtI3bGk
   ow7sHB1/1+LKL5xlQRujJKpbvXvpknWchCPbdRZVktnoorcPnL48CDWSZ
   bu7zZmOI2B/uKaxYuN8XkiSFWbqmiIOll4+AsTnETRGDvL3qtBOK5N4pB
   w==;
X-CSE-ConnectionGUID: 6xDnX73RReKPL+wM9Fg4Ng==
X-CSE-MsgGUID: wHrZLJ/2R4+8DgSQGrIIZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80922612"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80922612"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:25:07 -0700
X-CSE-ConnectionGUID: s0taGkdxQJKTcgYWk1rdBA==
X-CSE-MsgGUID: pqW4DugeR0WqLVdpZTy69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243686155"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:25:04 -0700
Date: Mon, 1 Jun 2026 14:25:01 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, rodrigo.vivi@intel.com,
	riana.tauro@intel.com, dev@lankhorst.se, airlied@gmail.com,
	simona@ffwll.ch, kuba@kernel.org
Subject: Re: [PATCH v2 4/4] drm/xe/hw_error: Use HW_ERR prefix in log
Message-ID: <ah16Hfwq7goxBm27@black.igk.intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
 <20260523050212.557292-5-raag.jadav@intel.com>
 <65752da7-a23d-4495-9863-541bdd3f7888@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65752da7-a23d-4495-9863-541bdd3f7888@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293733-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B865D61F492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 01:13:12PM +0200, Michal Wajdeczko wrote:
> On 5/23/2026 7:00 AM, Raag Jadav wrote:
> > Hardware errors should be logged with HW_ERR prefix. Make them
> > consistent with existing logs.
> > 
> > Fixes: 01aab7e1c9d4 ("drm/xe/xe_hw_error: Add support for PVC SoC errors")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_hw_error.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> > index 5135e8e4093f..4b72959b2276 100644
> > --- a/drivers/gpu/drm/xe/xe_hw_error.c
> > +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> > @@ -223,9 +223,9 @@ static void log_hw_error(struct xe_tile *tile, const char *name,
> >  	struct xe_device *xe = tile_to_xe(tile);
> >  
> >  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > -		drm_warn(&xe->drm, "%s %s detected\n", name, severity_str);
> > +		drm_warn(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
> 
> function is per-tile, so shouldn't we use tile-oriented logs instead?

Agree, but then it needs to be done file-wide which I'll pursue once
the fix lands and propageted.

Raag

> 		xe_tile_warn(tile, HW_ERR ...)
> 
> >  	else
> > -		drm_err_ratelimited(&xe->drm, "%s %s detected\n", name, severity_str);
> > +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected\n", name, severity_str);
> 
> 		xe_tile_err_ratelimited(tile, HW_ERR ...)
> 
> >  }
> >  
> >  static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> > @@ -235,10 +235,10 @@ static void log_gt_err(struct xe_tile *tile, const char *name, int i, u32 err,
> >  	struct xe_device *xe = tile_to_xe(tile);
> >  
> >  	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > -		drm_warn(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > +		drm_warn(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> >  			 name, severity_str, i, err);
> >  	else
> > -		drm_err_ratelimited(&xe->drm, "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> > +		drm_err_ratelimited(&xe->drm, HW_ERR "%s %s detected, ERROR_STAT_GT_VECTOR%d:0x%08x\n",
> >  				    name, severity_str, i, err);
> >  }
> >  
> > @@ -255,9 +255,9 @@ static void log_soc_error(struct xe_tile *tile, const char * const *reg_info,
> >  
> >  	if (strcmp(name, "Undefined")) {
> >  		if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> > -			drm_warn(&xe->drm, "%s SOC %s detected", name, severity_str);
> > +			drm_warn(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
> >  		else
> > -			drm_err_ratelimited(&xe->drm, "%s SOC %s detected", name, severity_str);
> > +			drm_err_ratelimited(&xe->drm, HW_ERR "%s SOC %s detected", name, severity_str);
> >  		atomic_inc(&info[index].counter);
> >  	}
> >  }
> 

