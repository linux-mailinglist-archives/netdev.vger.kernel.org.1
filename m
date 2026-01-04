Return-Path: <netdev+bounces-246780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47FCF126B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 17:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477EF3004CDA
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AB283FD9;
	Sun,  4 Jan 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+hAgoJT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0F235BE2;
	Sun,  4 Jan 2026 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767545030; cv=none; b=uR/qxmFCsk7ZI4j7j+V5rkv2ptkwSTeJ49bDtGa4xhXg/F/CrUYzUmqbzNbVS51TbepAG5filbu9IKflhX6WTLBA1x4DZip7rZ1Vi4UzUs4SfTTKHVFqDgf1m/b7TxyggX6zkAPrNTXGjF6BJRxuK9VcRKp9kSWZeoIJnbDONzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767545030; c=relaxed/simple;
	bh=AqzuhN55ZaaCJw1PTFBjT0AsN7LhAyrG2IsV5tfNyMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4KOVxaRSid61ZqqOxHl0ocoMmEpE9EXCTELCGwbsrRU4iIQJVoIfNk+rIJJaX5EMlm2NzrmmsSEosEE6rba0jsjYlQLdvnRuODXh1fqEGuwHtuP9CmF8titb1ANKcrDdl4wwRXO+ApHQhDc2ZzYIGu5w6P4GW7126+GsRUcrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+hAgoJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99239C4CEF7;
	Sun,  4 Jan 2026 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767545029;
	bh=AqzuhN55ZaaCJw1PTFBjT0AsN7LhAyrG2IsV5tfNyMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+hAgoJTTM0+4P2t6YJZLYzP1IwH7RrKnfcbordv/AC2HlaEIxIQ6UyMt8052CoeM
	 P9EDJm92gr9VzrhyfSbvCJ7uPMshyPhrc3mfDsuBs7PmBTePPnDxxR3px7uKty3SCB
	 PDN+LfBgUWvPm5TL1f61KSBjC4y8pMBWP11cOUIXsqyDbr0QlMWL8IUeE9sLQv0qEV
	 IpB8c8u+13/NrHJTS7vyUx/qc2kQjP1Gn8rEp2AoRoclXiH5TFeM6vbeV0C+xwOqZr
	 5DGWn2my+pXoM92hYFbyI4u2HzZthwktXu/xQiX9Rg7eDXHIBr2fE7/UicGwgNdl7c
	 qR6IJxKnFS18w==
Date: Sun, 4 Jan 2026 08:43:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH net-next v3] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20260104084347.5de3a537@kernel.org>
In-Reply-To: <011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
References: <20260102071745.291969-1-leon.hwang@linux.dev>
	<011ca15e-107b-4679-8203-f5f821f27900@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 12:43:46 +0100 Jesper Dangaard Brouer wrote:
> On 02/01/2026 08.17, Leon Hwang wrote:
> > Introduce a new tracepoint to track stalled page pool releases,
> > providing better observability for page pool lifecycle issues.
> 
> In general I like/support adding this tracepoint for "debugability" of
> page pool lifecycle issues.
> 
> For "observability" @Kuba added a netlink scheme[1][2] for page_pool[3], 
> which gives us the ability to get events and list page_pools from userspace.
> I've not used this myself (yet) so I need input from others if this is 
> something that others have been using for page pool lifecycle issues?

My input here is the least valuable (since one may expect the person
who added the code uses it) - but FWIW yes, we do use the PP stats to
monitor PP lifecycle issues at Meta. That said - we only monitor for
accumulation of leaked memory from orphaned pages, as the whole reason
for adding this code was that in practice the page may be sitting in
a socket rx queue (or defer free queue etc.) IOW a PP which is not
getting destroyed for a long time is not necessarily a kernel issue.

> Need input from @Kuba/others as the "page-pool-get"[4] state that "Only 
> Page Pools associated with a net_device can be listed".  Don't we want 
> the ability to list "invisible" page_pool's to allow debugging issues?
> 
>   [1] https://docs.kernel.org/userspace-api/netlink/intro-specs.html
>   [2] https://docs.kernel.org/userspace-api/netlink/index.html
>   [3] https://docs.kernel.org/netlink/specs/netdev.html
>   [4] https://docs.kernel.org/netlink/specs/netdev.html#page-pool-get

The documentation should probably be updated :(
I think what I meant is that most _drivers_ didn't link their PP to the
netdev via params when the API was added. So if the user doesn't see the
page pools - the driver is probably not well maintained.

In practice only page pools which are not accessible / visible via the
API are page pools from already destroyed network namespaces (assuming
their netdevs were also destroyed and not re-parented to init_net).
Which I'd think is a rare case?

> Looking at the code, I see that NETDEV_CMD_PAGE_POOL_CHANGE_NTF netlink
> notification is only generated once (in page_pool_destroy) and not when
> we retry in page_pool_release_retry (like this patch).  In that sense,
> this patch/tracepoint is catching something more than netlink provides.
> First I though we could add a netlink notification, but I can imagine
> cases this could generate too many netlink messages e.g. a netdev with
> 128 RX queues generating these every second for every RX queue.

FWIW yes, we can add more notifications. Tho, as I mentioned at the
start of my reply - the expectation is that page pools waiting for
a long time to be destroyed is something that _will_ happen in
production.

> Guess, I've talked myself into liking this change, what do other
> maintainers think?  (e.g. netlink scheme and debugging balance)

We added the Netlink API to mute the pr_warn() in all practical cases.
If Xiang Mei is seeing the pr_warn() I think we should start by asking
what kernel and driver they are using, and what the usage pattern is :(
As I mentioned most commonly the pr_warn() will trigger because driver
doesn't link the pp to a netdev.

