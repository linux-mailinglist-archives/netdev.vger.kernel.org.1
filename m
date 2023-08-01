Return-Path: <netdev+bounces-23435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15C76BF6E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170D31C20FFF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486E26B3C;
	Tue,  1 Aug 2023 21:43:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4A26B10
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 21:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3E8C433C8;
	Tue,  1 Aug 2023 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690926228;
	bh=usnEviioqoCVwGAiv0lnOrnKLUhwR79yOmsKkexjDRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tLYQ1R+pmQrIUdQF6GQH/IE5f5FfTkkHu5OjhS6irYTgXtcK0Iva3tfsnZmdDUY63
	 kuKFqF+gpJZd55k3V3n3xMSiJSnI9sa0y6o81qt7J0d8piyOhAq5Layeclr1clUaPV
	 E2xUfDTQ/PgsI6s3yfF8fosGllXXvcRLNwrqdnWbSVuwZilfr9C1loDgIYtL633Yca
	 UsdbDOWau8Bs0xLh/VTF2Z6GKC9iZJIRZCmw9G8Hm0/yF1m1ODHm/nlBX52j9PNX/N
	 dF+0iQsfLTLeu0Kw6Zu3MX40bWTC2Yz0ORKhQ1jnoNevHFBemlHhh2r+wIKL1/7dA+
	 uyMMu5QtSYYKw==
Date: Tue, 1 Aug 2023 14:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ruan Jinjie <ruanjinjie@huawei.com>, <yisen.zhuang@huawei.com>,
 <salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] net: hisilicon: fix the return value handle and
 remove redundant netdev_err() for platform_get_irq()
Message-ID: <20230801144347.140cc06f@kernel.org>
In-Reply-To: <20230731073858.3633193-1-ruanjinjie@huawei.com>
References: <20230731073858.3633193-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 15:38:58 +0800 Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> And there is no need to call the netdev_err() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Dan, with the sample of one patch from you I just applied I induce 
that treating 0 as error and returning a -EINVAL in that case may 
be preferable here?

> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index 50c3f5d6611f..ecf92a5d56bb 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -960,8 +960,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		ret = -EINVAL;
> +	if (irq < 0) {
> +		ret = irq;
>  		goto init_fail;
>  	}
>  
> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
> index ce2571c16e43..cb7b0293fe85 100644
> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
> @@ -862,8 +862,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  		goto out_disconnect_phy;
>  
>  	ndev->irq = platform_get_irq(pdev, 0);
> -	if (ndev->irq <= 0) {
> -		ret = -ENODEV;
> +	if (ndev->irq < 0) {
> +		ret = ndev->irq;
>  		goto out_disconnect_phy;
>  	}
>  
> diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> index f867e9531117..26d22bb04b87 100644
> --- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> @@ -1206,9 +1206,8 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
>  	}
>  
>  	ndev->irq = platform_get_irq(pdev, 0);
> -	if (ndev->irq <= 0) {
> -		netdev_err(ndev, "No irq resource\n");
> -		ret = -EINVAL;
> +	if (ndev->irq < 0) {
> +		ret = ndev->irq;
>  		goto out_phy_node;
>  	}
>  


