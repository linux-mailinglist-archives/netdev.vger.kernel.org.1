Return-Path: <netdev+bounces-99919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 432618D7026
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B8AB22B12
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A315099F;
	Sat,  1 Jun 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzwFtJx9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DE8405D;
	Sat,  1 Jun 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247786; cv=none; b=rlsxyo0/+JdxIeR33FLY7Jl1QSVmFQwF07iHhpJ5juDIblwwMp5R5iXkSNpA9sJwuO7w6tN09ZVnllvv81HaB3gPpRMfhb0lk5ReyFQbEi+BD2KAbhtyctg8RQ110sA8Krfd0F9HewhHm06zLdk1/PyQp6pJboPQuYUi2ahN3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247786; c=relaxed/simple;
	bh=BDYiHLgOxFM07kj3mFIpBgiAJCFSiSzDEkmgs0Bz6e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/R9N2G2PGziMhsVckAst64v7ydA6Kf5airJk6VT0MwyO8zcWouFEDB4jJz5fGOZ/BGuQJGoSI4VB2TWBWiWhX9tqGJKz+YLYYRHBVOh+n8/7L4y6WfZBENpiGtG2sjWGWuzV8sPvVhtqv235Xej/eeiJgPiYEoVfjhMEy0X0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzwFtJx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58868C116B1;
	Sat,  1 Jun 2024 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717247786;
	bh=BDYiHLgOxFM07kj3mFIpBgiAJCFSiSzDEkmgs0Bz6e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzwFtJx9UWUqPoJ4Ua9VVxFOHJjLpCQMH/v4XL3bqjyjBWK9AbgkffroAK4MHg/sx
	 abTdKTKrMUgOkMcoVS0wgfQC8oCEzH6KzezX+liK4gT/0bwpdaYPx+ATXXbWjjU71D
	 1wuknLzCU5a2G2kMcveLvPflbEj8xnWzryHQuVuFc9VQ27kqCjY79w+0yZU+dXkjx/
	 3HsEfhq++XE0B7g3u1xbqIVdmctaLQhGTIg1vhvqS8wvc0ARn2jVAcxSHGlo1pW2K+
	 Q9hsaLEH6XxBxKk03E19t217FEU7vFYefoZGTVefHpVrXdsnbVw81wiYEPD8FJHvcK
	 w6ZjxKOc0ejJg==
Date: Sat, 1 Jun 2024 14:16:20 +0100
From: Simon Horman <horms@kernel.org>
To: Ricky Wu <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com, wojciech.drewek@intel.com,
	michal.swiatkowski@linux.intel.com, pmenzel@molgen.mpg.de,
	Cyrus Lien <cyrus.lien@canonical.com>
Subject: Re: [PATCH net,v2] ice: avoid IRQ collision to fix init failure on
 ACPI S3 resume
Message-ID: <20240601131620.GM491852@kernel.org>
References: <20240530142131.26741-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530142131.26741-1-en-wei.wu@canonical.com>

On Thu, May 30, 2024 at 10:21:31PM +0800, Ricky Wu wrote:
> A bug in https://bugzilla.kernel.org/show_bug.cgi?id=218906 describes
> that irdma would break and report hardware initialization failed after
> suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).
> 
> The problem is caused due to the collision between the irq numbers
> requested in irdma and the irq numbers requested in other drivers
> after suspend/resume.
> 
> The irq numbers used by irdma are derived from ice's ice_pf->msix_entries
> which stores mappings between MSI-X index and Linux interrupt number.
> It's supposed to be cleaned up when suspend and rebuilt in resume but
> it's not, causing irdma using the old irq numbers stored in the old
> ice_pf->msix_entries to request_irq() when resume. And eventually
> collide with other drivers.
> 
> This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
> clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
> irdma if we've dynamically allocated them). On resume, we call
> ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
> MSI-X vectors if we would like to dynamically allocate them).
> 
> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> ---
> Changes in v2:
> - Change title
> - Add Fixes and Tested-by tags
> - Fix typo
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index f60c022f7960..ec3cbadaa162 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5544,7 +5544,7 @@ static int ice_suspend(struct device *dev)
>  	 */
>  	disabled = ice_service_task_stop(pf);
>  
> -	ice_unplug_aux_dev(pf);
> +	ice_deinit_rdma(pf);
>  
>  	/* Already suspended?, then there is nothing to do */
>  	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
> @@ -5624,6 +5624,10 @@ static int ice_resume(struct device *dev)
>  	if (ret)
>  		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
>  
> +	ret = ice_init_rdma(pf);
> +	if (ret)
> +		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n", ret);
> +

nit: The line above could trivially be wrapped to fit within 80 columns,
     as is preferred for Networking code.

     Flagged by checkpatch.pl --max-line-length=80

>  	clear_bit(ICE_DOWN, pf->state);
>  	/* Now perform PF reset and rebuild */
>  	reset_type = ICE_RESET_PFR;
> -- 
> 2.43.0
> 
> 

