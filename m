Return-Path: <netdev+bounces-43056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D197D132B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93633282527
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB81E517;
	Fri, 20 Oct 2023 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXK0+x1H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A651DA5F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939BBC433C8;
	Fri, 20 Oct 2023 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697817229;
	bh=ow2qZjxXy+ExHb0uBtwQDVUdBzUxQ+bVCPkMYGwP4wo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXK0+x1HbHx8xuwenAfeT5VRFSF0H1ems9MrSMoYJ8eMd68A9Bf4aFc2OOz944whC
	 xVVB7npSSPzXGJoNqGGCsgjOXVb20Q5tKgn9B6Hiuh4koqnutaVsUpD8NPGVjdu4C3
	 xy8Okd2yPNEGS06qF3yjgr3W3H2zZXeut+nBKBstuTAWHQ5h1a+6+kRk3euT1cNIT4
	 VLrk39+enM1r7NrLa5ZW8jvWBjKSAI+gfK2dLx2bc+NUToKvrI+y+Z/onomZzv8J2a
	 z+hBKGxiX0J7Wzb2GBRI7XFZSMsuaCnWnoNRU7q++r9HMnu45fljjIL+r0eQxLGJ7o
	 P3eaAV6WPiUVQ==
Message-ID: <e569b2a1-8766-793a-a0c5-f901ef146198@kernel.org>
Date: Fri, 20 Oct 2023 09:53:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/5] ipv6: add new arguments to
 udp_tunnel6_dst_lookup()
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-4-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-4-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> We want to make the function more generic so that it can be used by
> other UDP tunnel implementations such as geneve and vxlan. To do that,
> add the following arguments:
> 
>  - source and destination UDP port;
>  - ifindex of the output interface, needed by vxlan;
>  - the tos, because in some cases it is not taken from struct
>    ip_tunnel_info (for example, when it's inherited from the inner
>    packet);
>  - the dst cache, because not all tunnel types (e.g. vxlan) want to
>    use the one from struct ip_tunnel_info.
> 
> With these parameters, the function no longer needs the full struct
> ip_tunnel_info as argument and we can pass only the relevant part of
> it (struct ip_tunnel_key).
> 
> This is similar to what already done for IPv4 in commit 72fc68c6356b
> ("ipv4: add new arguments to udp_tunnel_dst_lookup()").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c     | 10 +++++++---
>  include/net/udp_tunnel.h  |  7 ++++---
>  net/ipv6/ip6_udp_tunnel.c | 33 ++++++++++++++++++---------------
>  3 files changed, 29 insertions(+), 21 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



