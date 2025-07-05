Return-Path: <netdev+bounces-204277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB24AF9E0A
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 05:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66367A979D
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F827280B;
	Sat,  5 Jul 2025 03:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9E26CE21;
	Sat,  5 Jul 2025 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751684790; cv=none; b=usK1/jjmWWJgVRACPLGrn3g+JjkhbGEB43swPUSmEGM3YYHjfJsQGDlNdxEFFigU+SleJ6gtodlsPT9Gos1C8HoYi0H22f0AcLUFwu5ye7aTzYJrKwmDhjTPkaz6lU4RqcpY+QoDgTzK0Y0AInmFfw3EczKWr6xeg2vCuPMNkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751684790; c=relaxed/simple;
	bh=xSmD1BN6P5V7C/X5RvCFdlgaheiZckKB+DDOQhLV30E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SRrCYOdWugQx6M1XNkjDQx/0aZxxX0GpuECrFFHsMYsxoPNj/ryAOOtBu49r71x0WG5nymzZYVxbMj69qc+ztegfUB1UAwrQ+JIOOhXjH7JVo4UHjYaCHSN7+DIwT8hfVfdZzIraqVUOlVUih3PrIU/HhpupDMWTPlqey6/SZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bYwQ522zrz2qFCJ;
	Sat,  5 Jul 2025 11:06:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D06D1A016C;
	Sat,  5 Jul 2025 11:05:40 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 5 Jul 2025 11:05:40 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 5 Jul 2025 11:05:39 +0800
Message-ID: <86aad556-51a7-47b8-872f-8ba1e06727a9@huawei.com>
Date: Sat, 5 Jul 2025 11:05:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: vlan: fix VLAN 0 refcount imbalance of
 toggling filtering during runtime
To: Ido Schimmel <idosch@idosch.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <jiri@resnulli.us>,
	<oscmaes92@gmail.com>, <linux@treblig.org>, <pedro.netdev@dondevamos.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20250703075702.1063149-1-dongchenchen2@huawei.com>
 <20250703075702.1063149-2-dongchenchen2@huawei.com>
 <aGf11IS6Blvz_XOm@shredder>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <aGf11IS6Blvz_XOm@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Thu, Jul 03, 2025 at 03:57:01PM +0800, Dong Chenchen wrote:
>> 8021q(vlan_device_event) will add VLAN 0 when enabling the device, and
>> remove it on disabling it if NETIF_F_HW_VLAN_CTAG_FILTER set.
>> However, if changing filter feature during netdev runtime,
>> null-ptr-unref[1] or bug_on[2] will be triggered by unregister_vlan_dev()
>> for refcount imbalance.
> [...]
>
>> Root cause is as below:
>> step1: add vlan0 for real_dev, such as bond, team.
>> register_vlan_dev
>>      vlan_vid_add(real_dev,htons(ETH_P_8021Q),0) //refcnt=1
>> step2: disable vlan filter feature and enable real_dev
>> step3: change filter from 0 to 1
>> vlan_device_event
>>      vlan_filter_push_vids
>>      	ndo_vlan_rx_add_vid //No refcnt added to real_dev vlan0
>> step4: real_dev down
>> vlan_device_event
>>      vlan_vid_del(dev, htons(ETH_P_8021Q), 0); //refcnt=0
>>          vlan_info_rcu_free //free vlan0
>> step5: real_dev up
>> vlan_device_event
>>      vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
>>          vlan_info_alloc //alloc new empty vid0. refcnt=1
>> step6: delete vlan0
>> unregister_vlan_dev
>>      BUG_ON(!vlan_info); //will trigger it if step5 was not executed
>>      vlan_group_set_device
>>          array = vg->vlan_devices_arrays
>> 	//null-ptr-ref will be triggered after step5
>>
>> E.g. the following sequence can reproduce null-ptr-ref
>>
>> $ ip link add bond0 type bond mode 0
>> $ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
>> $ ethtool -K bond0 rx-vlan-filter off
>> $ ifconfig bond0 up
>> $ ethtool -K bond0 rx-vlan-filter on
>> $ ifconfig bond0 down
>> $ ifconfig bond0 up
>> $ ip link del vlan0
>>
>> Add the auto_vid0 flag to track the refcount of vlan0, and use this
>> flag to determine whether to dec refcount while disabling real_dev.
>>
>> Fixes: ad1afb003939 ("vlan_dev: VLAN 0 should be treated as "no vlan tag" (802.1p packet)")
>> Reported-by: syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=a8b046e462915c65b10b
>> Co-developed-by: Ido Schimmel <idosch@idosch.org>
>> Signed-off-by: Ido Schimmel <idosch@idosch.org>
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> Given my name is also on the patch, do you mind making the commit

Hi, Ido

Thanks for your review
I apologize for adding your signature to the patch without your
permission. Perhaps I should use "suggested-by"?

