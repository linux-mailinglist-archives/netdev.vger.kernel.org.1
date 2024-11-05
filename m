Return-Path: <netdev+bounces-142047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45329BD36A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218CB1C20B3F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938D1D7E35;
	Tue,  5 Nov 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1AyA/Es"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028513D601;
	Tue,  5 Nov 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827905; cv=none; b=eyYGfalIV1v02pKUbERp9uXe+wHChtBmXwRkwNkNRj5SCuKJCUr1XjBd3DWOXYwPKr2bo4orcEcew87NVII3x80D0+A0jgsHdgtnh0ew9aDGmMT1NfxrJLSKZvIh1BH++NnFjm/nwNo+i7XiAE061vCGpGyhoi3cqQYhkWnbvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827905; c=relaxed/simple;
	bh=vRDnm4UNYqA8d9VnSmP10RmE+Z2Zrw9pRxMCm+NYbkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdsEe6WG1WoVeRB3tEs+JL4ATE+lgx6qNQasOZmLY5Rew5nMYci6JRxu1ITCPO9gm93WsIupmbE+vUWM7PYjFjB7lk8yxVmSNkoe/8Er7VWtbWs46j1D7nl9rsbusjGhb5tiXH6BbW9oyHn25wFrUlLgoabuYSySWy/UZYTcfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1AyA/Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDD8C4CECF;
	Tue,  5 Nov 2024 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827905;
	bh=vRDnm4UNYqA8d9VnSmP10RmE+Z2Zrw9pRxMCm+NYbkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k1AyA/Esh8KTH/OjDEh2OjxyBchcbRdSRVKxWD3mbmh3zESxZ75JO9DWRfMoUGaQo
	 z1LSD9vF5Aa78BwKE7JvVknfSLNHrLMKuOwe6YhdDJrjRRk61Xm+JLRc1uJk9Q/zvF
	 NWNuWY9IFqAxOF0zX4IF5/tUVqs8hWnUiuVL15UbyZpZcwFzoMPFvbVxRiQRbaNzm9
	 VFcImoGEsYLJVhgy7x60kNKdXQyKBqg1flNS/STzYbXpRc2QByWTtrOwovGMMTppP/
	 OGOLr+3YKDi5vdhfXoENtFk2GkTPBJga/8cLppWLm7Bf9eKDv6Qa5DUtD3h9ylbNAB
	 6dnEfLq6whung==
Message-ID: <79463950-3acf-45a0-a7fa-30a9c9236292@kernel.org>
Date: Tue, 5 Nov 2024 10:31:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: route: fix possible null-pointer-dereference in
 ip6_route_info_create
Content-Language: en-US
To: Yi Zou <03zouyi09.25@gmail.com>, davem@davemloft.net
Cc: 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241101035843.52230-1-03zouyi09.25@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241101035843.52230-1-03zouyi09.25@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 9:58 PM, Yi Zou wrote:
> In the ip6_route_info_create function, the variable fib6_nh is
> assigned the return value of nexthop_fib6_nh(rt->nh), which could
> result in fib6_nh being NULL. Immediately after this assignment,

not really. IPv6 can only have nexthops in the IPv6 address family, and
nexthop_mpath_select will never return NULL since `0` is always valid
index if the group exists.


> there is a potential dereference of fib6_nh in the following code:
> if (!ipv6_addr_any(&cfg->fc_prefsrc)) {
>  struct net_device *dev = fib6_nh->fib_nh_dev;
> This lead to a null pointer dereference (NPD) risk if fib6_nh is
> NULL. The issue can be resolved by adding a NULL check before the
> deference line.
> 
> Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b4251915585f..919592fa4e64 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3821,7 +3821,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>  			rt->fib6_flags = RTF_REJECT | RTF_NONEXTHOP;
>  	}
>  
> -	if (!ipv6_addr_any(&cfg->fc_prefsrc)) {
> +	if (!ipv6_addr_any(&cfg->fc_prefsrc) && fib6_nh) {
>  		struct net_device *dev = fib6_nh->fib_nh_dev;
>  
>  		if (!ipv6_chk_addr(net, &cfg->fc_prefsrc, dev, 0)) {



