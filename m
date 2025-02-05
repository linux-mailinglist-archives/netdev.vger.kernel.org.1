Return-Path: <netdev+bounces-163179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B4A29879
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8FC163E92
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8B1FC7E4;
	Wed,  5 Feb 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggPGncWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61813D897;
	Wed,  5 Feb 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779113; cv=none; b=gHk4xva3A20utspRiZ3WexmfCidxZPXNLGV3MNBA0rxrA73Vhqq3bQcQvjdzudpOMInfCwyyCzqU70wCGAhnvwCeCpfzTQYfdUp1m56NdRCApJwnBZSMMUnWA1++BoIwQId7jDZnt+1rIf9dqyq6LaP//xasqZIcZk2GMi/3bxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779113; c=relaxed/simple;
	bh=ctqEMXf7JvqZMX/tEU7QDm9t9klBXz3B7LC+25UaxNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMm3yNNCf1+cFc8aArn+pR265B/6WQVApBQmHHzzg54TlABpP0cxMeqjFq2W8+UHN+nunC2h10uiJ1dVZXC0/SlS4yyyk80l+bDr45YDXgSxJHxtM4fFsRGS1QVG7iqhyMo/754kXaxLBP2u+JOgEuVk+hQBylGAdjnOnSgTfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggPGncWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C1CC4CED1;
	Wed,  5 Feb 2025 18:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779112;
	bh=ctqEMXf7JvqZMX/tEU7QDm9t9klBXz3B7LC+25UaxNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggPGncWEqtD8CeKvsy4OqjKLqNQBbD/osuya2BRsmZPDGdHxdUYb6ylcF5VpnrDMP
	 7gLS5sUFmbVxO3ZYfGmVgLU+i4O5xIuujvpjV7RdR38Lqz8XUyZmrqDgJcrMc/OCZm
	 vfQM06NYQGgV/9kUMHzKO1fB06E3zzS0pkRKwYXMxuqzhRlM5iARmxydIUljX5icrC
	 NGbTAbqxuM4f7kq0uD4t6NKjcYtQIQ6+PWphl7vH7eLDj+DZQPZxx/V0gvAOP2E4id
	 6Hq5JI0q68JPRGMXv9VIm7X899NTeHih5Pcb4+vCSwl5QN3KIiaLTmBl5V3YYyA7XE
	 xpLMsP1+tWCxQ==
Date: Wed, 5 Feb 2025 18:11:48 +0000
From: Simon Horman <horms@kernel.org>
To: Liang Jie <buaajxlj@163.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Michal Luczaj <mhal@rbox.co>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind
 identifier length
Message-ID: <20250205181148.GK554665@kernel.org>
References: <20250205060653.2221165-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205060653.2221165-1-buaajxlj@163.com>

On Wed, Feb 05, 2025 at 02:06:53PM +0800, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> Refines autobind identifier length for UNIX domain sockets, addressing
> issues of memory waste and code readability.
> 
> The previous implementation in the unix_autobind function of UNIX domain
> sockets used hardcoded values such as 16, 6, and 5 for memory allocation
> and setting the length of the autobind identifier, which was not only
> inflexible but also led to reduced code clarity. Additionally, allocating
> 16 bytes of memory for the autobind path was excessive, given that only 6
> bytes were ultimately used.
> 
> To mitigate these issues, introduces the following changes:
>  - A new macro AUTOBIND_LEN is defined to clearly represent the total
>    length of the autobind identifier, which improves code readability and
>    maintainability. It is set to 6 bytes to accommodate the unique autobind
>    process identifier.
>  - Memory allocation for the autobind path is now precisely based on
>    AUTOBIND_LEN, thereby preventing memory waste.
>  - The sprintf() function call is updated to dynamically format the
>    autobind identifier according to the defined length, further enhancing
>    code consistency and readability.
> 
> The modifications result in a leaner memory footprint and elevated code
> quality, ensuring that the functional aspect of autobind behavior in UNIX
> domain sockets remains intact.
> 
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---
>  net/unix/af_unix.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 34945de1fb1f..5dcc55f2e3a1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1186,6 +1186,13 @@ static struct sock *unix_find_other(struct net *net,
>  	return sk;
>  }
>  
> +/*
> + * Define the total length of the autobind identifier for UNIX domain sockets.
> + * - The first byte distinguishes abstract sockets from filesystem-based sockets.
> + * - The subsequent five bytes store a unique identifier for the autobinding process.
> + */
> +#define AUTOBIND_LEN 6
> +
>  static int unix_autobind(struct sock *sk)
>  {
>  	struct unix_sock *u = unix_sk(sk);
> @@ -1204,11 +1211,11 @@ static int unix_autobind(struct sock *sk)
>  
>  	err = -ENOMEM;
>  	addr = kzalloc(sizeof(*addr) +
> -		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
> +		       offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN, GFP_KERNEL);

Hi Liang Jie,

1. While we are here, can we try to move this code to respect
   the preference for lines 80 columns wide or less in Networking code?

   e.g.

	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
		       AUTOBIND_LEN, GFP_KERNEL);

2. More importantly, this allocates AUTOBIND_LEN bytes for sun_path.

   However, because the sprintf() will append a trailing '\0' it will
   write up to AUTOBIND_LEN (that is, AUTOBIND_LEN - 1 + 1) bytes
   at an offset of 1 to sun_path. IOW, the write may be one byte larger
   than the buffer with the '\0' overflowing.

   Flagged by W=1 build with gcc-14

>  	if (!addr)
>  		goto out;
>  
> -	addr->len = offsetof(struct sockaddr_un, sun_path) + 6;
> +	addr->len = offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN;
>  	addr->name->sun_family = AF_UNIX;
>  	refcount_set(&addr->refcnt, 1);
>  
> @@ -1217,7 +1224,7 @@ static int unix_autobind(struct sock *sk)
>  	lastnum = ordernum & 0xFFFFF;
>  retry:
>  	ordernum = (ordernum + 1) & 0xFFFFF;
> -	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
> +	sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
>  
>  	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
>  	unix_table_double_lock(net, old_hash, new_hash);

-- 
pw-bot: changes-requested

