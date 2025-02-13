Return-Path: <netdev+bounces-165849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC01A33860
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B927A1551
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB056207DEF;
	Thu, 13 Feb 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHVBOqRa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACC207A11;
	Thu, 13 Feb 2025 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429933; cv=none; b=N5x9mI6gGGvk9QRDyltVB+hyNSGuXI64xTisTL+xbnOxqcJlFAUL6kuHOa0cl4fqMX8abdZJ39rbeI4nPrITMYOyU+3mZGNB7/pd0DGG13F2lID9uQ/jyJcp32l5N7doMkezRhxcZuI5YvqGf7NAI8iiao6jDgcQqu+aRBKiCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429933; c=relaxed/simple;
	bh=IuDkSPusWTCLmutvKrUiCtONzQj5Xn2RbA/VhezuVxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyieYX1Uzw2yd1VskxNA/B9eI3BxC6mciyZj1kUjkOdLGYvxlv1xCeXpHyAxlqnBvoZwY63YxS6fomYbZ4kZic5Y39n6QwONLZtpfKwYe4e9MDlajZE8pokYndQ9OD+lD+OzlQtQJbmxl1OsxTKeDfFPI4ru29nJz3dsptNZHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHVBOqRa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739429932; x=1770965932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IuDkSPusWTCLmutvKrUiCtONzQj5Xn2RbA/VhezuVxA=;
  b=SHVBOqRaLQEjouentecf0eiV2j3zV+hTODC9h4VCh21No3/c+MScuUtK
   /VKSw4cenwwFJh1bVE6r8r/hvC7d8TsMZQRYB7aadGOdy+z15SHi72d5y
   o4g9XttTDBg6VGfjt6bJQ6Jezr4ul6rwS4SmguYbfscpqVlGV2cmZbJna
   sYYFEEVjfjl2vJJRhTqxxRKdVCeOmdOEEtFijU430yDIvn0Bm6qtTu+LX
   cFIw8jpFDNx2kK4szvjcfp7N1WES5UYdFT+XgJA1fI6QT5+x0yVom4Ks6
   Lio7JHf5lHHI7QWXuMQWS7W6j/x9yvbSszlMG5tkTGNv2VMZCwqJ1Hyba
   g==;
X-CSE-ConnectionGUID: VznTinZERAuXRqGoZHMz9A==
X-CSE-MsgGUID: 1EALNzy+RPmZQ5jEx0JKNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39818279"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39818279"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:58:49 -0800
X-CSE-ConnectionGUID: KUJW1hv9RVqsIDMDOXu40g==
X-CSE-MsgGUID: Uu0E+VmgQ9e+/yLUUhvqhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150223547"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:58:46 -0800
Date: Thu, 13 Feb 2025 07:55:12 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
Message-ID: <Z62XUG6JzoD0sGAb@mev-dev.igk.intel.com>
References: <b16e4f01-4c85-46e2-b602-fce529293559@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16e4f01-4c85-46e2-b602-fce529293559@stanley.mountain>

On Thu, Feb 13, 2025 at 09:31:41AM +0300, Dan Carpenter wrote:
> If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
> then it returns -ENOSPC so there is no need to check for that in the
> caller.  In fact, because pf->msix.min is an unsigned int, it means that
> any negative error codes are type promoted to high positive values and
> treated as success.  So here, the "return -ENOMEM;" is unreachable code.
> Check for negatives instead.
> 
> Now that we're only dealing with error codes, it's easier to propagate
> the error code from pci_alloc_irq_vectors() instead of hardcoding
> -ENOMEM.
> 
> Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Fix my scripts to say [PATCH net-next]
>     Propagate the error code.
> 
>  drivers/net/ethernet/intel/ice/ice_irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> index cbae3d81f0f1..30801fd375f0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> @@ -149,8 +149,8 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
>  
>  	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
>  					PCI_IRQ_MSIX);
> -	if (vectors < pf->msix.min)
> -		return -ENOMEM;
> +	if (vectors < 0)
> +		return vectors;
>  
>  	ice_init_irq_tracker(pf, pf->msix.max, vectors);
>  

Thanks,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.47.2
> 

