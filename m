Return-Path: <netdev+bounces-29126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B5781A94
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EF81C2098C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87B18AE4;
	Sat, 19 Aug 2023 17:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2446BC
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 17:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2904C433C7;
	Sat, 19 Aug 2023 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692464780;
	bh=JOyLJwQSO4rvGUUqbBg6JpdrNb2GV83Hzh4Jii5PVmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MippY8TWUGd6ytAHRyBAKBNvooIHUE6QvicxWS3FZ7Lun3Cc5BlaZUvzDcq91ertJ
	 Fn1dp5S/87a73IoPQoKYmZqZYEJxhkexWlxCK4XQj4VsJTlgpjstQkruBPQZpn5Ue1
	 AmTkxmtZS7tYzzi36y46ERWrmaV2/ji+vTkXxSp5oM6OHNgLDpg56CA95ICRTKtG2R
	 2Vp/SrUoYKW6DFNNyq/d1e1qbbE1FJdsoHUFIrpK1z+Tc+6VpF2bORGos2rAVdMtMZ
	 LykgRhjqTP3yCR6TMYZ0eYxnUNN2WQnpFQ/9ig/YcSb5wqrMjABHBuG8wU8yVxi/CN
	 k4Qw5zVz1pYyA==
Date: Sat, 19 Aug 2023 19:06:15 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: bcmgenet: Return PTR_ERR() for
 fixed_phy_register()
Message-ID: <ZOD2hylmo1/HgaYO@vergenet.net>
References: <20230818070707.3670245-1-ruanjinjie@huawei.com>
 <20230818070707.3670245-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818070707.3670245-3-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 03:07:06PM +0800, Ruan Jinjie wrote:
> fixed_phy_register() returns -EPROBE_DEFER, -EINVAL and -EBUSY,
> etc, in addition to -ENODEV. The Best practice is to return these
> error codes with PTR_ERR().
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v3:
> - Split the return value check into another patch set.
> - Update the commit title and message.
> ---
>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index 0092e46c46f8..4012a141a229 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -619,7 +619,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
>  		if (!phydev || IS_ERR(phydev)) {
>  			dev_err(kdev, "failed to register fixed PHY device\n");
> -			return -ENODEV;
> +			return PTR_ERR(phydev);

Hi Ruan,

thanks for your patch.

Perhaps I am missing something, but this doesn't seem right to me.
In the case where phydev is NULL will return 0.
But bcmgenet_mii_pd_init() also returns 0 on success.

Perhaps this is better?

		if (!phydev || IS_ERR(phydev)) {
			dev_err(kdev, "failed to register fixed PHY device\n");
			return physdev ? PTR_ERR(phydev) : -ENODEV;
		}

I have a similar concern for patch 1/3 of this series.
Patch 3/3 seems fine in this regard.

>  		}
>  
>  		/* Make sure we initialize MoCA PHYs with a link down */
> -- 
> 2.34.1
> 
> 

