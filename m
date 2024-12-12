Return-Path: <netdev+bounces-151480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D101D9EFA9A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F9228E5AA
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124422C370;
	Thu, 12 Dec 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/qjrtOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116282253FE;
	Thu, 12 Dec 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026973; cv=none; b=NjemwZZki0Bhw5miOjeHtjbCrlQHSvwwgdinWnURAVb7TgeWz9qdV1qWkMJ+J+5NAfGVFcict1FTfdl8CwITSVmBLzn1bm8wtpw89oEuehOzbxmIzocx28iZq+/pYn+fKcESeSKGtNzmbxCDQ3v6dj2HUV9q7F9TtmP8X9M0dPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026973; c=relaxed/simple;
	bh=1TjkRWZBU28axmJe4vNYPqBY7I/9EiBSXXV3wfGhTXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9h/dm+UjrjuBFuZ1rwJFN9JuFXf+ZvafM386uHnUeoDMGEo+YHyIeNnASc7h1F2Ass66pGVwzQxd0AZpXruZwLFRzWZG5/Cz7I5Li0ZnVi3P0CXsYYCeqmLbIujlXt7/oXmcIT5T2lWkAhY6d+DDVFY4Gm+QHD87AKazNNqVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/qjrtOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4583AC4CED1;
	Thu, 12 Dec 2024 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026972;
	bh=1TjkRWZBU28axmJe4vNYPqBY7I/9EiBSXXV3wfGhTXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/qjrtOikj5SxtqdT61PFTX3lipRF4ofWG/3e6VfNRHa3XIW5KgBP21VOCXmaWItx
	 oMS+b3ncXFA2wE+mH8z8N1bsiyiWdPR+G23MuLBJlyofMr9/YwKXVBE08m30ugrnkN
	 rBr7TQG2K7NlzbCvExf6JTiFFeDcwJ3pxMUiZ+9jD6Fn4MhJE7TvEK/VWVPrp5giaR
	 Ce9CzROU1BGcv05hDb5dlaFumqRei9U0YTlCiL4DCQ+sd0HFbtEFkFj9U3C2HhWsfM
	 z6zcxrVGD8sxCAKffYtj/Fc+mitN6n9K4c3Oa5mhnhTD7y1wKIcezhTOqYZhXuHEEi
	 SvV1SSNi3leBw==
Date: Thu, 12 Dec 2024 18:09:28 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 15/28] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <20241212180928.GH73795@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-16-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-16-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:16PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is create equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |   8 ++
>  3 files changed, 165 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 967132b49832..77af6a59f4b5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -687,6 +687,160 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device *host_bridge;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
> +			__func__, cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The CXL specs do not forbid an accelerator being part of an
> +	 * interleaved HPA range, but it is unlikely and because it helps
> +	 * simplifying the code, we assume this being the case by now.
> +	 */
> +	if (cxld->interleave_ways != 1) {
> +		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
> +		return 0;
> +	}
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
> +		dev_dbg(dev, "%s, host bridge does not match\n", __func__);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (!resource_size(prev))
> +			continue;

Hi Alejandro and Dan,

Below it is assumed that prev may be null.
But above resource_size will dereference it unconditionally.
That doesn't seem right.

Flagged by Smatch.

> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
> +		__func__, &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
> +			__func__, &max);
> +	}
> +	return 0;
> +}

...

