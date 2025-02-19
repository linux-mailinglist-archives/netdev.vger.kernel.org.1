Return-Path: <netdev+bounces-167571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0265A3AF4D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C2A3A7F3A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A71145A18;
	Wed, 19 Feb 2025 02:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5B3596A;
	Wed, 19 Feb 2025 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930966; cv=none; b=cqXbHG/hEBG6pgN4KLt2aBlunW1xV6vvfdb06EZeqEsLFGnNZu7qh0u+58GVaUC6khSy0lyQ79ipbMowcG/Gnb2y2ik5DmQKTgJ494kSSnQRgrXJCAhk5WQJWDc43YOcSeRpCqyd6PwGEn0IP5TLelayMGG/z/VMkBt7MGAU2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930966; c=relaxed/simple;
	bh=f70mMRmx3/vnO150P7c2GwfoIWmSw9+OJsXal40irDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EmpHGAwucanj7gfYn+T/UaH+pME7IRXbaaa6ztDvBLAKTs7Y4tYy3lOCOoNDL3kYeRijGnzpuzECi+1SF/BEOAT8EKCLgZ0WVXWEtEESaaF31xzaF9/yBf9HpyiBPWvzQ1BIkiqrUk4N4eOuIG6WHa9zUYTVVoGen3rdU3eJZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YyKWH71D1z22wRK;
	Wed, 19 Feb 2025 10:06:19 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 02D3A180044;
	Wed, 19 Feb 2025 10:09:20 +0800 (CST)
Received: from kwepemn100006.china.huawei.com (7.202.194.109) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Feb 2025 10:09:19 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemn100006.china.huawei.com (7.202.194.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 10:09:18 +0800
Message-ID: <a3a64b5f-0c58-4e6b-80ec-13d629371955@huawei.com>
Date: Wed, 19 Feb 2025 10:09:17 +0800
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
CC: <edumazet@google.com>, <ncardwell@google.com>, <kuniyu@amazon.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250218105824.34511-1-wanghai38@huawei.com>
 <CAL+tcoCZQZWdTBNM5o2PEpzEnmgfZFFps1WuB9D75p2=Gkbf2Q@mail.gmail.com>
Content-Language: en-US
From: Wang Hai <wanghai38@huawei.com>
In-Reply-To: <CAL+tcoCZQZWdTBNM5o2PEpzEnmgfZFFps1WuB9D75p2=Gkbf2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100006.china.huawei.com (7.202.194.109)



On 2025/2/18 20:02, Jason Xing wrote:
> Hi Wang,
> 
> On Tue, Feb 18, 2025 at 7:02 PM Wang Hai <wanghai38@huawei.com> wrote:
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
> 
> It's known that it's possible to receive two packets in two different
> cpus like this case nearly at the same time. I'm curious if the socket
> was running on the loopback?
> 
Hi Jason,

Yeah, it's running in loopback.
> Even if the above check that you commented in tcp_paws_check() fails,
> how about the rest of the checks in tcp_validate_incoming()? 

The skb from cpu1 is a valid skb, so it should have passed the
tcp_validate_incoming check, but the current concurrency issue
prevented it from passing the check.

5951 static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
5952                                   const struct tcphdr *th, int 
syn_inerr)
5953 {
5954         struct tcp_sock *tp = tcp_sk(sk);
5955         SKB_DR(reason);
5956
5957         /* RFC1323: H1. Apply PAWS check first. */
5958         if (!tcp_fast_parse_options(sock_net(sk), skb, th, tp) ||
5959             !tp->rx_opt.saw_tstamp ||
5960             tcp_paws_check(&tp->rx_opt, TCP_PAWS_WINDOW)) // failed
5961                 goto step1;
5962
5963         reason = tcp_disordered_ack_check(sk, skb);
5964         if (!reason) // failed
5965                 goto step1;
5966         /* Reset is accepted even if it did not pass PAWS. */
5967         if (th->rst) // failed
5968                 goto step1;
5969         if (unlikely(th->syn)) // failed
5970                 goto syn_challenge;
5971
5972         /* Old ACK are common, increment PAWS_OLD_ACK
5973          * and do not send a dupack.
5974          */
5975         if (reason == SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK) {
5976                 NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWS_OLD_ACK);
5977                 goto discard;
5978         }
5979         NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
5980         if (!tcp_oow_rate_limited(sock_net(sk), skb,
5981                                   LINUX_MIB_TCPACKSKIPPEDPAWS,
5982                                   &tp->last_oow_ack_time))
5983                 tcp_send_dupack(sk, skb);
5984         goto discard; // Drop the skb from here.
> test, I doubt if really that check failed which finally caused the skb
> from CPU2 to be discarded. Let me put it this way, is the paws_win
> check the root cause? What is the drop reason for
> tcp_validate_incoming()?
> 
The values of ts_recent and rcv_tsval are compared in tcp_paws_check,
where ts_recent comes from req->ts_recent = t2 and rcv_tsval is the
current cpu1 skb time. ts_recent - rcv_tsval may be greater than 1
and here will fail here. Tcp_paws_check fails causing 
tcp_validate_incoming to fail too.

> Thanks,
> Jason
> 
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
>>
>>   listen_overflow:
>> --
>> 2.17.1
>>
>>


