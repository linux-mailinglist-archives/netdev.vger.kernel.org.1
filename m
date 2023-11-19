Return-Path: <netdev+bounces-49042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E901A7F078F
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3531F21B16
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1810965;
	Sun, 19 Nov 2023 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtoA6Vci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4B13AC2
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 16:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D151C433C7;
	Sun, 19 Nov 2023 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700411868;
	bh=5WIHftqOMDd2VIsQCh1myJLnnqgplSIpaJC354+s3BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtoA6Vciua+DwOzEsAPBcaHZwUyqsAB1rktFUVE8gVScY+ia9rqerKAaWM1giYsjb
	 2kOaMLroSbd6ZRXhsY7xnB+MAIP8DQCXXejbDJ9riYcyDMzOrPYHg4irkSUM3gHe60
	 h5fLzzdqUAC7Ec+IcZYpJTaJd1ojDxguig8YsuGqQkP3ZsaTRkzwTRDEr1WYmwhlLE
	 mEpPoHHzRMqvKT0HtxNUskpEdWJNY2a6gNJnuCwWMKAO56SEvk46e3X2eNTX2Ua2oZ
	 Y0BqUuz5RVK6ZTrREEKLLY/w/KRYqxtk4bjZFzl5o4T8lllDjArQxMR8KDb/j8M5Pv
	 t5MnLspmGSNuQ==
Date: Sun, 19 Nov 2023 16:37:44 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v2 net-next 1/4] amd-xgbe: reorganize the code of XPCS
 access
Message-ID: <20231119163744.GC186930@vergenet.net>
References: <20231116135416.3371367-1-Raju.Rangoju@amd.com>
 <20231116135416.3371367-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116135416.3371367-2-Raju.Rangoju@amd.com>

On Thu, Nov 16, 2023 at 07:24:13PM +0530, Raju Rangoju wrote:
> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
> be moved to helper functions. Also, the xgbe_pci_probe() needs
> reorganization.
> 
> Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
> access. And, convert if/else statements in xgbe_pci_probe() to switch
> case. This helps code look cleaner.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

...

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index f409d7bd1f1e..d6071f34b7db 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -274,12 +274,16 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	/* Set the PCS indirect addressing definition registers */
>  	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (rdev &&
> -	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
> +
> +	if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD))
> +		goto err_pci_enable;

Hi Raju,

Jumping to err_pci_enable will result in the function returning ret.
However, it appears that ret is set to 0 here. Perhaps it should
be set to an negative error code instead?

Flagged by Smatch.

> +
> +	switch (rdev->device) {
> +	case 0x15d0:
>  		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
>  		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
> -	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
> -		   (rdev->device == 0x14b5)) {
> +		break;
> +	case 0x14b5:
>  		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
>  		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
>  
> @@ -288,9 +292,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  		/* Yellow Carp devices do not need rrc */
>  		pdata->vdata->enable_rrc = 0;
> -	} else {
> +		break;
> +	default:
>  		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>  		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
> +		break;
>  	}
>  	pci_dev_put(rdev);
>  
> -- 
> 2.34.1
> 

