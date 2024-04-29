Return-Path: <netdev+bounces-92237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E08B616C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5191F22C10
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932D13AA31;
	Mon, 29 Apr 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDLhzZF2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F7127E20
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416702; cv=none; b=A6NquClxYWeGvjYpbnc+bHV+met9LS5TemoTdJ4NcrSsRTw6N1OAJoI1pRoh4axasl8jHeN2E+MwpxRfa3miaTKqWgeeNiQ6lr286bs5goOek9VeROfQ/2brnwSNj5enylZOmedwrLeFWK+/9J8cAe4qcOOu/fkRPGLPp2/aAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416702; c=relaxed/simple;
	bh=DW0F/0fyFOLtcXYzljdANlvFobwcwUaH9zyAqyyR72E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWVc3MUapjUCia5qlINH6o4iHHmrAmUFruo1KPWQreq9lEljMDIIhbwrCdp1RksEWYd6sD8gT1XDJedg0572ETDYRFn1ei+pDbYemangnNLWM01YYLERo2q9zkzZ4tbPEOq2y799LvWoyrTuXrWWa2egGVFlaRqElAy90bPxIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDLhzZF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E83C113CD;
	Mon, 29 Apr 2024 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714416702;
	bh=DW0F/0fyFOLtcXYzljdANlvFobwcwUaH9zyAqyyR72E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fDLhzZF2Pjcl7UrJkdKuvE9VZCkhqPBm85sf6VQ35zu/P1YkpNWuAcT5hhjFZG9FH
	 LbukMh+RUb6+KMSUKals5xXmfQ7hWVpuDgUUI2QeuQB1LvREdS9nqn+JwOMTb6kgGb
	 I4IQRi3GgmQiNwgJD89M0d+G6DuX7+Pn3w2/cbmNUKHS+uN+9F7tztqes08rmlMvP/
	 QKNcSa2jAtyP5z8yCetSVpLmH+oPT/QBUIBq8xWUynzfXO9r44xj2IAO+j8lJoBk0C
	 Df5PaebXxpN5xZXyN3lDr5xlq7VawvF4ZWQD3BZe0A9UPPrB5MdAGZvkzxvxFQoHRO
	 ZKJBKbOPwP2SQ==
Message-ID: <53eafc84-c51e-4c88-93ad-18c33ffe426c@kernel.org>
Date: Mon, 29 Apr 2024 12:51:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet: introduce dst_rtable() helper
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240429133009.1227754-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240429133009.1227754-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/24 7:30 AM, Eric Dumazet wrote:
> I added dst_rt6_info() in commit
> e8dfd42c17fa ("ipv6: introduce dst_rt6_info() helper")
> 
> This patch does a similar change for IPv4.
> 
> Instead of (struct rtable *)dst casts, we can use :
> 
>  #define dst_rtable(_ptr) \
>              container_of_const(_ptr, struct rtable, dst)
> 
> Patch is smaller than IPv6 one, because IPv4 has skb_rtable() helper.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/infiniband/core/addr.c   | 12 +++---------
>  drivers/net/vrf.c                |  2 +-
>  drivers/s390/net/qeth_core.h     |  5 ++---
>  include/linux/skbuff.h           |  9 ---------
>  include/net/ip.h                 |  4 ++--
>  include/net/route.h              | 11 +++++++++++
>  net/atm/clip.c                   |  2 +-
>  net/core/dst_cache.c             |  2 +-
>  net/core/filter.c                |  3 +--
>  net/ipv4/af_inet.c               |  2 +-
>  net/ipv4/icmp.c                  | 26 ++++++++++++++------------
>  net/ipv4/ip_input.c              |  2 +-
>  net/ipv4/ip_output.c             |  8 ++++----
>  net/ipv4/route.c                 | 24 +++++++++++-------------
>  net/ipv4/udp.c                   |  2 +-
>  net/ipv4/xfrm4_policy.c          |  2 +-
>  net/l2tp/l2tp_ip.c               |  2 +-
>  net/mpls/mpls_iptunnel.c         |  2 +-
>  net/netfilter/ipvs/ip_vs_xmit.c  |  2 +-
>  net/netfilter/nf_flow_table_ip.c |  4 ++--
>  net/netfilter/nft_rt.c           |  2 +-
>  net/sctp/protocol.c              |  4 ++--
>  net/tipc/udp_media.c             |  2 +-
>  23 files changed, 64 insertions(+), 70 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



