Return-Path: <netdev+bounces-289885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNxYOXqPDWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:39:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB0158BE0C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA9DE300FABB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1839C006;
	Wed, 20 May 2026 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byEb3BSR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7D3A257C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273591; cv=none; b=Hzd+ZI/XcsqgsM2/R3bgd7sMaxTfTCy3Cpn4SX5VpIZrwwS9WbQWa3zJirib4OSltaHB9f5Zjs8J8AaUqZazn9yqFFKmM2RemvlCZaRFCAX9VF92jfAcwG5GBwALMgv/UGhKOkwGvA9+ZkKNfDO3fUvP7ux7J7a1ZRIZtAMTTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273591; c=relaxed/simple;
	bh=eUHiWHdMbcMjdbFC/ml9hfj6eOgpoWIDrHGgBD9VobU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGhBznJHF60VkeDPjEfSl8IWIeZPzkBeOtsPnT0XsaVbenVYYiRq+ihza3rq9fMi82bdsqAz26iZN6IEYKpRgqBFC5hxIptQO23yI8W8VWxYE7cdOUhleKqkRjyI+a/vdJjG4QR4/0zaN/IHTaaQbVIirMC7aQCFubG7XQ7jvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byEb3BSR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779273589; x=1810809589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUHiWHdMbcMjdbFC/ml9hfj6eOgpoWIDrHGgBD9VobU=;
  b=byEb3BSRACQWH5GeQjVUeVtbtAEC2rNIg5nrwGMBAX3T5ZX8eahg9SEK
   tii7V9t4jqqEIPfqp096Ey5I0i2sQ/nIYv0loBgpj1aTIYW52s/uUfwrs
   YSHmAOZaW7JoAlfmFvHYpyhzBOeNeD1v4SSOwoygEORxnHcB/zFShhqwP
   KQi4UBVOVJh495k2AfisyoVB3j3PKJVkQnyJezHjUY/+7vEQPmI5ndHK8
   FjJqWg97iOzJZrj3lPoy/Tm/LN6lilBDxTbPOp7Q+vpLbF9/t7mjUOS/R
   iJp3h1QT1tsrridgw60DoEX/PQDdCOX6Mb/2LwMTc5w3XvA6VBPwiIBeJ
   Q==;
X-CSE-ConnectionGUID: QT4hfqdyR0WCiVwysoVkLg==
X-CSE-MsgGUID: wjIQ8P3HT+e4YioZPhg0hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102845325"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="102845325"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:39:46 -0700
X-CSE-ConnectionGUID: Y5XtTuW4QHiM0nD4GafOtw==
X-CSE-MsgGUID: upJKWnHLQKWxxmesNQlb8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="244422210"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 03:39:44 -0700
Date: Wed, 20 May 2026 12:39:40 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, rodrigo.vivi@intel.com,
	maarten@lankhorst.se, airlied@gmail.com, simona@ffwll.ch,
	kuba@kernel.org
Subject: Re: [PATCH v1 3/3] drm/xe/drm_ras: Add per node cleanup action
Message-ID: <ag2PbIWctfd6yRTw@black.igk.intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-4-raag.jadav@intel.com>
 <5d52d3dd-2154-48e2-b849-0ca2aa74fb13@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d52d3dd-2154-48e2-b849-0ca2aa74fb13@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289885-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim,black.igk.intel.com:mid]
X-Rspamd-Queue-Id: 8AB0158BE0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:53:52PM +0530, Tauro, Riana wrote:
> On 5/15/2026 1:58 AM, Raag Jadav wrote:
> > cleanup_node_param() is not registered in case of counter allocation
> > failure, which results in stale memory of previous node that isn't
> > cleaned up on unwind.
> 
> It is registered.
> 
> ret = assign_node_params(xe, node, i);
> if (ret)
>     cleanup_node_param(ras, i);

Is that also true for previous node params (in case second node
registration fails)?

> >   Add per node cleanup action which guarantees
> > cleanup on unwind and also simplifies the cleanup logic.
> > 
> > Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_drm_ras.c | 42 +++++++++++++--------------------
> >   1 file changed, 17 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> > index 89640ffb1c33..40abde29a26f 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> > @@ -131,14 +131,20 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
> >   	return 0;
> >   }
> > -static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
> > +static void cleanup_node_param(struct drm_ras_node *node)
> >   {
> > -	struct drm_ras_node *node = &ras->node[severity];
> > -
> >   	kfree(node->device_name);
> >   	node->device_name = NULL;
> >   }
> > +static void cleanup_node(struct drm_device *drm, void *arg)
> > +{
> > +	struct drm_ras_node *node = arg;
> > +
> > +	drm_ras_node_unregister(node);
> > +	cleanup_node_param(node);
> > +}
> > +
> >   static int register_nodes(struct xe_device *xe)
> >   {
> >   	struct xe_drm_ras *ras = &xe->ras;
> > @@ -150,13 +156,19 @@ static int register_nodes(struct xe_device *xe)
> >   		ret = assign_node_params(xe, node, i);
> >   		if (ret) {
> > -			cleanup_node_param(ras, i);
> > +			cleanup_node_param(node);
> 
> At this point drm_ras node is not registered.

Yes, and I don't believe we're attempting to unregister here :)

> >   			return ret;
> >   		}
> >   		ret = drm_ras_node_register(node);
> >   		if (ret) {
> > -			cleanup_node_param(ras, i);
> > +			cleanup_node_param(node);
> 
> Ditto

Ditto.

Raag

> > +			return ret;
> > +		}
> > +
> > +		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> > +		if (ret) {
> > +			cleanup_node(&xe->drm, node);
> >   			return ret;
> >   		}
> >   	}
> > @@ -164,20 +176,6 @@ static int register_nodes(struct xe_device *xe)
> >   	return 0;
> >   }
> > -static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
> > -{
> > -	struct xe_device *xe = arg;
> > -	struct xe_drm_ras *ras = &xe->ras;
> > -	int i;
> > -
> > -	for_each_error_severity(i) {
> > -		struct drm_ras_node *node = &ras->node[i];
> > -
> > -		drm_ras_node_unregister(node);
> > -		cleanup_node_param(ras, i);
> > -	}
> > -}
> > -
> >   /**
> >    * xe_drm_ras_init() - Initialize DRM RAS
> >    * @xe: xe device instance
> > @@ -204,11 +202,5 @@ int xe_drm_ras_init(struct xe_device *xe)
> >   		return err;
> >   	}
> > -	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
> > -	if (err) {
> > -		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
> > -		return err;
> > -	}
> > -
> >   	return 0;
> >   }

