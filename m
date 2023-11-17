Return-Path: <netdev+bounces-48751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652B7EF6A2
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D23E2812FE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85564177B;
	Fri, 17 Nov 2023 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlgKWZo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11ED311
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 16:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF55C433C8;
	Fri, 17 Nov 2023 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700240063;
	bh=wh3NvNk23iL8SMdrodhQJkLhcTt2jhyxZcQ1LppkWUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlgKWZo7VeYmcpzS93u1HzDIjxgc2fg/CGnYjJ9z5Rei42XGsmyyWPKk8F4v7L4A0
	 1MxLhHl7fnZDBWSH2f0wWzCAIyNn4nkKavs9gKyOyySy4LKvewOz23THJrmRuSYEXr
	 qQ4x+q3/3pygX7+PVt/0RiU/ZYZsEQHUTTfoEbhHlfQP6kfBv8/J+wK5iX3qXjLpRI
	 T+sdWyPzQaMVLQpQt32uV+CbGCSIY/rtcAm5Esa1nqNYp7fNmy81k6QY4lXQ5GdBZZ
	 KEJ8w91zNBpEYH1m7W8GMs0vXYZijDdwpmARFvsU7jKd4h8/v+zs7+/8WM2056/IHN
	 SdaBN0F1gFNig==
Date: Fri, 17 Nov 2023 16:54:19 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v4 1/1] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20231117165419.GO164483@vergenet.net>
References: <MW5PR03MB693280FDB441C89906BE044BA0B1A@MW5PR03MB6932.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR03MB693280FDB441C89906BE044BA0B1A@MW5PR03MB6932.namprd03.prod.outlook.com>

On Wed, Nov 15, 2023 at 10:10:53AM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.

Hi Min Li,

I think it would be appropriate to include a patch in this series
that makes use of 0x2011xxxx addresses.

> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
> - Apply SCSR_ADDR to scrach register in idtcm_load_firmware advised by Simon
> - Apply u32 to base in idtcm_output_enable advised by Simon
> - Correct sync_ctrl0/1 parameter position for idtcm_write advised by Simon

Thanks for the updates.

>  drivers/ptp/ptp_clockmatrix.c    |  71 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  32 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 331 insertions(+), 314 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..1d5da77502e6 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,7 +41,7 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm);
>  
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> +			     u32 module,
>  			     u16 regaddr,
>  			     u8 *buf,
>  			     u16 count)

...

> @@ -570,27 +571,27 @@ static int _sync_pll_output(struct idtcm *idtcm,
>  	if (qn_plus_1)
>  		val |= SYNCTRL1_Q1_DIV_SYNC_TRIG;
>  
> -	err = idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> +	err = idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
>  	if (err)
>  		return err;
>  
>  	/* PLL5 can have OUT8 as second additional output. */
>  	if (pll == 5 && qn_plus_1 != 0) {
> -		err = idtcm_read(idtcm, 0, HW_Q8_CTRL_SPARE,
> +		err = idtcm_read(idtcm, HW_Q8_CTRL_SPARE, 0,
>  				 &temp, sizeof(temp));

I feel that I am missing something obvious, but I have a question which I
would like to ask by way of an example.

Both before and after this patch idtcm_read() looks like this:

static inline int idtcm_read(struct idtcm *idtcm,
			     u16 module,
			     u16 regaddr,
			     u8 *buf,
			     u16 count) {
        return regmap_bulk_read(idtcm->regmap, module + regaddr, buf, count);
}

And so before this patch the above call to idtcm_read() ends up as
a call to regmap_bulk_read:

	regmap_bulk_read(idtcm->regmap, 0 + 0xa7d4, buf, count);

In particular, the 2nd argument is 0 + 0xa7d4 = 0xa7d4.

But after this patch the call to idtcm_read() becomes:

	regmap_bulk_read(idtcm->regmap,  0x2010a7d4 + 0, buf, count);

In particular, the 2nd argument is now 0x2010a7d4 + 0 = 0x2010a7d4.

My question is, how does this patch take into account the
change in this value from 0xa7d4 to 0x2010a7d4?

Or to the point, does the call to regmap_bulk_read() still
work with the new value?


