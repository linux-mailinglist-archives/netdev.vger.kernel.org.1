Return-Path: <netdev+bounces-169531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B21A44716
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8286319C10FF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291F15990C;
	Tue, 25 Feb 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/ZP9X5t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E92F2F
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502578; cv=none; b=mKn6Hpmg5Y+wZXwGKvpwrpj3iVNl3YkckAfCtliVKFEzh8lMX9nt3BCwmH0RC0rEh4DN4AOFWVmaA9rGR3E7VQTZCjWJVpytIgfYrCzgiBzyd+eARcM6H7hwh+U7yShvG9P7r0TOIN7k4OvF3FbxyqdySeSWOvV5ZdUX1T0bChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502578; c=relaxed/simple;
	bh=1OJOoPI5qtFJXpM87YzISjpXcQNxedDIKGa1xAyMAI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViaBHhtNrgFyap6s2kb6ufa+6/HeIFIE/J9TWLPC0gUtcWrQcuHoWMBD6cCT97zSTOMd5BxOXVHP8cC6rvOrkUAhkrBbr/AzQKGNnQ06ytosqXtfShRTw0XJ5mO1cFvW2ahGe/qe3LD9XjCV1Byt41VbwwmQL5hf4LvRhApKum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/ZP9X5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5E2C4CEDD;
	Tue, 25 Feb 2025 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740502577;
	bh=1OJOoPI5qtFJXpM87YzISjpXcQNxedDIKGa1xAyMAI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i/ZP9X5tCJYBiH3RIi7IghhvoeYXvQeDXB9QSwjRcvQFg60D3e978Xgd7XDEulEPX
	 kLr3zwR5pjT2VI/1FKdJ8A6dj8YwF0SsdhJ/lPR5L5iVLhisBC4dp/NDT/OZAW2C/W
	 e1abcl8ZxvTouhVXin/ZDILmZTRthUTxqsAoLeZ6YwKIr8NvRoP6+jmrrg1Atr6yN2
	 elR+ga/ElQLpA6xknULB8TmdnsfozMkW0oVHywIvorwZR0RXZwl0TyfFPRe+AyVvE5
	 ovWecvKh7i9X9UaoyknWuTkz2L3BT0RgOCER80vkk+USVlLTddzJJinq0zkJVIQe87
	 2aFFMCNQaTRWw==
Message-ID: <f970e46e-7153-4000-beef-f2d621998a8e@kernel.org>
Date: Tue, 25 Feb 2025 17:56:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Jakub Kicinski <kuba@kernel.org>, Yong-Hao Zou <yonghaoz1994@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 Neal Cardwell <ncardwell@google.com>
References: <20250224110654.707639-1-edumazet@google.com>
 <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org>
 <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
 <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org>
 <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
 <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org>
 <CANn89iLH_SgpWgAXvDjRbpFtVjWS-yLSiX0FbCweWjAJgzaASg@mail.gmail.com>
 <CANn89i+Zs2bLC7h2N5v15Xh=aTWdoa3v2d_A-EvRirsnFEPgwQ@mail.gmail.com>
 <CANn89iLf5hOnT=T+a9+msJ7=atWMMZQ+3syG75-8Nih8_MwHmw@mail.gmail.com>
 <8beaf62e-6257-452d-904a-fec6b21c891e@kernel.org>
 <CANn89i+3M1bJf=gXMH1zK3LiR-=XMRPe+qR8HNu94o2Xzm4vQQ@mail.gmail.com>
Content-Language: en-GB
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
In-Reply-To: <CANn89i+3M1bJf=gXMH1zK3LiR-=XMRPe+qR8HNu94o2Xzm4vQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 25/02/2025 11:51, Eric Dumazet wrote:
> On Tue, Feb 25, 2025 at 11:48 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> On 25/02/2025 11:42, Eric Dumazet wrote:
>>> On Tue, Feb 25, 2025 at 11:39 AM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>
>>>>
>>>> Yes, this would be it :
>>>>
>>>> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
>>>> index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..3555567ba4fb1ccd5c5921e39d11ff08f1d0cafd
>>>> 100644
>>>> --- a/net/ipv4/tcp_timer.c
>>>> +++ b/net/ipv4/tcp_timer.c
>>>> @@ -477,8 +477,8 @@ static void tcp_fastopen_synack_timer(struct sock
>>>> *sk, struct request_sock *req)
>>>>          * regular retransmit because if the child socket has been accepted
>>>>          * it's not good to give up too easily.
>>>>          */
>>>> -       inet_rtx_syn_ack(sk, req);
>>>>         req->num_timeout++;
>>>> +       inet_rtx_syn_ack(sk, req);
>>>>         tcp_update_rto_stats(sk);
>>>>         if (!tp->retrans_stamp)
>>>>                 tp->retrans_stamp = tcp_time_stamp_ts(tp);
>>>
>>> Obviously, I need to refine the patch and send a V2 later.
>>
>> Sorry, I still have the issue with this modification. I also checked
>> with the previous patch, just to be sure, but the problem is still there
>> as well.
> 
> I said "req->num_timeout" is not updated where I thought it was.

I think that in case of SYN+ACK retransmission, req->num_timeout is
incremented after tcp_synack_options():

  reqsk_timer_handler()
  --> inet_rtx_syn_ack()
    --> tcp_rtx_synack()
      --> tcp_v6_send_synack()
        --> tcp_make_synack()
          --> tcp_synack_options()
  then: req->num_timeout++

> Look at all the places were req->num_timeout or req->num_retrans are
> set/changed.... this will give you some indications.

I'm probably missing something obvious, but if the goal is to set
snt_tsval_first only the first time, why can we not simply set

  tcp_rsk(req)->snt_tsval_first = 0;

in tcp_conn_request(), and only set it to tsval in tcp_synack_options()
when it is 0? Something like that:


> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 217a8747a79b..26b3daa5efd2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7249,6 +7249,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>         tcp_rsk(req)->af_specific = af_ops;
>         tcp_rsk(req)->ts_off = 0;
>         tcp_rsk(req)->req_usec_ts = false;
> +       tcp_rsk(req)->snt_tsval_first = 0;
>  #if IS_ENABLED(CONFIG_MPTCP)
>         tcp_rsk(req)->is_mptcp = 0;
>  #endif
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 485ca131091e..020c624532d7 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -943,7 +943,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
>                 opts->options |= OPTION_TS;
>                 opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
>                               tcp_rsk(req)->ts_off;
> -               if (!req->num_timeout)
> +               if (!tcp_rsk(req)->snt_tsval_first)
>                         tcp_rsk(req)->snt_tsval_first = opts->tsval;
>                 WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
>                 opts->tsecr = READ_ONCE(req->ts_recent)


Or is the goal to update this field as long as the timeout didn't fire?
In this case maybe req->num_timeout should be updated before calling
inet_rtx_syn_ack() in reqsk_timer_handler(), no?

> Do not worry, I will make sure V2 is fine.

I don't doubt about that, thank you! :)

>> (In the v2, do you mind also removing the underscore from the MIB entry
>> name (TcpExtTSECR_Rejected) please? It looks like that's the only MIB
>> entry with an underscore.)
> 
> ok

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


