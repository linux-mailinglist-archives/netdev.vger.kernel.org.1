Return-Path: <netdev+bounces-18359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC5756974
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E9B2811B7
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4615D0;
	Mon, 17 Jul 2023 16:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE710E7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07409C433C7;
	Mon, 17 Jul 2023 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689612325;
	bh=Zf6HAodqfvOy5NeB0E135FndXum0nuUy4LaelbxaSco=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZJs9BJRZgMLn/bKcVsXUHNgoFejVMHGsJ2nmKk6Aeeq3QSDGYzz3DB3+W8A4ElJR3
	 H285vW+0uWqgRz0C2srOL8Yb8XeFv8qq0JDvHEiAE7AZQFl4hlT35ehgXlfhnZk3cJ
	 nPS+s8sZ1UFqWziRNjddu5Vg8eZcQGcMxm8vzDEmwKc7Bq4V6nGcDvhHbgkTGUwUMO
	 cK5ljxPpNNN6CoXe6ywN/qZJ2uqKf93JyRRnq4A3GBPtY2+/zvWd/qOia2D+IZNwVd
	 OT44XAGEmyCzGwIlLj20+Sj+2Fjru48ovfocRjiz+DqY4ks5UOIK2Qq6Kg3H+g9n3l
	 pY8DQWGigyH/A==
Message-ID: <2aa88ea3-2bfd-ad9d-9f89-9878bd00c7f0@kernel.org>
Date: Mon, 17 Jul 2023 10:45:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] net:ipv6: check return value of pskb_trim()
Content-Language: en-US
To: Yuanjun Gong <ruc_gongyuanjun@163.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
References: <20230717144519.21740-1-ruc_gongyuanjun@163.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230717144519.21740-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/23 8:45 AM, Yuanjun Gong wrote:
> goto tx_err if an unexpected result is returned by pskb_tirm()
> in ip6erspan_tunnel_xmit().
> 
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index da80974ad23a..070d87abf7c0 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -955,7 +955,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
>  		goto tx_err;
>  
>  	if (skb->len > dev->mtu + dev->hard_header_len) {
> -		pskb_trim(skb, dev->mtu + dev->hard_header_len);
> +		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
> +			goto tx_err;
>  		truncate = true;
>  	}
>  

Reviewed-by: David Ahern <dsahern@kernel.org>


