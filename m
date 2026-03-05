Return-Path: <netdev+bounces-264323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGbII4BrqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:39:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5EE210B09
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6AD0304C7D7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B0378D85;
	Thu,  5 Mar 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qq868KBM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66874223DD6
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710765; cv=none; b=HuHPi54dH5Fm5dUsuiLbODeB519P4Sgv2GbQvwzZcFWs+V6pZghbjzvxex0iagNIBBT5SK8h/Lxk1lCuvQ+ar02XxWelmnLh+KOoMLx1YaYOpxnwI4B+GODRk4mjwsk8yIsbVUKk5ulC+j5ZkUmPq5JZDf3y+tB8f2PP1wwDnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710765; c=relaxed/simple;
	bh=bRM+Z8TRqy+7khM6Y/tE2QgluvkMOuKZQbK7SF0Kjr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uZhOOd9hQKR18gromw92Wi6VvZu/N64oOmBKjkjr625yzItxJuK54Gkd0wqkI+lrgPQC1RcA76sUFtO65ai4xa0iVmBt8YJwnzSodyAQv3/nVNrbAfb4PFAIqDcQCUnydoeogHOhfoNSwBJvMOcYVB9VIuLgT5/XVl8Yu2ZmCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qq868KBM; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b9360037cdfso1195484666b.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772710762; x=1773315562; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAOkhEnhzPo5xZRNqtX6dTKBEVvp+75/lvQ1sFK3ki4=;
        b=Qq868KBMP2TERpLw12dWHqEKRLWzTRwcOk1Qs5IngnDB/svTRb2/9bWt8H8qDpCREv
         CO8UNa+4OJheZHQm3uRZLp4utHYua2399cTs3pSdohi1dFYqiG7xsApNkqJ568wSdPot
         CCwCsR2JqeFFJHLde7lIFPn0fGkGdV+aOJo0uA3Lv/sK3TL63tZ35xc5iatDrSkZhQGC
         33AAirHxhlt/mUNB3L7ekA6HQU6CysrrCbJpr6+BihxQ8z4woKH9pEDIWKaxwa3iQ+C+
         c8OakZ78Nc8iMz6Sqx+JTC/wUf65WaCahDqYqyzNiEPdbDkSlt1HMzMoG8Jdi7ltFRi9
         9l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710762; x=1773315562;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAOkhEnhzPo5xZRNqtX6dTKBEVvp+75/lvQ1sFK3ki4=;
        b=CrgNnF4TtaEd+eQ0qSUpYv6IwNzWpVnG0JetwoHItATHuZmOMfswrxTZGAsq71ZfpX
         vJhUtz2UDn/R4lq5YfnW5XGy5N5uvxq55PVHstfRFUMf397TFSFSIClpx0UFOwZAyaVT
         mz1TQi5MQIvp+L44Q6PuLrCHA1tut8KSeb6pdsnwTjhsljNHCz9rC3omscrMBO7QMMqW
         z0cFSBGdicG5ZhK35ueqQnoOJrg5yumhJTaMKSxmW0hRGjS0spNkCLH74X0D9LBXRE9R
         pxVUsO13LZ5UM0vlrZCSjzDLAeDN4uMnSxW4AqJpdX5YeZCPPirSp7H7bESvsX9tkV1y
         sErg==
X-Forwarded-Encrypted: i=1; AJvYcCV1LdEsHGSHnLR4QzAtMw7K6J1Zf1DrjqGB9qITOVF8SiWtG0Zpcy0/ljgahdFvrzWmaEJO+uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmXtIvwpykSSvF1FEzeBZzoRpi1KRhGMBbIDaNfaGwN2zyuL/
	A89LVXsV5BjtEgW5907adAlbNkOslLGbB5CJYeDswWZ1Ou6hTNN6JkEhYWvVN9dCkxY=
X-Gm-Gg: ATEYQzyKFZ2iPFBWJWEoamkwRPuGnQ31+jPODmCQHgSC2+/2uBc8LM2sFfjVsXWN+jK
	pScJ375EkL2lO1Br3kHvCNOftiCJKVO7zPStXfAQTJAqD1Cek5pPlduZW2gHdbDxp1fKXzwwrUI
	q1rHugS0XCEcgUf0wE4CnL5QmA8ps8s2P+wK3q2Mm73gQQUBkYMkisrm1kw/B3SYa98BlK9M16/
	G0Gu3SCU/9KzU6V+r8WLzVMmc5OsE7waHCrs0b5LzuzeSsqVioF5Yg6bMidb616K75WyrhERb96
	N4ESORlzYjAhqVyp5XcCcawhOPbVFJ3OPBd8RYWPvG4vsMORAINiKCN2E0iQtMCwSfjNgL3DgOv
	MZYK3if21XMpf8uz8sFj+aNf5R3gP4MoOHmuKPle1Yy0MpWO5jUtzMF0KvJsEjfX3PF8bYcIECi
	c4Varcg+jUcOw/Enmo1waj0RUuZH/J/BKtRl9ashCdKea+MEzTOe8n2ajq4z+ldBHIdF4/lw==
X-Received: by 2002:a17:906:c148:b0:b93:609a:1519 with SMTP id a640c23a62f3a-b93f15a7d55mr401408566b.48.1772710761619;
        Thu, 05 Mar 2026 03:39:21 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac513bcsm891702966b.19.2026.03.05.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:39:21 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in
 udp_bpf_recvmsg().
In-Reply-To: <20260221233234.3814768-4-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Sat, 21 Feb 2026 23:30:50 +0000")
References: <20260221233234.3814768-1-kuniyu@google.com>
	<20260221233234.3814768-4-kuniyu@google.com>
