Return-Path: <netdev+bounces-152555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F303D9F491B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6B161934
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73E1E3DC3;
	Tue, 17 Dec 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo4K0JV6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ABC1E282D;
	Tue, 17 Dec 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432151; cv=none; b=HTWH0YR4vLZolDrZ6AfrxW5g80tJ3DQ3vKy4tVINSqB/+ar6FYdP3oewq3470XC2V63m5he0btvSW/qXcCpSDmEcEDphKbmOLfVGOIW4WU7ljwMxqIPEjvlToxnkZPKatZZ0CM029/5AjYsLtkONbGAZdKcXGP5nvkTQMqTR+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432151; c=relaxed/simple;
	bh=1DE6usUuc7I/k3TUxkIHydMtKw4QUnTOvFMSLro//cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J07Ec9ne4Sn0MboSV3yNkcxDJrihllZ9GmSzxjTOCrJPoM7jx9jws4yuDL02Yi1OgBDd4fGIBG3MiThZ6wh7sLjl1cOXHGO4+6QbXbfeNO0+c4fchEGVq89HLTk4fysCMwv89BjqyTGpyf5PLcGVJZl0SzCaSWfRGNulu0OiOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo4K0JV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E0EC4CED4;
	Tue, 17 Dec 2024 10:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734432151;
	bh=1DE6usUuc7I/k3TUxkIHydMtKw4QUnTOvFMSLro//cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wo4K0JV6nAQFbJG9G+H0dHf/iGpzIigHd/jbC/R6gVIZbabBz+Wnbmk/Tz6tRM9pH
	 JIJY58LDm1oR9uJFnUDraLOlkRm7PaGCN878Sx4lUucWgZYj7VhlR0qt7XbUTFQOY0
	 pAL+7Fz5J47bShMWPvJ7N2uBdppKaRbZf7hiFJwI1ErkKEMqBHsL9/VZlVIuuREUa/
	 rEUOyL2Y8JDBSL/bUHsf3cq6Y6Qi9IhU4ANQ0YRAqt13G8Fd6Nm6zr6w2tO6vLQdJ4
	 JSIub4hDQ1Jp0u5LCCLs0lO3O1deiZIrLXGX3y1cJqnGvDVw+5V8wlSPXNWhFc95Yd
	 /9oNtB/1I0yHg==
Date: Tue, 17 Dec 2024 10:42:25 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 18/27] sfc: get endpoint decoder
Message-ID: <20241217104225.GP780307@kernel.org>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-19-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-19-alejandro.lucero-palau@amd.com>

On Mon, Dec 16, 2024 at 04:10:33PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 253c82c61f43..724bca59b4d4 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -121,6 +121,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_memdev;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxlrd);

Hi Alejandro,

Should the line above use cxl->cxled rather than cxl->cxlrd?

Flagged by Smatch.

> +		goto err_memdev;
> +	}

...

