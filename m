Return-Path: <netdev+bounces-112661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE5893A793
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660371F23333
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807513DBA0;
	Tue, 23 Jul 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDA2qLXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B213D8A6;
	Tue, 23 Jul 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761788; cv=none; b=t2VVP/mQGELxn9Pk1ANK+AZ002mFPA9wmd5eqWJZR2KWaXhlb8+HJ/uONK2P2BVeuafY5814trndFHP7V9ath5rd/JuabX6jANzD+ubKmjPB1yYTAtNHDSFnE2y2C+rmCGGabQe28bifJcf9vSY7B9m6IEwjcozSb86EbqaF+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761788; c=relaxed/simple;
	bh=MGnSDjAbQjtYumR66VcCkxG3xH/gtKxn9MINFf+bnTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/IJkLVVz3byiAkDFEha3OxVt9lYq6VoqlWty64Z9IKjNHBjWQ43pBkbD/y0Rwf5mb6BlbejIl//0dBJ+MvyzLqFKUsg1rVUXaMJyaMCQNn6dYwY5x4dEEpsT+rgcfzPmT8RVhuZ7GYHzc/bk8mbcOE1Hm9D0lymGBtG3jblt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDA2qLXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2FFC4AF09;
	Tue, 23 Jul 2024 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721761788;
	bh=MGnSDjAbQjtYumR66VcCkxG3xH/gtKxn9MINFf+bnTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FDA2qLXpx/Fpoh0TELKflobTExPn9GSnRvcI9j+nIP83MuNWbyU2N+hie0EsqkF4n
	 Zes0w1fJhbO5kLoqrs3C50yiOwXzB6R4n5XrYyEli3JhYS2iHu2BusqNRKHD/zZXyY
	 Mn16EboPrGcBLK9CNPoCad6iSlOLJE8YDtQXv4kj+vR6xl3TLG9k0iMjqwkhcO+JlZ
	 WPz1YUzMc1Z75wcG/OV31HX+cCNsmdWGyw9TnwpAulQ7zrLZ1x8Oah7aT0Blt2Gawx
	 YVD5ZrJKI8awHhm4XpgL1dvoP7WRUgED67Guz1XN6qNjszuYcVAndvQIj9B1roPhgp
	 DWJKxGXJYa7cw==
Message-ID: <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
Date: Tue, 23 Jul 2024 21:09:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for
 TFO/MPTCP
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Neal Cardwell <ncardwell@google.com>
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
 <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org>
 <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
 <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org>
 <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 23/07/2024 18:42, Eric Dumazet wrote:
