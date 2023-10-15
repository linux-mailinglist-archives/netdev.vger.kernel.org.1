Return-Path: <netdev+bounces-41098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292FE7C9A4E
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8832828168D
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD0DF4A;
	Sun, 15 Oct 2023 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvWtzmPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEE748D
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 17:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76349C433C7;
	Sun, 15 Oct 2023 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697390835;
	bh=Ziir8oZv21k8LxZA7E5IQuBfGIU4Qqz0ukLX7oQEpHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvWtzmPA27FQpFwupPv+suEGKg2Q7uUXswAQMe1VL88h/nvpcnotxaASW+gmhvss6
	 m7IfadY+9fiFAShD9EaI/iIy1TULC6dU4cqSDF3/lPr093sCB5U8iSY5q0PQBGygUt
	 mkV0LkVXKuhuka0gWqBhjBl/tJ2n0UkFDw200ZhLVhyHh52ToR9uM/0QIcK7njbKNk
	 b4vj8GCMRG9GYw0VGAKCLt+yuS7VnNargE/iMJ5MQZtDLEGZ67VerqPIcTwp1P55lk
	 l98lDP5As0Azzqg65HyG/PlOz5s8UC9rGOHQ1zHOvk9yHpRBFq1P//qQabWBjHgRWb
	 PphbTTDMK+P/g==
Date: Sun, 15 Oct 2023 20:27:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, brouer@redhat.com,
	lorenzo@kernel.org, Paulo.DaSilva@kyberna.com,
	ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: Re: [PATCH v3 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <20231015172710.GA223096@unreal>
References: <be2yyb4ksuzj2d4yhvfzj43fswdtqmcqxv5dplmi6qy7vr4don@ksativ2xr33e>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2yyb4ksuzj2d4yhvfzj43fswdtqmcqxv5dplmi6qy7vr4don@ksativ2xr33e>

On Sun, Oct 15, 2023 at 02:37:27PM +0200, Sven Auhagen wrote:
> If the page_pool variable is null while passing it to
> the page_pool_get_stats function we receive a kernel error.
> 
> Check if the page_pool variable is at least valid.
> 
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>
> ---
>  net/core/page_pool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 2396c99bedea..4c5dca6b4a16 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -65,6 +65,9 @@ bool page_pool_get_stats(struct page_pool *pool,
>  	if (!stats)
>  		return false;
>  
> +	if (!pool)
> +		return false;
> +

I would argue that both pool and stats shouldn't be NULL and must be
checked by caller. This API call named get-stats-from-pool.

Thanks

>  	/* The caller is responsible to initialize stats. */
>  	stats->alloc_stats.fast += pool->alloc_stats.fast;
>  	stats->alloc_stats.slow += pool->alloc_stats.slow;
> -- 
> 2.42.0
> 
> 

