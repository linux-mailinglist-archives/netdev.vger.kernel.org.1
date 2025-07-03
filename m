Return-Path: <netdev+bounces-203648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1B2AF69B3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E117C16B932
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92066288C21;
	Thu,  3 Jul 2025 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wbw0l3oq"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B15A2D;
	Thu,  3 Jul 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520239; cv=none; b=aJpbpC1DHKwF6SSDaU+OL5Tt6ALYjnzWxlIYQsvzKWeR402lhbCEqxSIlTzbRycgikudcnRyjMsbSwFAMPLvg0trzuittsX0owMstsusxg+lZjVJ8/ShdfJQxc556ArSJdx76FlzonwztM9ClOd1ReJOxeXvlYK73SKlqtJT4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520239; c=relaxed/simple;
	bh=EtoSA3VHJSWBfagW7ggQB3tJ1+3hNatvkz5DniWklAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OBpV3A6PpGkQrgm/kUWxfXz+gAsZrxL4kZUGl/yIRslcVmwr8yUEFy7vYwZYFtIFRhs0C7S+6xH9ogKUCzg30Crs9JtHQgC7epvDCiQSWiEXnkx4HhK+l4QGixKGnHAtbyBh+qJ8ZCx5JhK5RlKGQYdJoblICI6Dw+h+6hgyopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wbw0l3oq; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5635NieZ3434909;
	Thu, 3 Jul 2025 00:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751520224;
	bh=1S3pKObAAMv/1F4yr4SBhJZKzZhbIJykyhQ4qvCndNg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Wbw0l3oqL4/rixWyINFJeo0ZSkz7qHcrG47gl/oXIj+8eVEHy2S6V/jnTSr1IJ2d+
	 SD5y+NVXbwVfTN+hQx2+u7WmEQYydXHHxcRg8vwsFHeMdKcEEUiyUcb8YjDKGRIG+e
	 BDvGNp2acph+WjRXF5QrVWsOpuYqaeWVwnPgrB8s=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5635NhJP057019
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 3 Jul 2025 00:23:43 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 00:23:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 00:23:42 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5635Ncic540229;
	Thu, 3 Jul 2025 00:23:39 -0500
Message-ID: <95d7cf5c-6995-401a-b9de-08b82482b175@ti.com>
Date: Thu, 3 Jul 2025 10:53:37 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by
 accounting for skb_shared_info
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <horms@kernel.org>,
        <mwalle@kernel.org>, <jacob.e.keller@intel.com>, <jpanis@baylibre.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250626051226.2418638-1-c-vankar@ti.com>
 <20250627170835.75c73445@kernel.org>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20250627170835.75c73445@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Jakub,

On 28/06/25 05:38, Jakub Kicinski wrote:
> On Thu, 26 Jun 2025 10:42:26 +0530 Chintan Vankar wrote:
>> While transitioning from netdev_alloc_ip_align() to build_skb(), memory
>> for the "skb_shared_info" member of an "skb" was not allocated. Fix this
>> by including sizeof(skb_shared_info) in the packet length during
>> allocation.
>>
>> Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is based on the commit '9caca6ac0e26' of origin/main branch of
>> Linux-net repository.
>>
>> Link to v1:
>> https://lore.kernel.org/r/598f9e77-8212-426b-97ab-427cb8bd4910@ti.com/
>>
>> Changes from v1 to v2:
>> - Updated commit message and code change as suggested by Siddharth
>>    Vadapalli.
>>
>>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index f20d1ff192ef..67fef2ea4900 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -856,7 +856,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
>>   {
>>   	struct sk_buff *skb;
>>   
>> -	len += AM65_CPSW_HEADROOM;
>> +	len += AM65_CPSW_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>   
>>   	skb = build_skb(page_addr, len);
> 
> Looks to me like each packet is placed in a full page, isn't it?
> If that's the case the correct value for "buffer size" is PAGE_SIZE


Thanks for reviewing the patch and pointing this out. Since the maximum
packet size received from the wire is AM65_CPSW_MAX_PACKET_SIZE that is
2024 Bytes, after adding headroom and tailroom, the total Bytes will
remain below the minimum page size available that is 4096, it is better
to use PAGE_SIZE.

Regards,
Chintan.

