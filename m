Return-Path: <netdev+bounces-167740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF3DA3BF90
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89993A5E4A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EF91E3DC6;
	Wed, 19 Feb 2025 13:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FA1E5B97;
	Wed, 19 Feb 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970687; cv=none; b=lI3lCvs2R3g3hddNWzNVZK8OMxHrRcd5e4zdker6FF3OgIiRBXyrCxEp0GzwEp6XCc/JPQQ455ITrFTKkqqTcASILKwPlLJ46eYNdgUzpihG8hz5/Z7M6+DhczKaUceYZuRTqWvaLCDzxkSOlbTfihV/mCSEe9A6dat8GKdijb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970687; c=relaxed/simple;
	bh=IZPWOWfdVpOQpOW8h2ZxKykyu2r3t9RE7R/ymrdQ8Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fYaKmQV/s+sEin1wVp948mCtH8OjHMyGDtQ6YdhpqpBirBa7P+U75dmCLanUlfQ3/MnSpBkSPUmzN4odQpAVUTAauo8qquf3nnruM/FD4tafUFh/LE88wbpsocHGsWQdoyId2vm2jXWJFgc1Lu0mi30w2O/hB1DMy9714Ywktgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YycBN5xsNzkXPk;
	Wed, 19 Feb 2025 21:07:40 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C38C1402CF;
	Wed, 19 Feb 2025 21:11:21 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 21:11:20 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemn100006.china.huawei.com (7.202.194.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 21:11:19 +0800
Message-ID: <5fa8fc14-b67b-4da1-ac8e-339fd3e536c2@huawei.com>
Date: Wed, 19 Feb 2025 21:11:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way
 handshake
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Eric Dumazet <edumazet@google.com>, <ncardwell@google.com>,
	<kuniyu@amazon.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250218105824.34511-1-wanghai38@huawei.com>
 <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
 <f3b279ea-92c3-457f-915a-2f4963746838@huawei.com>
 <CAL+tcoByx13C1Bk1E33C_TqhpXydNNMe=PF93-5daRQeUC=V7A@mail.gmail.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <CAL+tcoByx13C1Bk1E33C_TqhpXydNNMe=PF93-5daRQeUC=V7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100006.china.huawei.com (7.202.194.109)



On 2025/2/19 11:31, Jason Xing wrote:
> On Wed, Feb 19, 2025 at 10:16 AM Wang Hai <wanghai38@huawei.com> wrote:
>>
>>
>>
>> On 2025/2/18 21:35, Eric Dumazet wrote:
>>> On Tue, Feb 18, 2025 at 12:00 PM Wang Hai <wanghai38@huawei.com> wrote:
>>>>
>>>> If two ack packets from a connection enter tcp_check_req at the same time
>>>> through different cpu, it may happen that req->ts_recent is updated with
>>>> with a more recent time and the skb with an older time creates a new sock,
>>>> which will cause the tcp_validate_incoming check to fail.
>>>>
>>>> cpu1                                cpu2
>>>> tcp_check_req
>>>>                                       tcp_check_req
>>>> req->ts_recent = tmp_opt.rcv_tsval = t1
>>>>                                       req->ts_recent = tmp_opt.rcv_tsval = t2
>>>>
>>>> newsk->ts_recent = req->ts_recent = t2 // t1 < t2
>>>> tcp_child_process
>>>> tcp_rcv_state_process
>>>> tcp_validate_incoming
>>>> tcp_paws_check
>>>> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win) // failed
>>>>
>>>> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>>>> ---
>>>>    net/ipv4/tcp_minisocks.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>>>> index b089b08e9617..0208455f9eb8 100644
>>>> --- a/net/ipv4/tcp_minisocks.c
>>>> +++ b/net/ipv4/tcp_minisocks.c
>>>> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>>>>           sock_rps_save_rxhash(child, skb);
>>>>           tcp_synack_rtt_meas(child, req);
>>>>           *req_stolen = !own_req;
>>>> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
>>>> +           unlikely(tcp_sk(child)->rx_opt.ts_recent != tmp_opt.rcv_tsval))
>>>> +               tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
>>>> +
>>>>           return inet_csk_complete_hashdance(sk, child, req, own_req);
>>>
>>> Have you seen the comment at line 818 ?
>>>
>>> /* TODO: We probably should defer ts_recent change once
>>>    * we take ownership of @req.
>>>    */
>>>
>>> Plan was clear and explained. Why implement something else (and buggy) ?
>>>
>> Hi Eric,
>>
>> Currently we have a real problem, so we want to solve it. This bug
>> causes the upper layers to be unable to be notified to call accept after
>> the successful three-way handshake.
>>
>> Skb from cpu1 that fails at tcp_paws_check (which it could have
>> succeeded) will not be able to enter the TCP_ESTABLISHED state, and
>> therefore parent->sk_data_ready(parent) will not be triggered, and skb
>> from cpu2 can complete the three-way handshake, but there is also no way
>> to call parent->sk_data_ready(parent) to notify the upper layer, which
>> will result
>> in the upper layer not being able to sense and call accept to obtain the
>> nsk.
>>
>> cpu1                                cpu2
>> tcp_check_req
>>                                       tcp_check_req
>> req->ts_recent = tmp_opt.rcv_tsval = t1
>>                                       req->ts_recent=tmp_opt.rcv_tsval= t2
>>
>> newsk->ts_recent = req->ts_recent = t2 // t1 < t2
>> tcp_child_process
>>    tcp_rcv_state_process
>>     tcp_validate_incoming
>>      tcp_paws_check // failed
>>    parent->sk_data_ready(parent); // will not be called
>>                                       tcp_v4_do_rcv
>>                                       tcp_rcv_state_process // Complete the three-way handshake
>>                                                                                                          // missing parent->sk_data_ready(parent);
> 
> IIUC, the ack received from cpu1 triggered calling
> inet_csk_complete_hashdance() so its state transited from
> TCP_NEW_SYN_RECV to TCP_SYN_RECV, right? If so, the reason why not
> call sk_data_ready() if the skb entered into tcp_child_process() is
> that its state failed to transit to TCP_ESTABLISHED?
> 
Yes, because it didn't switch to TCP_ESTABLISHED
> Here is another question. How did the skb on the right side enter into
> tcp_v4_do_rcv() after entering tcp_check_req() if the state of sk
> which the skb belongs to is TCP_NEW_SYN_RECV? Could you elaborate more
> on this point?
Since cpu1 successfully created the child sock, cpu2 will return
null in tcp_check_req and req_stolen is set to true, so that it will
subsequently go to 'goto lookup' to re-process the packet, and at
this point, sk->sk_state is already in TCP_SYN_RECV state, and then
then tcp_v4_do_rcv is called.
> 
> Thanks,
> Jason


