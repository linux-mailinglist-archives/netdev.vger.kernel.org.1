Return-Path: <netdev+bounces-139327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6152F9B182B
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8497282DB9
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724581D5178;
	Sat, 26 Oct 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvMdppCQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8338DD3;
	Sat, 26 Oct 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729946609; cv=none; b=t18D0cXO+jCIV4sES+yLbpoLYTnfagM/R4qgq7F5gpAAJsh35vEHx07tLhb/aHqys04faSjqTAqvxXAAahk8oDAioT9c5MC1bmab7re2FeYAo9lp1+AXOJCvd3tM0eoM9vCtH0KMNXFfURz7+Qu+xHmuTJuKEbYuKVTEDEej+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729946609; c=relaxed/simple;
	bh=AA+ZyvaduaES7kbYYENkucmRIN9PvxOGb9wVrFewfrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kul3tVO1LeFdc/R1LZd3Bc6YtoxRfX54bYn61ZQfiW25FAI9/SZjfyuAhT0ZwrWQnCGGNsDVtv/AZJBPmB1x19yO3p/23JITICYTjduFW32qmwrqEWUH//c3nc8NaJvy/5+b5rwUkcPifdSRST0FdMkTntiK/i8CRfXH+ax823k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvMdppCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D20C4CEC6;
	Sat, 26 Oct 2024 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729946607;
	bh=AA+ZyvaduaES7kbYYENkucmRIN9PvxOGb9wVrFewfrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvMdppCQ0SiUXA3BlPhVjCSWtNU5jQ6EsOb0+AQnLRA141tW4v+wYz1Z4IqXGDunW
	 o/zXW/roEegF7Nkh5Al+/VU2B580uAY5hpMlkktoDHEspNoOfsxCW7QMSm/SvnYKzR
	 jp5PyVJ96bg55a+nbAiad+v0ufcfGbJf7HC6e1WTPfTn10oQBNN4R4X8he6qQ2qqSn
	 LzUqtWZpLSPRJ1rTe/BUTtySxK1mEfUL3q1GcCYz2Lwil9Vn4Omzag7WwCvWpSh6me
	 ZSSxUiLh0ZJYzPUeGHufrLfsKq0CWHr0mZY2bcQ3DRpL4mCmV474Uy/EF/4QZOXcaq
	 /+aLtK0TiQ0rw==
Date: Sat, 26 Oct 2024 13:43:22 +0100
From: Simon Horman <horms@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jpanis@baylibre.com, dan.carpenter@linaro.org,
	grygorii.strashko@ti.com, u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: fix NULL deref check in
 am65_cpsw_nuss_probe
Message-ID: <20241026124322.GC1507976@kernel.org>
References: <20241025091139.230117-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025091139.230117-1-hanchunchao@inspur.com>

On Fri, Oct 25, 2024 at 05:11:39PM +0800, Charles Han wrote:
> In am65_cpsw_nuss_probe() devm_kzalloc() may return NULL but this
> returned value is not checked.
> 
> Fixes: 1af3cb3702d0 ("net: ethernet: ti: am65-cpsw: Fix hardware switch mode on suspend/resume")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Hi Charles,

As this is a fix for Networking code it should be explicitly targeted
at the net tree like this:

	Subject: [PATCH net v2] ...

> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 6201a09fa5f0..7af7542093e8 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -3528,6 +3528,9 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
>  	common->ale_context = devm_kzalloc(dev,
>  					   ale_entries * ALE_ENTRY_WORDS * sizeof(u32),
>  					   GFP_KERNEL);
> +	if (!common->ale_context)
> +		return -ENOMEM;
> +

While I agree this error should be checked, I don't think this error
handling is correct and will lead to leaked resources. Looking
over this function I think you want (completely untested!):

	if (!common->ale_context) {
		ret = -ENOMEM;
		goto err_of_clear;
	}

>  	ret = am65_cpsw_init_cpts(common);
>  	if (ret)
>  		goto err_of_clear;

-- 
pw-bot: changes-requested

