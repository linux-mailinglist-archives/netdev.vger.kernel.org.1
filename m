Return-Path: <netdev+bounces-98840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5673B8D2A0A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BF02892CD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3052B2CF;
	Wed, 29 May 2024 01:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9929A0;
	Wed, 29 May 2024 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716946609; cv=none; b=XYO0ag/nkVEoSaVJswh+MQuJU+3oNVumrj2Hrtz9YkXEv0Pv1E0TWrsJeuF4qPTskSfPvoxbVX4tz72PVMK/uJt7A/OlMYIc0fdk/KtecDCaBTGrPGW6CIGB329z8ewGAg2dctYzVyFgj0WyzmoOGzqYTdVS4tw4zxZrQqnm7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716946609; c=relaxed/simple;
	bh=mpEl7XZmp7M1ZOKua3Q8W69E/fOmIpZvLeF8vm3j7CI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fee3ScCqctSMeMYMJe7W58iK66qYc7uiVnYBW9IgPU0kjzq4/CGZHtz1q49vz08wwe5X+26h655Ln+yoAani3UF8mgRfGuumj7uI1MHNzJ0xB4oNiEvKAQt3q0h/ph3g/CeU8nAmgksApdKOAsa2ZdLZ2DM6D5kUbCwlSWKjjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VpsMX4sWbzwQck;
	Wed, 29 May 2024 09:32:56 +0800 (CST)
Received: from canpemm500007.china.huawei.com (unknown [7.192.104.62])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AA4B18006E;
	Wed, 29 May 2024 09:36:43 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 09:36:43 +0800
Subject: Re: [PATCH net] ipvlan: Dont Use skb->sk in
 ipvlan_process_v{4,6}_outbound
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <hannes@stressinduktion.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240525034231.2498827-1-yuehaibing@huawei.com>
 <1a1b249e7d53984a3ea094cdf5b362cea3273dc4.camel@redhat.com>
From: Yue Haibing <yuehaibing@huawei.com>
Message-ID: <a4a6ab6a-013c-a07a-80c1-506fdefa320f@huawei.com>
Date: Wed, 29 May 2024 09:36:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1a1b249e7d53984a3ea094cdf5b362cea3273dc4.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)

On 2024/5/28 19:15, Paolo Abeni wrote:
> On Sat, 2024-05-25 at 11:42 +0800, Yue Haibing wrote:
>> Raw packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will
>> hit WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path.
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
>> <IRQ>
>>  ? __warn (kernel/panic.c:693)
>>  ? sk_mc_loop (net/core/sock.c:760)
>>  ? report_bug (lib/bug.c:201 lib/bug.c:219)
>>  ? handle_bug (arch/x86/kernel/traps.c:239)
>>  ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>>  ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>>  ? sk_mc_loop (net/core/sock.c:760)
>>  ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
>>  ? nf_hook_slow (net/netfilter/core.c:626)
>>  ip6_finish_output (net/ipv6/ip6_output.c:222)
>>  ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
>>  ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
>>  ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
>>  dev_hard_start_xmit (net/core/dev.c:3594)
>>  sch_direct_xmit (net/sched/sch_generic.c:343)
>>  __qdisc_run (net/sched/sch_generic.c:416)
>>  net_tx_action (net/core/dev.c:5286)
>>  handle_softirqs (kernel/softirq.c:555)
>>  __irq_exit_rcu (kernel/softirq.c:589)
>>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043)
>>
>> The warning triggers as this:
>> packet_sendmsg
>>    packet_snd //skb->sk is packet sk
>>       __dev_queue_xmit
>>          __dev_xmit_skb //q->enqueue is not NULL
>>              __qdisc_run
>>                sch_direct_xmit
>>                  dev_hard_start_xmit
>>                    ipvlan_start_xmit
>>                       ipvlan_xmit_mode_l3 //l3 mode
>>                         ipvlan_process_outbound //vepa flag
>>                           ipvlan_process_v6_outbound
>>                             ip6_local_out
>>                                 __ip6_finish_output
>>                                   ip6_finish_output2 //multicast packet
>>                                     sk_mc_loop //sk->sk_family is AF_PACKET
>>
>> Call ip{6}_local_out() with NULL sk in ipvlan as other tunnels to fix this.
>>
>> Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive dereference inside the stack")
> 
> The patch LGTM, but the above fixes tag looks incorrect, I think the
> reproducer should splat even before such commit as the relevant warning
> will be still there and should be still reachable.

Yes, it should be Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver."), will post v2.
> 
> Cheers,
> 
> Paolo
> 
> .
> 

