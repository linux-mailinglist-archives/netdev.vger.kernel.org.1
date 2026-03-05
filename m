Return-Path: <netdev+bounces-264305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHA3H6VjqWmB6gAAu9opvQ
	(envelope-from <netdev+bounces-264305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:06:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A112104AC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930AA3056D8A
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE69382F27;
	Thu,  5 Mar 2026 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HI8gstVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A0288C3D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708727; cv=none; b=JAOJTgpbT8HRrKXMxDx6+1W7/s94ZHhGTzMRUlW/dcNEXaglaZ1N36jjAP0vwFOl1L9eljPRoX6OUoG/BvZBfLMUdgncxsrU3o2F/NcxWC5gd7MftwezApVDqbybwXnn31uRJcSsM59GRPy80W/4OkGwJPTcyquXB/s486fxQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708727; c=relaxed/simple;
	bh=L/DaKvYTz36FNjIuY5J5bDAK4KPHUjUfguKWDTyOtq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oolORVRdlykTTYw6T1RfV2/0dsSHigxoCMJHaDuOKtI0hjlEhFCARA9DJ9zICb9A78T2+ivFBozTcSjz2Cvwl4AlUZS4VJYwH1R99UH78K+/mhB/Ik/VWkj6AU6xXBNWGNeJcIebS1UWkyQBHCZXJdzQZhCiRcVPXJLoxL1dbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HI8gstVM; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-660d2e48383so3882447a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772708724; x=1773313524; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/7UCwgjtbrg6WQn51Mqdwa0wdTg8UHHjDw0AsFNOQY=;
        b=HI8gstVM5fEfbXT/Lk0lpwOpNe2TJOzuDWwZebLGuluIS6MLZoVUpOLJQCk/jhDMdM
         lahcnjrsvkeOKXHv4EThsfJ2gy0YCtJeCGLvoAjhTqYlYI3NdJ5P8smFg6rYLvGgJpdH
         u+ZjK0Ia8S9BAgBnVS9096Md/LP1Y1GfzYk4CT2aiZVXH2PvsIbdaLLWQVTIaN3M3api
         Wotkz1KW4XaMATU5TnpIY50pdvXG3Wzk49ZkBtR/JLwutvUrd3yUWiXiRaVj5cVyQhuq
         xfM4TUGmrBD7w9sAralUqllKFUedODCJ8JLzP5i4c2R1iNUvuh4ixvuR7h7/SvRDy0Lq
         +kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708724; x=1773313524;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/7UCwgjtbrg6WQn51Mqdwa0wdTg8UHHjDw0AsFNOQY=;
        b=PnwWm79ibe9xrkT8/gfwWJ7rH/by5FbxR963ydnVEYSI6XogF65bNqtBqL32EVn5Ob
         55lPo6RAuJshtIrbcY5GbakJ4eq+hjA9F0S/xQjGAqGQdLLcK617iJXQZx6G5fYviLPl
         b7d+XT93glcc7EWbQ4ptPw7l6V61m7iKnB6FOhM6FNfBH8ujE+6G6ifiZU0Cmj9jzMrU
         CLYzL2Kb7U4Oe+SkLQ//kO05FG54bQjgAknUmZQuvrYEthPhp+QAmJVxLko0jEmwAl7E
         lYcg176Mkwqf6txyw5zEGdw6XqKn3vjGWnf3UDtGL9Q1i9CSM3LXQHSii+uZnKO/wbAg
         shog==
X-Forwarded-Encrypted: i=1; AJvYcCVVJQ51bg4XIuh0610oQUFccc/ldERNNHLkndsBGQtIkeleHla7QEfviECVoMSIny+p9LJReJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OnrcqOv0BzOT1TnwTtoFWmP5x1JZNv+EMCzgX1I4FxKRWKJu
	JuGrtu8anRCqOSJgCnpejN7kobDk+Zk8c6wNUBJnO0qQde+shrFDUlTe47A3/ionkYk=
X-Gm-Gg: ATEYQzyEtm8ghO7Ec+s82LmgXOZI6R2N4Ea1VJlcBHFWWzeJ+SMLKwlJ1yMtHi+5z/X
	o4fz0qo7Hz6SCB2BgPwTeeZR9/Nw/5i7sTyfpOJ+7SqeZkLu8BbrKc2OESVhrK90gRHSalKDqd8
	acKVPdUWszonD6y5kxiEVGloSYlz0mwfs92RZbeKdq26mDs8QfFN9CMleyhxV6bVx28MkOcABDs
	TY7t0rEkxNH11TtCumc8ynCiGXmm02D7OA6KYn6qhEfGKBRmYadAnn2R3vrhEu2SuhGy234FKT3
	BUlYe4mBx7+JkNjyUmnX/cA4h9j+4mgYqfSgfpcP+Y/QC776nkRMs+9pcW0RTOeqRgbIHuWDJq9
	pvm0TiaiZkqEg9r389hgkcYEGqVm2Bi/RpOjFHvFNW9FHjnQHLLpDSWiXqLURv+RfvfbclDeuv6
	nzYSieAoNXPeHfiUF/ONLDUGHljC3Hv51U7JcoIUrggFdJp27xJSFIVKGYNE+heEFYcZETW7dNy
	ezJKtQZ
X-Received: by 2002:a05:6402:1448:b0:65f:7f90:fb89 with SMTP id 4fb4d7f45d1cf-660efeb46f4mr3684525a12.17.1772708724386;
        Thu, 05 Mar 2026 03:05:24 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-660af3bf657sm2678794a12.5.2026.03.05.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:05:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 bpf/net 1/6] sockmap: Annotate sk->sk_data_ready()
 for UDP.
