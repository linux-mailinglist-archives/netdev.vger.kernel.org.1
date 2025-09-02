Return-Path: <netdev+bounces-218975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A985B3F263
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438407AA088
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D52773C7;
	Tue,  2 Sep 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMx7b5QE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33A25394A;
	Tue,  2 Sep 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780616; cv=none; b=BdnRQY6z8HKadTERIdYVXwSX8NCMkRnjJF7YVglTSoDOXtWgup+JoaKwiWBRKFiRc3waopR79a4wP+XvPhr+MeHy472K+JI8KacudpmQZk4Bbq61AGiEbKZ8X2KtUDRPsLqIE5WGcgskQU4NJd0R4uU4BmOqYUcLhXk3wSriqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780616; c=relaxed/simple;
	bh=UD2z+87a80B9NL1fpLKZFmCJzZaPLyDEvwYLu6j0z3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCSshAuQ1T4EXeLEJY2iS5DPgF+u86Y2KlCENet3c8H2cAARtFOMQZEvyv4SpPdE0C+MZuk03Lh/Ve0ahwcsnBCYeAzQI0dKH2dStKYDiuc2dvxhcUSPpQ1l8JFXNZfT19JwUcc0T9VQjt6dzOpIMvWyqzS6jIRdMaR3Zpr7tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMx7b5QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD52C4CEF0;
	Tue,  2 Sep 2025 02:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780616;
	bh=UD2z+87a80B9NL1fpLKZFmCJzZaPLyDEvwYLu6j0z3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IMx7b5QEYDOal91YMWm+ONEAtLcii5EeDwGzsPpZOeXN2W4z8EHvW1nEXbhgV7ut6
	 DGHz69AUdaiMU0X9fGLWh7CugPD0qSgVZBmpovadoCBbyT+dieeCmBZo7kB9MvySh7
	 c91XvIodRGcuxtIJH0UZFQFZ5/JD82E8loXEnMAmYXrfbl6mq9ex3O/YHItpztJp1q
	 T31ljH4q76QzjVGnZ59xr4cAhW5GdEOL6XVWmq1SVo+rXaUetFKFaUAFOXzqaH7H85
	 f/wdhFGVpDkaY6F6UJc+SlocNn5xHBGKye1x4ZphqfS04dQe88oBO/cZsQS2kya5ZM
	 xdX14vWKlMVhA==
Message-ID: <22a53212-23a4-47d5-ab11-038e58b5e5a0@kernel.org>
Date: Mon, 1 Sep 2025 20:36:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] ipv4: icmp: Pass IPv4 control block
 structure as an argument to __icmp_send()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> __icmp_send() is used to generate ICMP error messages in response to
> various situations such as MTU errors (i.e., "Fragmentation Required")
> and too many hops (i.e., "Time Exceeded").
> 
> The skb that generated the error does not necessarily come from the IPv4
> layer and does not always have a valid IPv4 control block in skb->cb.
> 
> Therefore, commit 9ef6b42ad6fd ("net: Add __icmp_send helper.") changed
> the function to take the IP options structure as argument instead of
> deriving it from the skb's control block. Some callers of this function
> such as icmp_send() pass the IP options structure from the skb's control
> block as in these call paths the control block is known to be valid, but
> other callers simply pass a zeroed structure.
> 
> A subsequent patch will need __icmp_send() to access more information
> from the IPv4 control block (specifically, the ifindex of the input
> interface). As a preparation for this change, change the function to
> take the IPv4 control block structure as an argument instead of the IP
> options structure. This makes the function similar to its IPv6
> counterpart that already takes the IPv6 control block structure as an
> argument.
> 
> No functional changes intended.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/icmp.h    | 10 ++++++----
>  net/ipv4/cipso_ipv4.c | 12 ++++++------
>  net/ipv4/icmp.c       | 12 +++++++-----
>  net/ipv4/route.c      | 10 +++++-----
>  4 files changed, 24 insertions(+), 20 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



