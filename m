Return-Path: <netdev+bounces-151486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507B9EFAE6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E516794B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8C2101A0;
	Thu, 12 Dec 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxG0tJq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD31547F5;
	Thu, 12 Dec 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028177; cv=none; b=mczyeriBb7BDWLzz5cWrHBr7yylulLqPR85f+s0sp542DeudZ+2VKBrD4j5o0OWGLvNUnHxf5m4R845feEJhOl1BTgSpJVkMnf3CZbA+GolMdad0OrgANNAxtF/F9dCN46b3sVXiwmS56KsjDC++HL0E8G32Y9opBBTu14JS+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028177; c=relaxed/simple;
	bh=1PfUjDJ/jJaxCJPYfu1Eokx0VXf5REm0YtGpLhVq/6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfedBBBwJRkoGtlo0OJOpHPKX3yQjZQF6z8KG2eprCeh+6rj1kSGCiBwaLZoBCZ4pGqhJc80vHmULBZ1+RPCs7sk9DLUlyp2KSZnD49K1UbvLPLRtiJxjCB9tzBelnVkOaLqFPCRRX6PVIbiS2cNht6wjiJLkAHpIErhWqecfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxG0tJq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2B9C4CED0;
	Thu, 12 Dec 2024 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028177;
	bh=1PfUjDJ/jJaxCJPYfu1Eokx0VXf5REm0YtGpLhVq/6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxG0tJq646SMym6LBfKtrAZOzW3UHHyYUKTWRTfx249maBzBxQD63bvEMBWHZyTqF
	 ydI9ZPr6JRSdHIGdNbmhbRrwjlCUZ9UmAKAoZuL33r3s+LWcHJBD2y6HGD6Am1TlDx
	 Ht5jaOAUEH55IVruELPvXKPsTmt4EV4w07LrDt7tYFZP2BxQc8PvttYeCCbfLgVCw/
	 Drv7DInDgWfiyTRpK+gPxwERznyBwzuD0PpL1RcdjEZndp2UG8WkNWZZev/IblLDbP
	 qWCKP/R23/DD51aBdBNGebacw4yk7ZleOAr/ZVtsYMJNYHa5SrnbQvQiVvpVWIaBn8
	 h6SgmJIyNu9VQ==
Date: Thu, 12 Dec 2024 18:29:33 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 23/28] sfc: create cxl region
Message-ID: <20241212182933.GB2110@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-24-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-24-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:24PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for creating a region using the endpoint decoder related to
> a DPA range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 09827bb9e861..9b34795f7853 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
> +	if (!cxl->efx_region) {
> +		pci_err(pci_dev, "CXL accel create region failed");
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_region;

Hi Alejandro,

This is similar to my feedback on patch 18/28.

Looking over the implementation of cxl_create_region it seems
that it returns either a valid pointer or an error pointer, but
not NULL. If so, I think the correct condition would be
(completely untested):

	if (IS_ERR(cxl->efx_region)

But if cxl->efx_region can be NULL then rc, the return value of this
function, will be set to zero. Which doesn't seem correct given
the error message above.

> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err_region:
> +	cxl_dpa_free(cxl->cxled);
>  err3:
>  	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err2:
> @@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_accel_region_detach(probe_data->cxl->cxled);
>  		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
> -- 
> 2.17.1
> 
> 

