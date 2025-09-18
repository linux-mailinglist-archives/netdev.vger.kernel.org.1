Return-Path: <netdev+bounces-212615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AFEB21774
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD211732CA
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3512E5407;
	Mon, 11 Aug 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GCBeBJmt"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A32E338F
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947908; cv=none; b=Tb3zYiysG71xp3ItZ2/6yV64yLb8sR7etDskyIi7ZpZXcJe6xU5qzvGD9TCK9aBfz69H4TQInX7BKupP1+WMAU7Z/RhKwiwOLUv/RJnMayJCdfFLOU8VTIYs4WPcnaT93ZO6xJ3k/Cx4woKm0QH1sQGsq8rrSfKmvFE8sVyumz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947908; c=relaxed/simple;
	bh=RS5sFWaoZzHOwceC2btElDBf3P8I0UOMIzGHfWcVc8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIUveFpCwn/8QIKHhGIOsjPJAAJ0PayiQ3JVIdKUKduA3Wicy+lYYToimmSRukdlvMIQbZeDD+KdU7zAgjjYnxKWxl0vzv3T6ZdLlsB3x4uND3pIoBOWgRpD0AKJFogOQI5IpITLZVxE45EuwUYLR7pP+sQ9VabUq5FGqq9vXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GCBeBJmt; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Aug 2025 14:31:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754947893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mmwYpasJW0d8pQJPWzSNzQnwsfBE31Dbtu9ygTvRtHI=;
	b=GCBeBJmti4GhQF/v9x3g0yrh7KOUcwYuUIOw+XnLyYUQ0v7R6os5PdkLj2YRHuqj5LJVkJ
	mrztlFNm9OpKrG8JLm/MWVHCqC8c3HST/Wk+ENEhGfl/g7n9+C+4iD9JYKPs30Pz3TnP9e
	y2Tcf/noENLxElI6awRqGD6/JvuDwWA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <kiqfxuepou5lwqffxhdshau5lw6bkkrvshv4ekhvrmugweipau@rreefm2uttjp>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJeUNqwzRuc8N08y@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 09, 2025 at 08:32:22AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 05, 2025 at 08:44:29AM +0200, Daniel Sedlak wrote:
> > This patch exposes a new file for each cgroup in sysfs which signals
> > the cgroup socket memory pressure. The file is accessible in
> > the following path.
> > 
> >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > 
> > The output value is a cumulative sum of microseconds spent
> > under pressure for that particular cgroup.
> 
> I'm not sure the pressure name fits the best when the content is the
> duration. Note that in the memory.pressure file, the main content is
> time-averaged percentages which are the "pressure" numbers. Can this be an
> entry in memory.stat which signifies that it's a duration? net_throttle_us
> or something like that?

Good point and this can definitely be a metric exposed through
memory.stat. At the moment the metrics in memory.stat are either amount
of bytes or number of pages. Time duration would be the first one and
will need some work to make it part of rstat or we can explore to keep
this separate from rstat with manual upward sync on update side as it is
not performance critical (the read side seems performance critical for
this stat).