> message a bit clearer? Specifically, in addition to the BUG_ON(), it
> would be good to also describe the memory leak. Something like this:
>
> "
> Assuming the "rx-vlan-filter" feature is enabled on a net device, the
> 8021q module will automatically add or remove VLAN 0 when the net device
> is put administratively up or down, respectively.
>
> There are a couple of problems with the above scheme. The first problem
> is a memory leak that can happen if the "rx-vlan-filter" feature is
> disabled while the device is running:
>
>   # ip link add bond1 up type bond mode 0
>   # ethtool -K bond1 rx-vlan-filter off
>   # ip link del dev bond1
>
> When the device is put administratively down the "rx-vlan-filter"
> feature is disabled, so the 8021q module will not remove VLAN 0 and the
> memory will be leaked [1].
>
> Another problem that can happen is that the kernel can automatically
> delete VLAN 0 when the device is put administratively down despite not
> adding it when the device was put administratively up since during that
> time the "rx-vlan-filter" feature was disabled.
>
> This is not a problem if VLAN 0 does not exist, but if it belongs to an
> upper VLAN device with VLAN ID 0, then a crash [2] can be triggered when the
> VLAN device is deleted since the lower device does not have a VLAN info
> structure associated with it:
>
>   # ip link add bond1 type bond mode 0
>   # ip link add link bond1 name vlan0 type vlan id 0 protocol 802.1q
>   # ethtool -K bond1 rx-vlan-filter off
>   # ip link set dev bond1 up
>   # ethtool -K bond1 rx-vlan-filter on
>   # ip link set dev bond1 down
>   # ip link del vlan0
>
> Fix both problems by noting in the VLAN info whether VLAN 0 was
> automatically added upon NETDEV_UP and based on that decide whether it
> should be deleted upon NETDEV_DOWN, regardless of the state of the
> "rx-vlan-filter" feature.
>
> [1]
> unreferenced object 0xffff8880068e3100 (size 256):
>    comm "ip", pid 384, jiffies 4296130254
>    hex dump (first 32 bytes):
>      00 20 30 0d 80 88 ff ff 00 00 00 00 00 00 00 00  . 0.............
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 81ce31fa):
>      __kmalloc_cache_noprof+0x2b5/0x340
>      vlan_vid_add+0x434/0x940
>      vlan_device_event.cold+0x75/0xa8
>      notifier_call_chain+0xca/0x150
>      __dev_notify_flags+0xe3/0x250
>      rtnl_configure_link+0x193/0x260
>      rtnl_newlink_create+0x383/0x8e0
>      __rtnl_newlink+0x22c/0xa40
>      rtnl_newlink+0x627/0xb00
>      rtnetlink_rcv_msg+0x6fb/0xb70
>      netlink_rcv_skb+0x11f/0x350
>      netlink_unicast+0x426/0x710
>      netlink_sendmsg+0x75a/0xc20
>      __sock_sendmsg+0xc1/0x150
>      ____sys_sendmsg+0x5aa/0x7b0
>      ___sys_sendmsg+0xfc/0x180
> unreferenced object 0xffff888008c06f20 (size 32):
>    comm "ip", pid 384, jiffies 4296130254
>    hex dump (first 32 bytes):
>      a0 31 8e 06 80 88 ff ff a0 31 8e 06 80 88 ff ff  .1.......1......
>      81 00 00 00 01 00 00 00 cc cc cc cc cc cc cc cc  ................
>    backtrace (crc fe715fa5):
>      __kmalloc_cache_noprof+0x2b5/0x340
>      vlan_vid_add+0x25a/0x940
>      vlan_device_event.cold+0x75/0xa8
>      notifier_call_chain+0xca/0x150
>      __dev_notify_flags+0xe3/0x250
>      rtnl_configure_link+0x193/0x260
>      rtnl_newlink_create+0x383/0x8e0
>      __rtnl_newlink+0x22c/0xa40
>      rtnl_newlink+0x627/0xb00
>      rtnetlink_rcv_msg+0x6fb/0xb70
>      netlink_rcv_skb+0x11f/0x350
>      netlink_unicast+0x426/0x710
>      netlink_sendmsg+0x75a/0xc20
>      __sock_sendmsg+0xc1/0x150
>      ____sys_sendmsg+0x5aa/0x7b0
>      ___sys_sendmsg+0xfc/0x180
>
> [2]
> kernel BUG at net/8021q/vlan.c:99!
> Oops: invalid opcode: 0000 [#1] SMP KASAN
> CPU: 4 UID: 0 PID: 405 Comm: ip Not tainted 6.16.0-rc4-virtme-gb9fd9888a565 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
> RIP: 0010:unregister_vlan_dev+0x290/0x3b0
> [...]
> Call Trace:
>   <TASK>
>   rtnl_dellink+0x33d/0xa50
>   rtnetlink_rcv_msg+0x6fb/0xb70
>   netlink_rcv_skb+0x11f/0x350
>   netlink_unicast+0x426/0x710
>   netlink_sendmsg+0x75a/0xc20
>   __sock_sendmsg+0xc1/0x150
>   ____sys_sendmsg+0x5aa/0x7b0
>   ___sys_sendmsg+0xfc/0x180
>   __sys_sendmsg+0x124/0x1c0
>   do_syscall_64+0xbb/0x360
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> "

v3 wil be send. Thank you for your guidance.

Best regards
Dong Chenchen


