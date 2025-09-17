Return-Path: <netdev+bounces-224057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB50B80418
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864BD3BD996
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7664C30AADB;
	Wed, 17 Sep 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxeK2/45"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9B328966
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120669; cv=none; b=LVoy+/fmpBOYd7fkvmotSQLw2V6LtWLeyZ5L0vuxRPLZHUehhnOudkValKWBDxdgOCmP2FszlPTUNChFXPs3O3tKsQTquODQLBiVXlUBF8TcaM+eFuLYBF1opGTwsykLwhV7HSyVtouECyDYA2zflwk1AkrdqukUHnjExNRJYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120669; c=relaxed/simple;
	bh=KN+HSTt+zz54lPOUK/gQOiEaE+dw6eIamFwq00f11cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ4UnRlk4YqNuMA5Ha/lsYH8Mmgnt9E8b2bBM25zCaiCckFrOaISOGPo379usJ5/0VYNACxkA+FCB5kjF8C4THIB6Zh24HPs1Wa2G6ly0RVx6HDia6e6tQPwmcm+LiVofsFtyyB8o2tmTpwu1ZMrk6NCw3VhURP3Zt7NuCUm0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxeK2/45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0E1C4CEE7;
	Wed, 17 Sep 2025 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758120668;
	bh=KN+HSTt+zz54lPOUK/gQOiEaE+dw6eIamFwq00f11cw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FxeK2/45S+8LWm3b8Qyf2MVLDYySEHFG1fdevEpNrIEkvdrV/4klxfwQSdKCKIB+e
	 UlDvlw5AdzUKvS3vJ7oDhowPi0UN3QHmungXtkEMmhcZpGesFroDl+HVgJIF/6WVyJ
	 uClaJ1lA2Kd41rgz72qig5pUKOORaHOiXvsSEX+KpThYprZfZejwkdByF+hXVQmLB1
	 7T7y5abFH4i/h97FUtPAdiL5Q0SRRjJ55S241pyZvGut+bb71cCDjVNbHpCTDsPUxl
	 c5RT4vON3hoHApJY74EeXJHYGWsu5jxUF097bGPRT0CKkSVuXdj96Z6WnR5sORD5gS
	 +u33ZmkkGXqsw==
Message-ID: <13984b59-cc41-459a-9934-17c4a001b777@kernel.org>
Date: Wed, 17 Sep 2025 16:51:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net-next 6/7] mptcp: Call dst_release() in
 mptcp_active_enable().
Content-Language: en-GB, fr-BE
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20250916214758.650211-1-kuniyu@google.com>
 <20250916214758.650211-7-kuniyu@google.com>
 <35a48361-c69f-4cf9-aec9-db1ac0597f96@kernel.org>
 <CANn89iLT4P1qqtJBmKq0iA63isjMfdgv+gQ25+fM4gSG7dT4RA@mail.gmail.com>
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
In-Reply-To: <CANn89iLT4P1qqtJBmKq0iA63isjMfdgv+gQ25+fM4gSG7dT4RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 17/09/2025 16:04, Eric Dumazet wrote:
> On Wed, Sep 17, 2025 at 3:17 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Kuniyuki,
>>
>> On 16/09/2025 23:47, Kuniyuki Iwashima wrote:
>>> mptcp_active_enable() calls sk_dst_get(), which returns dst with its
>>> refcount bumped, but forgot dst_release().
>>>
>>> Let's add missing dst_release().
>>>
>>> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> ---
>>> v2: split from the next patch as dst_dev_rcu() patch hasn't been
>>>     backported to 6.12+, where the cited commit exists.
>>
>> Thank you for the v2 and for the split!
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> Ideally, it would be great to if the 'Cc: stable' tag can be added when
>> applying the patch, so I would be notified in case of issues with the
>> backport of this patch.
>>
>> Cc: stable@vger.kernel.org
> 
> I almost never use this tag, stable teams automatically catch things
> with Fixes: tag which contains a precise bug origin.

Indeed, they do. At the beginning, we were only adding the "Fixes:" tag,
without the "Cc: stable" one -- despite what the doc recommends [1] --
because we didn't see the point to have both. But later, we realised
adding "Cc: stable" results in Greg sending 'FAILED' notifications when
a patch cannot be backported, e.g. [2]. Thanks to that, we only have to
monitor Greg's 'FAILED' notifications to know what couldn't be
backported, instead of tracking each patch individually.

[1] https://docs.kernel.org/process/stable-kernel-rules.html#option-1
[2] https://lore.kernel.org/2025062026-excitable-trunks-92e6@gregkh

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thank you for the review!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


