Return-Path: <netdev+bounces-241957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E90EC8B028
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025343A830F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB633D6E6;
	Wed, 26 Nov 2025 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTjXxYcT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77933A6E5;
	Wed, 26 Nov 2025 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175005; cv=none; b=E6GroFhPj0UDzFdw0SYacn0pzfB9QVI57MtsBSwpCnAUpqDhWDycuBPu5AsCmF4a//EsXqm4RNSJ6WZm904Tcv/ueZQojCM7s0VUA9Y9womfQ4zvUoOlS4aYM2DprPoWeeeF7xL+kJdosHzSnpJzili0L7v2tBs4JrHbnfDU3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175005; c=relaxed/simple;
	bh=03fMF5LW9IFE3tRkyLEnUJ0Ww92EXK15IwGQVM2Y7Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QL65JAMIU97MJcyoEaknIqqFCKacAHGEutywlEkz+7OAOT/1uqudcusGcuu9jOR251hWGS92Syq7qCkXFQOy6cXocxrtgb4YJfgDeZjiEYNOQQe/3M1pxbrA7xgFnNX+m5xfwdLZabJ2Vj7dj17ZTsuCrckPmBbebGpfrnmeAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTjXxYcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2E3C113D0;
	Wed, 26 Nov 2025 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764175005;
	bh=03fMF5LW9IFE3tRkyLEnUJ0Ww92EXK15IwGQVM2Y7Ys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fTjXxYcTmEAgRUnQ3TbeF8OC40KdBYeYBtLdV5mGBlE6LOVaVuyUxOiUxVbs90YWt
	 wDp6OolGeR8LvVc2VMf677njqDlU+BWZ84dj+jcwpbQfqjyzOHH88oC/rNkmQHZLeM
	 kPY+iGMrsBJheYDzCa81oKUYHEg1KNARZ56h0vvZsSx9dUi9Enl2iwMCVKLsDd2duI
	 Ma8P/dv0BcHPKKcgEy5a4gQ1M/1nb849Qib9B15DTuFDJu7fCotoSVfb5BUwTQ53cM
	 S4JYd/DHP+cGEaYbf9LYsVdCk1qxE75oUJzDwmawrm/cuxBEqZri2Qk0aHJKn32jcf
	 0fp7inxqVa2Ng==
Message-ID: <bd417bb2-212b-4657-a509-e0ed0edb5647@kernel.org>
Date: Wed, 26 Nov 2025 17:36:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v1 net-next] mptcp: Initialise rcv_mss before calling
 tcp_send_active_reset() in mptcp_do_fastclose().
Content-Language: en-GB, fr-BE
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20251125195331.309558-1-kuniyu@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251125195331.309558-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

(+Cc MPTCP ML)

On 25/11/2025 20:53, Kuniyuki Iwashima wrote:
> syzbot reported divide-by-zero in __tcp_select_window() by
> MPTCP socket. [0]

Thank you for having released this bug report, and even more for having
sent the fix!

> We had a similar issue for the bare TCP and fixed in commit
> 499350a5a6e7 ("tcp: initialize rcv_mss to TCP_MIN_MSS instead
> of 0").
> 
> Let's apply the same fix to mptcp_do_fastclose().
> 
> [0]:
> Oops: divide error: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
> Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c 41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
> RSP: 0018:ffffc90003017640 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
> R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  tcp_select_window net/ipv4/tcp_output.c:281 [inline]
>  __tcp_transmit_skb+0xbc7/0x3aa0 net/ipv4/tcp_output.c:1568
>  tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
>  tcp_send_active_reset+0x2d1/0x5b0 net/ipv4/tcp_output.c:3836
>  mptcp_do_fastclose+0x27e/0x380 net/mptcp/protocol.c:2793
>  mptcp_disconnect+0x238/0x710 net/mptcp/protocol.c:3253
>  mptcp_sendmsg_fastopen+0x2f8/0x580 net/mptcp/protocol.c:1776

Note: arf, sorry, I just noticed my small syzkaller instances found it
too, and I should have caught it before. I thought this issue was linked
to another one [1]. It is not: this one here is specific to TFO where
mptcp_disconnect() is called directly in one error path not cover by the
selftests.

[1]
https://lore.kernel.org/20251125-net-mptcp-clear-sched-rtx-v1-1-1cea4ad2165f@kernel.org

>  mptcp_sendmsg+0x1774/0x1980 net/mptcp/protocol.c:1855
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0xe5/0x270 net/socket.c:742
>  __sys_sendto+0x3bd/0x520 net/socket.c:2244
>  __do_sys_sendto net/socket.c:2251 [inline]
>  __se_sys_sendto net/socket.c:2247 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2247
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f66e998f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffff9acedb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f66e9be5fa0 RCX: 00007f66e998f749
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
>  </TASK>
> 
> Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")

I see that this patch targets "net-next". I think it would be better to
target "net". No need to send a new version, this patch applies on top
of "net" without conflicts, and Paolo told me he can apply it on top of
"net".

The patch looks good to me, and can be applied to "net" directly:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


While at it, just to help me to track the backports:

Cc: stable@vger.kernel.org


> Reported-by: syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69260882.a70a0220.d98e3.00b4.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/mptcp/protocol.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 75bb1199bed9..40a8bdd5422a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2790,6 +2790,12 @@ static void mptcp_do_fastclose(struct sock *sk)
>  			goto unlock;
>  
>  		subflow->send_fastclose = 1;
> +
> +		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
> +		 * issue in __tcp_select_window(), see tcp_disconnect().
> +		 */
> +		inet_csk(ssk)->icsk_ack.rcv_mss = TCP_MIN_MSS;


I initially thought this should have been set in mptcp_sendmsg_fastopen,
before calling mptcp_disconnect(), but doing that here is probably safer
to catch other cases, and it aligns with tcp_disconnect(). So that's
perfect, no need to change anything!


> +
>  		tcp_send_active_reset(ssk, ssk->sk_allocation,
>  				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
>  unlock:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


