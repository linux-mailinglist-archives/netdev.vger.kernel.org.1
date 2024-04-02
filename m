Return-Path: <netdev+bounces-84073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7688957B2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6BEB2EE4A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A912BF22;
	Tue,  2 Apr 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl89PQ/t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9712B16E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069213; cv=none; b=ZtOZLjswmQsR/7lpCoVhyLX84gZ0zQD1f6tGXC6lcc7uCF+P0W/7T7xxL7S+SyYx/jGQF3qpviGcARsYV5N25c2zddxmLNF7o51xioBEjGOelejxclVICUyv3qI5ViAcvUymY+dfTlEoJS4pdi5NGYEBngMr41eUXk3tMConTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069213; c=relaxed/simple;
	bh=6DUx+m73fp2OZ+NK3fI/3shuKb4wYs7i7IOfVl+OyJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJe9QQeyYUCzyHEw5RkAfKDnplFnYU6mzyf0EuOgFkk1tpEK3l54MmmCIzuYBurz2iOLdL+GduEn1tvaYKRX6xVCvQwQGy+KiTvzUaZmlqFsJb7WDXVo5fEQyExsWRcsJ1B9M4+/Lh6xSyOMc3Rjmumo1N5SuBe0bZzRF/aiUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl89PQ/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC86C433F1;
	Tue,  2 Apr 2024 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712069213;
	bh=6DUx+m73fp2OZ+NK3fI/3shuKb4wYs7i7IOfVl+OyJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jl89PQ/tN7fIBz86mUt5JW3+qYSkEDALPUCX0Db+4L+3euspA/5KRaX2CA9DqLELz
	 fEjivLyMD/LpC+Vw4E/aw9XORM3F9fMkcPkwMhZDPq/RgbY/AqerbYrRy7kk5sbsqy
	 iNJbA8Zlm5hXmwS501fRUlGiOegO5aBdMNLvR3FWaKbx1Ijjo9v4528GM+Qw2Jqmke
	 xWeYDefD2pvIDqC79XVgEqLwlgF3/E5hMXD2fpPiWBQHisTnnTrFl6xxXH1sha5yEU
	 4EuidQddTgs3d2CdevR+qERH8oywXnPuANnOf2ufgfc0GhrVyDfgv0tqTPhdqYCBgk
	 Clpw3D0DsBByw==
Message-ID: <6f2bb8b9-a1a6-40ab-acd2-5767ec2c888d@kernel.org>
Date: Tue, 2 Apr 2024 08:46:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ipv6: Fix infinite recursion in fib6_dump_done().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzkaller <syzkaller@googlegroups.com>
References: <20240401211003.25274-1-kuniyu@amazon.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240401211003.25274-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 3:10 PM, Kuniyuki Iwashima wrote:
> syzkaller reported infinite recursive calls of fib6_dump_done() during
> netlink socket destruction.  [1]
> 
> From the log, syzkaller sent an AF_UNSPEC RTM_GETROUTE message, and then
> the response was generated.  The following recvmmsg() resumed the dump
> for IPv6, but the first call of inet6_dump_fib() failed at kzalloc() due
> to the fault injection.  [0]
> 
>   12:01:34 executing program 3:
>   r0 = socket$nl_route(0x10, 0x3, 0x0)
>   sendmsg$nl_route(r0, ... snip ...)
>   recvmmsg(r0, ... snip ...) (fail_nth: 8)
> 
> Here, fib6_dump_done() was set to nlk_sk(sk)->cb.done, and the next call
> of inet6_dump_fib() set it to nlk_sk(sk)->cb.args[3].  syzkaller stopped
> receiving the response halfway through, and finally netlink_sock_destruct()
> called nlk_sk(sk)->cb.done().
> 
> fib6_dump_done() calls fib6_dump_end() and nlk_sk(sk)->cb.done() if it
> is still not NULL.  fib6_dump_end() rewrites nlk_sk(sk)->cb.done() by
> nlk_sk(sk)->cb.args[3], but it has the same function, not NULL, calling
> itself recursively and hitting the stack guard page.
> 
> To avoid the issue, let's set the destructor after kzalloc().
> 

...

> Modules linked in:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Conflict with:
> https://lore.kernel.org/netdev/20240329183053.644630-1-edumazet@google.com/
> 
> Changes:
>   v2: Removed the garbage in the head of description
>   v1: https://lore.kernel.org/netdev/20240401205020.22723-1-kuniyu@amazon.com/
> ---
>  net/ipv6/ip6_fib.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



