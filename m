Return-Path: <netdev+bounces-289883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHPlMnmPDWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B358BE05
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9B963005AF8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088AD39D6CB;
	Wed, 20 May 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDzhwGWd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972E371D16
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273422; cv=none; b=Q2b+aKgwRo8qMTuU3s76eHEeukS5kLxkU+Z0PrWr1Jvzb35ckT7+QgRtcFzzI+qlatp58b19VMbzaKSghBMzDqrJEe2cpAWv6FOvLbXSEE/W4GciNo1ETCuUrJOt71tx5GQjcSI/nBS/l6Vdjdqb1MNxvvxLWd/1nMpkUIiaOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273422; c=relaxed/simple;
	bh=YHhT1zawAxLpF/+gpXRLZWVPjG4ZkiS659MyfYt66CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGvSyzIjOvgpSqFRMP5P4pbtJ7l8fT5deKZzzi/agQ6AdNrwHyk52zaplL6TMVcZRaFzQxuBPcg3CxlAq6oAnqYQHWCnTdMiTDBtl/E3BGpOixALiXkCUCHIVDzAjn4CqQwVrOoNRbvsMnEGcDr0DRJKGqSs7hvvLbl5F38THHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDzhwGWd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779273421; x=1810809421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YHhT1zawAxLpF/+gpXRLZWVPjG4ZkiS659MyfYt66CE=;
  b=XDzhwGWdt2kE61lX1qf/dMmYfUOklAAee4u6uM6imork05xIW1Ee6qNm
   fl5GdJdl9OWrgkLOtE8QI16PmU0cpNa1mDX1HyKQ8dNjPJqH2nD8g8joj
   5sPy5FC0PTRvHRg8FNAM5weRrLNQk4DeBTyHSX6RWeSBefpNQj8386VVN
   b59x4VdIKgx1CTFeadzXAvhagFRxi62H+5VIT/uDke5aFKK/bTOICr/G7
   +kvS9NPf7YL2ofOkNNqODBpGuacCTAwO02iElLXME3KzVOZYmI6b+KfMz
   BQpZN4cf7L9bw4bA55cynmkz0k+ByAR8Pozf24Z6ngyLt5ejn8Q8E02wS
   g==;
X-CSE-ConnectionGUID: oVPL9Es/Qz2hiSQfCGBgGw==
X-CSE-MsgGUID: i52x7Dz9SHK/rttwzULfhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="67696237"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="67696237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:36:59 -0700
X-CSE-ConnectionGUID: E5YR7U2QSYipsVTRRPEB3g==
X-CSE-MsgGUID: ExrKOdGTR1SPe9bFtgZCiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="237137989"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:36:57 -0700
Date: Wed, 20 May 2026 12:36:54 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, rodrigo.vivi@intel.com,
	maarten@lankhorst.se, airlied@gmail.com, simona@ffwll.ch,
	kuba@kernel.org
Subject: Re: [PATCH v1 2/3] drm/xe/drm_ras: Make counter allocation drm
 managed
Message-ID: <ag2OxgNBjSde2a7J@black.igk.intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-3-raag.jadav@intel.com>
 <ef067007-b928-4130-8e25-1c4f5afb5833@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef067007-b928-4130-8e25-1c4f5afb5833@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289883-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 466B358BE05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 03:21:49PM +0530, Tauro, Riana wrote:
> On 5/15/2026 1:58 AM, Raag Jadav wrote:
> > cleanup_node_param() is not registered in case of counter allocation
> > failure, which results in stale memory of previous node that isn't
> > cleaned up on unwind. Fix this using drm managed allocation, which is
> > guaranteed to be cleaned up on unwind.
> > 
> > Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_drm_ras.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> > index c21c8b428de6..89640ffb1c33 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> > @@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
> >   	struct xe_drm_ras_counter *counter;
> >   	int i;
> > -	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
> > +	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
> >   	if (!counter)
> >   		return ERR_PTR(-ENOMEM);
> 
> The intention was to clean up nodes  if there is a failure, to prevent
> memory
> from  persisting throughout the drm device lifecycle. We actually discussed
> this offline  afair.
> 
> So there was a change from from v5 to v6 in the initial patch [v6,2/5]
> drm/xe/xe_drm_ras: Add support for XE DRM RAS - Patchwork
> <https://patchwork.freedesktop.org/patch/704873/?series=155188&rev=6>

Yes, the idea was to prevent the driver from updating stale counter
(which isn't exposed to the user). But rethinking about it now, this
can be achieved by simply keeping info as NULL I guess?

Raag

> > @@ -135,9 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
> >   {
> >   	struct drm_ras_node *node = &ras->node[severity];
> > -	kfree(ras->info[severity]);
> > -	ras->info[severity] = NULL;
> > -
> >   	kfree(node->device_name);
> >   	node->device_name = NULL;
> >   }

