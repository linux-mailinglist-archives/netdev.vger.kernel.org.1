Return-Path: <netdev+bounces-146896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D59D6940
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 14:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E520281ED9
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21D188583;
	Sat, 23 Nov 2024 13:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927723098E
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368288; cv=none; b=g9iij042i9Gi6MGYB3oPVjGU2vnwnkqKZAeTfHFjZrnFUEubQ8a0+VYnTvEYCp6JAqrVC3Zglhhd70K7sMMov+TQ13POzG3VN0dvk4pJkZ6oCfWGwX8rxl+FVKD7zlCCzKWq3Mrbm8LVSqtL+y0esQwKMqD4bDNjTiZWFnWcqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368288; c=relaxed/simple;
	bh=yDskElWPzXCWFfYu59HcF+bTtisqBvmQb+TLZquULhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qbavEOXA3mxXrK4PgXjzf0pEvy4vvbKXlTRp0gjXEkl1imQ/3Dm5E3CDdW2atET5fqMGbtDt6n8eLxHAkXq9E3mAo5ECORnVv7uZppX336DvpFVRKVtTQ/nLEyRZF4Nc3HKOLl/Zu2hgSzGpd/04Xdq8ge3j1ZT9Awu8u6LeMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XwXgV3Gntz1V4lS;
	Sat, 23 Nov 2024 21:21:58 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id BEB911802D0;
	Sat, 23 Nov 2024 21:24:40 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 kwepemg200003.china.huawei.com (7.202.181.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 23 Nov 2024 21:24:39 +0800
Message-ID: <1284490f-9525-42ee-b7b8-ccadf6606f6d@huawei.com>
Date: Sat, 23 Nov 2024 21:24:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>
CC: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <liujian56@huawei.com>
References: <20241014223312.4254-1-kuniyu@amazon.com>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <20241014223312.4254-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)



