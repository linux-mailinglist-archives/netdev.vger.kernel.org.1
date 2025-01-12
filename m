Return-Path: <netdev+bounces-157526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB7A0A92D
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A556B188770C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D51B2192;
	Sun, 12 Jan 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XOzJkVkQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4A1B218F
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685392; cv=none; b=firTG81y4NmkccUsljCIex82IH/49GjoJG9cSPKTAAJ8PooEHe4p24GXvx55KhOj3BZXxhTmkk/OIaFJjV1+tJEMFYQe9TkucTSVSPaE7i5+QogOFWwMki3qiobbzzl89d7VsWESvJPqy9MUJlC0YtNJNo5LRQF8wRab5tkjyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685392; c=relaxed/simple;
	bh=qLkmNYgljz+xhBGJQQjwx1zz8tTu5vdJgF3nauNQyKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTUU3AGKnYR405XDtjysOCSlHnMu9UC5vsvQ7aiASr9tMqmaMIvc6YwHUaZq2DzyyxhrlxIkUDF/HkTX+LpqM0iZYced2LibrX//CF2Mq6yj1nHw04hJorbW5YTwAgvbxoohSVoreEkeYEzjrS2wjWRKy0IOdW+D7wEQZvOcXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XOzJkVkQ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac947d88-750e-4058-aa3e-b539a09b89d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736685386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16i8/HmQrvop6Wq90czxPGnG6F8sVpZRlEdmEypLhGg=;
	b=XOzJkVkQ3/t6r0eAnc340BPC0gjMQa4eBTcCWyH8oWtCQ9H2vQXZNjYlnUcN2zqXW2jUy6
	9gHXwt9PRG05mv3Ho85bgnhhzaMCTLGf/pHyTsgp29lIqr+qupcNfngaijyVQpxGHRpCOJ
	F8tlJzh2UtZzKfU+iLqQ8R7FIFsS0Ps=
Date: Sun, 12 Jan 2025 20:35:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "'David S . Miller'" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109155842.60798-1-rgallaispou@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250109155842.60798-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 1/9/25 23:58, Raphael Gallais-Pou 写道:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

LGTM!


Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
> Changes in v2:
>    - Split serie in single patches
>    - Remove irrelevant 'Link:' from commit log
>    - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-5-c7d4c4856336@gmail.com
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
> index eabc4da9e1a9..de9b6dfef15b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
> @@ -313,7 +313,6 @@ static void sti_dwmac_remove(struct platform_device *pdev)
>   	clk_disable_unprepare(dwmac->clk);
>   }
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int sti_dwmac_suspend(struct device *dev)
>   {
>   	struct sti_dwmac *dwmac = get_stmmac_bsp_priv(dev);
> @@ -333,10 +332,9 @@ static int sti_dwmac_resume(struct device *dev)
>   
>   	return stmmac_resume(dev);
>   }
> -#endif /* CONFIG_PM_SLEEP */
>   
> -static SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
> -					   sti_dwmac_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
> +						  sti_dwmac_resume);
>   
>   static const struct sti_dwmac_of_data stih4xx_dwmac_data = {
>   	.fix_retime_src = stih4xx_fix_retime_src,
> @@ -353,7 +351,7 @@ static struct platform_driver sti_dwmac_driver = {
>   	.remove = sti_dwmac_remove,
>   	.driver = {
>   		.name           = "sti-dwmac",
> -		.pm		= &sti_dwmac_pm_ops,
> +		.pm		= pm_sleep_ptr(&sti_dwmac_pm_ops),
>   		.of_match_table = sti_dwmac_match,
>   	},
>   };

