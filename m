Return-Path: <netdev+bounces-215404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49AB2E78D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005607B74C8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 21:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37DC258ECB;
	Wed, 20 Aug 2025 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NNQ05Mdu"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FF1DB154
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725683; cv=none; b=aPD5xPC46uIsjBZRPC/0vB9vsBNKes4mjW/HRecGEhxCwCZ6lD2UPoKPmnpXNd/0LX512o1tBLiIvAvRQO0941jbHQgD9sAxBQyWS9cZ5kN1dt21FfF0so4g6ldMhslVXL7CYHN03S2hGy7vj3EVtpIP2Iacdl5uXALFEDUVJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725683; c=relaxed/simple;
	bh=X/KkpmLbn4F5MP7wCou9O6AcaiHjVgcH3CgN8fhMs1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWBhTWhFUp9hspVZWbvmaouMYD7o3e+K4xjIusif6O25458EsuEeeYanS/W1F/p8PZmSlOOc16qM4Oxa3n3v+Jo5MUm1UYpagyqSyP+LgJSsx2ayn2cYKNNGudRPKPNKHdP8TJiDfcv9hnIsRTvtJuiIgK/AfemL5Ngn6r7etL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NNQ05Mdu; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 14:34:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755725679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PM4zc6JuUjs9DXSdg1cZOgc0LHF7QtVILQ3VPU4Ih/8=;
	b=NNQ05MduTzCaRYI9uiMb7owIrlzEL1YD/MvexojLbiozG6JxgMI58P+bKk4ZGymiCm0Cp0
	UcJ3Lmrcrf7o5ltnSE+CU1DdPSXFMbdsWQ1/9NtCpn1//ftaB4Gc3fByz0lVo+9Dgs0Fp8
	a2Lf4TnQry6HsMT23aHSrgSHvx+V3oM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matyas Hurtik <matyas.hurtik@cdn77.com>
Cc: Tejun Heo <tj@kernel.org>, 
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
Message-ID: <kyy6mxg4g6aer2mht3xawiq56ytveg7vllg7o6f7dgivkoh52z@ccinqivomtyl>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
 <aJzTeyRTu_sfm-9R@slm.duckdns.org>
 <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
 <aKYb7_xshbtFbXjb@slm.duckdns.org>
 <fa039702-3d60-4dc0-803a-b094b41fd2b9@cdn77.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa039702-3d60-4dc0-803a-b094b41fd2b9@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 10:37:49PM +0200, Matyas Hurtik wrote:
> Hello,
> 
> On 8/20/25 9:03 PM, Tejun Heo wrote:
> > On Wed, Aug 20, 2025 at 06:51:07PM +0200, Matyas Hurtik wrote:
> > > And the read side:   total_duration = 0;   for (;
> > > !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))    
> > > total_duration +=
> > > atomic_long_read(&memcg->socket_pressure_duration); Would that work?
> > This doesn't make sense to me. Why would a child report the numbers from
> > its ancestors?
> 
> Result of mem_cgroup_under_socket_pressure() depends on
> whether self or any ancestors have had socket_pressure set.
> 
> So any duration of an ancestor being throttled would also
> mean the child was being throttled.
> 
> By summing our and our ancestors socket_pressure_duration
> we should get our total time being throttled
> (possibly more because of overlaps).

This is not how memcg stats (and their semantics) work and maybe that is
not what you want. In the memcg stats semactics for a given memcg the
socket_pressure_duration metric is not the stall duration faced by
sockets in memcg but instead it will be stall duration caused by the
memcg and its descendants. If that is not what we want, we need to do
something different and orthogonal to memcg stats.

