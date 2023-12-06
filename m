Return-Path: <netdev+bounces-54585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D436E807872
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B92B20DAB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392836DCFE;
	Wed,  6 Dec 2023 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW3mQY6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A6DCE3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 19:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA29C433C7;
	Wed,  6 Dec 2023 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701890137;
	bh=SQBCq+vdv0d3tGaClUH0WQbz0FTWgbIDaKT4M0mAh1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZW3mQY6IaEElt6DdQcPJRLSzIdWZQ+mW/oGAUfWPF2QMPgjxB9CT2p1Lhiajup1XC
	 oDqO70xg+YNQp5jh9A47oedCCkYEThPN9EUufF8iGfoHJHyA2NGwIEjPxW3LJico6Q
	 ZRXIGKfWNAV0wC6LYY8h0u3cJuWmILQn7Z/dQQUelRcWo5mnS6Q1KIFwT2u7JCO7YS
	 5nWgtdFB4Shah17Pk0zmJYLglrUo1e+SZlKWrXIznjllXhx8Ydf5/Yq7GqDLtYRn0n
	 SEiXpR8E422gZuQUqE+CRWSH3WHlEIlFKNKhZQ8RZYYiiBfWVX22Pr6pfyIeFXJk24
	 KysCm5H0cGrTw==
Message-ID: <e4823a44-33a9-4dbf-a39d-66ae256b903a@kernel.org>
Date: Wed, 6 Dec 2023 12:15:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Judy Hsiao <judyhsiao@chromium.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>,
 Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
 <20231206093917.04fd57b5@hermes.local>
 <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
 <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/6/23 11:49 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Dec 6, 2023 at 9:51 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 12/6/23 10:39 AM, Stephen Hemminger wrote:
>>> On Wed,  6 Dec 2023 03:38:33 +0000
>>> Judy Hsiao <judyhsiao@chromium.org> wrote:
>>>
>>>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>>>> index df81c1f0a570..552719c3bbc3 100644
>>>> --- a/net/core/neighbour.c
>>>> +++ b/net/core/neighbour.c
>>>> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>>>  {
>>>>      int max_clean = atomic_read(&tbl->gc_entries) -
>>>>                      READ_ONCE(tbl->gc_thresh2);
>>>> +    u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>>>>      unsigned long tref = jiffies - 5 * HZ;
>>>>      struct neighbour *n, *tmp;
>>>>      int shrunk = 0;
>>>> +    int loop = 0;
>>>>
>>>>      NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>>>>
>>>> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>>>                              shrunk++;
>>>>                      if (shrunk >= max_clean)
>>>>                              break;
>>>> +                    if (++loop == 16) {
>>>
>>> Overall looks good.
>>> Minor comments:
>>>       - loop count should probably be unsigned
>>>         - the magic constant 16 should be a sysctl tuneable
>>
>> A tunable is needed here; the loop counter is just to keep the overhead
>> of the ktime_get_ns call in check.
> 
> From context, I'm going to assume you meant a tunable is _NOT_ needed here. ;-)
> 
> -Doug

yes, multitasking fail :-(

