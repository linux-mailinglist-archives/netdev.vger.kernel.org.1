Return-Path: <netdev+bounces-177896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79606A72A32
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 07:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D073B4346
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257262BB15;
	Thu, 27 Mar 2025 06:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D9AD4B;
	Thu, 27 Mar 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057218; cv=none; b=SFy0Dge6RNIpsdzzEK+rA94AZhwV9MAZ6BvhH8P3HeTSsTzCQYk4e6oh92BT79vpPklkSM/9OSkViXlsoigXQ3XFCaiONuz5dGpkub50EaCiywybfbdXD77CNj0L9qUmvBFOJ+MwN6Bza4gY6rWuLK9zR0dA4/9uStQBPlnRzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057218; c=relaxed/simple;
	bh=g7SVzWdeF5I+zO7qGTwFxWLgrnT/uKUyit9EFMi4pPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BgpA5HBn6o0VGE4A1m6v+kOSe0UyngjjK3PFbCJ23pPkfd2pK0BQlokOpgEHalBB85iPDUVxo10sG8MVKMB9kxNH4slxqAmSzTe6pl+K9hogTHdx62KG68oyJkpOK+HmJJD2xxbOLG8c3dwprnaZijooSAIifazIiRocGSwLQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZNYkQ6t50z13LQt;
	Thu, 27 Mar 2025 14:33:02 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C85181800E4;
	Thu, 27 Mar 2025 14:33:26 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 14:33:25 +0800
Message-ID: <df2d0ac0-c80e-4511-9303-3ee773c73a22@huawei.com>
Date: Thu, 27 Mar 2025 14:33:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed
 needed_headroom
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@amazon.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250327015827.2729554-1-wangliang74@huawei.com>
 <CANn89iJn5gARyEPHeYxZxERpERdNKMngMcP1BbKrW9ebxB-tRw@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CANn89iJn5gARyEPHeYxZxERpERdNKMngMcP1BbKrW9ebxB-tRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/27 12:32, Eric Dumazet 写道:
> On Thu, Mar 27, 2025 at 2:48 AM Wang Liang <wangliang74@huawei.com> wrote:
>> When create ipip6 tunnel, if tunnel->parms.link is assigned to the previous
>> created tunnel device, the dev->needed_headroom will increase based on the
>> previous one.
>>
>> If the number of tunnel device is sufficient, the needed_headroom can be
>> overflowed. The overflow happens like this:
> How many stacked devices would be needed to reach this point ?


In the ideal situation, maybe 3277 (65536 / sizeof(struct iphdr)) sit
devices is enough.

This issue can be easily reproduced by the C repro from
https://syzkaller.appspot.com/text?tag=ReproC&x=14fc39a4880000

It is the 2022/10/11 23:38 crash issue in
https://syzkaller.appspot.com/bug?extid=4c63f36709a642f801c5

>
> I thought we had a limit, to make sure we do not overflow the kernel stack ?


The commit 5ae1e9922bbd ("net: ip_tunnel: prevent perpetual headroom 
growth")
add a needed_headroom limit in ip_tunnel_adj_headroom() before send skb. It
not work in this issue, because the needed_headroom is already overflowed
when create device, and the skb allocated in __ip_append_data() is too 
small.

>>    ipip6_newlink
>>      ipip6_tunnel_create
>>        register_netdevice
>>          ipip6_tunnel_init
>>            ipip6_tunnel_bind_dev
>>              t_hlen = tunnel->hlen + sizeof(struct iphdr); // 40
>>              hlen = tdev->hard_header_len + tdev->needed_headroom; // 65496
>>              dev->needed_headroom = t_hlen + hlen; // 65536 -> 0
>>
>> The value of LL_RESERVED_SPACE(rt->dst.dev) may be HH_DATA_MOD, that leads
>> to a small skb allocated in __ip_append_data(), which triggers a
>> skb_under_panic:
>>
>>    ------------[ cut here ]------------
>>    kernel BUG at net/core/skbuff.c:209!
>>    Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>>    CPU: 0 UID: 0 PID: 24133 Comm: test Tainted: G W 6.14.0-rc7-00067-g76b6905c11fd-dirty #1
>>    Tainted: [W]=WARN
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>>    RIP: 0010:skb_panic+0x156/0x1d0
>>    Call Trace:
>>     <TASK>
>>     skb_push+0xc8/0xe0
>>     fou_build_udp+0x31/0x3a0
>>     gue_build_header+0xf7/0x150
>>     ip_tunnel_xmit+0x684/0x3660
>>     sit_tunnel_xmit__.isra.0+0xeb/0x150
>>     sit_tunnel_xmit+0x2e3/0x2930
>>     dev_hard_start_xmit+0x1a6/0x7b0
>>     __dev_queue_xmit+0x2fa9/0x4120
>>     neigh_connected_output+0x39e/0x590
>>     ip_finish_output2+0x7bb/0x1f00
>>     __ip_finish_output+0x442/0x940
>>     ip_finish_output+0x31/0x380
>>     ip_mc_output+0x1c4/0x6a0
>>     ip_send_skb+0x339/0x570
>>     udp_send_skb+0x905/0x1540
>>     udp_sendmsg+0x17c8/0x28f0
>>     udpv6_sendmsg+0x17f1/0x2c30
>>     inet6_sendmsg+0x105/0x140
>>     ____sys_sendmsg+0x801/0xc70
>>     ___sys_sendmsg+0x110/0x1b0
>>     __sys_sendmmsg+0x1f2/0x410
>>     __x64_sys_sendmmsg+0x99/0x100
>>     do_syscall_64+0x6e/0x1c0
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    ---[ end trace 0000000000000000 ]---
> Can you provide symbols ?
>
> scripts/decode_stacktrace.sh is your friend.


You can get the report in
https://syzkaller.appspot.com/text?tag=CrashReport&x=106b6b34880000

>> Fix this by add check for needed_headroom in ipip6_tunnel_bind_dev().
>>
>> Reported-by: syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=4c63f36709a642f801c5
>> Fixes: c88f8d5cd95f ("sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   net/ipv6/sit.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
>> index 39bd8951bfca..1662b735c5e3 100644
>> --- a/net/ipv6/sit.c
>> +++ b/net/ipv6/sit.c
>> @@ -1095,7 +1095,7 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
>>
>>   }
>>
>> -static void ipip6_tunnel_bind_dev(struct net_device *dev)
>> +static int ipip6_tunnel_bind_dev(struct net_device *dev)
>>   {
>>          struct ip_tunnel *tunnel = netdev_priv(dev);
>>          int t_hlen = tunnel->hlen + sizeof(struct iphdr);
>> @@ -1134,7 +1134,12 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
>>                  WRITE_ONCE(dev->mtu, mtu);
>>                  hlen = tdev->hard_header_len + tdev->needed_headroom;
>>          }
>> +
>> +       if (t_hlen + hlen > U16_MAX)
>> +               return -EOVERFLOW;
>> +
>>          dev->needed_headroom = t_hlen + hlen;
>> +       return 0;
>>   }
>>
>>   static void ipip6_tunnel_update(struct ip_tunnel *t,
>> @@ -1452,7 +1457,9 @@ static int ipip6_tunnel_init(struct net_device *dev)
>>          tunnel->net = dev_net(dev);
>>          strcpy(tunnel->parms.name, dev->name);
>>
>> -       ipip6_tunnel_bind_dev(dev);
>> +       err = ipip6_tunnel_bind_dev(dev);
>> +       if (err)
>> +               return err;
>>
>>          err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
>>          if (err)
>> --
>> 2.34.1
>>