Date: Thu, 05 Mar 2026 12:39:20 +0100
Message-ID: <875x7ao68n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: EE5EE210B09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-264323-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,9307c991a6d07ce6e6d8];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0]
>
> sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> but its processing is lockless.
>
> Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> multiple threads could touch the same sk_msg.
>
> For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock.
>
> Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> commit accidentally removed it.

FWIW, it doesn't sound like commit 9f2470fbc4cb ("skmsg: Improve
udp_bpf_recvmsg() accuracy") removed it by accident. The commit message
calls it out explicitly:

    Also, UDP does not lock the sock during BH Rx path, it makes
    no sense for its ->recvmsg() to lock the sock. It is always
    possible for ->recvmsg() to be called before packets actually
    arrive in the receive queue, we just use best effort to make
    it accurate here.

Looks like we just didn't understand the consequences at that time.

>
> Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
>
> Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> an option due to copy_page_to_iter() in sk_msg_recvmsg().
>
> [0]:
> BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
> Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
>
> CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xba/0x230 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
>  udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
>  inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
>  sock_recvmsg_nosec net/socket.c:1078 [inline]
>  sock_recvmsg+0x1a8/0x270 net/socket.c:1100
>  ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
>  ___sys_recvmsg+0x215/0x590 net/socket.c:2854
>  do_recvmmsg+0x334/0x800 net/socket.c:2949
>  __sys_recvmmsg net/socket.c:3023 [inline]
>  __do_sys_recvmmsg net/socket.c:3046 [inline]
>  __se_sys_recvmmsg net/socket.c:3039 [inline]
>  __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb319f9aeb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb31ad97028 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 00007fb31a216090 RCX: 00007fb319f9aeb9
> RDX: 0000000000000001 RSI: 0000200000000400 RDI: 0000000000000004
> RBP: 00007fb31a008c1f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000040000021 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fb31a216128 R14: 00007fb31a216090 R15: 00007ffe21dd0a98
>  </TASK>
>
> Allocated by task 6019:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
>  kasan_kmalloc include/linux/kasan.h:263 [inline]
>  __kmalloc_cache_noprof+0x3d1/0x6e0 mm/slub.c:5780
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  alloc_sk_msg net/core/skmsg.c:510 [inline]
>  sk_psock_skb_ingress_self+0x60/0x350 net/core/skmsg.c:612
>  sk_psock_verdict_apply net/core/skmsg.c:1038 [inline]
>  sk_psock_verdict_recv+0x7d9/0x8d0 net/core/skmsg.c:1236
>  udp_read_skb+0x73e/0x7e0 net/ipv4/udp.c:2045
>  sk_psock_verdict_data_ready+0x12d/0x550 net/core/skmsg.c:1257
>  __udp_enqueue_schedule_skb+0xc54/0x10b0 net/ipv4/udp.c:1789
>  __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
>  udp_queue_rcv_one_skb+0xac5/0x19c0 net/ipv4/udp.c:2475
>  __udp4_lib_mcast_deliver+0xc06/0xcf0 net/ipv4/udp.c:2585
>  __udp4_lib_rcv+0x10f6/0x2620 net/ipv4/udp.c:2724
>  ip_protocol_deliver_rcu+0x282/0x440 net/ipv4/ip_input.c:207
>  ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
>  NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
>  dst_input include/net/dst.h:474 [inline]
>  ip_sublist_rcv_finish+0x221/0x2a0 net/ipv4/ip_input.c:584
>  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
>  ip_sublist_rcv+0x5c6/0xa70 net/ipv4/ip_input.c:644
>  ip_list_rcv+0x3f1/0x450 net/ipv4/ip_input.c:678
>  __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
>  __netif_receive_skb_list_core+0x7e5/0x810 net/core/dev.c:6242
>  __netif_receive_skb_list net/core/dev.c:6294 [inline]
>  netif_receive_skb_list_internal+0x995/0xcf0 net/core/dev.c:6385
>  netif_receive_skb_list+0x54/0x410 net/core/dev.c:6437
>  xdp_recv_frames net/bpf/test_run.c:269 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:350 [inline]
>  bpf_test_run_xdp_live+0x1946/0x1cf0 net/bpf/test_run.c:379
>  bpf_prog_test_run_xdp+0x81c/0x1160 net/bpf/test_run.c:1396
>  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
>  __sys_bpf+0x5cb/0x920 kernel/bpf/syscall.c:6182
>  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 6021:
>  kasan_save_stack mm/kasan/common.c:57 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:253 [inline]
>  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>  kasan_slab_free include/linux/kasan.h:235 [inline]
>  slab_free_hook mm/slub.c:2540 [inline]
>  slab_free mm/slub.c:6674 [inline]
>  kfree+0x1be/0x650 mm/slub.c:6882
>  kfree_sk_msg include/linux/skmsg.h:385 [inline]
>  sk_msg_recvmsg+0xaa8/0xc30 net/core/skmsg.c:483
>  udp_bpf_recvmsg+0x4bd/0xe00 net/ipv4/udp_bpf.c:84
>  inet_recvmsg+0x260/0x270 net/ipv4/af_inet.c:891
>  sock_recvmsg_nosec net/socket.c:1078 [inline]
>  sock_recvmsg+0x1a8/0x270 net/socket.c:1100
>  ____sys_recvmsg+0x1e6/0x4a0 net/socket.c:2812
>  ___sys_recvmsg+0x215/0x590 net/socket.c:2854
>  do_recvmmsg+0x334/0x800 net/socket.c:2949
>  __sys_recvmmsg net/socket.c:3023 [inline]
>  __do_sys_recvmmsg net/socket.c:3046 [inline]
>  __se_sys_recvmmsg net/socket.c:3039 [inline]
>  __x64_sys_recvmmsg+0x198/0x250 net/socket.c:3039
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

