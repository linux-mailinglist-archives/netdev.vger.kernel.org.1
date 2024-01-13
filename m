Return-Path: <netdev+bounces-63381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A773D82C8DE
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F9A1F24912
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 01:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6415EA6;
	Sat, 13 Jan 2024 01:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDA11190
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TBh0y3PBsz1Q7rv;
	Sat, 13 Jan 2024 09:40:02 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 17CF61A0172;
	Sat, 13 Jan 2024 09:41:37 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 09:41:36 +0800
Message-ID: <e2396ae5-5f36-7522-f4df-46c79a7f2c5b@huawei.com>
Date: Sat, 13 Jan 2024 09:41:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] tcp: do not hold spinlock when sk state is not
 TCP_LISTEN
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240112013644.3079454-1-shaozhengchao@huawei.com>
 <CANn89iKiT-XvO00cygyMcc-EqToPLuyU3wX+jthQW7YnW7o2Bg@mail.gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CANn89iKiT-XvO00cygyMcc-EqToPLuyU3wX+jthQW7YnW7o2Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/12 17:42, Eric Dumazet wrote:
> On Fri, Jan 12, 2024 at 2:26 AM Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>>
>> When I run syz's reproduction C program locally, it causes the following
>> issue:
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
>>
>> The rskq_lock lock protects only the request_sock_queue structure.
>> Therefore, the rskq_lock lock could be not used when the TCP state is
>> not listen in inet_csk_reqsk_queue_add.
>>
>> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   net/ipv4/inet_connection_sock.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index 8e2eb1793685..b100a89c3d98 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -1295,11 +1295,11 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
>>   {
>>          struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
>>
>> -       spin_lock(&queue->rskq_lock);
>>          if (unlikely(sk->sk_state != TCP_LISTEN)) {
>>                  inet_child_forget(sk, req, child);
>>                  child = NULL;
>>          } else {
>> +               spin_lock(&queue->rskq_lock);
>>                  req->sk = child;
>>                  req->dl_next = NULL;
>>                  if (queue->rskq_accept_head == NULL)
>> @@ -1308,8 +1308,8 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
>>                          queue->rskq_accept_tail->dl_next = req;
>>                  queue->rskq_accept_tail = req;
>>                  sk_acceptq_added(sk);
>> +               spin_unlock(&queue->rskq_lock);
>>          }
>> -       spin_unlock(&queue->rskq_lock);
>>          return child;
>>   }
>>   EXPORT_SYMBOL(inet_csk_reqsk_queue_add);
>> --
>> 2.34.1
>>
Hi Eric:
	Thank you for you review.
> 
> This is not how I would fix the issue, this would be still racy,
> because 'listener' sk_state can change any time.
> 
> queue->fastopenq.lock would probably have a similar issue.
Yes, it will have a similar issue.
> 
> Please make sure we init the spinlock(s) once.
OK, I will send V2 after verification.
Thank you.

Zhengchao Shao

