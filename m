Return-Path: <netdev+bounces-207546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C4B07B83
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424EA16F8D5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C12F5493;
	Wed, 16 Jul 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xqr5SlOS"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4D283FE0
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684606; cv=none; b=SU9qZ/hLe7kyKX9GqE75yZfBA3Zkrgf02jsl750TXwI+YHZ9DDimrSIufbGMH2bqpFq9iSvudy9zOV5YbHLUDjTD+M3oGolW+9uI66Pa2mtUDiYuh5tQNvzXXvRETWNOYQ56bZRaeiPhe41lUGAIkToB1WVemAsiPP9EhbDC7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684606; c=relaxed/simple;
	bh=P+k06D7qBbCZm8y3X9WpXeA/zja+4RlUeGc0UOrydo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0oQ5ccoUBUyHBZ0Fv3T/IOjMl3z62hL7DdF7sadA4r4TsciuKSyzNA388ikCNEYcuXO1K35eNCQ0osxywj4+vdzUSqNQt4I+hoSLgH4z9FUbiBufW+NbVKCGguTuftZcRuUAn+cwmtBlz5erSwtOXuvZ9mALLgJjuLmSySuMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xqr5SlOS; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Jul 2025 09:49:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752684599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJMpmtlIPf4k+hDO7cbykgh07PoM5NDYPjmc8MkH7/4=;
	b=Xqr5SlOSNTfFxmkk2StgfhvEBwSew07x8SDxLTfEdxR64duiIBUX0ioQGZCxzF4QLQoE59
	D42vfchWcmJLG8avGrPG8gDtFkYSPR2iZxgNO8soiJ0FNewbOKNAzx/NgQh2bGCrhWKqgC
	D5Q9KvyMgt3ghQQFNA4LSRGVa4Aqylw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: account for memory pressure
 signaled by cgroup
Message-ID: <vlybtuctmjmsfkh4x455q4iokcme4zbowvolvti2ftmcysechr@ydj4uss6vkm2>
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-2-daniel.sedlak@cdn77.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714143613.42184-2-daniel.sedlak@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 14, 2025 at 04:36:12PM +0200, Daniel Sedlak wrote:
> This patch is a result of our long-standing debug sessions, where it all
> started as "networking is slow", and TCP network throughput suddenly
> dropped from tens of Gbps to few Mbps, and we could not see anything in
> the kernel log or netstat counters.
> 
> Currently, we have two memory pressure counters for TCP sockets [1],
> which we manipulate only when the memory pressure is signalled through
> the proto struct [2]. However, the memory pressure can also be signaled
> through the cgroup memory subsystem, which we do not reflect in the
> netstat counters. In the end, when the cgroup memory subsystem signals
> that it is under pressure, we silently reduce the advertised TCP window
> with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
> throughput reduction.
> 
> So this patch adds a new counter to account for memory pressure
> signaled by the memory cgroup, so it is much easier to spot.
> 
> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
> Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
> ---
>  Documentation/networking/net_cachelines/snmp.rst |  1 +
>  include/net/tcp.h                                | 14 ++++++++------
>  include/uapi/linux/snmp.h                        |  1 +
>  net/ipv4/proc.c                                  |  1 +
>  4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
> index bd44b3eebbef..ed17ff84e39c 100644
> --- a/Documentation/networking/net_cachelines/snmp.rst
> +++ b/Documentation/networking/net_cachelines/snmp.rst
> @@ -76,6 +76,7 @@ unsigned_long  LINUX_MIB_TCPABORTONLINGER
>  unsigned_long  LINUX_MIB_TCPABORTFAILED
>  unsigned_long  LINUX_MIB_TCPMEMORYPRESSURES
>  unsigned_long  LINUX_MIB_TCPMEMORYPRESSURESCHRONO
> +unsigned_long  LINUX_MIB_TCPCGROUPSOCKETPRESSURE
>  unsigned_long  LINUX_MIB_TCPSACKDISCARD
>  unsigned_long  LINUX_MIB_TCPDSACKIGNOREDOLD
>  unsigned_long  LINUX_MIB_TCPDSACKIGNOREDNOUNDO
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 761c4a0ad386..aae3efe24282 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -267,6 +267,11 @@ extern long sysctl_tcp_mem[3];
>  #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
>  #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in RACK */
>  
> +#define TCP_INC_STATS(net, field)	SNMP_INC_STATS((net)->mib.tcp_statistics, field)
> +#define __TCP_INC_STATS(net, field)	__SNMP_INC_STATS((net)->mib.tcp_statistics, field)
> +#define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
> +#define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
> +
>  extern atomic_long_t tcp_memory_allocated;
>  DECLARE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
>  
> @@ -277,8 +282,10 @@ extern unsigned long tcp_memory_pressure;
>  static inline bool tcp_under_memory_pressure(const struct sock *sk)
>  {
>  	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
> -	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
> +	    mem_cgroup_under_socket_pressure(sk->sk_memcg)) {
> +		TCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPCGROUPSOCKETPRESSURE);
>  		return true;

Incrementing it here will give a very different semantic to this stat
compared to LINUX_MIB_TCPMEMORYPRESSURES. Here the increments mean the
number of times the kernel check if a given socket is under memcg
pressure for a net namespace. Is that what we want?


