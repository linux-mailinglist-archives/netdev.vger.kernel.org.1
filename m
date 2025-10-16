Return-Path: <netdev+bounces-230207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D89BE54C6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69AA74E10A3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3536F28E571;
	Thu, 16 Oct 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cavN09Bs"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B52DC791
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644677; cv=none; b=B3gIJZzWtH+NFkgviJyEtMYBGuzyxNGGZ9gKxGalkZLK/90HqrrsH5CsC900XJ2DHUgkeR08vzq2Fyk0FPgGk1sAHFfp3G4LnueTBo8UP1wUafWL8y0H4UzYF2tvoo9U0E8CpWIOQTRNeP3JFaOdTmr0K0M9oHLvOY5r9moB5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644677; c=relaxed/simple;
	bh=VOTlOzJ0HPYw5d7WJPmbWEHOA2OmD4JtKDS7yjUv5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2HIb8jnch7UrqDATzhOg7JpdgwNezglcTJN/SS5QmCc/i7ZkrAUJBnv0Qd8hWNKu4PgPu/k4wBIwLwwOBr4w4gm+Jq+qqTqQwtTrHEV3fmHCYhkeUR4ahVPk8mkCcy6uOJXU2AkizncxpBBy5VAyekDydPUrJMqej59s6clBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cavN09Bs; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Oct 2025 12:57:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760644663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6QNM0LEjMhDM1AhzKkrXtK0wDpQlcn/3jFNh89PFW4=;
	b=cavN09Bsrq20N4KdKPWHM3D4vp7y79G96geueuYvCN/GClE8DD+V9Zb9uYlORCxcKV8RBo
	wCw6LqJx7EjOCW508calrRTToHHshth4/lAEfrtzLAAibUS8iH2yfGak6KWNIKmsjMiFuQ
	HDZhnN3zBftFsukEePJ+mHPWn7HnDWo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Wei Wang <weibunny@meta.com>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: net: track network throttling due to memcg
 memory pressure
Message-ID: <sntikxyoeveee3tkrxwr5rrztzr26sqzpn63r5nrel6vdyb7as@6mpya3n4mxju>
References: <20251016161035.86161-1-shakeel.butt@linux.dev>
 <20251016124610.0fcf17313c649795881db43c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016124610.0fcf17313c649795881db43c@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 16, 2025 at 12:46:10PM -0700, Andrew Morton wrote:
> On Thu, 16 Oct 2025 09:10:35 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > The kernel can throttle network sockets if the memory cgroup associated
> > with the corresponding socket is under memory pressure. The throttling
> > actions include clamping the transmit window, failing to expand receive
> > or send buffers, aggressively prune out-of-order receive queue, FIN
> > deferred to a retransmitted packet and more. Let's add memcg metric to
> > indicate track such throttling actions.
> > 
> > At the moment memcg memory pressure is defined through vmpressure and in
> > future it may be defined using PSI or we may add more flexible way for
> > the users to define memory pressure, maybe through ebpf. However the
> > potential throttling actions will remain the same, so this newly
> > introduced metric will continue to track throttling actions irrespective
> > of how memcg memory pressure is defined.
> > 
> > ...
> >
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2635,8 +2635,12 @@ static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
> >  #endif /* CONFIG_MEMCG_V1 */
> >  
> >  	do {
> > -		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
> > +		if (time_before64(get_jiffies_64(),
> > +				  mem_cgroup_get_socket_pressure(memcg))) {
> > +			memcg_memory_event(mem_cgroup_from_sk(sk),
> > +					   MEMCG_SOCK_THROTTLED);
> >  			return true;
> > +		}
> >  	} while ((memcg = parent_mem_cgroup(memcg)));
> >  
> 
> Totally OT, but that's one bigass inlined function.  A quick test
> indicates that uninlining just this function reduces the size of
> tcp_input.o and tcp_output.o nicely.  x86_64 defconfig:
> 
>    text	   data	    bss	    dec	    hex	filename
>   52130	   1686	      0	  53816	   d238	net/ipv4/tcp_input.o
>   32335	   1221	      0	  33556	   8314	net/ipv4/tcp_output.o
> 
>    text	   data	    bss	    dec	    hex	filename
>   51346	   1494	      0	  52840	   ce68	net/ipv4/tcp_input.o
>   31911	   1125	      0	  33036	   810c	net/ipv4/tcp_output.o
> 

Nice find and this inlining might be hurting instead of helping. I will
look into it if no one else comes to it before me.

