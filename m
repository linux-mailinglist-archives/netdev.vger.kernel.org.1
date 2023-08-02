Return-Path: <netdev+bounces-23595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D093C76CA4F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE63E1C21214
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64263C0;
	Wed,  2 Aug 2023 10:04:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A563AB
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:04:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D21212A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:04:21 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RG6td384zztRmS;
	Wed,  2 Aug 2023 18:00:57 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:04:18 +0800
Subject: Re: [PATCH net] vlan: Fix to delete vid only when by_dev has hw
 filter capable in vlan_vids_del_by_dev()
To: Ido Schimmel <idosch@idosch.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bigeasy@linutronix.de>,
	<wsa+renesas@sang-engineering.com>, <kaber@trash.net>,
	<netdev@vger.kernel.org>
References: <20230801095943.3650567-1-william.xuanziyang@huawei.com>
 <ZMkRvQFwMdjmcCh0@shredder>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <19e0698c-fe26-ed13-d39e-da5ba20bc84d@huawei.com>
Date: Wed, 2 Aug 2023 18:04:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZMkRvQFwMdjmcCh0@shredder>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Tue, Aug 01, 2023 at 05:59:43PM +0800, Ziyang Xuan wrote:
>> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
>> index 0beb44f2fe1f..79cf4f033b66 100644
>> --- a/net/8021q/vlan_core.c
>> +++ b/net/8021q/vlan_core.c
>> @@ -436,8 +436,11 @@ void vlan_vids_del_by_dev(struct net_device *dev,
>>  	if (!vlan_info)
>>  		return;
>>  
>> -	list_for_each_entry(vid_info, &vlan_info->vid_list, list)
>> +	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
>> +		if (!vlan_hw_filter_capable(by_dev, vid_info->proto))
>> +			continue;
>>  		vlan_vid_del(dev, vid_info->proto, vid_info->vid);
> 
> vlan_vids_add_by_dev() does not have this check which means that memory
> will leak [1] if the device is enslaved after the bond already has a
> VLAN upper.
> 
> I believe the correct solution is to explicitly set the STAG-related
> features [3] in the bond driver in a similar fashion to how it's done
> for the CTAG features. That way the bond driver will always propagate
> the VLAN info to its slaves.
> 
Thank you for your detailed analysis and valuable suggestions.
I will fix my patch according to your suggestions.

> Please check the team driver as well. I think it's suffering from the
> same problem. If so, please fix it in a separate patch.
> 
Yes, I will test, and fix it if there is the same bug.

Thank you.
William Xuan

> [1]
> unreferenced object 0xffff888103efbd00 (size 256):
>   comm "ip", pid 351, jiffies 4294763177 (age 19.697s)
>   hex dump (first 32 bytes):                                                          
>     00 10 7a 11 81 88 ff ff 00 00 00 00 00 00 00 00  ..z.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:                                                                          
>     [<ffffffff81a88c0a>] kmalloc_trace+0x2a/0xe0                     
>     [<ffffffff840f349c>] vlan_vid_add+0x30c/0x790
>     [<ffffffff840f4a68>] vlan_vids_add_by_dev+0x148/0x390
>     [<ffffffff82eea5e8>] bond_enslave+0xaf8/0x5d50
>     [<ffffffff837fbfd1>] do_set_master+0x1c1/0x220       
>     [<ffffffff8380711c>] do_setlink+0xa0c/0x3fa0  
>     [<ffffffff8381ee09>] __rtnl_newlink+0xc09/0x18c0
>     [<ffffffff8381fb2c>] rtnl_newlink+0x6c/0xa0 
>     [<ffffffff8381d4ee>] rtnetlink_rcv_msg+0x43e/0xe00
>     [<ffffffff83a2c920>] netlink_rcv_skb+0x170/0x440
>     [<ffffffff83a2a2cf>] netlink_unicast+0x53f/0x810  
>     [<ffffffff83a2af0b>] netlink_sendmsg+0x96b/0xe90
>     [<ffffffff83708e0f>] ____sys_sendmsg+0x30f/0xa70
>     [<ffffffff837129fa>] ___sys_sendmsg+0x13a/0x1e0 
>     [<ffffffff83712c6c>] __sys_sendmsg+0x11c/0x1f0  
>     [<ffffffff842fe5c8>] do_syscall_64+0x38/0x80   
> unreferenced object 0xffff888112ffab60 (size 32):
>   comm "ip", pid 351, jiffies 4294763177 (age 19.697s)
>   hex dump (first 32 bytes):
>     a0 bd ef 03 81 88 ff ff a0 bd ef 03 81 88 ff ff  ................
>     88 a8 0a 00 01 00 00 00 cc cc cc cc cc cc cc cc  ................
>   backtrace:
>     [<ffffffff81a88c0a>] kmalloc_trace+0x2a/0xe0
>     [<ffffffff840f3599>] vlan_vid_add+0x409/0x790
>     [<ffffffff840f4a68>] vlan_vids_add_by_dev+0x148/0x390
>     [<ffffffff82eea5e8>] bond_enslave+0xaf8/0x5d50
>     [<ffffffff837fbfd1>] do_set_master+0x1c1/0x220
>     [<ffffffff8380711c>] do_setlink+0xa0c/0x3fa0
>     [<ffffffff8381ee09>] __rtnl_newlink+0xc09/0x18c0
>     [<ffffffff8381fb2c>] rtnl_newlink+0x6c/0xa0
>     [<ffffffff8381d4ee>] rtnetlink_rcv_msg+0x43e/0xe00
>     [<ffffffff83a2c920>] netlink_rcv_skb+0x170/0x440
>     [<ffffffff83a2a2cf>] netlink_unicast+0x53f/0x810
>     [<ffffffff83a2af0b>] netlink_sendmsg+0x96b/0xe90
>     [<ffffffff83708e0f>] ____sys_sendmsg+0x30f/0xa70
>     [<ffffffff837129fa>] ___sys_sendmsg+0x13a/0x1e0
>     [<ffffffff83712c6c>] __sys_sendmsg+0x11c/0x1f0
>     [<ffffffff842fe5c8>] do_syscall_64+0x38/0x80
> 
> [2]
> #!/bin/bash
> 
> ip link add name dummy1 type dummy
> ip link add bond1 type bond mode 802.3ad
> ip link add link bond1 name bond1.10 type vlan id 10 protocol 802.1ad
> ip link set dev dummy1 master bond1
> ip link del dev dummy1
> 
> [3]
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 484c9e3e5e82..447b06ea4fc9 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5901,7 +5901,9 @@ void bond_setup(struct net_device *bond_dev)
>  
>         bond_dev->hw_features = BOND_VLAN_FEATURES |
>                                 NETIF_F_HW_VLAN_CTAG_RX |
> -                               NETIF_F_HW_VLAN_CTAG_FILTER;
> +                               NETIF_F_HW_VLAN_CTAG_FILTER |
> +                               NETIF_F_HW_VLAN_STAG_RX |
> +                               NETIF_F_HW_VLAN_STAG_FILTER;
>  
>         bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
>         bond_dev->features |= bond_dev->hw_features;
> 
>> +	}
>>  }
>>  EXPORT_SYMBOL(vlan_vids_del_by_dev);
>>  
>> -- 
>> 2.25.1
>>
>>
> 
> .
> 

