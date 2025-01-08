Return-Path: <netdev+bounces-156207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57347A05858
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98573A16BC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D11E04B8;
	Wed,  8 Jan 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9XrwRw8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13F38F82
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332845; cv=none; b=bteQoolg/e5uSeGAxYzc2xleMiv3BwaSBUB2wDDOcFkQL5l/WIjzAEK6rRVnpSFcExVBEyXpV8VFApbwTi3HH/SdXms3o7Vn+CGv7vnMM7vEUyWJpZYcznInLDIePxPQUMeie5K+ucrqDVmqf/H794UG+gTrY1QiV+4SEcaXhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332845; c=relaxed/simple;
	bh=PxHvhlvnNXfvcLPluPBbrQoY9pjdQh1p4HHAJa7oUBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncbSzmNUoUUTz55zdySBfJd1Y/F5ppg02pm1LafshERoZQyaTBW1k7W9HtTB7kG1TSApNRdko9iEFjFd3GAwextslowQ02VJkGKF7aWP9dT8D939IUJjbrrG3XaYPq7kZYUycc8E2zqxd8loCHhARzaNPhW6x9P6ZOIIz60WTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9XrwRw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94231C4CEE0;
	Wed,  8 Jan 2025 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736332844;
	bh=PxHvhlvnNXfvcLPluPBbrQoY9pjdQh1p4HHAJa7oUBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9XrwRw8TQ5BZP8mc7953R/atIT9/OjQbyuuAhwhRHXhuEwASXzeLTQgNdsv1Wzy2
	 81vGrQC0a+p0QP3zoVw45o602/kiedmpnT+JfxxsroOETy55SIWbQwRLYXCxAE0GvW
	 NdcyxyY2uC2iEIRK1TtKdwF5Cehzu9ZxT4/BEO4yX5c3q9Fje+VRLGRQxau0MIUl+4
	 XghE4apjUQOqKgU5AWWg5s8d1PK9eSRKEUa+/jXr0KqtXOvoSeTI6r/0AQ3842fhks
	 0wH/nhHcoSVRBtKYDgkcjzRZZ1InRj3woxbVd/tETl0YRvJ0VFnn5gTO5tkWqMXiCh
	 q5zuqiucVONKQ==
Date: Wed, 8 Jan 2025 10:40:40 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH v1 net 1/3] gtp: Use for_each_netdev_rcu() in
 gtp_genl_dump_pdp().
Message-ID: <20250108104040.GA7706@kernel.org>
References: <20250108062834.11117-1-kuniyu@amazon.com>
 <20250108062834.11117-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108062834.11117-2-kuniyu@amazon.com>

On Wed, Jan 08, 2025 at 03:28:32PM +0900, Kuniyuki Iwashima wrote:
> gtp_newlink() links the gtp device to a list in dev_net(dev).
> 
> However, even after the gtp device is moved to another netns,
> it stays on the list but should be invisible.
> 
> Let's use for_each_netdev_rcu() for netdev traversal in
> gtp_genl_dump_pdp().
> 
> Note that gtp_dev_list is no longer used under RCU, so list
> helpers are converted to the non-RCU variant.
> 
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Harald Welte <laforge@gnumonks.org>

...

> @@ -2280,7 +2281,10 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
>  		return 0;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
> +	for_each_netdev_rcu(net, dev) {
> +		if (dev->rtnl_link_ops != &gtp_link_ops)
> +			continue;
> +
>  		if (last_gtp && last_gtp != gtp)
>  			continue;
>  		else

Hi Iwashima-san,

With this change gtp seems to be uninitialised here.
And, also, it looks like gn is now set but otherwise unused in this function.

Flagged by W=1 builds with clang-19.

...

