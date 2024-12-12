Return-Path: <netdev+bounces-151491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EA9EFB55
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D518852E5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4F223338;
	Thu, 12 Dec 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raFr9Xfy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A72101A0;
	Thu, 12 Dec 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029049; cv=none; b=OhnLhGMFZGyRELjsSf2OCIrgfs58pYB4RM/2y4Q6LiDU0jA1YPW1fcRmfNTCY/irMi5brlu/QCfONTOWZHUQSs//cl3Hx/kxWwARfqzBSvObeeAJK7+Rkpk7tB68fv91VxGp0BHkt6z0+F4FbS9PRL1aGTp4ly/13nIdZfUuqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029049; c=relaxed/simple;
	bh=fp/dUTY0EcFc0/TB9PU8rwyfZcOy8D1EROhkZy2QS2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn/7vqkaT6jGOYEar/oE3OU3MDOJsuGahjPf7mKXKf2P9mSC1eDt+fZy/fo/eUWUgIHagKWxcSte8JnA30IdsJDozfHzJi7n6iMLwcvdXW9qQ5ntYLuvLlLd2NF8huavOuFQ5nUE2LFTUaYH1ltKnSzt0H6vR4fo42oruLo7ryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raFr9Xfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C897DC4CED1;
	Thu, 12 Dec 2024 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029049;
	bh=fp/dUTY0EcFc0/TB9PU8rwyfZcOy8D1EROhkZy2QS2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raFr9XfyXLHHLPVJkdfuDZuHApZ8i0u92YoHfIAi/RA+bOWd0gHPU1VIRWFbxHw5N
	 IVuvNN394G0z8F4a9J5OUpbxQjlf0ZoWEo4yZ7V34Y+LQ1WH5OXpKfs83bd/NNDupO
	 U0tDxLfpVBGrsCnWKN2mFPi8EJG8e/ASPSDMxsRFcrrCAHfqyDv/f9e9CUpItkFYXn
	 NvUbZTET151q72CFbZ8qoU1iH2JOLXXtY31n2Depeje1caiX8MWKwAtEBWoKMc9pUN
	 C5LiieIx9+ATw1IhXe6k5wxti9ZfmofGsoKTCack1BcJ4wPYXR+a5pFzNVw1uFUI/l
	 ZT6fYR7jBGe0A==
Date: Thu, 12 Dec 2024 18:44:04 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <20241212184404.GC2110@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-25-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:25PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  drivers/cxl/cxlmem.h      |  3 ++-
>  include/cxl/cxl.h         |  3 ++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b014f2fab789..b39086356d74 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * cxl_region driver.
>   */
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled)
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax)

nit: no_dax should be added to the Kernel doc for this function.

Also, I think you need to squash the following patch, which updates
the caller to use pass the extra argument, into this patch. Or otherwise
rework things slightly to avoid breaking bisection.

>  {
>  	struct cxl_region *cxlr;
>  

...

