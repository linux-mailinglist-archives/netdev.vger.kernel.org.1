Return-Path: <netdev+bounces-169390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09408A43ACC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885B91887790
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11872661B5;
	Tue, 25 Feb 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD7zgkkd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A8266190
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477669; cv=none; b=XVCUGsN3EnPuOAb+Zt1GqON0XI7ukicrGg/0w4/p7YJCVlaHUQC3Bk8juM0+9fQZ4qsHm5TSCmYzKAxkGDYxj5HmKLjQJQEHi7oko+1sXZFcok6BcHOLG8fISMBHnxTNCkl/s4l00jtQROYrJuw89py8RL6fBNxM0sgITv8wl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477669; c=relaxed/simple;
	bh=3bC23Lm0sU818T2eCu4YUuz5ydF3G+EgdBGxHisgwAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVPU4MzgXhtLQG4KxO8A+zPRdWNc/aiTCsh++auniatSJMlqjviQ32tWxpZ0bvQewf1DTVjyH0iJ8pSUbc6XQfBnNK2kq7NxO4e4U7RSZBJLko5WLHGqNcd5MscahJOkMFuXcHxmRcDwwFCyOE0vM0+ud7f5PUCpeGSgGc9l8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD7zgkkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA62BC4CEDD;
	Tue, 25 Feb 2025 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740477669;
	bh=3bC23Lm0sU818T2eCu4YUuz5ydF3G+EgdBGxHisgwAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SD7zgkkdS1JNr9J2V+IhVexeFdtxTbw6bpVWpAfojDG/+wM8LUP5kDK/We0nEby7Q
	 ByQdI0oels9P1w/tzgy6UMShhi7gj8VMyvJebr2LfP4javtJh/KQym1ShJjcsxzFRv
	 qpOGtROD+Lf1+DoY6GYrG+GfExm3dmWMKpGSf8SLRlkNA1PBjXfDtCJsf9J1To4Znd
	 fq4+JZ0JQLO0oL+s16MrgCqxGqhheNz120qCLlNwXWfi/qewS8kGXbc3eTjeCVoeqr
	 r0YtomSN5J9jkU/zrRD9Ip4/zschXSeBfMvGpY7vTIW1TxHl7SUKEgsZDxWLKyXUEL
	 ZHxUfEDbrWcrA==
Message-ID: <4bf331f1-123a-4290-868f-798c12a1f3f4@kernel.org>
Date: Tue, 25 Feb 2025 11:01:03 +0100
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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Yong-Hao Zou <yonghaoz1994@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
References: <20250224110654.707639-1-edumazet@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250224110654.707639-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 24/02/2025 12:06, Eric Dumazet wrote:
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
> 
> As hinted by an old comment in tcp_check_req(),
> we can check the TSecr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
> 
> In this patch, I record the oldest and most recent values
> that SYNACK packets have used.
> 
> Send a challenge ACK if we receive a TSecr outside
> of this range, and increase a new SNMP counter.

Thank you for this patch!

Sadly, it looks like it breaks MPTCP selftests, see [1] and [2]. When
there is a failure, we can see that the new counter is incremented [3]:

> # selftests: net/mptcp: mptcp_join.sh

(...)

> # 045 add multiple subflows IPv6
> #       currently established: 1            [ OK ]
> #       ack rx                              [FAIL] got 1 JOIN[s] ack rx expected 2
> # Server ns stats
> # TcpPassiveOpens                 2                  0.0
> # TcpAttemptFails                 1                  0.0
> # TcpInSegs                       51                 0.0
> # TcpOutSegs                      59                 0.0
> # TcpRetransSegs                  3                  0.0
> # TcpExtEmbryonicRsts             1                  0.0
> # TcpExtTW                        1                  0.0
> # TcpExtTSECR_Rejected            3                  0.0
> # TcpExtDelayedACKs               7                  0.0
> # TcpExtTCPPureAcks               19                 0.0
> # TcpExtTCPTimeouts               2                  0.0
> # TcpExtTCPSynRetrans             3                  0.0
> # TcpExtTCPOrigDataSent           24                 0.0
> # TcpExtTCPACKSkippedSynRecv      2                  0.0
> # TcpExtTCPDelivered              24                 0.0
> # MPTcpExtMPCapableSYNRX          1                  0.0
> # MPTcpExtMPCapableACKRX          1                  0.0
> # MPTcpExtMPJoinSynRx             2                  0.0
> # MPTcpExtMPJoinAckRx             1                  0.0
> # Client ns stats
> # TcpActiveOpens                  3                  0.0
> # TcpEstabResets                  1                  0.0
> # TcpInSegs                       59                 0.0
> # TcpOutSegs                      50                 0.0
> # TcpRetransSegs                  1                  0.0
> # TcpInErrs                       3                  0.0
> # TcpOutRsts                      1                  0.0
> # TcpExtTW                        2                  0.0
> # TcpExtDelayedACKs               1                  0.0
> # TcpExtTCPPureAcks               29                 0.0
> # TcpExtTCPTimeouts               1                  0.0
> # TcpExtTCPChallengeACK           2                  0.0
> # TcpExtTCPSYNChallenge           3                  0.0
> # TcpExtTCPSynRetrans             1                  0.0
> # TcpExtTCPOrigDataSent           24                 0.0
> # TcpExtTCPACKSkippedChallenge    1                  0.0
> # TcpExtTCPDelivered              27                 0.0
> # TcpExtTcpTimeoutRehash          1                  0.0
> # MPTcpExtMPCapableSYNTX          1                  0.0
> # MPTcpExtMPCapableSYNACKRX       1                  0.0
> # MPTcpExtMPJoinSynAckRx          2                  0.0
> # MPTcpExtMPJoinSynTx             2                  0.0
> # MPTcpExtMPRstTx                 1                  0.0
> # MPTcpExtRcvWndShared            2                  0.0
> #       join Rx                             [FAIL] see above
> #       join Tx                             [ OK ]
> #       currently established: 0            [ OK ]
(...)

