Return-Path: <netdev+bounces-64616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3144835F69
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F26281022
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2053A1AE;
	Mon, 22 Jan 2024 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSppJwft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9A3A1A6
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918901; cv=none; b=ZDXj0pR4M14KLtkWN2B7JFX7suH/dRGyUOrQPTmBdEhgRVe4y5F+4LKWIX8xRqoqmaleN9OwLZ3vD6DFuR1BQdhCqp56/GlYVuObxPiZ8c9PUXz+Q4B3/HJ+4cI/ZxxFkjePIhTk6fCj7DK5IwuIYJEOvY08YU8QPGtxkgbo8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918901; c=relaxed/simple;
	bh=NVcEa6outa5gAbGuudhANRt6AQFgwRwdGmjJl8y8dDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGk2bXJyNLzLnz5Xmlzt5tVqicXdJ99aSeQpIZflfRfjVkM5SK8p1Kt+1cuJheyRdt/Kfw/D+vvNSJvwYg/RJZLlJuRz52P2HXRwpUjq2uiWaSEblxIyk875uR8ETaTVK2rj/MkIMqvGdfvWJmmzH1ErY/hKiaZIxbwKKBkai1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cSppJwft; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so3852864e87.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 02:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705918897; x=1706523697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ordDvxtnTTJSvi6hhv77ShFlW0Me5Ge2bZluUietrgk=;
        b=cSppJwftAr7oDIo2Ia/CmPN7cnezbHeybHIPToU0268QDfYDfy1HNTduUPxGNN+Sqx
         INOKOAZil5UA4x/nGBGfFUPjn5+uzMwnRuCjRGNNvEfHLQQiGZGt2Xok55VmE68QA2H2
         /UXbo8O/sLXK2qkTib7v7LVAyCnDYrp+A7xcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918897; x=1706523697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ordDvxtnTTJSvi6hhv77ShFlW0Me5Ge2bZluUietrgk=;
        b=D49q2ntvDmvwmEBiThUSOg5UJAgP3yHCuuM2PTgvAt/7eOKQ+SMfRHZn8q4McshSp3
         /PjT0K/FqpdBe7cLXe2JzeWM8Rk8c2hUuUhSehTUgKjNgvVcezU3AikpIe9qT/j6Sjhx
         C25XYrSrdEjE8vexZHr291wcauHuo3AYaS7LBMPhX+0rrwiHEUibOjg3GYB7Wo5njU+P
         eIZwyNnMIOIIWeia4pjwDy3HpIBA87T+so7X1R3AS3l8DSmJbIcOh76H323Ws63pUkKq
         q8zD7rN0Bw2bQDTDxwD8DjXs95PxxM2friOedoInziy730CfSykDGibSnxsOMqQ0cbsX
         hrBw==
X-Gm-Message-State: AOJu0YxMD6RQkt6wDtBXRcy+Y822bQzVULfzC0t95WyKFPfFOT396MCn
	eQjUKWhP9m/b7vIjWY3ECr+udSatZy5NdGaWCbu1EvjMBMORlF4lRwTWT3eReKMS3VxEC5Z0kSM
	W+1qdWlTnvuGcYGuXQw0KcUGSW79501/qazZR
X-Google-Smtp-Source: AGHT+IEg1ZZcweWe+wk2wMVsIya5FKLosSIz9ftL2EoqRZxD0l15Z31SfkuNrZt3RpJ8HjkNyK7jz7Vg2Oh2URf+rAM=
X-Received: by 2002:a05:6512:10c5:b0:50e:9354:1913 with SMTP id
 k5-20020a05651210c500b0050e93541913mr1831611lfg.22.1705918897436; Mon, 22 Jan
 2024 02:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118012019.1751966-1-shaozhengchao@huawei.com>
 <20240122094219.GA1048271@google.com> <e18e24f5-7524-acf5-c9a4-7409fb395e6b@huawei.com>
In-Reply-To: <e18e24f5-7524-acf5-c9a4-7409fb395e6b@huawei.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 22 Jan 2024 18:21:26 +0800
Message-ID: <CAGXv+5HqkKpAP5hVoqP++d0+ehdnBQTe2y6Mk9OfsQwE=1=1hg@mail.gmail.com>
Subject: Re: [PATCH net,v4] tcp: make sure init the accept_queue's spinlocks once
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, sming56@aliyun.com, 
	hkchu@google.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:07=E2=80=AFPM shaozhengchao <shaozhengchao@huawei=
.com> wrote:
>
> Hi Chen-Yu=EF=BC=9A
>          Thank you for your report. I had the same problem this morning.
> It has been verified locally.

