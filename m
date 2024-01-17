Return-Path: <netdev+bounces-63890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244EC82FEF8
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED9F28808E
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F4CEBE;
	Wed, 17 Jan 2024 02:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370367F5
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459944; cv=none; b=MjUtKhVRAcrgylH2hlQRHNk+d8zJhDlH1HRarCycCVupvUkx3aZAf36+pOAACTJOSfI0CyTzwcZ/E3Uj8EdS8rc/pXQZApt9hNuKZ9/lzvbucnv3v4tC3DKfchPbfplnrqiJsdJtcfodRTiN+UUEWM8SnSDL/w87S/0YxoRn6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459944; c=relaxed/simple;
	bh=RpmC8KaQ8sSS17l0cfZR6o51Yo0vxI28CjoTMDuxxw0=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=ZDrhcxbvuAN8toA2lxTvvp1obsg+BrQB5l9mTze3ve34w9ZFSafn51FjrO/FWeDyRqLXxYcCeGTMJ7M6t6laiCikzkFNXpLRRLHdU96CRhArNB/Ws9noPE4ByS/a1IucHfRzRqqC5WRACseHUxWjlt/hkNB3WBNuE6We3wB51+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TF9Kd74gxz1FJQW;
	Wed, 17 Jan 2024 10:48:05 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D438140259;
	Wed, 17 Jan 2024 10:52:19 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 10:52:19 +0800
Message-ID: <444d4d17-a936-3c52-7f0c-85022e89ea29@huawei.com>
Date: Wed, 17 Jan 2024 10:52:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] tcp: make sure init the accept_queue's spinlocks
 once
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<dsahern@kernel.org>
CC: <hkchu@google.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240113030739.3446338-1-shaozhengchao@huawei.com>
 <0b0af55211d1ab8884c01e667f8bb5f8972c1622.camel@redhat.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <0b0af55211d1ab8884c01e667f8bb5f8972c1622.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/16 18:26, Paolo Abeni wrote:
