Return-Path: <netdev+bounces-97960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3038CE578
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3976281555
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE585C7D;
	Fri, 24 May 2024 12:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABF57C8D;
	Fri, 24 May 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554756; cv=none; b=S7DzwSPujIaqkX3Nc414z3SPd2SybH8nPl1QUGSQetDxZ/Jg1Ajo8kyANYneMvY/bTKLGSAPEzaa4CsEYWBGDeWk2/xlyPLJTC7XmwA4EDu7qA4by1n9D5xb/Qp1lOlRU13DIJda2umiekrTGwRwScc1HbSKsxojzFu8XTZ4NzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554756; c=relaxed/simple;
	bh=KqVEpSpvJ1Lb8NrKwlburIo6tdQTGmCdPrxh0QkDThQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=utln4Ba+8VkQZzyoxbU1LjKzspTzKbinqtIEZz9eYw4cQlADyPAIZno7itcZl7NovNJzB9OsXwDQSUr+ZrgwJKKBEz6vLhkB1udPCKTr0+WpE0G9eiuEW79o1A3OLCczu2BtHY+nEhWSZ5J2T2vfJXv4IIgeCOO/wWArUb7Cy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vm4Rz0cXXzsSZq;
	Fri, 24 May 2024 20:42:07 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id C9D041400D1;
	Fri, 24 May 2024 20:45:50 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 20:45:50 +0800
Subject: Re: [PATCH net] net/sched: Add xmit_recursion level in
 sch_direct_xmit()
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<hannes@stressinduktion.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mahesh Bandewar <maheshb@google.com>, David
 Ahern <dsahern@kernel.org>
References: <20240524085108.1430317-1-yuehaibing@huawei.com>
 <CANn89iL5-w3NzupmR4LgskvW2yw1jgnhdFg1HRg+k+JY38G6+w@mail.gmail.com>
 <5d001e22-c9fe-60d2-a775-40e1c44a1c56@huawei.com>
 <CANn89iKbVU074xq6vi6d3HCUrX+kh=_=0xo4C4aepjCOD5YMCA@mail.gmail.com>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <0b079848-534c-0365-caa5-3117b14d90d6@huawei.com>
Date: Fri, 24 May 2024 20:45:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKbVU074xq6vi6d3HCUrX+kh=_=0xo4C4aepjCOD5YMCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)

