Return-Path: <netdev+bounces-166182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C657BA34DEA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8622A16C862
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA12222D6;
	Thu, 13 Feb 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kfGA6NKY"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933328A2D4;
	Thu, 13 Feb 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472364; cv=none; b=D+6O+3AUueEF49WXxN7X16MIZgoziS/2OMQSzZKYGS6L3amRg6Rr8l6xLaV25fsTJJL11/YNmsm8rq/NNGI4TpApBuuLL/n5B8gRCM15AGrkHwZUs+aQo6x7GATiIQFuAgsEdK3o+Bu9ODgIWkRzepM+VMkfJeGN8EGsEYeeCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472364; c=relaxed/simple;
	bh=djAOyvkxrd4abeKbPFGppehKhsuEMBayhhlnavfa0Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CnKk5ImQpkyrnmHuseCp+hEIC0jv2qfGkyXDoUBWjH1lUt/9tCz4yhGURh08PivQGuKSz5LKAnf/+ywXpgaKXow6SVPFgWrZ8GZetdi9nratDl6oqfwMawWDMlTFP6qxV/laq1b9X/qth3vHs4sKcMG2/dsWtbuoKkwkeEcUYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kfGA6NKY; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51DIjakd4171222
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 12:45:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739472336;
	bh=tki3mSiA8np/SZTaq/xOWDDISgF8Ay9QT/oAuaJtrH8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kfGA6NKYYgTf5H5uiAcn9gLHH1o98mHAtTkvLu41R4G1inbYaA5wgu4slndAwO08P
	 xjVtEuPsMRXZ4LVVucFzqQkPlG+xAvDxN1fB1oHbGDFDng+oX+ZV+OG/wTYPs7fvhs
	 pAPaA42rbh4rMfikBJGBK9ZrsqUCFNywV6Sf9qqA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51DIjat7035913
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Feb 2025 12:45:36 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 12:45:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 12:45:35 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DIjTdu025218;
	Thu, 13 Feb 2025 12:45:30 -0600
Message-ID: <dda464e2-d442-4e20-bc6d-cea854c5f17f@ti.com>
Date: Fri, 14 Feb 2025 00:15:28 +0530
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
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <87cyfplg8s.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/11/2025 1:33 AM, Thomas Gleixner wrote:
> Chintan!
> 
> On Sun, Feb 09 2025 at 14:06, Vankar, Chintan wrote:
>> On 2/7/2025 2:58 AM, Thomas Gleixner wrote:
>>> On Wed, Feb 05 2025 at 21:31, Chintan Vankar wrote:
>>>> +static struct irq_chip ts_intr_irq_chip = {
>>>> +	.name			= "TIMESYNC_INTRTR",
>>>> +};
>>>
>>> How is this interrupt chip supposed to work? All it implements is a
>>> name.
>>>
>>
>> Timesync INTR can be used to map input sources with the corresponding
>> output, so that we can configure specific functionality for the device
>> that is using this output sources either as an interrupt source or to
>> synchronize the time.
>>
>> To implement above Timesync INTR's functionality, I have implemented
>> ts_intr_irq_domain_alloc() and ts_intr_irq_domain_free() ops which are
>> sufficient. Let me know if they are fine.
>>>> +
>>>> +	tsr_data.domain = irq_domain_create_tree(&node->fwnode, &ts_intr_irq_domain_ops, &tsr_data);
>>>
>>> So this instantiates a interrupt domain which is completely disconnected
>>> from the rest of the world.
>>>   > How is the output side of this supposed to handle an interrupt which is
>>> routed to it?
>>>
>>
>>                           ________________________
>>                          |    Timesync INTR       +---->dma_local_events
>>                          |                        |
>> Device sync events----->                        +---->pcie_cpts_hw_push
>>                          |                        |
>>            cpts_genf----->                        +---->cpts_hw_push
>>                          |________________________|
>>
>>
>> No it is connected, it is being used to configure the output for
>> Timesync INTR as mentioned above.
>>
>> As seen in the diagram, Timesync INTR has multiple output interfaces and
>> we can configure those to map them with the corresponding input as
>> required by peripherals which receives the signal. In context of this
>> series, CPTS module is utilizing the output signal of cpts_genf as
>> Hardware timestamp push event to generate timestamps at 1 seconds
> 
> If I understand this correctly, then the interrupt number you need to
> allocate for this is never going to be requested. If it would be
> requested it just would do nothing and the handler would never be
> invoked, right?
> 
> The allocation just establishes the routing of a signal between two
> arbitrary IP blocks in the SoC.
> 
> So the question is what has this to do with interrupts in the first
> place?
> 

Hello Thomas,

Your understanding is correct about the Timesync INTR. As I mentioned
Timesync INTR is an instance of Interrupt Router which has multiple
output and not all the output lines are acting as interrupt lines unlike
other Interrupt Routers. Timesync INTR can have devices on both the
sides, we can provide input to Timesync INTR that can be consumed by
some other device from the output line. As an instance, One of the
input of Timesync INTR is an output from the CPTS module which can be
consumed by other device and that does not need to handle/allocate Linux
irq number.

Let me know if implementing this driver for this specific use-case would
be feasible.

> Thanks,
> 
>          tglx

