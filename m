Return-Path: <netdev+bounces-205590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CEAFF596
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D7B587FDC
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00F469D;
	Thu, 10 Jul 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEWIBiEx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27910CA4E
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752106604; cv=none; b=BIpskr83d1P50cu1EVXjWC6jBIHjUfYqMy/3OXJ+GW/T91NQpag1iPK4xAjta5lMmxW/P3Cy5BTpoLZQDw5dCBKk5kvhVk+0U1MDEoYqMCz8LJqrnvLu4p8kH23EvfkMeV0vVi3ckj45M4tYAE8TdhGui4EStclGllBPyJOUMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752106604; c=relaxed/simple;
	bh=RCcA4rYOT3dpocUwHU/NNgNmI4ISHQvupaRhS4iTji4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djz8TcAIkhn/JEs3/+o1LensWehNqtt8k46Tt/Ge7/6Tq/niWYTHtQQaW2PHYAgY2O+cM+epNT+TKyinsIxq69dZvrLOPmMgIdYUkKxdFuPNF7NWn4EjmyOJN2FaBdDmjRV4V12Q0/dXsAze0mXjS6TSS40RhkAXXwzEXfKNQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEWIBiEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE91C4CEEF;
	Thu, 10 Jul 2025 00:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752106603;
	bh=RCcA4rYOT3dpocUwHU/NNgNmI4ISHQvupaRhS4iTji4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EEWIBiExN7VNoGIlv5SMRSErRXU/WwY/y2eZ4Rruf3XWNXjAc4wSF1XG6yDIAIZ26
	 vUkC0PctKXEKOEIDEG/d8t2KKT7/nvJPRxC+pq4QpQy0kLKw57/hHR5x52ljTAKBu+
	 hVY7/lovnfrnqBwFodqr6krYT5YJSIKz6EmqHSCj7nJjeTbAJndjCrAGtVbVwjFT1q
	 xvEoLHii9t8qQXyOQNHhglY2HbghDuKpXiv+Jjgusp2khomk/Pp91MgnlDugcItQiz
	 /sC/R+QOGT1xLgNQqF3kew/gi71qZ6Ga0kHdaHT25pGlG+x4LaVhdGwdTS5yHgXzPu
	 kvoVVThgRUYCA==
Date: Wed, 9 Jul 2025 17:16:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] dev: Pass netdevice_tracker to
 dev_get_by_flags_rcu().
Message-ID: <20250709171641.721b524a@kernel.org>
In-Reply-To: <20250709190144.659194-1-kuniyu@google.com>
References: <20250709190144.659194-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 19:01:32 +0000 Kuniyuki Iwashima wrote:
> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> index 53cf68e0242bf..fa7f0c22167b4 100644
> --- a/net/ipv6/anycast.c
> +++ b/net/ipv6/anycast.c
> @@ -69,6 +69,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
>  	struct ipv6_pinfo *np = inet6_sk(sk);
>  	struct ipv6_ac_socklist *pac = NULL;
>  	struct net *net = sock_net(sk);
> +	netdevice_tracker dev_tracker;
>  	struct net_device *dev = NULL;
>  	struct inet6_dev *idev;
>  	int err = 0, ishost;
> @@ -112,8 +113,8 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
>  			goto error;
>  		} else {
>  			/* router, no matching interface: just pick one */
> -			dev = dev_get_by_flags_rcu(net, IFF_UP,
> -						   IFF_UP | IFF_LOOPBACK);
> +			dev = netdev_get_by_flags_rcu(net, &dev_tracker, IFF_UP,
> +						      IFF_UP | IFF_LOOPBACK);
>  		}
>  		rcu_read_unlock();
>  	}
> @@ -159,7 +160,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
>  error_idev:
>  	in6_dev_put(idev);
>  error:
> -	dev_put(dev);
> +	netdev_put(dev, &dev_tracker);

Hmmm.. not sure this is legal.. We could have gotten the reference from
dev_get_by_index() or a bare dev_hold() -- I mean there are two other
ways of acquiring dev in this function. Either all or none of them
have to be tracker aware, we can't mix?
-- 
pw-bot: cr

