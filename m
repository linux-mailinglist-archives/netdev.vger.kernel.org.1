Return-Path: <netdev+bounces-56201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA1980E289
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9401C21414
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B0525F;
	Tue, 12 Dec 2023 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGGI4j1K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D866103
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5684CC433C8;
	Tue, 12 Dec 2023 03:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702350889;
	bh=STg08q9IfAR0tNeI5v/tHfkB1R036nNdGe+t8ciundo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mGGI4j1KtWPXG5XGxthX++rr+bHOo5M5KapVd0sqkY+j1yldnfhLfC4aaACy1aWI2
	 ud0jdHjYUeKrctIRwt2fGHY9fRzK5bwfSYJ1KmR9YncddGbA++5VzbVI2pvgtJqbAh
	 yYw+fBJxNluQopj+4tE4bB2UFGzhvbfup8GwOhnz9qe/gfII8lLoJobSRIyKsnzAif
	 49FFgsq4s72rZtT3vv0H+HOlgZH0Y7Sbmx9caRGP3B5Px3bbJEqSUbHf0swUY/tPJq
	 kMmhT82qgp3Bm5cewmGktHqixr54eFUb27YsauJjURm38BnJUVlEUlaAqoWBTvuQSj
	 JqU+tbzbPG3/Q==
Date: Mon, 11 Dec 2023 19:14:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Chris Snook <chris.snook@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Yuanjun Gong
 <ruc_gongyuanjun@163.com>, Jie Yang <jie.yang@atheros.com>, Jeff Garzik
 <jgarzik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
Message-ID: <20231211191447.0408689d@kernel.org>
In-Reply-To: <20231208082316.3384650-1-alexious@zju.edu.cn>
References: <20231208082316.3384650-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 16:23:14 +0800 Zhipeng Lu wrote:
> v2: Setting tx_ring->tx_buffer to NULL after free.

Having closer look at this driver  - it tries to free both on close and
remove, so seems like we do indeed have to NULL-out the pointer, sigh.

> diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> index 5935be190b9e..1bffe77439ac 100644
> --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> @@ -866,6 +866,8 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
>  		netdev_err(adapter->netdev, "offset(%d) > ring size(%d) !!\n",
>  			   offset, adapter->ring_size);
>  		err = -1;
> +		kfree(tx_ring->tx_buffer);
> +		tx_ring->tx_buffer = NULL;
>  		goto failed;

Please add a new jump target, tho, and move the freeing there.
There's a small chance someone will add more code to this function
and it will need to copy / paste this unwind.
-- 
pw-bot: cr

