Return-Path: <netdev+bounces-302969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xms5MBdSQ2qxWwoAu9opvQ
	(envelope-from <netdev+bounces-302969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CA6E077D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:20:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="isEtJ/Sx";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302969-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302969-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDBB5300A4A5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78D3D8915;
	Tue, 30 Jun 2026 05:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F135B62C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796821; cv=none; b=LfriUtZjgWMw50M25yYDsvEky06TEPO0lWCopE01oC0BZqTs1TURqkAZyKKoRy4r9i9dFoO/nyxKy6OKnJctEusVHmCm9+NBlzHkvDFbytzrzEk2efQraYot8M+1RG20d7NgrtElOsIr598pu5ngrvjGE/2kOoy6tLS4ipL82z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796821; c=relaxed/simple;
	bh=Kr/YG75jknEBGygfbdZbiLsmWOHsghWO/YAbsUOCBnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYHFyiypilYlWz5cdYpk7ddWlrmFQHsrFxXPvAJ7KE+CUCAJdj8/47urksEFi1pngQUgProgCNamp4Z8CaOOSESnU6/tcRO0QzZ7+yOnCN+w4CgUjRPTKBYx8evYQo+9p7RyhrzkmT6Josl0N4tPps45YYSaaFwqqd3assJc790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isEtJ/Sx; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782796821; x=1814332821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kr/YG75jknEBGygfbdZbiLsmWOHsghWO/YAbsUOCBnA=;
  b=isEtJ/SxG2viFRDptx17SepD3Rb2J9PvUbI+lBZi10lVAaV1pv2JKiet
   tdTBp6eUVZ+RQWe/XPBV7qXechVbTZyD3/lq9b1lBfZkPhVV42RXKl00h
   CF6QEYA1E3YSNH7d/XUYNI/tNGXU0Qqc0V9uGA7bWZwXagb8TQlR5VtRx
   tFRSf/Wvhfl+OA7831WVjlB+qtn/s/933N4XHmjS1x4s3ejcYm4HUGpyI
   tf0vi83KMi1vpikHlK8tfs6lkRj8ibnrUgmAirqoVgKYQ4NsnrJLB91hi
   WyHydtrrEZiLR8J2oh/bYAPixbbpDWpZP2if2UI6V7nC3W0w6n+UjQgZI
   w==;
X-CSE-ConnectionGUID: a+iC/NXVRFGrPd6XwKpQ1w==
X-CSE-MsgGUID: XWUO+aQkRXKrx6nR2LyW0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94883790"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94883790"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 22:20:20 -0700
X-CSE-ConnectionGUID: t9Hv/DrSRa6tVdNCttLtrQ==
X-CSE-MsgGUID: UHByy7OvTc6B1DVHvZlakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252305245"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 22:20:16 -0700
Date: Tue, 30 Jun 2026 07:20:13 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, kuba@kernel.org,
	simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
	soham.purkait@intel.com
Subject: Re: [PATCH v3 3/3] drm/xe/xe_ras: Add error-event support for CRI
Message-ID: <akNSDXcXa0mtwR5r@black.igk.intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
 <20260622101716.3313496-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622101716.3313496-8-riana.tauro@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302969-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 601CA6E077D

On Mon, Jun 22, 2026 at 03:47:20PM +0530, Riana Tauro wrote:
> Add error-event support for Correctable errors in CRI.
> error-event is reported to  userspace for all errors that crossed
> threshold on receiving an interrupt for correctable errors.

...

> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> +{
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	drm_severity = xe_to_drm_ras_severity(severity);
> +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX)
> +		return;
> +
> +	drm_component = xe_to_drm_ras_component(component);
> +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX)
> +		return;
> +
> +	ret = xe_ras_get_counter(xe, severity, component, &value);
> +	if (ret)
> +		return;
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
> +}
> +
>  void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  				      struct xe_sysctrl_event_response *response)
>  {
> @@ -152,6 +203,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  		severity = errors[id].common.severity;
>  		component = errors[id].common.component;
>  
> +		ras_send_error_event(xe, severity, component);

We already have error-value as part of the event, so this looks like
a lot of redundant duplicate events if threshold is set high enough.
I'm wondering if we use a local variable as a bitmap for components
(which we set here) and only send event for_each_set_bit() after the
loop?

Raag

>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
>  	}
> -- 
> 2.47.1
> 