In-Reply-To: <20260221233234.3814768-2-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Sat, 21 Feb 2026 23:30:48 +0000")
References: <20260221233234.3814768-1-kuniyu@google.com>
	<20260221233234.3814768-2-kuniyu@google.com>
Date: Thu, 05 Mar 2026 12:05:23 +0100
Message-ID: <87a4wmo7t8.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D1A112104AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-264305-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,113cea56c13a8a1e95ab];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30 PM GMT, Kuniyuki Iwashima wrote:
> syzbot reported data race of sk->sk_data_ready(). [0]
>
> UDP fast path does not hold bh_lock_sock(), instead
> spin_lock_bh(&sk->sk_receive_queue.lock) is used.
>
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_data_ready().
>
> Another option is to hold sk->sk_receive_queue.lock in
> sock_map_sk_acquire() if sk_is_udp() is true, but this is
> overkill and also does not work for sk->sk_write_space().
>
> [0]:
> BUG: KCSAN: data-race in __udp_enqueue_schedule_skb / sk_psock_drop
>
> write to 0xffff88811d063048 of 8 bytes by task 23114 on cpu 0:
>  sk_psock_stop_verdict net/core/skmsg.c:1287 [inline]
>  sk_psock_drop+0x12f/0x270 net/core/skmsg.c:873
>  sk_psock_put include/linux/skmsg.h:473 [inline]
>  sock_map_unref+0x2a5/0x300 net/core/sock_map.c:185
>  __sock_map_delete net/core/sock_map.c:426 [inline]
>  sock_map_delete_from_link net/core/sock_map.c:439 [inline]
>  sock_map_unlink net/core/sock_map.c:1608 [inline]
>  sock_map_remove_links+0x228/0x340 net/core/sock_map.c:1623
>  sock_map_close+0xa1/0x340 net/core/sock_map.c:1684
>  inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
>  __sock_release net/socket.c:662 [inline]
>  sock_close+0x6b/0x150 net/socket.c:1455
>  __fput+0x29b/0x650 fs/file_table.c:468
>  ____fput+0x1c/0x30 fs/file_table.c:496
>  task_work_run+0x130/0x1a0 kernel/task_work.c:233
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
>  exit_to_user_mode_loop+0x1f7/0x6f0 kernel/entry/common.c:75
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
>  do_syscall_64+0x1d3/0x2a0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88811d063048 of 8 bytes by task 23117 on cpu 1:
>  __udp_enqueue_schedule_skb+0x6c1/0x840 net/ipv4/udp.c:1789
>  __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
>  udp_queue_rcv_one_skb+0x709/0xc20 net/ipv4/udp.c:2475
>  udp_queue_rcv_skb+0x20e/0x2b0 net/ipv4/udp.c:2493
>  __udp4_lib_mcast_deliver+0x6e8/0x790 net/ipv4/udp.c:2585
>  __udp4_lib_rcv+0x96f/0x1260 net/ipv4/udp.c:2724
>  udp_rcv+0x4f/0x60 net/ipv4/udp.c:2911
>  ip_protocol_deliver_rcu+0x3f9/0x780 net/ipv4/ip_input.c:207
>  ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
>  dst_input include/net/dst.h:474 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
>  ip_sublist_rcv+0x42b/0x6d0 net/ipv4/ip_input.c:644
>  ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
>  __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
>  __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6242
>  __netif_receive_skb_list net/core/dev.c:6294 [inline]
>  netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6385
>  netif_receive_skb_list+0x31/0x1f0 net/core/dev.c:6437
>  xdp_recv_frames net/bpf/test_run.c:269 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:350 [inline]
>  bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
>  bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1396
>  bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4703
>  __sys_bpf+0x4c0/0x7b0 kernel/bpf/syscall.c:6182
>  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
>  __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6272
>  x64_sys_call+0x28e1/0x3000 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffffffff847b24d0 -> 0xffffffff84673410
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 23117 Comm: syz.8.5085 Tainted: G        W           syzkaller #0 PREEMPT(voluntary)
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
>
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Reported-by: syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e1.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Sorry for the delay. Got caught up in skb metadata stuff...

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

