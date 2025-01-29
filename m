Return-Path: <netdev+bounces-161453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3BA21878
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1E41889E60
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0319992D;
	Wed, 29 Jan 2025 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzCm92ye"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147D42A92
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137807; cv=none; b=GCl1S22aYbzA8viUmi05JzFMZjzoPAze1SMw1HVnMW/dLWACUQRWtEAaTScT6qJ/jNXpZ9p59Pjv+c40BhJC9M8T60lL97H/frxzq29NGB1UTaMXjLA2QvTxTJBOENFIcfdFuGiPTcTB6IFE7+d9qFmOQ7ZIKo/0gVoAVhW99IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137807; c=relaxed/simple;
	bh=VA1wsl1Ra0E6fpt9pPvOpi7VJWfJhk+EgZCR3xduRPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHk8zh2/BPa2hKSVs6ZzKu3faxTgXBYZmk6SATd9COkrmC/45FIxx51fAxalQW9QEvtK9aLzNokJKhDKxZ9C+tAg46Z/clqjEKh4mOwwFljUOcPClmIyUU8Kw56ABRr6WhQ8uX/NDwD7ycKbVS1ZvbnYto1JigqpzIxYH3hV03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzCm92ye; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738137806; x=1769673806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VA1wsl1Ra0E6fpt9pPvOpi7VJWfJhk+EgZCR3xduRPw=;
  b=WzCm92ye7cXJneUGgNMuIWkH0sXm94D5NoMY4rnbX9MJPEkTQcAUEcMS
   M4MdpbpEI5GjYs7PFkYMMuHqVPst6FRmaUPvYsTtMl9xHLlSunFZSTHvs
   JZsKuFlffPsMzxGnGFmP2w9cEOlNAYUK3386Er9GFw5J2tYFMYNfF44o/
   2+teEs3ugF7i26BY/O0UJ+5D6WqlAKoVihkW+JoSUWEpmYCOLhG1vrq8z
   pIXnVt9rSTtcYqZ6FuHbvaGLZFjkFzYCU84I9Z3TyALBo0Bt6QUF/3dkj
   HOaOUalCccVlXzs+nRqAvaGzUpcuraUhIVIpBJdLe7ULcC/eL9YYbjzJX
   A==;
X-CSE-ConnectionGUID: +UkSmV+dRiWUa3d2lY6p5A==
X-CSE-MsgGUID: LvqclL33RyC4zfnzmSaOzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="41478341"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="41478341"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 00:03:25 -0800
X-CSE-ConnectionGUID: pMugBHphQ4C43qZuXaNplg==
X-CSE-MsgGUID: bBZKD1xSTgSpv6bPynZDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="108932973"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 00:03:23 -0800
Date: Wed, 29 Jan 2025 08:59:54 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	brett.creeley@amd.com
Subject: Re: [PATCH net 1/2] pds_core: Prevent possible adminq overflow/stuck
 condition
Message-ID: <Z5nf+kn1uefCb/wj@mev-dev.igk.intel.com>
References: <20250129004337.36898-1-shannon.nelson@amd.com>
 <20250129004337.36898-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129004337.36898-2-shannon.nelson@amd.com>

On Tue, Jan 28, 2025 at 04:43:36PM -0800, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> The pds_core's adminq is protected by the adminq_lock, which prevents
> more than 1 command to be posted onto it at any one time. This makes it
> so the client drivers cannot simultaneously post adminq commands.
> However, the completions happen in a different context, which means
> multiple adminq commands can be posted sequentially and all waiting
> on completion.
> 
> On the FW side, the backing adminq request queue is only 16 entries
> long and the retry mechanism and/or overflow/stuck prevention is
> lacking. This can cause the adminq to get stuck, so commands are no
> longer processed and completions are no longer sent by the FW.
> 
> As an initial fix, prevent more than 16 outstanding adminq commands so
> there's no way to cause the adminq from getting stuck. This works
> because the backing adminq request queue will never have more than 16
> pending adminq commands, so it will never overflow. This is done by
> reducing the adminq depth to 16.
> 
> This is just the first step to fix this issue because there are already
> devices being used. Moving forward a new capability bit will be defined
> and set if the FW can gracefully handle the host driver/device having a
> deeper adminq.
> 
> Fixes: 792d36ccc163 ("pds_core: Clean up init/uninit flows to be more readable")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/core.c | 5 +----
>  drivers/net/ethernet/amd/pds_core/core.h | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 536635e57727..4830292d5f87 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -325,10 +325,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
>  	size_t sz;
>  	int err;
>  
> -	/* Scale the descriptor ring length based on number of CPUs and VFs */
> -	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
> -	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
> -	numdescs = roundup_pow_of_two(numdescs);
> +	numdescs = PDSC_ADMINQ_MAX_LENGTH;
>  	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
>  			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
>  			     numdescs,
> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index 14522d6d5f86..543097983bf6 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -16,7 +16,7 @@
>  
>  #define PDSC_WATCHDOG_SECS	5
>  #define PDSC_QUEUE_NAME_MAX_SZ  16
> -#define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
> +#define PDSC_ADMINQ_MAX_LENGTH	16	/* must be a power of two */
>  #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
>  #define PDSC_TEARDOWN_RECOVERY	false
>  #define PDSC_TEARDOWN_REMOVING	true
> -- 

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 2.17.1

