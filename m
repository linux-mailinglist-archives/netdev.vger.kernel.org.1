Return-Path: <netdev+bounces-47147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354127E83DF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42D12812DC
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16F3A29B;
	Fri, 10 Nov 2023 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZQLkTFJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD02CCDC
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C3C433C7;
	Fri, 10 Nov 2023 20:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699648578;
	bh=VLDqEhF4Fe1yrPqGsr+lxYxq7cKSlCZUOd4uw2dlNJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GZQLkTFJpSlCrTr63ZbeoUwgSC0M6pkX3gY2CbzbgBHeEL5ZLIsbhljz/3rTtYcl4
	 8C7pibEIeaG31xqDOpLHGPGcINrTNWc/lZckwC787p/kGxeSOuf1f591HnILbu6YJ0
	 y7lZPR4/mXWJkNa67lPanXsFiZDPlATB1vGNwXELk2PbNfGazlaKFYfE1JMMIc93t1
	 5vgCIDtTwbKb7VYTdP8P5OyveHQtowgi0wIxG8lHMMJU2ISMP3n4frs1xpJqmt6b9m
	 LqO+ogVQRuesM8e9HVrAClS0WWHw6MdbwjIyACDxDaIEudet+SSZodnPnpyrRahLYy
	 WDGOeLbokVtAQ==
Date: Fri, 10 Nov 2023 12:36:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH net] gve: Fixes for napi_poll when budget is 0
Message-ID: <20231110123616.06997341@kernel.org>
In-Reply-To: <20231109235916.1105860-1-ziweixiao@google.com>
References: <20231109235916.1105860-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Nov 2023 15:59:16 -0800 Ziwei Xiao wrote:
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")

You need to CC everyone who put their tag on that patch. Use:

./scripts/get_maintainer.pl --git-min-percent 25 0001-your.patch

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 276f996f95dc..5a84ccfd3423 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -254,16 +254,16 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
>  	if (block->tx) {
>  		if (block->tx->q_num < priv->tx_cfg.num_queues)
>  			reschedule |= gve_tx_poll(block, budget);
> -		else
> +		else if (budget)

So here you use it as a bool

>  			reschedule |= gve_xdp_poll(block, budget);
>  	}
>  
> -	if (block->rx) {
> +	if (block->rx && budget > 0) {

here as a signed int

>  		work_done = gve_rx_poll(block, budget);
>  		reschedule |= work_done == budget;
>  	}
>  
> -	if (reschedule)
> +	if (reschedule || budget == 0)

and here you compare to 0

Why is every single condition different :S

Just add a new if, before the block->rx handling which does:

	if (!budget)
		return 0;
-- 
pw-bot: cr
pv-bot: cc

