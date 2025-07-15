Return-Path: <netdev+bounces-207279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220ADB068D3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CC41AA6029
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 21:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110642749EC;
	Tue, 15 Jul 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bQgT4ZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE426AD9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616227; cv=none; b=QuldYwOJnwgPlsxm20K44296PDduetk/3g2+OURt2Q+EgV+b5tZGIfYCgDbxWQabktAcLkM0SCmQU+CQaq3wphg6N1wH2auqSpRdvme86EQzMkZsj30R7MKihcVth2N7czb5NZLwxNaco8fhYJB8oTDnLRk4jMNiect1wuGTdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616227; c=relaxed/simple;
	bh=7SBjb/w9yaoW5n+pl+NlR/ug56IehpiwfBG0m2/fvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnJxd5z+o3nDvbxYFmWqpuPjyY8fUdB3hYNoidE6f7W/jRTWjg6cxpzaq1QLiImS61fOs4yMvx/lC6e4/Mhi/XrUls3o95Qne+X9UY9CNtyWX8pSyR/+0ggqKkdPur+wlIel7SonJTDLTawhVBZTPW2g58mtyXDtOYS5uw7hf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bQgT4ZL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso6365323a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752616225; x=1753221025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvo3fY84WyhqmcbuVyYiwY3o8xPXeviLaqiJJ/E7jCk=;
        b=3bQgT4ZLozebSPbJ9+fPRHk80/0eVSr3bxqrMgcogCNnTP/+5GOjjFW7VrOUW1MPP/
         JY3caMWFiOmkHO9d6yiSWBM62YXgFCvoJdfk2Pr1r83oCZQz+uUH25S7fiZCIe+bdM/e
         dANXaBD3MtWwa0KBK0s98ttLyWsl4nYLCAXJGcI+ScWEk9LN3/aSauz7LU1LGyjleny3
         1IFzrwhcMP2XObIgA7DLT/bdr3nBuIvNmcvanclmwmeMRKLsLP+Fq2dDIucdwIah8tp1
         Y9euqhmzndyEGLqz/pZPYIavkEyQSoRRhvGshEIXpIAe2Ic87hWew4+1i9RmfjpgfXqf
         GgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752616225; x=1753221025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hvo3fY84WyhqmcbuVyYiwY3o8xPXeviLaqiJJ/E7jCk=;
        b=abfJIVMbLcMknscHEHVcjqcqfPxcBKP60GmtufLqmz+F8T7T29y7BV8GUlC6HLWFbo
         hN33+FSWPtmHpFHRQRHncJQ03Qz1ARKK4X+5p8H2yn7J5Eqs134herqlEtiBCmz4MjvS
         IB63grQsFBWXNNKlRMjgD8e5XnI37GGDt8H+fofJw9n4294Yp4aeY34FX2Im5tJldvb8
         UBQYuEllY+8aIJxZLSOrozXW2Q1OOwQgwws07+6JlUfXsLoqsgHVloDz+QRLi6WivhUr
         vWJWhVwRd9FmiEKx8UJqD81H3ecmQl1s1xG1GNNhxH/f/ZA0d+BfwKJOQobOcU1Cfp5R
         f4/w==
X-Gm-Message-State: AOJu0YyLaQDiLKNyXBsDEObvitIfwV1A5AjE2MEAxgtTMfzx48gBzaWX
	qH8YoaF5ZpzSOjM5gDOWSavS67MDc3EwhgjvUNLutB3JguqSQpM1Gw1rTSAgSe9UEsdJYfqkMiy
	8jCsaReqIqlNdAnqvoorHHrDxEXwBAUeaFj4/S7gr
X-Gm-Gg: ASbGncu4F1EfxI/pdiGs5MShSyGmmX9fME7oibMJcbnR0vEBVHafMroYgm5MhUn1ns2
	WMh9u+DCXcunnq0gPwgGDtArDV6K5gw75UD0KWrIltXYCAahE9QSVJbpxBAGIQfzV48G2NRFtVq
	g0ky7W+CpGSGOiFbUy0sC8UOIuOROwnZYFJWmAFzWtRLxzPTTeSQtaTGh3UHEyi0dZEHMcz/1q0
	UJNe232lPHosxPQPbbGO3cNj5P5WTpOSfbB
X-Google-Smtp-Source: AGHT+IHENSxZOHb/5CWKwRMWvCm3yXAEeH1ng7gMNz2Hird/264umCWYi1kxnssLPcS7v7YWExp+UIpdq6m3aSv6LVo=
X-Received: by 2002:a17:90b:3e47:b0:315:cbe0:13b3 with SMTP id
 98e67ed59e1d1-31c9f399399mr370051a91.7.1752616224511; Tue, 15 Jul 2025
 14:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b78d2d9bdccca29021eed9a0e7097dd8dc00f485.1752567053.git.pabeni@redhat.com>
