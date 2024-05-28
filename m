Return-Path: <netdev+bounces-98704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590BF8D2217
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC22B23003
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD1172BAE;
	Tue, 28 May 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqBZTFYd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002BF16EBE2
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915571; cv=none; b=K7VYhOiddGQM9C7u+YbnqlUd8mqSuGk6rlBY8hixHA+XT8urDpbZ3TGRMKO1pKYX/xC9rt8fw+LFyocmQxRFkSevFWTlcKlwQPwBs7NBsLr57a3sSWEWjkybACjYjz3dlsIQBPKXywbfLw13jPHLjSCqz2U8lA1pnXMi8EXkpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915571; c=relaxed/simple;
	bh=Ko9Tb+DUh5NRlOqeb3jzZFwSz5J9GQMrYOHK2NuLhqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WX+oPo12FUfpQDGasLB2/pwbL2aXJ9bVZ4j7LgyOpncKivHHIHL1oGIg3X2edjR4Mh7BpVPPVIWxljEVRqCaGv3YGqgYl5fBBu53dQiu1fC5Q8n8DGQX7o4IcW05aEo8SabouIxJTkkflh5WsJHHnhveFc5tLFZ5tzvM9rI9K+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqBZTFYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A6C3277B;
	Tue, 28 May 2024 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716915570;
	bh=Ko9Tb+DUh5NRlOqeb3jzZFwSz5J9GQMrYOHK2NuLhqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bqBZTFYd4ppz4N6BeS9UCNo1viGR7KuDAnGQb3p8O8VsUI1eyVAGKpMVElVb1Q0Wj
	 LPb/myiWOXaw1oJ1wUO/oUFxS7daGT+dhGlq4mBt14VcNJSXwbx93OFlKaffOCqjon
	 iAL71kDTqAAasQFotEL54egD3nV7Uk+I7xnHlUPAvpB9ncCNx9p5EJNAxUxNy8fnBb
	 0MciPdFlGiKtNwdeguKvLttlWwJHl42YShupLNAvUgZYDGJvbptSl9h1yn1RjE90Nz
	 bphAKw+h+JomeEawhOjM/CY1ofoGDjUF/McNZ/nhzpQaIHT4PFMh0/our/SjZaETyU
	 orSBg6cRFTYkg==
Message-ID: <b5619a44-c8d5-4bb5-9c98-223e3adec3e4@kernel.org>
Date: Tue, 28 May 2024 10:59:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix __dst_negative_advice() race
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Clement Lecigne <clecigne@google.com>, Tom Herbert <tom@herbertland.com>
References: <20240528114353.1794151-1-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240528114353.1794151-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 5:43 AM, Eric Dumazet wrote:
> __dst_negative_advice() does not enforce proper RCU rules when
> sk->dst_cache must be cleared, leading to possible UAF.
> 
> RCU rules are that we must first clear sk->sk_dst_cache,
> then call dst_release(old_dst).
> 
> Note that sk_dst_reset(sk) is implementing this protocol correctly,
> while __dst_negative_advice() uses the wrong order.
> 
> Given that ip6_negative_advice() has special logic
> against RTF_CACHE, this means each of the three ->negative_advice()
> existing methods must perform the sk_dst_reset() themselves.
> 
> Note the check against NULL dst is centralized in
> __dst_negative_advice(), there is no need to duplicate
> it in various callbacks.
> 
> Many thanks to Clement Lecigne for tracking this issue.
> 
> This old bug became visible after the blamed commit, using UDP sockets.
> 
> Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
> Reported-by: Clement Lecigne <clecigne@google.com>
> Diagnosed-by: Clement Lecigne <clecigne@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/dst_ops.h  |  2 +-
>  include/net/sock.h     | 13 +++----------
>  net/ipv4/route.c       | 22 ++++++++--------------
>  net/ipv6/route.c       | 29 +++++++++++++++--------------
>  net/xfrm/xfrm_policy.c | 11 +++--------
>  5 files changed, 30 insertions(+), 47 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