> # 064 simult IPv4 and IPv6 subflows, fullmesh 2x2
> #       ack rx                              [FAIL] got 2 JOIN[s] ack rx expected 4
> # Server ns stats
> # TcpPassiveOpens                 3                  0.0
> # TcpAttemptFails                 2                  0.0
> # TcpInSegs                       77                 0.0
> # TcpOutSegs                      74                 0.0
> # TcpRetransSegs                  6                  0.0
> # TcpExtEmbryonicRsts             2                  0.0
> # TcpExtTW                        3                  0.0
> # TcpExtTSECR_Rejected            6                  0.0
> # TcpExtDelayedACKs               8                  0.0
> # TcpExtTCPPureAcks               36                 0.0
> # TcpExtTCPTimeouts               4                  0.0
> # TcpExtTCPSynRetrans             6                  0.0
> # TcpExtTCPOrigDataSent           25                 0.0
> # TcpExtTCPACKSkippedSynRecv      4                  0.0
> # TcpExtTCPDelivered              25                 0.0
> # MPTcpExtMPCapableSYNRX          1                  0.0
> # MPTcpExtMPCapableACKRX          1                  0.0
> # MPTcpExtMPJoinSynRx             4                  0.0
> # MPTcpExtMPJoinAckRx             2                  0.0
> # MPTcpExtDuplicateData           1                  0.0
> # MPTcpExtAddAddrTx               2                  0.0
> # MPTcpExtEchoAdd                 2                  0.0
> # MPTcpExtRcvWndShared            2                  0.0
> # Client ns stats
> # TcpActiveOpens                  5                  0.0
> # TcpEstabResets                  2                  0.0
> # TcpInSegs                       74                 0.0
> # TcpOutSegs                      75                 0.0
> # TcpRetransSegs                  2                  0.0
> # TcpInErrs                       6                  0.0
> # TcpOutRsts                      2                  0.0
> # TcpExtTW                        3                  0.0
> # TcpExtDelayedACKs               7                  0.0
> # TcpExtTCPPureAcks               38                 0.0
> # TcpExtTCPTimeouts               2                  0.0
> # TcpExtTCPChallengeACK           4                  0.0
> # TcpExtTCPSYNChallenge           6                  0.0
> # TcpExtTCPSynRetrans             2                  0.0
> # TcpExtTCPOrigDataSent           26                 0.0
> # TcpExtTCPACKSkippedChallenge    2                  0.0
> # TcpExtTCPDelivered              31                 0.0
> # TcpExtTcpTimeoutRehash          2                  0.0
> # MPTcpExtMPCapableSYNTX          1                  0.0
> # MPTcpExtMPCapableSYNACKRX       1                  0.0
> # MPTcpExtMPTCPRetrans            1                  0.0
> # MPTcpExtMPJoinSynAckRx          4                  0.0
> # MPTcpExtMPJoinSynTx             4                  0.0
> # MPTcpExtAddAddr                 2                  0.0
> # MPTcpExtEchoAddTx               2                  0.0
> # MPTcpExtMPRstTx                 2                  0.0
> # MPTcpExtRcvWndShared            4                  0.0
> #       join Rx                             [FAIL] see above
> #       join Tx                             [ OK ]

This is easy to reproduce apparently with a "non-debug" kernel:

 $ ./mptcp_join.sh "add multiple subflows IPv6"
 $ ./mptcp_join.sh "simult IPv4 and IPv6 subflows, fullmesh 2x2"

I didn't check yet, but I prefer to already send this email to delay
this patch if that's OK. Maybe you already have an idea on what is
wrong? Maybe something checked in tcp_check_req() and not initialised on
MPTCP side?

[1] https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
[2]
https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp&ld-cases=1&pass=0&skip=0
[3]
https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-join-sh/stdout

> nstat -az | grep TcpExtTSECR_Rejected
> TcpExtTSECR_Rejected            0                  0.0

It looks strange to have the underscore in the name. Maybe better
without it?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