In-Reply-To: <b78d2d9bdccca29021eed9a0e7097dd8dc00f485.1752567053.git.pabeni@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 14:50:12 -0700
X-Gm-Features: Ac12FXw0xHFM5G2Sp7cRneGw4FmY3kdiupqkddzVm1RiF8MVBSDl0gZExlRKPcE
Message-ID: <CAAVpQUCDkfRxGrJ2t8oN3o75EKG80rEi1u71yDhOWJPAVUwX+Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix UaF in tcp_prune_ofo_queue()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The CI reported a UaF in tcp_prune_ofo_queue():
>
> BUG: KASAN: slab-use-after-free in tcp_prune_ofo_queue+0x55d/0x660
> Read of size 4 at addr ffff8880134729d8 by task socat/20348
>
> CPU: 0 UID: 0 PID: 20348 Comm: socat Not tainted 6.16.0-rc5-virtme #1 PRE=
EMPT(full)
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x82/0xd0
>  print_address_description.constprop.0+0x2c/0x400
>  print_report+0xb4/0x270
>  kasan_report+0xca/0x100
>  tcp_prune_ofo_queue+0x55d/0x660
>  tcp_try_rmem_schedule+0x855/0x12e0
>  tcp_data_queue+0x4dd/0x2260
>  tcp_rcv_established+0x5e8/0x2370
>  tcp_v4_do_rcv+0x4ba/0x8c0
>  __release_sock+0x27a/0x390
>  release_sock+0x53/0x1d0
>  tcp_sendmsg+0x37/0x50
>  sock_write_iter+0x3c1/0x520
>  vfs_write+0xc09/0x1210
>  ksys_write+0x183/0x1d0
>  do_syscall_64+0xc1/0x380
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcf73ef2337
> Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e f=
a 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffd4f924708 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcf73ef2337
> RDX: 0000000000002000 RSI: 0000555f11d1a000 RDI: 0000000000000008
> RBP: 0000555f11d1a000 R08: 0000000000002000 R09: 0000000000000000
> R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000008
> R13: 0000000000002000 R14: 0000555ee1a44570 R15: 0000000000002000
>  </TASK>
>
> Allocated by task 20348:
>  kasan_save_stack+0x24/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_slab_alloc+0x59/0x70
>  kmem_cache_alloc_node_noprof+0x110/0x340
>  __alloc_skb+0x213/0x2e0
>  tcp_collapse+0x43f/0xff0
>  tcp_try_rmem_schedule+0x6b9/0x12e0
>  tcp_data_queue+0x4dd/0x2260
>  tcp_rcv_established+0x5e8/0x2370
>  tcp_v4_do_rcv+0x4ba/0x8c0
>  __release_sock+0x27a/0x390
>  release_sock+0x53/0x1d0
>  tcp_sendmsg+0x37/0x50
>  sock_write_iter+0x3c1/0x520
>  vfs_write+0xc09/0x1210
>  ksys_write+0x183/0x1d0
>  do_syscall_64+0xc1/0x380
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 20348:
>  kasan_save_stack+0x24/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x38/0x50
>  kmem_cache_free+0x149/0x330
>  tcp_prune_ofo_queue+0x211/0x660
>  tcp_try_rmem_schedule+0x855/0x12e0
>  tcp_data_queue+0x4dd/0x2260
>  tcp_rcv_established+0x5e8/0x2370
>  tcp_v4_do_rcv+0x4ba/0x8c0
>  __release_sock+0x27a/0x390
>  release_sock+0x53/0x1d0
>  tcp_sendmsg+0x37/0x50
>  sock_write_iter+0x3c1/0x520
>  vfs_write+0xc09/0x1210
>  ksys_write+0x183/0x1d0
>  do_syscall_64+0xc1/0x380
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888013472900
>  which belongs to the cache skbuff_head_cache of size 232
> The buggy address is located 216 bytes inside of
>  freed 232-byte region [ffff888013472900, ffff8880134729e8)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1347=
2
> head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x80000000000040(head|node=3D0|zone=3D1)
> page_type: f5(slab)
> raw: 0080000000000040 ffff88800198fb40 ffffea0000347b10 ffffea00004f5290
> raw: 0000000000000000 0000000000120012 00000000f5000000 0000000000000000
> head: 0080000000000040 ffff88800198fb40 ffffea0000347b10 ffffea00004f5290
> head: 0000000000000000 0000000000120012 00000000f5000000 0000000000000000
> head: 0080000000000001 ffffea00004d1c81 00000000ffffffff 00000000ffffffff
> head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff888013472880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888013472900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888013472980: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>                                                     ^
>  ffff888013472a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888013472a80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>
> Indeed tcp_prune_ofo_queue() is reusing the skb dropped a few lines
> above. The caller wants to enqueue 'in_skb', lets check space vs the
> latter.
>
> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Only build tested: I would appreciate an additional pair of eyes...

Thanks for catching this!

I fed the diff to syzbot just in case and it didn't find other issues
https://syzkaller.appspot.com/bug?extid=3D865aca08c0533171bf6a

Tested-by: syzbot+865aca08c0533171bf6a@syzkaller.appspotmail.com
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 9c5baace4b7b..672cbfbdcec1 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5517,7 +5517,7 @@ static bool tcp_prune_ofo_queue(struct sock *sk, co=
nst struct sk_buff *in_skb)
>                 tcp_drop_reason(sk, skb, SKB_DROP_REASON_TCP_OFO_QUEUE_PR=
UNE);
>                 tp->ooo_last_skb =3D rb_to_skb(prev);
>                 if (!prev || goal <=3D 0) {
> -                       if (tcp_can_ingest(sk, skb) &&
> +                       if (tcp_can_ingest(sk, in_skb) &&
>                             !tcp_under_memory_pressure(sk))
>                                 break;
>                         goal =3D sk->sk_rcvbuf >> 3;
> --
> 2.50.0
>

