Return-Path: <netdev+bounces-139505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80249B2E66
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE61F21877
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1B1DED7F;
	Mon, 28 Oct 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V0PV4PaS"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB771DA0EB;
	Mon, 28 Oct 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113554; cv=none; b=pZ3tqqXs9X3+vJ1oSlCFcDLzD7ps6wBvDEQ0W355Ij3rUY8h/N//lYXcrj6Os7XX2pyotX2kQVrzu89eMbmkZRxHusY8+Ahdl773whmTNwbwUB1WXCEZvXZwDeRc7afPSCC30WB+m5X+L1Evu/ekKLP6lK81NroGf3Qf1pyY06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113554; c=relaxed/simple;
	bh=D0wS5lVtp7RHP8hKc6v5AFVgNs86gujc2DVkFKviJpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NshFy5Ym/Esa9PJtBJwaF0cfFq5wH54rm8GNhny08eNTf2ROQvFAJEImQupkifnVcVkFKF2nalrQ2YBoK+/7x7fWSTR7ouDJ1vbUa8pzEKg9tOMvt6Ps+Mz/MrNjID6ULbaVE8Qid4hQnEvK/qbbFhFkDT/xicX4pBGmI0azHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V0PV4PaS; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SB5DfL072486;
	Mon, 28 Oct 2024 06:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730113513;
	bh=ptxN7UQx680+8Nep+cFTxjI9+zmvMwutLIQwIT3A9BA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=V0PV4PaS1bEc3epVawS7wXANJouMPBMRniKiFy0N/XG6H0nFPJGCYx12UiCL/ICi9
	 B1iLpaq4Z61Om8O5zNFPkeHgU+oaUjhLpI+LxfUhhT0wf1cLkrY1C5pNYVeaQrPd2D
	 xe1BJzF7i0bCZ+z138UQYrQd9Jgekoik9MCv+PfQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SB5DDZ047842;
	Mon, 28 Oct 2024 06:05:13 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 06:05:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 06:05:13 -0500
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SB58Ln020827;
	Mon, 28 Oct 2024 06:05:08 -0500
Message-ID: <a2848e9f-028e-4d58-87e4-50848fe4bca1@ti.com>
Date: Mon, 28 Oct 2024 16:35:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix 1 PPS sync
To: Andrew Lunn <andrew@lunn.ch>
CC: <vigneshr@ti.com>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241024113140.973928-1-m-malladi@ti.com>
 <1a0a632e-0b3c-4192-8d00-51d23c15c97e@lunn.ch>
 <060c298c-5961-467a-80dd-947c85207eea@ti.com>
 <2288a9a9-f9d0-4414-80a2-e11ba66fad50@lunn.ch>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <2288a9a9-f9d0-4414-80a2-e11ba66fad50@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 25/10/24 18:52, Andrew Lunn wrote:
> On Fri, Oct 25, 2024 at 11:17:44AM +0530, Meghana Malladi wrote:
>>
>>
>> On 25/10/24 01:25, Andrew Lunn wrote:
>>>> +static inline u64 icssg_readq(const void __iomem *addr)
>>>> +{
>>>> +	return readl(addr) + ((u64)readl(addr + 4) << 32);
>>>> +}
>>>> +
>>>> +static inline void icssg_writeq(u64 val, void __iomem *addr)
>>>> +{
>>>> +	writel(lower_32_bits(val), addr);
>>>> +	writel(upper_32_bits(val), addr + 4);
>>>> +}
>>>
>>> Could readq() and writeq() be used, rather than your own helpers?
>>>
>>> 	Andrew
>>>
>> The addresses we are trying to read here are not 64-bit aligned, hence using
>> our own helpers to read the 64-bit value.
> 
> Ah, you should document this, because somebody might do a drive by
> patch converting this to readq()/write(q).
> 
> Alternatively, i think hi_lo_writeq() would work.
> 
> 	Andrew
I tried hi_lo_readq() and hi_lo_writeq(), and it is fitting my 
requirement. Thanks, I will update it.

Regards,
Meghana

