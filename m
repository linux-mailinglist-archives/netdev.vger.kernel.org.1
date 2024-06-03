Return-Path: <netdev+bounces-100052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDAB8D7B14
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A85C1F21674
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 05:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C520DD3;
	Mon,  3 Jun 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JFMU//xg"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149491D54D;
	Mon,  3 Jun 2024 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717393864; cv=none; b=H8hyeiC9t9AMlnX+MPD+N32/MYJ1jtwe4/jKCRNbs66HkJvVbDNtx94q7zGJINIFjKyOZrdGMfMozqwhLkk0O6Z2Sa9hqQ2SfvBMO4Az8yQyvPRB/xaJ93JpZ4KE64Thl2bbjJF452oNwKTaYiel+g5/WG5n6RTtfq0ImQRM60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717393864; c=relaxed/simple;
	bh=uMGsc/61hNRADrGZxVf65rV7HllHnrDixdPpmqNacpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lPKyvEaIBFJ/A+mFANCktERqW9CdUYlhQ1I5Klv0mojM5j9aR9zUfxSPt81B4hkvOR5pZCXGzAVHm2ebN96vzWCjoni3V8iBT5K34JxxXPmw0n5EttGTfznGR7+hLMmEHMz97m7vlBjAJY1+SPi/AOAchX9mF+kP+YDLVbzseb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JFMU//xg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4535od7V062866;
	Mon, 3 Jun 2024 00:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717393839;
	bh=4tezTvsBvS4XRAl+qfRmXNgQcdSrlJtF1XHxBZw/4Z4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JFMU//xgHgVbiE70uXVZuWTLXrRckm1+rqfAdYa3wATSizRfIYChEBs95Peym077f
	 uGTvoHkeZ+3iBtWOR93Z/aeUCWpPOHDHJSoIUvPv5QxkSACWIwgAChZ4ApHHfmDEI4
	 OCzecYIxdwiKh7d4Uo2yqw8djrYiNZSPU3sP4Icw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4535odk3008598
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 00:50:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 00:50:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 00:50:39 -0500
Received: from [172.24.227.57] (linux-team-01.dhcp.ti.com [172.24.227.57])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4535oYBB004880;
	Mon, 3 Jun 2024 00:50:35 -0500
Message-ID: <dbb10d47-bc9c-4180-a063-bd51ba0d214c@ti.com>
Date: Mon, 3 Jun 2024 11:20:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
To: Randy Dunlap <rdunlap@infradead.org>, <schnelle@linux.ibm.com>,
        <wsa+renesas@sang-engineering.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <vigneshr@ti.com>, <rogerq@ti.com>,
        <danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <rogerq@kernel.org>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
 <98b1a3a4-5db8-4b69-9e3e-99f2dadf1b43@infradead.org>
Content-Language: en-US
From: Yojana Mallik <y-mallik@ti.com>
In-Reply-To: <98b1a3a4-5db8-4b69-9e3e-99f2dadf1b43@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/31/24 21:00, Randy Dunlap wrote:
> 
> 
> On 5/30/24 11:40 PM, Yojana Mallik wrote:
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>> index 1729eb0e0b41..4f00cb8fe9f1 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -145,6 +145,15 @@ config TI_AM65_CPSW_QOS
>>   	  The EST scheduler runs on CPTS and the TAS/EST schedule is
>>   	  updated in the Fetch RAM memory of the CPSW.
>>   
>> +config TI_K3_INTERCORE_VIRT_ETH
>> +	tristate "TI K3 Intercore Virtual Ethernet driver"
>> +	help
>> +	  This driver provides intercore virtual ethernet driver
>> +	  capability.Intercore Virtual Ethernet driver is modelled as
> 
> 	  capability. Intercore

I will fix this.

> 
>> +	  a RPMsg based shared memory ethernet driver for network traffic
> 
> 	  a RPMsg-based
> 

I will fix this.

>> +	  tunnelling between heterogeneous processors Cortex A and Cortex R
>> +	  used in TI's K3 SoCs.
> 
> 
> OK, the darned British spellings can stay. ;)
> (the double-l words)
>

I will fix this. Thankyou for pointing out the errors.

Regards,
Yojana Mallik


