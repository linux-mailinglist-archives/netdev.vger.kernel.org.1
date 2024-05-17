Return-Path: <netdev+bounces-97030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A48C8D46
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069901F22A6F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0913DDB0;
	Fri, 17 May 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0KOR8ls"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFD65C
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715977708; cv=none; b=ZcXa73qL9cEKsUs3j4eIS7l6VPmE3bYbSVDT6IvUVIG49yNTAErbZVApdvyYtWtru+CJMQjNKuhDa9nAnvqWjGtVWQ+vFb5NVnexCvMqml3U3krMCtZLTNZDwrpl5rFT0cHMpEAg8FOUuMJ2GZIKWUmtEamuO9MJiGOeWu9nXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715977708; c=relaxed/simple;
	bh=ZROc9VrwBMl0NjaXjGn2JI/4h3n53FuL6lyKjP9d+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drJZJY+sG2rsd28RFhWQ3ToJCCvhiFoJ1UkmHwdJKuw5MWzx/n+SnvVTph6jtPqht9ViQYaaDmOv8SCvD4J+uLNXLnl3FOv8vTYk4vLMuOQoMVPyDvxD7EIiFovvYHU9IhLI/XxmpsCAMHLJmrTz3mTiu16Fx336TxwSiJCMCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0KOR8ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268F7C2BD10;
	Fri, 17 May 2024 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715977708;
	bh=ZROc9VrwBMl0NjaXjGn2JI/4h3n53FuL6lyKjP9d+Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0KOR8lsubVpcNVsY67x+kKam0bXj+W3buDA85s8WlGMDtwUtJHcFyIAzie0WjNzg
	 Y9gYVEKuGJDUfCFTqx97EG39jt7rSZf+rqQMdFcTno5rThjyavGI7YZ7zMJOJL0HGi
	 GqpTA4bfbLCQ6mPgvUaO7wc2KqGlyryc4q1S1Uv/myO92T5zTbCWgpVthMCb8cVMt+
	 Pt9sRe91/5oJD9UgYZGieZXslwUGp7j8Ffs6E6zJSRPtJUIKZhnWKeF/fI4b/asllU
	 Ngww7PGzIQyGDZPVekCLcs0rbX3geJryszL+GBLzV+NqIowUF9piYMTyZtCu/N/EJg
	 qejX0G2XjcQhg==
Date: Fri, 17 May 2024 21:28:22 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Florian Westphal <fw@strlen.de>,
	Glenn Judd <glenn.judd@morganstanley.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Yue Sun <samsun1006219@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix shift-out-of-bounds in
 dctcp_update_alpha().
Message-ID: <20240517202822.GA477004@kernel.org>
References: <20240517091626.32772-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517091626.32772-1-kuniyu@amazon.com>

On Fri, May 17, 2024 at 06:16:26PM +0900, Kuniyuki Iwashima wrote:
> In dctcp_update_alpha(), we use a module parameter dctcp_shift_g
> as follows:
> 
>   alpha -= min_not_zero(alpha, alpha >> dctcp_shift_g);
>   ...
>   delivered_ce <<= (10 - dctcp_shift_g);
> 
> It seems syzkaller started fuzzing module parameters and triggered
> shift-out-of-bounds [0] by setting 100 to dctcp_shift_g:
> 
>   memcpy((void*)0x20000080,
>          "/sys/module/tcp_dctcp/parameters/dctcp_shift_g\000", 47);
>   res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x20000080ul,
>                 /*flags=*/2ul, /*mode=*/0ul);
>   memcpy((void*)0x20000000, "100\000", 4);
>   syscall(__NR_write, /*fd=*/r[0], /*val=*/0x20000000ul, /*len=*/4ul);
> 
> Let's limit the max value of dctcp_shift_g by param_set_uint_minmax().
> 
> With this patch:
> 
>   # echo 10 > /sys/module/tcp_dctcp/parameters/dctcp_shift_g
>   # cat /sys/module/tcp_dctcp/parameters/dctcp_shift_g
>   10
>   # echo 11 > /sys/module/tcp_dctcp/parameters/dctcp_shift_g
>   -bash: echo: write error: Invalid argument
> 
> [0]:
> UBSAN: shift-out-of-bounds in net/ipv4/tcp_dctcp.c:143:12
> shift exponent 100 is too large for 32-bit type 'u32' (aka 'unsigned int')
> CPU: 0 PID: 8083 Comm: syz-executor345 Not tainted 6.9.0-05151-g1b294a1f3561 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x201/0x300 lib/dump_stack.c:114
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x346/0x3a0 lib/ubsan.c:468
>  dctcp_update_alpha+0x540/0x570 net/ipv4/tcp_dctcp.c:143
>  tcp_in_ack_event net/ipv4/tcp_input.c:3802 [inline]
>  tcp_ack+0x17b1/0x3bc0 net/ipv4/tcp_input.c:3948
>  tcp_rcv_state_process+0x57a/0x2290 net/ipv4/tcp_input.c:6711
>  tcp_v4_do_rcv+0x764/0xc40 net/ipv4/tcp_ipv4.c:1937
>  sk_backlog_rcv include/net/sock.h:1106 [inline]
>  __release_sock+0x20f/0x350 net/core/sock.c:2983
>  release_sock+0x61/0x1f0 net/core/sock.c:3549
>  mptcp_subflow_shutdown+0x3d0/0x620 net/mptcp/protocol.c:2907
>  mptcp_check_send_data_fin+0x225/0x410 net/mptcp/protocol.c:2976
>  __mptcp_close+0x238/0xad0 net/mptcp/protocol.c:3072
>  mptcp_close+0x2a/0x1a0 net/mptcp/protocol.c:3127
>  inet_release+0x190/0x1f0 net/ipv4/af_inet.c:437
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xc0/0x240 net/socket.c:1421
>  __fput+0x41b/0x890 fs/file_table.c:422
>  task_work_run+0x23b/0x300 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x9c8/0x2540 kernel/exit.c:878
>  do_group_exit+0x201/0x2b0 kernel/exit.c:1027
>  __do_sys_exit_group kernel/exit.c:1038 [inline]
>  __se_sys_exit_group kernel/exit.c:1036 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xe4/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f6c2b5005b6
> Code: Unable to access opcode bytes at 0x7f6c2b50058c.
> RSP: 002b:00007ffe883eb948 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f6c2b5862f0 RCX: 00007f6c2b5005b6
> RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
> RBP: 0000000000000001 R08: 00000000000000e7 R09: ffffffffffffffc0
> R10: 0000000000000006 R11: 0000000000000246 R12: 00007f6c2b5862f0
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
>  </TASK>
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Yue Sun <samsun1006219@gmail.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAEkJfYNJM=cw-8x7_Vmj1J6uYVCWMbbvD=EFmDPVBGpTsqOxEA@mail.gmail.com/
> Fixes: e3118e8359bb ("net: tcp: add DCTCP congestion control algorithm")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>

