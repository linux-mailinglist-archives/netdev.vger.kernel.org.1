Return-Path: <netdev+bounces-166662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D646A36DDA
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 12:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E5A16C5C1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE81A76AC;
	Sat, 15 Feb 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AsQby83H"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A2191F75;
	Sat, 15 Feb 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739620194; cv=none; b=bawjddDfa+nLcJ2s/4lj1O18M/SsBzLw7ExLpqN8t8Yc9aSNUKgDCFpWQx0fy0qiCXyzaKNfDDXdGpIhUyRbDVvmEodrM8MIWH18k2/MFFlM+4ST/1lpX99J0qSCiN2EfavQp8P59HoD2x1hp+3o2IIR63pUdQyH3a/KcceUoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739620194; c=relaxed/simple;
	bh=+FQIRzs2wuQMgHTdEcnK0KoIvFu1L6jLBjAsnavS25g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pUgDR68lvw6wliojMNzC78prXTdhF2xBiMHDBBPZt8lVWs+CBfVjkkIo+nuKB1nsqJrEzMaVXR85F1BeoGN0QwKq+whTMMuPXxUa8wGEFMWy75ULwmtUXBsnhAKMVrak2wwnggr6C9uqkow9hLE3bDHoJXJ8cTGz8Zjxr6VmY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AsQby83H; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51FBnHnD1020992
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 05:49:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739620157;
	bh=Rl5VY1tkZwofxrwLasF8opojSaEzhoskkIEIIsmtuIs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AsQby83HBCpVhiAL5rUzfY4e7JKSLISu3hohn3PYxUJM2eQVWbKc34xnW7IwRG6In
	 xjtYfeB8rqns+aV5jizW4OWE/y9T///AWlCxbfq5nXx+bKtZHJTNaa+7XBjKhzKcKi
	 fiO9Y47polG80URj10cR6aIKmuV7kIT8dCD0aDhQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51FBnH53072303
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Feb 2025 05:49:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Feb 2025 05:49:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Feb 2025 05:49:16 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51FBnB91026495;
	Sat, 15 Feb 2025 05:49:12 -0600
Message-ID: <4238ddcc-d6ab-41a3-8725-b948f013a5b9@ti.com>
Date: Sat, 15 Feb 2025 17:19:11 +0530
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
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
 <20250205160119.136639-2-c-vankar@ti.com> <87lduin4o5.ffs@tglx>
 <09880b14-cef1-44cd-9fa4-8840fb673c0a@ti.com> <87cyfplg8s.ffs@tglx>
 <dda464e2-d442-4e20-bc6d-cea854c5f17f@ti.com> <87jz9tjwjk.ffs@tglx>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <87jz9tjwjk.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Thomas,

On 14/02/25 04:13, Thomas Gleixner wrote:
> Chintan!
> 
> On Fri, Feb 14 2025 at 00:15, Vankar, Chintan wrote:
>> On 2/11/2025 1:33 AM, Thomas Gleixner wrote:
>>> On Sun, Feb 09 2025 at 14:06, Vankar, Chintan wrote:
>>>> On 2/7/2025 2:58 AM, Thomas Gleixner wrote:
>>> If I understand this correctly, then the interrupt number you need to
>>> allocate for this is never going to be requested. If it would be
>>> requested it just would do nothing and the handler would never be
>>> invoked, right?
>>>
>>> The allocation just establishes the routing of a signal between two
>>> arbitrary IP blocks in the SoC.
>>>
>>> So the question is what has this to do with interrupts in the first
>>> place?
>>
>> Your understanding is correct about the Timesync INTR. As I mentioned
>> Timesync INTR is an instance of Interrupt Router which has multiple
>> output and not all the output lines are acting as interrupt lines unlike
>> other Interrupt Routers. Timesync INTR can have devices on both the
>> sides, we can provide input to Timesync INTR that can be consumed by
>> some other device from the output line. As an instance, One of the
>> input of Timesync INTR is an output from the CPTS module which can be
>> consumed by other device and that does not need to handle/allocate Linux
>> irq number.
> 
> Two questions:
> 
>   1) For the case where no interrupt is involved, how is the routing
>      configured?
> 
>   2) For the case where it routes an input line to an interupt, then how
>      is this interrupt going to be handled by this interrupt domain which
>      is not connected to anything and implements an empty disfunctional
>      interrupt chip?
> 

For both the cases above the job of Timesync INTR is to map the output
register with the corresponding input.

As described in section 11.3.2.1 in the TRM at:
https://www.ti.com/lit/ug/spruiu1d/spruiu1d.pdf,
the job of the Timesync INTR is to provide a configuration of the
"output registers which controls the selection". Hence we just have to
provide configuration APIs in the Timesync INTR which programs output
registers of the Timesync INTR. About the handling of the interrupts,
the device which receives an interrupt needs to handle the interrupt.

Could you please explain why we consider these two cases to be
different?


Regards,
Chintan.

> Thanks
> 
>          tglx

