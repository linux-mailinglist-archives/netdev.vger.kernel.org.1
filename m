Return-Path: <netdev+bounces-33439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCD79DFDC
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04822817C8
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A75415AC0;
	Wed, 13 Sep 2023 06:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93EA45
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:15:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340851730
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 23:15:55 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RlqqF1gzgzNn2y;
	Wed, 13 Sep 2023 14:12:09 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 14:15:52 +0800
Subject: Re: [PATCH net v4] team: fix null-ptr-deref when team device type is
 changed
To: Paolo Abeni <pabeni@redhat.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <leon@kernel.org>, <ye.xingchen@zte.com.cn>,
	<liuhangbin@gmail.com>
References: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
 <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <2cad19f1-552b-792f-f074-daadd8753a59@huawei.com>
Date: Wed, 13 Sep 2023 14:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected


>> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>> index d3dc22509ea5..12fb5f4cff06 100644
>> --- a/drivers/net/team/team.c
>> +++ b/drivers/net/team/team.c
>> @@ -2127,7 +2127,10 @@ static const struct ethtool_ops team_ethtool_ops = {
>>  static void team_setup_by_port(struct net_device *dev,
>>  			       struct net_device *port_dev)
>>  {
>> -	dev->header_ops	= port_dev->header_ops;
>> +	if (port_dev->type == ARPHRD_ETHER)
>> +		dev->header_ops	= &eth_header_ops;
>> +	else
>> +		dev->header_ops	= port_dev->header_ops;
>>  	dev->type = port_dev->type;
>>  	dev->hard_header_len = port_dev->hard_header_len;
>>  	dev->needed_headroom = port_dev->needed_headroom;
> 
> If I read correctly, for !vlan_hw_offload_capable() lower dev, egress
> packets going trough the team device will not contain the vlan tag. 
> 
> Additionally, why is vlan special? Why others lower devices with custom
> header_ops do not need any care? 

We have also got ipvlan device problem as following:

BUG: KASAN: slab-out-of-bounds in ipvlan_hard_header+0xd1/0xe0
Read of size 8 at addr ffff888018ee1de8 by task syz-executor.1/3469
...
Call Trace:
 <IRQ>
 dump_stack+0xbe/0xfd
 print_address_description.constprop.0+0x19/0x170
 ? ipvlan_hard_header+0xd1/0xe0
 __kasan_report.cold+0x6c/0x84
 ? ipvlan_hard_header+0xd1/0xe0
 kasan_report+0x3a/0x50
 ipvlan_hard_header+0xd1/0xe0
 ? ipvlan_get_iflink+0x40/0x40
 neigh_resolve_output+0x28f/0x410
 ip6_finish_output2+0x762/0xef0
 ? ip6_frag_init+0xf0/0xf0
 ? nf_nat_icmpv6_reply_translation+0x460/0x460
 ? do_add_counters+0x370/0x370
 ? do_add_counters+0x370/0x370
 ? ipv6_confirm+0x1ee/0x360
 ? nf_ct_bridge_unregister+0x50/0x50
 __ip6_finish_output.part.0+0x1a8/0x400
 ip6_finish_output+0x1a9/0x1e0
 ip6_output+0x146/0x2b0
 ? ip6_finish_output+0x1e0/0x1e0
 ? __ip6_finish_output+0xb0/0xb0
 ? __sanitizer_cov_trace_switch+0x50/0x90
 ? nf_hook_slow+0xa3/0x150
 mld_sendpack+0x3d9/0x670
 ? mca_alloc+0x210/0x210
 ? add_grhead+0xf5/0x140
 ? ipv6_icmp_sysctl_init+0xd0/0xd0
 ? add_grec+0x4e1/0xa90
 ? _raw_spin_lock_bh+0x85/0xe0
 ? _raw_read_unlock_irqrestore+0x30/0x30
 mld_send_cr+0x426/0x630
 ? migrate_swap_stop+0x400/0x400
 mld_ifc_timer_expire+0x22/0x240
 ? ipv6_mc_netdev_event+0x80/0x80
 call_timer_fn+0x3d/0x230
 ? ipv6_mc_netdev_event+0x80/0x80
 expire_timers+0x190/0x270
 run_timer_softirq+0x22c/0x560

ipvlan problem is slightly different from vlan.

// add ipvlan to team device
team_port_add
  team_dev_type_check_change
    team_setup_by_port // assign ipvlan_header_ops to team_dev->header_ops	
  netdev_rx_handler_register // fail out without restore team_dev->header_ops

// add other ether type device to team device
team_port_add
  team_dev_type_check_change // return directly because port_dev->type and team_dev->type are same

team_dev->head_ops has be assigned to ipvlan_header_ops. That will trigger excption.

> 
> Exporting 'eth_header_ops' for team's sake only looks a bit too much to
> me. I think could instead cache the header_ops ptr after the initial
> ether_setup().

Is it possible to use ether_setup() like bonding driver andmodify MTU individually later?

> 
> Thanks!
> 
> Paolo
> 
> 
> 
> 
> .
> 

