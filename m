Return-Path: <netdev+bounces-229311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DABDA6F4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 779CC545430
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE983002CA;
	Tue, 14 Oct 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNgSryB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3F2FBDE9;
	Tue, 14 Oct 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455667; cv=none; b=oZL2i22CowHsgSxrUmIU8GBizHYcKYAi2yqBAUmY/eZy5VJ8+7DQd1D1axrkt+sse3WmKsSyN8NuJ3C3JCnd3yrgCQYFttls4Gj+VPW22s03M//ej5V9mNJExtlId2KA6dks0nWU5lJByPLNDFEBVEkfjQwzKRqEVZa3BqWDAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455667; c=relaxed/simple;
	bh=rcbQ/4zVKPt71QNu9FJMs9RnxpPz+SCqZaHgRW8i6xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNwWdP38uuejwvEmHYAxwPBTph2BDpcrJnTBbjoa26HfqcYQGzdULa+oQmD6UWsaEAhmTtHUffgCKOtdp+WTcGDhocl4juRdbx6ntyidsMJgMjPuQLdnBuKgS3GV9JvyYwXE2j+XbixN3lKmUFDrhY4DBUYuKf3G7LqhDxf31GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNgSryB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E376C4CEE7;
	Tue, 14 Oct 2025 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455667;
	bh=rcbQ/4zVKPt71QNu9FJMs9RnxpPz+SCqZaHgRW8i6xw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cNgSryB+BZuqNdIe8HWdP29pEuHcFy+pTb7q0EsxHOIKC1M6hctcZ3JfySAzPW7gv
	 yq9ea8HY+WFyN9Oi98YXBp0KVGTZW6D+mUU6BHHnUobvgZp+3YlFNfukqendjM9A+m
	 4ZbR2e4Eu4INVDKLAj1Xg7BX4HuuWI0HwRdMAG+d9eQmvAFSg4SLUhKQDG0DgKuoAC
	 BATlcMW2YW8xmJy5cBIfgN5irj6eWgttXzmvlyPnPa9fozv1ZVEHIoLFsFMVyFb0MN
	 JAyWg9fSI09X8+pM7YNyPYqFPJ5FdKFW7yfNjdWxM7ZXppDypjc0IIYmYcKJGs5hMI
	 wgDUlgv8hkx5Q==
Message-ID: <f046fdda-3bad-4f7f-8587-dca30d183f82@kernel.org>
Date: Tue, 14 Oct 2025 17:27:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v1] mptcp: fix incorrect IPv4/IPv6 check
Content-Language: en-GB, fr-BE
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Davide Caratti <dcaratti@redhat.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251014122619.316463-1-jiayuan.chen@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251014122619.316463-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiayuan,

Thank you for sharing this patch!

On 14/10/2025 14:26, Jiayuan Chen wrote:
> When MPTCP falls back to normal TCP, it needs to reset proto_ops. However,
> for sockmap and TLS, they have their own custom proto_ops, so simply
> checking sk->sk_prot is insufficient.
> 
> For example, an IPv6 request might incorrectly follow the IPv4 code path,
> leading to kernel panic.

Did you experiment issues, or is it a supposition? If yes, do you have
traces containing such panics (or just a WARN()?), and ideally the
userspace code that was leading to this?

What is unclear to me is how you got an MPTCP + TLS + sockmap socket.
And if yes, can we set sk_socket->ops to inet(6)_stream_ops and nothing
else without having any other issues?

And do we maybe have to update some code in subflow.c also looking at
sk->sk_prot? I guess no because there, the socket is created by MPTCP,
and it should be set to tcp(v6)_prot. Except if there is some BPF code
that can change that?

> Note that Golang has enabled MPTCP by default [1]
> 
> [1] https://go-review.googlesource.com/c/go/+/607715
> 
> Fixes: 8e2b8a9fa512 ("mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()")
If I understand the issue correctly, was it not present from the
beginning, before the mentioned commit?

> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/mptcp/protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0292162a14ee..efcdaeff91f8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -62,10 +62,10 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (sk->sk_prot == &tcpv6_prot)
> +	if (sk->sk_family == AF_INET6)

sk_prot was proving it was a TCP + IPv4/6 socket, and then that's OK to
set inet(6)_stream_ops. I guess we could only check the family, but, can
we always return inet(6)_stream_ops no matter what sk->sk_prot is?

If the protocol has been modified, the stream one has maybe been
modified too, no?

>  		return &inet6_stream_ops;
>  #endif
> -	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
> +	WARN_ON(sk->sk_family != AF_INET);

Please keep the WARN_ON_ONCE().

Maybe we should not return inet_stream_ops in case the previous
condition was wrong, and not change sk_socket->ops.

>  	return &inet_stream_ops;
>  }

Note about the subject: if it is a fix for an older commit, it should
target 'net', not 'net-next' (+ cc stable). Can you also have a clearer
subject mentioning 'proto' and 'fallback' please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


