Return-Path: <netdev+bounces-169637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2DA44F12
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51A97A6FC2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B671A4E98;
	Tue, 25 Feb 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCp7wX/O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC119CD0B;
	Tue, 25 Feb 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519721; cv=none; b=gukHi8C2dco3EeXR5qngfS9WmNzQgt+pYCD3hJVlUuB0fuay8bqy1/angzUTiHHKD1X5w15PgxFP5UaYSapmvAKW0CSnpoFrK4Jn3xWZcX+Ix3WNRaPeBuwdxBuTydllIEN2KfFDxnahx/rR80gmfX7Da6v2V4hYa6ZPaTrwYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519721; c=relaxed/simple;
	bh=i/w3Ugg7iqwU7nyARwQaD4QgDzZhsyrM7w55zgo5bBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UivohV2YKf7KtpD1EO52Lk5qZvqrTiU8Y2gfYBoRgPo9bsrX2m6nqOLJhFfZR3vjW7wt5h3xZQQ/gWSpVHQ1/vlDnfWrqVRxStsgtRxq7qlz46BkyGCPHu5WVRXlKqnL3+SLX4iy07pHbqMf/f4pmSEfIW7ldX7p2k7Q1d9ZGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCp7wX/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB3BC4CEDD;
	Tue, 25 Feb 2025 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740519721;
	bh=i/w3Ugg7iqwU7nyARwQaD4QgDzZhsyrM7w55zgo5bBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KCp7wX/OtqZL5zKviICbsptf27RtTUORLlU+8wi7qrpTYtmi4paqNdw8giRXxdzH2
	 qRDN59mwDbAhi1gpn2J4QLL3R4c6nn/8gzRI08SkeINmIA6YHlUSFXy99rbqwYyTtz
	 igMz2SA5LeaeZNVBczSo4pQ6aPRzFF4zWzhima8bTgOD3EIZht/rCtW+lV+Sx66LNp
	 xcQ2p0YZy3xINytivXjrEQnjcsUGR3ekL6OW3sFPOTDpMfmzpPqTCMpcj4cLm+Z/mx
	 /DH5zi6P/ap13VRShX9SDXiOFbvEk9IwBsf3Bx6Y+ULq02crE0zclHynkVGWjmDeQt
	 Mc45JT8xaBqXQ==
Message-ID: <30663725-7078-4b8d-bc75-8a9cd15b0b02@kernel.org>
Date: Tue, 25 Feb 2025 22:41:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Content-Language: en-GB
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
References: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
 <20250224232012.GA7359@templeofstupid.com>
 <e8039b96-1765-4464-b534-d6d1385b46eb@kernel.org>
 <20250225192946.GA1867@templeofstupid.com>
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
In-Reply-To: <20250225192946.GA1867@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krister,

On 25/02/2025 20:29, Krister Johansen wrote:
> Hi Matt,
> Thanks for the review!
> 
> On Tue, Feb 25, 2025 at 06:52:45PM +0100, Matthieu Baerts wrote:
>> On 25/02/2025 00:20, Krister Johansen wrote:
>>> If multiple connection requests attempt to create an implicit mptcp
>>> endpoint in parallel, more than one caller may end up in
>>> mptcp_pm_nl_append_new_local_addr because none found the address in
>>> local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
>>> case, the concurrent new_local_addr calls may delete the address entry
>>> created by the previous caller.  These deletes use synchronize_rcu, but
>>> this is not permitted in some of the contexts where this function may be
>>> called.  During packet recv, the caller may be in a rcu read critical
>>> section and have preemption disabled.
>>
>> Thank you for this patch, and for having taken the time to analyse the
>> issue!
>>
>>> An example stack:

(...)

>> Detail: if possible, next time, do not hesitate to resolve the
>> addresses, e.g. using: ./scripts/decode_stacktrace.sh
> 
> My apologies for the oversight here.  This is the decoded version of the
> stack:

No problem, thanks for the decoded version!

(...)

>> I'm going to apply it in our MPTCP tree, but this patch can also be
>> directly applied in the net tree directly, not to delay it by one week
>> if preferred. If not, I can re-send it later on.
> 
> Thanks, I'd be happy to send it to net directly now that it has your
> blessing.  Would you like me to modify the call trace in the commit
> message to match the decoded one that I included above before I send it
> to net?

Sorry, I forgot to mention that this bit was for the net maintainers.
Typically, trivial patches and small fixes related to MPTCP can go
directly to net.

No need for you to re-send it. If the net maintainers prefer me to send
it later with other patches (if any), I will update the call trace, no
problem!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


