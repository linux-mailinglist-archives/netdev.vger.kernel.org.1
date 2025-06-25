Return-Path: <netdev+bounces-201153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A479AE84A7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D89C6A24E2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FD25E453;
	Wed, 25 Jun 2025 13:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx-a.polytechnique.fr (mx-a.polytechnique.fr [129.104.30.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345353FD4;
	Wed, 25 Jun 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.104.30.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858070; cv=none; b=AIIKpcb2X3/l9m4uGxy1aUvVw31FqOQoMB3sfiAweZA/DyqmrD2c5J/B0UXt6cNHF8IFYiFs3LsVSfJSaciJT55eXwIGFc0BUD1OPYvdMa8o9K4Ge46+kCbaDkbJXKGCJ1h4ffH6TbEZ9jvzrPiVfU2A4pF2np+600WyUnu7lRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858070; c=relaxed/simple;
	bh=EMkbJPlhS92NnKFcknBrZgOb5HHbn9iZHQITh76fRww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/edovHEQyrH8f/bSN6j+qZq0LNrQo3tnior0aKGL3gmfkfyB1jWob9BWMS+bHmwmi3yzRVHK0ENpq/NsXprhsFDXesZR4qLZoTtWSkerNuAcv4xLg2cPkFGfPln5lLej8vsBZ5TKkqwlFPqJAqPze05wHG2tLkgTJIE5aou9Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=129.104.30.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from zimbra.polytechnique.fr (zimbra.polytechnique.fr [129.104.69.30])
	by mx-a.polytechnique.fr (tbp 25.10.18/2.0.8) with ESMTP id 55PDRMMJ028279;
	Wed, 25 Jun 2025 15:27:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by zimbra.polytechnique.fr (Postfix) with ESMTP id F2EA2761598;
	Wed, 25 Jun 2025 15:27:21 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.polytechnique.fr
Received: from zimbra.polytechnique.fr ([127.0.0.1])
 by localhost (zimbra.polytechnique.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0lf2ssbOzyF4; Wed, 25 Jun 2025 15:27:21 +0200 (CEST)
Received: from [129.88.52.32] (webmail-69.polytechnique.fr [129.104.69.39])
	by zimbra.polytechnique.fr (Postfix) with ESMTPSA id 9980E761F83;
	Wed, 25 Jun 2025 15:27:21 +0200 (CEST)
Message-ID: <ace152fe-877b-4df9-ba22-3c928bffa253@gmail.com>
Date: Wed, 25 Jun 2025 15:27:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethernet: cxgb4: Fix dma_unmap_sg() nents value
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250623122557.116906-2-fourier.thomas@gmail.com>
 <aFrBED5rhHtrN0sv@chelsio.com>
Content-Language: en-US, fr
From: Thomas Fourier <fourier.thomas@gmail.com>
In-Reply-To: <aFrBED5rhHtrN0sv@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/06/2025 17:17, Potnuri Bharat Teja wrote:
> On Monday, June 06/23/25, 2025 at 14:25:55 +0200, Thomas Fourier wrote:
>> The dma_unmap_sg() functions should be called with the same nents as the
>> dma_map_sg(), not the value the map function returned.
>>
>> Fixes: 8b4e6b3ca2ed ("cxgb4: Add HMA support")
>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
>> ---
>>   drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> index 51395c96b2e9..73bb1f413761 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> @@ -3998,7 +3998,7 @@ static void adap_free_hma_mem(struct adapter *adapter)
>>   
>>   	if (adapter->hma.flags & HMA_DMA_MAPPED_FLAG) {
>>   		dma_unmap_sg(adapter->pdev_dev, adapter->hma.sgt->sgl,
>> -			     adapter->hma.sgt->nents, DMA_BIDIRECTIONAL);
>> +			     adapter->hma.sgt->orig_nents, DMA_BIDIRECTIONAL);
>>   		adapter->hma.flags &= ~HMA_DMA_MAPPED_FLAG;
>>   	}
> Thanks for the patch Thomas.
> this fix needs below change as well:
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -4000,7 +4000,7 @@ static void adap_free_hma_mem(struct adapter *adapter)
>          }
>
> 	for_each_sg(adapter->hma.sgt->sgl, iter,	
> -                   adapter->hma.sgt->orig_nents, i) {
> +                   adapter->hma.sgt->nents, i) {
>                  page = sg_page(iter);
> 		if (page)
>                          __free_pages(page, HMA_PAGE_ORDER);		
>   

I don't think this change is correct since this loop iterates over all 
the pages

allocated at line 4076, not over the dma mapped pages.

It also seems that when passing the dma addresses to hardware,

the newpage assignment is not used line 4104 and that the dma mapping

length is not given to hardware.  Is that correct?

>> -- 
>> 2.43.0
>>

