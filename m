Return-Path: <netdev+bounces-161454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F88A218AF
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59A13A5E3A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC98194096;
	Wed, 29 Jan 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2FWUbKj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57602F29
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138347; cv=none; b=eabMkYlz9fq2Ed/MrTJhpkO3RL/QeSzt4DXVpqEcXIxuSeM5AG3LktP7JcCoOjShwVbXKon+ghA9EOOytVjy2qL9Hrc77GejVvs8IJpFX8z1CiGg1IBVRP9bpktZSgouGXlt40p/wnUlVGQTKS8gZb6SeXMQ1CTdin0lUCMgN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138347; c=relaxed/simple;
	bh=oclGy2CyuwuX++2/3PJU6WW23n+1onNoE2lFUwjyqd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLP0VXbPfArKPO1u+IBEcDb2bLuvlF+DBrb8Qvl2CF3bx45l/7746GNMMA3F3xueTsWqploaxa27RMaKsRqHXGmsdVRscXzXZAhZwxObVDE7JWTv84+GF4qWt+E2eyreT2OiUq4DYthu6OO5jaY5wofstsqRI6bcfMPMY6y89nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2FWUbKj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738138346; x=1769674346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oclGy2CyuwuX++2/3PJU6WW23n+1onNoE2lFUwjyqd4=;
  b=G2FWUbKjuklw7AnKosKAhaQ7NhGCzW4GAL+x3UFPHy2+0rZXeoVRKbuP
   m5r70nME+8vNqbBV/Ia/G46EQOP1sXHWahP3TpriTJ8is+kzBRCwgo3sq
   YatwPVxL0Zn7KTFXYAGJW4ZEAAjikzvzAm7z89fpIZdlu+qr72pCMAhe4
   3fcDnd1runnY2CB7MuCSS/D/b99zqTFKFqytKuJ46QBuWocJV6ML0O9RT
   iY1+L6h0wkBRz7CclajTYp8/4lo1K3vz/Hrq7Pr8tmPzlhIZNXgbauE9P
   xKisJVXIjloX3pnJJEE26yXuQyqVGdCzaEBZ6NlPh2xAzNqIyUWsr3Ioa
   A==;
X-CSE-ConnectionGUID: G7fI0ETUSB2cqvn1/8zAXw==
X-CSE-MsgGUID: kFf/XZDtSgutLhKTk5ZwJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56177668"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="56177668"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 00:12:17 -0800
X-CSE-ConnectionGUID: quZrQFXPQKeVImSM7Vudhg==
X-CSE-MsgGUID: 0GThVbBtRHOpolcQCyTDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="108857304"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 00:12:14 -0800
Date: Wed, 29 Jan 2025 09:08:46 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	brett.creeley@amd.com
Subject: Re: [PATCH net 2/2] pds_core: Add a retry mechanism when the adminq
 is full
Message-ID: <Z5niDotlJRWfInK7@mev-dev.igk.intel.com>
References: <20250129004337.36898-1-shannon.nelson@amd.com>
 <20250129004337.36898-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129004337.36898-3-shannon.nelson@amd.com>

On Tue, Jan 28, 2025 at 04:43:37PM -0800, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> If the adminq is full, the driver reports failure when trying to post
> new adminq commands. This is a bit aggressive and unexpected because
> technically the adminq post didn't fail in this case, it was just full.
> To harden this path add support for a bounded retry mechanism.
> 
> It's possible some commands take longer than expected, maybe hundreds
> of milliseconds or seconds due to other processing on the device side,
> so to further reduce the chance of failure due to adminq full increase
> the PDS_CORE_DEVCMD_TIMEOUT from 5 to 10 seconds.
> 
> The caller of pdsc_adminq_post() may still see -EAGAIN reported if the
> space in the adminq never freed up. In this case they can choose to
> call the function again or fail. For now, no callers will retry.
> 
> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/adminq.c | 22 ++++++++++++++++++----
>  include/linux/pds/pds_core_if.h            |  2 +-
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
> index c83a0a80d533..387de1712827 100644
> --- a/drivers/net/ethernet/amd/pds_core/adminq.c
> +++ b/drivers/net/ethernet/amd/pds_core/adminq.c
> @@ -181,7 +181,10 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
>  	else
>  		avail -= q->head_idx + 1;
>  	if (!avail) {
> -		ret = -ENOSPC;
> +		if (!pdsc_is_fw_running(pdsc))
> +			ret = -ENXIO;
> +		else
> +			ret = -EAGAIN;

Short if will fit nice here, anyway:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  		goto err_out_unlock;
>  	}
>  
> @@ -251,14 +254,25 @@ int pdsc_adminq_post(struct pdsc *pdsc,
>  	}
>  
>  	wc.qcq = &pdsc->adminqcq;
> -	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
> +	time_start = jiffies;
> +	time_limit = time_start + HZ * pdsc->devcmd_timeout;
> +	do {
> +		index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp,
> +					   &wc);
> +		if (index != -EAGAIN)
> +			break;
> +
> +		dev_dbg(pdsc->dev, "Retrying adminq cmd opcode %u\n",
> +			cmd->opcode);
> +		/* Give completion processing a chance to free up space */
> +		msleep(1);
> +	} while (time_before(jiffies, time_limit));
> +
>  	if (index < 0) {
>  		err = index;
>  		goto err_out;
>  	}
>  
> -	time_start = jiffies;
> -	time_limit = time_start + HZ * pdsc->devcmd_timeout;
>  	do {
>  		/* Timeslice the actual wait to catch IO errors etc early */
>  		poll_jiffies = msecs_to_jiffies(poll_interval);
> diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
> index 17a87c1a55d7..babc6d573acd 100644
> --- a/include/linux/pds/pds_core_if.h
> +++ b/include/linux/pds/pds_core_if.h
> @@ -22,7 +22,7 @@
>  #define PDS_CORE_BAR0_INTR_CTRL_OFFSET		0x2000
>  #define PDS_CORE_DEV_CMD_DONE			0x00000001
>  
> -#define PDS_CORE_DEVCMD_TIMEOUT			5
> +#define PDS_CORE_DEVCMD_TIMEOUT			10
>  
>  #define PDS_CORE_CLIENT_ID			0
>  #define PDS_CORE_ASIC_TYPE_CAPRI		0
> -- 
> 2.17.1

