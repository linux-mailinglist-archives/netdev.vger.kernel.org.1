Return-Path: <netdev+bounces-211986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4824FB1CEB2
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1731E189A59D
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE558225417;
	Wed,  6 Aug 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/YrO4X/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81B2B2D7
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517289; cv=none; b=OJ2B7wJDpBXIfZRXTEF85B74j7YwYbDjXMfIzS7M92NG3Nt9mkbALHnl/6cfCLixZVqZdTXgYOdmlcMRpXsObkQfKANbx1ZbIfoGO/kWfvwKuxYgIqsTTOZC1eZTwgawHE7/kplNvpC2gJMCSC0LZZPNr5nq+TDeNSiMDkLO70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517289; c=relaxed/simple;
	bh=Gc8IASkxveL30J2qUsdUS0ocB1fyU+yK3Khn0WshAro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqQ/S96j1Y47Zh8Fk9Ei/z5Z30kS5bzrEt4YmOmsGcXf/RmWCpBLqQRPK4ovjL87dL8fBEweTKNmyekFDq8gjUy7zMpeww3TodI6JFaHET+KsswFPLYD3pzQAy3QRkJ5910aq3mU3FVkOCudzFJl2Aydm+rrIeVbDyuzIODi76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/YrO4X/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 14:54:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754517284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FroE7+qI9Ws4d3iwncGRIwScgg54/aqmzkwV6db+qLE=;
	b=M/YrO4X/uY1dXXir3zZ9a3prwZFo4vvvo/bxNJD3qVEX++L1F9Qr6UqFtm6JJAPgTvQ3Sa
	VNSzm5l5hh34xnTOEDBOgRpAkghQeTjJb9UpdIT76VIuSt6yKlfYj/YfQgu34PCDSEsrC9
	fVWa1H7e/q1UughGACwJiKKyAr6kQ6w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > -                     WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> > > +                     socket_pressure = jiffies + HZ;
> > > +
> > > +                     jiffies_diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
> > > +                     memcg->socket_pressure_duration += jiffies_to_usecs(jiffies_diff);
> >
> > KCSAN will complain about this. I think we can use atomic_long_add() and
> > don't need the one with strict ordering.
> 
> Assuming from atomic_ that vmpressure() could be called concurrently
> for the same memcg, should we protect socket_pressure and duration
> within the same lock instead of mixing WRITE/READ_ONCE() and
> atomic?  Otherwise jiffies_diff could be incorrect (the error is smaller
> than HZ though).
> 

Yeah good point. Also this field needs to be hierarchical. So, with lock
something like following is needed:

	if (!spin_trylock(memcg->net_pressure_lock))
		return;
	
	socket_pressure = jiffies + HZ;
	diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);

	if (diff) {
		WRITE_ONCE(memcg->socket_pressure, socket_pressure);
		// mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
		// OR
		// while (memcg) {
		//	memcg->sk_pressure_duration += diff;
		//	memcg = parent_mem_cgroup(memcg);
		// }
	}

	spin_unlock(memcg->net_pressure_lock);

Regarding the hierarchical, we can avoid rstat infra as this code path
is not really performance critical. 

