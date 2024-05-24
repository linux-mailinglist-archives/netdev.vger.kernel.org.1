Return-Path: <netdev+bounces-97949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BB8CE456
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616EF1C20DA4
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1089F85269;
	Fri, 24 May 2024 10:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C3A2CA5;
	Fri, 24 May 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547252; cv=none; b=DnOu7VCm3voG3XCPSnY6XIIcYGSHE1qrqsT0fG7xQ9RBe+YAwOI7r9g5/VofsFfrIOPqvHVWvfRyAsqpIgCP2giU7Gp/69/hQxGqUk4LAownAPygQ72g8rx9pzbycHQqCNqk+JMsTL4F2OwX5Jrj0BRXaF7uZdINrIfRrFDOQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547252; c=relaxed/simple;
	bh=CwLuka3kg8BCvAxH8Ww5uLYNjfB369IVdj6s6g2dKao=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dTkV2vffgb80eXNLu1esEC35HVF4eMa+NxDNxW3HUVMURP7SuiYqVT0tKdYaHlwSPxKzbAeVuSbOkenmRxO6+ExMATXPvmu97AWdusdaLpeTWz3BJTz/Lo+EiCc4ZJ907PIplf14D2cG5RjtMBU2VZmUeKmhMSVVC3N0QoANpwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vm1gg4WXgz1S6CZ;
	Fri, 24 May 2024 18:37:03 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id 514BA180A9C;
	Fri, 24 May 2024 18:40:44 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 18:40:43 +0800
Subject: Re: [PATCH net] net/sched: Add xmit_recursion level in
 sch_direct_xmit()
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<hannes@stressinduktion.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240524085108.1430317-1-yuehaibing@huawei.com>
 <CANn89iL5-w3NzupmR4LgskvW2yw1jgnhdFg1HRg+k+JY38G6+w@mail.gmail.com>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <5d001e22-c9fe-60d2-a775-40e1c44a1c56@huawei.com>
Date: Fri, 24 May 2024 18:40:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iL5-w3NzupmR4LgskvW2yw1jgnhdFg1HRg+k+JY38G6+w@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------00ADEC1C92B0C2B19DC468A7"
Content-Language: en-US
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)

--------------00ADEC1C92B0C2B19DC468A7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 2024/5/24 17:24, Eric Dumazet wrote:
> On Fri, May 24, 2024 at 10:49 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will hit
>> WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path while ipvlan
>> device has qdisc queue.
>>
>> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
>> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm_kms_helper
>> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:sk_mc_loop+0x2d/0x70
>> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 85 ff 74 1c
>> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
>> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
>> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
>> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
>> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
>> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
>> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <IRQ>
>>  ? __warn+0x83/0x130
>>  ? sk_mc_loop+0x2d/0x70
>>  ? report_bug+0x18e/0x1a0
>>  ? handle_bug+0x3c/0x70
>>  ? exc_invalid_op+0x18/0x70
>>  ? asm_exc_invalid_op+0x1a/0x20
>>  ? sk_mc_loop+0x2d/0x70
>>  ip6_finish_output2+0x31e/0x590
>>  ? nf_hook_slow+0x43/0xf0
>>  ip6_finish_output+0x1f8/0x320
>>  ? __pfx_ip6_finish_output+0x10/0x10
>>  ipvlan_xmit_mode_l3+0x22a/0x2a0 [ipvlan]
>>  ipvlan_start_xmit+0x17/0x50 [ipvlan]
>>  dev_hard_start_xmit+0x8c/0x1d0
>>  sch_direct_xmit+0xa2/0x390
>>  __qdisc_run+0x66/0xd0
>>  net_tx_action+0x1ca/0x270
>>  handle_softirqs+0xd6/0x2b0
>>  __irq_exit_rcu+0x9b/0xc0
>>  sysvec_apic_timer_interrupt+0x75/0x90
> 
> Please provide full symbols in stack traces.

Call Trace:
<IRQ>
? __warn (kernel/panic.c:693)
? sk_mc_loop (net/core/sock.c:775 net/core/sock.c:760)
? report_bug (lib/bug.c:201 lib/bug.c:219)
? handle_bug (arch/x86/kernel/traps.c:239)
? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
? sk_mc_loop (net/core/sock.c:775 net/core/sock.c:760)
ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
? nf_hook_slow (./include/linux/netfilter.h:154 net/netfilter/core.c:626)
ip6_finish_output (net/ipv6/ip6_output.c:211 net/ipv6/ip6_output.c:222)
? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:498 drivers/net/ipvlan/ipvlan_core.c:538 drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
dev_hard_start_xmit (./include/linux/netdevice.h:4882 ./include/linux/netdevice.h:4896 net/core/dev.c:3578 net/core/dev.c:3594)
sch_direct_xmit (net/sched/sch_generic.c:343)
__qdisc_run (net/sched/sch_generic.c:416)
net_tx_action (./include/net/sch_generic.h:219 ./include/net/pkt_sched.h:128 ./include/net/pkt_sched.h:124 net/core/dev.c:5286)
handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555)
__irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637)
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043)

> 
>>  </IRQ>
>>
>> Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive dereference inside the stack")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  include/linux/netdevice.h | 17 +++++++++++++++++
>>  net/core/dev.h            | 17 -----------------
>>  net/sched/sch_generic.c   |  8 +++++---
>>  3 files changed, 22 insertions(+), 20 deletions(-)
> 
> This patch seems unrelated to the WARN_ON_ONCE(1) met in sk_mc_loop()
> 
> If sk_mc_loop() is called with a socket which is not inet, we are in trouble.
> 
> Please fix the root cause instead of trying to shortcut sk_mc_loop() as you did.
First setup like this:
ip netns add ns0
ip netns add ns1
ip link add ip0 link eth0 type ipvlan mode l3 vepa
ip link add ip1 link eth0 type ipvlan mode l3 vepa
ip link set ip0 netns ns0
ip link exec ip link set ip0 up
ip link set ip1 netns ns1
ip link exec ip link set ip1 up
ip link exec tc qdisc add dev ip1 root netem delay 10ms

