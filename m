Return-Path: <netdev+bounces-209089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C2B0E3DA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3151C8420A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A3280CC9;
	Tue, 22 Jul 2025 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bsjxRM8W"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00427F18B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211152; cv=none; b=h71kkTiDCbVXKsGAgnK7jbwpn15QTIhmTOa3vPIoUva2a1OFLKijauUujf41+aPma4JDnrrF8jhl9NEE3rWHHJmcno+s8RHdP/iWpDwPskvVEU7kuG6Bf2ST07hIuagYV4uGqmeTdu5jwKDh1DXHUaOurVtjzlcl4yayEySuyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211152; c=relaxed/simple;
	bh=T5NMkizmECXIX8UgoMKkY7obBeJloNgRGmuTwj+0xbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6abMgChlzfO74lti2Jjdt6UjD2XzUF2iQLvwIhC3PSS/hLsRFEhRLnHHVgaSjgWls3CbgdjwA3WxzY7f1rfxKttKJnU/1I9NdMHckIxgEhdRVXw7hDNj5C1hVRkyh4Tn7+0r0xDvKDqj7ZeR2d8mMbfRxfcDvTADtwR3PJgSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bsjxRM8W; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 12:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753211148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YR5doc3ubATFIwFqCTAQj7mEB5SIW2AFvm6iIjBaed8=;
	b=bsjxRM8WfX6Y/hUmZzPYJH3CThZq9cHvRIsrKdAIOKH6kYfPmQQU3ccX6o8xRli3BDvuGX
	H1X1NqHpg0kyCmcreBFRHAoB2aeNqGSWfxXWU9nIMgHnMgWk6BPAacJJ2q3d35iSWiDNHp
	gY0xmbFWlTp6IyWIv9lYzxOQmqBIka0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 11:27:39AM -0700, Kuniyuki Iwashima wrote:
> On Tue, Jul 22, 2025 at 10:50 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutný wrote:
> > > Hello Daniel.
> > >
> > > On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
> > > >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > > >
> > > > The output value is an integer matching the internal semantics of the
> > > > struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
> > > > representing the end of the said socket memory pressure, and once the
> > > > clock is re-armed it is set to jiffies + HZ.
> > >
> > > I don't find it ideal to expose this value in its raw form that is
> > > rather an implementation detail.
> > >
> > > IIUC, the information is possibly valid only during one jiffy interval.
> > > How would be the userspace consuming this?
> > >
> > > I'd consider exposing this as a cummulative counter in memory.stat for
> > > simplicity (or possibly cummulative time spent in the pressure
> > > condition).
> > >
> > > Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
> > > thought it's kind of legacy.
> >
> >
> > Yes vmpressure is legacy and we should not expose raw underlying number
> > to the userspace. How about just 0 or 1 and use
> > mem_cgroup_under_socket_pressure() underlying? In future if we change
> > the underlying implementation, the output of this interface should be
> > consistent.
> 
> But this is available only for 1 second, and it will not be useful
> except for live debugging ?

1 second is the current implementation and it can be more if the memcg
remains in memory pressure. Regarding usefullness I think the periodic
stat collectors (like cadvisor or Google's internal borglet+rumbo) would
be interested in scraping this interface. If this is still not useful,
what will be better? Some kind of trace which tracks the state of socket
pressure state of a memcg (i.e. going into and out of pressure)?

