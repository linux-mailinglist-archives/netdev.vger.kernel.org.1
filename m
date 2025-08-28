Return-Path: <netdev+bounces-217612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E4B3942F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628FD7C14C7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48C274659;
	Thu, 28 Aug 2025 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HHeluEfn"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7F23D7D3;
	Thu, 28 Aug 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363746; cv=none; b=NG82Ea8L62UQtAZlhzIkHdx+jpyEHFFsBkfZzmHIKVPVQhsDBmwDl6Z5DZ9IjYJIo9tzS14Z6wNhZ80o7ZmJtRxyZPB1eml6hTX7LAia58VFz3fF6S0HVEEJpfdnA7lpXgPMvgKt+YO/dj1JgBDALJovdMqdVIFWBU7WasnBv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363746; c=relaxed/simple;
	bh=JdQdj8/quONTRyAY1rYDuGFUboEOavKxJa5vBtUfRBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DIBn0MCGBmtcK84a6nWK/7PsrGH7+AfUHl/uYTO2yz2NuIFSTV+pv1uc+PDYPwKjl14JVyhivGG1WK+XwlQzsePJOV8yUZf5t5tSfxbNrGXh0DDTARSWExaSma8k1HCcegNs5PCtDCmsocWTXJ810Vc/7DFPb848uO1Nq8lA3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HHeluEfn; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57S6m3xH1922557;
	Thu, 28 Aug 2025 01:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756363683;
	bh=bRbLC9YRMEiIy0hEue35yrv0+2UC5iBSB3Rlj7DldO0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HHeluEfnSghIj47SW6dN2IgVyuEECGnUGjUUhsyilUOcFtY3Hgtmp/PNv2UJZuNKJ
	 FFIgS8xsdyevy22IB/ohdZXxDMNj0n8OkFhxBjgYhPFHHdCyQn1sDbYdKFJJIcF5EO
	 Bl4ixkep5MOY6YCmNJDUAjMg+1X+WR4HQjgR6BJU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57S6m3Gu3038278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 01:48:03 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 01:48:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 01:48:02 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57S6lsTv182199;
	Thu, 28 Aug 2025 01:47:55 -0500
Message-ID: <37a7ce7d-f34b-4734-8c05-722f6d369193@ti.com>
Date: Thu, 28 Aug 2025 12:17:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/5] Add driver for 1Gbe network chips from
 MUCSE
To: Yibo Dong <dong100@mucse.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <corbet@lwn.net>, <gur.stavi@huawei.com>, <maddy@linux.ibm.com>,
        <mpe@ellerman.id.au>, <lee@trager.us>, <gongfan1@huawei.com>,
        <lorenzo@kernel.org>, <geert+renesas@glider.be>,
        <Parthiban.Veerasooran@microchip.com>, <lukas.bulwahn@redhat.com>,
        <alexanderduyck@fb.com>, <richardcochran@gmail.com>, <kees@kernel.org>,
        <gustavoars@kernel.org>, <rdunlap@infradead.org>,
        <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20250828025547.568563-1-dong100@mucse.com>
 <0651d5a9-dd02-4936-94b8-834bd777003c@ti.com>
 <BC262E8E0C675110+20250828053659.GA645649@nic-Precision-5820-Tower>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <BC262E8E0C675110+20250828053659.GA645649@nic-Precision-5820-Tower>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 28/08/25 11:06 am, Yibo Dong wrote:
> On Thu, Aug 28, 2025 at 10:52:21AM +0530, MD Danish Anwar wrote:
>> Hi Dong Yibo,
>>
>> On 28/08/25 8:25 am, Dong Yibo wrote:
>>> Hi maintainers,
>>>
>>> This patch series is v9 to introduce support for MUCSE N500/N210 1Gbps
>>> Ethernet controllers. I divide codes into multiple series, this is the
>>> first one which only register netdev without true tx/rx functions.
>>>
>>> Changelog:
>>> v8 -> v9:
>>> 1. update function description format '@return' to 'Return' 
>>> 2. update 'negative on failure' to 'negative errno on failure'
>>>
>>> links:
>>> v8: https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
>>> v7: https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
>>> v6: https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
>>> v5: https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
>>> v4: https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
>>> v3: https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
>>> v2: https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
>>> v1: https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/
>>
>> Please wait for at least 24 hours before posting a new version. You
>> posted v8 yesterday and most folks won't have noticed v8 by now or they
>> maybe looking to give comments on v8. But before they could do that you
>> posted v9.
>>
>> Keep good amount of gaps between the series so that more folks can look
>> at it. 24 hours is the minimum.
>>
>> -- 
>> Thanks and Regards,
>> Danish
>>
>>
> 
> Got it, I found the v8 pathes state in websit:
> https://patchwork.kernel.org/project/netdevbpf/list/
> It is 'Changes Requested'. 
> I mistakenly thought that a new version needed to be sent. I will wait

That's correct. 'Changes Requested' means that version will no longer be
accepted and you have to send a newer one. But that doesn't mean you
have to send it immediately.

https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html#i-have-received-review-feedback-when-should-i-post-a-revised-version-of-the-patches


> more time in the next time.
> 
> Thanks for you feedback.

-- 
Thanks and Regards,
Danish


