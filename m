Return-Path: <netdev+bounces-45476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB647DD6CC
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 20:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0BE2813B7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 19:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C622335;
	Tue, 31 Oct 2023 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwvqM/vx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F41D525;
	Tue, 31 Oct 2023 19:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF144C433C7;
	Tue, 31 Oct 2023 19:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698782029;
	bh=2oK9cLvx1sCDZNWlQ8YmD9XkYwVk52IAfb2GSyqsfFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwvqM/vxLUku3QjCdu5Eg5XrdhSYkBdWRjg6HQB1qwynnRUbLEWDc32mkIePftzyi
	 lFVKmTxwmx5EyhzaY4tGlPHsV3Ge48WSUYThxF/cNjNz7cwLdnFn8UrqVq+o2rcV9b
	 Ffeuq9d+6GOK7QS2GLyLIjtcGkc6H/Ljro0eQ5MQeKVwtpCnOCLqjaedYXcZ1yiL1q
	 erE2ddwGXYHUaOmMfkC6wPqyPzNz8yasVZebpG67Rz5avikUKUAPeYJCGXo3N2By7k
	 E3TOpljh28b3s/Y9344i7pf0JWj8kX5I7fmbVzAo3QKIN1ND1HEy3VtVKhu3ZhgqMc
	 pGcw9rVhTxRiw==
Date: Tue, 31 Oct 2023 12:53:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peilin Ye <yepeilin.cs@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Peilin Ye
 <peilin.ye@bytedance.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>, Jiang
 Wang <jiang.wang@bytedance.com>, Youlun Zhang <zhangyoulun@bytedance.com>
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
Message-ID: <20231031125348.70fc975e@kernel.org>
In-Reply-To: <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
	<20231027190254.GA88444@n191-129-154.byted.org>
	<59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
	<20231028231135.GA2236124@n191-129-154.byted.org>
	<94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 15:19:26 +0100 Daniel Borkmann wrote:
> > Since I didn't want to update host-veth's TX counters.  If we
> > bpf_redirect_peer()ed a packet from NIC TC ingress to Pod-veth TC ingress,
> > I think it means we've bypassed host-veth TX?  
> 
> Yes. So the idea is to transition to tstats replace the location where
> we used to bump lstats with tstat's tx counter, and only the peer redirect
> would bump the rx counter.. then upon stats traversal we fold the latter into
> the rx stats which was populated by the opposite's tx counters. Makes sense.
> 
> OT: does cadvisor run inside the Pod to collect the device stats? Just
> curious how it gathers them.

Somewhat related - where does netkit count stats?

> >> Definitely no new stats ndo resp indirect call in fast path.  
> > 
> > Yeah, I think I'll put a comment saying that all devices that support
> > BPF_F_PEER must use tstats (or must use lstats), then.  
> 
> sgtm.

Is comment good enough? Can we try to do something more robust?
Move the allocation of stats into the core at registration based 
on some u8 assigned in the driver? (I haven't looked at the code TBH)

