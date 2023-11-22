Return-Path: <netdev+bounces-49891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C87F3BEA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 03:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D394282A7C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF22BAF4;
	Wed, 22 Nov 2023 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D7195
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 18:43:46 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SZlsq3FfnzWhcT;
	Wed, 22 Nov 2023 10:43:11 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 10:43:44 +0800
Message-ID: <a7bad923-34a6-f08d-4dbf-974a770fc5fd@huawei.com>
Date: Wed, 22 Nov 2023 10:43:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] ipv4: igmp: fix refcnt uaf issue when receiving igmp
 query packet
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20231121020558.240321-1-shaozhengchao@huawei.com>
 <CANn89i+zX5-xdXo0nezZiXS2+JXvcr-nsmaCmc8gNzuB5Xg5hQ@mail.gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CANn89i+zX5-xdXo0nezZiXS2+JXvcr-nsmaCmc8gNzuB5Xg5hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/22 1:37, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 2:53 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>>
>> When I perform the following test operations:
>> 1.ip link add br0 type bridge
>> 2.brctl addif br0 eth0
>> 3.ip addr add 239.0.0.1/32 dev eth0
>> 4.ip addr add 239.0.0.1/32 dev br0
>> 5.ip addr add 224.0.0.1/32 dev br0
>> 6.while ((1))
>>      do
>>          ifconfig br0 up
>>          ifconfig br0 down
>>      done
>> 7.send IGMPv2 query packets to port eth0 continuously. For example,
>> ./mausezahn ethX -c 0 "01 00 5e 00 00 01 00 72 19 88 aa 02 08 00 45 00 00
>> 1c 00 01 00 00 01 02 0e 7f c0 a8 0a b7 e0 00 00 01 11 64 ee 9b 00 00 00 00"
>>
>> The preceding tests may trigger the refcnt uaf isuue of the mc list. The
>> stack is as follows:
>>          refcount_t: addition on 0; use-after-free.
>>          WARNING: CPU: 21 PID: 144 at lib/refcount.c:25 refcount_warn_saturate+0x78/0x110
>>          CPU: 21 PID: 144 Comm: ksoftirqd/21 Kdump: loaded Not tainted 6.7.0-rc1-next-20231117-dirty #57
>>          RIP: 0010:refcount_warn_saturate+0x78/0x110
>>          Call Trace:
>>          <TASK>
>>          ? __warn+0x83/0x130
>>          ? refcount_warn_saturate+0x78/0x110
>>          ? __report_bug+0xea/0x100
>>          ? report_bug+0x24/0x70
>>          ? handle_bug+0x3c/0x70
>>          ? exc_invalid_op+0x18/0x70
>>          igmp_heard_query+0x221/0x690
>>          igmp_rcv+0xea/0x2f0
>>          ip_protocol_deliver_rcu+0x156/0x160
>>          ip_local_deliver_finish+0x77/0xa0
>>          __netif_receive_skb_one_core+0x8b/0xa0
>>          netif_receive_skb_internal+0x80/0xd0
>>          netif_receive_skb+0x18/0xc0
>>          br_handle_frame_finish+0x340/0x5c0 [bridge]
>>          nf_hook_bridge_pre+0x117/0x130 [bridge]
>>          __netif_receive_skb_core+0x241/0x1090
>>          __netif_receive_skb_list_core+0x13f/0x2e0
>>          __netif_receive_skb_list+0xfc/0x190
>>          netif_receive_skb_list_internal+0x102/0x1e0
>>          napi_gro_receive+0xd7/0x220
>>          e1000_clean_rx_irq+0x1d4/0x4f0 [e1000]
>>          e1000_clean+0x5e/0xe0 [e1000]
>>          __napi_poll+0x2c/0x1b0
>>          net_rx_action+0x2cb/0x3a0
>>          __do_softirq+0xcd/0x2a7
>>          run_ksoftirqd+0x22/0x30
>>          smpboot_thread_fn+0xdb/0x1d0
>>          kthread+0xe2/0x110
>>          ret_from_fork+0x34/0x50
>>          ret_from_fork_asm+0x1a/0x30
>>          </TASK>
> 
> 
> Please include symbols in stack traces, otherwise they are not precise enough.
> 
> scripts/decode_stacktrace.sh is your friend.
> 
> git grep -n scripts/decode_stacktrace.sh -- Documentation/admin-guide
> 
That's very usefull for me, Thank you. I will use it.

