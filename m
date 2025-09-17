Return-Path: <netdev+bounces-224136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3345B8118C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE844800D2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121C2BE655;
	Wed, 17 Sep 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TmuUoqkv"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DE281356;
	Wed, 17 Sep 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128477; cv=none; b=vBL7AcfyEhErMZCvVGYMgTGLr01HuJoDSav7Ki+GdoaKa/7hfXCZIfNMxwoOp6FAMyFLnNPE+s9xlLlPjaXHh7dCcbF53ia9MhYbnugekkKomY8xWYi/t2awurbB9jXTMAoWZPUsDraDG9OpzE84EGDMEb2BJIlnpBoh4YXSt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128477; c=relaxed/simple;
	bh=hJVKZkeRT4RlYlXpyr9p2g5aHiBMFf1ef3Yhwp5ZqPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqjMkr0JhbZW6sZxPTgmn29mryplk4wuTqjD0eAN3SymRqhFK1L1Q6B7HIJMsaKMI+31mhOnLEv4tATcxnAzYApYLG3fOjZaR0DoVYBdT3e7Us80T+/Okg0cO0K/uMgpZkZqGKrlME49sWAZIk7KHVFfJZpFwhffXlaVXA3x8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TmuUoqkv; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb294591-7d23-42fd-901a-3466b586f437@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758128472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojT4pPN0CvVUq05QTtka/Ya/G75lzlL/MTy5m+/ilvI=;
	b=TmuUoqkvLx//R0qEB7Vp9qm0AgXS8Wf5F5sP7bdnpS6OEB36alJxV1SySMZVVu6BnaukS3
	qLG22uZ8lFxgfTsRDe+uP59ht2qH+AHrqyntj4+ObdxXDS7bK+jc9390fIYGqkoNMJ0h+O
	mO41XLdeKsZFN0ao3lbVrQBPuGHZQaU=
Date: Wed, 17 Sep 2025 18:01:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
To: Ivan Vecera <ivecera@redhat.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250911072302.527024-1-ivecera@redhat.com>
 <20250915164641.0131f7ed@kernel.org>
 <SA1PR11MB844643902755174B7D7E9B3F9B17A@SA1PR11MB8446.namprd11.prod.outlook.com>
 <c60779d6-938d-4adc-a264-2d78fb3c5947@redhat.com>
 <SJ2PR11MB845273963D6C04DCDB222FF19B17A@SJ2PR11MB8452.namprd11.prod.outlook.com>
 <2ee83405-fd42-4a70-8a5f-f6f34b0b8731@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2ee83405-fd42-4a70-8a5f-f6f34b0b8731@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/09/2025 15:55, Ivan Vecera wrote:
> On 17. 09. 25 3:10 odp., Kubalewski, Arkadiusz wrote:
>>> From: Ivan Vecera <ivecera@redhat.com>
>>> Sent: Wednesday, September 17, 2025 2:18 PM
>>>
>>> On 17. 09. 25 1:26 odp., Kubalewski, Arkadiusz wrote:
>>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>>> Sent: Tuesday, September 16, 2025 1:47 AM
>>>>>
>>>>> cc: Arkadiusz
>>>>>
>>>>> On Thu, 11 Sep 2025 09:23:01 +0200 Ivan Vecera wrote:
>>>>>> The DPLL phase measurement block uses an exponential moving average,
>>>>>> calculated using the following equation:
>>>>>>
>>>>>>                          2^N - 1                1
>>>>>> curr_avg = prev_avg * --------- + new_val * -----
>>>>>>                            2^N                 2^N
>>>>>>
>>>>>> Where curr_avg is phase offset reported by the firmware to the 
>>>>>> driver,
>>>>>> prev_avg is previous averaged value and new_val is currently measured
>>>>>> value for particular reference.
>>>>>>
>>>>>> New measurements are taken approximately 40 Hz or at the frequency of
>>>>>> the reference (whichever is lower).
>>>>>>
>>>>>> The driver currently uses the averaging factor N=2 which prioritizes
>>>>>> a fast response time to track dynamic changes in the phase. But for
>>>>>> applications requiring a very stable and precise reading of the 
>>>>>> average
>>>>>> phase offset, and where rapid changes are not expected, a higher 
>>>>>> factor
>>>>>> would be appropriate.
>>>>>>
>>>>>> Add devlink device parameter phase_offset_avg_factor to allow a user
>>>>>> set tune the averaging factor via devlink interface.
>>>>>
>>>>> Is averaging phase offset normal for DPLL devices?
>>>>> If it is we should probably add this to the official API.
>>>>> If it isn't we should probably default to smallest possible history?
>>>>>
>>>>
>>>> AFAIK, our phase offset measurement uses similar mechanics, but the
>>>> algorithm
>>>> is embedded in the DPLL device FW and currently not user controlled.
>>>> Although it might happen that one day we would also provide such knob,
>>>> if useful for users, no plans for it now.
>>>>   From this perspective I would rather see it in dpll api, especially
>>>> this relates to the phase measurement which is already there, the value
>>>> being shared by multiple dpll devices seems HW related, but also 
>>>> seem not
>>>> a
>>>> problem, as long as a change would notify each device it relates with.
>>>
>>> What if the averaging is implemented in different HW differently? As I
>>> mentioned the Microchip HW uses exponential moving average but
>>> a different HW can do it differently.
>>>
>>
>> Yeah good point, in that case we would also need enumerate those, and 
>> the new
>> HW would have to extend the uAPI to let the user know which method is 
>> used?
>> Different methods could require different parameters?
>> But for your current case only one attribute would be enough?
>> Or maybe better to provide those together like:
>> DPLL_A_PHASE_MEASUREMENT_EMA_N
>> Then different method would have own attributes/params?
>>
>> Next question if a HW could have multiple of those methods available and
>> controlled, in which case we shall also have in mind a plan for a
>> "turned-off" value for further extensions?
>>
>> Thank you!
>> Arkadiusz
> 
> Jiri, Vadim,
> any comments / opinions?

Our HW doesn't have such options, and it doesn't looks like we will be
able to extend it this way. But I'm fine with providing UAPI if there
will other users.


