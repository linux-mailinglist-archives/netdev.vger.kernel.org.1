Return-Path: <netdev+bounces-83451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE908924A5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF01C213F1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997613A403;
	Fri, 29 Mar 2024 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izfIS6r5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5010942;
	Fri, 29 Mar 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741988; cv=none; b=tSRYUhfsvrbFrIvVc2i2FkMfu21U0cWMTH6rvft3iY+BFMxzwZiAbpwoHt6TIfYMtYNHWk2GVSe1DTBRN8T+Ft3AZsd5ayB2Qj6iEcIZrPdexY5p/NSLGETC3pVi690XfuVoBvTOBi5onzmxfdew7M8BWKUozJZr954oBz2aff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741988; c=relaxed/simple;
	bh=hYQtK+VuVvgg8lPKFuE+XCfswrikJuLqP6/ufQ7d/Zc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lkaRzYd/TeGyPNHmQxBbAF1ozJLam3uOUzM6j7+VaRS5RNSYkkf1a+cSb8GzQ94gudXjAEXpwv9bSjKAF/NiPXGEII8nyTDMeuKZpd3w1FrtKQ1xYgAa7JxDNNZ5gqpZjrfDME/4FcRpQVBgfAZL2St9h8+wHDlU95jwd/rxCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izfIS6r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8603C433F1;
	Fri, 29 Mar 2024 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711741987;
	bh=hYQtK+VuVvgg8lPKFuE+XCfswrikJuLqP6/ufQ7d/Zc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=izfIS6r5t8/x4rdeXFXlHXwMsJJbw+TZI4vbaTo8m+X69nsBEth/UgoYcgRpm0dem
	 SBqPLIWdVFZvUYwHBOz/itAniKM8CFN4o6zRBAsCvU6/7cgmYmSDqBEuDxrsA5OO56
	 W0/rVaRsYEhiqSyCLSExvDfnxmrQobrNtfDA12+mYTNFHza0y6POs36qkGXERlj9xy
	 dDAIQEqp1+CMokROovkG7Qv348koI4o5weLFwd+uELWpIGV30bM1qjWpq4H9Jbx5FG
	 A3N2/l1pZdL+iSkxDx13RZDxt+4jwBs0O3uG5rRNhCoMxhX2ZbImYzQ42wjcHAT4Wt
	 2DubPdflwrsOw==
Date: Fri, 29 Mar 2024 12:53:06 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
    Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    mptcp@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net] mptcp: prevent BPF accessing lowat from a subflow
 socket.
In-Reply-To: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
Message-ID: <2a68e09b-936c-447d-bfe8-bd043c94306c@kernel.org>
References: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Mar 2024, Paolo Abeni wrote:

> Alexei reported the following splat:
>
> WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430 subflow_data_ready+0x147/0x1c0
> Modules linked in: dummy bpf_testmod(O) [last unloaded: bpf_test_no_cfi(O)]
> CPU: 32 PID: 3276 Comm: test_progs Tainted: GO       6.8.0-12873-g2c43c33bfd23
> Call Trace:
>  <TASK>
>  mptcp_set_rcvlowat+0x79/0x1d0
>  sk_setsockopt+0x6c0/0x1540
>  __bpf_setsockopt+0x6f/0x90
>  bpf_sock_ops_setsockopt+0x3c/0x90
>  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
>  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x132
>  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
>  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
>  tcp_connect+0x879/0x1160
>  tcp_v6_connect+0x50c/0x870
>  mptcp_connect+0x129/0x280
>  __inet_stream_connect+0xce/0x370
>  inet_stream_connect+0x36/0x50
>  bpf_trampoline_6442491565+0x49/0xef
>  inet_stream_connect+0x5/0x50
>  __sys_connect+0x63/0x90
>  __x64_sys_connect+0x14/0x20
>

Thanks Paolo, change LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> The root cause of the issue is that bpf allows accessing mptcp-level
> proto_ops from a tcp subflow scope.

What should we do about this root cause going forward? Does this fall on 
the MPTCP subsystem to add special checks in places where proto_ops are 
accessed via sk_socket? Or is there a more generic way to catch this?

- Mat


>
> Fix the issue detecting the problematic call and preventing any action.
>
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/482
> Fixes: 5684ab1a0eff ("mptcp: give rcvlowat some love")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/sockopt.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index dcd1c76d2a3b..73fdf423de44 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1493,6 +1493,10 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
> 	struct mptcp_subflow_context *subflow;
> 	int space, cap;
>
> +	/* bpf can land here with a wrong sk type */
> +	if (sk->sk_protocol == IPPROTO_TCP)
> +		return -EINVAL;
> +
> 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
> 		cap = sk->sk_rcvbuf >> 1;
> 	else
> -- 
> 2.43.2
>
>