I have a patch ready that I'll send out shortly.

ChenYu

> Zhengchao Shao
>
> On 2024/1/22 17:42, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Thu, Jan 18, 2024 at 09:20:19AM +0800, Zhengchao Shao wrote:
> >> When I run syz's reproduction C program locally, it causes the followi=
ng
> >> issue:
> >> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
> >> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kerne=
l/locking/qspinlock_paravirt.h:508)
> >> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> >> RIP: 0010:__pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_p=
aravirt.h:508)
> >> Code: 73 56 3a ff 90 c3 cc cc cc cc 8b 05 bb 1f 48 01 85 c0 74 05 c3 c=
c cc cc cc 8b 17 48 89 fe 48 c7 c7
> >> 30 20 ce 8f e8 ad 56 42 ff <0f> 0b c3 cc cc cc cc 0f 0b 0f 1f 40 00 90=
 90 90 90 90 90 90 90 90
> >> RSP: 0018:ffffa8d200604cb8 EFLAGS: 00010282
> >> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9d1ef60e0908
> >> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d1ef60e0900
> >> RBP: ffff9d181cd5c280 R08: 0000000000000000 R09: 00000000ffff7fff
> >> R10: ffffa8d200604b68 R11: ffffffff907dcdc8 R12: 0000000000000000
> >> R13: ffff9d181cd5c660 R14: ffff9d1813a3f330 R15: 0000000000001000
> >> FS:  00007fa110184640(0000) GS:ffff9d1ef60c0000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 0000000020000000 CR3: 000000011f65e000 CR4: 00000000000006f0
> >> Call Trace:
> >> <IRQ>
> >>    _raw_spin_unlock (kernel/locking/spinlock.c:186)
> >>    inet_csk_reqsk_queue_add (net/ipv4/inet_connection_sock.c:1321)
> >>    inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1358)
> >>    tcp_check_req (net/ipv4/tcp_minisocks.c:868)
> >>    tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2260)
> >>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
> >>    ip_local_deliver_finish (net/ipv4/ip_input.c:234)
> >>    __netif_receive_skb_one_core (net/core/dev.c:5529)
> >>    process_backlog (./include/linux/rcupdate.h:779)
> >>    __napi_poll (net/core/dev.c:6533)
> >>    net_rx_action (net/core/dev.c:6604)
> >>    __do_softirq (./arch/x86/include/asm/jump_label.h:27)
> >>    do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
> >> </IRQ>
> >> <TASK>
> >>    __local_bh_enable_ip (kernel/softirq.c:381)
> >>    __dev_queue_xmit (net/core/dev.c:4374)
> >>    ip_finish_output2 (./include/net/neighbour.h:540 net/ipv4/ip_output=
.c:235)
> >>    __ip_queue_xmit (net/ipv4/ip_output.c:535)
> >>    __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
> >>    tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6469)
> >>    tcp_rcv_state_process (net/ipv4/tcp_input.c:6657)
> >>    tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
> >>    __release_sock (./include/net/sock.h:1121 net/core/sock.c:2968)
> >>    release_sock (net/core/sock.c:3536)
> >>    inet_wait_for_connect (net/ipv4/af_inet.c:609)
> >>    __inet_stream_connect (net/ipv4/af_inet.c:702)
> >>    inet_stream_connect (net/ipv4/af_inet.c:748)
> >>    __sys_connect (./include/linux/file.h:45 net/socket.c:2064)
> >>    __x64_sys_connect (net/socket.c:2073 net/socket.c:2070 net/socket.c=
:2070)
> >>    do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:8=
2)
> >>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> >>    RIP: 0033:0x7fa10ff05a3d
> >>    Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89
> >>    c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b=
 0d ab a3 0e 00 f7 d8 64 89 01 48
