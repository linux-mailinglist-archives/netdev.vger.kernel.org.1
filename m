Return-Path: <netdev+bounces-78841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7AF876BD1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A9F1F2208A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB55D460;
	Fri,  8 Mar 2024 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7dAGUEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566E5B666;
	Fri,  8 Mar 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929574; cv=none; b=I0gHDz/pfQ7XI+Hr1GJnwI1b0+pBigo4L7QckijKZ/g1apQqEVzvFFiHx5IvKpcAWtoVPfox/f/TLc9gS07aRIE9q25zkfGBXtOfeTdEVSjaeMVQM1u5cDr9wcMOJ0SIqlKiMeVYOFZWf9ocjrw8y1+AE8mYrK9q9WPIrMctKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929574; c=relaxed/simple;
	bh=xOQAFgzUnSYHJaX/ksMi8tAAakBzboNkECyhONjBcsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WJdCOakvTnZGM8KpjJnGt92OI6T2x7sLz+fXTitafoCZiuZqSUz+Dg84fgDvvpebX35u71nLrMEFIp8yGqZ3ezWrirykbUXvW7IXnWQbxI1WQXsL0iXtHFSbov3+DwfqDt3g/7IJgMKH6a49ybkI5v1t/vC1vPSIr9KiAyWkRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7dAGUEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BF1C433F1;
	Fri,  8 Mar 2024 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709929573;
	bh=xOQAFgzUnSYHJaX/ksMi8tAAakBzboNkECyhONjBcsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=A7dAGUEIfoLuOBPVRS0kThRQWCXM2VL4HwYKhQ3hJ5YX9NaNH4sClUVvRpry/CWYN
	 A4xYjb7lhE5Gev81ullgMu86s8plsMed7n24+TOZRY+LhqZ8AX7spvFwcL1GmL7/oT
	 nWswAUQuCpCw24opxujTtAiueWMmS7WSShNl1Mr2STIzrmiifzttPObGybvV44+1hH
	 +OwsJ3kCJkw3Q8k8pvJLfgsFz+4sStR822cf0ibviY1Ucb/wHeyt8iKj0VOYxk+eP4
	 T5qr6lfZqtj6y/WJSkriXZS6f/tUE/Vmt5GZcvkVm+myaeGh+JAPvBKdizmuH2SAh4
	 6t4xLf5sA3Zxg==
Date: Fri, 8 Mar 2024 12:26:09 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
cc: edumazet@google.com, dsahern@kernel.org, 
    Matthieu Baerts <matttbe@kernel.org>, geliang@kernel.org, kuba@kernel.org, 
    Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
    mptcp@lists.linux.dev, netdev@vger.kernel.org, 
    Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] mptcp: annotate a data-race around
 sysctl_tcp_wmem[0]
In-Reply-To: <20240308112504.29099-2-kerneljasonxing@gmail.com>
Message-ID: <51583ac1-3717-269a-907f-992e009dc045@kernel.org>
References: <20240308112504.29099-1-kerneljasonxing@gmail.com> <20240308112504.29099-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 8 Mar 2024, Jason Xing wrote:

> From: Jason Xing <kernelxing@tencent.com>
>
> It's possible that writer and the reader can manipulate the same
> sysctl knob concurrently. Using READ_ONCE() to prevent reading
> an old value.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> net/mptcp/protocol.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f16edef6026a..a10ebf3ee10a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -850,7 +850,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
> 	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
> 		return;
>
> -	new_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[0];
> +	new_sndbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]);
> 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> 		ssk_sndbuf =  READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_sndbuf);
>

Looks good to me, thanks Jason.

Reviewed-by: Mat Martineau <martineau@kernel.org>