On 2024/5/24 20:26, Eric Dumazet wrote:
> On Fri, May 24, 2024 at 12:40 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> On 2024/5/24 17:24, Eric Dumazet wrote:
>>> On Fri, May 24, 2024 at 10:49 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>>>>
>>>> packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will hit
>>>> WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path while ipvlan
>>>> device has qdisc queue.
>>>>
>>>> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
>>>> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm_kms_helper
>>>> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>>> RIP: 0010:sk_mc_loop+0x2d/0x70
>>>> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 85 ff 74 1c
>>>> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
>>>> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
>>>> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
>>>> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
>>>> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
>>>> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
>>>> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>  <IRQ>
>>>>  ? __warn+0x83/0x130
>>>>  ? sk_mc_loop+0x2d/0x70
>>>>  ? report_bug+0x18e/0x1a0
>>>>  ? handle_bug+0x3c/0x70
>>>>  ? exc_invalid_op+0x18/0x70
>>>>  ? asm_exc_invalid_op+0x1a/0x20
>>>>  ? sk_mc_loop+0x2d/0x70
>>>>  ip6_finish_output2+0x31e/0x590
>>>>  ? nf_hook_slow+0x43/0xf0
>>>>  ip6_finish_output+0x1f8/0x320
>>>>  ? __pfx_ip6_finish_output+0x10/0x10
>>>>  ipvlan_xmit_mode_l3+0x22a/0x2a0 [ipvlan]
>>>>  ipvlan_start_xmit+0x17/0x50 [ipvlan]
>>>>  dev_hard_start_xmit+0x8c/0x1d0
>>>>  sch_direct_xmit+0xa2/0x390
>>>>  __qdisc_run+0x66/0xd0
>>>>  net_tx_action+0x1ca/0x270
>>>>  handle_softirqs+0xd6/0x2b0
>>>>  __irq_exit_rcu+0x9b/0xc0
>>>>  sysvec_apic_timer_interrupt+0x75/0x90
>>>
>>> Please provide full symbols in stack traces.
>>
>> Call Trace:
>> <IRQ>
>> ? __warn (kernel/panic.c:693)
>> ? sk_mc_loop (net/core/sock.c:775 net/core/sock.c:760)
>> ? report_bug (lib/bug.c:201 lib/bug.c:219)
>> ? handle_bug (arch/x86/kernel/traps.c:239)
>> ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>> ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>> ? sk_mc_loop (net/core/sock.c:775 net/core/sock.c:760)
>> ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
>> ? nf_hook_slow (./include/linux/netfilter.h:154 net/netfilter/core.c:626)
>> ip6_finish_output (net/ipv6/ip6_output.c:211 net/ipv6/ip6_output.c:222)
>> ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
>> ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:498 drivers/net/ipvlan/ipvlan_core.c:538 drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
>> ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
>> dev_hard_start_xmit (./include/linux/netdevice.h:4882 ./include/linux/netdevice.h:4896 net/core/dev.c:3578 net/core/dev.c:3594)
>> sch_direct_xmit (net/sched/sch_generic.c:343)
>> __qdisc_run (net/sched/sch_generic.c:416)
>> net_tx_action (./include/net/sch_generic.h:219 ./include/net/pkt_sched.h:128 ./include/net/pkt_sched.h:124 net/core/dev.c:5286)
>> handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555)
>> __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637)
>> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043)
>>
>>>
>>>>  </IRQ>
>>>>
>>>> Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive dereference inside the stack")
>>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>>>> ---
>>>>  include/linux/netdevice.h | 17 +++++++++++++++++
>>>>  net/core/dev.h            | 17 -----------------
>>>>  net/sched/sch_generic.c   |  8 +++++---
>>>>  3 files changed, 22 insertions(+), 20 deletions(-)
>>>
>>> This patch seems unrelated to the WARN_ON_ONCE(1) met in sk_mc_loop()
>>>
>>> If sk_mc_loop() is called with a socket which is not inet, we are in trouble.
>>>
>>> Please fix the root cause instead of trying to shortcut sk_mc_loop() as you did.
>> First setup like this:
>> ip netns add ns0
>> ip netns add ns1
>> ip link add ip0 link eth0 type ipvlan mode l3 vepa
>> ip link add ip1 link eth0 type ipvlan mode l3 vepa
>> ip link set ip0 netns ns0
>> ip link exec ip link set ip0 up
>> ip link set ip1 netns ns1
>> ip link exec ip link set ip1 up
>> ip link exec tc qdisc add dev ip1 root netem delay 10ms
>>
>> Second, build and send a raw ipv6 multicast packet as attached repro in ns1
>>
>> packet_sendmsg
>>    packet_snd //skb->sk is packet sk
>>       __dev_queue_xmit
>>          __dev_xmit_skb //q->enqueue is not NULL
>>              __qdisc_run
>>                  qdisc_restart
>>                     sch_direct_xmit
>>                        dev_hard_start_xmit
>>                           netdev_start_xmit
>>                             ipvlan_start_xmit
>>                               ipvlan_xmit_mode_l3 //l3 mode
>>                                  ipvlan_process_outbound //vepa flag
>>                                    ipvlan_process_v6_outbound //skb->protocol is ETH_P_IPV6
>>                                       ip6_local_out
>>                                        ...
>>                                          __ip6_finish_output
>>                                             ip6_finish_output2 //multicast packet
>>                                                sk_mc_loop //dev_recursion_level is 0
>>                                                   WARN_ON_ONCE //sk->sk_family is AF_PACKET
>>
>>> .
> 
> I would say ipvlan code should not use skb->sk when calling
> ip6_local_out() , like other tunnels.

Thanks, seems good. Will test this
> 
> Untested patch :
> 
> diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
> index 2d5b021b4ea6053eeb055a76fa4c7d9380cd2a53..fef4eff7753a7acb1e11d9712abd669de7740df6
> 100644
> --- a/drivers/net/ipvlan/ipvlan_core.c
> +++ b/drivers/net/ipvlan/ipvlan_core.c
> @@ -439,7 +439,7 @@ static noinline_for_stack int
> ipvlan_process_v4_outbound(struct sk_buff *skb)
> 
>         memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> 
> -       err = ip_local_out(net, skb->sk, skb);
> +       err = ip_local_out(net, NULL, skb);
>         if (unlikely(net_xmit_eval(err)))
>                 DEV_STATS_INC(dev, tx_errors);
>         else
> @@ -494,7 +494,7 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
> 
>         memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> 
> -       err = ip6_local_out(dev_net(dev), skb->sk, skb);
> +       err = ip6_local_out(dev_net(dev), NULL, skb);
>         if (unlikely(net_xmit_eval(err)))
>                 DEV_STATS_INC(dev, tx_errors);
>         else
> .
> 

