Return-Path: <netdev+bounces-151479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604E89EFA5B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDE21893131
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC002210EA;
	Thu, 12 Dec 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN8Ey7zB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DF205517;
	Thu, 12 Dec 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026665; cv=none; b=elChjQt0cfvAzMmbgGCu+YqhMH8qjIC4s+Jd2sKUeyf404O/+uIObGxg+nLTtE8WLTo1Ieh4cZ57saB7JI2/0eJ48XDAw3XslP2IKauFvuUua0jhCpwRiJWhaiOcbdBaxqeB+NUzHUoLsQgZiX8Yzt9WLXl7UQqwEWYSRkEeDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026665; c=relaxed/simple;
	bh=oc3RC83dgYccnL8/qHAyI1IZIiTbMy6/CSwlvs21/e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPLdhQ/wka/MkXZvXwve5YLPd2j4r+xAwT1vGp56FNVSUUZS+7367Drdu18agOEpmHYKFDUQym86sNbnft0696sEMDnj5xXg40UfaQ0amOnjR2pPGklGTBkPSOV4npainLCZW14YDNjsYtonPBULTt4tZV0qiBu8q+tYK3cCfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN8Ey7zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D75C4CECE;
	Thu, 12 Dec 2024 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026665;
	bh=oc3RC83dgYccnL8/qHAyI1IZIiTbMy6/CSwlvs21/e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XN8Ey7zB54+JdfFjzGATabmDm+OMD4gwXTUugW5k5bfeq9I7jdI+CkQ8BtwE6CHOF
	 Qx8mePSeqAMVRNtZFnBtEFiN/JAjbEp+wd/sGfQumdwwqar2HzqX2KHdVORv/uWG5J
	 F3DSNSfI1VatPj9h0wL0yCB/wVomzRuY2GJUorR/fY/aLsGylABFS8kpQuwx/FcJ3T
	 qCLb80VnzO8vjjxdPJpP2tU/NxanEOqvo1DEOzQ7JEPbYqXkLhswJ1mGvUdlbwQjuq
	 CSFJ4baMR9IqKpz7F8C2Ej5S3Y8gEZBXLuOXWlec7+joeQy4aFkrGQ6piz7MRInJjJ
	 ceBbGL9+AcpWg==
Date: Thu, 12 Dec 2024 18:04:20 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 07/28] sfc: use cxl api for regs setup and checking
Message-ID: <20241212180420.GG73795@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-8-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-8-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:08PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 58a6f14565ff..3f15486f99e4 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,6 +21,8 @@
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct pci_dev *pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> @@ -65,6 +67,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err2;
>  	}
>  
> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL accel setup regs failed");
> +		goto err2;
> +	}
> +
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
> +
> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
> +		pci_err(pci_dev,
> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",
> +			*found, *expected);
> +		goto err2;

Hi Alejandro,

goto err2 will result in the function returning rc.
However, rc is 0 here. Should it be set to a negative error value instead?

Flagged by Smatch.

> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> -- 
> 2.17.1
> 
> 

