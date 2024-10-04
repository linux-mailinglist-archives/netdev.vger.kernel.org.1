Return-Path: <netdev+bounces-132166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52359909D3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988501C214F8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A31CACD5;
	Fri,  4 Oct 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOk4sgTd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E01E378C;
	Fri,  4 Oct 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061293; cv=none; b=VSi51hI5+yaP6nDzgAg0cNbcQoCZBcQxHt3H1fJSnw84qAt6fJ9hLtHIuPem3QSrglU78cwaEcWxLWgRsm+oUkJD/RXfMpTrLusSTO5GXSSbTU+c+i38TvxrlVqK5yynMQWCHZvH0TwoFRSrJts0XVlF+4xEuRYOVGLzLUcEPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061293; c=relaxed/simple;
	bh=rdXVs0WNSDVjMRsC0dS9JWOvTq2XiJ7Xa8h/W4iiRVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpCHzK3C9b/b68RucS7pKADkBXcRoqxk0zj00sq5GRrae3swz6joWCur1CYfKFs1whKy5xsYoZTkjgs537ENFEm3IfY7w8udrLR1+/pLp+cygSNgiAP56zKcxgvZo20uQJwaP1+R2rIT8sKG0lFHYmC2rlajTE/QDBOKOdF5JEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOk4sgTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E227C4CEC6;
	Fri,  4 Oct 2024 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728061290;
	bh=rdXVs0WNSDVjMRsC0dS9JWOvTq2XiJ7Xa8h/W4iiRVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cOk4sgTdK5ePHNbIdwTbx8+lW5WKddZpwMMxA2P7jlIwrPzEvPLZAw9bZlbsZgvNe
	 aIoLLNcvoCZpHx3pOztC0IH92bfEVokyoMSgI7G7EbTb31vN24wcLaHykFM86T5u6+
	 AJaQrCLo9chk6O439SAMtoFw26TNcjCs3O8NKalCau94NasjmYlUxtwVE+hMYJIRr2
	 Wb7ZhEJZE04kZDgpZAgKfdLkCvn49MC38INoYpAyOZczGFcyRVuNs9rqhDcG8y5BeD
	 7YofoTVXspUrd9sNScOoYyaWgQzGLKnmYMAGKhO7z74ec7h+P04eGvF7UyhHP+9nIx
	 uu7KCJqlC6T7Q==
Message-ID: <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>
Date: Fri, 4 Oct 2024 11:01:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: rmikey@meta.com, kernel-team@meta.com, horms@kernel.org,
 "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241004162720.66649-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241004162720.66649-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 10:27 AM, Breno Leitao wrote:
> Branch annotation traces from approximately 200 IPv6-enabled hosts
> revealed that the 'likely' branch in ip_neigh_for_gw() was consistently
> mispredicted. Given the increasing prevalence of IPv6 in modern networks,
> this commit adjusts the function to favor the IPv6 path.
> 
> Swap the order of the conditional statements and move the 'likely'
> annotation to the IPv6 case. This change aims to improve performance in
> IPv6-dominant environments by reducing branch mispredictions.
> 
> This optimization aligns with the trend of IPv6 becoming the default IP
> version in many deployments, and should benefit modern network
> configurations.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/route.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index 1789f1e6640b..b90b7b1effb8 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_for_gw(struct rtable *rt,
>  	struct net_device *dev = rt->dst.dev;
>  	struct neighbour *neigh;
>  
> -	if (likely(rt->rt_gw_family == AF_INET)) {
> -		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> -	} else if (rt->rt_gw_family == AF_INET6) {
> +	if (likely(rt->rt_gw_family == AF_INET6)) {
>  		neigh = ip_neigh_gw6(dev, &rt->rt_gw6);
>  		*is_v6gw = true;
> +	} else if (rt->rt_gw_family == AF_INET) {
> +		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
>  	} else {
>  		neigh = ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
>  	}

This is an IPv4 function allowing support for IPv6 addresses as a
nexthop. It is appropriate for IPv4 family checks to be first.