> >>    RSP: 002b:00007fa110183de8 EFLAGS: 00000202 ORIG_RAX: 0000000000000=
02a
> >>    RAX: ffffffffffffffda RBX: 0000000020000054 RCX: 00007fa10ff05a3d
> >>    RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
> >>    RBP: 00007fa110183e20 R08: 0000000000000000 R09: 0000000000000000
> >>    R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa110184640
> >>    R13: 0000000000000000 R14: 00007fa10fe8b060 R15: 00007fff73e23b20
> >> </TASK>
> >>
> >> The issue triggering process is analyzed as follows:
> >> Thread A                                       Thread B
> >> tcp_v4_rcv   //receive ack TCP packet       inet_shutdown
> >>    tcp_check_req                                  tcp_disconnect //dis=
connect sock
> >>    ...                                              tcp_set_state(sk, =
TCP_CLOSE)
> >>      inet_csk_complete_hashdance                ...
> >>        inet_csk_reqsk_queue_add                 inet_listen  //start l=
isten
> >>          spin_lock(&queue->rskq_lock)             inet_csk_listen_star=
t
> >>          ...                                        reqsk_queue_alloc
> >>          ...                                          spin_lock_init
> >>          spin_unlock(&queue->rskq_lock)      //warning
> >>
> >> When the socket receives the ACK packet during the three-way handshake=
,
> >> it will hold spinlock. And then the user actively shutdowns the socket
> >> and listens to the socket immediately, the spinlock will be initialize=
d.
> >> When the socket is going to release the spinlock, a warning is generat=
ed.
> >> Also the same issue to fastopenq.lock.
> >>
> >> Move init spinlock to inet_create and inet_accept to make sure init th=
e
> >> accept_queue's spinlocks once.
> >>
> >> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_so=
ck_queue")
> >> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> >> Reported-by: Ming Shu <sming56@aliyun.com>
> >> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> >
> > This patch causes a lockdep error for me on next-20240122 when SSHing
> > into my test device over IPv6. Reverting this patch gets rid of the
> > message, but that is probably not the correct fix.
> >
> > Given that inet_listen is also used from net/ipv6/af_inet6.c, and
> > __inet_listen_sk is used from mptcp, inet_init_csk_locks() would need
> > to be called in a couple more places. I don't know much about the
> > networking stack, but I can try to come up with a patch.
> >
> > Backtrace below:
> >
> > INFO: trying to register non-static key.
> > The code is fine but needs lockdep annotation, or maybe
> > you didn't initialize this object before use?
> > turning off the locking correctness validator.
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc1-next-20240122-01036=
-g319fbd8fc6d3 #147 2400bce4623c16f3873f828b5d429524a0849cd3
> > Hardware name: Google Krane Chromebook (DT)
> > Call trace:
> > dump_backtrace (arch/arm64/kernel/stacktrace.c:293)
> > show_stack (arch/arm64/kernel/stacktrace.c:300)
> > dump_stack_lvl (lib/dump_stack.c:107)
> > dump_stack (lib/dump_stack.c:114)
> > register_lock_class (kernel/locking/lockdep.c:977 kernel/locking/lockde=
p.c:1289)
> > __lock_acquire (kernel/locking/lockdep.c:5014)
> > lock_acquire (./arch/arm64/include/asm/percpu.h:40 kernel/locking/lockd=
ep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
> > _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/s=
pinlock.c:154)
> > inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1303 net/i=
pv4/inet_connection_sock.c:1355)
> > tcp_check_req (net/ipv4/tcp_minisocks.c:653)
> > tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1837)
> > ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:438)
> > ip6_input_finish (./include/linux/rcupdate.h:779 net/ipv6/ip6_input.c:4=
84)
> > ip6_input (./include/linux/netfilter.h:314 ./include/linux/netfilter.h:=
308 net/ipv6/ip6_input.c:492)
> > ip6_sublist_rcv_finish (net/ipv6/ip6_input.c:86 (discriminator 3))
> > ip6_sublist_rcv (net/ipv6/ip6_input.c:317)
> > ipv6_list_rcv (net/ipv6/ip6_input.c:326)
> > __netif_receive_skb_list_core (net/core/dev.c:5577 net/core/dev.c:5625)
> > netif_receive_skb_list_internal (net/core/dev.c:5679 net/core/dev.c:576=
8)
> > napi_complete_done (./include/linux/list.h:37 (discriminator 2) ./inclu=
de/net/gro.h:440 (discriminator 2) ./include/net/gro.h:435 (discriminator 2=
) net/core/dev.c:6108 (discriminator 2))
> > r8152_poll (drivers/net/usb/r8152.c:2780 (discriminator 1)) r8152
> > __napi_poll.constprop.0 (net/core/dev.c:6576)
> > net_rx_action (net/core/dev.c:6647 net/core/dev.c:6778)
> > __do_softirq (./arch/arm64/include/asm/jump_label.h:21 ./include/linux/=
jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
> > ____do_softirq (arch/arm64/kernel/irq.c:82)
> > call_on_irq_stack (arch/arm64/kernel/entry.S:895)
> > do_softirq_own_stack (arch/arm64/kernel/irq.c:87)
> > __irq_exit_rcu (./arch/arm64/include/asm/percpu.h:44 kernel/softirq.c:6=
12 kernel/softirq.c:634)
> > irq_exit_rcu (kernel/softirq.c:646 (discriminator 4))
> > el1_interrupt (arch/arm64/kernel/entry-common.c:505 arch/arm64/kernel/e=
ntry-common.c:517)
> > el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:523)
> > el1h_64_irq (arch/arm64/kernel/entry.S:594)
> > arch_local_irq_enable (./arch/arm64/include/asm/irqflags.h:51)
> > cpuidle_enter (drivers/cpuidle/cpuidle.c:388)
> > do_idle (kernel/sched/idle.c:134 kernel/sched/idle.c:215 kernel/sched/i=
dle.c:312)
> > cpu_startup_entry (kernel/sched/idle.c:409)
> > rest_init (./include/linux/rcupdate.h:751 (discriminator 1) init/main.c=
:701 (discriminator 1))
> > arch_call_rest_init+0x1c/0x28
> > start_kernel (init/main.c:1023 (discriminator 1))
> > __primary_switched (arch/arm64/kernel/head.S:524)
> >
> >
> > Regards
> > ChenYu
> >
> >> ---
> >> v4: Add a helper to init accept_queue's spinlocks.
> >> v3: Move init spinlock to inet_create and inet_accept.
> >> v2: Add 'init_done' to make sure init the accept_queue's spinlocks onc=
e.
> >> ---
> >>   include/net/inet_connection_sock.h | 8 ++++++++
> >>   net/core/request_sock.c            | 3 ---
> >>   net/ipv4/af_inet.c                 | 3 +++
> >>   net/ipv4/inet_connection_sock.c    | 4 ++++
> >>   4 files changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_con=
nection_sock.h
> >> index d0a2f827d5f2..9ab4bf704e86 100644
> >> --- a/include/net/inet_connection_sock.h
> >> +++ b/include/net/inet_connection_sock.h
> >> @@ -357,4 +357,12 @@ static inline bool inet_csk_has_ulp(const struct =
sock *sk)
> >>      return inet_test_bit(IS_ICSK, sk) && !!inet_csk(sk)->icsk_ulp_ops=
;
> >>   }
> >>
> >> +static inline void inet_init_csk_locks(struct sock *sk)
> >> +{
> >> +    struct inet_connection_sock *icsk =3D inet_csk(sk);
> >> +
> >> +    spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
> >> +    spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
> >> +}
> >> +
> >>   #endif /* _INET_CONNECTION_SOCK_H */
> >> diff --git a/net/core/request_sock.c b/net/core/request_sock.c
> >> index f35c2e998406..63de5c635842 100644
> >> --- a/net/core/request_sock.c
> >> +++ b/net/core/request_sock.c
> >> @@ -33,9 +33,6 @@
> >>
> >>   void reqsk_queue_alloc(struct request_sock_queue *queue)
> >>   {
> >> -    spin_lock_init(&queue->rskq_lock);
> >> -
> >> -    spin_lock_init(&queue->fastopenq.lock);
> >>      queue->fastopenq.rskq_rst_head =3D NULL;
> >>      queue->fastopenq.rskq_rst_tail =3D NULL;
> >>      queue->fastopenq.qlen =3D 0;
> >> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >> index 835f4f9d98d2..4e635dd3d3c8 100644
> >> --- a/net/ipv4/af_inet.c
> >> +++ b/net/ipv4/af_inet.c
> >> @@ -330,6 +330,9 @@ static int inet_create(struct net *net, struct soc=
ket *sock, int protocol,
> >>      if (INET_PROTOSW_REUSE & answer_flags)
> >>              sk->sk_reuse =3D SK_CAN_REUSE;
> >>
> >> +    if (INET_PROTOSW_ICSK & answer_flags)
> >> +            inet_init_csk_locks(sk);
> >> +
> >>      inet =3D inet_sk(sk);
> >>      inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
> >>
> >> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connectio=
n_sock.c
> >> index 8e2eb1793685..459af1f89739 100644
> >> --- a/net/ipv4/inet_connection_sock.c
> >> +++ b/net/ipv4/inet_connection_sock.c
> >> @@ -727,6 +727,10 @@ struct sock *inet_csk_accept(struct sock *sk, int=
 flags, int *err, bool kern)
> >>      }
> >>      if (req)
> >>              reqsk_put(req);
> >> +
> >> +    if (newsk)
> >> +            inet_init_csk_locks(newsk);
> >> +
> >>      return newsk;
> >>   out_err:
> >>      newsk =3D NULL;
> >> --
> >> 2.34.1
> >>

