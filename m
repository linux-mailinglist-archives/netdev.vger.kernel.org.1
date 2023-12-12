Return-Path: <netdev+bounces-56483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2280F116
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E296928180D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE675434;
	Tue, 12 Dec 2023 15:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 1064 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 07:31:02 PST
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE4E9
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:31:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SqMXn1JM8z1L9jw;
	Tue, 12 Dec 2023 23:12:09 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BB6A1A016F;
	Tue, 12 Dec 2023 23:13:16 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 23:13:15 +0800
Message-ID: <2c57d2a3-e0d2-4758-9e85-0d0ddb32a680@huawei.com>
Date: Tue, 12 Dec 2023 23:13:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] net: update the vlan filter info synchronously when
 modifying the features of netdev
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <jiri@resnulli.us>,
	<vladimir.oltean@nxp.com>, <andrew@lunn.ch>, <d-tatianin@yandex-team.ru>,
	<justin.chen@broadcom.com>, <rkannoth@marvell.com>, <idosch@nvidia.com>,
	<jdamato@fastly.com>, <netdev@vger.kernel.org>
References: <20231209092921.1454609-1-liujian56@huawei.com>
 <6772e7d91e5ecfe12922eb6ed9a5b4c8773a5adb.camel@redhat.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <6772e7d91e5ecfe12922eb6ed9a5b4c8773a5adb.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)



在 2023/12/12 19:58, Paolo Abeni 写道:
> On Sat, 2023-12-09 at 17:29 +0800, Liu Jian wrote:
>> I got the bleow warning trace:
> 
> minor nit:  ^^^^^ below
>>
>> WARNING: CPU: 4 PID: 4056 at net/core/dev.c:11066 unregister_netdevice_many_notify
>> CPU: 4 PID: 4056 Comm: ip Not tainted 6.7.0-rc4+ #15
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>> RIP: 0010:unregister_netdevice_many_notify+0x9a4/0x9b0
>> Call Trace:
>>   rtnl_dellink
>>   rtnetlink_rcv_msg
>>   netlink_rcv_skb
>>   netlink_unicast
>>   netlink_sendmsg
>>   __sock_sendmsg
>>   ____sys_sendmsg
>>   ___sys_sendmsg
>>   __sys_sendmsg
>>   do_syscall_64
>>   entry_SYSCALL_64_after_hwframe
>>
>> It can be repoduced via:
>>
>>      ip netns add ns1
>>      ip netns exec ns1 ip link add bond0 type bond mode 0
>>      ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
>>      ip netns exec ns1 ip link set bond_slave_1 master bond0
>> [1] ip netns exec ns1 ethtool -K bond0 rx-vlan-filter off
>> [2] ip netns exec ns1 ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
>> [3] ip netns exec ns1 ip link add link bond0 name bond0.0 type vlan id 0
>> [4] ip netns exec ns1 ip link set bond_slave_1 nomaster
>> [5] ip netns exec ns1 ip link del veth2
>>      ip netns del ns1
>>
>> This is all caused by command [1] turning off the rx-vlan-filter function
>> of bond0. The reason is the same as commit 01f4fd270870 ("bonding: Fix
>> incorrect deletion of ETH_P_8021AD protocol vid from slaves"). Commands
>> [2] [3] add the same vid to slave and master respectively, causing
>> command [4] to empty slave->vlan_info. The following command [5] triggers
>> this problem.
>>
>> To fix the problem, we could update the vlan filter information
>> synchronously when modifying the features of netdev.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> it looks like the above reproducer triggers only after 01f4fd270870
> ("bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from
> slaves")???
It should have nothing to do with this commit.
This problem still exists after revert the commit.
> 
> Also, why targeting net-next? this looks like a 'net' patch
Yes, it should be 'net'. Sorry for the typo.
> 
>> Signed-off-by: Liu Jian <liujian56@huawei.com>
>> ---
>>   net/8021q/vlan_core.c  | 21 ++++++++++++++++++++-
>>   net/ethtool/features.c | 19 ++++++++++++++++++-
>>   net/ethtool/ioctl.c    | 18 +++++++++++++++++-
>>   3 files changed, 55 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
>> index 0beb44f2fe1f..e94b509386bb 100644
>> --- a/net/8021q/vlan_core.c
>> +++ b/net/8021q/vlan_core.c
>> @@ -407,6 +407,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
>>   		return 0;
>>   
>>   	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
>> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
>> +		    vid_info->proto == htons(ETH_P_8021Q))
>> +			continue;
>> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
>> +		    vid_info->proto == htons(ETH_P_8021AD))
>> +			continue;
>>   		err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
>>   		if (err)
>>   			goto unwind;
>> @@ -417,6 +423,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
>>   	list_for_each_entry_continue_reverse(vid_info,
>>   					     &vlan_info->vid_list,
>>   					     list) {
>> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
>> +		    vid_info->proto == htons(ETH_P_8021Q))
>> +			continue;
>> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
>> +		    vid_info->proto == htons(ETH_P_8021AD))
>> +			continue;
>>   		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
>>   	}
>>   
>> @@ -436,8 +448,15 @@ void vlan_vids_del_by_dev(struct net_device *dev,
>>   	if (!vlan_info)
>>   		return;
>>   
>> -	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
>> +	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
>> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
>> +		    vid_info->proto == htons(ETH_P_8021Q))
>> +			continue;
>> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
>> +		    vid_info->proto == htons(ETH_P_8021AD))
>> +			continue;
>>   		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
>> +	}
>>   }
>>   EXPORT_SYMBOL(vlan_vids_del_by_dev);
>>   
>> diff --git a/net/ethtool/features.c b/net/ethtool/features.c
>> index a79af8c25a07..dee6d17c5b50 100644
>> --- a/net/ethtool/features.c
>> +++ b/net/ethtool/features.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   
>> +#include <linux/if_vlan.h>
>>   #include "netlink.h"
>>   #include "common.h"
>>   #include "bitset.h"
>> @@ -278,8 +279,24 @@ int ethnl_set_features(struct sk_buff *skb, struct genl_info *info)
>>   					  wanted_diff_mask, new_active,
>>   					  active_diff_mask, compact);
>>   	}
>> -	if (mod)
>> +	if (mod) {
>> +		bitmap_xor(active_diff_mask, old_active, new_active,
>> +			   NETDEV_FEATURE_COUNT);
>> +		if (test_bit(NETIF_F_HW_VLAN_CTAG_FILTER_BIT, active_diff_mask)) {
>> +			if (test_bit(NETIF_F_HW_VLAN_CTAG_FILTER_BIT, new_active))
>> +				vlan_get_rx_ctag_filter_info(dev);
>> +			else
>> +				vlan_drop_rx_ctag_filter_info(dev);
>> +		}
>> +		if (test_bit(NETIF_F_HW_VLAN_STAG_FILTER_BIT, active_diff_mask)) {
>> +			if (test_bit(NETIF_F_HW_VLAN_STAG_FILTER_BIT, new_active))
>> +				vlan_get_rx_stag_filter_info(dev);
>> +			else
>> +				vlan_drop_rx_stag_filter_info(dev);
>> +		}
> 
> __netdev_update_features() invoked a little bit above does the same
> thing, why it's not enough?!?
I re-learned this code, and it was really superfluous.
And I retest it , __netdev_update_features() was enough.

So the repair code should be as follows?

diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 0beb44f2fe1f..e94b509386bb 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -407,6 +407,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
                 return 0;

         list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+               if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+                   vid_info->proto == htons(ETH_P_8021Q))
