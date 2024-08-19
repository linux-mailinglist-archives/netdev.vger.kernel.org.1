Return-Path: <netdev+bounces-119670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962549568C4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EEB283166
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15215B138;
	Mon, 19 Aug 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FEdK/rV3"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B4148315;
	Mon, 19 Aug 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064710; cv=none; b=SoLQfR1wExy8EvJuq6IBfO09JbYmLZbSg+9bV9uYbKM+uETSsK06c5e9QgS4ZAfvzqpEAdF0Zs8czIJOwaM+3bqhaukU/c2T2Z4uaZzXnVjQI8EuEsRFhUQGlZjn8/SbBB5moDgHiEOV5BPP+OvfZCFGAx2cM+0FQleHx7uMujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064710; c=relaxed/simple;
	bh=Md9Uzo/jv1nZu/djVH7ZwzcrA+B55XC/J0D3CVIPd6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mEGq+k9txK8MwoBa4TIqznYcLpSREz9IR5GszIbMYzOCvKCOrLEc71OWers0k+4AObx7sMX0VtXQvdpN6Zam6WYoW8iW/QFhGxzDzyZQVZdN7yFI+H6BLYCr4YEgvtvlr+ceNd1yr7D212Xg8QMavDUfKaGEcBi+5LbTAI/JS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FEdK/rV3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47JApTsU074689;
	Mon, 19 Aug 2024 05:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724064689;
	bh=RXta3I2bystr0uzK6BSwjLHhBReD4UWbpFShef858x4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=FEdK/rV3JOxIBhayLJq6O9QxyFpjRM9mL29IdUyIGoafdEcP8+aYPA7ou3SGrn1M/
	 Cxq/JUEcteh0bLS5jaBQ9GCfNGR5FUJCV7ZfpKHD2aR0lO3WipGqCg/hN6+UlQ1LL5
	 pMuI6WdctF+oTK6cHHTCyd2ZCF+0Td3ry6waYhOg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47JApTHW037964
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 05:51:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 05:51:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 05:51:28 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47JApMLd127341;
	Mon, 19 Aug 2024 05:51:23 -0500
Message-ID: <4c8b3eec-c221-4184-a6cf-492fcb664a8a@ti.com>
Date: Mon, 19 Aug 2024 16:21:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
From: "Anwar, Md Danish" <a0501179@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
 <082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch>
 <1ae38c1d-1f10-4bb9-abd7-5876f710bcb7@ti.com>
 <5128f815-f710-4ab7-9ca9-828506054db2@lunn.ch>
 <c1125924-bf7b-46c5-89d0-e15a330af58c@ti.com>
Content-Language: en-US
In-Reply-To: <c1125924-bf7b-46c5-89d0-e15a330af58c@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/14/2024 8:24 PM, Anwar, Md Danish wrote:
> 
> 
> On 8/14/2024 7:32 PM, Andrew Lunn wrote:
>>> Yes, the icssg_init_ and many other APIs are common for switch and hsr.
>>> They can be renamed to indicate that as well.
>>>
>>> How does icssg_init_switch_or_hsr_mode() sound?
>>
>> I would say it is too long. And when you add the next thing, say
>> bonding, will it become icssg_init_switch_or_hsr_or_bond_mode()?
>>
>> Maybe name the function after what it actually does, not why you call
>> it.
>>

Andrew, the functions are actually doing some configurations different
than EMAC mode which are needed for offloading the frames for switch as
well as HSR mode. icssg_init_emac_mode() doesn't do any configuration
related to offloading. Perhaps naming these APIs to
icssg_init_fw_offload_mode() will be a better fit?

Other Similar APIs can also be changed to use _fw_offload instead of
_switch. How does this sound?


> Sure Andrew, I will try to come up with a proper name for these APIs.
> 
>>>>>  static struct icssg_firmwares icssg_switch_firmwares[] = {
>>>>>  	{
>>>>>  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
>>>>> @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>>>>>  
>>>>>  	if (prueth->is_switch_mode)
>>>>>  		firmwares = icssg_switch_firmwares;
>>>>> +	else if (prueth->is_hsr_offload_mode)
>>>>> +		firmwares = icssg_hsr_firmwares;
>>>>
>>>> Documentation/networking/netdev-features.rst
>>>>
>>>> * hsr-fwd-offload
>>>>
>>>> This should be set for devices which forward HSR (High-availability Seamless
>>>> Redundancy) frames from one port to another in hardware.
>>>>
>>>> To me, this suggests if the flag is not set, you should keep in dual
>>>> EMACS or switchdev mode and perform HSR in software.
>>>
>>>
>>> Correct. This is the expected behavior. If the flag is not set we remain
>>> in dual EMAC firmware and do HSR in software. Please see
>>> prueth_hsr_port_link() for detail on this.
>>
>> O.K.
>>
>> 	Andrew
> 

-- 
Thanks and Regards,
Md Danish Anwar