Second, build and send a raw ipv6 multicast packet as attached repro in ns1

packet_sendmsg
   packet_snd //skb->sk is packet sk
      __dev_queue_xmit
         __dev_xmit_skb //q->enqueue is not NULL
             __qdisc_run
                 qdisc_restart
                    sch_direct_xmit
                       dev_hard_start_xmit
                          netdev_start_xmit
                            ipvlan_start_xmit
                              ipvlan_xmit_mode_l3 //l3 mode
                                 ipvlan_process_outbound //vepa flag
                                   ipvlan_process_v6_outbound //skb->protocol is ETH_P_IPV6
                                      ip6_local_out
                                       ...
                                         __ip6_finish_output
                                            ip6_finish_output2 //multicast packet
                                               sk_mc_loop //dev_recursion_level is 0
                                                  WARN_ON_ONCE //sk->sk_family is AF_PACKET

> .
> 

--------------00ADEC1C92B0C2B19DC468A7
Content-Type: text/plain; charset="UTF-8"; name="repro.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="repro.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8dW5p
c3RkLmg+ICAgICAgICAgICAvLyBjbG9zZSgpDQojaW5jbHVkZSA8c3RyaW5nLmg+ICAgICAg
ICAgICAvLyBzdHJjcHksIG1lbXNldCgpLCBhbmQgbWVtY3B5KCkNCiNpbmNsdWRlIDxuZXRk
Yi5oPiAgICAgICAgICAgIC8vIHN0cnVjdCBhZGRyaW5mbw0KI2luY2x1ZGUgPHN5cy90eXBl
cy5oPiAgICAgICAgLy8gbmVlZGVkIGZvciBzb2NrZXQoKSwgdWludDhfdCwgdWludDE2X3Qs
IHVpbnQzMl90DQojaW5jbHVkZSA8c3lzL3NvY2tldC5oPiAgICAgICAvLyBuZWVkZWQgZm9y
IHNvY2tldCgpDQojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPiAgICAgICAvLyBJUFBST1RPX1RD
UCwgSU5FVDZfQUREUlNUUkxFTg0KI2luY2x1ZGUgPG5ldGluZXQvaXAuaD4gICAgICAgLy8g
SVBfTUFYUEFDS0VUICh3aGljaCBpcyA2NTUzNSkNCiNpbmNsdWRlIDxuZXRpbmV0L2lwNi5o
PiAgICAgIC8vIHN0cnVjdCBpcDZfaGRyDQojZGVmaW5lIF9fRkFWT1JfQlNEICAgICAgICAg
ICAvLyBVc2UgQlNEIGZvcm1hdCBvZiB0Y3AgaGVhZGVyDQojaW5jbHVkZSA8bmV0aW5ldC90
Y3AuaD4gICAgICAvLyBzdHJ1Y3QgdGNwaGRyDQojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+ICAg
ICAgICAvLyBpbmV0X3B0b24oKSBhbmQgaW5ldF9udG9wKCkNCiNpbmNsdWRlIDxzeXMvaW9j
dGwuaD4gICAgICAgIC8vIG1hY3JvIGlvY3RsIGlzIGRlZmluZWQNCiNpbmNsdWRlIDxiaXRz
L2lvY3Rscy5oPiAgICAgIC8vIGRlZmluZXMgdmFsdWVzIGZvciBhcmd1bWVudCAicmVxdWVz
dCIgb2YgaW9jdGwuDQojaW5jbHVkZSA8bmV0L2lmLmg+ICAgICAgICAgICAvLyBzdHJ1Y3Qg
aWZyZXENCiNpbmNsdWRlIDxsaW51eC9pZl9ldGhlci5oPiAgIC8vIEVUSF9QX0lQID0gMHgw
ODAwLCBFVEhfUF9JUFY2ID0gMHg4NkREDQojaW5jbHVkZSA8bGludXgvaWZfcGFja2V0Lmg+
ICAvLyBzdHJ1Y3Qgc29ja2FkZHJfbGwgKHNlZSBtYW4gNyBwYWNrZXQpDQojaW5jbHVkZSA8
bmV0L2V0aGVybmV0Lmg+DQojaW5jbHVkZSA8ZXJybm8uaD4gICAgICAgICAgICAvLyBlcnJu
bywgcGVycm9yKCkNCg0KI2RlZmluZSBFVEhfSERSTEVOIDE0ICAvLyBFdGhlcm5ldCBoZWFk
ZXIgbGVuZ3RoDQojZGVmaW5lIElQNl9IRFJMRU4gNDAgIC8vIElQdjYgaGVhZGVyIGxlbmd0
aA0KI2RlZmluZSBUQ1BfSERSTEVOIDIwICAvLyBUQ1AgaGVhZGVyIGxlbmd0aCwgZXhjbHVk
ZXMgb3B0aW9ucyBkYXRhDQoNCnVpbnQxNl90IGNoZWNrc3VtICh1aW50MTZfdCAqLCBpbnQp
Ow0KdWludDE2X3QgdGNwNl9jaGVja3N1bSAoc3RydWN0IGlwNl9oZHIsIHN0cnVjdCB0Y3Bo
ZHIpOw0KY2hhciAqYWxsb2NhdGVfc3RybWVtIChpbnQpOw0KdWludDhfdCAqYWxsb2NhdGVf
dXN0cm1lbSAoaW50KTsNCmludCAqYWxsb2NhdGVfaW50bWVtIChpbnQpOw0KDQppbnQgbWFp
biAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0Kew0KICBpbnQgaSwgc3RhdHVzLCBmcmFtZV9s
ZW5ndGgsIHNkLCBieXRlcywgKnRjcF9mbGFnczsNCiAgY2hhciAqaW50ZXJmYWNlLCAqdGFy
Z2V0LCAqc3JjX2lwLCAqZHN0X2lwOw0KICBzdHJ1Y3QgaXA2X2hkciBpcGhkcjsNCiAgc3Ry
dWN0IHRjcGhkciB0Y3BoZHI7DQogIHVpbnQ4X3QgKnNyY19tYWMsICpkc3RfbWFjLCAqZXRo
ZXJfZnJhbWU7DQogIHN0cnVjdCBhZGRyaW5mbyBoaW50cywgKnJlczsNCiAgc3RydWN0IHNv
Y2thZGRyX2luNiAqaXB2NjsNCiAgc3RydWN0IHNvY2thZGRyX2xsIGRldmljZTsNCiAgc3Ry
dWN0IGlmcmVxIGlmcjsNCiAgdm9pZCAqdG1wOw0KDQogIC8vIEFsbG9jYXRlIG1lbW9yeSBm
b3IgdmFyaW91cyBhcnJheXMuDQogIHNyY19tYWMgPSBhbGxvY2F0ZV91c3RybWVtICg2KTsN
CiAgZHN0X21hYyA9IGFsbG9jYXRlX3VzdHJtZW0gKDYpOw0KICBldGhlcl9mcmFtZSA9IGFs
bG9jYXRlX3VzdHJtZW0gKElQX01BWFBBQ0tFVCk7DQogIGludGVyZmFjZSA9IGFsbG9jYXRl
X3N0cm1lbSAoNDApOw0KICB0YXJnZXQgPSBhbGxvY2F0ZV9zdHJtZW0gKElORVQ2X0FERFJT
VFJMRU4pOw0KICBzcmNfaXAgPSBhbGxvY2F0ZV9zdHJtZW0gKElORVQ2X0FERFJTVFJMRU4p
Ow0KICBkc3RfaXAgPSBhbGxvY2F0ZV9zdHJtZW0gKElORVQ2X0FERFJTVFJMRU4pOw0KICB0
Y3BfZmxhZ3MgPSBhbGxvY2F0ZV9pbnRtZW0gKDgpOw0KDQogIC8vIEludGVyZmFjZSB0byBz
ZW5kIHBhY2tldCB0aHJvdWdoLg0KICBzdHJjcHkgKGludGVyZmFjZSwgImlwMSIpOw0KDQog
IC8vIFN1Ym1pdCByZXF1ZXN0IGZvciBhIHNvY2tldCBkZXNjcmlwdG9yIHRvIGxvb2sgdXAg
aW50ZXJmYWNlLg0KICBpZiAoKHNkID0gc29ja2V0IChQRl9QQUNLRVQsIFNPQ0tfUkFXLCBo
dG9ucyAoRVRIX1BfQUxMKSkpIDwgMCkgew0KICAgIHBlcnJvciAoInNvY2tldCgpIGZhaWxl
ZCB0byBnZXQgc29ja2V0IGRlc2NyaXB0b3IgZm9yIHVzaW5nIGlvY3RsKCkgIik7DQogICAg
ZXhpdCAoRVhJVF9GQUlMVVJFKTsNCiAgfQ0KDQogIC8vIFVzZSBpb2N0bCgpIHRvIGxvb2sg
dXAgaW50ZXJmYWNlIG5hbWUgYW5kIGdldCBpdHMgTUFDIGFkZHJlc3MuDQogIG1lbXNldCAo
JmlmciwgMCwgc2l6ZW9mIChpZnIpKTsNCiAgc25wcmludGYgKGlmci5pZnJfbmFtZSwgc2l6
ZW9mIChpZnIuaWZyX25hbWUpLCAiJXMiLCBpbnRlcmZhY2UpOw0KICBpZiAoaW9jdGwgKHNk
LCBTSU9DR0lGSFdBRERSLCAmaWZyKSA8IDApIHsNCiAgICBwZXJyb3IgKCJpb2N0bCgpIGZh
aWxlZCB0byBnZXQgc291cmNlIE1BQyBhZGRyZXNzICIpOw0KICAgIHJldHVybiAoRVhJVF9G
QUlMVVJFKTsNCiAgfQ0KICBjbG9zZSAoc2QpOw0KDQogIC8vIENvcHkgc291cmNlIE1BQyBh
ZGRyZXNzLg0KICBtZW1jcHkgKHNyY19tYWMsIGlmci5pZnJfaHdhZGRyLnNhX2RhdGEsIDYg
KiBzaXplb2YgKHVpbnQ4X3QpKTsNCiAgLy8gU2V0IGRlc3RpbmF0aW9uIE1BQyBhZGRyZXNz
LCBzYW1lIGFzIHNyY19tYWMNCiAgbWVtY3B5IChkc3RfbWFjLCBzcmNfbWFjLCA2ICogc2l6
ZW9mICh1aW50OF90KSk7DQoNCiAgLy8gRmluZCBpbnRlcmZhY2UgaW5kZXggZnJvbSBpbnRl
cmZhY2UgbmFtZSBhbmQgc3RvcmUgaW5kZXggaW4NCiAgLy8gc3RydWN0IHNvY2thZGRyX2xs
IGRldmljZSwgd2hpY2ggd2lsbCBiZSB1c2VkIGFzIGFuIGFyZ3VtZW50IG9mIHNlbmR0bygp
Lg0KICBpZiAoKGRldmljZS5zbGxfaWZpbmRleCA9IGlmX25hbWV0b2luZGV4IChpbnRlcmZh
Y2UpKSA9PSAwKSB7DQogICAgcGVycm9yICgiaWZfbmFtZXRvaW5kZXgoKSBmYWlsZWQgdG8g
b2J0YWluIGludGVyZmFjZSBpbmRleCAiKTsNCiAgICBleGl0IChFWElUX0ZBSUxVUkUpOw0K
ICB9DQoNCiAgc3RyY3B5IChzcmNfaXAsICJmZTgwOjo1MjU0OjA6OTNkOmY0MTYiKTsNCiAg
c3RyY3B5ICh0YXJnZXQsICJmZjAwOjowMSIpOw0KDQogIC8vIEZpbGwgb3V0IGhpbnRzIGZv
ciBnZXRhZGRyaW5mbygpLg0KICBtZW1zZXQgKCZoaW50cywgMCwgc2l6ZW9mIChzdHJ1Y3Qg
YWRkcmluZm8pKTsNCiAgaGludHMuYWlfZmFtaWx5ID0gQUZfSU5FVDY7DQogIGhpbnRzLmFp
X3NvY2t0eXBlID0gU09DS19SQVc7DQogIGhpbnRzLmFpX2ZsYWdzID0gaGludHMuYWlfZmxh
Z3MgfCBBSV9DQU5PTk5BTUU7DQoNCiAgLy8gUmVzb2x2ZSB0YXJnZXQgdXNpbmcgZ2V0YWRk
cmluZm8oKS4NCiAgaWYgKChzdGF0dXMgPSBnZXRhZGRyaW5mbyAodGFyZ2V0LCBOVUxMLCAm
aGludHMsICZyZXMpKSAhPSAwKSB7DQogICAgZnByaW50ZiAoc3RkZXJyLCAiZ2V0YWRkcmlu
Zm8oKSBmYWlsZWQ6ICVzXG4iLCBnYWlfc3RyZXJyb3IgKHN0YXR1cykpOw0KICAgIGV4aXQg
KEVYSVRfRkFJTFVSRSk7DQogIH0NCiAgaXB2NiA9IChzdHJ1Y3Qgc29ja2FkZHJfaW42ICop
IHJlcy0+YWlfYWRkcjsNCiAgdG1wID0gJihpcHY2LT5zaW42X2FkZHIpOw0KICBpZiAoaW5l
dF9udG9wIChBRl9JTkVUNiwgdG1wLCBkc3RfaXAsIElORVQ2X0FERFJTVFJMRU4pID09IE5V
TEwpIHsNCiAgICBzdGF0dXMgPSBlcnJubzsNCiAgICBmcHJpbnRmIChzdGRlcnIsICJpbmV0
X250b3AoKSBmYWlsZWQuXG5FcnJvciBtZXNzYWdlOiAlcyIsIHN0cmVycm9yIChzdGF0dXMp
KTsNCiAgICBleGl0IChFWElUX0ZBSUxVUkUpOw0KICB9DQogIGZyZWVhZGRyaW5mbyAocmVz
KTsNCg0KICAvLyBGaWxsIG91dCBzb2NrYWRkcl9sbC4NCiAgZGV2aWNlLnNsbF9mYW1pbHkg
PSBBRl9QQUNLRVQ7DQogIG1lbWNweSAoZGV2aWNlLnNsbF9hZGRyLCBzcmNfbWFjLCA2ICog
c2l6ZW9mICh1aW50OF90KSk7DQogIGRldmljZS5zbGxfaGFsZW4gPSBodG9ucyAoNik7DQog
IGRldmljZS5zbGxfcHJvdG9jb2wgPSBodG9ucyAoRVRIX1BfSVBWNik7DQoNCiAgLy8gSVB2
NiBoZWFkZXINCiAgLy8gSVB2NiB2ZXJzaW9uICg0IGJpdHMpLCBUcmFmZmljIGNsYXNzICg4
IGJpdHMpLCBGbG93IGxhYmVsICgyMCBiaXRzKQ0KICBpcGhkci5pcDZfZmxvdyA9IGh0b25s
ICgoNiA8PCAyOCkgfCAoMCA8PCAyMCkgfCAwKTsNCg0KICAvLyBQYXlsb2FkIGxlbmd0aCAo
MTYgYml0cyk6IFRDUCBoZWFkZXINCiAgaXBoZHIuaXA2X3BsZW4gPSBodG9ucyAoVENQX0hE
UkxFTik7DQoNCiAgLy8gTmV4dCBoZWFkZXIgKDggYml0cyk6IDYgZm9yIFRDUA0KICBpcGhk
ci5pcDZfbnh0ID0gSVBQUk9UT19UQ1A7DQoNCiAgLy8gSG9wIGxpbWl0ICg4IGJpdHMpOiBk
ZWZhdWx0IHRvIG1heGltdW0gdmFsdWUNCiAgaXBoZHIuaXA2X2hvcHMgPSAyNTU7DQoNCiAg
Ly8gU291cmNlIElQdjYgYWRkcmVzcyAoMTI4IGJpdHMpDQogIGlmICgoc3RhdHVzID0gaW5l
dF9wdG9uIChBRl9JTkVUNiwgc3JjX2lwLCAmKGlwaGRyLmlwNl9zcmMpKSkgIT0gMSkgew0K
ICAgIGZwcmludGYgKHN0ZGVyciwgImluZXRfcHRvbigpIGZhaWxlZC5cbkVycm9yIG1lc3Nh
Z2U6ICVzIiwgc3RyZXJyb3IgKHN0YXR1cykpOw0KICAgIGV4aXQgKEVYSVRfRkFJTFVSRSk7
DQogIH0NCg0KICAvLyBEZXN0aW5hdGlvbiBJUHY2IGFkZHJlc3MgKDEyOCBiaXRzKQ0KICBp
ZiAoKHN0YXR1cyA9IGluZXRfcHRvbiAoQUZfSU5FVDYsIGRzdF9pcCwgJihpcGhkci5pcDZf
ZHN0KSkpICE9IDEpIHsNCiAgICBmcHJpbnRmIChzdGRlcnIsICJpbmV0X3B0b24oKSBmYWls
ZWQuXG5FcnJvciBtZXNzYWdlOiAlcyIsIHN0cmVycm9yIChzdGF0dXMpKTsNCiAgICBleGl0
IChFWElUX0ZBSUxVUkUpOw0KICB9DQoNCiAgLy8gVENQIGhlYWRlcg0KICAvLyBTb3VyY2Ug
cG9ydCBudW1iZXIgKDE2IGJpdHMpDQogIHRjcGhkci50aF9zcG9ydCA9IGh0b25zICg2MCk7
DQoNCiAgLy8gRGVzdGluYXRpb24gcG9ydCBudW1iZXIgKDE2IGJpdHMpDQogIHRjcGhkci50
aF9kcG9ydCA9IGh0b25zICg4MCk7DQoNCiAgLy8gU2VxdWVuY2UgbnVtYmVyICgzMiBiaXRz
KQ0KICB0Y3BoZHIudGhfc2VxID0gaHRvbmwgKDApOw0KDQogIC8vIEFja25vd2xlZGdlbWVu
dCBudW1iZXIgKDMyIGJpdHMpOiAwIGluIGZpcnN0IHBhY2tldCBvZiBTWU4vQUNLIHByb2Nl
c3MNCiAgdGNwaGRyLnRoX2FjayA9IGh0b25sICgwKTsNCg0KICAvLyBSZXNlcnZlZCAoNCBi
aXRzKTogc2hvdWxkIGJlIDANCiAgdGNwaGRyLnRoX3gyID0gMDsNCg0KICAvLyBEYXRhIG9m
ZnNldCAoNCBiaXRzKTogc2l6ZSBvZiBUQ1AgaGVhZGVyIGluIDMyLWJpdCB3b3Jkcw0KICB0
Y3BoZHIudGhfb2ZmID0gVENQX0hEUkxFTiAvIDQ7DQoNCiAgLy8gRmxhZ3MgKDggYml0cykN
Cg0KICAvLyBGSU4gZmxhZyAoMSBiaXQpDQogIHRjcF9mbGFnc1swXSA9IDA7DQoNCiAgLy8g
U1lOIGZsYWcgKDEgYml0KTogc2V0IHRvIDENCiAgdGNwX2ZsYWdzWzFdID0gMTsNCg0KICAv
LyBSU1QgZmxhZyAoMSBiaXQpDQogIHRjcF9mbGFnc1syXSA9IDA7DQoNCiAgLy8gUFNIIGZs
YWcgKDEgYml0KQ0KICB0Y3BfZmxhZ3NbM10gPSAwOw0KDQogIC8vIEFDSyBmbGFnICgxIGJp
dCkNCiAgdGNwX2ZsYWdzWzRdID0gMDsNCg0KICAvLyBVUkcgZmxhZyAoMSBiaXQpDQogIHRj
cF9mbGFnc1s1XSA9IDA7DQoNCiAgLy8gRUNFIGZsYWcgKDEgYml0KQ0KICB0Y3BfZmxhZ3Nb
Nl0gPSAwOw0KDQogIC8vIENXUiBmbGFnICgxIGJpdCkNCiAgdGNwX2ZsYWdzWzddID0gMDsN
Cg0KICB0Y3BoZHIudGhfZmxhZ3MgPSAwOw0KICBmb3IgKGk9MDsgaTw4OyBpKyspIHsNCiAg
ICB0Y3BoZHIudGhfZmxhZ3MgKz0gKHRjcF9mbGFnc1tpXSA8PCBpKTsNCiAgfQ0KDQogIC8v
IFdpbmRvdyBzaXplICgxNiBiaXRzKQ0KICB0Y3BoZHIudGhfd2luID0gaHRvbnMgKDY1NTM1
KTsNCg0KICAvLyBVcmdlbnQgcG9pbnRlciAoMTYgYml0cyk6IDAgKG9ubHkgdmFsaWQgaWYg
VVJHIGZsYWcgaXMgc2V0KQ0KICB0Y3BoZHIudGhfdXJwID0gaHRvbnMgKDApOw0KDQogIC8v
IFRDUCBjaGVja3N1bSAoMTYgYml0cykNCiAgdGNwaGRyLnRoX3N1bSA9IHRjcDZfY2hlY2tz
dW0gKGlwaGRyLCB0Y3BoZHIpOw0KDQogIC8vIEZpbGwgb3V0IGV0aGVybmV0IGZyYW1lIGhl
YWRlci4NCiAgLy8gRXRoZXJuZXQgZnJhbWUgbGVuZ3RoID0gZXRoZXJuZXQgaGVhZGVyIChN
QUMgKyBNQUMgKyBldGhlcm5ldCB0eXBlKSArIGV0aGVybmV0IGRhdGEgKElQIGhlYWRlciAr
IFRDUCBoZWFkZXIpDQogIGZyYW1lX2xlbmd0aCA9IDYgKyA2ICsgMiArIElQNl9IRFJMRU4g
KyBUQ1BfSERSTEVOOw0KDQogIC8vIERlc3RpbmF0aW9uIGFuZCBTb3VyY2UgTUFDIGFkZHJl
c3Nlcw0KICBtZW1jcHkgKGV0aGVyX2ZyYW1lLCBkc3RfbWFjLCA2ICogc2l6ZW9mICh1aW50
OF90KSk7DQogIG1lbWNweSAoZXRoZXJfZnJhbWUgKyA2LCBzcmNfbWFjLCA2ICogc2l6ZW9m
ICh1aW50OF90KSk7DQoNCiAgLy8gTmV4dCBpcyBldGhlcm5ldCB0eXBlIGNvZGUgKEVUSF9Q
X0lQVjYgZm9yIElQdjYpLg0KICAvLyBodHRwOi8vd3d3LmlhbmEub3JnL2Fzc2lnbm1lbnRz
L2V0aGVybmV0LW51bWJlcnMNCiAgZXRoZXJfZnJhbWVbMTJdID0gRVRIX1BfSVBWNiAvIDI1
NjsNCiAgZXRoZXJfZnJhbWVbMTNdID0gRVRIX1BfSVBWNiAlIDI1NjsNCg0KICAvLyBOZXh0
IGlzIGV0aGVybmV0IGZyYW1lIGRhdGEgKElQdjYgaGVhZGVyICsgVENQIGhlYWRlcikuDQog
IC8vIElQdjYgaGVhZGVyDQogIG1lbWNweSAoZXRoZXJfZnJhbWUgKyBFVEhfSERSTEVOLCAm
aXBoZHIsIElQNl9IRFJMRU4gKiBzaXplb2YgKHVpbnQ4X3QpKTsNCg0KICAvLyBUQ1AgaGVh
ZGVyDQogIG1lbWNweSAoZXRoZXJfZnJhbWUgKyBFVEhfSERSTEVOICsgSVA2X0hEUkxFTiwg
JnRjcGhkciwgVENQX0hEUkxFTiAqIHNpemVvZiAodWludDhfdCkpOw0KDQogIC8vIFN1Ym1p
dCByZXF1ZXN0IGZvciBhIHJhdyBzb2NrZXQgZGVzY3JpcHRvci4NCiAgaWYgKChzZCA9IHNv
Y2tldCAoUEZfUEFDS0VULCBTT0NLX1JBVywgaHRvbnMgKEVUSF9QX0FMTCkpKSA8IDApIHsN
CiAgICBwZXJyb3IgKCJzb2NrZXQoKSBmYWlsZWQgIik7DQogICAgZXhpdCAoRVhJVF9GQUlM
VVJFKTsNCiAgfQ0KDQogIC8vIFNlbmQgZXRoZXJuZXQgZnJhbWUgdG8gc29ja2V0Lg0KICBp
ZiAoKGJ5dGVzID0gc2VuZHRvIChzZCwgZXRoZXJfZnJhbWUsIGZyYW1lX2xlbmd0aCwgMCwg
KHN0cnVjdCBzb2NrYWRkciAqKSAmZGV2aWNlLCBzaXplb2YgKGRldmljZSkpKSA8PSAwKSB7
DQogICAgcGVycm9yICgic2VuZHRvKCkgZmFpbGVkIik7DQogICAgZXhpdCAoRVhJVF9GQUlM
VVJFKTsNCiAgfQ0KDQogIC8vIENsb3NlIHNvY2tldCBkZXNjcmlwdG9yLg0KICBjbG9zZSAo
c2QpOw0KDQogIC8vIEZyZWUgYWxsb2NhdGVkIG1lbW9yeS4NCiAgZnJlZSAoc3JjX21hYyk7
DQogIGZyZWUgKGRzdF9tYWMpOw0KICBmcmVlIChldGhlcl9mcmFtZSk7DQogIGZyZWUgKGlu
dGVyZmFjZSk7DQogIGZyZWUgKHRhcmdldCk7DQogIGZyZWUgKHNyY19pcCk7DQogIGZyZWUg
KGRzdF9pcCk7DQogIGZyZWUgKHRjcF9mbGFncyk7DQoNCiAgcmV0dXJuIChFWElUX1NVQ0NF
U1MpOw0KfQ0KDQovLyBDaGVja3N1bSBmdW5jdGlvbg0KdWludDE2X3QNCmNoZWNrc3VtICh1
aW50MTZfdCAqYWRkciwgaW50IGxlbikNCnsNCiAgaW50IG5sZWZ0ID0gbGVuOw0KICBpbnQg
c3VtID0gMDsNCiAgdWludDE2X3QgKncgPSBhZGRyOw0KICB1aW50MTZfdCBhbnN3ZXIgPSAw
Ow0KDQogIHdoaWxlIChubGVmdCA+IDEpIHsNCiAgICBzdW0gKz0gKncrKzsNCiAgICBubGVm
dCAtPSBzaXplb2YgKHVpbnQxNl90KTsNCiAgfQ0KDQogIGlmIChubGVmdCA9PSAxKSB7DQog
ICAgKih1aW50OF90ICopICgmYW5zd2VyKSA9ICoodWludDhfdCAqKSB3Ow0KICAgIHN1bSAr
PSBhbnN3ZXI7DQogIH0NCg0KICBzdW0gPSAoc3VtID4+IDE2KSArIChzdW0gJiAweEZGRkYp
Ow0KICBzdW0gKz0gKHN1bSA+PiAxNik7DQogIGFuc3dlciA9IH5zdW07DQogIHJldHVybiAo
YW5zd2VyKTsNCn0NCg0KLy8gQnVpbGQgSVB2NiBUQ1AgcHNldWRvLWhlYWRlciBhbmQgY2Fs
bCBjaGVja3N1bSBmdW5jdGlvbiAoU2VjdGlvbiA4LjEgb2YgUkZDIDI0NjApLg0KdWludDE2
X3QNCnRjcDZfY2hlY2tzdW0gKHN0cnVjdCBpcDZfaGRyIGlwaGRyLCBzdHJ1Y3QgdGNwaGRy
IHRjcGhkcikNCnsNCiAgdWludDMyX3QgbHZhbHVlOw0KICBjaGFyIGJ1ZltJUF9NQVhQQUNL
RVRdLCBjdmFsdWU7DQogIGNoYXIgKnB0cjsNCiAgaW50IGNoa3N1bWxlbiA9IDA7DQoNCiAg
cHRyID0gJmJ1ZlswXTsgIC8vIHB0ciBwb2ludHMgdG8gYmVnaW5uaW5nIG9mIGJ1ZmZlciBi
dWYNCg0KICAvLyBDb3B5IHNvdXJjZSBJUCBhZGRyZXNzIGludG8gYnVmICgxMjggYml0cykN
CiAgbWVtY3B5IChwdHIsICZpcGhkci5pcDZfc3JjLCBzaXplb2YgKGlwaGRyLmlwNl9zcmMp
KTsNCiAgcHRyICs9IHNpemVvZiAoaXBoZHIuaXA2X3NyYyk7DQogIGNoa3N1bWxlbiArPSBz
aXplb2YgKGlwaGRyLmlwNl9zcmMpOw0KDQogIC8vIENvcHkgZGVzdGluYXRpb24gSVAgYWRk
cmVzcyBpbnRvIGJ1ZiAoMTI4IGJpdHMpDQogIG1lbWNweSAocHRyLCAmaXBoZHIuaXA2X2Rz
dCwgc2l6ZW9mIChpcGhkci5pcDZfZHN0KSk7DQogIHB0ciArPSBzaXplb2YgKGlwaGRyLmlw
Nl9kc3QpOw0KICBjaGtzdW1sZW4gKz0gc2l6ZW9mIChpcGhkci5pcDZfZHN0KTsNCg0KICAv
LyBDb3B5IFRDUCBsZW5ndGggdG8gYnVmICgzMiBiaXRzKQ0KICBsdmFsdWUgPSBodG9ubCAo
c2l6ZW9mICh0Y3BoZHIpKTsNCiAgbWVtY3B5IChwdHIsICZsdmFsdWUsIHNpemVvZiAobHZh
bHVlKSk7DQogIHB0ciArPSBzaXplb2YgKGx2YWx1ZSk7DQogIGNoa3N1bWxlbiArPSBzaXpl
b2YgKGx2YWx1ZSk7DQoNCiAgLy8gQ29weSB6ZXJvIGZpZWxkIHRvIGJ1ZiAoMjQgYml0cykN
CiAgKnB0ciA9IDA7IHB0cisrOw0KICAqcHRyID0gMDsgcHRyKys7DQogICpwdHIgPSAwOyBw
dHIrKzsNCiAgY2hrc3VtbGVuICs9IDM7DQoNCiAgLy8gQ29weSBuZXh0IGhlYWRlciBmaWVs
ZCB0byBidWYgKDggYml0cykNCiAgbWVtY3B5IChwdHIsICZpcGhkci5pcDZfbnh0LCBzaXpl
b2YgKGlwaGRyLmlwNl9ueHQpKTsNCiAgcHRyICs9IHNpemVvZiAoaXBoZHIuaXA2X254dCk7
DQogIGNoa3N1bWxlbiArPSBzaXplb2YgKGlwaGRyLmlwNl9ueHQpOw0KDQogIC8vIENvcHkg
VENQIHNvdXJjZSBwb3J0IHRvIGJ1ZiAoMTYgYml0cykNCiAgbWVtY3B5IChwdHIsICZ0Y3Bo
ZHIudGhfc3BvcnQsIHNpemVvZiAodGNwaGRyLnRoX3Nwb3J0KSk7DQogIHB0ciArPSBzaXpl
b2YgKHRjcGhkci50aF9zcG9ydCk7DQogIGNoa3N1bWxlbiArPSBzaXplb2YgKHRjcGhkci50
aF9zcG9ydCk7DQoNCiAgLy8gQ29weSBUQ1AgZGVzdGluYXRpb24gcG9ydCB0byBidWYgKDE2
IGJpdHMpDQogIG1lbWNweSAocHRyLCAmdGNwaGRyLnRoX2Rwb3J0LCBzaXplb2YgKHRjcGhk
ci50aF9kcG9ydCkpOw0KICBwdHIgKz0gc2l6ZW9mICh0Y3BoZHIudGhfZHBvcnQpOw0KICBj
aGtzdW1sZW4gKz0gc2l6ZW9mICh0Y3BoZHIudGhfZHBvcnQpOw0KDQogIC8vIENvcHkgc2Vx
dWVuY2UgbnVtYmVyIHRvIGJ1ZiAoMzIgYml0cykNCiAgbWVtY3B5IChwdHIsICZ0Y3BoZHIu
dGhfc2VxLCBzaXplb2YgKHRjcGhkci50aF9zZXEpKTsNCiAgcHRyICs9IHNpemVvZiAodGNw
aGRyLnRoX3NlcSk7DQogIGNoa3N1bWxlbiArPSBzaXplb2YgKHRjcGhkci50aF9zZXEpOw0K
DQogIC8vIENvcHkgYWNrbm93bGVkZ2VtZW50IG51bWJlciB0byBidWYgKDMyIGJpdHMpDQog
IG1lbWNweSAocHRyLCAmdGNwaGRyLnRoX2Fjaywgc2l6ZW9mICh0Y3BoZHIudGhfYWNrKSk7
DQogIHB0ciArPSBzaXplb2YgKHRjcGhkci50aF9hY2spOw0KICBjaGtzdW1sZW4gKz0gc2l6
ZW9mICh0Y3BoZHIudGhfYWNrKTsNCg0KICAvLyBDb3B5IGRhdGEgb2Zmc2V0IHRvIGJ1ZiAo
NCBiaXRzKSBhbmQNCiAgLy8gY29weSByZXNlcnZlZCBiaXRzIHRvIGJ1ZiAoNCBiaXRzKQ0K
ICBjdmFsdWUgPSAodGNwaGRyLnRoX29mZiA8PCA0KSArIHRjcGhkci50aF94MjsNCiAgbWVt
Y3B5IChwdHIsICZjdmFsdWUsIHNpemVvZiAoY3ZhbHVlKSk7DQogIHB0ciArPSBzaXplb2Yg
KGN2YWx1ZSk7DQogIGNoa3N1bWxlbiArPSBzaXplb2YgKGN2YWx1ZSk7DQoNCiAgLy8gQ29w
eSBUQ1AgZmxhZ3MgdG8gYnVmICg4IGJpdHMpDQogIG1lbWNweSAocHRyLCAmdGNwaGRyLnRo
X2ZsYWdzLCBzaXplb2YgKHRjcGhkci50aF9mbGFncykpOw0KICBwdHIgKz0gc2l6ZW9mICh0
Y3BoZHIudGhfZmxhZ3MpOw0KICBjaGtzdW1sZW4gKz0gc2l6ZW9mICh0Y3BoZHIudGhfZmxh
Z3MpOw0KDQogIC8vIENvcHkgVENQIHdpbmRvdyBzaXplIHRvIGJ1ZiAoMTYgYml0cykNCiAg
bWVtY3B5IChwdHIsICZ0Y3BoZHIudGhfd2luLCBzaXplb2YgKHRjcGhkci50aF93aW4pKTsN
CiAgcHRyICs9IHNpemVvZiAodGNwaGRyLnRoX3dpbik7DQogIGNoa3N1bWxlbiArPSBzaXpl
b2YgKHRjcGhkci50aF93aW4pOw0KDQogIC8vIENvcHkgVENQIGNoZWNrc3VtIHRvIGJ1ZiAo
MTYgYml0cykNCiAgLy8gWmVybywgc2luY2Ugd2UgZG9uJ3Qga25vdyBpdCB5ZXQNCiAgKnB0
ciA9IDA7IHB0cisrOw0KICAqcHRyID0gMDsgcHRyKys7DQogIGNoa3N1bWxlbiArPSAyOw0K
DQogIC8vIENvcHkgdXJnZW50IHBvaW50ZXIgdG8gYnVmICgxNiBiaXRzKQ0KICBtZW1jcHkg
KHB0ciwgJnRjcGhkci50aF91cnAsIHNpemVvZiAodGNwaGRyLnRoX3VycCkpOw0KICBwdHIg
Kz0gc2l6ZW9mICh0Y3BoZHIudGhfdXJwKTsNCiAgY2hrc3VtbGVuICs9IHNpemVvZiAodGNw
aGRyLnRoX3VycCk7DQoNCiAgcmV0dXJuIGNoZWNrc3VtICgodWludDE2X3QgKikgYnVmLCBj
aGtzdW1sZW4pOw0KfQ0KDQovLyBBbGxvY2F0ZSBtZW1vcnkgZm9yIGFuIGFycmF5IG9mIGNo
YXJzLg0KY2hhciAqDQphbGxvY2F0ZV9zdHJtZW0gKGludCBsZW4pDQp7DQogIHZvaWQgKnRt
cDsNCg0KICBpZiAobGVuIDw9IDApIHsNCiAgICBmcHJpbnRmIChzdGRlcnIsICJFUlJPUjog
Q2Fubm90IGFsbG9jYXRlIG1lbW9yeSBiZWNhdXNlIGxlbiA9ICVpIGluIGFsbG9jYXRlX3N0
cm1lbSgpLlxuIiwgbGVuKTsNCiAgICBleGl0IChFWElUX0ZBSUxVUkUpOw0KICB9DQoNCiAg
dG1wID0gKGNoYXIgKikgbWFsbG9jIChsZW4gKiBzaXplb2YgKGNoYXIpKTsNCiAgaWYgKHRt
cCAhPSBOVUxMKSB7DQogICAgbWVtc2V0ICh0bXAsIDAsIGxlbiAqIHNpemVvZiAoY2hhcikp
Ow0KICAgIHJldHVybiAodG1wKTsNCiAgfSBlbHNlIHsNCiAgICBmcHJpbnRmIChzdGRlcnIs
ICJFUlJPUjogQ2Fubm90IGFsbG9jYXRlIG1lbW9yeSBmb3IgYXJyYXkgYWxsb2NhdGVfc3Ry
bWVtKCkuXG4iKTsNCiAgICBleGl0IChFWElUX0ZBSUxVUkUpOw0KICB9DQp9DQoNCi8vIEFs
bG9jYXRlIG1lbW9yeSBmb3IgYW4gYXJyYXkgb2YgdW5zaWduZWQgY2hhcnMuDQp1aW50OF90
ICoNCmFsbG9jYXRlX3VzdHJtZW0gKGludCBsZW4pDQp7DQogIHZvaWQgKnRtcDsNCg0KICBp
ZiAobGVuIDw9IDApIHsNCiAgICBmcHJpbnRmIChzdGRlcnIsICJFUlJPUjogQ2Fubm90IGFs
bG9jYXRlIG1lbW9yeSBiZWNhdXNlIGxlbiA9ICVpIGluIGFsbG9jYXRlX3VzdHJtZW0oKS5c
biIsIGxlbik7DQogICAgZXhpdCAoRVhJVF9GQUlMVVJFKTsNCiAgfQ0KDQogIHRtcCA9ICh1
aW50OF90ICopIG1hbGxvYyAobGVuICogc2l6ZW9mICh1aW50OF90KSk7DQogIGlmICh0bXAg
IT0gTlVMTCkgew0KICAgIG1lbXNldCAodG1wLCAwLCBsZW4gKiBzaXplb2YgKHVpbnQ4X3Qp
KTsNCiAgICByZXR1cm4gKHRtcCk7DQogIH0gZWxzZSB7DQogICAgZnByaW50ZiAoc3RkZXJy
LCAiRVJST1I6IENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkgZm9yIGFycmF5IGFsbG9jYXRlX3Vz
dHJtZW0oKS5cbiIpOw0KICAgIGV4aXQgKEVYSVRfRkFJTFVSRSk7DQogIH0NCn0NCg0KLy8g
QWxsb2NhdGUgbWVtb3J5IGZvciBhbiBhcnJheSBvZiBpbnRzLg0KaW50ICoNCmFsbG9jYXRl
X2ludG1lbSAoaW50IGxlbikNCnsNCiAgdm9pZCAqdG1wOw0KDQogIGlmIChsZW4gPD0gMCkg
ew0KICAgIGZwcmludGYgKHN0ZGVyciwgIkVSUk9SOiBDYW5ub3QgYWxsb2NhdGUgbWVtb3J5
IGJlY2F1c2UgbGVuID0gJWkgaW4gYWxsb2NhdGVfaW50bWVtKCkuXG4iLCBsZW4pOw0KICAg
IGV4aXQgKEVYSVRfRkFJTFVSRSk7DQogIH0NCg0KICB0bXAgPSAoaW50ICopIG1hbGxvYyAo
bGVuICogc2l6ZW9mIChpbnQpKTsNCiAgaWYgKHRtcCAhPSBOVUxMKSB7DQogICAgbWVtc2V0
ICh0bXAsIDAsIGxlbiAqIHNpemVvZiAoaW50KSk7DQogICAgcmV0dXJuICh0bXApOw0KICB9
IGVsc2Ugew0KICAgIGZwcmludGYgKHN0ZGVyciwgIkVSUk9SOiBDYW5ub3QgYWxsb2NhdGUg
bWVtb3J5IGZvciBhcnJheSBhbGxvY2F0ZV9pbnRtZW0oKS5cbiIpOw0KICAgIGV4aXQgKEVY
SVRfRkFJTFVSRSk7DQogIH0NCn0=
--------------00ADEC1C92B0C2B19DC468A7--

