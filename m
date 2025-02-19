Return-Path: <netdev+bounces-167600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECDA3AFEB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909EA3ADC0A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D5155312;
	Wed, 19 Feb 2025 03:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAE1119A;
	Wed, 19 Feb 2025 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934522; cv=none; b=ip7iF/YtZNP5ROI7yFeWKRoiB3jVrqb1jYW6Mu75Ay18kFeuhIxp4mfO1XR8k/OJPmUmThflM9Fq0gKwLU954xDM2wT+AYhXu4j1DQAy+SqxFI+NusAgXAAy7Pe2yrOsj3WMmU4cnnn7gmrmKQJ41kA0CMHT+R09SfnQIdpDYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934522; c=relaxed/simple;
	bh=F/b7KSb/46Hhx7CHmSwzSQ8LRO+xjTjA4Gt7OJu6PLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DDOlqmcWa1GK33vcVEz4X57ZZDgGWyyP1pq8caKb1H7bB24LmxYKKk/MTiHT0dyGHJkQmFTcYQe1OBULKCEej8fJNZb70VonZOGJK6E3hGLn5B3ZCmQMc0E0+ANtzktH1NghxVKzgJqDLihsJB5QFBu16DGYLdS4avSeCNU9i9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YyLsK5pbVzMrgD;
	Wed, 19 Feb 2025 11:07:01 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 22AFF1A0188;
	Wed, 19 Feb 2025 11:08:32 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 11:08:31 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemn100006.china.huawei.com (7.202.194.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 11:08:30 +0800
Message-ID: <4dff834e-f652-447c-a1f0-bfd851449f70@huawei.com>
Date: Wed, 19 Feb 2025 11:08:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way
 handshake
To: Eric Dumazet <edumazet@google.com>
CC: <ncardwell@google.com>, <kuniyu@amazon.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>
References: <20250218105824.34511-1-wanghai38@huawei.com>
 <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100006.china.huawei.com (7.202.194.109)



On 2025/2/18 21:35, Eric Dumazet wrote:
> On Tue, Feb 18, 2025 at 12:00 PM Wang Hai <wanghai38@huawei.com> wrote:
>>
>> If two ack packets from a connection enter tcp_check_req at the same time
>> through different cpu, it may happen that req->ts_recent is updated with
>> with a more recent time and the skb with an older time creates a new sock,
>> which will cause the tcp_validate_incoming check to fail.
>>
>> cpu1                                cpu2
>> tcp_check_req
>>                                      tcp_check_req
>> req->ts_recent = tmp_opt.rcv_tsval = t1
>>                                      req->ts_recent = tmp_opt.rcv_tsval = t2
>>
>> newsk->ts_recent = req->ts_recent = t2 // t1 < t2
>> tcp_child_process
>> tcp_rcv_state_process
>> tcp_validate_incoming
>> tcp_paws_check
>> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win) // failed
>>
>> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   net/ipv4/tcp_minisocks.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>> index b089b08e9617..0208455f9eb8 100644
>> --- a/net/ipv4/tcp_minisocks.c
>> +++ b/net/ipv4/tcp_minisocks.c
>> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>>          sock_rps_save_rxhash(child, skb);
>>          tcp_synack_rtt_meas(child, req);
>>          *req_stolen = !own_req;
>> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
>> +           unlikely(tcp_sk(child)->rx_opt.ts_recent != tmp_opt.rcv_tsval))
>> +               tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
>> +
>>          return inet_csk_complete_hashdance(sk, child, req, own_req);
> 
> Have you seen the comment at line 818 ?
> 
> /* TODO: We probably should defer ts_recent change once
>   * we take ownership of @req.
>   */
> 
> Plan was clear and explained. Why implement something else (and buggy) ?
Hi Eric,

According to the plan, can we fix it like this?

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b089b08e9617..1210d4967b94 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -814,13 +814,6 @@ struct sock *tcp_check_req(struct sock *sk, struct 
sk_buff *skb,
         }

         /* In sequence, PAWS is OK. */
-
-       /* TODO: We probably should defer ts_recent change once
-        * we take ownership of @req.
-        */
-       if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, 
tcp_rsk(req)->rcv_nxt))
-               WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
-
         if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
                 /* Truncate SYN, it is out of window starting
                    at tcp_rsk(req)->rcv_isn + 1. */
@@ -878,6 +871,9 @@ struct sock *tcp_check_req(struct sock *sk, struct 
sk_buff *skb,
         sock_rps_save_rxhash(child, skb);
         tcp_synack_rtt_meas(child, req);
         *req_stolen = !own_req;
+       if (own_req && tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)- 
seq, tcp_rsk(req)->rcv_nxt))
+               tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
+
         return inet_csk_complete_hashdance(sk, child, req, own_req);

  listen_overflow:
> 


