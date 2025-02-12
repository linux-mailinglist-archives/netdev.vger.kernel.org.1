Return-Path: <netdev+bounces-165685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED1A33080
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE62A162812
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5F20100D;
	Wed, 12 Feb 2025 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDSyHZES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C401FF7D7
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391083; cv=none; b=bJDN/98lgSHNP8JeREFmjJSIvCxgFu5TtI9ztYIwU3OKhcVzWyD/xcoCh7FceFS0ubiL559AOS9xwCv5E82Gsc2mrIquT79LHlEPfZCsmXzNxne9z6P9JYxUQLEyiTP2KzTYz5mIFQFQpgDg+mE/jEa7Z4ZwouU1uX10k/jrzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391083; c=relaxed/simple;
	bh=VHdmywmcEgEqAsfWJi4QSwscGRS1FUi6oqqGWeedxAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuJqoxhp8f5lsgcYztj2SqVjRKrBS8KdSyo+E3FmYDqw1ih8GBeLpExrYe9/681IHr00AaBibTDO5DMPL0/D1RicpLLYAV6wdFe26q+/Zker7O5X1IiZqX/lxd3oBDkX/WsBjld3KpNQO6tWXjxiynNRr3vMoOtHMsgRofgV6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDSyHZES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC266C4CEDF;
	Wed, 12 Feb 2025 20:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739391083;
	bh=VHdmywmcEgEqAsfWJi4QSwscGRS1FUi6oqqGWeedxAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aDSyHZESwltGEOVb446QDY0SHTbd0yuKrwnzzwR8kqaGSVTcYqOWXYyetSMM6/ru6
	 I+CZWKNeXcXu1EVvudj9CIN4NAYvJP6wxHfCDtFAqAQikQJEbC3YPxL2ijuQzt/kwF
	 cT+MOYtGWdQQrS5MvzFLSs5vUojqfSC+nhGMm4epHJYTaBmJ+ygUQHJguuXe00/U/B
	 3go2tt+TzhuOpJ55E+/eKkJL6ook9LDBPyIGytWjwWiV/3822p0aDod83dRYBhzEWR
	 bYVZu0PAbelNMm91k5aX8fwViCz+AqWeUPPkNWv/5DrME5labkcERf++LnHmT3sEUy
	 /DVioMXcgrXGg==
Message-ID: <5281a36d-e46d-44d0-80ac-9a65d8201863@kernel.org>
Date: Wed, 12 Feb 2025 13:11:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] net: deduplicate cookie logic
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 7:09 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Reuse standard sk, ip and ipv6 cookie init handlers where possible.
> 
> Avoid repeated open coding of the same logic.
> Harmonize feature sets across protocols.
> Make IPv4 and IPv6 logic more alike.
> Simplify adding future new fields with a single init point.
> 
> v1->v2:
>   - limit INET_DSCP_MASK to routing
>   - remove no longer used local variable (fix build warning)
> 
> Willem de Bruijn (7):
>   tcp: only initialize sockcm tsflags field
>   net: initialize mark in sockcm_init
>   ipv4: initialize inet socket cookies with sockcm_init
>   ipv4: remove get_rttos
>   icmp: reflect tos through ip cookie rather than updating inet_sk
>   ipv6: replace ipcm6_init calls with ipcm6_init_sk
>   ipv6: initialize inet socket cookies with sockcm_init
> 
>  include/net/ip.h       | 16 +++++-----------
>  include/net/ipv6.h     | 11 ++---------
>  include/net/sock.h     |  1 +
>  net/can/raw.c          |  2 +-
>  net/ipv4/icmp.c        |  6 ++----
>  net/ipv4/ping.c        |  6 +++---
>  net/ipv4/raw.c         |  6 +++---
>  net/ipv4/tcp.c         |  2 +-
>  net/ipv4/udp.c         |  6 +++---
>  net/ipv6/ping.c        |  3 ---
>  net/ipv6/raw.c         | 15 +++------------
>  net/ipv6/udp.c         | 10 +---------
>  net/l2tp/l2tp_ip6.c    |  8 +-------
>  net/packet/af_packet.c |  9 ++++-----
>  14 files changed, 30 insertions(+), 71 deletions(-)
> 

LGTM. For the set

Reviewed-by: David Ahern <dsahern@kernel.org>


