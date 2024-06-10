Return-Path: <netdev+bounces-102313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAD90257F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C961F22242
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216614291E;
	Mon, 10 Jun 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXoMX+NX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23613FD83
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032753; cv=none; b=jANVobKeE4FfU/EZ/cTzbNegOlX3Z+72smbVeqHQjV9niJjxW5XedG4NryqybsZVfDsA2qOOSu0t/vmLonbTHfcI36V6Jfg4RbUqjDowQsdvL+u09IP69hIB3Oazo78dGS/LT4ztOwa0kY/zOHAHejknBVF6cbNRHKVU3lpMTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032753; c=relaxed/simple;
	bh=4LpV+woxC4a33gVAMJzYDiZcxqIfHZvWBX+mt4uAFTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as8q5RCEN6gJ5jcHYJ/pkPUZezI9zI0ARLmmZyaQg+dJz6ucY3XaDv9xgUUBjhBmvicOv5zJOQrUWtgJT92Duz652kZ9dvSV7qwBYmFJTj1cR8eJfZWdpkjGLN4aMW+uIUH8z8VJPg9nif1GGV7tBjt0n6kbp4F33HyF6PhLKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXoMX+NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20655C4AF1C;
	Mon, 10 Jun 2024 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718032753;
	bh=4LpV+woxC4a33gVAMJzYDiZcxqIfHZvWBX+mt4uAFTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fXoMX+NXla+Df2QJZ6auIW/4BykBkevmwsCmLx8mgSgPbq/0UPunInY7omLfRKMPv
	 q/n//fC9r0ihWXVCgqG5ccYs0yv0iHL5UaPnzFb9Wf+mvQbsvebzhs7Tu3kg5S0mT/
	 ueDMBdTLjULzi7QRhMGsJ3P3OkEsCjNNOnDb1UQ6T245htbZWfNlyYem7zHHwEcJPD
	 cUGBNreGe+sGAbNIc1OQ4N8hgUK4/g+53jN6nfqIOyordTBiVKDSDX4GyR7RZf5fy9
	 QnO39rrMfvj6wUWOrOCgvGSYBmcdWPqh058TBh26YZef3KR60Tt0KOE9rKffqXuq3L
	 0wH/Zgof4XDEQ==
Message-ID: <ea309c08-4726-430c-a9c5-295e76ba61d4@kernel.org>
Date: Mon, 10 Jun 2024 09:19:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: core: Unify dstats with tstats and
 lstats, implement generic dstats collection
Content-Language: en-US
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 4:25 AM, Jeremy Kerr wrote:
> The struct pcpu_dstats ("dstats") has a few variations from the other
> two stats types (struct pcpu_sw_netstats and struct pcpu_lstats), and
> doesn't have generic helpers for collecting the per-cpu stats into a
> struct rtnl_link_stats64.
> 
> This change unifies dstats with the other types, adds a collection
> implementation to the core, and updates the single driver (vrf) to use
> this generic implementation.
> 
> Of course, questions/comments/etc are most welcome!
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> v3:
> - rather than exposing helpers, perform dstat collection implicitly when
>   type == NETDEV_PCPU_STAT_DSTAT
> - Link to v2:
>   https://lore.kernel.org/r/20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au
> 
> ---
> v2:
> - use correct percpu var in dev_fetch_dstats
> - use correct accessor in vfr rx drop accounting
> - v1: https://lore.kernel.org/r/20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au
> 
> ---
> Jeremy Kerr (3):
>       net: core,vrf: Change pcpu_dstat fields to u64_stats_t
>       net: core: Implement dstats-type stats collections
>       net: vrf: move to generic dstat helpers
> 
>  drivers/net/vrf.c         | 56 ++++++++++++++---------------------------------
>  include/linux/netdevice.h | 12 +++++-----
>  net/core/dev.c            | 50 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 45 deletions(-)
> ---
> base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
> change-id: 20240605-dstats-b6e08c318555
> 
> Best regards,

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>

thanks

