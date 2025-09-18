Return-Path: <netdev+bounces-213816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B43B26DE9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2093BE593
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598130E0C4;
	Thu, 14 Aug 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O3Hvbk99"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906522D7B6
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193450; cv=none; b=fZ97IXenBqgLQ9hqXk/UYb6gE4NgBkg7HhJ+qQYC+7vc31LzKXSrMEpuaqzl9JNvmMboohwavn59C24iI8NLEjR6VXKHxjnEY7Z3hn4Kh0xtihxEBBem8e9sAVq3lVnlxEgznu/XsiX30+n1w09JPXTCKXox6zJ1EIXov4nMV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193450; c=relaxed/simple;
	bh=VrLqtK6VPEFLX0UXMEQTYpnpDohw/mLwThy9iiZZy7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li5AnztxANvs91eYF7EzJT4zvNTvbfwWBXgfQ9Z4Nm+CUu7+hRDhTPgSKtXU9qUXVbOSquW9Laq7+Cnbs7a2c3v8XBqxWdxHlmuFoqRWFp8K0KLw0xl/9+lEEzV4wNVa6Bx3wQsjkn7laQqpLJG5bYQozW4fC2MF3JcQtTX8mLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O3Hvbk99; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 10:43:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755193443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPqZ11vpcoRklz9QYq4kh+2Xloc1crac2d4cWurYTAw=;
	b=O3Hvbk99j9KPxhil/aCjUAoy8Wol7HQP4nDBpa3lCDAejGlYIDhslkt4pnJIi5IGTLLrdL
	r/FzL5iuW4xHMETt0+kz+unxWqQZHb55cbmw7dZMuOK9O+66fAyq9rqb9Y9oz+IQcMOiY6
	59/FNZI76uv8vm4442ykA6BSbdL7z5w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matyas Hurtik <matyas.hurtik@cdn77.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <heh23oulcubeuqssykmb6i6uh3vazzpmcymqhi7kif4i26waij@pttojulkfgzk>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
 <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
 <0f6a8c37-95e0-4009-a13b-99ce0e25ea47@cdn77.com>
 <qsncixzj7s7jd7f3l2erjjs7cx3fanmlbkh4auaapsvon45rx3@62o2nqwrb43e>
 <4937aca8-8ebb-47d5-986f-7bb27ddbdaba@cdn77.com>
 <okedwjaepuw2b55eki6zyn6l3ngstmml2amoebyvc4orzsxqjs@45tbzonckct5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <okedwjaepuw2b55eki6zyn6l3ngstmml2amoebyvc4orzsxqjs@45tbzonckct5>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 10:31:39AM -0700, Shakeel Butt wrote:
> On Thu, Aug 14, 2025 at 06:27:22PM +0200, Matyas Hurtik wrote:
> > On 8/7/25 10:52 PM, Shakeel Butt wrote:
> > 
> > > We definitely don't need a global lock. For memcg->net_pressure_lock, we
> > > need to be very clear why we need this lock. Basically we are doing RMW
> > > on memcg->socket_pressure and we want known 'consistently' how much
> > > further we are pushing memcg->socket_pressure. In other words the
> > > consistent value of diff. The lock is one way to get that consistent
> > > diff. We can also play some atomic ops trick to get the consistent value
> > > without lock but I don't think that complexity is worth it.
> > 
> > Hello,
> > 
> > 
> > I tried implementing the second option, making the diff consistent using
> > atomics.
> > Would something like this work?
> > 
> > if (level > VMPRESSURE_LOW) {
> >   unsigned long new_socket_pressure;
> >   unsigned long old_socket_pressure;
> >   unsigned long duration_to_add;
> >   /*
> >     * Let the socket buffer allocator know that
> >     * we are having trouble reclaiming LRU pages.
> >     *
> >     * For hysteresis keep the pressure state
> >     * asserted for a second in which subsequent
> >     * pressure events can occur.
> >     */
> >   new_socket_pressure = jiffies + HZ;
> 
> Add an if condition here if old_socket_pressure is already equal to
> the new_socket_pressure and skip all of the following.
> 
> >   old_socket_pressure = atomic_long_xchg(
> >     &memcg->socket_pressure, new_socket_pressure);
> > 
> >   duration_to_add = jiffies_to_usecs(

One more point, this jiffies_to_usecs() can be done at the read side
i.e. keep socket_pressure_duration in jiffies.

Also TJ suggested to expose this new stat in memory.stat. That will be
easy by just adding seq_buf_printf() at the end of memcg_stat_format().


