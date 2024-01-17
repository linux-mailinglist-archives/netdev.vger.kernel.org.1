Return-Path: <netdev+bounces-63953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3B18304C7
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943361C213AA
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B51DFCA;
	Wed, 17 Jan 2024 11:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB71DFC8
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492383; cv=none; b=e2gWJUGSHmhGw6EbZ8xXeYSu+ESxSeXfTzSGuhltqyRyyiAQoqUl4l9eBvvi4nt9ppJYXQ2NpnejxrJNtFkK/QN9sHywq2U7o2T3GvTkQTE7M73T4E0STigEaACUd5hecd4YmaCiCWiySHoawdFtCB1K2egK6KfpAz8HZ62NhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492383; c=relaxed/simple;
	bh=9dlU2yvjrOhkBQJnrZhu8gPJGuUtV1z75kJ8q8dI6xU=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=UAqGIoXbqPsyZTShjs2ZrmZ5A9toy0RNVraiMwKMPM/cJ6mjr1CHKatiA0PWRsa7xGHlkReruFPfUsgEe/9n3nUtTRsKxcU3uvF7u78FZrXQuDbIJ+wzCXI0TlvP4zhTM+7seAG/lr/LLCZXDR/iw34yVbytK5Z39TOo1DlKZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TFPP65VmGzWmcd;
	Wed, 17 Jan 2024 19:51:54 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C60F1800BF;
	Wed, 17 Jan 2024 19:52:56 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 19:52:56 +0800
Message-ID: <a4a29064-e0f5-69b8-b690-911d155fec86@huawei.com>
Date: Wed, 17 Jan 2024 19:52:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v3] tcp: make sure init the accept_queue's spinlocks
 once
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <sming56@aliyun.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20240117063152.1046210-1-shaozhengchao@huawei.com>
 <CANn89iKhWyw9YvS_cgfuym0sK4O-FS2xXyWgU=MjZ0g=wesYjg@mail.gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CANn89iKhWyw9YvS_cgfuym0sK4O-FS2xXyWgU=MjZ0g=wesYjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/17 19:28, Eric Dumazet wrote:
> On Wed, Jan 17, 2024 at 7:22 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>>
>> When I run syz's reproduction C program locally, it causes the following
>> </TASK>
>>
>> The issue triggering process is analyzed as follows:
>> Thread A                                       Thread B
>> tcp_v4_rcv      //receive ack TCP packet       inet_shutdown
>>    tcp_check_req                                  tcp_disconnect //disconnect sock
>>    ...                                              tcp_set_state(sk, TCP_CLOSE)
>>      inet_csk_complete_hashdance                ...
>>        inet_csk_reqsk_queue_add                 inet_listen  //start listen
>>          spin_lock(&queue->rskq_lock)             inet_csk_listen_start
>>          ...                                        reqsk_queue_alloc
>>          ...                                          spin_lock_init
>>          spin_unlock(&queue->rskq_lock)  //warning
>>
>> When the socket receives the ACK packet during the three-way handshake,
>> it will hold spinlock. And then the user actively shutdowns the socket
>> and listens to the socket immediately, the spinlock will be initialized.
>> When the socket is going to release the spinlock, a warning is generated.
>> Also the same issue to fastopenq.lock.
>>
>> Move init spinlock to inet_create and inet_accept to make sure init the
>> accept_queue's spinlocks once.
>>
>> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
>> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
>> Reported-by: Ming Shu <sming56@aliyun.com>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v3: Move init spinlock to inet_create and inet_accept.
>> v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
>> ---
>>   net/core/request_sock.c         |  3 ---
>>   net/ipv4/af_inet.c              | 11 +++++++++++
>>   net/ipv4/inet_connection_sock.c |  8 ++++++++
>>   3 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/core/request_sock.c b/net/core/request_sock.c
>> index f35c2e998406..63de5c635842 100644
>> --- a/net/core/request_sock.c
>> +++ b/net/core/request_sock.c
>> @@ -33,9 +33,6 @@
>>
>>   void reqsk_queue_alloc(struct request_sock_queue *queue)
>>   {
>> -       spin_lock_init(&queue->rskq_lock);
>> -
>> -       spin_lock_init(&queue->fastopenq.lock);
>>          queue->fastopenq.rskq_rst_head = NULL;
>>          queue->fastopenq.rskq_rst_tail = NULL;
>>          queue->fastopenq.qlen = 0;
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index 835f4f9d98d2..6589741157a4 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -244,6 +244,14 @@ int inet_listen(struct socket *sock, int backlog)
>>   }
>>   EXPORT_SYMBOL(inet_listen);
>>
>> +static void __inet_init_csk_lock(struct sock *sk)
>> +{
>> +       struct inet_connection_sock *icsk = inet_csk(sk);
>> +
>> +       spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
>> +       spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
>> +}
> 
> This probably could be an inline helper in a suitable include file.
> No need for __prefix btw.
> 
> static void inline inet_init_csk_locks(struct sock *sk)
> {
>         struct inet_connection_sock *icsk = inet_csk(sk);
> 
>         spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
>         spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
> }
> 
> 
>> +
>>   /*
>>    *     Create an inet socket.
>>    */
>> @@ -330,6 +338,9 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>>          if (INET_PROTOSW_REUSE & answer_flags)
>>                  sk->sk_reuse = SK_CAN_REUSE;
>>
>> +       if (INET_PROTOSW_ICSK & answer_flags)
>> +               __inet_init_csk_lock(sk);
>> +
>>          inet = inet_sk(sk);
>>          inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
>>
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index 8e2eb1793685..5d3277ab9954 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -655,6 +655,7 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>>   {
>>          struct inet_connection_sock *icsk = inet_csk(sk);
>>          struct request_sock_queue *queue = &icsk->icsk_accept_queue;
>> +       struct request_sock_queue *newqueue;
>>          struct request_sock *req;
>>          struct sock *newsk;
>>          int error;
>> @@ -727,6 +728,13 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>>          }
>>          if (req)
>>                  reqsk_put(req);
>> +
>> +       if (newsk) {
>> +               newqueue = &inet_csk(newsk)->icsk_accept_queue;
>> +               spin_lock_init(&newqueue->rskq_lock);
>> +               spin_lock_init(&newqueue->fastopenq.lock);
>> +       }
> 
> So that we could here use a common helper
> 
> if (newsk)
>       inet_init_csk_locks(newsk);
> 
> 
> Thanks, this is looking quite nice.
> 
Hi Eric:
	Thank you for your review. I will send V4 later.

Zhengchao Shao

