Return-Path: <netdev+bounces-101188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7178FDB0E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44691C23270
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A278167DBF;
	Wed,  5 Jun 2024 23:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0C1AAA5;
	Wed,  5 Jun 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631871; cv=none; b=Wub+LatOf0YHSujXa/N/tJLFpDdqVMYhpfTeHhHCCgkzeR8sctu9hS80aTnlT4G2fkphiYidR7g/CLt5uRFtHJnhpM4dC0vOzOYiUSomWREt4TBTaieXUm8LPIVVI01Y/f3ho1V98dRp+ajVxd0ig0GiZw6PiVgDSUlR5m0oofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631871; c=relaxed/simple;
	bh=5ApjUtK872vDWT9BiZ/Y5CWSDUL4VWEAnM4+OUhd+Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swM4D0LYZknRjEJeaV/zhOTNcKjNNN6DEXrd++mTLxliK8nBJLyyOWrCWf1iASivwiEjuytJWJx57GSKU5zmJEEwYHaTYEanYY7JYWZzC2mJBTYLddzldrsTcpvKU2PcM8Se7AAEIVIdXxsJ4bnlYV93iQlLtrJy4K5SUmv5JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445C9C2BD11;
	Wed,  5 Jun 2024 23:57:48 +0000 (UTC)
Date: Wed, 5 Jun 2024 19:57:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina
 Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells
 <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann
 <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov
 <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>,
 linux-trace-kernel@vger.kernel.org, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
Message-ID: <20240605195750.1a225963@gandalf.local.home>
In-Reply-To: <983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
References: <cover.1717529533.git.yan@cloudflare.com>
	<983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 14:47:38 -0700
Yan Zhai <yan@cloudflare.com> wrote:

> skb does not include enough information to find out receiving
> sockets/services and netns/containers on packet drops. In theory
> skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
> stack for OOO packet lookup. Similarly, skb->sk often identifies a local
> sender, and tells nothing about a receiver.
> 
> Allow passing an extra receiving socket to the tracepoint to improve
> the visibility on receiving drops.
> 
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> v2->v3: fixed drop_monitor function prototype
> ---
>  include/trace/events/skb.h | 11 +++++++----
>  net/core/dev.c             |  2 +-
>  net/core/drop_monitor.c    |  9 ++++++---
>  net/core/skbuff.c          |  2 +-
>  4 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index 07e0715628ec..aa6b46b6172c 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -24,15 +24,16 @@ DEFINE_DROP_REASON(FN, FN)
>  TRACE_EVENT(kfree_skb,
>  
>  	TP_PROTO(struct sk_buff *skb, void *location,
> -		 enum skb_drop_reason reason),
> +		 enum skb_drop_reason reason, struct sock *rx_sk),
>  
> -	TP_ARGS(skb, location, reason),
> +	TP_ARGS(skb, location, reason, rx_sk),
>  
>  	TP_STRUCT__entry(
>  		__field(void *,		skbaddr)
>  		__field(void *,		location)
>  		__field(unsigned short,	protocol)
>  		__field(enum skb_drop_reason,	reason)
> +		__field(void *,		rx_skaddr)

Please add the pointer after the other pointers:

 		__field(void *,		skbaddr)
 		__field(void *,		location)
+		__field(void *,		rx_skaddr)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)

otherwise you are adding holes in the ring buffer event.

The TP_STRUCT__entry() is a structure that is saved in the ring buffer. We
want to avoid alignment holes. I also question having a short before the
enum, if the emum is 4 bytes. The short should be at the end.

In fact, looking at the format file, there is a 2 byte hole:

 # cat /sys/kernel/tracing/events/skb/kfree_skb/format

name: kfree_skb
ID: 1799
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:void * skbaddr;	offset:8;	size:8;	signed:0;
	field:void * location;	offset:16;	size:8;	signed:0;
	field:unsigned short protocol;	offset:24;	size:2;	signed:0;
	field:enum skb_drop_reason reason;	offset:28;	size:4;	signed:0;

Notice that "protocol" is 2 bytes in size at offset 24, but "reason" starts
at offset 28. This means at offset 26, there's a 2 byte hole.

-- Steve



>  	),
>  
>  	TP_fast_assign(
> @@ -40,12 +41,14 @@ TRACE_EVENT(kfree_skb,
>  		__entry->location = location;
>  		__entry->protocol = ntohs(skb->protocol);
>  		__entry->reason = reason;
> +		__entry->rx_skaddr = rx_sk;
>  	),
>  


