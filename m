Return-Path: <netdev+bounces-47767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D77EB49C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DD51C20A3E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449E41A98;
	Tue, 14 Nov 2023 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="MCmVG1Q6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587041A94
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:18:33 +0000 (UTC)
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F04183
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:18:32 -0800 (PST)
Received: from tarshish (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id BD0064402E9;
	Tue, 14 Nov 2023 18:17:27 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699978647;
	bh=MXUufhnQc4E7e0CoSv9KYV8Jam2iwE7MtiQuj2v8Z0g=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=MCmVG1Q6KXRCTnBO3L53foF5Lr1LO4avTBnLrSPnTH8xCqUUlnssThGO0c1OYPSAG
	 /VwUG5GP2fF8TPm3AcnpvcyDoWY9AVYMqgAPC7uydHnTZFnIa/wvHjvu8S/mOUWbrD
	 cVQfL1oCR4ve8regqlS18XT/v9g17NGPpFrzzzX+3ajqFHUli+oa1+JWGCHiQ/Mv3x
	 dWL8cUDYsm7dAA/uBP32wR8RHtxhv2+ylGjzMeHVPDVbqVdDbirplv7ijcloUUrBFD
	 vtcvz/GjKcu/0e4+xOq1Hxwn6lzz+CBV2dr7uOkD0AGTWNPhsx9C5jEwKK7Xf6ngGp
	 m4eYMI0usa0Iw==
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
 <d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>
 <ysmqbuxjcgbcq4urtru5elda3dcbyejo2db3ds5cousy2trjdh@6fe774njbiam>
User-agent: mu4e 1.10.7; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: avoid rx queue overrun
Date: Tue, 14 Nov 2023 18:09:17 +0200
In-reply-to: <ysmqbuxjcgbcq4urtru5elda3dcbyejo2db3ds5cousy2trjdh@6fe774njbiam>
Message-ID: <874jhocnqi.fsf@tarshish>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Serge,

On Tue, Nov 14 2023, Serge Semin wrote:
> On Mon, Nov 13, 2023 at 07:42:50PM +0200, Baruch Siach wrote:
>> dma_rx_size can be set as low as 64. Rx budget might be higher than
>> that. Make sure to not overrun allocated rx buffers when budget is
>> larger.
>> 
>> Leave one descriptor unused to avoid wrap around of 'dirty_rx' vs
>> 'cur_rx'.
>
> Have you ever met the denoted problem? I am asking because what you
> say can happen only if the incoming traffic overruns the Rx-buffer,
> otherwise the loop will break on the first found DMA-own descriptor.
> But if that happens AFAICS the result will likely to be fatal because
> the stmmac_rx() method will try to handle the already handled and not
> yet recycled descriptor with no buffers assigned.

I have encountered this issue. When stmmac_rx() consumes all dma_rx_size
descriptors in one go, dirty_rx == cur_rx, which leads stmmac_rx_dirty()
to return zero. That in turn makes stmmac_rx_refill() skip
stmmac_set_rx_owner() so that Rx hangs completely.

> So after adding the Fixes tag feel tree to add:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks,
baruch

> -Serge(y)
>
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index f28838c8cdb3..2afb2bd25977 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -5293,6 +5293,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>>  
>>  	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
>>  	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
>> +	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
>>  
>>  	if (netif_msg_rx_status(priv)) {
>>  		void *rx_head;
>> -- 
>> 2.42.0
>> 
>> 


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

