Return-Path: <netdev+bounces-83497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94F892A1F
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 10:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1326283515
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6818045;
	Sat, 30 Mar 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THahwfNx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA534179A6;
	Sat, 30 Mar 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792390; cv=none; b=mpWDHS1F3wTtWsrdo9JalfPe3/cC5sdrW3x+j3Mhl2qX/mKKcmtQrcVYo/6+C1CUL0Ez+KfJqHWl49lm7nHDrDYKemOFGVluge795hNNCsnK1NKxy+KxbLOAxurgw1URU5iSxDtLts5OeTAkiC/OBsej9NxIIaM5Cx6wRgnkvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792390; c=relaxed/simple;
	bh=6kh34bHcthGqlHrO/Hn60opsPoAyecYkLcoCkMkdVOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQQp3EMaMVKmsC828+X8GSd/LdpIXo+B0bVjyxC/Nsxns9PdxXvFjch6Z1kIhyXmPtL2NYVwqOQwAnJScfJjFJrKTPRQEPrv5pSQllXA/Hz618+d8V+HZ88OF0iA53MteXZFaprKAvYf94+GqPuOnvaarGGV1mDtrxZL1n36BqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THahwfNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C9C433C7;
	Sat, 30 Mar 2024 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792390;
	bh=6kh34bHcthGqlHrO/Hn60opsPoAyecYkLcoCkMkdVOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THahwfNxDpwSqq4X1JODLYsXP3knH5oY3pZR9qCtxwGIvE2hEJ84TlhEzjwH2nIQ8
	 zE/u/jaFZPwNzoTS43sx9UlNLF4+IvtIWnB/V5G0ydmaIibX9l8HrIMxKWh+n+qFL6
	 Nqs3AA3BCTOgRSH81hLLCquAhLv3PEpHAU/zLdCTLzhwElda6bZD/KKRRgE6bCud4o
	 tL0FihIpWuxFDYlXNlUVBResWRZTxNs1+e15n+TE9hQQKyNsxXIi2LnIDHI7I9rjau
	 GNJtSHJPDoMqXJham5+BO3ROpnZloute8wm6Uvzc7dtzZYEsszatBsKNomPp2EfsdZ
	 MJ6+yXQGXqpHg==
Message-ID: <d1c55f68-8afa-4f94-a7f6-8dba339c8790@kernel.org>
Date: Sat, 30 Mar 2024 10:53:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: prevent BPF accessing lowat from a subflow
 socket.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, bpf@vger.kernel.org
References: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 29/03/2024 19:50, Paolo Abeni wrote:
> Alexei reported the following splat:
> 
>  WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430 subflow_data_ready+0x147/0x1c0
>  Modules linked in: dummy bpf_testmod(O) [last unloaded: bpf_test_no_cfi(O)]
>  CPU: 32 PID: 3276 Comm: test_progs Tainted: GO       6.8.0-12873-g2c43c33bfd23
>  Call Trace:
>   <TASK>
>   mptcp_set_rcvlowat+0x79/0x1d0
>   sk_setsockopt+0x6c0/0x1540
>   __bpf_setsockopt+0x6f/0x90
>   bpf_sock_ops_setsockopt+0x3c/0x90
>   bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
>   bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x132
>   bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
>   __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
>   tcp_connect+0x879/0x1160
>   tcp_v6_connect+0x50c/0x870
>   mptcp_connect+0x129/0x280
>   __inet_stream_connect+0xce/0x370
>   inet_stream_connect+0x36/0x50
>   bpf_trampoline_6442491565+0x49/0xef
>   inet_stream_connect+0x5/0x50
>   __sys_connect+0x63/0x90
>   __x64_sys_connect+0x14/0x20
> 
> The root cause of the issue is that bpf allows accessing mptcp-level
> proto_ops from a tcp subflow scope.
> 
> Fix the issue detecting the problematic call and preventing any action.

Thank you for having looked at that! The patch looks good to me as well:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

FYI, the patch was also OK for our CI, but we don't run all BPF tests.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


