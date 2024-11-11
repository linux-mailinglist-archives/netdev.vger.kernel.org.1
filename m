Return-Path: <netdev+bounces-143881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A49C49E7
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70EA1F23043
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B91BD4F7;
	Mon, 11 Nov 2024 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQiEpvfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE721A76B5;
	Mon, 11 Nov 2024 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368548; cv=none; b=rNDezach6Ln0+ebQPsoZdThWSKYJEdhDgGCptvefw2dk2+4tyAnL82vWpSwxOewGm1WBRBV6Ym9l3e73ppUrZ3M4AlZ+j/OZjauMEnJZLSpURm+4fvD71bvTORNWa675r6+qU6n8RmroCFDmKUHMoO7jZhzOPfxn8MD/m3Fs4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368548; c=relaxed/simple;
	bh=lx/uf1XCOtyzWrRpHbiiJq4DmrN5aJ/7b3JcX4BHNag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqWB8lmkyrMtPW+JRCb1sTrl72JE1iKgcnRpnocFF6c8xwfUMgP4aa9DcL8kfA/5Wz1bVJ3aVwWD3G+xZJL6mkoTFbxgf0Ux5vDo2colojuM2HWuyvarlId620tJRYPUn4etf0VIzNQaFTtSNMnVW0FqbuqQkoXW24NzWda3Po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQiEpvfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93DC4CECF;
	Mon, 11 Nov 2024 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731368548;
	bh=lx/uf1XCOtyzWrRpHbiiJq4DmrN5aJ/7b3JcX4BHNag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQiEpvfUcNEPRXW31BV/pD6xyZ8tn83MIkuEvYxjqhbPUv31TbZiu2wvzpXrw82Qt
	 DOQhv1t/uRMMHCwYEV8vVQ8Bvgq26Pd9C+R+7yE30NcIrWy0FjRZrPfSf9AUnx4iP/
	 PhpNOem7AwnFimqdHo4a5o8deFUw2rqBzPo8oxQYN9Lsm1EV7hJnaXT7efbzygV91F
	 NK5Ewc7U9T+tlck/C5PHQPMcubjbde13KlDJdM4SIysA1IoKxgBsicEbUpDQa4J+OO
	 GNSFzYdodr7u4GC8i5oNGCjxJNHEbp6oJqRF2RpX2sLGowebHznGXSGSial5zsv5/q
	 JMU6U90h1VsLQ==
Date: Mon, 11 Nov 2024 15:42:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module
 parameter
Message-ID: <20241111154226.5d7b29bf@kernel.org>
In-Reply-To: <CABAhCOQPw0zR1Cn7RoabjA0P-Onmpq_4jLgmtkTYpfZbFAOoGQ@mail.gmail.com>
References: <20241107133004.7469-1-shaw.leon@gmail.com>
	<20241107133004.7469-6-shaw.leon@gmail.com>
	<CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
	<CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
	<20241107075943.78bb160c@kernel.org>
	<CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
	<20241107200410.4126cf52@kernel.org>
	<CABAhCOSyG6sTWfDfoYDCbiXesDbGiWYFrK4OGi+3zFgO-CZPxA@mail.gmail.com>
	<20241109165907.4e9611a9@kernel.org>
	<CABAhCOQPw0zR1Cn7RoabjA0P-Onmpq_4jLgmtkTYpfZbFAOoGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 16:15:41 +0800 Xiao Liang wrote:
> > Let's start with annotating the drivers which need the old behavior.
> > It seems like something that was done as a workaround for old drivers,
> > maybe there isn't that many of them and we can convert them all in one
> > series.  
> 
> I'd like to clarify a bit here.
> Link netns is closely coupled with source netns, as it's passed to drivers
> as source netns. Without introducing a flag, after applying the logic in
> this patchset, drivers won't be able to distinguish the two:
>   1) ip -n ns1 link add netns ns2 ...
>   2) ip link add netns ns2 link-netns ns1 ...

True, but the question is how many drivers actually care about the net
parameter. Ideally we would pass both netns to the drivers, refactor
the ->newlink callback to take a parameter struct and add both netns
as members. Passing just one or the other will always be confusing.

> There's no problem for drivers that already handle source netns.
> But it changes the semantics of 1) for ip tunnels silently. The effective
> link-netns is ns2 before, and will be changed to ns1 afterwards, which will
> almost certainly affect some users. Is this acceptable?

No, changing the behavior for the commands you provided is not
acceptable. At the same time we shouldn't be adding technical debt 
of supporting both converted and unconverted drivers upstream.

> On the other hand, do we need to deal with out-of-tree drivers?

Nope, but again, changing the prototype of newlink would also make it
hard to get wrong for OOT modules.

