Return-Path: <netdev+bounces-196810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F9AD673F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81627AD343
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C51A9B52;
	Thu, 12 Jun 2025 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ePPip87u"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B91361;
	Thu, 12 Jun 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705665; cv=none; b=lIL8R0SIGNoLrqm5mJO0utPz/M6uzm1/l63wTfXYmNHn/sizcQrt3dvh0Q0kE+ZN+IWpW95Ffsr17BRQ3jVf1aWIlDyNl9xv8+W6kzSY+Ltj0XrdC1el4DbfOnVyeCr07UgXTiKUhTJbnMW/EAL50/q1IKuZQTIymefLB3/pq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705665; c=relaxed/simple;
	bh=9wQfzzj7t9uK2/u04vK/+hfHsgoZV4eWemmen29KTdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t4nCIPzxVUoNLvOvDdyXcs1JJCzCuCrif01CeZXPSGWZr1Pou2mDvU73YPZTxo4SBxVr6ie+J0xAvHbfA+ubPsgc9OTCK7dvyUvwlMfjVZ+CSHkJKb9cTopZa7UM8HsVrZ3FKtXALaaO7vgDI5GfMA+QW5CFsS9MD5Se2VQHfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ePPip87u; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C5KqE32777873;
	Thu, 12 Jun 2025 00:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749705652;
	bh=f0hXMw8ptRoZo8p1kCUGMksKDyTuNXCp9RDEBkWxjOA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ePPip87uWoVMAXtwg7UZuCmvzjYTFrqY4z0RyKdYQe047ftJS5HKh8iNxGQYadiBG
	 GhLLq45++EdhLh1Rd9eTQSF6nB2lSj6n+J5Il4cmk6S7UrsCGB0Gd1GOWPJM0XMcNx
	 dwqD3ruNjFI6L4b5YXEJ8Tbiuu3eXUKdQezzBbHg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C5KpNN2306843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 00:20:51 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 00:20:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 00:20:50 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C5KjFH1459677;
	Thu, 12 Jun 2025 00:20:46 -0500
Message-ID: <42ac0736-cb5a-4d99-a11c-6f861adbdb5f@ti.com>
Date: Thu, 12 Jun 2025 10:50:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add prp offload support
 to ICSSG driver
To: Jakub Kicinski <kuba@kernel.org>, Himanshu Mittal <h-mittal1@ti.com>
CC: <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <m-malladi@ti.com>,
        <pratheesh@ti.com>, <prajith@ti.com>
References: <20250610061638.62822-1-h-mittal1@ti.com>
 <20250611170424.08e47f1a@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250611170424.08e47f1a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/06/25 5:34 am, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 11:46:38 +0530 Himanshu Mittal wrote:
>> Add support for ICSSG PRP mode which supports offloading of:
>>  - Packet duplication and PRP trailer insertion
>>  - Packet duplicate discard and PRP trailer removal
>>
>> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 23 +++++++++++++++++++-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 +++
>>  2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 86fc1278127c..65883c7851c5 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -138,6 +138,19 @@ static struct icssg_firmwares icssg_hsr_firmwares[] = {
>>  	}
>>  };
>>  
>> +static struct icssg_firmwares icssg_prp_firmwares[] = {
>> +	{
>> +		.pru = "ti-pruss/am65x-sr2-pru0-pruprp-fw.elf",
>> +		.rtu = "ti-pruss/am65x-sr2-rtu0-pruprp-fw.elf",
>> +		.txpru = "ti-pruss/am65x-sr2-txpru0-pruprp-fw.elf",
>> +	},
>> +	{
>> +		.pru = "ti-pruss/am65x-sr2-pru1-pruprp-fw.elf",
>> +		.rtu = "ti-pruss/am65x-sr2-rtu1-pruprp-fw.elf",
>> +		.txpru = "ti-pruss/am65x-sr2-txpru1-pruprp-fw.elf",
>> +	}
>> +};
> 
> AFAIU your coworker is removing the static names, please wait until 
> the dust is settled on that:
> 
> https://lore.kernel.org/all/20250610052501.3444441-1-danishanwar@ti.com/

Yes, it's better to wait for that patch to get merged before we add new
firmware.

-- 
Thanks and Regards,
Danish

