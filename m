Return-Path: <netdev+bounces-70835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35146850AF7
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 20:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C11C20D5A
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AC5C614;
	Sun, 11 Feb 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmLN/F6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB265B5AD
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678201; cv=none; b=nXrIeHIkYJ9QpEttkw7MRSQxHRmPGmnuA5bSQDteLjDj36c1Ak8tZK1c0dZkOxtbfkr5YAyCycZ4+QH7ssZMpJMIi8VEU8DHOH7MbJyEdFi6v3M1vObq5RjzO0TfyUicP9la4jEUSj5xKLO8bUpO/u8+OKXQpaAj/g7J9GbHDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678201; c=relaxed/simple;
	bh=H7fOyObAV3smH0AvGX6lakb6QfWZruk0B1+49U9ZHvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbj3nSMakyeU7EZDl5Yut4J9BfYjD/7PkxklSG2S3THcKM0Y/HyKe2qVCQAWEA/H40Bb06M5zvQYystBFBq6DJa2duUjUiUSbvkC8bj30Xlc55N6gd6W9CtrlkOtlOLIQJKuFBNSI+FWN0gcXcR/+/yucNxgmh7D5pPdw1zHd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmLN/F6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D3C433C7;
	Sun, 11 Feb 2024 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707678200;
	bh=H7fOyObAV3smH0AvGX6lakb6QfWZruk0B1+49U9ZHvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cmLN/F6ZoGrNumK32v0Qkhldt4E8BJQTIQzVVDlB/QJTvzIN9MUzCM19LRQsqwICd
	 A8wDKZMXL1wnf3Tbb98HT0Bx/MH/fk6V5Dm0aVbvHMO+frT0FaEDJLKS48DEQh5LXq
	 Sigd95+Iz+K2yWHbQySb9hNlquc9L6cL2DtWi2l0CSs/DGfUmIxqAnpfoK9OJQFEof
	 oitUbZxwyRLl3IdLwPtVM2sFR9akM+nKSN1oqxMQrOEjm/1RB8+whfqYWrSvO1e6uF
	 I8FWb55AYmhK/kRz/mxAGZNKBQaYc7JlAUMK6oWs3pKtRHX8bRpv1ojjrwH7/ASNjH
	 HqoscNJgOD1yw==
Message-ID: <5d12353d-8c1b-4dcb-a908-5ccb8081970b@kernel.org>
Date: Sun, 11 Feb 2024 12:03:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: Set the routing scope properly in
 ip_route_output_ports().
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, James Chapman <jchapman@katalix.com>,
 Taehee Yoo <ap420073@gmail.com>
References: <dacfd2ab40685e20959ab7b53c427595ba229e7d.1707496938.git.gnault@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <dacfd2ab40685e20959ab7b53c427595ba229e7d.1707496938.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 9:43 AM, Guillaume Nault wrote:
> Set scope automatically in ip_route_output_ports() (using the socket
> SOCK_LOCALROUTE flag). This way, callers don't have to overload the
> tos with the RTO_ONLINK flag, like RT_CONN_FLAGS() does.
> 
> For callers that don't pass a struct sock, this doesn't change anything
> as the scope is still set to RT_SCOPE_UNIVERSE when sk is NULL.
> 
> Callers that passed a struct sock and used RT_CONN_FLAGS(sk) or
> RT_CONN_FLAGS_TOS(sk, tos) for the tos are modified to use
> ip_sock_tos(sk) and RT_TOS(tos) respectively, as overloading tos with
> the RTO_ONLINK flag now becomes unnecessary.
> 
> In drivers/net/amt.c, all ip_route_output_ports() calls use a 0 tos
> parameter, ignoring the SOCK_LOCALROUTE flag of the socket. But the sk
> parameter is a kernel socket, which doesn't have any configuration path
> for setting SOCK_LOCALROUTE anyway. Therefore, ip_route_output_ports()
> will continue to initialise scope with RT_SCOPE_UNIVERSE and amt.c
> doesn't need to be modified.
> 
> Also, remove RT_CONN_FLAGS() and RT_CONN_FLAGS_TOS() from route.h as
> these macros are now unused.
> 
> The objective is to eventually remove RTO_ONLINK entirely to allow
> converting ->flowi4_tos to dscp_t. This will ensure proper isolation
> between the DSCP and ECN bits, thus minimising the risk of introducing
> bugs where TOS values interfere with ECN.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/net/route.h             | 7 ++-----
>  net/ipv4/af_inet.c              | 2 +-
>  net/ipv4/datagram.c             | 2 +-
>  net/ipv4/inet_connection_sock.c | 2 +-
>  net/ipv4/ip_output.c            | 2 +-
>  net/l2tp/l2tp_ip.c              | 2 +-
>  6 files changed, 7 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


