Return-Path: <netdev+bounces-169407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40895A43BD8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E90E3A3443
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565431FDE18;
	Tue, 25 Feb 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBWuya4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E931C8625
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479600; cv=none; b=PRhRs2FTrEz8Z9U9ubFvRYOEk4iI9ZgunQwiQSQkhyoMO8dPTqKY7eO/CnGAVLnHQjVroGOf0B0duz7T1LYqozfpjV0gX5RPGnPA/KLZwhCQrN3ZW2T3NL/wZH59iaz5fnumLLW/yeD2c6+nAV6t3pDuNQ4nfZVUgbIGcZcQ7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479600; c=relaxed/simple;
	bh=IMb0lgRZBmt/2/fyUGzqkBk2C1Qn5EpyV/f1+nCvmuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahbLMHd1eqFr384/tePXQ8nLdcZRAqI3TmfbciCqEWQgw7tOKAIismMyc/OPjbbMEQEuekExDVtqkfpruDKMGGIyRG50PuaPidrO9sNYc/AI9eRgOKKUmF5iqdVG/Rr3I5LlN520HaceBGEfqT1vrwXDoAUxb9CQto2LOgFNpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBWuya4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C445C4CEDD;
	Tue, 25 Feb 2025 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740479599;
	bh=IMb0lgRZBmt/2/fyUGzqkBk2C1Qn5EpyV/f1+nCvmuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uBWuya4Gh7ILmJA2bA8jlRwGXTIAF1zcrCe7L4rkVf4qTMhJVwbP8OS8vkzupSlea
	 5IoIXeB+xKPGgxwS9jMZdaSAXLAUhiQ9ZqyluwQ2/pw5r3VrwTaGYTAdhKRMd2qGs0
	 gtTstV+bcIw/NV1mx9dWLJUObkNeFVPERhkir5XF0MfXKcWvrAp9vkKnGCzCzK7R2R
	 COCI+rTvQdKKzp9mGQqN4kjKmh8NMcmtwtUlcnamSK/y2idy4zMjlmV6xDRByZDhIY
	 hDMJCG0UNONj5poXEbDUw7sqMKCRIM8ZnM1RDQSQKkqJKMjRYBy/ot/X6WRihF9Iw3
	 FWP8clvoH9dqQ==
Message-ID: <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org>
Date: Tue, 25 Feb 2025 11:33:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
Content-Language: en-GB
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/02/2025 11:21, Eric Dumazet wrote:
> On Tue, Feb 25, 2025 at 11:19 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Eric,
>>
>> On 25/02/2025 11:11, Eric Dumazet wrote:
>>> On Tue, Feb 25, 2025 at 11:09 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>
>>>> Hi Paolo, Eric,
>>>>
>>>> On 25/02/2025 10:59, Paolo Abeni wrote:
>>>>> On 2/24/25 12:06 PM, Eric Dumazet wrote:
>>>>>> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
>>>>>> for flows using TCP TS option (RFC 7323)
>>>>>>
>>>>>> As hinted by an old comment in tcp_check_req(),
>>>>>> we can check the TSecr value in the incoming packet corresponds
>>>>>> to one of the SYNACK TSval values we have sent.
>>>>>>
>>>>>> In this patch, I record the oldest and most recent values
>>>>>> that SYNACK packets have used.
>>>>>>
>>>>>> Send a challenge ACK if we receive a TSecr outside
>>>>>> of this range, and increase a new SNMP counter.
>>>>>>
>>>>>> nstat -az | grep TcpExtTSECR_Rejected
>>>>>> TcpExtTSECR_Rejected            0                  0.0
>>>>
>>>> (...)
>>>>
>>>>> It looks like this change causes mptcp self-test failures:
>>>>>
>>>>> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-join-sh/stdout
>>>>>
>>>>> ipv6 subflows creation fails due to the added check:
>>>>>
>>>>> # TcpExtTSECR_Rejected            3                  0.0
>>>>
>>>> You have been faster to report the issue :-)
>>>>
>>>>> (for unknown reasons the ipv4 variant of the test is successful)
>>>>
>>>> Please note that it is not the first time the MPTCP test suite caught
>>>> issues with the IPv6 stack. It is likely possible the IPv6 stack is less
>>>> covered than the v4 one in the net selftests. (Even if I guess here the
>>>> issue is only on MPTCP side.)
>>>
>>>
>>> subflow_prep_synack() does :
>>>
>>>  /* clear tstamp_ok, as needed depending on cookie */
>>> if (foc && foc->len > -1)
>>>      ireq->tstamp_ok = 0;
>>>
>>> I will double check fastopen code then.
>>
>> Fastopen is not used in the failing tests. To be honest, it is not clear
>> to me why only the two tests I mentioned are failing, they are many
>> other tests using IPv6 in the MP_JOIN.
> 
> Yet, clearing tstamp_ok might be key here.
> 
> Apparently tcp_check_req() can get a non zero tmp_opt.rcv_tsecr even
> if tstamp_ok has been cleared at SYNACK generation.

Good point. But in the tests, it is not suppose to clear the timestamps.

(Of course, when I take a capture, I cannot reproduce the issue :) )

> 
> I would test :
> 
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index a87ab5c693b524aa6a324afe5bf5ff0498e528cc..0ed27f5c923edafdf48919600491eb1cb50bc913
> 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -674,7 +674,8 @@ struct sock *tcp_check_req(struct sock *sk, struct
> sk_buff *skb,
>                 if (tmp_opt.saw_tstamp) {
>                         tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
>                         if (tmp_opt.rcv_tsecr) {
> -                               tsecr_reject = !between(tmp_opt.rcv_tsecr,
> +                               if (inet_rsk(req)->tstamp_ok)
> +                                       tsecr_reject =
> !between(tmp_opt.rcv_tsecr,
> 
> tcp_rsk(req)->snt_tsval_first,
> 
> READ_ONCE(tcp_rsk(req)->snt_tsval_last));
>                                 tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
Thank you for the suggestion. It doesn't look to be that, I can still
reproduce the issue.

If I print the different TS (rcv, snt first, snt last) when tsecr_reject
is set, I get this:

[  227.984292] mattt: 2776726299 2776727335 2776727335
[  227.984684] mattt: 2776726299 2776727335 2776727335
[  227.984771] mattt: 3603918977 3603920020 3603920020
[  227.984896] mattt: 3603918977 3603920020 3603920020
[  230.031921] mattt: 3603918977 3603920020 3603922068
[  230.032283] mattt: 2776726299 2776727335 2776729383
[  230.032554] mattt: 2776729384 2776727335 2776729383
      ack rx                [FAIL] got 0 JOIN[s] ack rx expected 2

So not 0 or uninit values.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


