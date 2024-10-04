Return-Path: <netdev+bounces-132098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E70990632
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBABD1F22059
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51B216A3F;
	Fri,  4 Oct 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHtzXMsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08215749A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052513; cv=none; b=mluafmAuDsCpezYgIOCdXaFL5n/lK+xdC0i3DEQz4ZbNbIE6V7yv29aCl+HjLLARqlhLr6OKtHA9wqvjBG+Ls9jt09AtHiDgA4NO+cOFBbo7+m6z77pexpPeofHhVmGrRn4sdEhWA8dBioD6RtS2irkJ06sTqY1DNUIjahZ5RZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052513; c=relaxed/simple;
	bh=fXz1kNPnizFh7tivaptzm7yl9L4SJuvdBDnvepJzgOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxjlQd69eMafmODF3WSfmxSHL13JREdoCmTUZL2Q2NGcehQd6gpmDkJYfRxuSc6SUyNo0Uv+ozOZO9Sjh9i/QvHwd9KmTcGGxlItwYIIk3924S1TB3seb6kslM90XUl/18vlc+jxqMH4REXnrR4Kejz38fy3ABKoQS+c6+0Qo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHtzXMsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237C0C4CEC6;
	Fri,  4 Oct 2024 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728052513;
	bh=fXz1kNPnizFh7tivaptzm7yl9L4SJuvdBDnvepJzgOY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHtzXMsPTb6FuXEpBvFnoljFmf8lDJbtyWy5e9943bLpdm2DIGM59QlBIdTsHG2tX
	 R4s2eJGxAXawnekTG5osgoToM6CBSgEF6Bh0ukozhffBX4xhXnxogmIGJASj0EVbBN
	 thdeRgtAYI7ucbD1CMGcmtNMM24Y5XFW4UnziU1nLWhCdH5VylhWPdGO+44VkCV3DL
	 a3/mM6GOGZlGrGlC9LURX2bvyGmYybuS1V/AI3s8yjw3+iRYSkzCUgz4kOxABpWaa9
	 17OfcjmWVSrsQ8VLbJfzjRRYQTpQPGICjTIEkYD3Hw6eA3LH0DvV/9eEM6QEydusgf
	 ErWULXxnrsBvw==
Message-ID: <11039025-6386-444d-ad5f-5eea664bafd5@kernel.org>
Date: Fri, 4 Oct 2024 08:35:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] ipv4: preliminary work for per-netns RTNL
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexandre Ferrieux <alexandre.ferrieux@orange.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20241004134720.579244-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241004134720.579244-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 7:47 AM, Eric Dumazet wrote:
> Inspired by 9b8ca04854fd ("ipv4: avoid quadratic behavior in
> FIB insertion of common address") and per-netns RTNL conversion
> started by Kuniyuki this week.
> 
> ip_fib_check_default() can use RCU instead of a shared spinlock.
> 
> fib_info_lock can be removed, RTNL is already used.
> 
> fib_info_devhash[] can be removed in favor of a single
> pointer in net_device.
> 
> Eric Dumazet (4):
>   ipv4: remove fib_devindex_hashfn()
>   ipv4: use rcu in ip_fib_check_default()
>   ipv4: remove fib_info_lock
>   ipv4: remove fib_info_devhash[]
> 
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     |  2 +
>  net/ipv4/fib_semantics.c                      | 77 +++++++------------
>  3 files changed, 31 insertions(+), 49 deletions(-)
> 


For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


