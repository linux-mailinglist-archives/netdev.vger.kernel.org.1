Return-Path: <netdev+bounces-151336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CE9EE381
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93D6283DEE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BE20E715;
	Thu, 12 Dec 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+b7AyzM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F5204C3D;
	Thu, 12 Dec 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997427; cv=none; b=GmA8MWMXGQdEyk75MuCvByv4UuFzPygxaQlEK6bJFkuo9f19o8GhOJyZp99ZUJAhSZMEBcOyEA8M5ROz4pveqmJQuS5vHX5YZqYr0FFgvPJ2i1twO8Bj33otytdKMt6vCodA5Fx9u+qWAPxrGfxfuEhoxqRa26Wfi+puTY8HpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997427; c=relaxed/simple;
	bh=nppU8uMDTN+7Tp4+rDmbcKivr8wiymzwB3BPU5fBWtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMTNooAngV138nLaeYN7n6NS0e3dHjfRgUlWmPNs4sjGcILhw/hBNrS0O1MF5qlLunhM94J8D6kejmK1w8AB4gA90oaSL0KtkgOebm8lheqVyAyKIhxLzQT5OvhIjl3tVEi5xXUv1pFLF6Ic86lQE5i9H3ZkuouE0Aad4Fz/ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+b7AyzM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733997426; x=1765533426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nppU8uMDTN+7Tp4+rDmbcKivr8wiymzwB3BPU5fBWtA=;
  b=V+b7AyzM9s4vgRikwKpAw4h5852+lkc7bsorT3B6syUUDGPa6aFSOmAB
   dw3hGUXDN9oqElxlBnhCSOxkRBDt/eWqpQIrVkdZLOzPo4kNdURULP/bK
   Y/Bybyy2gHbqvBfCR15b16fMVvsC/MhHJzDewhHMqu7E224uKhUAmKsCT
   h4/icnLvzaZXprgzPcxVYCgOw6HShCBNh5W+YzN9KQAIbtUz9Wq9EKDo/
   s9H277fexGsziVsHUZDrbQ1DKWyw9vQabSmH+gQMaG+Bi2CDFdpuWN+B/
   WlJsGrdQXjfWHhvfR0QEkRYUjsorRKrWeB98/b1qtyVOkUCy+KSSirDvC
   A==;
X-CSE-ConnectionGUID: vmdsgPWGT4io1WzA0cf6ag==
X-CSE-MsgGUID: 4AshdFvtRUGbC6PzVH1d+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34133618"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34133618"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:57:06 -0800
X-CSE-ConnectionGUID: 43UYJOO/SG2GYPoQsceDyw==
X-CSE-MsgGUID: Hvwmu08KTpu2+6lxDwrGWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96979763"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:57:03 -0800
Date: Thu, 12 Dec 2024 10:54:02 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Lorenz Brun <lorenz@brun.one>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manuel Ullmann <labre@posteo.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: keep rings across suspend/resume
Message-ID: <Z1qyuioi7N1WYEW4@mev-dev.igk.intel.com>
References: <20241212023946.3979643-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212023946.3979643-1-lorenz@brun.one>

On Thu, Dec 12, 2024 at 03:39:24AM +0100, Lorenz Brun wrote:
> The rings are order-6 allocations which tend to fail on suspend due to
> fragmentation. As memory is kept during suspend/resume, we don't need to
> reallocate them.
> 
> This does not touch the PTP rings which, if enabled, still reallocate.
> Fixing these is harder as the whole structure is reinitialized.
> 
> Fixes: cbe6c3a8f8f4 ("net: atlantic: invert deep par in pm functions, preventing null derefs")
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
>  drivers/net/ethernet/aquantia/atlantic/aq_main.c     |  4 ++--
>  drivers/net/ethernet/aquantia/atlantic/aq_nic.c      |  7 ++++---
>  drivers/net/ethernet/aquantia/atlantic/aq_nic.h      |  2 +-
>  drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c |  4 ++--
>  drivers/net/ethernet/aquantia/atlantic/aq_vec.c      | 10 ++++++++++
>  5 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> index c1d1673c5749..cd3709ba7229 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> @@ -84,7 +84,7 @@ int aq_ndev_open(struct net_device *ndev)
>  
>  err_exit:
>  	if (err < 0)
> -		aq_nic_deinit(aq_nic, true);
> +		aq_nic_deinit(aq_nic, true, false);
Only my suggestion:
Instead of passing another boolean to the function you can have:
aq_nic_deinit(...)
{
	always without free
}

