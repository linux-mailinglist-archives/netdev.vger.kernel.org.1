Return-Path: <netdev+bounces-172867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33ACA56563
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0745E1899DF5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089920E039;
	Fri,  7 Mar 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KGumB7H4"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954A634EC;
	Fri,  7 Mar 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343477; cv=none; b=fUfROQbvhZ/3ezJsNnAFKGba/5J77sYWnMhv27al57RkCVeL5FA0aisWsJme3gclAkPVrw5f20c8MXgyRd0eC+plDK0vIKy5eZYyk8jmKVMSVC8snu1NY7nf/eX5BBFBYdxJ9VDbItFfYsmduICUvDsuKeUa72h/XIKy6X9R1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343477; c=relaxed/simple;
	bh=g+i5ExB7iJNAMgpmrSvnBOnHGid3nMQ/bRienlHPEhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qvG7Kn2T2JbIYGL9biVDuauV9BD8fz+0o4wBy7FjkUvy16Id+ogytpaGUQz1ZZ7Sp1338UiPzzE4Jt96jJHL0q62FtT83ND/3R2RJ0R4KwnHF+XJhwfsc2nbIZvSwJ6CF0h8P0SiEe/7rChYbNCeo4DL6OdaVI+EvcZTi58GRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KGumB7H4; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AUlJJ243303
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 04:30:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343447;
	bh=o06VURZdv6TpTGBcJJyPYbkacPk57jeEgcFoNnbN4aE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KGumB7H4cAQuFzdLuZycJZSpzg4QLD+dAHTuVBw8wXFNQprMsQ6eDC1tUtMpvhhb3
	 4yo1Mfqb25UBTSJsBbPGMMIxW/zK5kLtIyv1S6n6mSYX9agzI58VKgMGEsvlls8dRy
	 s9UzPLM1SjLU/JUpCgSeR5VofbJ+/CiONUvr/mTc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527AUlqh015612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 04:30:47 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:30:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:30:46 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AUf4v015736;
	Fri, 7 Mar 2025 04:30:42 -0600
Message-ID: <3931a391-3967-4260-a104-4eb313810c0d@ti.com>
Date: Fri, 7 Mar 2025 16:00:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add ICSSG FW Stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Meghana Malladi <m-malladi@ti.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Lee Trager <lee@trager.us>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Roger Quadros <rogerq@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>
References: <20250305111608.520042-1-danishanwar@ti.com>
 <20250306165513.541ff46e@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250306165513.541ff46e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jakub

On 07/03/25 6:25 am, Jakub Kicinski wrote:
> On Wed, 5 Mar 2025 16:46:08 +0530 MD Danish Anwar wrote:
>> + - ``FW_RTU_PKT_DROP``: Diagnostic error counter which increments when RTU drops a locally injected packet due to port being disabled or rule violation.
>> + - ``FW_Q0_OVERFLOW``: TX overflow counter for queue0
>> + - ``FW_Q1_OVERFLOW``: TX overflow counter for queue1
>> + - ``FW_Q2_OVERFLOW``: TX overflow counter for queue2
>> + - ``FW_Q3_OVERFLOW``: TX overflow counter for queue3
>> + - ``FW_Q4_OVERFLOW``: TX overflow counter for queue4
>> + - ``FW_Q5_OVERFLOW``: TX overflow counter for queue5
>> + - ``FW_Q6_OVERFLOW``: TX overflow counter for queue6
>> + - ``FW_Q7_OVERFLOW``: TX overflow counter for queue7
> ...
> 
> Thanks for the docs, it looks good. Now, do all of these get included
> in the standard stats returned by icssg_ndo_get_stats64 ?
> That's the primary source of information for the user regarding packet
> loss.

No, these are not reported via icssg_ndo_get_stats64.

.ndo_get_stats64 populates stats that are part of `struct
rtnl_link_stats64`. icssg_ndo_get_stats64 populates those stats wherever
applicable. These firmware stats are not same as the ones defined in
`icssg_ndo_get_stats64` hence they are not populated. They are not
standard stats, they will be dumped by `ethtool -S`. Wherever there is a
standard stats, I will make sure it gets dumped from the standard
interface instead of `ethtool -S`

Only below stats are included in the standard stats returned by
icssg_ndo_get_stats64
- rx_packets
- rx_bytes
- tx_packets
- tx_bytes
- rx_crc_errors
- rx_over_errors
- rx_multicast_frames

> 
>>  	if (prueth->pa_stats) {
>>  		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
>> -			reg = ICSSG_FW_STATS_BASE +
>> -			      icssg_all_pa_stats[i].offset *
>> -			      PRUETH_NUM_MACS + slice * sizeof(u32);
>> +			reg = icssg_all_pa_stats[i].offset +
>> +			      slice * sizeof(u32);
>>  			regmap_read(prueth->pa_stats, reg, &val);
>>  			emac->pa_stats[i] += val;
> 
> This gets called by icssg_ndo_get_stats64() which is under RCU 

Yes, this does get called by icssg_ndo_get_stats64(). Apart from that
there is a workqueue (`icssg_stats_work_handler`) that calls this API
periodically and updates the emac->stats and emac->pa_stats arrays.

> protection and nothing else. I don't see any locking here, and

There is no locking here. I don't think this is related to the patch.
The API emac_update_hardware_stats() updates all the stats supported by
ICSSG not just standard stats.

> I hope the regmap doesn't sleep. cat /proc/net/dev to test.
> You probably need to send some fixes to net.

I checked cat /proc/net/dev and the stats shown there are not related to
the stats I am introducing in this series.

The fix could be to add a lock in this function, but we have close to 90
stats and this function is called not only from icssg_ndo_get_stats64()
but from emac_get_ethtool_stats(). The function also gets called
periodically (Every 25 Seconds for 1G Link). I think every time locking
90 regmap_reads() could result in performance degradation.

I only see couple of drivers acquiring spin lock before reading the
stats for .ndo_get_stats64. Most of the drivers are not using any lock.

I did some testing and did not see any discrepancy in the stats `cat
/proc/net/dev` without the lock.

Furthermore, the fix is independent of this patch. I can send out a
separate fix to net to add cpu locks to this function. But I don't think
there is any change needed in this patch.

Let me know what should be done here.

-- 
Thanks and Regards,
Danish

