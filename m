Return-Path: <netdev+bounces-111888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF29933F4D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F56284C03
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFE181CF9;
	Wed, 17 Jul 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o43QFE8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81548181CEE;
	Wed, 17 Jul 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229012; cv=none; b=pAuple5TMhnfY/vE/gPpCMLFN7U/r46YkEp0PDhuT45Mp3N6YLd1+7jzsj9liEtACnb8oyRZf5hjtk3R0xv8vsXhS4LKWEv7LhDpplOy2GOrYAQeEs/gNyGdceJgwgHFMZAt7iZjt7AQ1tv2qw9Sz17j9yMKjZhz6c5hLJ5uu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229012; c=relaxed/simple;
	bh=zQiRJOqalHUnatNyl71T2glIefnb7xlR1qihZel3g3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXt5zIO2M+eYFGkAhsh3uiOqz6cdZLtxRdtWpVXWoTlvaR17nYUbdDVAOw/XqxD+XMleI+ULlHQHpz5wnQU/urBQ/esBgzmn7aEDR8w5yTdDZTabkV/qg7Wx6d0ly0YvR9Po/nbOVQNCQEchAIJIJWYgmHJYUqyyoe8fhTzsuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o43QFE8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A74C4AF0B;
	Wed, 17 Jul 2024 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721229012;
	bh=zQiRJOqalHUnatNyl71T2glIefnb7xlR1qihZel3g3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o43QFE8vVgEQ3sQayaBMwsmYEo+yTxpThLWajQQysalzEbY82XM9zyj2UVLWcy0DI
	 sDWNcU6Pev2zLkwGq4SyN/XIkyWJOBW6Bojgxykm24qVPd7s11pLUxcBOfrZqIiu4g
	 9iroMDIh1QDwVJY2IwvB1+hpRj05jz5Hrz87Mtt//S14JDiX1ESR/sg26cPMnz+6OC
	 I72kaO8kMlfD9H/OsGPKiLxVIqeA/ee9PyF48JlBXUbJ8NkQmtor8nT0O7CPkC7RmY
	 GRXeiUnO5rHuG6cyAJsQ5XcggNJXYYSao5mziJ8RwOnk0zFniTHPWuFsuHIFram92a
	 5uA9Ny5KWJxUQ==
Message-ID: <310de142-e263-4bcd-b499-69e0640de51e@kernel.org>
Date: Wed, 17 Jul 2024 17:09:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] tcp: process the 3rd ACK with sk_socket for for
 TFO/MPTCP
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
 <CANn89iKrHnzuHpRn0fi6+2WB_wxi5r-HpZ2jrkhrZEPyhBe0HQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iKrHnzuHpRn0fi6+2WB_wxi5r-HpZ2jrkhrZEPyhBe0HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 17/07/2024 16:57, Eric Dumazet wrote:
> On Tue, Jul 16, 2024 at 12:43 PM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
>> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
>> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
>> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
>> had an impact on TFO and MPTCP.
>>
>> I started to look at the impact on MPTCP, because the MPTCP CI found
>> some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggested
>> me to look at the impact on TFO with "plain" TCP.
>>
>> For MPTCP, when receiving the 3rd ACK of a request adding a new path
>> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
>> has been created when the MPTCP connection got established before with
>> the first path. The newly added 'goto' will then skip the processing of
>> the segment text (step 7) and not go through tcp_data_queue() where the
>> MPTCP options are validated, and some actions are triggered, e.g.
>> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
>> running a packetdrill test [3] establishing a second subflow.
>>
>> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
>> delayed. Still, we don't want to have this behaviour as it delays the
>> switch to the fully established mode, and invalid MPTCP options in this
>> 3rd ACK will not be caught any more. This modification also affects the
>> MPTCP + TFO feature as well, and being the reason why the selftests
>> started to be unstable the last few days [4].
>>
>> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
>> passing: if the 3rd ACK contains data, these data would no longer be
>> processed, and thus not ACKed.
>>
>> Note that for MPTCP, in case of simultaneous connect(), a fallback to
>> TCP will be done, which seems fine:
>>
>>   `../common/defaults.sh`
>>
>>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
>>   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
>>
>>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
>>
>>   +0 write(3, ..., 100) = 100
>>   +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop, sack 0:1>
>>   +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/9936227696 [1]
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
>> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/syscalls/accept.pkt#L28 [3]
>> Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh [4]
>> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/server/basic-cookie-not-reqd.pkt#L21 [5]
>> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - We could also drop this 'goto consume', and send the unnecessary ACK
>>    in this simultaneous connect case, which doesn't seem to be a "real"
>>    case, more something for fuzzers.
>>  - When sending this patch, the 'Fixes' commit is only in net-next, this
>>    patch is then on top of net-next. But because net-next will be merged
>>    into -net soon -- judging by the PR that has been sent to Linus a few
>>    hours ago -- the 'net' prefix is then used.
>> ---
>>  net/ipv4/tcp_input.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index ff9ab3d01ced..a89b3ee57d8c 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -6820,7 +6820,13 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>>
>> -               if (sk->sk_socket)
>> +               /* In simult-connect cases, sk_socket will be assigned. But also
>> +                * with TFO and MPTCP (MPJ) while they required further
>> +                * processing later in tcp_data_queue().
>> +                */
>> +               if (sk->sk_socket &&
>> +                   TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq &&
>> +                   !sk_is_mptcp(sk))
>>                         goto consume;
>>                 break;
>>
> 
> Hi Matthieu
> 
> I had no time yet to run all our packetdrill tests with Kuniyuki patch
> because of the ongoing netdev conference.
> 
> Is it ok for you if we hold your patch for about 5 days ?

Sure, no problem, take your time!

> I would like to make sure we did not miss anything else.

I understand!

> I am CCing Neal, perhaps he can help to expedite the testing part
> while I am busy.

Thank you, no urgency here.

If it's OK with you, I can send a v2 using Kuniyuki's suggestion --
simply limiting the bypass to SYN+ACK only -- because it is simpler and
ready to be sent, but also to please the CI because my v1 was rejected
by the CI because I sent it just before the sync with Linus tree. We can
choose later to pick the v2, the previous one, or a future one.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


