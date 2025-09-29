Return-Path: <netdev+bounces-227219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0915BAA67C
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D4D1920882
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA623D7E9;
	Mon, 29 Sep 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbRalK6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37847235053
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172767; cv=none; b=O9Y+W3dZGsTpPpuXQkgHQSOGwVGnyJkHHFJyyus0PK9FKfKZdXSBmpKSLo/4nZ6jQu5g7IfFGh+CK7a5erZ7ZP9JlO4KYUxOUZhGsIpAw0D5EjI8DXA7emG+tDRazlfq675qpkebbNvYUkXc5L3lT3tTKcrhpS4KKZfMCY528fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172767; c=relaxed/simple;
	bh=fWFa56CaCr9LX+5lM2ssDjfftN0f2CkAdQoyFzHbpPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixwMVsmbO9kdVSh93GZMBM/bYWfOyPn2XrL5APOXFr8/PRnZl5xfYTpY8dZIEwD6JmbjXCGC74vZnSWjVYdbOWvtYD8zbavUSWKZHE+zFj9mU6KQ9n7nXYTjd24xWqb/eODsxwKr/gUTHZymTzvrwZxKadaQxTlb0w/FAFsv5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbRalK6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACAAC4CEF4;
	Mon, 29 Sep 2025 19:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759172766;
	bh=fWFa56CaCr9LX+5lM2ssDjfftN0f2CkAdQoyFzHbpPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbRalK6s0VvT890QK/EgzhJz5u5xeTVx3TujpQkqgx4xKF1Zvz6zp4dDeLE5mc5UJ
	 qPAE99xSWeDzwP/eQEnvkihA6NDDbekkqWlrdTtGEZSCi19N8qk59vQ6FiuAnOr+k3
	 C9uPJccfL4NqBowa/80pvRpZw01qbIB3/E/9Q+H0rNzUlK84xcLetjTEHVHCgm28Yu
	 QvH5/Z6AhCKDppPOJcppxzFPqxJwz7YFWt8lz2bfZLP7WmSUXOu3GME6h5A6gVLZD8
	 jFjAToLfZtxNiUW4xiFwGW8+vD+FQnj5g50yOKU1ZngUxEjSjy2Z3ZjZ4A3KFXDyNn
	 dn2ItbNhvNGmA==
Date: Mon, 29 Sep 2025 22:06:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com
Subject: Re: [PATCH net-next 2/6] bnxt_en: Refactor aux bus functions to be
 generic
Message-ID: <20250929190601.GC324804@unreal>
References: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
 <20250922090851.719913-3-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090851.719913-3-pavan.chebbi@broadcom.com>

On Mon, Sep 22, 2025 at 02:08:47AM -0700, Pavan Chebbi wrote:
> Up until now there was only one auxiliary device that bnxt
> created and that was for RoCE driver. bnxt fwctl is also
> going to use an aux bus device that bnxt should create.
> This requires some nomenclature changes and refactoring of
> the existing bnxt aux dev functions.
> 
> Make aux bus init/uninit/add/del functions generic which will
> accept aux device type as a parameter. Change aux_dev_ids to
> aux_dev_rdma_ids to mean it is for RoCE driver.
> 
> Also rename the 'aux_priv' and 'edev' members of struct bp to
> 'aux_priv_rdma' and 'edev_rdma' respectively, to mean they belong
> to rdma.
> Rename bnxt_aux_device_release() as bnxt_rdma_aux_device_release()
> 
> Future patches will reuse these functions to add an aux bus device
> for fwctl.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  23 ++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 102 +++++++++---------
>  include/linux/bnxt/ulp.h                      |  13 ++-
>  5 files changed, 77 insertions(+), 67 deletions(-)

<...>

> index 992eec874345..665850753f90 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -27,11 +27,11 @@
>  #include "bnxt.h"
>  #include "bnxt_hwrm.h"
>  
> -static DEFINE_IDA(bnxt_aux_dev_ids);
> +static DEFINE_IDA(bnxt_rdma_aux_dev_ids);

I would argue that this complexity is not needed, so this and following
two patches are very questionable.

1. The desire is to generate IDs inside auxiliary_device_create() function
and not create IDA per-driver or like in this case per-auxdevice.
2. You are not expected to mix both function pointers and auxdevices
which pretends to be separate devices with separate drivers. Core code
shouldn't call to auxdevice to avoid circular dependency. Auxdevice is
expected to call to core device instead.

Thanks

