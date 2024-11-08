Return-Path: <netdev+bounces-143136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9318C9C13B0
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52635283D8E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB210940;
	Fri,  8 Nov 2024 01:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A012E5D;
	Fri,  8 Nov 2024 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029663; cv=none; b=H7PwR30fXuqGeN6g68obuBNX/a1+MuexI1Ca0cT5eqwYSUKGDdnK9SzFcDSaY0KT1hK4Eq7QLdMCzKDJvtn6k1awurjA0RarUkGxa4WXCQ9kV7/f5omM5Gy4q2nIJtAkJpw0SNJ4tMAmrN7MqnYpVCQkrCkWHoR41kd06Zd6LAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029663; c=relaxed/simple;
	bh=j/2zML9BZrRy1UuFY03j0zwAxJdnb6FVG7SmyxpyxCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i8+HQzudwm6KzEFQQHREv3ffsdi5D+8XjxsYq0xuBTgJL4sFeDU9hjgb9p0+eKSe6m0dShINgZe6u6M0ss7bYP8qsXDfDa+81+2AMsujYTYbnzDABvg2P6xK5eBoWau8tx8QpQ79iUmtYRRTA59sQMkz6s7TnLeYCS/HdMngizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xl1d15nx9z1T9mp;
	Fri,  8 Nov 2024 09:31:49 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D96E11402E1;
	Fri,  8 Nov 2024 09:34:11 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 09:34:10 +0800
Message-ID: <c21660c3-a8ac-4a8b-a312-f52ac781a353@huawei.com>
Date: Fri, 8 Nov 2024 09:34:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net v2] net: fix data-races around
 sk->sk_forward_alloc
To: Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <kuniyu@amazon.com>, <luoxuanqiang@kylinos.cn>,
	<kernelxing@tencent.com>, <kirjanov@gmail.com>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241105080305.717508-1-wangliang74@huawei.com>
 <CANn89iJ8mOqtOkMvrn6c892XrA_m3uf5FabmDWzA_pk-tTMCzw@mail.gmail.com>
 <20241106151401.GA120192@kernel.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20241106151401.GA120192@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2024/11/6 23:14, Simon Horman 写道:
> On Tue, Nov 05, 2024 at 10:52:34AM +0100, Eric Dumazet wrote:
>> On Tue, Nov 5, 2024 at 8:46 AM Wang Liang <wangliang74@huawei.com> wrote:
>>> Syzkaller reported this warning:
>>>   ------------[ cut here ]------------
>>>   WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1c5/0x1e0
>>>   Modules linked in:
>>>   CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>>   RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>>>   Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>>>   RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>>>   RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>>>   RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>>>   RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>>>   R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>>>   R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>>>   FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>   Call Trace:
>>>    <TASK>
>>>    ? __warn+0x88/0x130
>>>    ? inet_sock_destruct+0x1c5/0x1e0
>>>    ? report_bug+0x18e/0x1a0
>>>    ? handle_bug+0x53/0x90
>>>    ? exc_invalid_op+0x18/0x70
>>>    ? asm_exc_invalid_op+0x1a/0x20
>>>    ? inet_sock_destruct+0x1c5/0x1e0
>>>    __sk_destruct+0x2a/0x200
>>>    rcu_do_batch+0x1aa/0x530
>>>    ? rcu_do_batch+0x13b/0x530
>>>    rcu_core+0x159/0x2f0
>>>    handle_softirqs+0xd3/0x2b0
>>>    ? __pfx_smpboot_thread_fn+0x10/0x10
>>>    run_ksoftirqd+0x25/0x30
>>>    smpboot_thread_fn+0xdd/0x1d0
>>>    kthread+0xd3/0x100
>>>    ? __pfx_kthread+0x10/0x10
>>>    ret_from_fork+0x34/0x50
>>>    ? __pfx_kthread+0x10/0x10
>>>    ret_from_fork_asm+0x1a/0x30
>>>    </TASK>
>>>   ---[ end trace 0000000000000000 ]---
>>>
>>> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
>>> concurrently when sk->sk_state == TCP_LISTEN with sk->sk_lock unlocked,
>>> which triggers a data-race around sk->sk_forward_alloc:
>>> tcp_v6_rcv
>>>      tcp_v6_do_rcv
>>>          skb_clone_and_charge_r
>>>              sk_rmem_schedule
>>>                  __sk_mem_schedule
>>>                      sk_forward_alloc_add()
>>>              skb_set_owner_r
>>>                  sk_mem_charge
>>>                      sk_forward_alloc_add()
>>>          __kfree_skb
>>>              skb_release_all
>>>                  skb_release_head_state
>>>                      sock_rfree
>>>                          sk_mem_uncharge
>>>                              sk_forward_alloc_add()
>>>                              sk_mem_reclaim
>>>                                  // set local var reclaimable
>>>                                  __sk_mem_reclaim
>>>                                      sk_forward_alloc_add()
>>>
>>> In this syzkaller testcase, two threads call
>>> tcp_v6_do_rcv() with skb->truesize=768, the sk_forward_alloc changes like
>>> this:
>>>   (cpu 1)             | (cpu 2)             | sk_forward_alloc
>>>   ...                 | ...                 | 0
>>>   __sk_mem_schedule() |                     | +4096 = 4096
>>>                       | __sk_mem_schedule() | +4096 = 8192
>>>   sk_mem_charge()     |                     | -768  = 7424
>>>                       | sk_mem_charge()     | -768  = 6656
>>>   ...                 |    ...              |
>>>   sk_mem_uncharge()   |                     | +768  = 7424
>>>   reclaimable=7424    |                     |
>>>                       | sk_mem_uncharge()   | +768  = 8192
>>>                       | reclaimable=8192    |
>>>   __sk_mem_reclaim()  |                     | -4096 = 4096
>>>                       | __sk_mem_reclaim()  | -8192 = -4096 != 0
>>>
>>> The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
>>> sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
>>> Fix the same issue in dccp_v6_do_rcv().
>>>
>>> Suggested-by: Eric Dumazet <edumazet@google.com>
>>> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Hi Wang Liang,
>
> Please post a non-RFC variant of this patch so it can be considered for
> inclusion in net. And please include Eric's Reviewed-by tag.
>
> Thanks!


Thanks very much for your suggestion!

I have send the patch("[PATCH net] net: fix data-races around 
sk->sk_forward_alloc") with Reviewed-by tag, and remove the RFC.

Please check it.


