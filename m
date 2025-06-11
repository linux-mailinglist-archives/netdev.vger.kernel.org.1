Return-Path: <netdev+bounces-196500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D97AD506B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A7D1BC2497
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 09:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79853261399;
	Wed, 11 Jun 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pT85o15H"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE2262FCB;
	Wed, 11 Jun 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634879; cv=none; b=Qxp2ICvTOk8lvTwHWEEsjIzqnkbsR9M5NGpbJ6u8AF20aXqgml666Cq0VBHwaPxGsQEAi9Fi3ENkceTSwYxozh4+SN8DgcvHon/g2qbTzs/3LCaT4FLkVA9HR0JpFjpOVXTo2i05zZ71a09XqrRCPGggjPhQYhEXOxglxF+uZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634879; c=relaxed/simple;
	bh=TsHTys5p+kCpjkxZoTXlOVWR2jW1yNLCbU1XBZMBavo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j5qaTNEyWj/TJJxo9EBAJazeOsgI4f2M7jgdlCmJvQ0g5aOZv/R6C2XoBHC/d1ApwZPel0+XjoeV9zh8eyxSBpSLxu/xaqYhVgZ2RJ41vqp9gKPVDH2RrXQ2HwyvM7emK9hNO4vX3mNhZfsCaydxdyhxf54Tmc+CisJJYe71iuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pT85o15H; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55B9efh92551038;
	Wed, 11 Jun 2025 04:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749634841;
	bh=ICMYgHUJn775s1HXZV50Y8Poxnt8AvE5dvw388PWPI8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pT85o15Hr4oz59yGeBfsMmFt92cujnTwoD1eitRxyiqKJEszp0HsM/zOsGnLPXZf+
	 qtOetbW9WFgDBT8cVc/TpYz5+2Zpj+yJu9nSkB3i1XGpVM2zIfCK1pSutnISft2F0Z
	 XsaFavfy8YiFiv8afdXxuzC2dXJrjIzggjyLRBKE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55B9efpE1631823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 11 Jun 2025 04:40:41 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 04:40:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 04:40:41 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55B9eZCj137397;
	Wed, 11 Jun 2025 04:40:36 -0500
Message-ID: <10d1c003-fcac-4463-8bce-f40bda3047f0@ti.com>
Date: Wed, 11 Jun 2025 15:10:35 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Meghana Malladi <m-malladi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger
 Quadros <rogerq@ti.com>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
 <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
 <20250610085001.3upkj2wbmoasdcel@skbuf>
 <1cee4cab-c88f-4bd8-bd71-62cd06901b3b@ti.com>
 <20250610150254.w4gvmbsw6nrhb6k4@skbuf>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250610150254.w4gvmbsw6nrhb6k4@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 10/06/25 8:32 pm, Vladimir Oltean wrote:
> On Tue, Jun 10, 2025 at 04:14:29PM +0530, MD Danish Anwar wrote:
>>> 1. If there is no "existing" schedule, what does the "extend" variable
>>>    extend? The custom base-time mechanism has to work even for the first
>>>    taprio schedule. (this is an unanswered pre-existing question)
>>
>> The firmware has a cycle-time of 1ms even if there is no schedule. Every
>> 1ms, firmware updates a counter. The curr_time is calculated as
>> CounterValue * 1ms.
>>
>> Even if there are no schedule, the default cycle-time will remain 1ms.
>> Let's say the first schedule has a base-time of 20.5ms then the default
>> cycle will be extended by 0.5 ms and then the schedule will apply. This
>> is the reason, the extend feature is also impacting get/set_time
>> calculations.
> 
> So what is an ICSSG IEP cycle, then? I think this is another case where
> the firmware calls something X, taprio (and 802.1Q) also calls something
> X, and yet, they are talking about different things.
> 
> A schedule (in taprio terms) is an array of gate states and the
> respective time intervals for which those states apply. The schedule is
> periodic, and a cycle is the period of time after which the schedule
> repeats itself. By default, the cycle time (the duration of the cycle)
> is equal to the sum of the gate intervals, but it can also be longer or
> shorter (extended or truncated schedule).
> 

Yes I understand that.

> Whereas in the case of ICSSG, based on a code search for
> IEP_DEFAULT_CYCLE_TIME_NS, a cycle seems to be some elementary unit of
> timekeeping, used by the firmware API to express other information in
> terms of it, like packet timestamps and periodic output. Would that be a
> correct description?
> 
> When you say that "even if there is no schedule, the default cycle time
> will remain 1ms", you are talking about the cycle time in the ICSSG
> sense, because in the taprio/802.1Q sense, it is absurd to talk about a

Yes I am. By default cycle-time, I meant IEP_DEFAULT_CYCLE_TIME_NS.

> cycle time in absense of a schedule. And implicitly, you are saying that
> when the firmware extends the next-to-last cycle in order for unaligned
> base times to work, this alters that timekeeping unit. Like stretching

Yes. This is exactly what's happening. The IEP cycle and schedule cycle
are related to each other in firmware implementation. I am not sure how,
but that's what the firmware team confirmed with me. Due to this, a
different cycle-time in scheduling impacts the IEP cycles and
get/set_time APIs.

