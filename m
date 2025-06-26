Return-Path: <netdev+bounces-201405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC872AE952E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68283A9773
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB34218592;
	Thu, 26 Jun 2025 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xQp1igqh"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E04C83;
	Thu, 26 Jun 2025 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915907; cv=none; b=tf9SMx7tTCR/Wv5XpUHy7/SN5mmwIAg3hJzjabm0J1xXEN2IiyiRn8SpoPKf2gOuSl9tqZvgGcvsAje/3vVnZBe6U36r1c+c84wCOVBqgDW20DxHdRn2Z3KYKM2/WQc292Co/For1Wi+srA8brcw/h59eu2ySVUBkAepFs12kaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915907; c=relaxed/simple;
	bh=rIxvj9U2Es+PgGq1Z2rbceyIUBWUq3F6wlfrLINQunk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=efT4Z66RjRSp+woEN+/Ld1iWx02a/rRI3zLsUK/QLhsCQLNKatbRV44OMjkMjnjZEUCGI8rEbzrvk6yW+GEE3Y/WQ6DKyGpS30xx0ZC0f4yth97y6MsS0gfWYEzvzMgZ3zDBAqsOXEIwHomLkm0ghuEQii+pDWyZg8WtKbHY/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xQp1igqh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q5VUqn2359289;
	Thu, 26 Jun 2025 00:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750915890;
	bh=6bpepEW9f+DsBh8JOFLsFyO4rOle2MVrTGXFq+4Uh+c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xQp1igqhRCiAkthNQeimNbfBSeRvpAbq+1iAOvszWnKVhVmrG6Q6coWlul2+PuKLP
	 0F6Gguc7y4mxRRGqydIXGTV+VHYVr+IF5hgDb6i4RwisYL/K8WIIrJBobTpv7Aw6N7
	 AVVY8JBZdgLhBwofFq41mRpAVJSvbjHkY4Xy8Yqs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q5VUjd1684200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 00:31:30 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 00:31:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 00:31:29 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q5VP6e444546;
	Thu, 26 Jun 2025 00:31:25 -0500
Message-ID: <a57e0de4-3d54-4626-a6ae-a661fd36d130@ti.com>
Date: Thu, 26 Jun 2025 11:01:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by
 accounting for skb_shared_info
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>, <jacob.e.keller@intel.com>,
        <jpanis@baylibre.com>, <danishanwar@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250625112725.1096550-1-c-vankar@ti.com>
 <598f9e77-8212-426b-97ab-427cb8bd4910@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <598f9e77-8212-426b-97ab-427cb8bd4910@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Siddharth,

On 25/06/25 19:07, Siddharth Vadapalli wrote:
> On Wed, Jun 25, 2025 at 04:57:25PM +0530, Chintan Vankar wrote:
> 
> Hello Chintan,
> 
>> While transitioning from netdev_alloc_ip_align to build_skb, memory for
> 
> nitpick: Add parantheses when referring to functions:
> netdev_alloc_ip_align()
> build_skb()
> 
>> skb_shared_info was not allocated. Fix this by including
> 
> Enclose structures within double quotes and preferably refer to them
> in the context of an "skb":
> 
> ...memory for the "skb_shared_info" member of an "skb" was not allocated...
> 
>> sizeof(skb_shared_info) in the packet length during allocation.
>>
>> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
> 
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is based on the commit '9caca6ac0e26' of origin/main branch of
>> Linux-net repository.
>>
>>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index f20d1ff192ef..3905eec0b11e 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -857,6 +857,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
>>   	struct sk_buff *skb;
>>   
>>   	len += AM65_CPSW_HEADROOM;
>> +	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> 
> This could be added to the previous line itself:
> 
> 	len += AM65_CPSW_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> 
>>   
>>   	skb = build_skb(page_addr, len);
>>   	if (unlikely(!skb))
> 
> Thank you for finding the bug and fixing it.
> 

Thank you for reviewing patch. I have posted v2 by addressing your
comments at:
https://lore.kernel.org/r/20250626051226.2418638-1-c-vankar@ti.com/

Regards,
Chintan.

> Regards,
> Siddharth.

