Return-Path: <netdev+bounces-48884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F57EFEC9
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98201C20492
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B581107A4;
	Sat, 18 Nov 2023 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF19h/d6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D08D2FE
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 10:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BF0C433C8;
	Sat, 18 Nov 2023 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700301615;
	bh=L9M95Ltso1jBAgMC7hvWwPmZwod9YKS9n4i4gz3W6hU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dF19h/d66TMUwHhKeq9ZrJ6O320womNNbzpupX6gVnn2zyl/pCxr6NWOJLoAKTBgf
	 jZGL9d04DFJPb8emniIm9orLwOvP73xbcOnoMTjyOE5CAcSAKYsHW0fohhvoC7MU7u
	 1oY028rIhTLv03TxlUDxu2tAqeAAFbdqI2uDnKAAj5aiov7HbrWHerSYGICG8kXKw7
	 QGSaXATewwtG1Dxzbt9r9LbeWsjB58eT8qBPQZMmN1MP3Zrx4gD2GH2ZOycS6mhFNO
	 pkiUkfE2lXeCzBW/gEfwVAXY0CnwlN/QXZQ+BWufH0WEKZSLxB6F9lwSwsHl0IVSi4
	 DMhwBbVu6gsgw==
Message-ID: <4cabffc1-7ff9-4277-b508-5902f42b47cb@kernel.org>
Date: Sat, 18 Nov 2023 12:00:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] net: ethernet: ti: cpsw: Don't error out in .remove()
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, Stanislav Fomichev <sdf@google.com>,
 Marek Majtyka <alardam@gmail.com>, Rob Herring <robh@kernel.org>,
 Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org,
 netdev@vger.kernel.org, kernel@pengutronix.de
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
 <20231117091655.872426-3-u.kleine-koenig@pengutronix.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231117091655.872426-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/11/2023 11:16, Uwe Kleine-König wrote:
> Returning early from .remove() with an error code still results in the
> driver unbinding the device. So the driver core ignores the returned error
> code and the resources that were not freed are never catched up. In
> combination with devm this also often results in use-after-free bugs.
> 
> If runtime resume fails, it's still important to free all resources, so
> don't return with an error code, but emit an error message and continue
> freeing acquired stuff.
> 
> This prepares changing cpsw_remove() to return void.
> 
> Fixes: 8a0b6dc958fd ("drivers: net: cpsw: fix wrong regs access in cpsw_remove")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index ca4d4548f85e..db5a2ba8a6d4 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1727,16 +1727,24 @@ static int cpsw_remove(struct platform_device *pdev)
>  	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
>  	int i, ret;
>  
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	ret = pm_runtime_get_sync(&pdev->dev);
>  	if (ret < 0)
> -		return ret;
> +		/* There is no need to do something about that. The important
> +		 * thing is to not exit early, but do all cleanup that doesn't
> +		 * require register access.
> +		 */
> +		dev_err(&pdev->dev, "runtime resume failed (%pe)\n",
> +			ERR_PTR(ret));
>  
>  	for (i = 0; i < cpsw->data.slaves; i++)
>  		if (cpsw->slaves[i].ndev)
>  			unregister_netdev(cpsw->slaves[i].ndev);
>  
> -	cpts_release(cpsw->cpts);
> -	cpdma_ctlr_destroy(cpsw->dma);
> +	if (ret >= 0) {
> +		cpts_release(cpsw->cpts);

cpts_release() only does clk_unprepare().
Why not do that in the error path as well?

> +		cpdma_ctlr_destroy(cpsw->dma);

cpdma_ctrl_destroy() not only stops the DMA controller
but also frees up the channel and calls dma_free_coherent?

We still want to free up the channel and dma_free_coherent in the
error path?

> +	}
> +
>  	cpsw_remove_dt(pdev);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);

-- 
cheers,
-roger

