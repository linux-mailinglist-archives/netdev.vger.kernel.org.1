Return-Path: <netdev+bounces-166122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3FA34A77
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924A31894DB8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72E221571;
	Thu, 13 Feb 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djp5uQBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BC155326
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464338; cv=none; b=Oga+k6Ve78BKFI9UT2SmiNhbAY2jSw70VA6Z4wVOlbvC2m4BawWYTEFJYgwrFBjyK3NSHZ3qd10UfVpiM61Pw6ygxXMnrYIK5gR1Edci+w+X3pBetP/hvxIbZ+2c2eXkbCf/OrxYpFaKrMKhrvOX2oFg0mwKHb1+38ipRZtr1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464338; c=relaxed/simple;
	bh=tvox82U4+Hop8rGIYLrDX2FJipGXsxf9NheTw1Ppo2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaST0/B7/MmfKw4FlYjO9+Qvuc8natZIllURJNSlypptpyFN0Po5J8Lm7ilGxHzcI8BvEdikfdwNBornIvdCeGkmojWk9cpJKMN8PW06zRXOZm1aCRfbWjRDNGB07M9/0gmmq5dicENbEnULw98mh53AQdbrXUzJk+bq1oYO3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djp5uQBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ED6C4CED1;
	Thu, 13 Feb 2025 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464338;
	bh=tvox82U4+Hop8rGIYLrDX2FJipGXsxf9NheTw1Ppo2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djp5uQBuSgUKeFYKJ2q+7A7tsAC2SGLWJHhFqPILGq89SesMJyS8E+YJWE17Zgpr2
	 6ZoYmLEhnvfp0Vm9V8QnnY3FA5epi7PSow9F/NkVetYmweJzqbd2hOXtU8tzRz2afO
	 /eK5eyagXR4IXD8Gh2GpmjI5brEXcw8VB20kjPBQ5zokf1GyiuOWR5oykxRU1ISslU
	 mcc6NKcVzO2Uo4+0jSDIWsG3pqukVCrVba3ETFHRzPUEU7WN9BYpca53Eexlug0hBI
	 3elUnr05QQ45pPNicQlLjeZarDJZZPtil3aOt5sYxbEK0Wzuj6OaduEbGR1PFWvYjm
	 SwWkLFmw0xcFg==
Date: Thu, 13 Feb 2025 08:32:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>, Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH v4 net 2/3] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
Message-ID: <20250213083217.77e18e10@kernel.org>
In-Reply-To: <20250212064206.18159-3-kuniyu@amazon.com>
References: <20250212064206.18159-1-kuniyu@amazon.com>
	<20250212064206.18159-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:42:05 +0900 Kuniyuki Iwashima wrote:
> +static void rtnl_net_dev_lock(struct net_device *dev)
> +{
> +	struct net *net;
> +
> +#ifdef CONFIG_NET_NS
> +again:
> +#endif
> +	/* netns might be being dismantled. */
> +	rcu_read_lock();
> +	net = dev_net_rcu(dev);
> +	net_passive_inc(net);
> +	rcu_read_unlock();
> +
> +	rtnl_net_lock(net);
> +
> +#ifdef CONFIG_NET_NS
> +	/* dev might have been moved to another netns. */
> +	if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> +		rtnl_net_unlock(net);
> +		net_passive_dec(net);
> +		goto again;
> +	}
> +#endif

Is there a plan to clean this up in net-next? Or perhaps after Eric's
dev_net() work? Otherwise I'm tempted to suggest to use a loop, maybe:

	bool again;

	do {
		again = false;

		/* netns might be being dismantled. */
		rcu_read_lock();
		net = dev_net_rcu(dev);
		net_passive_inc(net);
		rcu_read_unlock();

		rtnl_net_lock(net);

#ifdef CONFIG_NET_NS
		/* dev might have been moved to another netns. */
		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
			rtnl_net_unlock(net);
			net_passive_dec(net);
			again = true;
		}
#endif
	} while (again);

