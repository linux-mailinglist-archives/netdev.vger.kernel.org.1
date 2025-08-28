Return-Path: <netdev+bounces-218004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC23DB3ACED
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A30E1890275
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5022B5AD;
	Thu, 28 Aug 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTptxzYy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5292264C0
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417567; cv=none; b=tDYMGytjHGi35rKF8wNUNTwzZTFhuAzEv3AwYgAvlyxXF9zCqBVas21n1CfG91m8oJL5qqhYKWHW1PLhVblfDEPPYpoZB6k/ImQ29hVawPJIC8XPT5cGsuL1Swvgxz0QKzsLiWFbLpeMQYwLwKKyJZBOhp43Z0XmiDZV9Qjc4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417567; c=relaxed/simple;
	bh=b1vCVyxVyhgcLvyKDAZGxLkbXI+ZmAk3/5zUhhet/ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgGUvywq0wmHbO3s1pri3kpM4mbdQU0+8MLrLDooIhuwVmwsZsWVn6LFnkq/xl2r9HlVCK072oYUGwX6CaqBeHfVLF0qF8dS192EnjFNZvAq1FNfzo2/B3HJ/GXp60wzP3ej+VsxXlsJ+iVmNamGe4DwZunlA499QsOPkk7cS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTptxzYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9106C4CEEB;
	Thu, 28 Aug 2025 21:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756417567;
	bh=b1vCVyxVyhgcLvyKDAZGxLkbXI+ZmAk3/5zUhhet/ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WTptxzYyYrIbye/vZCrsvCZs583/PDeIw8YupPMZr/mbBZXztqH8HKt+qhT6l13Im
	 jWR11WAJwGFZRPcTU/DfcHk8zau6/TqheNcaVkEs72hFrCO3+YVrJw8Jg3FJH3bHYO
	 kp3ixAjVPtHfBunDyhrj7AaYuSahcuYha84g0ERJzM/W3Yx1yFdiUKt2ac33VmpFOs
	 zakkL1Bpt20/fK6E04NzT44dxAyJHiNsRq+YmVCNfE5y/MgaxUygaAmbLB2YuWATiz
	 5gTEhLbHAic0+YbTgarjAaB2zFJdUrRf+brI89FDtPHPeQc8BDofaAyyJZaK4TDIkk
	 i5BeT4gX776vA==
Message-ID: <326b8a8c-fe86-4751-a81b-b5bef50e5867@kernel.org>
Date: Thu, 28 Aug 2025 15:46:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] ipv6: start using dst_dev_rcu()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-3-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Refactor icmpv6_xrlim_allow() and ip6_dst_hoplimit()
> so that we acquire rcu_read_lock() a bit longer
> to be able to use dst_dev_rcu() instead of dst_dev().
> 
> __ip6_rt_update_pmtu() and rt6_do_redirect can directly
> use dst_dev_rcu() in sections already holding rcu_read_lock().
> 
> Small changes to use dst_dev_net_rcu() in
> ip6_default_advmss(), ipv6_sock_ac_join(),
> ip6_mc_find_dev() and ndisc_send_skb().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/anycast.c     | 2 +-
>  net/ipv6/icmp.c        | 6 +++---
>  net/ipv6/mcast.c       | 2 +-
>  net/ipv6/ndisc.c       | 2 +-
>  net/ipv6/output_core.c | 8 +++++---
>  net/ipv6/route.c       | 7 +++----
>  6 files changed, 14 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


