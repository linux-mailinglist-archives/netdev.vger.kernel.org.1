Return-Path: <netdev+bounces-133164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729F99525A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC661C25308
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5521DF73C;
	Tue,  8 Oct 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+sIumao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565581F951
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399019; cv=none; b=fa8rz2EgN0o2vw8nBbzfHIK6meu5oXHxPbUmOT1Ol1lVIsFmK2ksTNZEw12Dil3YDBn+AmHsmz9G3Cn/wgfo0IfR3l9lFo1vSn30gqkAo6smnM/GinLLkpwNa6rZz5lB8fMn/iv9DpjO5zapInZBfMuEC1ppXHSEBuqJi0GUvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399019; c=relaxed/simple;
	bh=+j+v3UYpnMzW7J7g6sIYcIpEgGF78nSWnO/jzThNHHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vE2CgkjVazsgpNcGSJOQerqZcYj/A2XS99xs9xIy4VPKLppNzL77+QqtIVgWM7ap+FJaQbv/0gwESZv2U8CHNnRo7Sv20+qPYUnftp1Us6BU4z1tK3mxeYQ/f0GyuvkufDIV032e3o/OgNZOFclhG8iAVhqboN+X4qH+SBV738w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+sIumao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985C7C4CECD;
	Tue,  8 Oct 2024 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728399018;
	bh=+j+v3UYpnMzW7J7g6sIYcIpEgGF78nSWnO/jzThNHHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+sIumao3hoRJJUbNc8aty/yjFpQ8opdDVYYe/DDZBYxcTrFLu4RiUUfQPW18AiJC
	 XvJ5tunBaWoK779OUxFfOd4Ao2FKnabQ7iGSOo0mZK2Ku/kOZf9eKNptK5XEdsJyln
	 EpAlN/lCx+WTmDAojwNP9GVkk0Lny4PNYLKvVPubbVzrZqr7U7e3LHwJNK4lEp3t/1
	 x5ce1oOWCpZ/ne1ekxyDvqxiEZIyTw1uIpW78KqvfoJQb6EZX8KkEW/zKXfAhbxYNW
	 fyTBR7H0SB5xMTIW2kMQXLiBGwrdYEwN5C3QnHWkagTj2DZ7RwtKjP9G/Wldn3v/or
	 Dq7b7oeZ6aR5w==
Message-ID: <c2781afc-7b89-4f70-8a37-bb2436716a91@kernel.org>
Date: Tue, 8 Oct 2024 08:50:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] ipv4: Convert __fib_validate_source() and
 its callers to dscp_t.
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1728302212.git.gnault@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cover.1728302212.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 12:24 PM, Guillaume Nault wrote:
> This patch series continues to prepare users of ->flowi4_tos to a
> future conversion of this field (__u8 to dscp_t). This time, we convert
> __fib_validate_source() and its call chain.
> 
> The objective is to eventually make all users of ->flowi4_tos use a
> dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
> regressions where ECN bits are erroneously interpreted as DSCP bits.
> 
> Guillaume Nault (7):
>   ipv4: Convert ip_route_use_hint() to dscp_t.
>   ipv4: Convert ip_mkroute_input() to dscp_t.
>   ipv4: Convert __mkroute_input() to dscp_t.
>   ipv4: Convert ip_route_input_mc() to dscp_t.
>   ipv4: Convert ip_mc_validate_source() to dscp_t.
>   ipv4: Convert fib_validate_source() to dscp_t.
>   ipv4: Convert __fib_validate_source() to dscp_t.
> 
>  include/net/ip_fib.h    |  3 ++-
>  include/net/route.h     |  7 +++---
>  net/ipv4/fib_frontend.c |  9 +++----
>  net/ipv4/ip_input.c     |  4 ++--
>  net/ipv4/route.c        | 52 ++++++++++++++++++-----------------------
>  net/ipv4/udp.c          |  4 ++--
>  6 files changed, 38 insertions(+), 41 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


