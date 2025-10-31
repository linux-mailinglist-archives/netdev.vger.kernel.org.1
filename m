Return-Path: <netdev+bounces-234730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9BDC26A08
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144F91886F10
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06242E62C5;
	Fri, 31 Oct 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoK/IFcU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AE28E5
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936061; cv=none; b=f9qtsAGrzyFuU2O/XaZczbHB2mLXx3Iyu5SC7rH+Mwl4vOOTo0SMaLQ0mB3WqjF8vnViJRcVTaJdEnr6BSSs49NKQbMZuGNi83U8K1OG0e13liadDu6Tv5J19R5SqB98FHDif+S1zWYwPXaFBniZIbwkDPKLezbn/X0rg9UIdSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936061; c=relaxed/simple;
	bh=jMTlQfDIO00Ez2MpSamB++ig112SYI+p4EWBlHItD/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5a075mjqU87UfmUfOMCKVbhBjtqGl7h00HvjqokotOwoSCoxyRs25f4q1Y3ME15kZwXveqpsiaAPn4FeZE1LQXrggkrFtY00w512QddRuuqZldaKAQlgjFL4FI1Ha7GPS8CAA2aMK5h92haqoSxXcZt3EH99Y8mfw+Wy98G5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoK/IFcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B30C4CEE7;
	Fri, 31 Oct 2025 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761936060;
	bh=jMTlQfDIO00Ez2MpSamB++ig112SYI+p4EWBlHItD/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HoK/IFcUyP8Xi/oFN1bhBi1xt/QA34qrZw5hXn2gB3ruBZeyzP23WqJ/pLXwNjSH3
	 vmQguajI6LKDsQVIJs8uS+GgNzY5Xj81Hk9uSoRKdpX2H2K3o6pEneY/kOOitknsYx
	 B+5WLJpbbhayp9W0TjZS/5jMY/39weQ+AXutMpt1NJeua2Ah7+aY4jqin9Pcq9zD5b
	 V4H+j/w7dBLHtNn92Us8UgkVNfX45h/yvIrcJNq+8o4+l+UUbp+uUKWj/e6nCoLDIY
	 d9NWxHuavA5+CqwcrITZSvwiDuqHrleoP3VRgKID2aJrKzeakm53KEUmpHDvkp+D/3
	 SfJk29TkJoYPA==
Date: Fri, 31 Oct 2025 11:40:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com, parav@nvidia.com,
 tariqt@nvidia.com
Subject: Re: [PATCH net-next] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
Message-ID: <20251031114058.29d635c5@kernel.org>
In-Reply-To: <e25c6c0c-1e2a-48c2-9606-5f51f36afbf0@bytedance.com>
References: <e25c6c0c-1e2a-48c2-9606-5f51f36afbf0@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 17:42:50 -0700 Zijian Zhang wrote:
> When performing XDP_REDIRECT from one mlnx device to another, using
> smp_processor_id() to select the queue may go out-of-range.
> 
> Assume eth0 is redirecting a packet to eth1, eth1 is configured
> with only 8 channels, while eth0 has its RX queues pinned to
> higher-numbered CPUs (e.g. CPU 12). When a packet is received on
> such a CPU and redirected to eth1, the driver uses smp_processor_id()
> as the SQ index. Since the CPU ID is larger than the number of queues
> on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
> the redirect fails.
> 
> This patch fixes the issue by mapping the CPU ID to a valid channel
> index using modulo arithmetic:
> 
>      sq_num = smp_processor_id() % priv->channels.num;
> 
> With this change, XDP_REDIRECT works correctly even when the source
> device uses high CPU affinities and the target device has fewer TX
> queues.

And what if you have 8 queues and CPUs 0 and 8 try to Xmit at the same
time? Is there any locking here?
-- 
pw-bot: cr

