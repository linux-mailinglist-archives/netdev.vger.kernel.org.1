Return-Path: <netdev+bounces-169397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EFA43B48
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB9189B61E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F592676CD;
	Tue, 25 Feb 2025 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAE+RX+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E752676C8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478763; cv=none; b=bKqg3su4n5L6ksSexEzsCXlOldnJ9xstM78cYRsPlFeY4F0J3nAxU2iwAPN7Rz6sEWXmapDt221cfdgmcCY2b4VFUzQToj41AtQ8NHEZ2i2hOSJ6kZmWREqnpG1REld2n5MzMCpVxyIDa+MHBm/nBcMYmn7iUwforMCjVi3BAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478763; c=relaxed/simple;
	bh=dKx9c1fbPPCeeEQdpe91fclm/bH75hSB9tiE4r9sZfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn6rPMpWIuZu8lRcUq2wLROYlV7KsviZJxFOWE6axoavg7Uk5GRras4jTCDlJ9tcn+xyyDjOAJyBCbAWKOTgCFL6g4QfXp1tperdHZmV9ssqG4s7/LSBfqe3M85/VWWI9UivBj3Kbz9tKn//rz80+cLy46B6XhAB4GpfZ0mh6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAE+RX+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F2BC4CEE2;
	Tue, 25 Feb 2025 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478762;
	bh=dKx9c1fbPPCeeEQdpe91fclm/bH75hSB9tiE4r9sZfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IAE+RX+xmazx7f1+clz2BvKwh46O+6NlI1MUp3apTom1bQetPV/fBknAwy2CsA94g
	 Tm97kIY0u/Xi+XMPIK5XXXlagvO2BLDUEaNelAuzl9fdi1NIaApXQN8LZLN8xbA3AP
	 Z4YOgP+hbHmDSYbhLpWUzuuIgCyl7UMHviSNF+BLnAm3vZVhktNqhnPoSANgnqZPQ5
	 d0aOh9dHc7bcogoPcArKq1NcAmNZNmWm5yQoSIrAet3qc1l37v7igCJc4oV8ArIbkF
	 pl32/JF14z1ZUsxul564b7gnWQq32fIs+X3pvlkT13YQ6iytxqeK/qxwSNJlEnitIX
	 YUEAgJu8XUAYw==
Message-ID: <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org>
Date: Tue, 25 Feb 2025 11:19:18 +0100
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
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 25/02/2025 11:11, Eric Dumazet wrote:
> On Tue, Feb 25, 2025 at 11:09 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Paolo, Eric,
>>
>> On 25/02/2025 10:59, Paolo Abeni wrote:
>>> On 2/24/25 12:06 PM, Eric Dumazet wrote:
>>>> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
>>>> for flows using TCP TS option (RFC 7323)
>>>>
>>>> As hinted by an old comment in tcp_check_req(),
>>>> we can check the TSecr value in the incoming packet corresponds
>>>> to one of the SYNACK TSval values we have sent.
>>>>
>>>> In this patch, I record the oldest and most recent values
>>>> that SYNACK packets have used.
>>>>
>>>> Send a challenge ACK if we receive a TSecr outside
>>>> of this range, and increase a new SNMP counter.
>>>>
>>>> nstat -az | grep TcpExtTSECR_Rejected
>>>> TcpExtTSECR_Rejected            0                  0.0
>>
>> (...)
>>
>>> It looks like this change causes mptcp self-test failures:
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-join-sh/stdout
>>>
>>> ipv6 subflows creation fails due to the added check:
>>>
>>> # TcpExtTSECR_Rejected            3                  0.0
>>
>> You have been faster to report the issue :-)
>>
>>> (for unknown reasons the ipv4 variant of the test is successful)
>>
>> Please note that it is not the first time the MPTCP test suite caught
>> issues with the IPv6 stack. It is likely possible the IPv6 stack is less
>> covered than the v4 one in the net selftests. (Even if I guess here the
>> issue is only on MPTCP side.)
> 
> 
> subflow_prep_synack() does :
> 
>  /* clear tstamp_ok, as needed depending on cookie */
> if (foc && foc->len > -1)
>      ireq->tstamp_ok = 0;
> 
> I will double check fastopen code then.

Fastopen is not used in the failing tests. To be honest, it is not clear
to me why only the two tests I mentioned are failing, they are many
other tests using IPv6 in the MP_JOIN.

  045 add multiple subflows IPv6
  064 simult IPv4 and IPv6 subflows, fullmesh 2x2

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