> the ruler in order for a mouse and an elephant to measure the same.
> 
> I think it needs to be explicitly pointed out that the taprio schedule
> is only supposed to affect packet scheduling at the egress of the port,
> but taprio is only a reader of the timekeeping process (and PTP time)
> and should not alter it. The timekeeping process should be independent
> and the taprio portion of the firmware should keep track of its own
> "cycles" which may not begin at the beginning of a timekeeping "cycle",
> may not end at the end of one, and may span multiple timekeeping
> "cycles", respectively.
> 

I understand that. But there are some dependency in firmware which
results into taprio schedule impacting the IEP cycle.

> What if you also have a Qci (tc-gate) schedule on the ingress of the
> same port, and that is configured for a different cycle-time or a
> different base-time (requiring a different "extend" value)? It will be
> too inflexible to apply the restriction that the parameters have to be
> the same.
> 
>>>>> That's what our first approach was. If it's okay with you I can drop all
>>>>> these changes and add below check in driver
>>>>>
>>>>> if (taprio->base_time % taprio->cycle_time) {
>>>>> 	NL_SET_ERR_MSG_MOD(taprio->extack, "Base-time should be multiple of cycle-time");
>>>>> 	return -EOPNOTSUPP;
>>>>> }
>>>
>>> I don't want to make a definitive statement on this just yet, I don't
>>> fully understand what was implemented in the firmware and what was the
>>> thinking.
>>>
>>
>> The firmware always expects cycle-time of 1ms and base-time to multiple
>> of cycle-time i.e. base-time to be multiple of 1ms.
>>
>> This way all the schedules will be aligned and that's what current
>> implementation is.
>>
>> To add support for base-time that are not multiple of cycle-time we
>> added "extend". However that will also only work as long as cycle-time
>> is 1ms. cycle-time other than 1ms is not supported by firmware as of
>> now. This is something we discovered recently.
>>
>> We have a check for TAS_MIN_CYCLE_TIME and TAS_MAX_CYCLE_TIME and they
>> are defined as,
>>
>> /* Minimum cycle time supported by implementation (in ns) */
>> #define TAS_MIN_CYCLE_TIME  (1000000)
>>
>> /* Minimum cycle time supported by implementation (in ns) */
>> #define TAS_MAX_CYCLE_TIME  (4000000000)
>>
>> But it is wrong. As per current firmware implementation,
>> 	TAS_MIN_CYCLE_TIME = TAS_MAX_CYCLE_TIME = 1ms
>>
>>
>> The ideal use case will be to support,
>> 1. Different cycle times
>> 2. Different base times which may or may not be multiple of cycle-times.
>>
>> With the current implementation, we are able to support #2 however #1 is
>> still a limitation. Once support for #1 is added, the implementation
>> will need to be changed.
> 
> (...)
> 
>>> As you can see, I still have trouble understanding the concepts proposed
>>> by the firmware.
>>
>> I understand that. I hope this makes it a bit more clear. Let me know
>> what needs to be done now.
> 
> Was the "extend" feature added to the ICSSG firmware as a result of the
> previous taprio review feedback? Because if it was, it's unfortunate
> that because of the lack of clarity of the firmware concepts, the way
> this feature was implemented is essentially DOA and cannot be used.
> 

Yes, the extend feature was added based on the feedback on v9.

> I am not very positive that even if adding the extra restrictions
> discovered here (cycle-time cannot be != IEP_DEFAULT_CYCLE_TIME_NS),
> the implementation will work as expected. I am not sure that our image
> of "as expected" is the same.
> 
> Given that these don't seem to be hardware limitations, but constraints
> imposed by the ICSSG firmware, I guess my suggestion would be to start
> with the selftest I mentioned earlier (which may need to be adapted),

Yes I am working on running the selftest on ICSSG driver however there
are some setup issues that I am encountering. I will try to test this
using the selftest.

> and use it to get a better picture of the gaps. Then make a plan to fix
> them in the firmware, and see what it takes. If it isn't going to be
> sufficient to fix the bugs unless major API changes are introduced, then
> maybe it doesn't make sense for Linux to support taprio offload on the
> buggy firmware versions.
> 
> Or maybe it does (with the appropriate restrictions), but it would still
> inspire more trust to see that the developer at least got some version
> of the firmware to pass a selftest, and has a valid reference to follow.

Sure. I think we can go back to v9 implementation (no extend feature)
and add two additional restrictions in the driver.

1. Cycle-time needs to be 1ms
2. Base-time needs to be Multiple of 1ms

With these two restrictions we can have the basic taprio support. Once
the firmware is fixed and has support for both the above cases, I will
modify the driver as needed.

I know firmware is very buggy as of now. But we can still start the
driver integration and fix these bugs with time.

I will try to test the implementation with these two limitations using
the selftest and share the logs if it's okay with you to go ahead with
these limitations.

> Not going to lie, it doesn't look great that we discover during v10 that
> taprio offload only works with a cycle time of 1 ms. The schedule is

I understand that. Even I got to know about this limitation after my
last response to v10
(https://lore.kernel.org/all/5e928ff0-e75b-4618-b84c-609138598801@ti.com/)

> network-dependent and user-customizable, and maybe the users didn't get
> the memo that only 1 ms was tested :-/

Let me know if it'll be okay to go ahead with the two limitations
mentioned above for now (with selftest done).

If it's okay, I will try to send v11 with testing with selftest done as
well. Thanks for the continuous feedback.

-- 
Thanks and Regards,
Danish