> On Tue, Jul 23, 2024 at 6:08 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Eric,
>>
>> On 23/07/2024 17:38, Eric Dumazet wrote:
>>> On Tue, Jul 23, 2024 at 4:58 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>
>>>> Hi Eric,
>>>>
>>>> +cc Neal
>>>> -cc Jerry (NoSuchUser)
>>>>
>>>> On 23/07/2024 16:37, Eric Dumazet wrote:
>>>>> On Thu, Jul 18, 2024 at 12:34 PM Matthieu Baerts (NGI0)
>>>>> <matttbe@kernel.org> wrote:
>>>>>>
>>>>>> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
>>>>>> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
>>>>>> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
>>>>>> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
>>>>>> had an impact on TFO and MPTCP.
>>>>>>
>>>>>> I started to look at the impact on MPTCP, because the MPTCP CI found
>>>>>> some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggested
>>>>>> me to look at the impact on TFO with "plain" TCP.
>>>>>>
>>>>>> For MPTCP, when receiving the 3rd ACK of a request adding a new path
>>>>>> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
>>>>>> has been created when the MPTCP connection got established before with
>>>>>> the first path. The newly added 'goto' will then skip the processing of
>>>>>> the segment text (step 7) and not go through tcp_data_queue() where the
>>>>>> MPTCP options are validated, and some actions are triggered, e.g.
>>>>>> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
>>>>>> running a packetdrill test [3] establishing a second subflow.
>>>>>>
>>>>>> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
>>>>>> delayed. Still, we don't want to have this behaviour as it delays the
>>>>>> switch to the fully established mode, and invalid MPTCP options in this
>>>>>> 3rd ACK will not be caught any more. This modification also affects the
>>>>>> MPTCP + TFO feature as well, and being the reason why the selftests
>>>>>> started to be unstable the last few days [4].
>>>>>>
>>>>>> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
>>>>>> passing: if the 3rd ACK contains data, and the connection is accept()ed
>>>>>> before receiving them, these data would no longer be processed, and thus
>>>>>> not ACKed.
>>>>>>
>>>>>> One last thing about MPTCP, in case of simultaneous connect(), a
>>>>>> fallback to TCP will be done, which seems fine:
>>>>>>
>>>>>>   `../common/defaults.sh`
>>>>>>
>>>>>>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
>>>>>>   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
>>>>>>
>>>>>>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>>>>>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>>>>>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
>>>>>>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
>>>>>>
>>>>>>   +0 write(3, ..., 100) = 100
>>>>>>   +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop, sack 0:1>
>>>>>>   +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
>>>>>>
>>>>>> Simultaneous SYN-data crossing is also not supported by TFO, see [6].
>>>>>>
>>>>>> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/9936227696 [1]
>>>>>> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
>>>>>> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/syscalls/accept.pkt#L28 [3]
>>>>>> Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh [4]
>>>>>> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/server/basic-cookie-not-reqd.pkt#L21 [5]
>>>>>> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fastopen/client/simultaneous-fast-open.pkt [6]
>>>>>> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
>>>>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>>> ---
>>>>>> Notes:
>>>>>>  - We could also drop this 'goto consume', and send the unnecessary ACK
>>>>>>    in this simultaneous connect case, which doesn't seem to be a "real"
>>>>>>    case, more something for fuzzers. But that's not what the RFC 9293
>>>>>>    recommends to do.
>>>>>>  - v2:
>>>>>>    - Check if the SYN bit is set instead of looking for TFO and MPTCP
>>>>>>      specific attributes, as suggested by Kuniyuki.
>>>>>>    - Updated the comment above
>>>>>>    - Please note that the v2 has been sent mainly to satisfy the CI (to
>>>>>>      be able to catch new bugs with MPTCP), and because the suggestion
>>>>>>      from Kuniyuki looks better. It has not been sent to urge TCP
>>>>>>      maintainers to review it quicker than it should, please take your
>>>>>>      time and enjoy netdev.conf :)
>>>>>> ---
>>>>>>  net/ipv4/tcp_input.c | 7 ++++++-
>>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>>> index ff9ab3d01ced..bfe1bc69dc3e 100644
>>>>>> --- a/net/ipv4/tcp_input.c
>>>>>> +++ b/net/ipv4/tcp_input.c
>>>>>> @@ -6820,7 +6820,12 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>>>>>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>>>>>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>>>>>>
>>>>>> -               if (sk->sk_socket)
>>>>>> +               /* For crossed SYN cases, not to send an unnecessary ACK.
>>>>>> +                * Note that sk->sk_socket can be assigned in other cases, e.g.
>>>>>> +                * with TFO (if accept()'ed before the 3rd ACK) and MPTCP (MPJ:
>>>>>> +                * sk_socket is the parent MPTCP sock).
>>>>>> +                */
>>>>>> +               if (sk->sk_socket && th->syn)
>>>>>>                         goto consume;
>>>>>
>>>>> I think we should simply remove this part completely, because we
>>>>> should send an ack anyway.
>>>>
>>>> Thank you for having looked, and ran the full packetdrill test suite!
>>>>
>>>>>
>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>> index ff9ab3d01ced89570903d3a9f649a637c5e07a90..91357d4713182078debd746a224046cba80ea3ce
>>>>> 100644
>>>>> --- a/net/ipv4/tcp_input.c
>>>>> +++ b/net/ipv4/tcp_input.c
>>>>> @@ -6820,8 +6820,6 @@ tcp_rcv_state_process(struct sock *sk, struct
>>>>> sk_buff *skb)
>>>>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>>>>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>>>>>
>>>>> -               if (sk->sk_socket)
>>>>> -                       goto consume;
>>>>>                 break;
>>>>>
>>>>>         case TCP_FIN_WAIT1: {
>>>>>
>>>>>
>>>>> I have a failing packetdrill test after  Kuniyuki  patch :
>>>>>
>>>>>
>>>>>
>>>>> //
>>>>> // Test the simultaneous open scenario that both end sends
>>>>> // SYN/data. Although we don't support that the connection should
>>>>> // still be established.
>>>>> //
>>>>> `../../common/defaults.sh
>>>>>  ../../common/set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
>>>>>
>>>>> // Cache warmup: send a Fast Open cookie request
>>>>>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
>>>>>    +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
>>>>>    +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) = -1 EINPROGRESS
>>>>> (Operation is now in progress)
>>>>>    +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
>>>>>  +.01 < S. 123:123(0) ack 1 win 14600 <mss
>>>>> 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
>>>>>    +0 > . 1:1(0) ack 1
>>>>>  +.01 close(3) = 0
>>>>>    +0 > F. 1:1(0) ack 1
>>>>>  +.01 < F. 1:1(0) ack 2 win 92
>>>>>    +0 > .  2:2(0) ack 2
>>>>>
>>>>>
>>>>> //
>>>>> // Test: simulatenous fast open
>>>>> //
>>>>>  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
>>>>>    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
>>>>>    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
>>>>>    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
>>>>> abcd1234,nop,nop>
>>>>> // Simul. SYN-data crossing: we don't support that yet so ack only remote ISN
>>>>> +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
>>>>> 6,FO 87654321,nop,nop>
>>>>>    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
>>>>>
>>>>> // SYN data is never retried.
>>>>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
>>>>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
>>>>>    +0 > . 1001:1001(0) ack 1
>>>>
>>>> I recently sent a PR -- already applied -- to Neal to remove this line:
>>>>
>>>>   https://github.com/google/packetdrill/pull/86
>>>>
>>>> I thought it was the intension of Kuniyuki's patch not to send this ACK
>>>> in this case to follow the RFC 9293's recommendation. This TFO test
>>>> looks a bit similar to the example from Kuniyuki's patch:
>>>>
>>>>
>>>> --------------- 8< ---------------
>>>>  0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
>>>> +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
>>>>
>>>> +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
>>>> +0 < S  0:0(0) win 1000 <mss 1000>
>>>> +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscale 8>
>>>> +0 < S. 0:0(0) ack 1 win 1000
>>>>
>>>>   /* No ACK here */
>>>>
>>>> +0 write(3, ..., 100) = 100
>>>> +0 > P. 1:101(100) ack 1
>>>> --------------- 8< ---------------
>>>>
>>>>
>>>>
>>>> But maybe here that should be different for TFO?
>>>>
>>>> For my case with MPTCP (and TFO), it is fine to drop this 'goto consume'
>>>> but I don't know how "strict" we want to be regarding the RFC and this
>>>> marginal case.
>>>
>>> Problem of this 'goto consume' is that we are not properly sending a
>>> DUPACK in this case.
>>>
>>>  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
>>>    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
>>>    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) = 1000
>>>    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
>>> abcd1234,nop,nop>
>>> // Simul. SYN-data crossing: we don't support that yet so ack only remote ISN
>>> +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
>>> 6,FO 87654321,nop,nop>
>>>    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
>>>
>>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
>>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
>>>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
>>
>> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?
> 
> It is normal, because the SYN was already received/processed.
> 
> sack 0:1 represents this SYN sequence.

Thank you for your reply!

Maybe it is just me, but does it not look strange to have the SACK
covering a segment (0:1) that is before the ACK (1)?

'ack 1' and 'sack 0:1' seem to cover the same block, no?
Before Kuniyuki's patch, this 'sack 0:1' was not present.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


