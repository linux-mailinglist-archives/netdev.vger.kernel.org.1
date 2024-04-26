Return-Path: <netdev+bounces-91734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF9B8B3AAF
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6291C240F0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49E149011;
	Fri, 26 Apr 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyQBHN82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EB148FE1
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144159; cv=none; b=BevOlm2VofONF03AFRmxMuxVJHonqHG2JSp9kTVzoXVUmc4KwPqoNBNfeIoWdpzDsUg192x1kwKxm9gHCt46TGYlvFmX+EPA0Wqi3s0hb/jzyEbfhK+s+QFVtJgdjgNR3VO4pApwXdr73OkPhfzILXPgx2kdxmBsHiaS3vzZcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144159; c=relaxed/simple;
	bh=yaU/HHR/rhUtN5Q2lblbIJPD+nqMtry98iNXBo0wyss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kocSM1jeLuJsZ7rsDhQI9hykJGcsRcU2OOw2i4h+6OQlkuiwGQ1uQv85H+WBMWFDeOsEpQ6QoryxhXNOnA/wKZ2rJ9/Pk+ZGd2BmGWa1pdzaQvWLNftsk1icmzLx0/SmLxnjbQLVhLZD2KDvo2WlLRDYW7DW7BJNUdO2IR/WVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyQBHN82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007D4C113CD;
	Fri, 26 Apr 2024 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144159;
	bh=yaU/HHR/rhUtN5Q2lblbIJPD+nqMtry98iNXBo0wyss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EyQBHN82cgxrl/Qj89DkqI9kWKQmasKxFkhZcTkwQParl0apigvW53ATF9wzleN5v
	 FMKn9M6VHFRZX6F82DgFlFYKlcHgwvp4J05PEz7LqAbmgElCBTF3dMddBrHR2LoFcv
	 6BSiK8oPmlgeOm872i07ze8N1Ac3hffMqMzGByz59dqrNVxr00yTeLdh2U/MnXapJj
	 qaSYZqM1fc5vPXOPvTzYvMsUn18qGSbd8FPsy78Qro2TLMItU5TuDSjP6oZYOLcBu2
	 3pdI8/MMNfHarN9yfFWbE5UcHmbWQd0Dt3vsFHylijuiKVzPhULsM9g7EV62rz220q
	 iNgh5cntOW2HQ==
Message-ID: <9fa615a8-3b5e-4cd2-ba76-f72d908c32b7@kernel.org>
Date: Fri, 26 Apr 2024 09:09:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: introduce dst_rt6_info() helper
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240425165757.90458-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240425165757.90458-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/24 10:57 AM, Eric Dumazet wrote:
> Instead of (struct rt6_info *)dst casts, we can use :
> 
>  #define dst_rt6_info(_ptr) \
>          container_of_const(_ptr, struct rt6_info, dst)
> 
> Some places needed missing const qualifiers :
> 
> ip6_confirm_neigh(), ipv6_anycast_destination(),
> ipv6_unicast_destination(), has_gateway()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/infiniband/core/addr.c                |  6 ++--
>  .../ethernet/mellanox/mlxsw/spectrum_span.c   |  2 +-
>  drivers/net/vrf.c                             |  2 +-

missing drivers/net/vxlan/vxlan_core.c, vxlan_xmit_one

>  drivers/s390/net/qeth_core.h                  |  2 +-
>  include/net/ip6_fib.h                         |  6 ++--
>  include/net/ip6_route.h                       | 11 ++++----
>  net/bluetooth/6lowpan.c                       |  2 +-
>  net/core/dst_cache.c                          |  2 +-
>  net/core/filter.c                             |  2 +-
>  net/ipv4/ip_tunnel.c                          |  2 +-
>  net/ipv6/icmp.c                               |  8 +++---
>  net/ipv6/ila/ila_lwt.c                        |  4 +--
>  net/ipv6/ip6_output.c                         | 18 ++++++------
>  net/ipv6/ip6mr.c                              |  2 +-
>  net/ipv6/ndisc.c                              |  2 +-
>  net/ipv6/ping.c                               |  2 +-
>  net/ipv6/raw.c                                |  4 +--
>  net/ipv6/route.c                              | 28 +++++++++----------
>  net/ipv6/tcp_ipv6.c                           |  4 +--
>  net/ipv6/udp.c                                | 11 +++-----
>  net/ipv6/xfrm6_policy.c                       |  2 +-
>  net/l2tp/l2tp_ip6.c                           |  2 +-
>  net/mpls/mpls_iptunnel.c                      |  2 +-
>  net/netfilter/ipvs/ip_vs_xmit.c               | 14 +++++-----
>  net/netfilter/nf_flow_table_core.c            |  8 ++----
>  net/netfilter/nf_flow_table_ip.c              |  4 +--
>  net/netfilter/nft_rt.c                        |  2 +-
>  net/sctp/ipv6.c                               |  2 +-
>  net/xfrm/xfrm_policy.c                        |  3 +-
>  29 files changed, 75 insertions(+), 84 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



