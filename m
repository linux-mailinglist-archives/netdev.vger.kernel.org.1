Return-Path: <netdev+bounces-23567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD076C85D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ED01C2125E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5F1871;
	Wed,  2 Aug 2023 08:32:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE3567F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74AEC433C7;
	Wed,  2 Aug 2023 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690965136;
	bh=czZ2Jc5IGhvkgvIQn6V7t/Feg0h0UdSM4eZ0f1JTcnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPOGp9MtNap4YcFdZBKuDfs18WJSXe2VqbsCRlmZQRFzKkkoCSqz5T1rcb6YteXxs
	 yu7BQeqlsVOupxuQrdBC0sayOjvxFjETixkodAWsfzlN6I2lCFfOvUywrZRvX0jeVx
	 b61/dtOSGK049bG4HPj+GyzLABkXFoucRdZ0G7mXLbC8RD1SNeaN1WVl8k/lA7wYnI
	 diP1+Kg6h2FyuzwNfsKXyDHQs0UXC0r2oN4marHJJmWu/r7jKTIhg1ZOGbMkJJrr5B
	 S3f7osH02NjfM8uhnv8xPkoAicrhSmwuCLd09/c/G3yreZS/EDJf2Jfgt3kmBlrFuO
	 4ErOQB11+gD4Q==
Date: Wed, 2 Aug 2023 10:32:12 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wei.fang@nxp.com, robh@kernel.org,
	bhupesh.sharma@linaro.org, arnd@arndb.de, netdev@vger.kernel.org,
	Alex Elder <elder@linaro.org>
Subject: Re: [PATCH net-next] cirrus: cs89x0: fix the return value handle and
 remove redundant dev_warn() for platform_get_irq()
Message-ID: <ZMoUjMGxhUZ9v2pT@kernel.org>
References: <20230801133121.416319-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801133121.416319-1-ruanjinjie@huawei.com>

+ Alex Elder

On Tue, Aug 01, 2023 at 09:31:21PM +0800, Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> And there is no need to call the dev_warn() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/cirrus/cs89x0.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
> index 7c51fd9fc9be..d323c5c23521 100644
> --- a/drivers/net/ethernet/cirrus/cs89x0.c
> +++ b/drivers/net/ethernet/cirrus/cs89x0.c
> @@ -1854,9 +1854,8 @@ static int __init cs89x0_platform_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	dev->irq = platform_get_irq(pdev, 0);
> -	if (dev->irq <= 0) {
> -		dev_warn(&dev->dev, "interrupt resource missing\n");
> -		err = -ENXIO;
> +	if (dev->irq < 0) {
> +		err = dev->irq;
>  		goto free;
>  	}
>  
> -- 
> 2.34.1
> 
> 

