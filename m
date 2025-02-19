Return-Path: <netdev+bounces-167579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CCA3AF66
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FD3175C15
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4822BAF4;
	Wed, 19 Feb 2025 02:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F722862BE;
	Wed, 19 Feb 2025 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931403; cv=none; b=UTl0Y6OpkOhKqGIlEioItEnpiLWAWcruU6sxn00SDnpE3Nx9/VaNzI/K8cAvWeuePVnlya1n0MHYahi4BiYyaYZWvC4PiwTFb58nEY6frZabGNl4H4NQ7WPDvduJ+N65gDOcx1RW3J1b9tA+xq27BY95NyEObPl5SZT8CIkDlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931403; c=relaxed/simple;
	bh=4bSW4K+gbt3sFOuxBssTMp43VhqeJuAd/btPUf4ThMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iwKN5oYsI5XCoWJq1nO69K4Id8UfOeH+z8lAP4ynA95g/SIl4dutbIxjQTQGTpWHP4lRH5Poh9dFbaX7cmMtPC14/7/DONYcHHDUIXcY4rvmg+iQ5rQlpOC/aUWQlmlcsSN4H+brZQW61HfNLHlvkHfRGm60FyuACN7I21vCrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YyKdl69QgzjYD3;
	Wed, 19 Feb 2025 10:11:55 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id B6161140367;
	Wed, 19 Feb 2025 10:16:31 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 10:16:31 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemn100006.china.huawei.com (7.202.194.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 10:16:30 +0800
Message-ID: <f3b279ea-92c3-457f-915a-2f4963746838@huawei.com>
Date: Wed, 19 Feb 2025 10:16:29 +0800
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
> 
Hi Eric,

Currently we have a real problem, so we want to solve it. This bug 
causes the upper layers to be unable to be notified to call accept after 
the successful three-way handshake.

Skb from cpu1 that fails at tcp_paws_check (which it could have 
succeeded) will not be able to enter the TCP_ESTABLISHED state, and 
therefore parent->sk_data_ready(parent) will not be triggered, and skb 
from cpu2 can complete the three-way handshake, but there is also no way 
to call parent->sk_data_ready(parent) to notify the upper layer, which 
will result
in the upper layer not being able to sense and call accept to obtain the 
nsk.

cpu1                                cpu2
tcp_check_req
                                     tcp_check_req
req->ts_recent = tmp_opt.rcv_tsval = t1
                                     req->ts_recent=tmp_opt.rcv_tsval= t2

newsk->ts_recent = req->ts_recent = t2 // t1 < t2
tcp_child_process
  tcp_rcv_state_process
   tcp_validate_incoming
    tcp_paws_check // failed
  parent->sk_data_ready(parent); // will not be called
                                     tcp_v4_do_rcv
				     tcp_rcv_state_process // Complete the three-way handshake
													// missing parent->sk_data_ready(parent);


