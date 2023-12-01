Return-Path: <netdev+bounces-52899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927C8009FA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A1DB20D52
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB82136C;
	Fri,  1 Dec 2023 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn0YDiwF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49954219E0
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 11:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5443AC433C8;
	Fri,  1 Dec 2023 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701430503;
	bh=bAkOKZYHWz/B6ZGojduBi42RS2pXekoCHVmKsM+KArI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mn0YDiwFNb08kiD6dNABvWp7l8WtnwibCdgonnaOwbp1itZwfh4Tlx5+66qirmbGh
	 r9Lcrm/m9evgsndO4KfaM3W31iwHQLiilkp9Nl0M5513m4NX6yvybmsF05tnRm/CFs
	 dgAQEWVKRO0eVzRdc2ykXRsih+t7lAns5P8+s1uYdv2+J2xS/ex43dxDkl8691GpEX
	 IOMnDdk5l7SLOJXJm6NyRttFpBvYqE4wpYr6tnoJo0Z0/oDiexOr+jfovNVFA019TW
	 JeDq5j+0eFOdkx+W9/MpTihQhiq0G4GXScOqEP9O3N1pgjbq836l+5M/WugHP1W9bw
	 3W15ZN3K90n/w==
Date: Fri, 1 Dec 2023 11:34:56 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	pbhagavatula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: cn10k: Increase outstanding LMTST
 transactions
Message-ID: <20231201113456.GU32077@kernel.org>
References: <20231129112155.9967-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129112155.9967-1-gakula@marvell.com>

On Wed, Nov 29, 2023 at 04:51:55PM +0530, Geetha sowjanya wrote:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Currently the number of outstanding store transactions issued by AP as
> a part of LMTST operation is set to 1 i.e default value.
> This patch set to max supported value to increase the performance.
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> index 0e74c5a2231e..93fedabfe31e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> @@ -559,3 +559,12 @@ void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw)
>  	cfg |= BIT_ULL(1) | BIT_ULL(2);
>  	rvu_write64(rvu, blkaddr, NIX_AF_CFG, cfg);
>  }
> +
> +void rvu_apr_block_cn10k_init(struct rvu *rvu)
> +{
> +	u64 reg;
> +
> +	reg = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
> +	reg |= 0xFULL << 35;

Hi Pavan and Geetha,

I think it would be best to avoid the magic value 35 here.

Best would probably be to use GENMASK_ULL and FIELD_PREP.
Else defining something similar to APR_LMT_MAP_ENT_SCH_ENA_SHIFT.

It might also be nice to avoid the magic value 0xFULL using a #define.

> +	rvu_write64(rvu, BLKADDR_APR, APR_AF_LMT_CFG, reg);
> +}
> -- 
> 2.25.1
> 

