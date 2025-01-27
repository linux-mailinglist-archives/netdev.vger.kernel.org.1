Return-Path: <netdev+bounces-161180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC957A1DCBA
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5698616213F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB7192D76;
	Mon, 27 Jan 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBkt0mRT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBC17B50A
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006066; cv=none; b=u6y2iaxGkPjblBuwCRxTps3tzTU5clYV28ofLhnyEfIySZnpwhBAzx3CQlvz24BNmt+NWFjV3btWRqkTZx68JmsRN3OEIhBEa4kuUn8PIBUrdxfTe9qFt316Qc81PkARxx58yxCm57kre3MUmO84IZAAqOx/3bZitGVN4Q6oCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006066; c=relaxed/simple;
	bh=PkS2KKkojkLfxnANl8Zqzmsf8KA00nn6rHetuNjn0Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjoTgjMENdpjHeLQAHAu3RhD0I33/xwNX6pF4x+e7XE9woa+7SsF/RHkaSb7b9OSGy+Mb+TXRKs4/RUkxq9FFPf0+3/iUkYIqdDqY37FabOekKWcXGatUEWs7LndDYHvkODfnJ0YNneVoglYIpSGRL2O5rSumJu/ja8vpukJRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBkt0mRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C0EC4CED2;
	Mon, 27 Jan 2025 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738006066;
	bh=PkS2KKkojkLfxnANl8Zqzmsf8KA00nn6rHetuNjn0Ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BBkt0mRTTn7C87meZpyEclQ9yd98ZFmox38wyt2ODoQ/dxce4USUz88phXF2Cru7z
	 tg4ubRw3CL+9G9p4mCbdTvTuVW+wyotaqEqyh8/6PaL0hgF7HVtZt14C2IE6pHUkNS
	 W55AQEYQuDHuKfL4q5A2MgRukWTR0UaKLXvs5GE9y5enaJgHB/GtFuPYGne0aprZ4x
	 puZQ7ALqcGgctekZCzsyFmSnOwg99IFhe+V/WyeNxF0FDZJOR6mS4XzgG8yyMTvaqr
	 6qGE3vDQa7E6J/aU1tMn9qU+DOgOqyvaf+Oi7IZdZ0mR90TPc9QFnhdXbnIavyJMZg
	 hg1rbqDyCEMLw==
Date: Mon, 27 Jan 2025 11:27:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <20250127112744.0db2b45a@kernel.org>
In-Reply-To: <Z5PrXkL7taguM57W@x130>
References: <20250116215530.158886-1-saeed@kernel.org>
	<20250116215530.158886-11-saeed@kernel.org>
	<20250116152136.53f16ecb@kernel.org>
	<Z4maY9r3tuHVoqAM@x130>
	<20250116155450.46ba772a@kernel.org>
	<Z5LhKdNMO5CvAvZf@mini-arch>
	<20250123165553.66f9f839@kernel.org>
	<Z5ME2-zHJq6arJC8@x130>
	<20250124072621.4ef8c763@kernel.org>
	<Z5PrXkL7taguM57W@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 11:34:54 -0800 Saeed Mahameed wrote:
> On 24 Jan 07:26, Jakub Kicinski wrote:
> >> Are you expecting drivers to hold netdev_lock internally?
> >> I was thinking something more scalable, queue_mgmt API to take
> >> netdev_lock,  and any other place in the stack that can access
> >> "netdev queue config" e.g ethtool/netlink/netdev_ops should grab
> >> netdev_lock as well, this is better for the future when we want to
> >> reduce rtnl usage in the stack to protect single netdev ops where
> >> netdev_lock will be sufficient, otherwise you will have to wait for ALL
> >> drivers to properly use netdev_lock internally to even start thinking of
> >> getting rid of rtnl from some parts of the core stack.  
> >
> >Agreed, expecting drivers to get the locking right internally is easier
> >short term but messy long term. I'm thinking opt-in for drivers to have
> >netdev_lock taken by the core. Probably around all ops which today hold
> >rtnl_lock, to keep the expectations simple.
> 
> Why opt-in? I don't see any overhead of taking netdev_lock by default in
> rtnl_lock flows.

We could, depends on how close we take the dev lock to the ndo vs to
rtnl_lock. Some drivers may call back into the stack so if we're not
careful enough we'll get flooded by static analysis reports saying 
that we had deadlocked some old Sun driver :(

Then there are SW upper drivers like bonding which we'll need at 
the very least lockdep nesting allocations for.

Would be great to solve all these issues, but IMHO not a hard
requirement, we can at least start with opt in. Unless always
taking the lock gives us some worthwhile invariant I haven't considered?

