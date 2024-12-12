Return-Path: <netdev+bounces-151481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8299EFAB8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D360F16F29B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05C231A39;
	Thu, 12 Dec 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH3sqYJu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2D22370C;
	Thu, 12 Dec 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027128; cv=none; b=AwGsCfCzhuXp4dUFBMdPBiqRqnXtCRSjpTSlpe9LaPs1XIyxhOPnScD+K+RBV2GdJdJHC/ZBQ6VIHM1YrQ/4mjJL/RCPXta6LnbzZPoeQE/qPvHvjlQ3TeXI5zheStNYEA6ao1oMI1rYLNtzUFpmQolkNXbqKweVP+007emIUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027128; c=relaxed/simple;
	bh=OY1y+5vY1bOZPYadIV8H9gvceIlcFBAJIacX4Qcgho0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZqBkYfISn4SXCFKDBU3VHhr4FbDHpHZhrli9/oKLKr7U6G+AS5oh+iNH9nVG5D76XOiKHKIDd0rnD3pegbHoxEMuMHgUiIF6kaFjPJOx5307ik5aqWAKcG6w7K4zRoh99ZPZWj8cKf7I312PvFPSBAqlhGyyA4SpwRVNccGSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH3sqYJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EE2C4CED0;
	Thu, 12 Dec 2024 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027127;
	bh=OY1y+5vY1bOZPYadIV8H9gvceIlcFBAJIacX4Qcgho0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH3sqYJu2nuhuKXv2eF2Wv7A4Bidw9g48lwKLJHgvcYJEHkxZVosEknSDpF7MtqQC
	 4vLjhdxUYnJyQLCyLcmS+Tl2mKOlDqTDiDORu9lqOvOXOtSeEW2rfsDvlqn8mG3oJA
	 /6hwAW1duvgTLvbw9XKwWyWc6fWRXxzdfw6KqYb6zwAeM54H05m3KO1Y0QjGWCzUum
	 y8AJwqzKAER2mk+BIdOT1WXi/pHoZ3OOW82AyEusorWX4FUrGo6ZOFMuHD9qInvX++
	 vM0mjuZL1KVKyE+Iss/0w4gphB5Wjo7UXFznLCtnKYg+80WM961DXM6wLiTgHpmzJP
	 5c+SBKSMq+15w==
Date: Thu, 12 Dec 2024 18:12:03 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 17/28] cxl: define a driver interface for DPA
 allocation
Message-ID: <20241212181203.GI73795@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-18-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-18-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:18PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to  map the minimum amount of memory the driver needs to
> operate vs the total possible that can be mapped given HPA availability.
> 
> Factor out the core of cxl_dpa_alloc, that does free space scanning,
> into a cxl_dpa_freespace() helper, and use that to balance the capacity
> available to map vs the @min and @max arguments to cxl_request_dpa.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 154 +++++++++++++++++++++++++++++++++++------
>  include/cxl/cxl.h      |   5 ++
>  2 files changed, 138 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c

...

> @@ -538,6 +557,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @endpoint: an endpoint port with available decoders

nit: @cxlmd should be described here rather than @endpoint

> + * @is_ram: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     bool is_ram,
> +					     resource_size_t min,
> +					     resource_size_t max)

...

