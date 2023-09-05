Return-Path: <netdev+bounces-32070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3E792264
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724F8281181
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6333D2F0;
	Tue,  5 Sep 2023 12:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA188D2EC
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:01:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57211B3;
	Tue,  5 Sep 2023 05:01:14 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rg3vf0Vghz1M9Cj;
	Tue,  5 Sep 2023 19:59:26 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 20:01:11 +0800
Subject: Re: [PATCH net v3] team: fix null-ptr-deref when team device type is
 changed
To: Paolo Abeni <pabeni@redhat.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <liuhangbin@gmail.com>
CC: <linux-kernel@vger.kernel.org>
References: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
 <7125d734bdf73708aae9f431fb5d18b1699499a5.camel@redhat.com>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <b7f5a25e-50b7-5738-fd43-52284c1469c9@huawei.com>
Date: Tue, 5 Sep 2023 20:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7125d734bdf73708aae9f431fb5d18b1699499a5.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Tue, 2023-09-05 at 16:10 +0800, Ziyang Xuan wrote:
>> Get a null-ptr-deref bug as follows with reproducer [1].
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000228
>> ...
>> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
>> ...
>> Call Trace:
>>  <TASK>
>>  ? __die+0x24/0x70
>>  ? page_fault_oops+0x82/0x150
>>  ? exc_page_fault+0x69/0x150
>>  ? asm_exc_page_fault+0x26/0x30
>>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>>  neigh_connected_output+0xb2/0x100
>>  ip6_finish_output2+0x1cb/0x520
>>  ? nf_hook_slow+0x43/0xc0
>>  ? ip6_mtu+0x46/0x80
>>  ip6_finish_output+0x2a/0xb0
>>  mld_sendpack+0x18f/0x250
>>  mld_ifc_work+0x39/0x160
>>  process_one_work+0x1e6/0x3f0
>>  worker_thread+0x4d/0x2f0
>>  ? __pfx_worker_thread+0x10/0x10
>>  kthread+0xe5/0x120
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork+0x34/0x50
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork_asm+0x1b/0x30
>>
>> [1]
>> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
>> $ ip link add name t-dummy type dummy
>> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
>> $ ip link add name t-nlmon type nlmon
>> $ ip link set t-nlmon master team0
>> $ ip link set t-nlmon nomaster
>> $ ip link set t-dummy up
>> $ ip link set team0 up
>> $ ip link set t-dummy.100 down
>> $ ip link set t-dummy.100 master team0
>>
>> When enslave a vlan device to team device and team device type is changed
>> from non-ether to ether, header_ops of team device is changed to
>> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
>> for vlan->real_dev in vlan_dev_hard_header() because team device is not
>> a vlan device.
>>
>> Assign eth_header_ops to header_ops of team device when its type is changed
>> from non-ether to ether to fix the bug.
>>
>> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> I'm sorry to note that this submission does not fit our process:
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/maintainer-netdev.rst#L353
> 
> this specific kind of process violations tend to make reviewers quite
> unhappy, please be more careful.
> 
Sorry for the inconvenience caused to everyone. It's my fault. I will improve.

> Regards,
> 
> Paolo
> 
> .
> 

