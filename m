Return-Path: <netdev+bounces-157131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E128A08FA0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39203A2D16
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2F207DFC;
	Fri, 10 Jan 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfP2PADI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAC205E1A
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509428; cv=none; b=qn1+xf4zJH/RpqSHhpthq/BgLP28kGt5Hus/zXEp/6ao0RsUOk40rjcueYXDS5g/peRYcah9cD6JtHWQZSY+d9qWJgkPi7jVbdjb0Be+Z0sR6qx9PFJKkNgvJYvS+yJUCh+hmrtkq726ca75ZvY01rW3QFQBsbMerVyEx0bdIlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509428; c=relaxed/simple;
	bh=HRzgJm8ruZ6S90c1OI35i1S8ynQqGmcMSAi8WMivMrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP3nw4TV0UzqHM/73a5qsYRP8CrSFnSP1Yz5nVt6SFUw+KRjBfsMg/7AuA6OjkP5HJaN5fRXRLGsTP5rnLMKUyrT77pT/PqY6FgXYF/MuVi326rSi1ORnuoHdVmursFi4Gw+Z35Kjinj7DHqhCZsIywCVAY+TMOJtOV09ozGh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfP2PADI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE68C4CED6;
	Fri, 10 Jan 2025 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736509427;
	bh=HRzgJm8ruZ6S90c1OI35i1S8ynQqGmcMSAi8WMivMrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfP2PADIlYoSfTcqNLK0NJqSzlJv9SiR07hcsaWlpxlL8V+4MCJZI5W5ysbYIJX+N
	 wYPVpt/dWOnu6wtYh0u78698ojkcmdYaiR9vcGljVOKOECHtkkId+unUV3LigVH/Vl
	 YCEjo/05zh99zchwCYL6JGpTjWmhOSqBgYkj16Ghks1lsqGLhumR1T6zMnZ8POq9l5
	 Z/C8UPwY+e5zfh/dLept0POoudtFAstLBDQ46rbI45SGOzo5s+ynJOBc+2iGHgv+LC
	 VDU0k3BqY7g/s7COMHHdYcblgJ5yFHSp2XpcuwOc8Iae5odpZ3HjlMuMIgfii4sIAF
	 16PLDh5OlYWuA==
Date: Fri, 10 Jan 2025 11:43:44 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 06/12] af_unix: Reuse out_pipe label in
 unix_stream_sendmsg().
Message-ID: <20250110114344.GA7706@kernel.org>
References: <20250110092641.85905-1-kuniyu@amazon.com>
 <20250110092641.85905-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110092641.85905-7-kuniyu@amazon.com>

On Fri, Jan 10, 2025 at 06:26:35PM +0900, Kuniyuki Iwashima wrote:
> This is a follow-up of commit d460b04bc452 ("af_unix: Clean up
> error paths in unix_stream_sendmsg().").
> 
> If we initialise skb with NULL in unix_stream_sendmsg(), we can
> reuse the existing out_pipe label for the SEND_SHUTDOWN check.
> 
> Let's rename do it and adjust the existing label as out_pipe_lock.
> 
> While at it, size and data_len are moved to the while loop scope.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index b190ea8b8e9d..6505eeab9957 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c

...

> @@ -2285,16 +2283,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  	}
>  
> -	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
> -		if (!(msg->msg_flags & MSG_NOSIGNAL))
> -			send_sig(SIGPIPE, current, 0);
> -
> -		err = -EPIPE;
> -		goto out_err;
> -	}
> +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)

Hi Iwashima-san,

I think you need to set reason here.

Flagged by W=1 builds with clang-19.

> +		goto out_pipe;
>  
>  	while (sent < len) {
> -		size = len - sent;
> +		int size = len - sent;
> +		int data_len;
>  
>  		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
>  			skb = sock_alloc_send_pskb(sk, 0, 0,

...

-- 
pw-bot: changes-requested

