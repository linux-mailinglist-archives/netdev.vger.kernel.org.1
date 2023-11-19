Return-Path: <netdev+bounces-49043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E1B7F0792
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4C2280F11
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475E913AC0;
	Sun, 19 Nov 2023 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btVZuE3h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23014A88
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 16:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0687C433C8;
	Sun, 19 Nov 2023 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700412178;
	bh=NtbOgGn0f1GJpK48NFHHAtP3UgZuYNI8fTOjUsbdL5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btVZuE3hg/H0SQZ8gNMHdSKCXXvJNEq7GRJKnCVUWIdGKfua8ry4s3/lM29WHpWO8
	 ZaLGwWtS1eGs9PPYo5ebMH7BtVAIWuLni50UviZJ4aRY3ULGOEku9LInIQtFIyTDE1
	 vS0tKLlJLBeSp/1vX/2UONFkGZVtQ3Kh/OEn2nnANsocjAmQdb4FIn7AfCy2B2DKJS
	 KzyK0Z+d+WuxxBGNmCQJO3V+TXbSB4pve2xV0nvogZmxjhaxWZgzRGPH/JA2Lav/16
	 r5fWA8weWcATp/ydNQzXjEV1i/FrkEohM066qGdu984n13CroIWyFpq7X4bm/6EFru
	 MRsDuRr5MGEbA==
Date: Sun, 19 Nov 2023 16:42:54 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH v2 net-next 2/4] amd-xgbe: add support for Crater
 ethernet device
Message-ID: <20231119164254.GD186930@vergenet.net>
References: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
 <20231116135416.3371367-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116135416.3371367-3-Raju.Rangoju@amd.com>

On Thu, Nov 16, 2023 at 07:24:14PM +0530, Raju Rangoju wrote:
> Add the necessary support to enable Crater ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Crater, use
> the pci_{read/write}_config_dword calls.
> 
> Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

...

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c

...

> @@ -479,6 +492,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
>  	return ret;
>  }
>  
> +static struct xgbe_version_data xgbe_v3 = {
> +	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
> +	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
> +	.mmc_64bit			= 1,
> +	.tx_max_fifo_size		= 65536,
> +	.rx_max_fifo_size		= 65536,
> +	.tx_tstamp_workaround		= 1,
> +	.ecc_support			= 1,
> +	.i2c_support			= 1,
> +	.irq_reissue_support		= 1,
> +	.tx_desc_prefetch		= 5,
> +	.rx_desc_prefetch		= 5,
> +	.an_cdr_workaround		= 0,
> +	.enable_rrc			= 0,
> +};

Hi Raju and Sudheesh,

W=1 allmodconfig builds on x86_64 with gcc-13 and clang-16 flag that
xgbe_v3 us defined but not used.

Please take care to arrange patch-sets so that each patch builds
without introducing new warnings.

> +
>  static struct xgbe_version_data xgbe_v2a = {
>  	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
>  	.xpcs_access			= XGBE_XPCS_ACCESS_V2,

...

