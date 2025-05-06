Return-Path: <netdev+bounces-188309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028CAAAC150
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254D03B4541
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841B278750;
	Tue,  6 May 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8Mt6uQS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422B2777FC;
	Tue,  6 May 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527122; cv=none; b=JgF4imwGsg0ACC81itnXG079o3dvKFOyrkoXl1WUNk36V3lM+K1Q+JbeAV7HeB6JB+5j8Bx2TfNSQ9wvydn9OHguh+AeNdKcCm0jt1ICRnCV3HEaJHro2RZ5Hw9my6cPWWPI3Fi5Bt9009iWokHd2L9LX1gOMudbG47FuRpF6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527122; c=relaxed/simple;
	bh=ER3+WX6Fn7TizF7Fs+zanDiEtNNqVrG5KKHsKgWbPvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWLPPL4kUX//BXZTRWF2ax9+gXljjlLx8Rhc2y3Qflp6tXfdAzKPVfDBxWdA6Sz67k6cOW26sacraudo4h/74cyPJTHf+2Kv/y+A97q6AcROl7Jdg/Gh0mITiKT4gK5sXdwC0Wy1nlOrrX1viFPog22P8Mwk3mTb9uckViNAc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8Mt6uQS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746527120; x=1778063120;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ER3+WX6Fn7TizF7Fs+zanDiEtNNqVrG5KKHsKgWbPvo=;
  b=Z8Mt6uQSKt64D28NpQRdjCWX5TQuFzFXT52a4Ngm4hxr8VdKAjgNmmly
   XqOXgxXGZbbO4uAo+CQzzzEtabOXV/yiMsPskNwTBDo5Z2RKlxortUUop
   INbCIzTu8/jqb+KhF3/qTZynnoBKF5wlJPAuPyKrprq6g+vhzTHpWrWsL
   hTvcFaUDISCyEg+x1UklmmMU8W6ThTZxGAOsc6PVCVDgOmT9U5ClltOfx
   ufD/ai4AhpLO/Y83ekCjtyteZhlYfY/9EX/x+XIosDZfnImCcDkvCWfat
   sWX3dBnxDK7QQI0bLRQCyaWZ6ZAi2/xwjCRwg0fKLp6EjqWD6R0EAwnGG
   A==;
X-CSE-ConnectionGUID: ShK7N9VmS7+rQaa4u+puZA==
X-CSE-MsgGUID: JrsFAsy7R3qa5a9Y0JlutQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51993564"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="51993564"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 03:25:18 -0700
X-CSE-ConnectionGUID: Ck10n3cyRsacHwt1VjnfGw==
X-CSE-MsgGUID: 3lF5rXSWRaSZ0eaBD3MM2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="158825654"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 03:25:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jeff Layton <jlayton@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Jeff
 Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 09/10] i915: add ref_tracker_dir symlinks for each
 tracker
In-Reply-To: <20250505-reftrack-dbgfs-v7-9-f78c5d97bcca@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
 <20250505-reftrack-dbgfs-v7-9-f78c5d97bcca@kernel.org>
Date: Tue, 06 May 2025 13:25:10 +0300
Message-ID: <87zffqujcp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 05 May 2025, Jeff Layton <jlayton@kernel.org> wrote:
> Now that there is the ability to create a symlink for each tracker, do
> so for the i915 entries.

I haven't tried this, but

Acked-by: Jani Nikula <jani.nikula@intel.com>


>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/gpu/drm/i915/intel_runtime_pm.c | 1 +
>  drivers/gpu/drm/i915/intel_wakeref.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
> index 3fdab3b44c08cea16ac2f73aafc2bea2ffbb19e7..94315e952ead9be276298fb2a0200d102005a0c1 100644
> --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
> @@ -61,6 +61,7 @@ static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
>  {
>  	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT,
>  			     "intel_runtime_pm", dev_name(rpm->kdev));
> +	ref_tracker_dir_symlink(&rpm->debug, "intel_runtime_pm-%s", dev_name(rpm->kdev));
>  }
>  
>  static intel_wakeref_t
> diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
> index 5269e64c58a49884f5d712557546272bfdeb8417..2e0498b3fa7947f994de1339d4d2bed93de1a795 100644
> --- a/drivers/gpu/drm/i915/intel_wakeref.c
> +++ b/drivers/gpu/drm/i915/intel_wakeref.c
> @@ -115,6 +115,7 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
>  
>  #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
>  	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, "intel_wakeref", name);
> +	ref_tracker_dir_symlink(&wf->debug, "intel_wakeref-%s", name);
>  #endif
>  }

-- 
Jani Nikula, Intel

