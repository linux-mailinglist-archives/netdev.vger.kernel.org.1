Return-Path: <netdev+bounces-173097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA6A572D1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 21:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405F3189B8A4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA12500CE;
	Fri,  7 Mar 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRi42CuO"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F121A5B8C
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378387; cv=none; b=g/Y0R+LnCS4dRQIy/InfqwEmzGautXnWHMRcHrAOfvdrGOBQI67uB4ft/qBQsncIj56stoxnFh7EtXx+YpzFxKgJmZuY32UXTZvsR5Vk94rbA+7/2WHy7TkfdfKukysKLP3FEqlcc/XeqlPEF/FtkCvYCJrQLofeF3tHhDxEkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378387; c=relaxed/simple;
	bh=i4tXWbK2Su3es/UUrOMUUWCh7h0iXBpxDBqUtqDrJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCMWtA2rt8uA0rfhavnW57YSLFHiIDW4F7o+eOXRA1AJTWwLDBrdVriXA/6uZcse48FPdOJfsumFAvD/19D6muejP2PmTn81LzwztIptXBHi+sAx43Jcos7ENF+uHSc39ZEyHg/nYpNFG1QaxS/VEGpb/sb2mIroqyCdC8sq42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRi42CuO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 12:12:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741378381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YljDuPqUyrSKj1qY6CTlyxawJAoX4glZcEt/JKL20jE=;
	b=cRi42CuORB2PT/6TuaBDeboPqIk1v1v+grz2MHaj4U6p5d4n8CFV1S3qgY+8frY05pdVhN
	Sf+vXMzBmP1jsidnwGDqehrbtzS0KMNx1xt2mwVMeA66NIUE6gUdCdO6BVtVI5ufuf4mPQ
	JU/fYuTQ/0fd6LbVAuRTsa/vx0qT6mc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] memcg: net: improve charging of incoming network
 traffic
Message-ID: <dpnv6luzeby3wni3jlcv2utgx4ozfp5zl3zfnhn2shv3q4iejz@sbex7f6azcpc>
References: <20250307055936.3988572-1-shakeel.butt@linux.dev>
 <Z8tMB4i_hBLaSZS1@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tMB4i_hBLaSZS1@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 07, 2025 at 07:41:59PM +0000, Yosry Ahmed wrote:
> On Thu, Mar 06, 2025 at 09:59:36PM -0800, Shakeel Butt wrote:
> > Memory cgroup accounting is expensive and to reduce the cost, the kernel
> > maintains per-cpu charge cache for a single memcg. So, if a charge
> > request comes for a different memcg, the kernel will flush the old
> > memcg's charge cache and then charge the newer memcg a fixed amount (64
> > pages), subtracts the charge request amount and stores the remaining in
> > the per-cpu charge cache for the newer memcg.
> > 
> > This mechanism is based on the assumption that the kernel, for locality,
> > keep a process on a CPU for long period of time and most of the charge
> > requests from that process will be served by that CPU's local charge
> > cache.
> > 
> > However this assumption breaks down for incoming network traffic in a
> > multi-tenant machine. We are in the process of running multiple
> > workloads on a single machine and if such workloads are network heavy,
> > we are seeing very high network memory accounting cost. We have observed
> > multiple CPUs spending almost 100% of their time in net_rx_action and
> > almost all of that time is spent in memcg accounting of the network
> > traffic.
> > 
> > More precisely, net_rx_action is serving packets from multiple workloads
> > and is observing/serving mix of packets of these workloads. The memcg
> > switch of per-cpu cache is very expensive and we are observing a lot of
> > memcg switches on the machine. Almost all the time is being spent on
> > charging new memcg and flushing older memcg cache. So, definitely we
> > need per-cpu cache that support multiple memcgs for this scenario.
> 
> We've internally faced a different situation on machines with a large
> number of CPUs where the mod_memcg_state(MEMCG_SOCK) call in
> mem_cgroup_[un]charge_skmem() causes latency due to high contention on
> the atomic update in memcg_rstat_updated().

Interesting. At Meta, we are not seeing the latency issue due to
memcg_rstat_updated() but it is one of most expensive function in our
fleet and optimizing it is in our plan.

> 
> In this case, networking performs a lot of charge/uncharge operations,
> but because we count the absolute magnitude updates in
> memcg_rstat_updated(), we reach the threshold quickly. In practice, a
> lot of these updates cancel each other out so the net change in the
> stats may not be that large.
> 
> However, not using the absolute value of the updates could cause stat
> updates of irrelevant stats with opposite polarity to cancel out,
> potentially delaying stat updates.
> 
> I wonder if we can leverage the batching introduced here to fix this
> problem as well. For example, if the charging in
> mem_cgroup_[un]charge_skmem() is satisfied from this catch, can we avoid
> mod_memcg_state() and only update the stats once at the end of batching?
> 
> IIUC the current implementation only covers the RX path, so it will
> reduce the number of calls to mod_memcg_state(), but it won't prevent
> charge/uncharge operations from raising the update counter
> unnecessarily. I wonder if the scope of the batching could be increased
> so that both TX and RX use the same cache, and charge/uncharge
> operations cancel out completely in terms of stat updates.
> 
> WDYT?

JP (CCed) is currently working on collecting data from our fleet to find
the hotest memcg stats i.e. with the most updates. I think the early
data show MEMCG_SOCK and MEMCG_KMEM are among the hot ones. JP has
couple of ideas to improve the situation here which he will experiment
with and share in due time.

Regarding batching for TX and RX, my intention is to keep the charge
batching general purpose but I think the batching the MEMCG_SOCK for
networking with a scoping API can be done and seems like a good idea. I
will do that in the followup.

Thanks for taking a look.




