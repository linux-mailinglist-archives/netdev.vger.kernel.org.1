Return-Path: <netdev+bounces-69952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0B84D1FC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AE2B217D2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978183CD9;
	Wed,  7 Feb 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfIbaISJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E58289E
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332766; cv=none; b=N3KWToC3cR5kWoc89lP8B1f6Je9LLfMhY1aSBypLp/6j0dKqZ8YQbhLIWf13GEIEezE1KzOhQz6Yug9b/DlGsSHQpz+3hatOGDg824dnVq+iHu90J//AVirdRfQoKPW9IZo1tmBCgK2khp/sYf14YQP7YlCN5LqDlGvXAlCFVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332766; c=relaxed/simple;
	bh=AHffeFkqlkzNjvgk2uMUDL25/sZLa3SKtFKao1Pw2AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+wKJoqLKBuE3WmkldOkvbvUXcRDeLnaalp8i2ZwGXzLiuoinuL7bC8AB2ppuEn6fPsqIOttCsyL8SstcTSn76NOlvdeXmaLmbY2Kvg5vfSnHt6tFe9iO6Aiu2+k325M/8axBWbI5hxd8SdQ9EGz2Sv4ZfWYhgMvavnHmOxWe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfIbaISJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F4BC433F1;
	Wed,  7 Feb 2024 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332766;
	bh=AHffeFkqlkzNjvgk2uMUDL25/sZLa3SKtFKao1Pw2AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfIbaISJlXXx69ctbCJzCYQC+CLO4CSmJOZW4PIUUbwUoN/go7Fdiv3d0hheZK+TE
	 Feuwy88D4iYrk/mX2mJR4NF/og5UizcBNIlVLz/S2XA5K3ytAsZMaLA79SOzDUWQ4m
	 vbUjSqB/QKxXQskLmWiQznIASKaQm0h2oF2jeG6smV5+qkcsumGTj7lcjWgdbwgm94
	 Y7t+wFqJCFBjEyEjcugVifvu3TzraQet4XK5Rgqw5NHiTgmUhHsuP7lM/PSVT7ADlt
	 DS570srDHieljr98vUNsbved3RwZK42hFSCqI5PY7548giTnD23ZiDSsVqeoIAjU67
	 Ur0CAEhn4Gpng==
Date: Wed, 7 Feb 2024 19:06:02 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v4 net-next 1/2] amd-xgbe: reorganize the code of XPCS
 access
Message-ID: <20240207190602.GL1297511@kernel.org>
References: <20240205204900.2442500-1-Raju.Rangoju@amd.com>
 <20240205204900.2442500-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205204900.2442500-2-Raju.Rangoju@amd.com>

On Tue, Feb 06, 2024 at 02:18:59AM +0530, Raju Rangoju wrote:
> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
> be moved to helper functions. Also, the xgbe_pci_probe() needs
> reorganization.
> 
> Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
> access. And, convert if/else statements in xgbe_pci_probe() to switch
> case. This helps code look cleaner.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Hi Raju,

it seems to me that this patch is doing two things:

1. Adding get_mmd_address() and get_pcs_index_and_offset() helpers,
   and using them.
2. Refactoring xgbe_pci_probe()

I think it would be nice to split this into two patches - one thing per patch.

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 62 ++++++++++--------------
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 +++++++------
>  drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 ++
>  3 files changed, 51 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index f393228d41c7..ac70db54c92a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1150,18 +1150,16 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
>  	return 0;
>  }
>  
> -static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
> -				 int mmd_reg)
> +static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
>  {
> -	unsigned long flags;
> -	unsigned int mmd_address, index, offset;
> -	int mmd_data;
> -
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	return (mmd_reg & XGBE_ADDR_C45) ?
> +		mmd_reg & ~XGBE_ADDR_C45 :
> +		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +}
>  
> +static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata, unsigned int mmd_address,
> +				     unsigned int *index, unsigned int *offset)

nit: Networking (still) prefers code no more than 80 columns wide.

...