When locating the issue, I print the reference counting call stack of
the mc list when the issue occurs, like dev_tracker. As shown in the
following figure:
  node = ffff899f0113eb40
  stack count is 1, op : hold
[<0000000083ff3eef>] igmp_start_timer+0x4e/0xa0
[<00000000d52900df>] igmp_mod_timer+0x99/0xa8
[<0000000007b0df49>] igmp_heard_query.cold+0x3c/0x46
[<00000000a8401267>] igmp_rcv+0x142/0x2b0
[<00000000004cd82b>] ip_protocol_deliver_rcu+0x188/0x1c0
[<000000007133c934>] ip_local_deliver_finish+0x44/0x60
[<000000006dbfe577>] __netif_receive_skb_one_core+0x8b/0xa0
[<00000000c462a041>] netif_receive_skb_internal+0x40/0xd0
[<00000000963a8181>] netif_receive_skb+0x17/0x90
[<000000006b194425>] br_handle_frame_finish+0x17e/0x450 [bridge]
[<00000000a2ed8c7a>] nf_hook_bridge_pre+0x111/0x130 [bridge]
[<00000000154b9e87>] __netif_receive_skb_core+0x1a6/0xf20
[<000000001278b781>] __netif_receive_skb_list_core+0x13f/0x2e0
[<000000002d543b87>] __netif_receive_skb_list+0xfd/0x190
[<00000000de5ceec5>] netif_receive_skb_list_internal+0xfc/0x1e0
[<00000000a02df917>] gro_normal_one+0x77/0xa0
stack count is 1, op : put
[<000000005042a35a>] ip_ma_put+0x16/0xb0
[<0000000085f34370>] br_ip4_multicast_leave_snoopers.isra.0+0x47/0xa0 
[bridge]
[<00000000870fe473>] br_multicast_leave_snoopers+0x26/0x70 [bridge]
[<00000000043d0a0c>] br_dev_stop+0x4c/0x50 [bridge]
[<000000004c2d80b1>] __dev_close_many+0x99/0x110
[<00000000cdba8c2a>] __dev_change_flags+0x10d/0x250
[<000000004ee64457>] dev_change_flags+0x21/0x60
[<000000007aa8f47d>] devinet_ioctl+0x5c5/0x710
[<0000000060b50685>] inet_ioctl+0x190/0x1d0
[<00000000a89e60f7>] sock_do_ioctl+0x38/0x140
[<00000000b9071265>] sock_ioctl+0x195/0x370
[<00000000c24ede15>] __se_sys_ioctl+0x85/0xc0
[<00000000cb9d6bde>] do_syscall_64+0x33/0x40
[<00000000b8341b80>] entry_SYSCALL_64_after_hwframe+0x62/0xc7
stack count is 1, op : _put
[<00000000f49c2712>] igmp_stop_timer+0x4f/0x80
[<0000000094bd7946>] __igmp_group_dropped+0x79/0x1b0
[<000000003f7c8697>] __ip_mc_dec_group+0xc9/0xf0
  [<0000000085f34370>] br_ip4_multicast_leave_snoopers.isra.0+0x47/0xa0 
