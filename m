Return-Path: <netdev+bounces-38795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC7B7BC86F
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8522D1C20941
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EB28E1C;
	Sat,  7 Oct 2023 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA72+nID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548928689
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 14:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D519C433C7;
	Sat,  7 Oct 2023 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696690342;
	bh=kykrOis2w1PaWsK9svmGejE5QwtogNC++rLKy8pBryA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oA72+nIDoigy2eNMFHURszzd0IgFdTFO9R40WkcdJVNxaEIQPxXFZE2fmMvarXTeh
	 n7NquBUhhwcX8G8hfOnsWpKtLuaXcCIEkn1EdHLodVTXx5pbmCDHNHafwuikmQ56EK
	 +LMFxs3jqagd8WsPMnRczNy67dbeX8uoWQ7weMF1DW6HzdmcJAKJMHah6PBPMK+zRG
	 ZDqOXKTmWZ+/T9G2YnnfyiViqbzvdr0GtFAOespBKwE/O9UkdlgIUiGDH4tbXsRndO
	 gb/PenUBKRhSn0e0+3YARjsay6SOQQUyyhxl7QiBFZQ26XvCacEIWSvzli7thrhmXk
	 E6X652S33tz/w==
Date: Sat, 7 Oct 2023 16:52:17 +0200
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, richardcochran@gmail.com, lcherian@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net PATCH v2] octeontx2-af: Fix hardware timestamping for VFs
Message-ID: <20231007145217.GB831234@kernel.org>
References: <20231003110504.913980-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003110504.913980-1-saikrishnag@marvell.com>

On Tue, Oct 03, 2023 at 04:35:04PM +0530, Sai Krishna wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Currently for VFs, mailbox returns ENODEV error when hardware timestamping
> enable is requested. This patch fixes this issue. Modified this patch to
> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
> 
> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index f2b1edf1bb43..f464640e188b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -756,12 +756,11 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
>  	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
>  		return 0;
>  
> -	/* This msg is expected only from PFs that are mapped to CGX LMACs,
> +	/* This msg is expected only from PF/VFs that are mapped to CGX/RPM LMACs,
>  	 * if received from other PF/VF simply ACK, nothing to do.
>  	 */
> -	if ((pcifunc & RVU_PFVF_FUNC_MASK) ||
> -	    !is_pf_cgxmapped(rvu, pf))
> -		return -ENODEV;
> +	if (!is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)))

Hi Sai,

I'm not clear on why this change substitutes pf for rvu_get_pf(pcifunc),
as futher above in this function pf is set to the return value of
rvu_get_pf(pcifunc).

> +		return -EPERM;
>  
>  	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
>  	cgxd = rvu_cgx_pdata(cgx_id, rvu);
> -- 
> 2.25.1
> 
> 

