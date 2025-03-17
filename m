Return-Path: <netdev+bounces-175250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C868A6493C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF13B5485
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19492376E1;
	Mon, 17 Mar 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RWiRBNVE"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03D239586
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206447; cv=none; b=dV2Sbm5hpH9jFodQhPkieGA6u4bX6YOwHIdy5ojvAD7/WJQ/6Zh5blTCRM429OblzOSayJvFmj5lHWfKsrRD7G5300KeNRgGv6G1b7GlbfR7pR6kWKHx5Hde1ye69TsgIEdP3w7k545M0EzdZULf4Y4LglZAPk7q7ARQLZbVdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206447; c=relaxed/simple;
	bh=qA2DWbWK+y+2LCjli8MLWF0xhWHk1GbzjeWkgfVbf1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e6hHqJW/d/e3UBI4cvowOYF8LuxLIg4JJUBRk5QGYhF4kr5Cm8xdNb9prJmZSdMDdWET4wzWeDI+WqpT6dtVQgQzDQaOyaNP1GSAnWGUxD6UmzxhlKQBiY9jVxVEMbWf18oMTYWYfrLo5MmaVgPEREor1kRSwZCpSnFoIfgiT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RWiRBNVE; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52HADxAB2247647
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Mar 2025 05:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742206439;
	bh=x4Slj5yj6G5kRuvXXZOObsp/raaiilax7WtVv0791qQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RWiRBNVEF9xBgyJH4cUTL6qKv5YHWxcrug4V9VshSq0rDeRv1SNXBcTJrhUQu/1Sf
	 ZFPc1Dv7l2eaRaxeqzTTP+vW8pMNlRXSNlsTsjwDeMQMRHQxSwwXMmByf1N4CnGOOQ
	 6rDeDXyFZWwa4tCBNNFFMa8jSBMKHTBIU5yiDzmI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52HADxM7074977;
	Mon, 17 Mar 2025 05:13:59 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Mar 2025 05:13:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Mar 2025 05:13:59 -0500
Received: from [172.24.27.245] (lt9560gk3.dhcp.ti.com [172.24.27.245])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52HADv4L033751;
	Mon, 17 Mar 2025 05:13:58 -0500
Message-ID: <0d4d2010-79e3-47d3-bcef-d6140fc68596@ti.com>
Date: Mon, 17 Mar 2025 15:43:56 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [bug report] net: ti: icssg-prueth: Add XDP
 support
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <netdev@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>
References: <70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain>
 <a497632b-3754-42f2-9b7b-1821fee0c136@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <a497632b-3754-42f2-9b7b-1821fee0c136@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dan,

On 3/15/2025 2:01 AM, Roger Quadros wrote:
> +Meghana, On 14/03/2025 12: 50, Dan Carpenter wrote: > Hello Roger 
> Quadros, > > Commit 62aa3246f462 ("net: ti: icssg-prueth: Add XDP 
> support") from > Mar 5, 2025 (linux-next), leads to the following Smatch 
> static > checker warning: 
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> updgPZavlq17YEXEXDMjX3l3H00pWvtYT_4pQscvyXpIdw2OveCVYQibZIdWxZw5GR1hxtmi6vr2_ObXj1T_qBc3C0dxD5U$>
> ZjQcmQRYFpfptBannerEnd
> 
> +Meghana,
> 
> On 14/03/2025 12:50, Dan Carpenter wrote:
>> Hello Roger Quadros,
>> 
>> Commit 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support") from
>> Mar 5, 2025 (linux-next), leads to the following Smatch static
>> checker warning:
>> 
>> 	drivers/net/ethernet/ti/icssg/icssg_common.c:635 emac_xmit_xdp_frame()
>> 	error: we previously assumed 'first_desc' could be null (see line 584)
>> 
>> drivers/net/ethernet/ti/icssg/icssg_common.c
>>    563  u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
>>    564                          struct xdp_frame *xdpf,
>>    565                          struct page *page,
>>    566                          unsigned int q_idx)
>>    567  {
>>    568          struct cppi5_host_desc_t *first_desc;
>>    569          struct net_device *ndev = emac->ndev;
>>    570          struct prueth_tx_chn *tx_chn;
>>    571          dma_addr_t desc_dma, buf_dma;
>>    572          struct prueth_swdata *swdata;
>>    573          u32 *epib;
>>    574          int ret;
>>    575  
>>    576          if (q_idx >= PRUETH_MAX_TX_QUEUES) {
>>    577                  netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);
>>    578                  return ICSSG_XDP_CONSUMED;      /* drop */
>> 
>> Do we need to free something on this path?
>> 

Freeing the page is handled by the caller of this function based of the 
return type.

>>    579          }
>>    580  
>>    581          tx_chn = &emac->tx_chns[q_idx];
>>    582  
>>    583          first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
>>    584          if (!first_desc) {
>>    585                  netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
>>    586                  goto drop_free_descs;   /* drop */
>>                         ^^^^^^^^^^^^^^^^^^^^
>> This will dereference first_desc and crash.
>> 

Thanks for catching this bug, will post fix for this shortly.

>>    587          }
>>    588  
>>    589          if (page) { /* already DMA mapped by page_pool */
>>    590                  buf_dma = page_pool_get_dma_addr(page);
>>    591                  buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
>>    592          } else { /* Map the linear buffer */
>>    593                  buf_dma = dma_map_single(tx_chn->dma_dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
>>    594                  if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
>>    595                          netdev_err(ndev, "xdp tx: failed to map data buffer\n");
>>    596                          goto drop_free_descs;   /* drop */
>>    597                  }
>>    598          }
>>    599  
>>    600          cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>>    601                           PRUETH_NAV_PS_DATA_SIZE);
>>    602          cppi5_hdesc_set_pkttype(first_desc, 0);
>>    603          epib = first_desc->epib;
>>    604          epib[0] = 0;
>>    605          epib[1] = 0;
>>    606  
>>    607          /* set dst tag to indicate internal qid at the firmware which is at
>>    608           * bit8..bit15. bit0..bit7 indicates port num for directed
>>    609           * packets in case of switch mode operation
>>    610           */
>>    611          cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
>>    612          k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>    613          cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
>>    614          swdata = cppi5_hdesc_get_swdata(first_desc);
>>    615          if (page) {
>>    616                  swdata->type = PRUETH_SWDATA_PAGE;
>>    617                  swdata->data.page = page;
>>    618          } else {
>>    619                  swdata->type = PRUETH_SWDATA_XDPF;
>>    620                  swdata->data.xdpf = xdpf;
>>    621          }
>>    622  
>>    623          cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
>>    624          desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
>>    625  
>>    626          ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
>>    627          if (ret) {
>>    628                  netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
>>    629                  goto drop_free_descs;
>>    630          }
>>    631  
>>    632          return ICSSG_XDP_TX;
>>    633  
>>    634  drop_free_descs:
>>    635          prueth_xmit_free(tx_chn, first_desc);
>>    636          return ICSSG_XDP_CONSUMED;
>>    637  }
>> 
>> 
>> regards,
>> dan carpenter
> 
> -- 
> cheers,
> -roger
> 


