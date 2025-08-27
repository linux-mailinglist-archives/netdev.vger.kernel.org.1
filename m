Return-Path: <netdev+bounces-217295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF4B383D9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DD189B979
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28975350D42;
	Wed, 27 Aug 2025 13:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07931E112
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302049; cv=none; b=KcWg6xtvNQ33LYdZBNGNAwRtwM7nEAvkiVGabanxfzesrfOdEmQhjEzi+P6+5job4bPmul109gC1bgQuqRJwwlSJvUzwyzWsgT+27f4nziltqcw7/cmbdNaGruz/8oIoXz8TPBU2sQndNz+R+2w/LTAiJ247P0xaO4R1C04sBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302049; c=relaxed/simple;
	bh=YZSW/JhS8eG5W+NL0XbvPL29It5aZ+AGRYmBVN8Sidc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLGA2ldJP0AkmyF6gVTYcrdGRwzANnDYssnwwi2pSU/bVabu4k3WPgGg9ayC8KMQtd6FRTT+lR8oXNI+2IU+OLHNLx6AT1ccfUaYAO8T6fm2MJqZi7DVUOwgYoChIY+nH7L0q85lTXtUHrPo+ymZn8tLjUzFe1lK1IKZI/1yxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.16.0.106] (unknown [213.71.9.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 07D6E60213AC1;
	Wed, 27 Aug 2025 15:39:36 +0200 (CEST)
Message-ID: <aefa86a1-8959-4e5f-8203-78ce4c50b3bd@molgen.mpg.de>
Date: Wed, 27 Aug 2025 15:39:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Miroslav Lichvar <mlichvar@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de> <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
 <20250826125912.q0OhVCZJ@linutronix.de>
 <e656a4ee-281c-4205-9183-bc3c7dbc9173@intel.com>
 <87ecswq5vj.fsf@jax.kurt.home>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87ecswq5vj.fsf@jax.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


A very interesting issue.

Am 27.08.25 um 14:57 schrieb Kurt Kanzenbach:
> On Tue Aug 26 2025, Jacob Keller wrote:
>> On 8/26/2025 5:59 AM, Sebastian Andrzej Siewior wrote:
>>> On 2025-08-25 16:28:38 [-0700], Jacob Keller wrote:
>>>> Ya, I don't think we fully understand either. Miroslav said he tested on
>>>> I350 which is a different MAC from the I210, so it could be something
>>>> there. Theoretically we could handle just I210 directly in the interrupt
>>>> and leave the other variants to the kworker.. but I don't know how much
>>>> benefit we get from that. The data sheet for the I350 appears to have
>>>> more or less the same logic for Tx timestamps. It is significantly
>>>> different for Rx timestamps though.
>>>
>>> From logical point of view it makes sense to retrieve the HW timestamp
>>> immediately when it becomes available and feed it to the stack. I can't
>>> imagine how delaying it to yet another thread improves the situation.
>>> The benchmark is about > 1k packets/ second while in reality you have
>>> less than 20 packets a second. With multiple applications you usually
>>> need a "second timestamp register" or you may lose packets.
>>>
>>> Delaying it to the AUX worker makes sense for hardware which can't fire
>>> an interrupt and polling is the only option left. This is sane in this
>>> case but I don't like this solution as some kind compromise for
>>> everyone. Simply because it adds overhead and requires additional
>>> configuration.
>>
>> I agree. Its just frustrating that doing so appears to cause a
>> regression in at least one test setup on hardware which uses this method.
>>
>>>>> Also I couldn't really see a performance degradation with ntpperf. In my
>>>>> tests the IRQ variant reached an equal or higher rate. But sometimes I
>>>>> get 'Could not send requests at rate X'. No idea what that means.
>>>>>
>>>>> Anyway, this patch is basically a compromise. It works for Miroslav and
>>>>> my use case.
>>>>>
>>>>>> This is also what the igc does and the performance improved
>>>>>> 	afa141583d827 ("igc: Retrieve TX timestamp during interrupt handling")
>>>>
>>>> igc supports several hardware variations which are all a lot similar to
>>>> i210 than i350 is to i210 in igb. I could see this working fine for i210
>>>> if it works fine in igb.. I honestly am at a loss currently why i350 is
>>>> much worse.
>>>>
>>>>>> and here it causes the opposite?
>>>>>
>>>>> As said above, I'm out of ideas here.
>>>>
>>>> Same. It may be one of those things where the effort to dig up precisely
>>>> what has gone wrong is so large that it becomes not feasible relative to
>>>> the gain :(
>>>
>>> Could we please use the direct retrieval/ submission for HW which
>>> supports it and fallback to the AUX worker (instead of the kworker) for
>>> HW which does not have an interrupt for it?
>>
>> I have no objection. Perhaps we could assume the high end of the ntpperf
>> benchmark is not reflective of normal use case? We *are* limited to only
>> one timestamp register, which the igb driver does protect by bitlock.
> 
> Does that mean we're going back to v1 + the AUX worker for 82576? Let me
> prepare v3 then.

Good question. Personally, I’d interpret Linux’ no-regression-policy 
that, if a possible regression is known, even for a synthetic benchmark, 
it must not be introduced unrelated how upsetting this is. So the 
current approach needs to be taken.


Kind regards,

Paul

