Return-Path: <netdev+bounces-97958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA378CE55D
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628111C2101C
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EF8665A;
	Fri, 24 May 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8K0DOM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B912839E
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553610; cv=none; b=GhC7cohkInOPiIFUT+Qom+l3ozCWRiOwyAcWnzGAiMpYHlIpcLYrPXvCEzofFcvsBw8BKJ8YH8msibC5KyN4zo3e8vYZ9RuyK31ladNJ5yfM85OW8efI9ba9oQ5TwmC+GoaMnQbw9t9h8PJfawuC9BT8KhkfeBIcejKq08ReHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553610; c=relaxed/simple;
	bh=xuhMGFKrZLaP3kgQexbQhHlxBwz6KojWZq7D8mXC75w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTmsN+1Lkt7tSQjHnK0DzUxODgQHFCe/8D/6WB81ktKsM7RJqezjruktlxSbR3izi+rd16suE1vUAkII8ZZUM6f/f51/xu6+xDx2shy85NAqVImpdKZqrTTvvRHFDTeoO/tRRnBe8Ncv39DnLCzHykJk1CpPGHNZQmkydxwAvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8K0DOM0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so13029a12.0
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716553606; x=1717158406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+5TB7ZrFRYN94Y3lNzCPIJpQbVDBgEGdR2gSSTMYVE=;
        b=h8K0DOM0RLM2e8ytgChMjqF3VnJ21vlDAoW7P87hHmfQFRFBjFQ7VtFJ88/l9TxDNu
         Etm+LMUiPFfn6X1BkROsEQFFZ+VOef0B++3vt+VD0CaNGbstnMrmuy7fNb8UrXdLGVKf
         YcEcNME979Go+APmRurOCRrL53NCsm/V/jmFqK00/Hmk/88a7x1Dj/ugXpt58Etf1iVL
         RoKY7eV0eTQ4QP9DjBUMSq0VKuoX2FaZ6IczE9XNW3tEePJhXHeBe91c9F/4SwJizUUo
         36SLUVSOFUDvVoqQ52J+MIfkMH6gkdZlr3BTrG8ZZYYlRWksl4rXGRyIL74t3Qvua4HQ
         /lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716553606; x=1717158406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+5TB7ZrFRYN94Y3lNzCPIJpQbVDBgEGdR2gSSTMYVE=;
        b=CXtue8R72xkcnROEBLhEuqLgM7TCxOgWclsHinQpg5NNHDpRjEs2Rz56w1Ke0kUvFP
         krlmfc6zlgpiALyS4Y9UCPQlliGStxWgCGONI4pSQO9ml0VT7s0rgsHhPCtXAyt+451h
         GRbDQPxiHgWGPjvDCqznOXVWXmmjhewmaZ0NGSVmAa5jfKEq1AkWo5IUbh01jJuP/ldQ
         A8tV74H6M0+G9qZqU7WMDqht4BercB9Rtw7JyY2x8Wb+d/ECjfePdvCa6EZq4T/T2v3Q
         77OpRJWx2c/pEJTR3IZF5LkLUINyCqIhi1Xjs2jkZu3/awzQ/eIClHcy2F0yl8LCn/HA
         Ch3A==
X-Forwarded-Encrypted: i=1; AJvYcCV88xSDqhHw9s/2GslywNSHsL2B+rUvqpl1TFNb4FDlLMHuIy1Gc1Mbp2zqBcOJDwgRJ+ZJMRW15Oi1FazsR7QcDxxNWgog
X-Gm-Message-State: AOJu0YzVWdswFq/mda5O3JhiRjf97qb9UGt0CyhGjjo6LwcHXqcfo8El
	M7O2WWF6KCbNlUdsKbQtUfC3/PaoUHfUQV5gYNHngwKGPg5LgzzRm4GcxQnuaFqHmo1GBQ6t3QP
	G2Y3UC25HORQfrPiXSRhHMZflcaSyBYRnPqnC
