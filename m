Return-Path: <netdev+bounces-153564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F06E9F8A85
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1EC168595
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F41CAAC;
	Fri, 20 Dec 2024 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXhDbDbR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8133F6;
	Fri, 20 Dec 2024 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664885; cv=none; b=isgl/z/o7aeQxftbLBfftk4QDbpOMMuuUqrRntYycDcEGwM8DTNWb5NplvJRgzGT0i0VpL4m/8Ooby3MKu6VYEDr5INMtTVumKl2sWKNEbvEBBKEexBMKOgsxfYEfHAf4dIc4GwQiThu4xYTutNw1AtmW+TUTBwDSY6l4GCjhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664885; c=relaxed/simple;
	bh=LpXZNLwyu+pe8JMKwhPjrZb9NBYxO1pkZDNccLN7VJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wz1Sol95bDYFQ31uSjkgGnjaoT3p29xuzGywAImbAlZXeWIEgBZk99FdFzklpWOnCjg4vqUdec7OFSbfYAzYVhYMoUNWlpv6NsVU3zAw+J897g4B1wClYwaBUBq7QCbKL7YEFyZlPjs+fTUcQpVFkgJFim8kSM/CCUMwxWrUYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXhDbDbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD4C4CECE;
	Fri, 20 Dec 2024 03:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734664885;
	bh=LpXZNLwyu+pe8JMKwhPjrZb9NBYxO1pkZDNccLN7VJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CXhDbDbRj6JCIC6qXGls+F5r32jV7U9qWzj4m0mgGNxPAmWgCxy+xa//Oo5R39wwn
	 ioBKlrqahJ05eEOwce8+/enim5jTZQdq7jWsM2nFFWlCYDQFMJ4TSsuZDxMNCHGjnB
	 z2XOip2ugEhg2jQskMCiJ11iJclUiYioAAmjhLagOYVQvDCTn6Qoj/qtChgCSL1iuj
	 lq1XGciC6Yks1mB22xYoNjoVZPOmzfqrEniuHtjo02Ti8wraDyFMk1CvLLJZWg/Ieb
	 sluGG+c+EAffLQoEdsC3oqQM5jYUwpZeMGKzLZENBcjnYNHDW1o2yntPUkvRLXBi+S
	 ZzlxIUVTFNwlQ==
Date: Thu, 19 Dec 2024 19:21:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Satananda
 Burla <sburla@marvell.com>, "Abhijit Ayarekar" <aayarekar@marvell.com>
Subject: Re: [PATCH net v3 1/4] octeon_ep: fix race conditions in
 ndo_get_stats64
Message-ID: <20241219192123.4a5f6e75@kernel.org>
In-Reply-To: <20241218115111.2407958-2-srasheed@marvell.com>
References: <20241218115111.2407958-1-srasheed@marvell.com>
	<20241218115111.2407958-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 03:51:08 -0800 Shinas Rasheed wrote:
> ndo_get_stats64() can race with ndo_stop(), which frees input and
> output queue resources. Call synchronize_net() to avoid such races.

synchronize_rcu() acts as a barrier.
What are the two operations you are separating with this barrier?

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..941bbaaa67b5 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -757,6 +757,7 @@ static int octep_stop(struct net_device *netdev)
>  {
>  	struct octep_device *oct = netdev_priv(netdev);
>  
> +	synchronize_net();
>  	netdev_info(netdev, "Stopping the device ...\n");