+                       continue;
+               if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
+                   vid_info->proto == htons(ETH_P_8021AD))
+                       continue;
                 err = vlan_vid_add(dev, vid_info->proto, vid_info->vid);
                 if (err)
                         goto unwind;
@@ -417,6 +423,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
         list_for_each_entry_continue_reverse(vid_info,
                                              &vlan_info->vid_list,
                                              list) {
+               if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+                   vid_info->proto == htons(ETH_P_8021Q))
+                       continue;
+               if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
+                   vid_info->proto == htons(ETH_P_8021AD))
+                       continue;
                 vlan_vid_del(dev, vid_info->proto, vid_info->vid);
         }

@@ -436,8 +448,15 @@ void vlan_vids_del_by_dev(struct net_device *dev,
         if (!vlan_info)
                 return;

-       list_for_each_entry(vid_info, &vlan_info->vid_list, list)
+       list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
+               if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+                   vid_info->proto == htons(ETH_P_8021Q))
+                       continue;
+               if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
+                   vid_info->proto == htons(ETH_P_8021AD))
+                       continue;
                 vlan_vid_del(dev, vid_info->proto, vid_info->vid);
+       }
  }
  EXPORT_SYMBOL(vlan_vids_del_by_dev);

If there are no comments, I will resend the v2 version, thank you.
> 
>> +
>>   		netdev_features_change(dev);
>> +	}
>>   
>>   out_rtnl:
>>   	rtnl_unlock();
>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>> index 0b0ce4f81c01..df7f65ca10b2 100644
>> --- a/net/ethtool/ioctl.c
>> +++ b/net/ethtool/ioctl.c
>> @@ -3055,8 +3055,24 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
>>   	if (dev->ethtool_ops->complete)
>>   		dev->ethtool_ops->complete(dev);
>>   
>> -	if (old_features != dev->features)
>> +	if (old_features != dev->features) {
>> +		netdev_features_t diff = old_features ^ dev->features;
>> +
>> +		if (diff & NETIF_F_HW_VLAN_CTAG_FILTER) {
>> +			if (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
>> +				vlan_get_rx_ctag_filter_info(dev);
>> +			else
>> +				vlan_drop_rx_ctag_filter_info(dev);
>> +		}
>> +		if (diff & NETIF_F_HW_VLAN_STAG_FILTER) {
>> +			if (dev->features & NETIF_F_HW_VLAN_STAG_FILTER)
>> +				vlan_get_rx_stag_filter_info(dev);
>> +			else
>> +				vlan_drop_rx_stag_filter_info(dev);
>> +		}
>> +
> 
> The same here, via ethtool_set_features()
> 
> 
> Cheers,
> 
> Paolo
> 

