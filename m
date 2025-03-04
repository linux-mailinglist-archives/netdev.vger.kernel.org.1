Return-Path: <netdev+bounces-171531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B6BA4D601
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E0B3A4AB4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2651F5404;
	Tue,  4 Mar 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KOne0f1l"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539A189528;
	Tue,  4 Mar 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076244; cv=none; b=iMk2gLlpiPLBLpKJFOUVjYOOhwRnWXqJeAn0ln2tzNXmVXNgs+UpYIpuyxkDy96iouvyTNOJDNEquGI4jd0pCvlnnWGjdcLlTKvIeChHVHrk1HHdJ+36l+BBkLqWQkSagXxAcrEf7o2xsofGTK7EevFj4btw0rMNdStBtRR/hPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076244; c=relaxed/simple;
	bh=tcxZLstVr4VNllrZF6oqSc0dUyKjiXtBl2rVpewrbDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jhGyvYiXsJFAmh85bKuqhAv5h1Mhal8qPpRTF9BtJDIKrvRtiou/WCq73pEG78G3xXloVy+IGQPVuNVl//RFpWvIsGl1heORhu8H5Setrl9mSvZyerubp+D1INUFzIU7bhyarxnWjGijLwchVHbt5eh55GJNy4sz0h5ODq+aTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KOne0f1l; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5248GiLo2912962
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 4 Mar 2025 02:16:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741076204;
	bh=Q2OXkEES7Yr0y5dN7s4KOrfkCNcFyfcQ2GugE0dZYS4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KOne0f1lM6G34zbctiUwbEARuKJv0K+91fthqeO66/t12qkvb6OXnnFyRptDnY3zl
	 cUOfMsL5NjMAQTmx27bp4+xXawY4OK8LZEa5imYwoFvfkI4+nGFvxvFTWbmiS6KROw
	 REQtOotz48bSTEBACyV23bn8cqtB3gf51+lU/8pg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5248GiUE096921;
	Tue, 4 Mar 2025 02:16:44 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 02:16:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 02:16:43 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5248GdYe043311;
	Tue, 4 Mar 2025 02:16:40 -0600
Message-ID: <33c38844-4fbe-469c-bb5f-06bdb7721114@ti.com>
Date: Tue, 4 Mar 2025 13:46:39 +0530
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
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250303172543.249a4fc2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 04/03/25 6:55 am, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 15:07:12 +0530 MD Danish Anwar wrote:
>> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
> 
> I presume frame preemption is implemented in silicon? If yes -
> what makes these "FW statistics"? Does the FW collect them from 

The statistics are maintained / updated by firmware and thus the name.

Preemption is implemented partially in both the hardware and firmware.
The STATE MACHINE for preemption is in the firmware. The decision to
when to PREEMEPT / ASSEMBLE a packet is made in firmware.

These preemption statistics are updated by the firmware based on the
action performed by the firmware. Driver can read these to know the
statistics of preemption. These stats will be able used by
ethtool_mm_stats once the support for Preemption is added in the driver.

> the device or the frames are for FW? 
> 
>> +	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>> +	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>> +	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
>> +	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP),
>> +	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN),
>> +	ICSSG_PA_STATS(FW_CUT_THR_PKT),
>> +	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT),
>> +	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
>> +	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
>> +	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
>>  };
>>  
>>  #endif /* __NET_TI_ICSSG_STATS_H */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> index 424a7e945ea8..d30203a0978c 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
>> @@ -231,4 +231,109 @@
>>  /* Start of 32 bits PA_STAT counters */
>>  #define PA_STAT_32b_START_OFFSET                           0x0080
>>  
>> +/* Diagnostic error counter which increments when RTU drops a locally injected
>> + * packet due to port disabled or rule violation.
>> + */
>> +#define FW_RTU_PKT_DROP		0x0088
>> +
>> +/* Tx Queue Overflow Counters */
>> +#define FW_Q0_OVERFLOW		0x0090
>> +#define FW_Q1_OVERFLOW		0x0098
>> +#define FW_Q2_OVERFLOW		0x00A0
>> +#define FW_Q3_OVERFLOW		0x00A8
>> +#define FW_Q4_OVERFLOW		0x00B0
>> +#define FW_Q5_OVERFLOW		0x00B8
>> +#define FW_Q6_OVERFLOW		0x00C0
>> +#define FW_Q7_OVERFLOW		0x00C8
>> +
>> +/* Incremented if a packet is dropped at PRU because of a rule violation */
>> +#define FW_DROPPED_PKT		0x00F8
> 
> Instead of adding comments here please add a file under
> Documentation/networking/device_drivers/ with the explanations.
> That's far more likely to be discovered by users, no?

Sure I will drop these MACRO comments and create a .rst file in
Documentation/networking/device_drivers/

One question though, should I create a table for the stats and it's
description or should I create a section for each stats?

Something like this,

FW_RTU_PKT_DROP
---------------
Diagnostic error counter which increments when RTU drops a locally
injected packet due to port being disabled or rule violation.

Please let me know what do you think.

-- 
Thanks and Regards,
Danish

