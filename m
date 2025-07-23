Return-Path: <netdev+bounces-209462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B78B0F9C2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5965B7AFE56
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE5223328;
	Wed, 23 Jul 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UO7tdZ57"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68D223704
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293276; cv=none; b=JgO4jbHznVQh6RuMAuwz5N2RPzTrYjbd0KTTWUBmV4wMDgi+VTT1TazIwINK90Rdy6bus+IS+XkcXSvxZhzgN/JVxCsbuDcvZLQBusOuldihFht6Nr9Pri/CUNfm1tYXPKK9MDqEfi+Aq26Z8TNosfRG3nFFeUOtbRN4cIbuTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293276; c=relaxed/simple;
	bh=rXuKXuJt+U9u59jPG5MBC7r2aKN9kiZFqfYauJjLZQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSiUCsixgO9qHExLybTur9ujSztcUP01qf1lNusDo4iPfQperxQ2A+NPg8tj4iJNeIgQrbdXgpRcdB9Ig9ETBcyWRHazAHAKBovHEmnGWTxp6E+rE/wErpc0OwPC9bmnxCBJEJjkWI6IerHRFzB3vD49iaEaGfXY+cyMMjBEstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UO7tdZ57; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Jul 2025 10:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753293262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Gwff2VE8d4007wYdTiGPmJ4gJfFC6HAzVdL8zXdtRw=;
	b=UO7tdZ57wlRfHAi9qqc4+fBjZIliVIfL8CcZnGE7Dt4F/OxBOsALVh2F/P3WDk69tO2UKS
	8+Sc7TpBfq+LtvQPupBRgAwJ/feO/lVwEvRhBhkS7ES0uhxldk5zZvH5sUCQBMLqoMrmQ7
	n4l+H/rXj7gJ/r4fe31yB6uWoKsF45Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <irvyenjca4czrxfew4c7nc23luo5ybgdw3lquq7aoadmhmfu6h@h4mx532ls26h>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
 <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
 <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 23, 2025 at 10:58:10AM +0200, Daniel Sedlak wrote:
> On 7/23/25 10:38 AM, Michal Koutný wrote:
> > On Tue, Jul 22, 2025 at 01:11:05PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > > 1 second is the current implementation and it can be more if the memcg
> > > > > remains in memory pressure. Regarding usefullness I think the periodic
> > > > > stat collectors (like cadvisor or Google's internal borglet+rumbo) would
> > > > > be interested in scraping this interface.
> > > > 
> > > > I think the cumulative counter suggested above is better at least.
> > > 
> > > It is tied to the underlying implementation. If we decide to use, for
> > > example, PSI in future, what should this interface show?
> > 
> > Actually, if it was exposed as cummulative time under pressure (not
> > cummulative events), that's quite similar to PSI.
> 
> I think overall the cumulative counter is better than just signaling 1 or 0,
> but it lacks the time information (if not scraped periodically). In
> addition, it may oscillate between under_pressure=true/false rather quickly
> so the cumulative counter would catch this.

Yes cumulative counter would not miss small bursts.

> 
> To me, introducing the new PSI for sockets (like for CPU, IO, memory), would
> be slightly better than cumulative counter because PSI can have the timing
> information without frequent periodic scrapes. So it may help with live
> debugs.

How would this PSI for sockets work? What would be the entry and exit
points?

> 
> However, if we were to just add a new counter to the memory.stat in each
> cgroup, then it would be easier to do so?

