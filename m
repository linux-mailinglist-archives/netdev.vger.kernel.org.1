Return-Path: <netdev+bounces-121200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF295C260
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11BF1C23028
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF73AD49;
	Fri, 23 Aug 2024 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp0Ug81o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9EBA46;
	Fri, 23 Aug 2024 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372643; cv=none; b=KqKVHUhAFAXTPFVxzT+Asz2EAw0rOuBsnyWjK09gUZIKtnnlmoClTNaX9tgMe1adoAUjtR6+FwCE2DJqcDAwaJkfsCzsZv2g062gZyUQTzkA0KPJrPOeTCvB84B0Mhys9FZOU7R4YPpuqaecMM2NiCPijIVnyv699lNEyRSe1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372643; c=relaxed/simple;
	bh=Lfa+jEqCITXRWgdOmQ2JKwJx+fGjGw9EOWy2Nx4XtAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qww9r8vFr1KuMqgeYcYtANcGnjxhJafSn4q4mxaHEk+VMTXKKsXbLR4B6nm3kZVAzBMgKYkjLofti1En7jvk6AmiolC2FlwZx5KInOPCSYY7hbIsfZN0Ptc7+XacC+POgW1ilEfC4XUboUdaVzQDdI+1i+zd5Q0N/lTbKpLGsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp0Ug81o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EB7C32782;
	Fri, 23 Aug 2024 00:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724372642;
	bh=Lfa+jEqCITXRWgdOmQ2JKwJx+fGjGw9EOWy2Nx4XtAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mp0Ug81olGx7mmEtbFl9yK+S1CFx5NRHHTFNy0ZYG7SgpUN2boOQS3kR9XujUbTMF
	 dAProY9V/ZsjM4qYW8HngPrxInFmiQpvR+gmrYRwRsV3+TC7+mGQcbZizR6pQUHC08
	 aHt4ANmEbGdylCT/u3gwYLMTjXas7TOz7MYa/6Rr53BWM8Xsqc8LIQMKx5F1ja0EED
	 pb+vBezbOhBAgy3RIq//Wj93VWLaZvjcMrWV9Jvq1lA4JactWrue4RJIrSNM3v97t7
	 Gp4BvveeARn+Tlqo67B1mhP3+tgD2rzIFX5wQz6GuPnYvG5BPSFa86s5JdsMwCyCOZ
	 URDGbm1eUEQAQ==
Date: Thu, 22 Aug 2024 17:24:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: ftgmac100: Get link speed and duplex for NC-SI
Message-ID: <20240822172401.43fe8dd2@kernel.org>
In-Reply-To: <20240822031945.3102130-1-jacky_chou@aspeedtech.com>
References: <20240822031945.3102130-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 11:19:45 +0800 Jacky Chou wrote:
> The ethtool of this driver uses the phy API of ethtool
> to get the link information from PHY driver.
> Because the NC-SI is forced on 100Mbps and full duplex,
> the driver connects a fixed-link phy driver for NC-SI.

replace: the driver connects -> connect

> The ethtool will get the link information from the
> fixed-link phy driver.

Hm. I defer to the PHY experts on the merits.

> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> v2:
>   - use static for struct fixed_phy_status ncsi_phy_status
>   - Stop phy device at net_device stop when using NC-SI.
>   - Start phy device at net_device start when using NC-SI.
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index fddfd1dd5070..93862b027be0 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -26,6 +26,7 @@
>  #include <linux/of_net.h>
>  #include <net/ip.h>
>  #include <net/ncsi.h>
> +#include <linux/phy_fixed.h>

Keep the headers sorted, put the new one after of_net.h

>  #include "ftgmac100.h"
>  

> @@ -1794,6 +1805,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  	struct net_device *netdev;
>  	struct ftgmac100 *priv;
>  	struct device_node *np;
> +	struct phy_device *phydev;

keep the variable declarations sorted longest to shortest if possible

>  	int err = 0;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1879,6 +1891,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  			err = -EINVAL;
>  			goto err_phy_connect;
>  		}
> +
> +		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
> +		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> +					 PHY_INTERFACE_MODE_MII);
> +		if (err) {
> +			dev_err(&pdev->dev, "Connecting PHY failed\n");
> +			goto err_phy_connect;
> +		}

Very suspicious that you register it but you never unregister it.
Are you sure the error path and .remove don't need to be changed?
-- 
pw-bot: cr

