Return-Path: <netdev+bounces-13778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02373CE3F
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 05:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9E280FBC
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 03:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAEE63D;
	Sun, 25 Jun 2023 03:18:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763B62A
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 03:18:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408910E7
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 20:18:13 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QpblB4lpvzqV24;
	Sun, 25 Jun 2023 11:17:58 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 11:18:10 +0800
Message-ID: <bc78d89c-97e9-4b08-f178-067f5aeec5c6@huawei.com>
Date: Sun, 25 Jun 2023 11:18:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 net] ipv6: rpl: Fix Route of Death.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <alex.aring@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
References: <20230623005223.61341-1-kuniyu@amazon.com>
 <20230623192047.85787-1-kuniyu@amazon.com>
From: wangyufen <wangyufen@huawei.com>
In-Reply-To: <20230623192047.85787-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/6/24 3:20, Kuniyuki Iwashima 写道:
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Thu, 22 Jun 2023 17:52:23 -0700
>> From: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Date: Tue, 20 Jun 2023 21:25:13 -0700
>>> From: wangyufen <wangyufen@huawei.com>
>>> Date: Wed, 21 Jun 2023 09:55:13 +0800
>>>> 在 2023/6/20 17:10, Kuniyuki Iwashima 写道:
>>>>> From: wangyufen <wangyufen@huawei.com>
>>>>> Date: Tue, 20 Jun 2023 16:12:26 +0800
>>>>>> 在 2023/6/6 2:06, Kuniyuki Iwashima 写道:
>>>>>>> A remote DoS vulnerability of RPL Source Routing is assigned CVE-2023-2156.
>>>>>>>
>>>>>>> The Source Routing Header (SRH) has the following format:
>>>>>>>
>>>>>>>      0                   1                   2                   3
>>>>>>>      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>>>>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>>>>>      |  Next Header  |  Hdr Ext Len  | Routing Type  | Segments Left |
>>>>>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>>>>>      | CmprI | CmprE |  Pad  |               Reserved                |
>>>>>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>>>>>      |                                                               |
>>>>>>>      .                                                               .
>>>>>>>      .                        Addresses[1..n]                        .
>>>>>>>      .                                                               .
>>>>>>>      |                                                               |
>>>>>>>      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>>>>>>>
>>>>>>> The originator of an SRH places the first hop's IPv6 address in the IPv6
>>>>>>> header's IPv6 Destination Address and the second hop's IPv6 address as
>>>>>>> the first address in Addresses[1..n].
>>>>>>>
>>>>>>> The CmprI and CmprE fields indicate the number of prefix octets that are
>>>>>>> shared with the IPv6 Destination Address.  When CmprI or CmprE is not 0,
>>>>>>> Addresses[1..n] are compressed as follows:
>>>>>>>
>>>>>>>      1..n-1 : (16 - CmprI) bytes
>>>>>>>           n : (16 - CmprE) bytes
>>>>>>>
>>>>>>> Segments Left indicates the number of route segments remaining.  When the
>>>>>>> value is not zero, the SRH is forwarded to the next hop.  Its address
>>>>>>> is extracted from Addresses[n - Segment Left + 1] and swapped with IPv6
>>>>>>> Destination Address.
>>>>>>>
>>>>>>> When Segment Left is greater than or equal to 2, the size of SRH is not
>>>>>>> changed because Addresses[1..n-1] are decompressed and recompressed with
>>>>>>> CmprI.
>>>>>>>
>>>>>>> OTOH, when Segment Left changes from 1 to 0, the new SRH could have a
>>>>>>> different size because Addresses[1..n-1] are decompressed with CmprI and
>>>>>>> recompressed with CmprE.
>>>>>>>
>>>>>>> Let's say CmprI is 15 and CmprE is 0.  When we receive SRH with Segment
>>>>>>> Left >= 2, Addresses[1..n-1] have 1 byte for each, and Addresses[n] has
>>>>>>> 16 bytes.  When Segment Left is 1, Addresses[1..n-1] is decompressed to
>>>>>>> 16 bytes and not recompressed.  Finally, the new SRH will need more room
>>>>>>> in the header, and the size is (16 - 1) * (n - 1) bytes.
>>>>>>>
>>>>>>> Here the max value of n is 255 as Segment Left is u8, so in the worst case,
>>>>>>> we have to allocate 3825 bytes in the skb headroom.  However, now we only
>>>>>>> allocate a small fixed buffer that is IPV6_RPL_SRH_WORST_SWAP_SIZE (16 + 7
>>>>>>> bytes).  If the decompressed size overflows the room, skb_push() hits BUG()
>>>>>>> below [0].
>>>>>>>
>>>>>>> Instead of allocating the fixed buffer for every packet, let's allocate
>>>>>>> enough headroom only when we receive SRH with Segment Left 1.
>>>>>>>
>>>>>>> [0]:
>>>>>>>
>>>>>>> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
>>>>>>> Reported-by: Max VA
>>>>>>> Closes: https://www.interruptlabs.co.uk/articles/linux-ipv6-route-of-death
>>>>>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>>>>> ---
>>>>>>> To maintainers:
>>>>>>> Please complement the Reported-by address from the security@ mailing list
>>>>>>> if possible, which checkpatch will complain about.
>>>>>>>
>>>>>>> v2:
>>>>>>>      * Reload oldhdr@ after pskb_expand_head() (Eric Dumazet)
>>>>>>>
>>>>>>> v1: https://lore.kernel.org/netdev/20230605144040.39871-1-kuniyu@amazon.com/
>>>>>>> ---
>>>>>>
>>>>>> When I tested the linux-ipv6-route-of-death issue on Linux 6.4-rc7, I
>>>>>> got the following panic:
>>>>>>
>>>>>> [ 2046.147186] BUG: kernel NULL pointer dereference, address:
>>>>>> 0000000000000000
>>>>>> [ 2046.147978] #PF: supervisor read access in kernel mode
>>>>>> [ 2046.148522] #PF: error_code(0x0000) - not-present page
>>>>>> [ 2046.149082] PGD 8000000187886067 P4D 8000000187886067 PUD 187887067
>>>>>> PMD 0
>>>>>> [ 2046.149788] Oops: 0000 [#1] PREEMPT SMP PTI
>>>>>> [ 2046.150233] CPU: 4 PID: 2093 Comm: python3 Not tainted 6.4.0-rc7 #15
>>>>>> [ 2046.150964] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>>>>>> [ 2046.151566] RIP: 0010:icmp6_send+0x691/0x910
>>>>>> [ 2046.152029] Code: 78 0f 13 95 48 c7 c7 d0 a0 d4 95 e8 39 e4 ab ff e9
>>>>>> 81 fe ff ff 48 8b 43 58 48 83 e0 fe 0f 84 bf fa ff ff 48 8b 80 d0 00 00
>>>>>> 00 <48> 8b 00 8b 80 e0 00 00 00 89 85 f0 fe ff ff e9 a4 fa ff ff 0f b7
>>>>>> [ 2046.153892] RSP: 0018:ffffb463c01b0b90 EFLAGS: 00010286
>>>>>> [ 2046.154432] RAX: 0000000000000000 RBX: ffff907d03099700 RCX:
>>>>>> 0000000000000000
>>>>>> [ 2046.155160] RDX: 0000000000000021 RSI: 0000000000000000 RDI:
>>>>>> 0000000000000001
>>>>>> [ 2046.155881] RBP: ffffb463c01b0cb0 R08: 0000000000020021 R09:
>>>>>> 0000000000000040
>>>>>> [ 2046.156611] R10: ffffb463c01b0cd0 R11: 000000000000a600 R12:
>>>>>> ffff907d21a28888
>>>>>> [ 2046.157340] R13: ffff907d21a28870 R14: ffff907d21a28878 R15:
>>>>>> ffffffff97b03d00
>>>>>> [ 2046.158064] FS:  00007ff3341ba740(0000) GS:ffff908018300000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [ 2046.158895] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [ 2046.159483] CR2: 0000000000000000 CR3: 0000000109a5a000 CR4:
>>>>>> 00000000000006e0
>>>>>> [ 2046.160205] Call Trace:
>>>>>> [ 2046.160467]  <IRQ>
>>>>>> [ 2046.160693]  ? __die_body+0x1b/0x60
>>>>>> [ 2046.161059]  ? page_fault_oops+0x15b/0x470
>>>>>> [ 2046.161488]  ? fixup_exception+0x22/0x330
>>>>>> [ 2046.161901]  ? exc_page_fault+0x65/0x150
>>>>>> [ 2046.162318]  ? asm_exc_page_fault+0x22/0x30
>>>>>> [ 2046.162750]  ? icmp6_send+0x691/0x910
>>>>>> [ 2046.163137]  ? ip6_route_input+0x187/0x210
>>>>>> [ 2046.163560]  ? __pfx_free_object_rcu+0x10/0x10
>>>>>> [ 2046.164019]  ? __call_rcu_common.constprop.0+0x10a/0x5a0
>>>>>> [ 2046.164568]  ? _raw_spin_lock_irqsave+0x19/0x50
>>>>>> [ 2046.165034]  ? __pfx_free_object_rcu+0x10/0x10
>>>>>> [ 2046.165499]  ? ip6_pkt_drop+0xf2/0x1c0
>>>>>> [ 2046.165890]  ip6_pkt_drop+0xf2/0x1c0
>>>>>> [ 2046.166269]  ipv6_rthdr_rcv+0x122d/0x1310
>>>>>> [ 2046.166684]  ip6_protocol_deliver_rcu+0x4bc/0x630
>>>>>> [ 2046.167173]  ip6_input_finish+0x40/0x60
>>>>>> [ 2046.167568]  ip6_input+0x3b/0xd0
>>>>>> [ 2046.167905]  ? ip6_rcv_core.isra.0+0x2cb/0x5e0
>>>>>> [ 2046.168368]  ipv6_rcv+0x53/0x100
>>>>>> [ 2046.168706]  __netif_receive_skb_one_core+0x63/0xa0
>>>>>> [ 2046.169231]  process_backlog+0xa8/0x150
>>>>>> [ 2046.169626]  __napi_poll+0x2c/0x1b0
>>>>>> [ 2046.169991]  net_rx_action+0x260/0x330
>>>>>> [ 2046.170385]  ? kvm_sched_clock_read+0x5/0x20
>>>>>> [ 2046.170824]  ? kvm_clock_read+0x14/0x30
>>>>>> [ 2046.171226]  __do_softirq+0xe6/0x2d1
>>>>>> [ 2046.171596]  do_softirq+0x80/0xa0
>>>>>> [ 2046.171944]  </IRQ>
>>>>>> [ 2046.172178]  <TASK>
>>>>>> [ 2046.172406]  __local_bh_enable_ip+0x73/0x80
>>>>>> [ 2046.172829]  __dev_queue_xmit+0x331/0xd40
>>>>>> [ 2046.173246]  ? __local_bh_enable_ip+0x37/0x80
>>>>>> [ 2046.173692]  ? ___neigh_create+0x60b/0x8d0
>>>>>> [ 2046.174114]  ? eth_header+0x26/0xc0
>>>>>> [ 2046.174489]  ip6_finish_output2+0x1e7/0x680
>>>>>> [ 2046.174916]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>> [ 2046.175462]  ip6_finish_output+0x1df/0x350
>>>>>> [ 2046.175881]  ? nf_hook_slow+0x40/0xc0
>>>>>> [ 2046.176274]  ip6_output+0x6e/0x140
>>>>>> [ 2046.176627]  ? __pfx_ip6_finish_output+0x10/0x10
>>>>>> [ 2046.177096]  rawv6_sendmsg+0x6f9/0x1210
>>>>>> [ 2046.177497]  ? dl_cpu_busy+0x2f3/0x300
>>>>>> [ 2046.177886]  ? __pfx_dst_output+0x10/0x10
>>>>>> [ 2046.178305]  ? _raw_spin_unlock_irqrestore+0x1e/0x40
>>>>>> [ 2046.178825]  ? __wake_up_common_lock+0x91/0xd0
>>>>>> [ 2046.179339]  ? sock_sendmsg+0x8b/0xa0
>>>>>> [ 2046.179791]  ? __pfx_rawv6_sendmsg+0x10/0x10
>>>>>> [ 2046.180246]  sock_sendmsg+0x8b/0xa0
>>>>>> [ 2046.180610]  __sys_sendto+0xfa/0x170
>>>>>> [ 2046.180983]  ? __bitmap_weight+0x4b/0x60
>>>>>> [ 2046.181399]  ? task_mm_cid_work+0x183/0x200
>>>>>> [ 2046.181827]  __x64_sys_sendto+0x25/0x30
>>>>>> [ 2046.182228]  do_syscall_64+0x3b/0x90
>>>>>> [ 2046.182599]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>>> [ 2046.183109] RIP: 0033:0x7ff3344a668a
>>>>>> [ 2046.183493] Code: 48 c7 c0 ff ff ff ff eb bc 0f 1f 80 00 00 00 00 f3
>>>>>> 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f
>>>>>> 05 <48> 3d 00 f0 ff ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
>>>>>> [ 2046.185326] RSP: 002b:00007ffc82a34658 EFLAGS: 00000246 ORIG_RAX:
>>>>>> 000000000000002c
>>>>>> [ 2046.186083] RAX: ffffffffffffffda RBX: 00007ffc82a346f0 RCX:
>>>>>> 00007ff3344a668a
>>>>>> [ 2046.186799] RDX: 0000000000000060 RSI: 00007ff33112db00 RDI:
>>>>>> 0000000000000003
>>>>>> [ 2046.187515] RBP: 000000000159cd90 R08: 00007ffc82a34770 R09:
>>>>>> 000000000000001c
>>>>>> [ 2046.188230] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>>>> 0000000000000000
>>>>>> [ 2046.188958] R13: 0000000000000000 R14: 00007ffc82a346f0 R15:
>>>>>> 0000000000451072
>>>>>> [ 2046.189675]  </TASK>
>>>>>> [ 2046.189909] Modules linked in: fuse rfkill binfmt_misc cirrus
>>>>>> drm_shmem_helper joydev drm_kms_helper sg syscopyarea sysfillrect
>>>>>> sysimgblt virtio_balloon serio_raw squashfs parport_pc ppdev lp parport
>>>>>> ramoops reed_solomon drm ip_tables x_tables xfs sd_mod t10_pi
>>>>>> crc64_rocksoft crc64 ata_generic ata_piix virtio_net net_failover
>>>>>> failover libata e1000 i2c_piix4
>>>>>> [ 2046.193039] CR2: 0000000000000000
>>>>>> [ 2046.193400] ---[ end trace 0000000000000000 ]---
>>>>>> [ 2046.193870] RIP: 0010:icmp6_send+0x691/0x910
>>>>>> [ 2046.194315] Code: 78 0f 13 95 48 c7 c7 d0 a0 d4 95 e8 39 e4 ab ff e9
>>>>>> 81 fe ff ff 48 8b 43 58 48 83 e0 fe 0f 84 bf fa ff ff 48 8b 80 d0 00 00
>>>>>> 00 <48> 8b 00 8b 80 e0 00 00 00 89 85 f0 fe ff ff e9 a4 fa ff ff 0f b7
>>>>>> [ 2046.196146] RSP: 0018:ffffb463c01b0b90 EFLAGS: 00010286
>>>>>> [ 2046.196672] RAX: 0000000000000000 RBX: ffff907d03099700 RCX:
>>>>>> 0000000000000000
>>>>>> [ 2046.197388] RDX: 0000000000000021 RSI: 0000000000000000 RDI:
>>>>>> 0000000000000001
>>>>>> [ 2046.198096] RBP: ffffb463c01b0cb0 R08: 0000000000020021 R09:
>>>>>> 0000000000000040
>>>>>> [ 2046.198825] R10: ffffb463c01b0cd0 R11: 000000000000a600 R12:
>>>>>> ffff907d21a28888
>>>>>> [ 2046.199537] R13: ffff907d21a28870 R14: ffff907d21a28878 R15:
>>>>>> ffffffff97b03d00
>>>>>> [ 2046.200253] FS:  00007ff3341ba740(0000) GS:ffff908018300000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [ 2046.201044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [ 2046.201624] CR2: 0000000000000000 CR3: 0000000109a5a000 CR4:
>>>>>> 00000000000006e0
>>>>>> [ 2046.202340] Kernel panic - not syncing: Fatal exception in interrupt
>>>>>> [ 2046.203655] Kernel Offset: 0x12e00000 from 0xffffffff81000000
>>>>>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>>>>> [ 2046.204731] ---[ end Kernel panic - not syncing: Fatal exception in
>>>>>> interrupt ]---
>>>>>
>>>>> Please decode the stack trace.
>>>>>
>>>>> $ cat <<EOF | ./scripts/decode_stacktrace.sh vmlinux
>>>>> PASTE YOUR TRACE HERE
>>>>> EOF
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> The test procedure is as follows:
>>>>>> # sysctl -a | grep -i rpl_seg_enabled
>>>>>> net.ipv6.conf.all.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.default.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.dummy0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.ens3.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.ens4.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.erspan0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.gre0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.gretap0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.ip6_vti0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.ip6gre0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.ip6tnl0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.ip_vti0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.lo.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.sit0.rpl_seg_enabled = 1
>>>>>> net.ipv6.conf.tunl0.rpl_seg_enabled = 1
>>>>>>
>>>>>> # python3
>>>>>> Python 3.8.10 (default, Nov 14 2022, 12:59:47)
>>>>>> [GCC 9.4.0] on linux
>>>>>> Type "help", "copyright", "credits" or "license" for more information.
>>>>>>    >>> from scapy.all import *
>>>>>>    >>> import socket
>>>>>>    >>> DST_ADDR = "fe80::266:88ff:fe99:7419"
>>>>>>    >>> SRC_ADDR = DST_ADDR
>>>>>>    >>> sockfd = socket.socket(socket.AF_INET6, socket.SOCK_RAW,
>>>>>> socket.IPPROTO_RAW)
>>>>>>    >>> p = IPv6(src=SRC_ADDR, dst=DST_ADDR) /
>>>>>> IPv6ExtHdrSegmentRouting(type=3, addresses=["a8::", "a7::", "a6::"],
>>>>>> segleft=1, lastentry=0xf0)
>>>>>>    >>> sockfd.sendto(bytes(p), (DST_ADDR, 0))
>>>>>>
>>>>>> Is this a new issue?
>>>>>
>>>>> Can you test this ?  I couldn't reproduce the issue on my setup...
>>>>>
>>>>> ---8<---
>>>>> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
>>>>> index 202fc3aaa83c..f2890c391e3b 100644
>>>>> --- a/net/ipv6/exthdrs.c
>>>>> +++ b/net/ipv6/exthdrs.c
>>>>> @@ -587,7 +587,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>>>>>    	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
>>>>>    	skb_postpull_rcsum(skb, oldhdr,
>>>>>    			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
>>>>> -	if (unlikely(!hdr->segments_left)) {
>>>>> +	if (unlikely(!hdr->segments_left) || skb_cloned(skb)) {
>>>>>    		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
>>>>>    				     GFP_ATOMIC)) {
>>>>>    			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
>>>>> ---8<---
>>>>
>>>> I tested it and the problem persisted, and attached the config I used.
>>>>
>>>> Also,the DST_ADDR = "fe80::266:88ff:fe99:7419" I used the  the
>>>> link-local address of the local NIC ens4.
>>>>
>>>> # ip addr show dev ens4
>>>> 12: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
>>>> state UP group default qlen 1000
>>>>       link/ether 00:66:88:99:74:19 brd ff:ff:ff:ff:ff:ff
>>>>       altname enp0s4
>>>>       inet 169.254.6.143/16 brd 169.254.255.255 scope link ens4:avahi
>>>>          valid_lft forever preferred_lft forever
>>>>       inet6 fe80::266:88ff:fe99:7419/64 scope link
>>>>          valid_lft forever preferred_lft forever
>>>>
>>>> The test machine is an Ubuntu 20.04.4 LTS VM.
>>>
>>> Could you provide your decoded stack trace ?
>>>
>>> It seems the packet is dropped.  I'd like to know where it happens.
>>
>> Ok, I think I reproduced your issue by forcibly calling
>> ip6_pkt_discard_out() for the skb.
> 
> I just forgot to "return -1" after this, that leads to null-ptr-deref
> in ipv6_rthdr_rcv(), not icmp6_send().
> 
> So, I didn't reproduce the issue.
> 
> Also, I should have used ip6_pkt_discard().  Neither didn't reproduce
> it with return -1 though.
> 
> Could you provide these info ?
> 
> * the log of skb_dump() with the diff below
> * decoded stack trace
> * the output of
>    * ip -d rule
# ip -d rule
0:	from all lookup local proto kernel
220:	from all lookup 220 proto unspec
32766:	from all lookup main proto kernel
32767:	from all lookup default proto kernel

>    * ip -d route (for all tables)
# ip -d route
unicast default dev ens4 proto boot scope link metric 1012
unicast default via 192.168.123.1 dev ens3 proto dhcp scope global 
metric 20100
unicast 169.254.0.0/16 dev ens4 proto kernel scope link src 169.254.6.143
unicast 169.254.0.0/16 dev ens3 proto boot scope link metric 1000
unicast 192.168.123.0/24 dev ens3 proto kernel scope link src 
192.168.123.110 metric 100

>    * ip -d neigh
# ip -d neigh
185.125.188.55 dev ens4 FAILED
185.125.190.58 dev ens4 INCOMPLETE
91.189.91.157 dev ens4 FAILED
185.125.188.54 dev ens4 FAILED
185.125.190.57 dev ens4 FAILED
192.168.123.1 dev ens3 lladdr 52:54:00:b9:d7:30 REACHABLE
185.125.188.59 dev ens4 FAILED
185.125.190.56 dev ens4 FAILED
185.125.188.58 dev ens4 FAILED
> 
> ---8<---
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 5fa0e37305d9..41e9256cb81e 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -642,6 +642,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>   	ip6_route_input(skb);
>   
>   	if (skb_dst(skb)->error) {
> +		skb_dump(KERN_ERR, skb, true);
skb_dump info as follows:
[  529.457596] skb len=576 headroom=112 headlen=576 tailroom=1040
[  529.457596] mac=(98,14) net=(112,40) trans=152
[  529.457596] shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
[  529.457596] csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
[  529.457596] hash(0x0 sw=0 l4=0) proto=0x86dd pkttype=0 iif=1
[  529.460505] dev name=lo feat=0x00000516401d7c69
[  529.461039] skb headroom: 00000000: 6c 69 62 6e 73 73 5f 66 69 6c 65 
73 2d 32 2e 33
[  529.461842] skb headroom: 00000010: 31 2e 73 6f 00 00 6c 64 2d 32 2e 
33 31 2e 73 6f
[  529.462673] skb headroom: 00000020: 00 00 a1 c5 3b 8c ff ff 20 d8 a1 
c5 3b 8c ff ff
[  529.463503] skb headroom: 00000030: 30 d8 a1 c5 3b 8c ff ff 30 d8 a1 
c5 3b 8c ff ff
[  529.464348] skb headroom: 00000040: 40 d8 a1 c5 3b 8c ff ff 40 d8 a1 
c5 3b 8c ff ff
[  529.465190] skb headroom: 00000050: 50 d8 a1 c5 3b 8c ff ff 50 d8 a1 
c5 3b 8c ff ff
[  529.466040] skb headroom: 00000060: 60 d8 00 00 00 00 00 00 00 00 00 
00 00 00 86 dd
[  529.466835] skb linear:   00000000: 60 00 00 00 02 18 2b 40 fe 80 00 
00 00 00 00 00
[  529.467656] skb linear:   00000010: 02 66 88 ff fe 99 74 19 00 a6 00 
00 00 00 00 00
[  529.468484] skb linear:   00000020: 00 00 00 00 00 00 00 00 3b 42 03 
00 00 00 00 00
[  529.469312] skb linear:   00000030: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.470140] skb linear:   00000040: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 a8
[  529.470946] skb linear:   00000050: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.471755] skb linear:   00000060: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.472583] skb linear:   00000070: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.473410] skb linear:   00000080: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.474245] skb linear:   00000090: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.475073] skb linear:   000000a0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.475885] skb linear:   000000b0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.476700] skb linear:   000000c0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.477521] skb linear:   000000d0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.478341] skb linear:   000000e0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.479164] skb linear:   000000f0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.479964] skb linear:   00000100: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.480769] skb linear:   00000110: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.481588] skb linear:   00000120: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.482407] skb linear:   00000130: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.483228] skb linear:   00000140: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 a7
[  529.484051] skb linear:   00000150: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.484842] skb linear:   00000160: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.485673] skb linear:   00000170: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.486492] skb linear:   00000180: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.487310] skb linear:   00000190: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.488126] skb linear:   000001a0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.488940] skb linear:   000001b0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.489743] skb linear:   000001c0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.490560] skb linear:   000001d0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.491377] skb linear:   000001e0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.492195] skb linear:   000001f0: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.493014] skb linear:   00000200: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.493803] skb linear:   00000210: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.494615] skb linear:   00000220: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 00
[  529.495451] skb linear:   00000230: fe 80 00 00 00 00 00 00 02 66 88 
ff fe 99 74 19
[  529.496265] skb tailroom: 00000000: b0 da a1 c5 3b 8c ff ff b0 da a1 
c5 3b 8c ff ff
[  529.497082] skb tailroom: 00000010: c0 da a1 c5 3b 8c ff ff c0 da a1 
c5 3b 8c ff ff
[  529.497867] skb tailroom: 00000020: d0 da a1 c5 3b 8c ff ff d0 da a1 
c5 3b 8c ff ff
[  529.498679] skb tailroom: 00000030: e0 da a1 c5 3b 8c ff ff e0 da a1 
c5 3b 8c ff ff
[  529.499492] skb tailroom: 00000040: f0 da a1 c5 3b 8c ff ff f0 da a1 
c5 3b 8c ff ff
[  529.500306] skb tailroom: 00000050: 00 db a1 c5 3b 8c ff ff 00 db a1 
c5 3b 8c ff ff
[  529.501122] skb tailroom: 00000060: 10 db a1 c5 3b 8c ff ff 10 db a1 
c5 3b 8c ff ff
[  529.501912] skb tailroom: 00000070: 20 db a1 c5 3b 8c ff ff 20 db a1 
c5 3b 8c ff ff
[  529.502718] skb tailroom: 00000080: 30 db a1 c5 3b 8c ff ff 30 db a1 
c5 3b 8c ff ff
[  529.503531] skb tailroom: 00000090: 40 db a1 c5 3b 8c ff ff 40 db a1 
c5 3b 8c ff ff
[  529.504344] skb tailroom: 000000a0: 50 db a1 c5 3b 8c ff ff 50 db a1 
c5 3b 8c ff ff
[  529.505163] skb tailroom: 000000b0: 60 db a1 c5 3b 8c ff ff 60 db a1 
c5 3b 8c ff ff
[  529.505996] skb tailroom: 000000c0: 70 db a1 c5 3b 8c ff ff 70 db a1 
c5 3b 8c ff ff
[  529.506778] skb tailroom: 000000d0: 80 db a1 c5 3b 8c ff ff 80 db a1 
c5 3b 8c ff ff
[  529.507586] skb tailroom: 000000e0: 90 db a1 c5 3b 8c ff ff 90 db a1 
c5 3b 8c ff ff
[  529.508396] skb tailroom: 000000f0: a0 db a1 c5 3b 8c ff ff a0 db a1 
c5 3b 8c ff ff
[  529.509208] skb tailroom: 00000100: b0 db a1 c5 3b 8c ff ff b0 db a1 
c5 3b 8c ff ff
[  529.510022] skb tailroom: 00000110: c0 db a1 c5 3b 8c ff ff c0 db a1 
c5 3b 8c ff ff
[  529.510805] skb tailroom: 00000120: d0 db a1 c5 3b 8c ff ff d0 db a1 
c5 3b 8c ff ff
[  529.511614] skb tailroom: 00000130: e0 db a1 c5 3b 8c ff ff e0 db a1 
c5 3b 8c ff ff
[  529.512424] skb tailroom: 00000140: f0 db a1 c5 3b 8c ff ff f0 db a1 
c5 3b 8c ff ff
[  529.513239] skb tailroom: 00000150: 00 b0 a1 c5 3b 8c ff ff 00 dc a1 
c5 3b 8c ff ff
[  529.514051] skb tailroom: 00000160: 10 dc a1 c5 3b 8c ff ff 10 dc a1 
c5 3b 8c ff ff
[  529.514834] skb tailroom: 00000170: 20 dc a1 c5 3b 8c ff ff 20 dc a1 
c5 3b 8c ff ff
[  529.515663] skb tailroom: 00000180: 30 dc a1 c5 3b 8c ff ff 30 dc a1 
c5 3b 8c ff ff
[  529.516472] skb tailroom: 00000190: 40 dc a1 c5 3b 8c ff ff 40 dc a1 
c5 3b 8c ff ff
[  529.517280] skb tailroom: 000001a0: 50 dc a1 c5 3b 8c ff ff 50 dc a1 
c5 3b 8c ff ff
[  529.518090] skb tailroom: 000001b0: 60 dc a1 c5 3b 8c ff ff 60 dc a1 
c5 3b 8c ff ff
[  529.518872] skb tailroom: 000001c0: 70 dc a1 c5 3b 8c ff ff 70 dc a1 
c5 3b 8c ff ff
[  529.519677] skb tailroom: 000001d0: 80 dc a1 c5 3b 8c ff ff 80 dc a1 
c5 3b 8c ff ff
[  529.520488] skb tailroom: 000001e0: 90 dc a1 c5 3b 8c ff ff 90 dc a1 
c5 3b 8c ff ff
[  529.521297] skb tailroom: 000001f0: a0 dc a1 c5 3b 8c ff ff a0 dc a1 
c5 3b 8c ff ff
[  529.522109] skb tailroom: 00000200: b0 dc a1 c5 3b 8c ff ff b0 dc a1 
c5 3b 8c ff ff
[  529.522892] skb tailroom: 00000210: c0 dc a1 c5 3b 8c ff ff c0 dc a1 
c5 3b 8c ff ff
[  529.523697] skb tailroom: 00000220: d0 dc a1 c5 3b 8c ff ff d0 dc a1 
c5 3b 8c ff ff
[  529.524505] skb tailroom: 00000230: e0 dc a1 c5 3b 8c ff ff e0 dc a1 
c5 3b 8c ff ff
[  529.525335] skb tailroom: 00000240: f0 dc a1 c5 3b 8c ff ff f0 dc a1 
c5 3b 8c ff ff
[  529.526147] skb tailroom: 00000250: 00 dd a1 c5 3b 8c ff ff 00 dd a1 
c5 3b 8c ff ff
[  529.526941] skb tailroom: 00000260: 10 dd a1 c5 3b 8c ff ff 10 dd a1 
c5 3b 8c ff ff
[  529.527737] skb tailroom: 00000270: 20 dd a1 c5 3b 8c ff ff 20 dd a1 
c5 3b 8c ff ff
[  529.528542] skb tailroom: 00000280: 30 dd a1 c5 3b 8c ff ff 30 dd a1 
c5 3b 8c ff ff
[  529.529348] skb tailroom: 00000290: 40 dd a1 c5 3b 8c ff ff 40 dd a1 
c5 3b 8c ff ff
[  529.530154] skb tailroom: 000002a0: 50 dd a1 c5 3b 8c ff ff 50 dd a1 
c5 3b 8c ff ff
[  529.530941] skb tailroom: 000002b0: 60 dd a1 c5 3b 8c ff ff 60 dd a1 
c5 3b 8c ff ff
[  529.531734] skb tailroom: 000002c0: 70 dd a1 c5 3b 8c ff ff 70 dd a1 
c5 3b 8c ff ff
[  529.532540] skb tailroom: 000002d0: 80 dd a1 c5 3b 8c ff ff 80 dd a1 
c5 3b 8c ff ff
[  529.533348] skb tailroom: 000002e0: 90 dd a1 c5 3b 8c ff ff 90 dd a1 
c5 3b 8c ff ff
[  529.534155] skb tailroom: 000002f0: a0 dd a1 c5 3b 8c ff ff a0 dd a1 
c5 3b 8c ff ff
[  529.534943] skb tailroom: 00000300: b0 dd a1 c5 3b 8c ff ff b0 dd a1 
c5 3b 8c ff ff
[  529.535753] skb tailroom: 00000310: c0 dd a1 c5 3b 8c ff ff c0 dd a1 
c5 3b 8c ff ff
[  529.536560] skb tailroom: 00000320: d0 dd a1 c5 3b 8c ff ff d0 dd a1 
c5 3b 8c ff ff
[  529.537369] skb tailroom: 00000330: e0 dd a1 c5 3b 8c ff ff e0 dd a1 
c5 3b 8c ff ff
[  529.538174] skb tailroom: 00000340: f0 dd a1 c5 3b 8c ff ff f0 dd a1 
c5 3b 8c ff ff
[  529.538962] skb tailroom: 00000350: 00 de a1 c5 3b 8c ff ff 00 de a1 
c5 3b 8c ff ff
[  529.539755] skb tailroom: 00000360: 10 de a1 c5 3b 8c ff ff 10 de a1 
c5 3b 8c ff ff
[  529.540559] skb tailroom: 00000370: 20 de a1 c5 3b 8c ff ff 20 de a1 
c5 3b 8c ff ff
[  529.541366] skb tailroom: 00000380: 30 de a1 c5 3b 8c ff ff 30 de a1 
c5 3b 8c ff ff
[  529.542173] skb tailroom: 00000390: 40 de a1 c5 3b 8c ff ff 40 de a1 
c5 3b 8c ff ff
[  529.542959] skb tailroom: 000003a0: 00 00 00 00 00 00 00 00 63 00 00 
00 63 00 00 00
[  529.543752] skb tailroom: 000003b0: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[  529.544555] skb tailroom: 000003c0: 70 de a1 c5 3b 8c ff ff 70 de a1 
c5 3b 8c ff ff
[  529.545376] skb tailroom: 000003d0: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[  529.546179] skb tailroom: 000003e0: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[  529.546965] skb tailroom: 000003f0: 40 12 3b d8 3e 8c ff ff 80 e6 34 
d3 3b 8c ff ff
[  529.547754] skb tailroom: 00000400: 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00

The position of the null pointer is as follows:

ipv6_rpl_srh_rcv()
   ...
   if (skb_dst(skb)->error) {
     dst_input(skb);
       ... ip6_pkt_discard()
         ip6_pkt_drop()
           icmpv6_send()
             icmp6_send()
               if (__ipv6_addr_needs_scope_id(addr_type)) {
                 iif = icmp6_iif(skb)；
                   icmp6_dev()
                     if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || 
netif_is_l3_master(skb->dev))) {
                       const struct rt6_info *rt6 = skb_rt6_info(skb);
                       if (rt6)
                         dev = rt6->rt6i_idev->dev;
			  <==== rt6->rt6i_idev is NULL

>   		dst_input(skb);
>   		return -1;
>   	}
> @@ -660,6 +661,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>   		goto looped_back;
>   	}
>   
> +	skb_dump(KERN_ERR, skb, true);
>   	dst_input(skb);
>   
>   	return -1;
> ---8<---

