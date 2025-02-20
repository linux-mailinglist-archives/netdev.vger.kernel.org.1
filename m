Return-Path: <netdev+bounces-168154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52709A3DC02
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C29718847C1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B083EA83;
	Thu, 20 Feb 2025 14:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC191BC4E;
	Thu, 20 Feb 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060197; cv=none; b=G3frQjcCEBxNQ8ma9D7kSCD9InF4sYT3Q4ljqvsVpzg+mLOOo1rIJeBf+g/JTwnoe7/hYXCZNzEXvaTx6TQ5KqYq9ZlfPzYfV0pONEANV4ozD8wx3lDSK7TsjcehtNxXsv9MHI6M48lrzoP6kwBzIDT9qul+RO7jXPWcmNsnfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060197; c=relaxed/simple;
	bh=O20IELQPiI+34MOiysPEaE7ghKnd+vs/0kkneEOGD9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oOysOP2antGd1T9qHF9ZC2u41/xYfldTkJGOjIsCoLNYvZwHUJyIBMKIsq4Mp3zgL1ltUumteqdxzd+//hWh5uaIIz70z2iy2eTfOGDUXb8IMGvxbp++JZ2Ns5uLiyvmHoOed/Y4UfD84J0wfG9mifW9uSeKR5k4mfd4OcylLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YzFLB45L4zWn3G;
	Thu, 20 Feb 2025 22:01:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id BE75A1800DB;
	Thu, 20 Feb 2025 22:03:11 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 22:03:11 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemn100006.china.huawei.com (7.202.194.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 22:03:10 +0800
Message-ID: <c52f3ef0-0ae0-4913-a3f0-19d55147874d@huawei.com>
Date: Thu, 20 Feb 2025 22:03:09 +0800
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
 <5fa8fc14-b67b-4da1-ac8e-339fd3e536c2@huawei.com>
 <CAL+tcoC3TuZPTwnHTDvXC+JPoJbgW2UywZ2=xv=E=utokb3pCQ@mail.gmail.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <CAL+tcoC3TuZPTwnHTDvXC+JPoJbgW2UywZ2=xv=E=utokb3pCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100006.china.huawei.com (7.202.194.109)



On 2025/2/20 11:04, Jason Xing wrote:
> On Wed, Feb 19, 2025 at 9:11 PM Wang Hai <wanghai38@huawei.com> wrote:
>>
>>
>>
>> On 2025/2/19 11:31, Jason Xing wrote:
>>> On Wed, Feb 19, 2025 at 10:16 AM Wang Hai <wanghai38@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/2/18 21:35, Eric Dumazet wrote:
>>>>> On Tue, Feb 18, 2025 at 12:00 PM Wang Hai <wanghai38@huawei.com> wrote:
>>>>>>
>>>>>> If two ack packets from a connection enter tcp_check_req at the same time
>>>>>> through different cpu, it may happen that req->ts_recent is updated with
>>>>>> with a more recent time and the skb with an older time creates a new sock,
>>>>>> which will cause the tcp_validate_incoming check to fail.
>>>>>>
>>>>>> cpu1                                cpu2
>>>>>> tcp_check_req
>>>>>>                                        tcp_check_req
>>>>>> req->ts_recent = tmp_opt.rcv_tsval = t1
>>>>>>                                        req->ts_recent = tmp_opt.rcv_tsval = t2
>>>>>>
>>>>>> newsk->ts_recent = req->ts_recent = t2 // t1 < t2
>>>>>> tcp_child_process
>>>>>> tcp_rcv_state_process
>>>>>> tcp_validate_incoming
>>>>>> tcp_paws_check
>>>>>> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <= paws_win) // failed
>>>>>>
>>>>>> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
>>>>>>
>>>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>>>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>>>>>> ---
>>>>>>     net/ipv4/tcp_minisocks.c | 4 ++++
>>>>>>     1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
>>>>>> index b089b08e9617..0208455f9eb8 100644
>>>>>> --- a/net/ipv4/tcp_minisocks.c
>>>>>> +++ b/net/ipv4/tcp_minisocks.c
>>>>>> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>>>>>>            sock_rps_save_rxhash(child, skb);
>>>>>>            tcp_synack_rtt_meas(child, req);
>>>>>>            *req_stolen = !own_req;
>>>>>> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
>>>>>> +           unlikely(tcp_sk(child)->rx_opt.ts_recent != tmp_opt.rcv_tsval))
>>>>>> +               tcp_sk(child)->rx_opt.ts_recent = tmp_opt.rcv_tsval;
>>>>>> +
>>>>>>            return inet_csk_complete_hashdance(sk, child, req, own_req);
>>>>>
>>>>> Have you seen the comment at line 818 ?
>>>>>
>>>>> /* TODO: We probably should defer ts_recent change once
>>>>>     * we take ownership of @req.
>>>>>     */
>>>>>
>>>>> Plan was clear and explained. Why implement something else (and buggy) ?
>>>>>
>>>> Hi Eric,
>>>>
>>>> Currently we have a real problem, so we want to solve it. This bug
>>>> causes the upper layers to be unable to be notified to call accept after
>>>> the successful three-way handshake.
>>>>
>>>> Skb from cpu1 that fails at tcp_paws_check (which it could have
>>>> succeeded) will not be able to enter the TCP_ESTABLISHED state, and
>>>> therefore parent->sk_data_ready(parent) will not be triggered, and skb
>>>> from cpu2 can complete the three-way handshake, but there is also no way
>>>> to call parent->sk_data_ready(parent) to notify the upper layer, which
>>>> will result
>>>> in the upper layer not being able to sense and call accept to obtain the
>>>> nsk.
>>>>
>>>> cpu1                                cpu2
>>>> tcp_check_req
>>>>                                        tcp_check_req
>>>> req->ts_recent = tmp_opt.rcv_tsval = t1
>>>>                                        req->ts_recent=tmp_opt.rcv_tsval= t2
>>>>
>>>> newsk->ts_recent = req->ts_recent = t2 // t1 < t2
>>>> tcp_child_process
>>>>     tcp_rcv_state_process
>>>>      tcp_validate_incoming
>>>>       tcp_paws_check // failed
>>>>     parent->sk_data_ready(parent); // will not be called
>>>>                                        tcp_v4_do_rcv
>>>>                                        tcp_rcv_state_process // Complete the three-way handshake
>>>>                                                                                                           // missing parent->sk_data_ready(parent);
>>>
>>> IIUC, the ack received from cpu1 triggered calling
>>> inet_csk_complete_hashdance() so its state transited from
>>> TCP_NEW_SYN_RECV to TCP_SYN_RECV, right? If so, the reason why not
>>> call sk_data_ready() if the skb entered into tcp_child_process() is
>>> that its state failed to transit to TCP_ESTABLISHED?
>>>
>> Yes, because it didn't switch to TCP_ESTABLISHED
>>> Here is another question. How did the skb on the right side enter into
>>> tcp_v4_do_rcv() after entering tcp_check_req() if the state of sk
>>> which the skb belongs to is TCP_NEW_SYN_RECV? Could you elaborate more
>>> on this point?
>> Since cpu1 successfully created the child sock, cpu2 will return
>> null in tcp_check_req and req_stolen is set to true, so that it will
>> subsequently go to 'goto lookup' to re-process the packet, and at
>> this point, sk->sk_state is already in TCP_SYN_RECV state, and then
>> then tcp_v4_do_rcv is called.
> 
> Now I can see what happened there. Perhaps it would be good to update
> the commit message
> in the next iteration.
Hi Jason,

Thanks for the suggestion, I'll test it out and improve the commit 
message to send v2.
> 
> Another key information I notice is that the second lookup process
> loses the chance to call sk_data_ready() for its parent socket. It's
> the one of the main reasons that cause your application to be unable
> to get notified. Taking a rough look at tcp_rcv_state_process(), I
> think it's not easy to acquire the parent socket there and then call
> sk_data_ready() without modifying more codes compared to the current
> solution. It's a different solution in theory.
Yes, I have considered this fix before, but the complexity of the fix 
would be higher.
> 
> If your new approach (like your previous reply) works, the following
> commit[1] will be reverted/overwritten.
I'm sorry, I may not have understood what you meant. Applying my fix, 
commit[1] is still necessary because it doesn't solve the bug that 
commit[1] fixes. can you explain in detail, why commit[1] will be 
reverted/overwritten.

Thanks,
Wang


