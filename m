Return-Path: <netdev+bounces-111818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4793329F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 22:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F775283144
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C094D8DA;
	Tue, 16 Jul 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea7MVBHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4E41C7F
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160270; cv=none; b=Ijj/t+E4lYMCaEcjo9+F38NDi1D6H+ZFtaNGjbYnOVkC/IPMB7f7hZur/mP/ZdvMUq4A5nqEM1AY8wgDEP3Z88H2JAPfdNmNggUvkJmNoqr9iPBM345wmVDEj0TT7r2mZwk31/QBskHpQQczLbwUoXNRdYDppHmpUDPBWcxaD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160270; c=relaxed/simple;
	bh=gIdLRVCS90Nj+b8n0UNHsFDi5yREho6pUPn/HqxpXEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jq1dnqKJy8irIQ+J8BAmot0cU2pnbLS7bwvGi+h4wMspuzpb5UamqdSUm/ctj6ITBsiDLTwbOib0p+3OthQszBosVWR2iHYlbgOVbILblRenMuvt73hbXhsYCorGEJKBXulca1P/n76kLSn5BAdBIujeBFydD8t656aslNKBqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea7MVBHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF80CC4AF0D;
	Tue, 16 Jul 2024 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721160269;
	bh=gIdLRVCS90Nj+b8n0UNHsFDi5yREho6pUPn/HqxpXEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ea7MVBHGt1j4DMf1R172YSW8MgwTRVTeDd7RqNOfOX0LEyvYS7k+wrVMsnKrrlR5W
	 xQCnRKxcN+hWzdRFD7aTr/H+LkGaiCWUEzjXHJjs3iO7nb6c9tNFQHyVywUAQEccWW
	 fasf/KfOabrmLI51+nnqP+YOOmlGZQoRyGlYFyEVozJiB9zr0KB094+ZaUhduLWbyw
	 WUKYv7VkoeaQLvE9QCXaGOzWp5lxR0Au6O6rGswiZcxPlcQSJVfwpEvhii6a9souAy
	 Vh3vMeHbLbNa6T4FgjPC9ubkg2Qsih1UtHfeubswqDkuOr4fXhyVnvfTqzlKUOqtSJ
	 aIKSi3BHDCFcw==
Message-ID: <31eb13bf-7ea9-436f-92a9-a8745ed86f9e@kernel.org>
Date: Tue, 16 Jul 2024 22:04:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 net-next 1/2] tcp: Don't drop SYN+ACK for simultaneous
 connect().
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <19b76438-2fc8-4f2f-a0ae-c988f5b17e9f@kernel.org>
 <20240716192320.54815-1-kuniyu@amazon.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240716192320.54815-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

Thank you for your reply!

