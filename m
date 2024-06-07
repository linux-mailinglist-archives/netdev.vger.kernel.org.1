Return-Path: <netdev+bounces-101629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0368FFB1B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38CE1C20DDE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ACA17BA3;
	Fri,  7 Jun 2024 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qzFkKSbl"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC122089;
	Fri,  7 Jun 2024 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736397; cv=none; b=GmbP7GyCMGKfwnGsodLOKKAGE16gtZg9rymbADuyQ+xJIjWo+toB0w0lg9K80/WteP4Z2077odGNf4EP9k0qBz8cZSjZ8vgUPJ0W7KFD/fy6EtVSpyk/wSb+tM3uTwbVyXSejgN92E2y+koUeU7wpZnKZ60jJAM8KwyWE0DBsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736397; c=relaxed/simple;
	bh=slbmzeyADNYp8hiUFTqbrwW883b79pkHaC4LmbNRy0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GJ5fktAgETq6T664w8Bb6kl5L9k4jWSOQkUxMfgJDYljcTzgnh+y6KXv4IqKDuOK2rAPo9YY9OcIxohxC28YKZEMcMxJv1Od6kdwL4900jrjmefzhKwAGHFRHT9zb/IO9LoeS8tyuUQPA+30A+r69bQEFgZCmJSzHDbZFzJfI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qzFkKSbl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4574xK6P032178;
	Thu, 6 Jun 2024 23:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717736360;
	bh=q9zM+C2ALOTZzdhqIQKT3rHPlePwj64EjR20S0wa0Co=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qzFkKSblR0UyD30+76tK6YHGKVTzVQqAaX/J7YhfK+5mP/gb/9aQa3NFNce0562AZ
	 q/hGR67pKwk19VSKd9LlowEgIoK815ficPeFeh70uugFPE2cxarJeiMYd0Qpe2g+4m
	 AgMIdqYR3mJ3JAl9u4EYcFnz5zaK12olAS9QUy20=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4574xKqp003605
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 23:59:20 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 23:59:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 23:59:19 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4574xDlX007855;
	Thu, 6 Jun 2024 23:59:13 -0500
Message-ID: <f81178c5-313e-47f6-bfe0-7e21a7f89a90@ti.com>
Date: Fri, 7 Jun 2024 10:29:12 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
        MD Danish Anwar
	<danishanwar@ti.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros
	<rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Jacob
 Keller <jacob.e.keller@intel.com>,
        Roger Quadros <rogerq@ti.com>
References: <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <20240603135100.t57lr4u3j6h6zszd@skbuf>
 <20240603140559.krc6ap5qbltutsvj@skbuf>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240603140559.krc6ap5qbltutsvj@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 6/3/2024 7:35 PM, Vladimir Oltean wrote:
> On Mon, Jun 03, 2024 at 04:51:00PM +0300, Vladimir Oltean wrote:
>>>>> +static void tas_reset(struct prueth_emac *emac)
>>>>> +{
>>>>> +	struct tas_config *tas = &emac->qos.tas.config;
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
>>>>> +		tas->max_sdu_table.max_sdu[i] = 2048;
>>>>
>>>> Macro + short comment for the magic number, please.
>>>>
>>>
>>> Sure I will add it. Each elements in this array is a 2 byte value
>>> showing the maximum length of frame to be allowed through each gate.
>>
>> Is the queueMaxSDU[] array active even with the TAS being in the reset
>> state? Does this configuration have any impact upon the device MTU?
>> I don't know why 2048 was chosen.
> 
> Another comment here is: in the tc-taprio UAPI, a max-sdu value of 0
> is special and means "no maxSDU limit for this TX queue". You are
> programming the values from taprio straight away to hardware, so,
> assuming there's no bug there, it means that the hardware also
> understands 0 to mean "no maxSDU limit".
> 

I discussed this with the firmware team. They are not treating 0 as
something special (""no maxSDU limit for this TX queue"). They have
limit on every queue. Driver needs to handle the max-sdu size carefully.

> If so, then during tas_reset(), after which the TAS should be disabled,
> why aren't you also using 0 as a default value, but 2048?

As using 0 doesn't mean anything special in firmware. The default value
during reset is kept as the max supported value.

There's also one thing missing here, the max-sdu table in firmware is
updated (by calling tas_update_maxsdu_table()) only once by driver
during tas_reset(). The firmware table should also be updated once
before triggering the list change so that the firmware would know what
are the max-sdu value that user has requested.

If a user request max-sdu as 0 0 0 80 for 4 queues. The driver will
update these values to firmware as PRUETH_MAX_MTU, PRUETH_MAX_MTU,
PRUETH_MAX_MTU, 80.


-- 
Thanks and Regards,
Md Danish Anwar

