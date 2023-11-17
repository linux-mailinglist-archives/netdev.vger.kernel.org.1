Return-Path: <netdev+bounces-48607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F77EEF42
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715D71F26518
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA6171B1;
	Fri, 17 Nov 2023 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI4q2I7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBD171A5
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15245C433C7;
	Fri, 17 Nov 2023 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700214721;
	bh=5HsDJUIpq+WzQyoTIrlE2LCZwPI5r2SD0ENhnQYLf1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VI4q2I7EkqkFG6srWleLxAYUsWZgEVJLttuy3A0pOI2L1sYGJhbWk0hxY+apO057T
	 dcm56loYfQEy+G4pa12a4kv/3IuXnCEV/YXXAcNBoG+xScoJduED0hv1jd9s7XESmo
	 KvB9Uj28b6caL4UP7lPC2JuHnueRBLTlwJUuZZ8W7RvA0R0RIJW9l3/oaxDA9TYPVZ
	 7JkRJVhwKkxehp5h7QaPet4RrIwFjFpTVmQHOOtG4vRCwMqCtA0eMO3DsYNqbHHhX9
	 Q/tm78NUfm/hWEx4yX3ENGXr7XFIFD88yNnm3w8DOMcLk9Blzmz9fWAaBHHfrNNYt9
	 I9Q4s6ct/jBAg==
Message-ID: <e8cf4f85-b05a-4a7a-ae13-406792be1bbe@kernel.org>
Date: Fri, 17 Nov 2023 11:51:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] net: ethernet: ti: am65-cpsw: Don't error out in
 .remove()
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
 kernel@pengutronix.de
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
 <20231117091655.872426-2-u.kleine-koenig@pengutronix.de>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231117091655.872426-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/11/2023 11:16, Uwe Kleine-König wrote:
> Returning early from .remove() with an error code still results in the
> driver unbinding the device. So the driver core ignores the returned error
> code and the resources that were not freed are never catched up. In
> combination with devm this also often results in use-after-free bugs.
> 
> In case of the am65-cpsw-nuss driver there is an error path, but it's never
> taken because am65_cpts_resume() never fails (which however might be
> another problem). Still make this explicit and drop the early return in
> exchange for an error message (that is more useful than the error the
> driver core emits when .remove() returns non-zero).
> 
> This prepares changing am65_cpsw_nuss_remove() to return void.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index ece9f8df98ae..960cb3fa0754 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -3007,9 +3007,12 @@ static int am65_cpsw_nuss_remove(struct platform_device *pdev)
>  
>  	common = dev_get_drvdata(dev);
>  
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	ret = pm_runtime_get_sync(&pdev->dev);

Unrelated to this patch but I see pm_runtime_resume_and_get()
used at multiple places in this driver.

Would it be wise to replace them all with pm_runtime_get_sync()?

>  	if (ret < 0)
> -		return ret;
> +		/* am65_cpts_resume() doesn't fail, so handling ret < 0 is only
> +		 * for the sake of completeness.
> +		 */
> +		dev_err(dev, "runtime resume failed (%pe)\n", ERR_PTR(ret));
>  
>  	am65_cpsw_unregister_devlink(common);
>  	am65_cpsw_unregister_notifiers(common);

-- 
cheers,
-roger

