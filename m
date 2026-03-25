Return-Path: <netdev+bounces-271562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OItRCWfnw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582B326128
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DD9130C8241
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA763DC4CD;
	Wed, 25 Mar 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8mQ44ZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DE3DC4AF
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445519; cv=none; b=gtC8LMRV23KrvIwvFWhWA8qsCVj8z7uM0pI4nq3h2cHN2hs8jsx3nEkPzXEr6aQccSRi6HEYKQ3U121BDpoZkDwE1mVYBsFMOZGZrtL9U1HWA/SbnMQ585b+/iLeAvKFgeS7Odh65Oad36avx4tfe1QMMqpVnRgCqii90lUPugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445519; c=relaxed/simple;
	bh=AfbjMFvIEQIsKqipV64JeUiV3a4hNryaOeC6I7cYi70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lazNuVdoVW5t+6Hojio43F1yrgtvllygUDX9dgD0RCU30Fe1TtrVVTdfO70s/b/TTd5nnf5VTT1scquo9yF4BkOCbVi80qAX1CrMZ5k2Gs9MsYHmd5jl/NfPN8CL/WoZkqWzeAYNVNBeucYRBum7ailgQERElnvYszyhiZUw5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8mQ44ZJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774445517; x=1805981517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfbjMFvIEQIsKqipV64JeUiV3a4hNryaOeC6I7cYi70=;
  b=l8mQ44ZJwruOt+wUydWLfanAcig2a5rBuCkiiBqlgxqNvxCUQwngEhhU
   EShoIaIgVL58IEFgeMvgd5MmO0b+q7XPqhXbQ2DDX6qYLRGYb2YrRD2Xo
   C9aSew8zF2xSgFWM5+mErRiKNGD+++bsnmaggkV/LLcumvmR3loadHLtx
   S6my+z/LF3gjA2wjYGU/Nnd01fy5W1424fj9EVn5tOMRcwdq5QmcbJX47
   s/0DXncFGDNhZPuV/uXys5W8GTKt6qypBbojDC+oL4jaMfnYFQ2AzQXyc
   JgC/6jcbDV7GTr5MZ6UwY/IspIfH5rEH75nAz4pftxTCSBCPqxj/TV+/S
   g==;
X-CSE-ConnectionGUID: Xz8JnXgfTsK1fUTipMYF6A==
X-CSE-MsgGUID: N3OLabjTRtiSzDi5r5QaWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86558683"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86558683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:31:57 -0700
X-CSE-ConnectionGUID: Ob0snIG0TcmV3mTY+a4Nww==
X-CSE-MsgGUID: b43bz8bhRTqaD0inBrd4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224937123"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:31:53 -0700
Date: Wed, 25 Mar 2026 14:31:49 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
	airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <acPjxf5XTYuR7sbM@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311102913.3387468-9-riana.tauro@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	TAGGED_FROM(0.00)[bounces-271562-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,amd.com:email,qualcomm.com:email,davemloft.net:email,black.igk.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5582B326128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:
> Add support for asynchronous error notifications in drm_ras.

It's either drm_ras or DRM RAS, make it consistent in all patches
(both commit message and subject).

> Define a new `error-event` netlink event and a new multicast
> group `error-notify` in drm_ras spec. Each event contains
> a node-id and error-id to identify the type and source
> of error.
> 
> Add drm_ras_error_notify() to trigger this event from drivers.
> Userspace can receive this event by subscribing to the
> multicast group error-notify.
> 
> Example: Using ynl tool

Ditto. Either Usage or Example, make it consistent in all patches.

Also, please utilize the full 75 character space where possible.

> $ sudo ynl --family drm_ras --subscribe error-notify
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> ---
>  Documentation/gpu/drm-ras.rst            |  9 +++++
>  Documentation/netlink/specs/drm_ras.yaml | 14 +++++++
>  drivers/gpu/drm/drm_ras.c                | 48 ++++++++++++++++++++++++
>  drivers/gpu/drm/drm_ras_nl.c             |  6 +++
>  drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>  include/drm/drm_ras.h                    |  2 +
>  include/uapi/drm/drm_ras.h               |  3 ++
>  7 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 4636e68f5678..09b2918f67bd 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -54,6 +54,8 @@ User space tools can:
>    ``node-id`` and ``error-id`` as parameters.
>  * Clear specific error counters with the ``clear-error-counter`` command, using both
>    ``node-id`` and ``error-id`` as parameters.
> +* Listen to ``error-event`` notifications for error events by subscribing to the
> +  ``error-notify`` multicast group.
>  
>  YAML-based Interface
>  --------------------
> @@ -109,3 +111,10 @@ Example: Clear an error counter for a given node
>  
>      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>      None
> +
> +Example: Listen to error events
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --subscribe error-notify
> +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}

Can we also have error-name and node-name? I'd be pulling my hair off
if I need to remember all the ids.

On that note, I think it'll be good to have them as part of request
attributes as an alternative to ids (also for existing commands) but
that can done as a follow up.

Also, what if I have multiple devices with multiple nodes. Do they need
separate subscription?

Raag