aq_nic_deinit_and_free(...)
{
	aq_nic_deinit(...);
	free
}

It may be easier to read.

>  
>  	return err;
>  }
> @@ -95,7 +95,7 @@ int aq_ndev_close(struct net_device *ndev)
>  	int err = 0;
>  
>  	err = aq_nic_stop(aq_nic);
> -	aq_nic_deinit(aq_nic, true);
> +	aq_nic_deinit(aq_nic, true, false);
>  
>  	return err;
>  }
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index fe0e3e2a8117..a6324ae88acf 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> @@ -1422,7 +1422,7 @@ void aq_nic_set_power(struct aq_nic_s *self)
>  		}
>  }
>  
> -void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
Will be nice to have a kernel-doc.

> +void aq_nic_deinit(struct aq_nic_s *self, bool link_down, bool keep_rings)
>  {
>  	struct aq_vec_s *aq_vec = NULL;
>  	unsigned int i = 0U;
> @@ -1433,7 +1433,8 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
>  	for (i = 0U; i < self->aq_vecs; i++) {
>  		aq_vec = self->aq_vec[i];
>  		aq_vec_deinit(aq_vec);
> -		aq_vec_ring_free(aq_vec);
> +		if (!keep_rings)
> +			aq_vec_ring_free(aq_vec);
>  	}
>  
>  	aq_ptp_unregister(self);
> @@ -1499,7 +1500,7 @@ void aq_nic_shutdown(struct aq_nic_s *self)
>  		if (err < 0)
>  			goto err_exit;
>  	}
> -	aq_nic_deinit(self, !self->aq_hw->aq_nic_cfg->wol);
> +	aq_nic_deinit(self, !self->aq_hw->aq_nic_cfg->wol, false);
>  	aq_nic_set_power(self);
>  
>  err_exit:
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
> index ad33f8586532..f0543a5cc087 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
> @@ -189,7 +189,7 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p);
>  int aq_nic_get_regs_count(struct aq_nic_s *self);
>  u64 *aq_nic_get_stats(struct aq_nic_s *self, u64 *data);
>  int aq_nic_stop(struct aq_nic_s *self);
> -void aq_nic_deinit(struct aq_nic_s *self, bool link_down);
> +void aq_nic_deinit(struct aq_nic_s *self, bool link_down, bool keep_rings);
>  void aq_nic_set_power(struct aq_nic_s *self);
>  void aq_nic_free_hot_resources(struct aq_nic_s *self);
>  void aq_nic_free_vectors(struct aq_nic_s *self);
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
> index 43c71f6b314f..1015eab5ee50 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
> @@ -390,7 +390,7 @@ static int aq_suspend_common(struct device *dev)
>  	if (netif_running(nic->ndev))
>  		aq_nic_stop(nic);
>  
> -	aq_nic_deinit(nic, !nic->aq_hw->aq_nic_cfg->wol);
> +	aq_nic_deinit(nic, !nic->aq_hw->aq_nic_cfg->wol, true);
>  	aq_nic_set_power(nic);
>  
>  	rtnl_unlock();
> @@ -426,7 +426,7 @@ static int atl_resume_common(struct device *dev)
>  
>  err_exit:
>  	if (ret < 0)
> -		aq_nic_deinit(nic, true);
> +		aq_nic_deinit(nic, true, false);
>  
>  	rtnl_unlock();
>  
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> index 9769ab4f9bef..3b51d6ee0812 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -132,6 +132,16 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
>  	unsigned int i = 0U;
>  	int err = 0;
>  
> +	if (self && self->tx_rings == aq_nic_cfg->tcs && self->rx_rings == aq_nic_cfg->tcs) {
> +		/* Correct rings already allocated, nothing to do here */
> +		return 0;
Is the same number of Tx/Rx always enough to say that the vector is the
same? It has more additinal data in the structure.

> +	} else if (self && (self->tx_rings > 0 || self->rx_rings > 0)) {
> +		/* Allocated rings are different, free rings and reallocate */
> +		pr_notice("%s: cannot reuse rings, have %d, need %d, reallocating", __func__,
> +			  self->tx_rings, aq_nic_cfg->tcs);
> +		aq_vec_ring_free(self);
> +	}
> +
>  	for (i = 0; i < aq_nic_cfg->tcs; ++i) {
>  		const unsigned int idx_ring = AQ_NIC_CFG_TCVEC2RING(aq_nic_cfg,
>  								    i, idx);

Thanks,
Michal
> -- 
> 2.44.1

