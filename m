Return-Path: <netdev+bounces-47780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BFF7EB62E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C9C1C20AE7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883902AF19;
	Tue, 14 Nov 2023 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="ZecOo3P3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB192C1BD
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:14:09 +0000 (UTC)
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831FD121
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:14:07 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id AF8A9440576;
	Tue, 14 Nov 2023 20:13:03 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699985583;
	bh=5ZSVUMiPozNPbjLvDyJEKRkQZEv1+jBMbhUS03XMLrs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=ZecOo3P3y93oC675ZgM6E2Y0G0oIr5BvbRdVd6+fvRv/c3VyyNmpFSnnwumE8H+DB
	 6VO9dLIjajXeYyQJGh5/MC56VXG6SZcEJH6cyfTwNXsK1vuJFHkGKyoBNKuKdcyD5l
	 M9dtfoiWAKqYtb+IyyokrzaZC7b2B2Ee19ampk6nIKDIjd1Wcrq9DmUw2VK9J+zx2d
	 wxEA0Q5n7ESY7dO6j9Jlf2jFadL3Wmdu2WGmdeWddZJnQ9Ay4UWB+ntGnByGPKa4Dj
	 TaU2sKkXOX+3GbhJYfE7/9x0PheD3Qy6rF7MCMxMaBrZwlIhvOLjGZYV2XP0yri+LQ
	 3x+KYqmQ8VXfQ==
References: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
 <27ad91b102bf9555e61bb1013672c2bc558e97b9.1699945390.git.baruch@tkos.co.il>
 <qw2ymgim7ikxmgyznzdh7acf66rm62gqdkqnjpshgksdqkdar5@52gef7yifpfg>
User-agent: mu4e 1.10.7; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: reduce dma ring display
 code duplication
Date: Tue, 14 Nov 2023 20:06:14 +0200
In-reply-to: <qw2ymgim7ikxmgyznzdh7acf66rm62gqdkqnjpshgksdqkdar5@52gef7yifpfg>
Message-ID: <87zfzgb3te.fsf@tarshish>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Serge,

On Tue, Nov 14 2023, Serge Semin wrote:
> On Tue, Nov 14, 2023 at 09:03:10AM +0200, Baruch Siach wrote:
>> The code to show extended descriptor is identical to normal one.
>> Consolidate the code to remove duplication.
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v2: Fix extended descriptor case, and properly test both cases
>> ---
>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 39336fe5e89d..cf818a2bc9d5 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -6182,26 +6182,19 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
>>  	int i;
>>  	struct dma_extended_desc *ep = (struct dma_extended_desc *)head;
>>  	struct dma_desc *p = (struct dma_desc *)head;
>
>> +	unsigned long desc_size = extend_desc ? sizeof(*ep) : sizeof(*p);
>
> From readability point of view it's better to keep the initializers as
> simple as possible: just type casts or container-of-based inits. The
> more complex init-statements including the ternary-based ones is better to
> move to the code section closer to the place of the vars usage. So could
> you please move the initialization statement from the vars declaration
> section to being performed right before the loop entrance? It shall
> improve the readability a tiny bit.
>
>>  	dma_addr_t dma_addr;
>>  
>>  	for (i = 0; i < size; i++) {
>> -		if (extend_desc) {
>> -			dma_addr = dma_phy_addr + i * sizeof(*ep);
>> -			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
>> -				   i, &dma_addr,
>> -				   le32_to_cpu(ep->basic.des0),
>> -				   le32_to_cpu(ep->basic.des1),
>> -				   le32_to_cpu(ep->basic.des2),
>> -				   le32_to_cpu(ep->basic.des3));
>> -			ep++;
>> -		} else {
>> -			dma_addr = dma_phy_addr + i * sizeof(*p);
>> -			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
>> -				   i, &dma_addr,
>> -				   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
>> -				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
>> +		dma_addr = dma_phy_addr + i * desc_size;
>> +		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
>> +				i, &dma_addr,
>> +				le32_to_cpu(p->des0), le32_to_cpu(p->des1),
>> +				le32_to_cpu(p->des2), le32_to_cpu(p->des3));
>> +		if (extend_desc)
>> +			p = &(++ep)->basic;
>> +		else
>>  			p++;
>> -		}
>>  	}
>
> If I were simplifying/improving things I would have done it in the
> next way:

Thanks for your thorough review and detailed comments.

I find your suggestion more verbose for little readability
gain. Readability is a matter of taste, I guess.

I don't feel strongly about this patch. I would be fine with any
decision whether to take it in some form or not.

baruch

>
> static void stmmac_display_ring(void *head, int size, int extend_desc,
> 			       struct seq_file *seq, dma_addr_t dma_addr)
> {
>         struct dma_desc *p;
> 	size_t desc_size;
> 	int i;
>
> 	if (extend_desc)
> 		desc_size = sizeof(struct dma_extended_desc);
> 	else
> 		desc_size = sizeof(struct dma_desc);
>
> 	for (i = 0; i < size; i++) {
> 		if (extend_desc)
> 			p = &((struct dma_extended_desc *)head)->basic;
> 		else
> 			p = head;
>
> 		seq_printf(seq, "%d [%pad]: 0x%08x 0x%08x 0x%08x 0x%08x\n",
> 			   i, &dma_addr,
> 			   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
> 			   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
>
> 		dma_addr += desc_size;
> 		head += desc_size;
> 	}
> }
>
> 1. Add 0x%08x format to have the aligned data printout.
> 2. Use the desc-size to increment the virt and phys addresses for
> unification.
> 3. Replace sysfs_ prefix with stmmac_ since the method is no longer
> used for sysfs node.
>
> On the other hand having the extended data printed would be also
> useful at the very least for the Rx descriptors, which expose VLAN,
> Timestamp and IPvX related info. Extended Tx descriptors have only the
> timestamp in the extended part.
>
> -Serge(y)
>
>>  }

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

