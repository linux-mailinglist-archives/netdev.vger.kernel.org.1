Return-Path: <netdev+bounces-215388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1EB2E5A4
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BE25E2C16
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96825FA29;
	Wed, 20 Aug 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AM8PeyYU"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72836CE0C
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718347; cv=none; b=hBgt02MeiSPEfLvpLOFKUarjJXnkXWQ5p/C+VVjIUMZsy208dwG+oD9G8BJQa/rKs4MadUzvbK19qgItBN21ds90Dax9FEFhGcVwmxBLeGkHN0efLXdYXJaBxY3nGewxtpqgc81dFJqkbWnf8i5a5dYtK/RJzs9aJ4kEx3vNvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718347; c=relaxed/simple;
	bh=fTIxBTLa4wOFkN+npnEUXHvJzyECweac9e5WGMHnblY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT9vVKU/5o55tkzMtTIBMnuEEpMlsrj0etYMREBpNrjnNzVa74vxCkgCXkBoCYgKgy1Y+aTTm1QnemUS7MxvuGvCv0YuZcNcnTQMjMFuWpK6QnPrD4Fz/Xwu5soOxLs0P2P5yq9x7LRIQxWzOTtB4W4ethhev+jjFFaQbYUU3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AM8PeyYU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 12:31:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755718329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOyuOaWYAFtKnuh/JpQ9JhhAptxR93x2Tx2hSXqcNWA=;
	b=AM8PeyYUIFxQSds2E1ti4q5gOD0Jo2OmKPSyT2r4q5JOB5E5vzCXxr5kEY6Onf4RejPq3n
	cNjwZ9xAAsLJahg8aYdLCnre/a9sjbjNbhyy1+bcKBxa7ADpHa7QnKcZKDMJiFOr2CkrFJ
	xdnVBIDDbLgfn/ccp94IvkMfvAPIKUA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Matyas Hurtik <matyas.hurtik@cdn77.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <zldrraxaeff5gaffaltgzmnsgc7kvnlltubkaury3mhqlfmgwp@jinkxqagerjy>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
 <aJzTeyRTu_sfm-9R@slm.duckdns.org>
 <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
 <aKYb7_xshbtFbXjb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKYb7_xshbtFbXjb@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 09:03:11AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 20, 2025 at 06:51:07PM +0200, Matyas Hurtik wrote:
> ...
> > And the read side:
> >   total_duration = 0;
> >   for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
> >     total_duration += atomic_long_read(&memcg->socket_pressure_duration);
> > Would that work?
> 
> This doesn't make sense to me. Why would a child report the numbers from its
> ancestors?

I think Matyas might wanted to do a tree traversal under the given memcg
and by mistake did this upward traversal. However that will miss the
already deleted memcgs under the given memcg.

