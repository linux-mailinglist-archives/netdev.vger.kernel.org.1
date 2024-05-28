Return-Path: <netdev+bounces-98478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF78D18D0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CD51C21922
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27F16B744;
	Tue, 28 May 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxkFMBy8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449C16B738;
	Tue, 28 May 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893035; cv=none; b=glHQSoe5u+pSPdAQAYj76H25lfkH0JLMkZ7ivlAsATezsbi7RlHnjlH/ckl2CO6BrLGeMOg2wiSZWl3c+h7noMdRD2JZq2JT9eDGnPOHFv8su1RtWpvhHF/U7CDtWwFljF2f7zOfJhDhcH88jU6+h3UxOLZYU3J63a11Ht7G1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893035; c=relaxed/simple;
	bh=faO5qzmy4SrjD0t39u78b/WW8X2p7Mw4t5HKMKNoD2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuEPmMwv+m+C5YbuxJhk4q8Qb/QHsIKSpnqQLIhWZfT7Kj6gS+7poW+Whi6F4K2yIPC8B2VRnCBNcMO5B6xjpvKZGKTfBBSWB+HXYheRcfdV3XcQeqBoVi0MLjE7PoL+dLHwssKlCoQvAIcHcnzuxp6iYtyHLbsOeTeq4RU5tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxkFMBy8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716893034; x=1748429034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=faO5qzmy4SrjD0t39u78b/WW8X2p7Mw4t5HKMKNoD2A=;
  b=UxkFMBy81gH3XgmBlT3qS3FqmE0jS3VXRq6BECZZ+el63HmdzBYxznfe
   CP0S/goHHgsqDWJHNun6UYpOKH4Nz1d5a0PjEzIo9lrf/P7Yx6g9ZOquH
   Z9gi4l0JOZRcQWcqfFJpMKdeEvU1AM5qNXmG+YX2n7c99s75PbijPZNCO
   24D/+Yp0DZkcF+/4pd8VNtW+lTD0flt4DQjco9r/6hilBeBKfxP3zszsz
   i4WS6hzYUlpA2v+ElUq9ms9+MwXkyX+3HhZB5lUeFPxONzB+j+8QUCx31
   2m3jNbOIh14Ke3g7QW43FQ/olGZyjLNJu0MdHC4XfZrX2bkgTseup27mZ
   w==;
X-CSE-ConnectionGUID: Qy+3qRuvRyOaJMgfVeI/4A==
X-CSE-MsgGUID: G0fpYyCrQtqbDyRwYFChOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13001688"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13001688"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:43:53 -0700
X-CSE-ConnectionGUID: jj070PvSQhKUAU35PmDPIA==
X-CSE-MsgGUID: X5hnXjsSSeulPrJQrCdEKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39470586"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:43:50 -0700
Date: Tue, 28 May 2024 12:43:02 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Ricky Wu <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org,
	edumazet@google.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after
 suspend/resume
Message-ID: <ZlW1NiQOpf6497Tg@mev-dev>
References: <20240528100315.24290-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528100315.24290-1-en-wei.wu@canonical.com>

On Tue, May 28, 2024 at 06:03:15PM +0800, Ricky Wu wrote:
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
> irdma if we've dynamically allocated them). On Resume, we call
> ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
> MSI-X vectors if we would like to dynamically allocate them).
> 
> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
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
>  	clear_bit(ICE_DOWN, pf->state);
>  	/* Now perform PF reset and rebuild */
>  	reset_type = ICE_RESET_PFR;

Looks fine, thanks for the fix. You can add fixes tag and target it to a
net tree.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.43.0
> 

