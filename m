Return-Path: <netdev+bounces-245780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39729CD76FD
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 00:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C413013710
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FAF3112C1;
	Mon, 22 Dec 2025 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQdhOR4B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F22BEC43
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445146; cv=none; b=GrN4hNiBKYK1gIEjFE7QPYL3eHP5dSz5wbEoiIVMWbsZys7kbgvvv9+R0F/Kh8nqR6UgoRLRVtiKvmmn2ihErLteh1W2CVRFvmiJsyiTjchKwr3DMGxcSUb+A9ioP+wuRLwR5dV1nSDF48DVyc80DoeZJfeHHsrjLkGULOhFjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445146; c=relaxed/simple;
	bh=KU9xtddCKoCnoRyNcsct+GsZHKRgBSHIyTp87UYCJIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WipmWAEeUyrghBgkxAi1cQ9skW7zKR7XuEK1LuMpOig3mE8EbtrY/PfMLeT2B+dpgW/OOtaXuyG24xWr4uX8r0yc+WBYo3hFqxgj2j63MXOeU2a9Uf6odzNyzAD23Jypoto00VTXiNTItw3CUKQRtbqw0J8Lk03K63xSNx6sFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQdhOR4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF09DC4CEF1;
	Mon, 22 Dec 2025 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766445145;
	bh=KU9xtddCKoCnoRyNcsct+GsZHKRgBSHIyTp87UYCJIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XQdhOR4ByUwORd8FUG0UWebJ9VRgN17eMHzmh2AJElPV7D0mJJkDVbTqeW+TyDlvM
	 EVu4NcZ8fuOoIXX5p2YLiTAx/z65ax1TobwRQ2kkCMM8yfCj4OHTHlA3ZESp5bKyxN
	 kzho79CqIiN5Dr60YfwRZyje9qiytBshnZt7dLQgXCZJx35y3WvtzRe7endfExUZUz
	 gV8F1C8xV8m8Z34Db7lVNqu3hkyCI3KtsKVabd8GXF9DNT2FKqmMtB7FteuGlyBuQZ
	 wNKD2XhjJ8zakKo06y8f8EhrSjTzI/3ksxyCzE8FlMEoaUiOfAZcH825EMxpNITgRu
	 OPOH5jSb8q6qw==
Message-ID: <7c583798-61a9-416f-b437-ae452440c424@kernel.org>
Date: Mon, 22 Dec 2025 18:12:23 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ipv4: Fix reference count leak when using error
 routes with nexthop objects
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20251221144829.197694-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251221144829.197694-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/25 7:48 AM, Ido Schimmel wrote:
> When a nexthop object is deleted, it is marked as dead and then
> fib_table_flush() is called to flush all the routes that are using the
> dead nexthop.
> 
> The current logic in fib_table_flush() is to only flush error routes
> (e.g., blackhole) when it is called as part of network namespace
> dismantle (i.e., with flush_all=true). Therefore, error routes are not
> flushed when their nexthop object is deleted:
> 
>  # ip link add name dummy1 up type dummy
>  # ip nexthop add id 1 dev dummy1
>  # ip route add 198.51.100.1/32 nhid 1
>  # ip route add blackhole 198.51.100.2/32 nhid 1
>  # ip nexthop del id 1
>  # ip route show
>  blackhole 198.51.100.2 nhid 1 dev dummy1
> 
> As such, they keep holding a reference on the nexthop object which in
> turn holds a reference on the nexthop device, resulting in a reference
> count leak:
> 
>  # ip link del dev dummy1
>  [   70.516258] unregister_netdevice: waiting for dummy1 to become free. Usage count = 2
> 
> Fix by flushing error routes when their nexthop is marked as dead.
> 
> IPv6 does not suffer from this problem.
> 
> Fixes: 493ced1ac47c ("ipv4: Allow routes to use nexthop objects")
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Closes: https://lore.kernel.org/netdev/d943f806-4da6-4970-ac28-b9373b0e63ac@I-love.SAKURA.ne.jp/
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/fib_trie.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 59a6f0a9638f..7e2c17fec3fc 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -2053,10 +2053,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>  				continue;
>  			}
>  
> -			/* Do not flush error routes if network namespace is
> -			 * not being dismantled
> +			/* When not flushing the entire table, skip error
> +			 * routes that are not marked for deletion.
>  			 */
> -			if (!flush_all && fib_props[fa->fa_type].error) {
> +			if (!flush_all && fib_props[fa->fa_type].error &&
> +			    !(fi->fib_flags & RTNH_F_DEAD)) {
>  				slen = fa->fa_slen;
>  				continue;
>  			}


Reviewed-by: David Ahern <dsahern@kernel.org>

thanks for the fast turnaround, Ido.