> On Sat, 2024-01-13 at 11:07 +0800, Zhengchao Shao wrote:
>> When I run syz's reproduction C program locally, it causes the following
>> issue:
>> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
>> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
>> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>> RIP: 0010:__pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
>> Code: 73 56 3a ff 90 c3 cc cc cc cc 8b 05 bb 1f 48 01 85 c0 74 05 c3 cc cc cc cc 8b 17 48 89 fe 48 c7 c7
>> 30 20 ce 8f e8 ad 56 42 ff <0f> 0b c3 cc cc cc cc 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90
>> RSP: 0018:ffffa8d200604cb8 EFLAGS: 00010282
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9d1ef60e0908
>> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d1ef60e0900
>> RBP: ffff9d181cd5c280 R08: 0000000000000000 R09: 00000000ffff7fff
>> R10: ffffa8d200604b68 R11: ffffffff907dcdc8 R12: 0000000000000000
>> R13: ffff9d181cd5c660 R14: ffff9d1813a3f330 R15: 0000000000001000
>> FS:  00007fa110184640(0000) GS:ffff9d1ef60c0000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000000 CR3: 000000011f65e000 CR4: 00000000000006f0
>> Call Trace:
>> <IRQ>
>>    _raw_spin_unlock (kernel/locking/spinlock.c:186)
>>    inet_csk_reqsk_queue_add (net/ipv4/inet_connection_sock.c:1321)
>>    inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1358)
>>    tcp_check_req (net/ipv4/tcp_minisocks.c:868)
>>    tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2260)
>>    ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
>>    ip_local_deliver_finish (net/ipv4/ip_input.c:234)
>>    __netif_receive_skb_one_core (net/core/dev.c:5529)
>>    process_backlog (./include/linux/rcupdate.h:779)
>>    __napi_poll (net/core/dev.c:6533)
>>    net_rx_action (net/core/dev.c:6604)
>>    __do_softirq (./arch/x86/include/asm/jump_label.h:27)
>>    do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
>> </IRQ>
>> <TASK>
>>    __local_bh_enable_ip (kernel/softirq.c:381)
>>    __dev_queue_xmit (net/core/dev.c:4374)
>>    ip_finish_output2 (./include/net/neighbour.h:540 net/ipv4/ip_output.c:235)
>>    __ip_queue_xmit (net/ipv4/ip_output.c:535)
>>    __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
>>    tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6469)
>>    tcp_rcv_state_process (net/ipv4/tcp_input.c:6657)
>>    tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
>>    __release_sock (./include/net/sock.h:1121 net/core/sock.c:2968)
>>    release_sock (net/core/sock.c:3536)
>>    inet_wait_for_connect (net/ipv4/af_inet.c:609)
>>    __inet_stream_connect (net/ipv4/af_inet.c:702)
>>    inet_stream_connect (net/ipv4/af_inet.c:748)
>>    __sys_connect (./include/linux/file.h:45 net/socket.c:2064)
>>    __x64_sys_connect (net/socket.c:2073 net/socket.c:2070 net/socket.c:2070)
>>    do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82)
>>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
>>    RIP: 0033:0x7fa10ff05a3d
>>    Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89
>>    c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
>>    RSP: 002b:00007fa110183de8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
>>    RAX: ffffffffffffffda RBX: 0000000020000054 RCX: 00007fa10ff05a3d
>>    RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
>>    RBP: 00007fa110183e20 R08: 0000000000000000 R09: 0000000000000000
>>    R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa110184640
>>    R13: 0000000000000000 R14: 00007fa10fe8b060 R15: 00007fff73e23b20
>> </TASK>
>>
>> The issue triggering process is analyzed as follows:
>> Thread A                                       Thread B
>> tcp_v4_rcv	//receive ack TCP packet       inet_shutdown
>>    tcp_check_req                                  tcp_disconnect //disconnect sock
>>    ...                                              tcp_set_state(sk, TCP_CLOSE)
>>      inet_csk_complete_hashdance                ...
>>        inet_csk_reqsk_queue_add                 inet_listen  //start listen
>>          spin_lock(&queue->rskq_lock)             inet_csk_listen_start
>>          ...                                        reqsk_queue_alloc
>>          ...                                          spin_lock_init
>>          spin_unlock(&queue->rskq_lock)	//warning
>>
>> When the socket receives the ACK packet during the three-way handshake,
>> it will hold spinlock. And then the user actively shutdowns the socket
>> and listens to the socket immediately, the spinlock will be initialized.
>> When the socket is going to release the spinlock, a warning is generated.
>> Also the same issue to fastopenq.lock.
>>
>> Add 'init_done' to make sure init the accept_queue's spinlocks once.
>>
>> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
>> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
>> ---
>>   include/net/request_sock.h | 1 +
>>   net/core/request_sock.c    | 7 +++++--
>>   net/ipv4/tcp.c             | 1 +
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
>> index 144c39db9898..0054746fe92d 100644
>> --- a/include/net/request_sock.h
>> +++ b/include/net/request_sock.h
>> @@ -175,6 +175,7 @@ struct fastopen_queue {
>>   struct request_sock_queue {
>>   	spinlock_t		rskq_lock;
>>   	u8			rskq_defer_accept;
>> +	bool			init_done;
>>   
>>   	u32			synflood_warned;
>>   	atomic_t		qlen;
>> diff --git a/net/core/request_sock.c b/net/core/request_sock.c
>> index f35c2e998406..51fe631a4af2 100644
>> --- a/net/core/request_sock.c
>> +++ b/net/core/request_sock.c
>> @@ -33,9 +33,12 @@
>>   
>>   void reqsk_queue_alloc(struct request_sock_queue *queue)
>>   {
>> -	spin_lock_init(&queue->rskq_lock);
>> +	if (!queue->init_done) {
>> +		spin_lock_init(&queue->rskq_lock);
>> +		spin_lock_init(&queue->fastopenq.lock);
>> +		queue->init_done = true;
>> +	}
>>   
>> -	spin_lock_init(&queue->fastopenq.lock);
>>   	queue->fastopenq.rskq_rst_head = NULL;
>>   	queue->fastopenq.rskq_rst_tail = NULL;
>>   	queue->fastopenq.qlen = 0;
> 
> I looks like the last bits of reqsk_queue_alloc() could still race with
> a 3rd ack. Could the latter end-up touching a corrupted/unexpectedly
> zeroed fastopenq?
> 
Hi Paolo:
	I haven't been able to analyze the specific scenario yet. Can
you describe it in detail? Thank you.

Zhengchao Shao
> Cheers,
> 
> Paolo
> 

