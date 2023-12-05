Return-Path: <netdev+bounces-53844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C9804DB9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571EF1C20A7A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E113E483;
	Tue,  5 Dec 2023 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+ur2qqE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AE3C082
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04DC433C7;
	Tue,  5 Dec 2023 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701768273;
	bh=LE4v9iNcz3QGxhQv8zqdcmJBFGyHYI45ixnNodZ4Tnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+ur2qqE4tEKBVcwnd+4nPXAEG3oHW3XTb9zLUw0xjJPl4Hml+yoh1l+izgkexVxb
	 kiv4xnO0z60QIpEPVuq9P7poxaNliwATjcG+fw6ZgbHBsUkd8O1nPR+6PgnfpseNGy
	 5aUAgXICvXLpf2/0hhqdE0u167ZQkU/THjJMf7QC6QJHnBSAsvYn29I7O8thX1l7qG
	 c4jhFVuYoSWnF6GVkNeybZZhBVFe7ED9AnkU2KOb+2T3o5OKv4aBMWcSyBSKhuBaSC
	 R3cshUcCLL4GhH4/xLRaUttjxHVPypjVnILfX6ZKMtZbPsw42tCwVxP2IASWxroSaD
	 dAMUV6wp4g72A==
Date: Tue, 5 Dec 2023 09:24:29 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20231205092429.GS50400@kernel.org>
References: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Thu, Nov 30, 2023 at 01:46:29PM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

...

> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..f8556627befa 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,8 +41,8 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm);
>  
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> -			     u16 regaddr,
> +			     u32 module,
> +			     u32 regaddr,
>  			     u8 *buf,
>  			     u16 count)
>  {
> @@ -50,8 +50,8 @@ static inline int idtcm_read(struct idtcm *idtcm,
>  }
>  
>  static inline int idtcm_write(struct idtcm *idtcm,
> -			      u16 module,
> -			      u16 regaddr,
> +			      u32 module,
> +			      u32 regaddr,
>  			      u8 *buf,
>  			      u16 count)
>  {

Hi Min Li,

My understanding of Paolo's review of v5 was that it would be cleaner to:

1. Leave the type of the module parameter as u16
2. Update the type of the regaddr parameter to u32

And...

...

> @@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
>  	val = SYNCTRL1_MASTER_SYNC_RST;
>  
>  	/* Place master sync in reset */
> -	err = idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> +	err = idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
>  	if (err)
>  		return err;
>  
> -	err = idtcm_write(idtcm, 0, sync_ctrl0, &sync_src, sizeof(sync_src));
> +	err = idtcm_write(idtcm, sync_ctrl0, 0, &sync_src, sizeof(sync_src));
>  	if (err)
>  		return err;
>  

... avoid the need for changes like the two above.

As it is the meaning of module and regaddr are subtly reversed.
If that is intentional then it really ought to be at least stated
in the patch. And, IMHO, ideally a separate patch.

As it is, reversing the meaning of these parameters seems
to add extra churn to this patch.





