Return-Path: <netdev+bounces-230541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDABEACDA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D692D1AE009E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339E29B77E;
	Fri, 17 Oct 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vS0rhs+A"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83F2417F0
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719233; cv=none; b=t0rKWN0GzXHt3tpzTUgbtV2XxlYYQ4XKLFcCYVr9oUEbnuq7dwlnVYNnduhR1fiX98HknE/saotmQKqjaBNCe+VsrV1/Rf2bFaNjgJhlhSc2lYSxePS7v+8c+YU0d74FSSbpfS1ofcRmKVs6wXfyTPYHwzq7hsrzcQfsTs5LR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719233; c=relaxed/simple;
	bh=VejBTcIpMQ+YvMAbEqPgmeUV1iVvXTggt3BZUGQJQUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9X9rju/77KRnb3l9OT8aWKsuro4ih18OPRq5STocRq3OIn4UyRgHrCneMtCjAqDgWZYuDRlQk7auZHoB6dY+WTnf6MExOweZ8cXkdSGuurszDUNce6hxmRFrBaAkle3kvZBuX1SAp7+bYArps5sBauXFeRQY76tEsgx0fAHHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vS0rhs+A; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59fb5dff-9a4c-447c-95b8-27982a53cc7b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760719229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VejBTcIpMQ+YvMAbEqPgmeUV1iVvXTggt3BZUGQJQUA=;
	b=vS0rhs+Ayf7E2j/4MIdoKz5wbnKc/pEi0/sWX5QYWLiJ3Eg2TS3/BjOJrvav9sBB5DIaUL
	z+u4+mM0ZNvyIdBnbxsuqHubq93aEBoVMNWyp5y+o5+YEurGNFbeZqe4RunkmWU525bHUC
	FKFwzMwRz3jxHNx2jMXpX2uoGUDigCc=
Date: Fri, 17 Oct 2025 17:39:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: support PPS in/out on all pins
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
 <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com>
 <20f633b9-8a49-4240-8cb8-00309081ab73@linux.dev>
 <CALs4sv0ehFVMMB2HPqUkGnv5iRW-VYKpeFf3QtRDgThVH=XQYQ@mail.gmail.com>
 <f1c42ecd-57c0-4cea-906e-aebcd583944a@linux.dev>
 <CALs4sv3OV-VVYS7oy1akiZdQncsmqY+hqds7NLeiy3oh3Awz8w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv3OV-VVYS7oy1akiZdQncsmqY+hqds7NLeiy3oh3Awz8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/10/2025 15:08, Pavan Chebbi wrote:
> On Fri, Oct 17, 2025 at 4:10 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 17/10/2025 10:15, Pavan Chebbi wrote:
>>> On Fri, Oct 17, 2025 at 2:21 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 17.10.2025 04:45, Pavan Chebbi wrote:
>>>>> On Fri, Oct 17, 2025 at 3:54 AM Vadim Fedorenko
>>>>> <vadim.fedorenko@linux.dev> wrote:
>>>>>>
>>>>>> n_ext_ts and n_per_out from ptp_clock_caps are checked as a max number
>>>>>> of pins rather than max number of active pins.
>>>>>
>>>>> I am not 100pc sure. How is n_pins going to be different then?
>>>>> https://elixir.bootlin.com/linux/v6.17/source/include/linux/ptp_clock_kernel.h#L69
>>>>
>>>> So in general it's more for the case where HW has pins connected through mux to
>>>> the DPLL channels. According to the bnxt_ptp_cfg_pin() bnxt HW has pins
>>>> hardwired to channels and NVM has pre-defined configuration of pins' functions.
>>>>
>>>> [host ~]# ./testptp -d /dev/ptp2 -l
>>>> name bnxt_pps0 index 0 func 0 chan 0
>>>> name bnxt_pps1 index 1 func 0 chan 1
>>>> name bnxt_pps2 index 2 func 0 chan 2
>>>> name bnxt_pps3 index 3 func 0 chan 3
>>>>
>>>> without the change user cannot configure EXTTS or PEROUT function on pins
>>>> 1-3 preserving channels 1-3 on them.
>>>>
>>>> The user can actually use channel 0 on every pin because bnxt driver doesn't
>>>> care about channels at all, but it's a bit confusing that it sets up different
>>>> channels during init phase.
>>>
>>> You are right that we don't care about the channels. So I think
>>> ideally it should have been set to 0 for all the pins.
>>> Does that not make a better fix? Meaning to say, we don't care about
>>> the channel but/therefore please use 0 for all pins.
>>> What I am not sure about the proposed change in your patch is that it
>>> may be overriding the definition of the n_ext_ts and n_per_out in
>>> order to provide flexibility to users to change channels, no?
>>
>> Well, yeah, the overriding exists, but that's mostly the artifact of not
>> so flexible API. But I agree, we can improve init part to make it clear.
>> But one more thing has just come to my mind - is it
>> really possible to configure PPS-in/PPS-out on pins 0-1?
>> AFAIU, there are functions assigned to each pin, which can only be
>> enabled or disabled by the user-space app, and in this case
>> bnxt_ptp_verify() should be improved to validate function per pin,
>> right?
>>
> The pin config was really flexible because we implemented it first for
> 575xx chipsets. We could remap the functions on Thor1.
> With 576xx, what you are saying is true. The pin functions are fixed.
> If the user is aware of the functions, then it's not a problem.
> But yes, because there is verify() available, we can always validate.
> So we can improve the bnxt_ptp_verify()

Ok, I'm going to send v2 with supported_flags provided and changing
initialization to set channels to 0 based on CHIP generation.

I'll let you do the improvements to bnxt_ptp_verify() as you have more
insights on the HW itself.