On 16/07/2024 21:23, Kuniyuki Iwashima wrote:
> Hi Matthieu,
> 
> From: Matthieu Baerts <matttbe@kernel.org>
> Date: Mon, 15 Jul 2024 17:58:49 +0200
>> Hi Kuniyuki,
>>
>> On 10/07/2024 19:12, Kuniyuki Iwashima wrote:
>>> RFC 9293 states that in the case of simultaneous connect(), the connection
>>> gets established when SYN+ACK is received. [0]
>>>
>>>       TCP Peer A                                       TCP Peer B
>>>
>>>   1.  CLOSED                                           CLOSED
>>>   2.  SYN-SENT     --> <SEQ=100><CTL=SYN>              ...
>>>   3.  SYN-RECEIVED <-- <SEQ=300><CTL=SYN>              <-- SYN-SENT
>>>   4.               ... <SEQ=100><CTL=SYN>              --> SYN-RECEIVED
>>>   5.  SYN-RECEIVED --> <SEQ=100><ACK=301><CTL=SYN,ACK> ...
>>>   6.  ESTABLISHED  <-- <SEQ=300><ACK=101><CTL=SYN,ACK> <-- SYN-RECEIVED
>>>   7.               ... <SEQ=100><ACK=301><CTL=SYN,ACK> --> ESTABLISHED
>>>
>>> However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such a
>>> SYN+ACK is dropped in tcp_validate_incoming() and responded with Challenge
>>> ACK.
>>>
>>> For example, the write() syscall in the following packetdrill script fails
>>> with -EAGAIN, and wrong SNMP stats get incremented.
>>>
>>>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
>>>   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
>>>
>>>   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
>>>   +0 < S  0:0(0) win 1000 <mss 1000>
>>>   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
>>>   +0 < S. 0:0(0) ack 1 win 1000
>>>
>>>   +0 write(3, ..., 100) = 100
>>>   +0 > P. 1:101(100) ack 1
>>>
>>>   --
>>>
>>>   # packetdrill cross-synack.pkt
>>>   cross-synack.pkt:13: runtime error in write call: Expected result 100 but got -1 with errno 11 (Resource temporarily unavailable)
>>>   # nstat
>>>   ...
>>>   TcpExtTCPChallengeACK           1                  0.0
>>>   TcpExtTCPSYNChallenge           1                  0.0
>>>
>>> The problem is that bpf_skops_established() is triggered by the Challenge
>>> ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
>>> check if the peer supports a TCP option that is expected to be exchanged
>>> in SYN and SYN+ACK.
>>>
>>> Let's accept a bare SYN+ACK for active-open TCP_SYN_RECV sockets to avoid
>>> such a situation.
>>>
>>> Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not to
>>> send an unnecessary ACK, but this could be a bit risky for net.git, so this
>>> targets for net-next.
>>>
>>> Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>
>> Thank you for having worked on this patch!
>>
>>> ---
>>>  net/ipv4/tcp_input.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index 47dacb575f74..1eddb6b9fb2a 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -5989,6 +5989,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>>>  	 * RFC 5961 4.2 : Send a challenge ack
>>>  	 */
>>>  	if (th->syn) {
>>> +		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
>>> +		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
>>> +		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
>>> +		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
>>> +			goto pass;
>>>  syn_challenge:
>>>  		if (syn_inerr)
>>>  			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
>>> @@ -5998,6 +6003,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>>>  		goto discard;
>>>  	}
>>>  
>>> +pass:
>>>  	bpf_skops_parse_hdr(sk, skb);
>>>  
>>>  	return true;
>>> @@ -6804,6 +6810,9 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>>>  		tcp_fast_path_on(tp);
>>>  		if (sk->sk_shutdown & SEND_SHUTDOWN)
>>>  			tcp_shutdown(sk, SEND_SHUTDOWN);
>>> +
>>> +		if (sk->sk_socket)
>>> +			goto consume;
>>
>> It looks like this modification changes the behaviour for MPTCP Join
>> requests for listening sockets: when receiving the 3rd ACK of a request
>> adding a new path (MP_JOIN), sk->sk_socket will be set, and point to the
>> MPTCP sock that has been created when the MPTCP connection got created
>> before with the first path.
> 
> Thanks for catching this!
> 
> I completely missed how MPTCP sets sk->sk_socket before the 3rd ACK is
> processed.

No problem. That's a shame there was not a clear error in the selftests :)

> I debugged a bit and confirmed mptcp_stream_accept() sets
> the inflight subflow's sk->sk_socket with newsk->sk_socket.

Yes, that's correct.

>> This new 'goto' here will then skip the
>> process of the segment text (step 7) and not go through tcp_data_queue()
>> where the MPTCP options are validated, and some actions are triggered,
>> e.g. sending the MPJ 4th ACK [1].
>>
>> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
>> delayed,
> 
> Yes, the test failure depends on timing.  I only reproduced it by running
> the test many times on non-kvm qemu.

Thank you for having checked!

>> but it looks like it affects the MPTFO feature as well --
>> probably in case of retransmissions I suppose -- and being the reason
>> why the selftests started to be unstable the last few days [2].
>>
>> [1] https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens
>> [2]
>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh
>>
>>
>> Looking at what this patch here is trying to fix, I wonder if it would
>> not be enough to apply this patch:
>>
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index ff9ab3d01ced..ff981d7776c3 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -6820,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>>>  
>>> -               if (sk->sk_socket)
>>> +               if (sk->sk_socket && !sk_is_mptcp(sk))
>>>                         goto consume;
>>>                 break;
>>>  
>>
>> But I still need to investigate how the issue that is being addressed by
>> your patch can be translated to the MPTCP case. I guess we could add
>> additional checks for MPTCP: new connection or additional path? etc. Or
>> maybe that's not needed.
> 
> My first intention was not to drop SYN+ACK in tcp_validate_incoming(),
> and the goto is added in v2, which is rather to be more compliant with
> RFC not to send an unnecessary ACK for simultaneous connect().
> 
> So, we could rewrite the condition as this,
> 
>   if (sk->sk_socket && !th->syn)

(Just to be sure, do you mean the opposite with th->syn?)

  if (sk->sk_socket && th->syn)
      goto consume;

That's a good idea!

I sent my patch a couple of minutes ago [1], then I saw your suggestion
here. It looks like it should work for the TFO case as well. Maybe your
suggestion is more generic and will cover more cases?

[1]
https://lore.kernel.org/all/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org/

> but I think your patch is better to give a hint that MPTCP has a
> different logic.

Because TFO has also a different logic, it might be good to have a clear
comment about that.

> Also, a similar check done before the goto, and this could be
> improved ?
> 
>   if (sk->sk_socket)
>     sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);

It is a bit late for me, but I think it can be kept as it is: for MPTCP,
it will not wake up the userspace as the subflow is managed by the
kernel. I would need to check if we could avoid that. Also, will this
wakeup not be useful for TFO?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


