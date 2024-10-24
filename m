Return-Path: <netdev+bounces-138446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0499AD9FA
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC89A1F21F31
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7D446A1;
	Thu, 24 Oct 2024 02:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26217442F
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737369; cv=none; b=jxBEAmVsYDQaoWoy01zfbCGR+m82R6hiHrluLKfOEzz7LqcaW89FU8kVg9y7hMV1E/aQH/mhWCqk3MteLenfZN8fuPnOzGL38OBPuicY6ew4rLaStLKKku3qlHEf4FHfbplGWbbhAID97Hrpn0KNJJ2i4THXXkMaCqC/1yMRUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737369; c=relaxed/simple;
	bh=vzlzubPzBmB0kW3eMXZgvQQaf8+nL09KeVyAvMkKUvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=svByzjtcIridy5cUm910PpsSs1/hUlttjPKByMbF92kcmJNQRF1VAPVjmJ2j4th+HsRm+3qfwyCKGNFfszZuYiysw5RGZVSEkOqsIihc6rUqmPsoy6aKSrGMdslMYSqcg/RW+Q2wHoYUi2Dw3Ov3lArr4xB3Y4eOHwjk3X9MZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYqkQ6gSKz2FbJ4;
	Thu, 24 Oct 2024 10:34:38 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EDBBC14022D;
	Thu, 24 Oct 2024 10:36:02 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 10:36:02 +0800
Message-ID: <cf13ffde-2a5f-4845-a27d-d4789a384891@huawei.com>
Date: Thu, 24 Oct 2024 10:36:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] gve: change to use page_pool_put_full_page when
 recycling pages
To: Praveen Kaligineedi <pkaligineedi@google.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <willemb@google.com>,
	<jeroendb@google.com>, <shailend@google.com>, <hramamurthy@google.com>,
	<ziweixiao@google.com>, <jacob.e.keller@intel.com>
References: <20241023221141.3008011-1-pkaligineedi@google.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241023221141.3008011-1-pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/24 6:11, Praveen Kaligineedi wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> The driver currently uses page_pool_put_page() to recycle
> page pool pages. Since gve uses split pages, if the fragment
> being recycled is not the last fragment in the page, there
> is no dma sync operation. When the last fragment is recycled,
> dma sync is performed by page pool infra according to the
> value passed as dma_sync_size which right now is set to the
> size of fragment.
> 
> But the correct thing to do is to dma sync the entire page when
> the last fragment is recycled. Hence change to using
> page_pool_put_full_page().

I am not sure if Fixes tag is needed if the blamed commit is only
in the net-next tree. Otherwise, LGTM.

Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> 
> Link: https://lore.kernel.org/netdev/89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com/
> 
> Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 05bf1f80a79c..403f0f335ba6 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -210,8 +210,7 @@ void gve_free_to_page_pool(struct gve_rx_ring *rx,
>  	if (!page)
>  		return;
>  
> -	page_pool_put_page(page->pp, page, buf_state->page_info.buf_size,
> -			   allow_direct);
> +	page_pool_put_full_page(page->pp, page, allow_direct);
>  	buf_state->page_info.page = NULL;
>  }
>  

