Return-Path: <netdev+bounces-28327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B773D77F119
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3821281CEB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE01FD2;
	Thu, 17 Aug 2023 07:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B061C2F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2426FC433C7;
	Thu, 17 Aug 2023 07:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692256767;
	bh=5AF+khJ/zO9MH/Zd0dHfg08/t7h8ETv+nNrgkrDMhXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW8Ey1/jojir8VRvWZm/aj9UPZ9yigPLejXepqYwikFpuM1PMMBPlvxx7x0KNHLFD
	 NUb6jDE52lRe1hEqmOwG052FdjAmvzm6ozOo9EkTXph4SOlulrdN78fbqrQ9eGJEiJ
	 12PFRvEmpQgUFuq9BBc2TWPrAdtwi3o8AY1xGs8csYfAF9BoBfYTa8HHzGi7Kwc+aN
	 A6NLYyNjXheVzWEHjwXWHSySklbZ7buBGLgx5ySjtm/CtSzmEnGutW9++DYRyoHqmE
	 77XlE0ZuLqRtai6hqz1g9hJzXDRNe50ESRT4YpE4ZvGjuEmZOK5SQDzIaflcG4gNzo
	 vmzpR37IqQ0Fg==
Date: Thu, 17 Aug 2023 10:19:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH -next] net: broadcom: Use helper function IS_ERR_OR_NULL()
Message-ID: <20230817071923.GB22185@unreal>
References: <20230816095357.2896080-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816095357.2896080-1-ruanjinjie@huawei.com>

On Wed, Aug 16, 2023 at 05:53:56PM +0800, Ruan Jinjie wrote:
> Use IS_ERR_OR_NULL() instead of open-coding it
> to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/bgmac.c        | 2 +-
>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 10c7c232cc4e..4cd7c6abb548 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
>  	int err;
>  
>  	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);

When can fixed_phy_register() return NULL?
It looks like it returns or valid phy_dev or ERR_PTR().

Thanks


> -	if (!phy_dev || IS_ERR(phy_dev)) {
> +	if (IS_ERR_OR_NULL(phy_dev)) {
>  		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
>  		return -ENODEV;
>  	}
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index 0092e46c46f8..aa9a436fb3ce 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -617,7 +617,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>  		};
>  
>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> -		if (!phydev || IS_ERR(phydev)) {
> +		if (IS_ERR_OR_NULL(phydev)) {
>  			dev_err(kdev, "failed to register fixed PHY device\n");
>  			return -ENODEV;
>  		}
> -- 
> 2.34.1
> 
> 