[bridge]
[<00000000870fe473>] br_multicast_leave_snoopers+0x26/0x70 [bridge]
[<00000000043d0a0c>] br_dev_stop+0x4c/0x50 [bridge]
[<000000004c2d80b1>] __dev_close_many+0x99/0x110
[<00000000cdba8c2a>] __dev_change_flags+0x10d/0x250
[<000000004ee64457>] dev_change_flags+0x21/0x60
[<000000007aa8f47d>] devinet_ioctl+0x5c5/0x710
[<0000000060b50685>] inet_ioctl+0x190/0x1d0
[<00000000a89e60f7>] sock_do_ioctl+0x38/0x140
[<00000000b9071265>] sock_ioctl+0x195/0x370
[<00000000c24ede15>] __se_sys_ioctl+0x85/0xc0
[<00000000cb9d6bde>] do_syscall_64+0x33/0x40
[<00000000b8341b80>] entry_SYSCALL_64_after_hwframe+0x62/0xc7
stack count is 1, op : hold
[<0000000083ff3eef>] igmp_start_timer+0x4e/0xa0
[<0000000062a4d9aa>] igmp_group_added+0x17b/0x1e0
[<000000004d79d41c>] ____ip_mc_inc_group+0x188/0x260
[<00000000ec98c0c0>] br_ip4_multicast_join_snoopers.isra.0+0x47/0x90 
[bridge]
[<0000000011f715b6>] br_multicast_join_snoopers+0x26/0x70 [bridge]
[<0000000062443b20>] br_dev_open+0x51/0x60 [bridge]
[<000000005333d1a7>] __dev_open+0xee/0x1a0
[<000000007024c19b>] __dev_change_flags+0x1de/0x250
[<000000004ee64457>] dev_change_flags+0x21/0x60
[<000000007aa8f47d>] devinet_ioctl+0x5c5/0x710
[<0000000060b50685>] inet_ioctl+0x190/0x1d0
[<00000000a89e60f7>] sock_do_ioctl+0x38/0x140
[<00000000b9071265>] sock_ioctl+0x195/0x370
[<00000000c24ede15>] __se_sys_ioctl+0x85/0xc0
[<00000000cb9d6bde>] do_syscall_64+0x33/0x40
[<00000000b8341b80>] entry_SYSCALL_64_after_hwframe+0x62/0xc7

Therefore, the process analysis of the issue is accurate.
>>
>> The root causes are as follows:
>> Thread A                                        Thread B
>> ...                                             netif_receive_skb
>> br_dev_stop                                     ...
>>      br_multicast_leave_snoopers                 ...
>>          __ip_mc_dec_group                       ...
>>              __igmp_group_dropped                igmp_rcv
>>                  igmp_stop_timer                     igmp_heard_query         //ref = 1
>>                  ip_ma_put                               igmp_mod_timer
>>                      refcount_dec_and_test                   igmp_start_timer //ref = 0
>>                          ...                                     refcount_inc //ref increases from 0
>> When the device receives an IGMPv2 Query message, it starts the timer
>> immediately, regardless of whether the device is running. If the device is
>> down and has left the multicast group, it will cause the mc list refcount
>> uaf issue.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   net/ipv4/igmp.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
>> index 76c3ea75b8dd..f217581904d6 100644
>> --- a/net/ipv4/igmp.c
>> +++ b/net/ipv4/igmp.c
>> @@ -1044,6 +1044,8 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>>          for_each_pmc_rcu(in_dev, im) {
>>                  int changed;
>>
>> +               if (!netif_running(im->interface->dev))
>> +                       continue;
> 
> This seems racy to me.
> 
> I guess igmp_start_timer() should use refcount_inc_not_zero() instead.
> 
I think it could solves the issue.

ThreadA			Thread B
			igmp_heard_query
__ip_mc_dec_group       ...
   __igmp_group_dropped  ...
     igmp_stop_timer     ...//r = 1
     ...                   rcu_read_lock
     ...                   igmp_mod_timer
     ...                     igmp_start_timer  //if timer is started, r=2
			
     ...                   rcu_read_unlock
   ip_ma_put //r=1
			
		     Thread C
		     igmp_timer_expire //timer function will be called
		       ip_ma_put //r=0,free im

Thanks

Zhengchao Shao
>>                  if (group && group != im->multiaddr)
>>                          continue;
>>                  if (im->multiaddr == IGMP_ALL_HOSTS)
>> --
>> 2.34.1
>>
> 