X-Google-Smtp-Source: AGHT+IGHn5L1uycYhffe8JVxue6IwpHJSjos4Cxhy9NA8pouewer/Odr/+VsiRSafqS5Qj4i8HLUs/dTUGZSrFhAgkU=
X-Received: by 2002:a05:6402:5207:b0:573:8b4:a0a6 with SMTP id
 4fb4d7f45d1cf-57855302f23mr137068a12.5.1716553605970; Fri, 24 May 2024
 05:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524085108.1430317-1-yuehaibing@huawei.com>
 <CANn89iL5-w3NzupmR4LgskvW2yw1jgnhdFg1HRg+k+JY38G6+w@mail.gmail.com> <5d001e22-c9fe-60d2-a775-40e1c44a1c56@huawei.com>
In-Reply-To: <5d001e22-c9fe-60d2-a775-40e1c44a1c56@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 May 2024 14:26:31 +0200
Message-ID: <CANn89iKbVU074xq6vi6d3HCUrX+kh=_=0xo4C4aepjCOD5YMCA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Add xmit_recursion level in sch_direct_xmit()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, hannes@stressinduktion.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahesh Bandewar <maheshb@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:40=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
> On 2024/5/24 17:24, Eric Dumazet wrote:
> > On Fri, May 24, 2024 at 10:49=E2=80=AFAM Yue Haibing <yuehaibing@huawei=
.com> wrote:
> >>
> >> packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device wil=
l hit
> >> WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path while ip=
vlan
> >> device has qdisc queue.
> >>
> >> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
> >> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg =
drm_kms_helper
> >> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 0=
4/01/2014
> >> RIP: 0010:sk_mc_loop+0x2d/0x70
> >> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 4=
8 85 ff 74 1c
> >> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
> >> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
> >> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
> >> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
> >> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
> >> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
> >> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  <IRQ>
> >>  ? __warn+0x83/0x130
> >>  ? sk_mc_loop+0x2d/0x70
> >>  ? report_bug+0x18e/0x1a0
> >>  ? handle_bug+0x3c/0x70
> >>  ? exc_invalid_op+0x18/0x70
> >>  ? asm_exc_invalid_op+0x1a/0x20
> >>  ? sk_mc_loop+0x2d/0x70
> >>  ip6_finish_output2+0x31e/0x590
> >>  ? nf_hook_slow+0x43/0xf0
> >>  ip6_finish_output+0x1f8/0x320
> >>  ? __pfx_ip6_finish_output+0x10/0x10
> >>  ipvlan_xmit_mode_l3+0x22a/0x2a0 [ipvlan]
> >>  ipvlan_start_xmit+0x17/0x50 [ipvlan]
> >>  dev_hard_start_xmit+0x8c/0x1d0
> >>  sch_direct_xmit+0xa2/0x390
> >>  __qdisc_run+0x66/0xd0
> >>  net_tx_action+0x1ca/0x270
> >>  handle_softirqs+0xd6/0x2b0
> >>  __irq_exit_rcu+0x9b/0xc0
> >>  sysvec_apic_timer_interrupt+0x75/0x90
> >
> > Please provide full symbols in stack traces.
>
> Call Trace:
> <IRQ>
> ? __warn (kernel/panic.c:693)
> ? sk_mc_loop (net/core/sock.c:775 net/core/sock.c:760)
> ? report_bug (lib/bug.c:201 lib/bug.c:219)
> ? handle_bug (arch/x86/kernel/traps.c:239)
> ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
> ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
> ? sk_mc_loop (net/core/sock.c:775 net/core/sock.c:760)
> ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
> ? nf_hook_slow (./include/linux/netfilter.h:154 net/netfilter/core.c:626)
> ip6_finish_output (net/ipv6/ip6_output.c:211 net/ipv6/ip6_output.c:222)
> ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
> ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:498 drivers/net/ipv=
lan/ipvlan_core.c:538 drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
> ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
> dev_hard_start_xmit (./include/linux/netdevice.h:4882 ./include/linux/net=
device.h:4896 net/core/dev.c:3578 net/core/dev.c:3594)
> sch_direct_xmit (net/sched/sch_generic.c:343)
> __qdisc_run (net/sched/sch_generic.c:416)
> net_tx_action (./include/net/sch_generic.h:219 ./include/net/pkt_sched.h:=
128 ./include/net/pkt_sched.h:124 net/core/dev.c:5286)
> handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/j=
ump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555)
> __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.=
c:637)
> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/ke=
rnel/apic/apic.c:1043)
>
> >
> >>  </IRQ>
> >>
> >> Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive de=
reference inside the stack")
> >> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> >> ---
> >>  include/linux/netdevice.h | 17 +++++++++++++++++
> >>  net/core/dev.h            | 17 -----------------
> >>  net/sched/sch_generic.c   |  8 +++++---
> >>  3 files changed, 22 insertions(+), 20 deletions(-)
> >
> > This patch seems unrelated to the WARN_ON_ONCE(1) met in sk_mc_loop()
> >
> > If sk_mc_loop() is called with a socket which is not inet, we are in tr=
ouble.
> >
> > Please fix the root cause instead of trying to shortcut sk_mc_loop() as=
 you did.
