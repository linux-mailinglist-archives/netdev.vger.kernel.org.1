Return-Path: <netdev+bounces-47135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340277E82E8
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0231D1C209A3
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585703A29C;
	Fri, 10 Nov 2023 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3I8vKDi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC63A262
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C95C433C8;
	Fri, 10 Nov 2023 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699645451;
	bh=gMTNMcFdUq6GUBvKFbLUH+ZN2QErP8+dG8hYixvB3TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3I8vKDiIJbvJIlfTxeM04d6iidiBy5EncXrF1n5tTzEf70QY2Mg6nol/AzqQIPCs
	 XhKpKpuC15SU0q44aaz/keJvpj4yO+s7wburNS1Xk0IWYFMQiE5QcXGRvSVNpDQ/8O
	 OGD1qaqKNZnjwdca6yFY3rE44LR1CrzuqLcROCO1Rjb53jmjgWowfTbyhFy1y9sIDQ
	 VAZ/nwzggdy6J1n5dJax4v7zbTiBV2Oz+VxsMC64+6JE9g7UIhRDE3UwcN7ZJf0RcB
	 yPWG1rznN3awtPrArA3r/gdm5FNalYwN6rv4bfjoThxcRppUN76b7pieDExFQimcaD
	 0W6J0IlSLHW5g==
Date: Fri, 10 Nov 2023 11:44:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Dae R. Jeong" <threeearcat@gmail.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: [PATCH] tls: fix missing memory barrier in tls_init
Message-ID: <20231110114410.01cd3eb3@kernel.org>
In-Reply-To: <ZU4Mk_RfzvRpwkmX@dragonet>
References: <ZU4Mk_RfzvRpwkmX@dragonet>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 19:57:23 +0900 Dae R. Jeong wrote:
> +	mutex_init(&ctx->tx_lock);
> +	ctx->sk_proto = READ_ONCE(sk->sk_prot);
> +	ctx->sk = sk;
>  	ctx->tx_conf = TLS_BASE;
>  	ctx->rx_conf = TLS_BASE;

TLS_BASE is 0, so there's no strong reason to move the rcu assign
after *x_conf init. It's already 0. You can replace the assignment
with WARN_ON(ctx->tx_conf != TLS_BASE) to make sure, and move that 
into tls_ctx_create() instead of removing that function.

FWIW make sure you read this before posting v2:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

