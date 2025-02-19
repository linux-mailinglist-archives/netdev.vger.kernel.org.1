Return-Path: <netdev+bounces-167846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA07A3C8EF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EF5189B8FB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7C22B595;
	Wed, 19 Feb 2025 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BVC9iWak"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89B1FECAE;
	Wed, 19 Feb 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993790; cv=none; b=js2r78i+d62NBNC1+pYvEPI146m6+B/IyotjWEBWesRqoZz3EwKDOImUynPB/QY9zPtM2Uj5rfjU3QCTDdAz+7pxNi8WSQkuXES0fhgZ6NjAJUx+BFJmMla3CgUsHQwD+TbyhlcswQLkIqwz6L6A8IG8fJEZIanUUUYtMrFxwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993790; c=relaxed/simple;
	bh=YUZVKPNnWqfMc6DHELioLciuEgVLDK11YWAFpFQIrpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oY0NKppHyuOx2SAc6XYX5VDlUt13HSshk26Wjkth6D8MrZuT8NVwF5hygiBm8m88Zh6M8QC347ZG6dYeq8dQ8ZbXELbg7HxGF/TAKS3W/xDJZWkjjrAmGMbBTCMcMh7DMkmbviGzYx0B2zTvj4a15YMfGVnl01l/tJaqE4fIw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BVC9iWak; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JJa5pU2063500
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 13:36:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739993765;
	bh=8EvVce+jqD12k32qwF7nR1NxOePu4ZKlcn0n3l2IJUI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BVC9iWakCbU6AvMW2RylcRWtY2vSIlU6vNlIuUCnK4Ng+AAdwW87md1tFYmgpYkk/
	 Pb5Nyoyd8ZQnvICjNZ6BHJdopuWS48+T21BvEh/rHfrkOHc0xHsy4Y9dxmXeGXFSkz
	 rBsTTX0wCN+Adn9YZBnt/0voh4n+z6FkXUzC4qmg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JJa5me014675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Feb 2025 13:36:05 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 13:36:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 13:36:04 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JJZxUp074733;
	Wed, 19 Feb 2025 13:36:00 -0600
Message-ID: <b399c73b-359a-4dde-acc3-0bf4aea900e9@ti.com>
Date: Thu, 20 Feb 2025 01:05:58 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync
 Interrupt Router
To: Thomas Gleixner <tglx@linutronix.de>, Jason Reeder <jreeder@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com> <87lduin4o5.ffs@tglx>
 <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com> <87cyfplg8s.ffs@tglx>
 <dda464e2-d442-4e20-bc6d-cea854c5f17f@ti.com> <87jz9tjwjk.ffs@tglx>
 <4238ddcc-d6ab-41a3-8725-b948f013a5b9@ti.com> <87ikp8jph9.ffs@tglx>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <87ikp8jph9.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Thomas/Greg,

On 2/18/2025 1:47 AM, Thomas Gleixner wrote:
> Chintan!
> 
> On Sat, Feb 15 2025 at 17:19, Chintan Vankar wrote:
>> On 14/02/25 04:13, Thomas Gleixner wrote:
>>> Two questions:
>>>
>>>    1) For the case where no interrupt is involved, how is the routing
>>>       configured?
>>>
>>>    2) For the case where it routes an input line to an interupt, then how
>>>       is this interrupt going to be handled by this interrupt domain which
>>>       is not connected to anything and implements an empty disfunctional
>>>       interrupt chip?
>>>
>>
>> For both the cases above the job of Timesync INTR is to map the output
>> register with the corresponding input.
>>
>> As described in section 11.3.2.1 in the TRM at:
>> https://www.ti.com/lit/ug/spruiu1d/spruiu1d.pdf,
>> the job of the Timesync INTR is to provide a configuration of the
>> "output registers which controls the selection". Hence we just have to
>> provide configuration APIs in the Timesync INTR which programs output
>> registers of the Timesync INTR. About the handling of the interrupts,
>> the device which receives an interrupt needs to handle the interrupt.
>>
>> Could you please explain why we consider these two cases to be
>> different?
> 
> They are different as
> 
>    #1 Routes the signal from one IP block to another IP block
> 
>       So there is no notion of an actual interrupt, but still you use the
>       interrupt domain mechanism, which requires to allocate a Linux
>       interrupt number just to configure that router.
> 
>       What's the purpose of this interrupt number and the allocated
>       resources behind it?
> 
>    #2 Routes the signal from an IP block to an actual interrupt "input"
> 
>       Again, this requires to allocate a Linux interrupt number which is
>       disfunctional as it is not connected in the interrupt domain
>       hierarchy and just provides an interrupt chip with a name and no
>       actual functionality behind it.
> 
>       So the resulting real interrupt needs yet another interrupt number
>       which then maps to something which actually can handle interrupts.
> 
> So in some aspect they are not that different because both have nothing
> to do with the actual concept of interrupt management in the Linux
> kernel.
> 
>  From the kernel's interrupt handling POV this is a completely
> transparent piece of hardware, which is not associated to any interrupt
> handling mechanism. Just because the manual mentions INTR in the name of
> the IP block does not make it part of the actual kernel interrupt
> handling.
> 
> I have no idea into which subsystem such a SoC configuration belongs to,
> but Greg might have an idea.
> 

Thanks for the reviewing the patch. Since you suggest to implement it
with a different subsystem, I want your and Greg's suggestion for that.

As we discussed and also from the documentation, Timesync INTR should be
configured by programming it's output registers to control the selection
corresponding to the input. Mux-controller subsystem also works on the
similar kind of principle, to program the output by selectively choosing
from multiple input sources, I am trying to relate Timesync INTR with
that subsystem.

Could you please suggest if the implementation can be achieved using the
mux-subsystem ?


Regards,
Chintan.

> Thanks,
> 
>          tglx

