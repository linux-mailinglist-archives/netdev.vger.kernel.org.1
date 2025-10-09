Return-Path: <netdev+bounces-228416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0998BCA17A
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBC83E1FA5
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89D226D16;
	Thu,  9 Oct 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZUm0GTpV"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AA1DE3BB
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025995; cv=none; b=rPHd4Icl6w0OQQpr1XK1Mqy2GFyWL/9Wu8Nu1NVfgE1nBiD12YTm1G+95N6Y7dFVuRFInJmpma0B3uvps2XtmA1YIu0lXWtJ4xkhiQbnY6/H5tS9/mWIFA89zWWYiINjd4Wo6TlNtGZqn9DPMlG62My4s35Mq50DoUJiDa5EATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025995; c=relaxed/simple;
	bh=NcO+P8kozAojpKsaknXrA27jXpe71fCctjMFmkzDnRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3qIAm6I/2fBEZR0ldvH90sWJe/N8Rd9OLUmteUVUd0Uzknd/Hg5iLxXtd04e0IQO6usIJUeJREXFjHNPhlHXGW5RAR7+10nKjxJQQANBOL1wrI+qHIb1E3ewXnwaYz5OKC8VQNqXBhLKiPooKjCw5cqI6xK1G1JV/BWlsxNpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZUm0GTpV; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Oct 2025 09:06:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760025980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KukbsMbl2huYRhlfoo2l0mDAbmiuXFQP1BtPelYVi10=;
	b=ZUm0GTpVawkjiuJwQRpZJGGk3dlnInR8BQqp+avz857kSA9AMtwUiJc7SoyzfdEfczhfgI
	t4YvP0k8b3mNJ0nUQGPRRxpmwogQOXrODl08eBC2UrQ9b2x+HSYz41SR2yCPRxhwqnizPK
	1dbY1/nAOQlraza2002+CzXHfj4NQzw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Message-ID: <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev>
 <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6qgnl9w.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 09, 2025 at 08:32:27AM -0700, Roman Gushchin wrote:
> Daniel Sedlak <daniel.sedlak@cdn77.com> writes:
> 
> > Hi Roman,
> >
> > On 10/8/25 8:58 PM, Roman Gushchin wrote:
> >>> This patch exposes a new file for each cgroup in sysfs which is a
> >>> read-only single value file showing how many microseconds this cgroup
> >>> contributed to throttling the throughput of network sockets. The file is
> >>> accessible in the following path.
> >>>
> >>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec
> >> Hi Daniel!
> >> How this value is going to be used? In other words, do you need an
> >> exact number or something like memory.events::net_throttled would be
> >> enough for your case?
> >
> > Just incrementing a counter each time the vmpressure() happens IMO
> > provides bad semantics of what is actually happening, because it can
> > hide important details, mainly the _time_ for how long the network
> > traffic was slowed down.
> >
> > For example, when memory.events::net_throttled=1000, it can mean that
> > the network was slowed down for 1 second or 1000 seconds or something
> > between, and the memory.net.throttled_usec proposed by this patch
> > disambiguates it.
> >
> > In addition, v1/v2 of this series started that way, then from v3 we
> > rewrote it to calculate the duration instead, which proved to be
> > better information for debugging, as it is easier to understand
> > implications.
> 
> But how are you planning to use this information? Is this just
> "networking is under pressure for non-trivial amount of time ->
> raise the memcg limit" or something more complicated?
> 
> I am bit concerned about making this metric the part of cgroup API
> simple because it's too implementation-defined and in my opinion
> lack the fundamental meaning.
> 
> Vmpressure is calculated based on scanned/reclaimed ratio (which is
> also not always the best proxy for the memory pressure level), then
> if it reaches some level we basically throttle networking for 1s.
> So it's all very arbitrary.
> 
> I totally get it from the debugging perspective, but not sure about
> usefulness of it as a permanent metric. This is why I'm asking if there
> are lighter alternatives, e.g. memory.events or maybe even tracepoints.
> 

I also have a very similar opinion that if we expose the current
implementation detail through a stable interface, we might get stuck
with this implementation and I want to change this in future.

Coming back to what information should we expose that will be helpful
for Daniel & Matyas and will be beneficial in general. After giving some
thought, I think the time "network was slowed down" or more specifically
time window when mem_cgroup_sk_under_memory_pressure() returns true
might not be that useful without the actual network activity. Basically
if no one is calling mem_cgroup_sk_under_memory_pressure() and doing
some actions, the time window is not that useful.

How about we track the actions taken by the callers of
mem_cgroup_sk_under_memory_pressure()? Basically if network stack
reduces the buffer size or whatever the other actions it may take when
mem_cgroup_sk_under_memory_pressure() returns, tracking those actions
is what I think is needed here, at least for the debugging use-case.

WDYT?

