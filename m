Return-Path: <netdev+bounces-34332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA827A349C
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3251C20A53
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD361C3D;
	Sun, 17 Sep 2023 08:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD121876;
	Sun, 17 Sep 2023 08:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61959C433C7;
	Sun, 17 Sep 2023 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694940454;
	bh=l+Sr+3wtCBb7xzBSEztJcEqZ8CXJywYnYrDfeKgva0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKlcyKI2kpWpgmNiueo4a26VAntMReflY2KPdNKBUoBv1OPJC6yo+TgJ/eYj1XNI8
	 YqWY7bQg8BuZ3eDnrfXfmIKcf36zE3/mU1QJDRa+G3zh0HnHqus3I/jAXZ6GcIZOWV
	 aacSttw4rLx/isPT7EN2NHNV4Bf2fIPH1KBMpkKuDkOk3ANTrlaBwkD8Or9uJsSG+y
	 LhmswnwVU6GJF2EXmjH0oIHPZWt+YiMwY34fc3sbjRWV0rxk3bK1wjdbs7hknE8LQ5
	 M1jBaGONdVNuOp0BlkXjkR8ws/A3YY3WWwdzpG2k855dT/l0o77y+ytD38Dpl2I6M9
	 4P2jSGmXhCBYA==
Date: Sun, 17 Sep 2023 10:47:28 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org, sujuan.chen@mediatek.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 13/15] net: ethernet: mtk_wed: introduce hw_rro
 support for MT7988
Message-ID: <20230917084728.GI1125562@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
 <da27f7333fa31808ceae581d9bef5030c6072f33.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da27f7333fa31808ceae581d9bef5030c6072f33.1694701767.git.lorenzo@kernel.org>

On Thu, Sep 14, 2023 at 04:38:18PM +0200, Lorenzo Bianconi wrote:
> From: Sujuan Chen <sujuan.chen@mediatek.com>
> 
> MT7988 SoC support 802.11 receive reordering offload in hw while
> MT7986 SoC implements it through the firmware running on the mcu.
> 
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>

...

Hi Lorenzo,

some minor feedback from my side.

> @@ -565,6 +565,73 @@ mtk_wed_free_tx_buffer(struct mtk_wed_device *dev)
>  	kfree(page_list);
>  }
>  
> +static int
> +mtk_wed_hwrro_buffer_alloc(struct mtk_wed_device *dev)
> +{
> +	int n_pages = MTK_WED_RX_PG_BM_CNT / MTK_WED_RX_BUF_PER_PAGE;
> +	struct mtk_wed_buf *page_list;
> +	struct mtk_wed_bm_desc *desc;
> +	dma_addr_t desc_phys;
> +	int i, page_idx = 0;
> +
> +	if (!dev->wlan.hw_rro)
> +		return 0;
> +
> +	page_list = kcalloc(n_pages, sizeof(*page_list), GFP_KERNEL);
> +	if (!page_list)
> +		return -ENOMEM;
> +
> +	dev->hw_rro.size = dev->wlan.rx_nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
> +	dev->hw_rro.pages = page_list;
> +	desc = dma_alloc_coherent(dev->hw->dev,
> +				  dev->wlan.rx_nbuf * sizeof(*desc),
> +				  &desc_phys, GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	dev->hw_rro.desc = desc;
> +	dev->hw_rro.desc_phys = desc_phys;
> +
> +	for (i = 0; i < MTK_WED_RX_PG_BM_CNT; i += MTK_WED_RX_BUF_PER_PAGE) {
> +		dma_addr_t page_phys, buf_phys;
> +		struct page *page;
> +		void *buf;
> +		int s;
> +
> +		page = __dev_alloc_page(GFP_KERNEL);
> +		if (!page)
> +			return -ENOMEM;
> +
> +		page_phys = dma_map_page(dev->hw->dev, page, 0, PAGE_SIZE,
> +					 DMA_BIDIRECTIONAL);
> +		if (dma_mapping_error(dev->hw->dev, page_phys)) {
> +			__free_page(page);
> +			return -ENOMEM;
> +		}
> +
> +		page_list[page_idx].p = page;
> +		page_list[page_idx++].phy_addr = page_phys;
> +		dma_sync_single_for_cpu(dev->hw->dev, page_phys, PAGE_SIZE,
> +					DMA_BIDIRECTIONAL);
> +
> +		buf = page_to_virt(page);
> +		buf_phys = page_phys;
> +
> +		for (s = 0; s < MTK_WED_RX_BUF_PER_PAGE; s++) {
> +			desc->buf0 = cpu_to_le32(buf_phys);
> +			desc++;
> +
> +			buf += MTK_WED_PAGE_BUF_SIZE;

clang-16 W=1 warns that buf is set but otherwise unused in this function.

> +			buf_phys += MTK_WED_PAGE_BUF_SIZE;
> +		}
> +
> +		dma_sync_single_for_device(dev->hw->dev, page_phys, PAGE_SIZE,
> +					   DMA_BIDIRECTIONAL);
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  mtk_wed_rx_buffer_alloc(struct mtk_wed_device *dev)
>  {

...