> First setup like this:
> ip netns add ns0
> ip netns add ns1
> ip link add ip0 link eth0 type ipvlan mode l3 vepa
> ip link add ip1 link eth0 type ipvlan mode l3 vepa
> ip link set ip0 netns ns0
> ip link exec ip link set ip0 up
> ip link set ip1 netns ns1
> ip link exec ip link set ip1 up
> ip link exec tc qdisc add dev ip1 root netem delay 10ms
>
> Second, build and send a raw ipv6 multicast packet as attached repro in n=
s1
>
> packet_sendmsg
>    packet_snd //skb->sk is packet sk
>       __dev_queue_xmit
>          __dev_xmit_skb //q->enqueue is not NULL
>              __qdisc_run
>                  qdisc_restart
>                     sch_direct_xmit
>                        dev_hard_start_xmit
>                           netdev_start_xmit
>                             ipvlan_start_xmit
>                               ipvlan_xmit_mode_l3 //l3 mode
>                                  ipvlan_process_outbound //vepa flag
>                                    ipvlan_process_v6_outbound //skb->prot=
ocol is ETH_P_IPV6
>                                       ip6_local_out
>                                        ...
>                                          __ip6_finish_output
>                                             ip6_finish_output2 //multicas=
t packet
>                                                sk_mc_loop //dev_recursion=
_level is 0
>                                                   WARN_ON_ONCE //sk->sk_f=
amily is AF_PACKET
>
> > .

I would say ipvlan code should not use skb->sk when calling
ip6_local_out() , like other tunnels.

Untested patch :

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_c=
ore.c
index 2d5b021b4ea6053eeb055a76fa4c7d9380cd2a53..fef4eff7753a7acb1e11d9712ab=
d669de7740df6
100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -439,7 +439,7 @@ static noinline_for_stack int
ipvlan_process_v4_outbound(struct sk_buff *skb)

        memset(IPCB(skb), 0, sizeof(*IPCB(skb)));

-       err =3D ip_local_out(net, skb->sk, skb);
+       err =3D ip_local_out(net, NULL, skb);
        if (unlikely(net_xmit_eval(err)))
                DEV_STATS_INC(dev, tx_errors);
        else
@@ -494,7 +494,7 @@ static int ipvlan_process_v6_outbound(struct sk_buff *s=
kb)

        memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));

-       err =3D ip6_local_out(dev_net(dev), skb->sk, skb);
+       err =3D ip6_local_out(dev_net(dev), NULL, skb);
        if (unlikely(net_xmit_eval(err)))
                DEV_STATS_INC(dev, tx_errors);
        else

