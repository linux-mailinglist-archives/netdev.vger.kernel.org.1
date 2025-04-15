Return-Path: <netdev+bounces-182595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E139FA89459
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CDB1887C77
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39B1C75E2;
	Tue, 15 Apr 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJp1aN7u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158427586F;
	Tue, 15 Apr 2025 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700411; cv=none; b=OcQP1WUchNYcBZ4GR/fgcKYkDByg3Hfm/oNFJVZe0NJTRtvO/ElJIs6PCdo+dZ4x8+rd64VvNr1wF4xQESb8YqY5mstw+4khFcHL87pAhB6Xz9lbKeT6qc4CJarm0N9K/FfFVTtOElhDO4BaCs5sm/muHz5W9Tu84BMdvWZcDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700411; c=relaxed/simple;
	bh=C2p/GvdSf/MpUlUE7MKNGjq3PmhkSh1z6bGrbPDYfFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCnDM+sVO9/Xd8q/aA3aGaBxD0Vyw8sqtnp2dQ1+uOUM0TjpASkVj+R0IwnmvCP7MRyQb71NW2JJrGzGg2geJ7qKCTXupYUjRxSM1ypAXGYKEVFIu/Taox0ZRvnJ7Q0y4cjv5Qv7LpvwD3e16UOgCB0ND+LOeuWbI72IgLm1bgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJp1aN7u; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744700406; x=1776236406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C2p/GvdSf/MpUlUE7MKNGjq3PmhkSh1z6bGrbPDYfFM=;
  b=dJp1aN7u2jJvF9SS9fgjccMVDIGSaz1M1NWJsbOn7pU1+4c1pViUqY8O
   /9wEqjyL3DqeIMkpmJwI5rCss5PsG2CKZjlR4cQdoAV4vqT17ByPz4cUg
   ljmKRge/NzDP1aWlU6CeUWVRZOL1P/k6TAK5lc7DGGO1vTctCzbQfYTgE
   yKgOXhXYBZD3uhJpm5op8B6TXH1aNV1EJmqUkMmrgezNdtqvMkPKgI6de
   5HK82OcLtUlC+YZonKylxnY3NeExZSi/RH1fEOPC07LuJONhD8ktTtJoI
   pdXKA2LWxG6BTmPrTmqjD2gxwV1CvaDVn4ilR+gcdxvQr/G+DmLJmEexU
   A==;
X-CSE-ConnectionGUID: +4nLEZdmSwOIQKT/6+9rbw==
X-CSE-MsgGUID: 0S0cvsHZQn+TYUv90xQwyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="57184134"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="57184134"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:00:06 -0700
X-CSE-ConnectionGUID: sIz9rrG7Sge0gB7h0E3a9A==
X-CSE-MsgGUID: 5+P3nvfqTKq2uA116uid1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130571783"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 00:00:03 -0700
Date: Tue, 15 Apr 2025 08:59:43 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ptp: ocp: fix NULL deref in __handle_s for irig/dcf
Message-ID: <Z/4D3/PW9FkxQSdo@mev-dev.igk.intel.com>
References: <20250415064638.130453-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415064638.130453-1-maimon.sagi@gmail.com>

On Tue, Apr 15, 2025 at 09:46:38AM +0300, Sagi Maimon wrote:
> SMA store/get operations via sysfs can call __handle_signal_outputs
> or __handle_signal_inputs while irig and dcf pointers remain
> uninitialized. This leads to a NULL pointer dereference in
> __handle_s. Add NULL checks for irig and dcf to prevent crashes.
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Paolo Abeni:
>  - https://www.spinics.net/lists/netdev/msg1082406.html
> Changes since v1:
>  - Expanded commit message to clarify the NULL dereference scenario.
> ---
>  drivers/ptp/ptp_ocp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 7945c6be1f7c..4e4a6f465b01 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2434,15 +2434,19 @@ ptp_ocp_dcf_in(struct ptp_ocp *bp, bool enable)
>  static void
>  __handle_signal_outputs(struct ptp_ocp *bp, u32 val)
>  {
> -	ptp_ocp_irig_out(bp, val & 0x00100010);
> -	ptp_ocp_dcf_out(bp, val & 0x00200020);
> +	if (bp->irig_out)
> +		ptp_ocp_irig_out(bp, val & 0x00100010);
> +	if (bp->dcf_out)
> +		ptp_ocp_dcf_out(bp, val & 0x00200020);
>  }
>  
>  static void
>  __handle_signal_inputs(struct ptp_ocp *bp, u32 val)
>  {
> -	ptp_ocp_irig_in(bp, val & 0x00100010);
> -	ptp_ocp_dcf_in(bp, val & 0x00200020);
> +	if (bp->irig_out)
Why not irig_in? Can we asssume that "in" isn't NULL if "out" isn't?

> +		ptp_ocp_irig_in(bp, val & 0x00100010);
> +	if (bp->dcf_out)
The same here.

> +		ptp_ocp_dcf_in(bp, val & 0x00200020);

Just my opinion, I will move these checks into ptp_ocp_...() functions
as bp is passed to a function not bp->sth.

>  }
>  
>  static u32
> -- 
> 2.47.0