在 2024/10/15 6:33, Kuniyuki Iwashima 写道:
> Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> 
>    """
>    We are seeing a use-after-free from a bpf prog attached to
>    trace_tcp_retransmit_synack. The program passes the req->sk to the
>    bpf_sk_storage_get_tracing kernel helper which does check for null
>    before using it.
>    """
> 
> The commit 83fccfc3940c ("inet: fix potential deadlock in
> reqsk_queue_unlink()") added timer_pending() in reqsk_queue_unlink() not
> to call del_timer_sync() from reqsk_timer_handler(), but it introduced a
> small race window.
> 
> Before the timer is called, expire_timers() calls detach_timer(timer, true)
> to clear timer->entry.pprev and marks it as not pending.
> 
> If reqsk_queue_unlink() checks timer_pending() just after expire_timers()
> calls detach_timer(), TCP will miss del_timer_sync(); the reqsk timer will
> continue running and send multiple SYN+ACKs until it expires.
> 
> The reported UAF could happen if req->sk is close()d earlier than the timer
> expiration, which is 63s by default.
> 
> The scenario would be
> 
>    1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
>       but del_timer_sync() is missed
> 
>    2. reqsk timer is executed and scheduled again
> 
>    3. req->sk is accept()ed and reqsk_put() decrements rsk_refcnt, but
>       reqsk timer still has another one, and inet_csk_accept() does not
>       clear req->sk for non-TFO sockets
> 
>    4. sk is close()d
> 
>    5. reqsk timer is executed again, and BPF touches req->sk
> 
> Let's not use timer_pending() by passing the caller context to
> __inet_csk_reqsk_queue_drop().
> 
> Note that reqsk timer is pinned, so the issue does not happen in most
> use cases. [1]
> 
> [0]
> BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0
> 
> Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
> bpf_sk_storage_get_tracing+0x2e/0x1b0
> bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
> bpf_trace_run2+0x4c/0xc0
> tcp_rtx_synack+0xf9/0x100
> reqsk_timer_handler+0xda/0x3d0
> run_timer_softirq+0x292/0x8a0
> irq_exit_rcu+0xf5/0x320
> sysvec_apic_timer_interrupt+0x6d/0x80
> asm_sysvec_apic_timer_interrupt+0x16/0x20
> intel_idle_irq+0x5a/0xa0
> cpuidle_enter_state+0x94/0x273
> cpu_startup_entry+0x15e/0x260
> start_secondary+0x8a/0x90
> secondary_startup_64_no_verify+0xfa/0xfb
> 
> kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6
> 
> allocated by task 0 on cpu 9 at 260507.901592s:
> sk_prot_alloc+0x35/0x140
> sk_clone_lock+0x1f/0x3f0
> inet_csk_clone_lock+0x15/0x160
> tcp_create_openreq_child+0x1f/0x410
> tcp_v6_syn_recv_sock+0x1da/0x700
> tcp_check_req+0x1fb/0x510
> tcp_v6_rcv+0x98b/0x1420
> ipv6_list_rcv+0x2258/0x26e0
> napi_complete_done+0x5b1/0x2990
> mlx5e_napi_poll+0x2ae/0x8d0
> net_rx_action+0x13e/0x590
> irq_exit_rcu+0xf5/0x320
> common_interrupt+0x80/0x90
> asm_common_interrupt+0x22/0x40
> cpuidle_enter_state+0xfb/0x273
> cpu_startup_entry+0x15e/0x260
> start_secondary+0x8a/0x90
> secondary_startup_64_no_verify+0xfa/0xfb
> 
> freed by task 0 on cpu 9 at 260507.927527s:
> rcu_core_si+0x4ff/0xf10
> irq_exit_rcu+0xf5/0x320
> sysvec_apic_timer_interrupt+0x6d/0x80
> asm_sysvec_apic_timer_interrupt+0x16/0x20
> cpuidle_enter_state+0xfb/0x273
> cpu_startup_entry+0x15e/0x260
> start_secondary+0x8a/0x90
> secondary_startup_64_no_verify+0xfa/0xfb
> 
> Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink()")
> Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
> Closes: https://lore.kernel.org/netdev/eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev/
> Link: https://lore.kernel.org/netdev/b55e2ca0-42f2-4b7c-b445-6ffd87ca74a0@linux.dev/ [1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v3:
>    * Stop timer before reqsk_queue_removed().
> 
> v2: https://lore.kernel.org/netdev/20241009174226.7738-1-kuniyu@amazon.com/
>    * Added issue scenario in changelog
>    * Correct reqsk for __inet_csk_reqsk_queue_drop()
> 
> v1: https://lore.kernel.org/netdev/20241007141557.14424-1-kuniyu@amazon.com/
> ---
>   net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 2c5632d4fddb..2b698f8419fe 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1045,21 +1045,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
>   		found = __sk_nulls_del_node_init_rcu(sk);
>   		spin_unlock(lock);
>   	}
> -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
> -		reqsk_put(req);
> +
>   	return found;
>   }
>   
> -bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
> +static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
> +					struct request_sock *req,
> +					bool from_timer)
>   {
>   	bool unlinked = reqsk_queue_unlink(req);
>   
> +	if (!from_timer && timer_delete_sync(&req->rsk_timer))
> +		reqsk_put(req);
> +
>   	if (unlinked) {
>   		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
>   		reqsk_put(req);
>   	}
> +
>   	return unlinked;
>   }
> +
> +bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
> +{
> +	return __inet_csk_reqsk_queue_drop(sk, req, false);
> +}
>   EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
>   
>   void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
> @@ -1152,7 +1162,7 @@ static void reqsk_timer_handler(struct timer_list *t)
>   
>   		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
>   			/* delete timer */
> -			inet_csk_reqsk_queue_drop(sk_listener, nreq);
> +			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
>   			goto no_ownership;
>   		}
>   
> @@ -1178,7 +1188,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>   	}
>   
>   drop:
> -	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
> +	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> +	reqsk_put(req);
Excuse me, why is "req" used here instead of "oreq"?
Typo?
>   }
>   
>   static bool reqsk_queue_hash_req(struct request_sock *req,

