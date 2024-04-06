Return-Path: <netdev+bounces-85384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E289A8E7
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 06:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432812835CF
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68BE18C36;
	Sat,  6 Apr 2024 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzDVDMJ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3971803D
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379217; cv=none; b=fYbK6S+MUgHoJYtdRMPe5LxwhXv0/ZsPDtkiNNvEBFJCQeYZaXlS0jHZJGYVWoT0UPo5g/V28iAIzxHYX72HZbV0tSySPob1Q1BA4uOxX6r2goGj/djFy3frSaQKvKbpvuTxaYA71G6qXHr4NRRbkGkop5Q3WoLrde6XRDT4Yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379217; c=relaxed/simple;
	bh=V1C5n9i/0halplv7ejaoUQJQfU2HCkUb+8X9NQF25RY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpfSDM+b7FXNkHc5/X7VMKrHbfyyXDO2k7Ds44+IwyMEJgvDCF16qgpDsEnhH3AxQcrImwwJkjH5CTQVeIOoHDmgQazzPzkQUzgFJ4j40Jv0xWTmwDIUUz9FL82ttxxJkIOSrFNbpR9SPJhZ/2ZcskTqEVTpZmOGQys4NGr5Upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzDVDMJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8197CC433C7;
	Sat,  6 Apr 2024 04:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712379217;
	bh=V1C5n9i/0halplv7ejaoUQJQfU2HCkUb+8X9NQF25RY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzDVDMJ29ctk6ZgPMaIEvrdeC3PmvbXkl5fRpVeHPDWSLRfbqe8Wm9xAoeI0V0Skj
	 VFVn4+qIfmJz0CJiUz7hXi5FGWzjzziIrjLiukDvtz1sFoAsbCzw6zxcT3iInkm5rl
	 VJdtIqHHwOh8MiHQx7KUNQXtMYYh5d3RXgMG3fDs1mXcaQ6q+ov4dVPk5QXTPXnpvq
	 GGKXwdk+EBxBJQaALTPe3SvrLuaUKZyTO3LtwyJAsRKMhcu0n2xAsOY1Dtsfzap4LZ
	 1K+jNRH0BBM3vfNtJwFnMA1xd3tt20H+BiXxVigfY6+T8QjqwKqGMcMqUOGs5Xkhxv
	 sXvJmVs8BniWg==
Date: Fri, 5 Apr 2024 21:53:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next 3/5] ethtool: add interface to read representor
 Rx statistics
Message-ID: <20240405215335.7a5601ca@kernel.org>
In-Reply-To: <20240404173357.123307-4-tariqt@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
	<20240404173357.123307-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 20:33:55 +0300 Tariq Toukan wrote:
> Implement common representor port statistics in
> a rep_port_stats struct_group, introducing a new
> 'out of buffer' stats for when packets are dropped
> due to a lack of receive buffers in RX queue.
> 
> The port statistics represent the statistics of the
> function with which the representor is associated.
> 
> Print the representor port stats when the
> --groups rep-port or --all-groups are used.

I re-read what Tariq said on v1 and I clearly missed the point,
sorry about that. Looking that his patch makes it pretty obvious.

With the netdev netlink family in place I was hoping we would
only put in ethtool stats for functionality already configured
via ethtool or clearly related to Ethernet.

But before we go to netdev - can you think of more such error stats 
that we may need to add? Since it's the equivalent of rtnl rx_missed 
I think we should consider putting it in netdev_offload_xstats. Maybe
following the same definition as packet/byte counters? Report sum by
default and CPU ones under IFLA_OFFLOAD_XSTATS_CPU_HIT? Or new enum
entry?

Simon, WDYT?

> +/**
> + * struct ethtool_rep_port_stats - representor port statistics
> + * @rep_port_stats: struct group for representor port

In more trivial remarks - kernel-doc script apparently doesn't want
the group to be documented (any more?)

> + *	@out_of_buf: Number of packets were dropped due to buffer exhaustion.
> + */
> +struct ethtool_rep_port_stats {
> +	struct_group(rep_port_stats,
> +		u64 out_of_buf;
> +	);
> +};
> +

