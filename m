Return-Path: <netdev+bounces-133636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462FC99694F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B002AB26F0D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D71925B4;
	Wed,  9 Oct 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJyOhibx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4253192585;
	Wed,  9 Oct 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474893; cv=none; b=U3ycTTcAwOLWMZwgj8DKFPEkQLLpNC+EvuXL5zZYtIgZsKR2SA2kpA9aWL70Uk7yzkCHnT49Fe0fmaGXwYGNMGwDVmv7Qs9qLgcfWJTuCn0IxqJbY+c5PF7MgWHhs0laMiJeGce072ohmhgefoNR95JVekD19vUTY6GOYQ9QhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474893; c=relaxed/simple;
	bh=6XboQiBiqtAshC35gbGlqSFQvI3cs+VP6vX2LqYcdAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2m1qtHRjhkSxe59DZky1wKjqq6xhA5hSskpoDywtDwIlXm0y6wwn3FKlBpqa30ZvLVlypJ2oZCuUPAk77NIfWYn401Ttz8lwg21Xcz8nTOaYzwPYSd7RDPPdafaHdVj2mgrAU6fbAplrzZKHgpozv98rJXeUltA82PpJ9kMMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJyOhibx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7496C4CEC5;
	Wed,  9 Oct 2024 11:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728474893;
	bh=6XboQiBiqtAshC35gbGlqSFQvI3cs+VP6vX2LqYcdAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJyOhibxLOBg5vY6YRhMNNS7Vtu28OgJ1B5TAucH0v5w/5hu3fZp1jx28xA7hca2S
	 nGJrPlv6cjp4/XJyPBxP/Jsf13Mp8BHfjhRo4WddQ6JxOXdzWoyn8HoqOGda9GOwBR
	 6u9y+oQ2RaqVDSlWcjh7fxhkRTK9fRCCmvIjykvMYRMBZm3gKhh7osMfu5Egb4Aeu7
	 lwg4HxAE+3CLvOFhJ7isxMt7ys0qTL12BMTse52t21quhOtTaWOLIo4FaoqvtFkKJa
	 jmGd97mlRapVEJ9T5CKQw46M4zhbErRpBEXYUHU5+4qHLasx9HT7w3O45gI0ZlP9wW
	 m43x9BcUVXqCQ==
Date: Wed, 9 Oct 2024 12:54:48 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, csokas.bence@prolan.hu,
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, linux@roeck-us.net,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
Message-ID: <20241009115448.GJ99782@kernel.org>
References: <20241008061153.1977930-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008061153.1977930-1-wei.fang@nxp.com>

On Tue, Oct 08, 2024 at 02:11:53PM +0800, Wei Fang wrote:
> Some platforms (such as i.MX25 and i.MX27) do not support PTP, so on
> these platforms fec_ptp_init() is not called and the related members
> in fep are not initialized. However, fec_ptp_save_state() is called
> unconditionally, which causes the kernel to panic. Therefore, add a
> condition so that fec_ptp_save_state() is not called if PTP is not
> supported.
> 
> Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/353e41fe-6bb4-4ee9-9980-2da2a9c1c508@roeck-us.net/
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 60fb54231ead..1b55047c0237 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1077,7 +1077,8 @@ fec_restart(struct net_device *ndev)
>  	u32 rcntl = OPT_FRAME_SIZE | 0x04;
>  	u32 ecntl = FEC_ECR_ETHEREN;
>  
> -	fec_ptp_save_state(fep);
> +	if (fep->bufdesc_ex)
> +		fec_ptp_save_state(fep);

Hi,

I am wondering if you considered adding this check to (the top of)
fec_ptp_save_state. It seems like it would both lead to a smaller
change and be less error-prone to use.

>  
>  	/* Whack a reset.  We should wait for this.
>  	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> @@ -1340,7 +1341,8 @@ fec_stop(struct net_device *ndev)
>  			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
>  	}
>  
> -	fec_ptp_save_state(fep);
> +	if (fep->bufdesc_ex)
> +		fec_ptp_save_state(fep);
>  
>  	/* Whack a reset.  We should wait for this.
>  	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
> -- 
> 2.34.1
> 
> 

