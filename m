Return-Path: <netdev+bounces-171922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6BEA4F680
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30BA3A5281
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 05:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1815749C;
	Wed,  5 Mar 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d3k3IzMM"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EB5103F;
	Wed,  5 Mar 2025 05:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152087; cv=none; b=GFwhnVAwaMHyayjtuwY/JF2hIqGw86GuZLvXB43AaKkzQ0x8xa2Dlfpr7XGmk0ZN4EyX12TiHldGEvHfcGmAhEPi/gbK9zP+2vATID/D/GHwexi+WKAwAZyxeyxnsezS6+ENzRTG/OLkbiS6ywkRt7YIyruR1+Gv/lbhrk2/ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152087; c=relaxed/simple;
	bh=FHL8mgJUPxbUe+Hq6oSBmF+pjKynbkkOWQzLA/C/blA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dHfGLHk0cqUuLZuknom4Imr4gc166z3+6cWQtc7FtcDOvve7TA27ucf9NP+mIqh/tzNFe8/drWud1B3VupBv+zkKrSfPlLXxIhgSJZep75tV2G+/kbAX/yY8FkFv1+OPKbAhd9VapmM+eYlJrDK/bv1h/aLSDFXrAMWi6pAbw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d3k3IzMM; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5255KrIT3769565
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 23:20:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741152053;
	bh=ijoXj6D3ao9xjhKDSHIBWiEm1mRJLo6+iyZj8hvRuuk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=d3k3IzMMwQHMqRvHIz1I3WSFLblEUfV3ckhP5Qq3G+yJxAUkwldRjER9dxjHSQ/cM
	 wPY1FFGyDl3rxZA+I/UgPXsEFix7rod1VUimOi8Wk/y8Apqw8+3ukjImUrl/GTipVb
	 2Ke63Sx08evB8dIGxDSJiYd93XWZ/04huCX5ofMY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5255Kqao026316
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 23:20:53 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 23:20:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 23:20:52 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5255KmhZ080040;
	Tue, 4 Mar 2025 23:20:48 -0600
Message-ID: <cf468c08-6808-49a2-b6d9-5c2b00d654de@ti.com>
Date: Wed, 5 Mar 2025 10:50:47 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add ICSSG FW Stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Meghana Malladi <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        "David
 S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20250227093712.2130561-1-danishanwar@ti.com>
 <20250303172543.249a4fc2@kernel.org>
 <33c38844-4fbe-469c-bb5f-06bdb7721114@ti.com>
 <20250304162437.0160f687@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250304162437.0160f687@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub,

On 05/03/25 5:54 am, Jakub Kicinski wrote:
> On Tue, 4 Mar 2025 13:46:39 +0530 MD Danish Anwar wrote:
>> On 04/03/25 6:55 am, Jakub Kicinski wrote:
>>> On Thu, 27 Feb 2025 15:07:12 +0530 MD Danish Anwar wrote:  
>>>> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>>>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>>>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>>>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>>>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),  
>>>
>>> I presume frame preemption is implemented in silicon? If yes -
>>> what makes these "FW statistics"? Does the FW collect them from   
>>
>> The statistics are maintained / updated by firmware and thus the name.
>>
>> Preemption is implemented partially in both the hardware and firmware.
>> The STATE MACHINE for preemption is in the firmware. The decision to
>> when to PREEMEPT / ASSEMBLE a packet is made in firmware.
>>
>> These preemption statistics are updated by the firmware based on the
>> action performed by the firmware. Driver can read these to know the
>> statistics of preemption. These stats will be able used by
>> ethtool_mm_stats once the support for Preemption is added in the driver.
> 
> That was going to be my next question. If the statistic is suitable 
> for a standard interface it should not be reported via ethtool -S.
> 

Sure. I will not report it via `ethtool -S`. This will only be reported
via ethtool_get_mm_stats. I will do something similar to
`icssg_miig_stats`. Have a boolean to indicate whether the stat is
getting reported by some standard interface or not.

> Please leave the stats for unimplemented features out.
> 

Sure. For now I will remove the FW_PREEMPT stats since the feature is
not implemented yet. Once the implementation is done, I will add the
stats to icssg_all_pa_stats() and read it via
emac_update_hardware_stats() and report it via ethtool_get_mm_stats.

>>>> +/* Incremented if a packet is dropped at PRU because of a rule violation */
>>>> +#define FW_DROPPED_PKT		0x00F8  
>>>
>>> Instead of adding comments here please add a file under
>>> Documentation/networking/device_drivers/ with the explanations.
>>> That's far more likely to be discovered by users, no?  
>>
>> Sure I will drop these MACRO comments and create a .rst file in
>> Documentation/networking/device_drivers/
>>
>> One question though, should I create a table for the stats and it's
>> description or should I create a section for each stats?
>>
>> Something like this,
>>
>> FW_RTU_PKT_DROP
>> ---------------
> 
> Let's document the user-visible names! The strings from ethtool -S
> 
>> Diagnostic error counter which increments when RTU drops a locally
>> injected packet due to port being disabled or rule violation.
>>
>> Please let me know what do you think.
> 
> Taking inspiration from:
>   Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> should be a safe choice, I hope.

This looks to be a good choice. I will do the changes and send out a v2.
Thanks for the review.

-- 
Thanks and Regards,
Danish

