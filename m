Return-Path: <netdev+bounces-229135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6714BD86DC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF81421C21
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60122E62AF;
	Tue, 14 Oct 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="azZNFzNk"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683E2E0B5F;
	Tue, 14 Oct 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433946; cv=none; b=sVaZiUiswQ8Fq9/13mqlI1FHw4OT6zrSWaFz4XAEl3wrEzG0DAw8JHwvg/togpp3x7GgfmBqVIN/aFbivrIVhBfYPHMVANEiWXLX0W8VKTCfv/oP04NORKMXjd9KFYEXcq3WF14+wuCG9cJj3sjP8WxoeR6huNqxRfpvHWbnezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433946; c=relaxed/simple;
	bh=o/vSQIl7tNPStdaocN65f1QVLmQY4TPDbzkpap21YpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=inq7ZE35hFhN5736QdcuHWaC3Iabjwv5f5JYcELCkB2um4M1YF9N8lQ/0CaCsuW8tmExNUT9jkhasNO8NFQckt45KoSgUJMHz3BgQhTWz58rjKLF+FMoB2Vory+2Jt5PslJkqpPNAiCv9rokC+RLO6i798+8TiSXR8OOALd+Z3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=azZNFzNk; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59E9PTNW1114817;
	Tue, 14 Oct 2025 04:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760433929;
	bh=juZD7qPlFNPrZBo5nIhRej6WrFZIUY5prg9h7+Bs/nA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=azZNFzNkYdWFRBvfHbXBKWRfdXruCNPaS08gn7i/xOLsiGUeV9wAHVLW4J7/LKYfp
	 1Od47Qd1vJS9m2ONmm0iviys3MDm9qJd91bnjLkCl57MbyyjD+Khz7fWoXNtxWysdt
	 l9PhgTKqCVBcd87QH6d5MsQJkD5ClEKWS3KniTlE=
Received: from DLEE205.ent.ti.com (dlee205.ent.ti.com [157.170.170.85])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59E9PTBA3906283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 04:25:29 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 04:25:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 04:25:29 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59E9PPQB3335218;
	Tue, 14 Oct 2025 04:25:26 -0500
Message-ID: <c8821c7e-b551-4a1b-9bb1-33d0eb05eb4c@ti.com>
Date: Tue, 14 Oct 2025 14:55:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix fdb hash size
 configuration
To: Simon Horman <horms@kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20251013085925.1391999-1-m-malladi@ti.com>
 <aOzqMj1TbzJCZrRk@horms.kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <aOzqMj1TbzJCZrRk@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Simon,

On 10/13/25 17:31, Simon Horman wrote:
> On Mon, Oct 13, 2025 at 02:29:25PM +0530, Meghana Malladi wrote:
>> The ICSSG driver does the initial FDB configuration which
>> includes setting the control registers. Other run time
>> management like learning is managed by the PRU's. The default
>> FDB hash size used by the firmware is 512 slots which is not
>> aligned with the driver's configuration. Update the driver
>> FDB config to fix it.
>>
>> Fixes: abd5576b9c57f ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>
>> Please refer trm [1] 6.4.14.12.17 section
>> on how the FDB config register gets configured.
>>
>> [1]: https://www.ti.com/lit/pdf/spruim2
> 
> Thanks for the link!
> And thanks to TI for publishing this document.
> 
>>
>>   drivers/net/ethernet/ti/icssg/icssg_config.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index da53eb04b0a4..3f8237c17d09 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -66,6 +66,9 @@
>>   #define FDB_GEN_CFG1		0x60
>>   #define SMEM_VLAN_OFFSET	8
>>   #define SMEM_VLAN_OFFSET_MASK	GENMASK(25, 8)
>> +#define FDB_HASH_SIZE_MASK	GENMASK(6, 3)
>> +#define FDB_HASH_SIZE_SHIFT	3
>> +#define FDB_HASH_SIZE		3
> 
> I am slightly confused about this.
> 
> The patch description says "The default FDB hash size used by the firmware
> is 512 slots which is not aligned with the driver's configuration."
> And above FDB_HASH_SIZE is 3, which is the value that the driver will
> now set hash size to.
> 
> But table 6-1404 (on page 4049) of [1] describes 3 as setting
> the FDB hash size to 512 slots. I would have expected a different
> value based on my understanding of the patch description.
> 

Yes you are right. But if you re-check the same table 6-1404, there is
a reset field for FDB_HAS_SIZE which is 4, meaning 1024 slots.
Currently the driver is not updating this reset value from 4(1024 slots) 
to 3(512 slots), which is why the driver is not aligned with the 
firmware. This patch fixes this by updating the reset value to 512 slots.

Let me know if the commit message is not clear enough to convey this 
correctly. I will update it accordingly.

>>   
>>   #define FDB_GEN_CFG2		0x64
>>   #define FDB_VLAN_EN		BIT(6)
>> @@ -463,6 +466,8 @@ void icssg_init_emac_mode(struct prueth *prueth)
>>   	/* Set VLAN TABLE address base */
>>   	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
>>   			   addr <<  SMEM_VLAN_OFFSET);
>> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, FDB_HASH_SIZE_MASK,
>> +			   FDB_HASH_SIZE << FDB_HASH_SIZE_SHIFT);
>>   	/* Set enable VLAN aware mode, and FDBs for all PRUs */
>>   	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, (FDB_PRU0_EN | FDB_PRU1_EN | FDB_HOST_EN));
>>   	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
>> @@ -484,6 +489,8 @@ void icssg_init_fw_offload_mode(struct prueth *prueth)
>>   	/* Set VLAN TABLE address base */
>>   	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
>>   			   addr <<  SMEM_VLAN_OFFSET);
>> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, FDB_HASH_SIZE_MASK,
>> +			   FDB_HASH_SIZE << FDB_HASH_SIZE_SHIFT);
>>   	/* Set enable VLAN aware mode, and FDBs for all PRUs */
>>   	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
>>   	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
>>
>> base-commit: 68a052239fc4b351e961f698b824f7654a346091
>> -- 
>> 2.43.0
>>


