Return-Path: <netdev+bounces-39047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213437BD885
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF202815A7
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C94182D2;
	Mon,  9 Oct 2023 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941A8827
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:29:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B86839F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 03:29:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF961FB;
	Mon,  9 Oct 2023 03:29:57 -0700 (PDT)
Received: from [10.57.69.35] (unknown [10.57.69.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EF233F7A6;
	Mon,  9 Oct 2023 03:29:14 -0700 (PDT)
Message-ID: <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
Date: Mon, 9 Oct 2023 11:29:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
 Greg Ungerer <gerg@linux-m68k.org>
References: <20231009074121.219686-1-hch@lst.de>
 <20231009074121.219686-6-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231009074121.219686-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-09 08:41, Christoph Hellwig wrote:
> The coldfire platforms can't properly implement dma_alloc_coherent and
> currently just return noncoherent memory from dma_alloc_coherent.
> 
> The fec driver than works around this with a flush of all caches in the
> receive path. Make this hack a little less bad by using the explicit
> dma_alloc_noncoherent API and documenting the hacky cache flushes so
> that the DMA API level hack can be removed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/net/ethernet/freescale/fec_main.c | 84 ++++++++++++++++++++---
>   1 file changed, 75 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 77c8e9cfb44562..aa032ea0ebf0c2 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -406,6 +406,70 @@ static void fec_dump(struct net_device *ndev)
>   	} while (bdp != txq->bd.base);
>   }
>   
> +/*
> + * Coldfire does not support DMA coherent allocations, and has historically used
> + * a band-aid with a manual flush in fec_enet_rx_queue.
> + */
> +#ifdef CONFIG_COLDFIRE

It looks a bit odd that this ends up applying to all of Coldfire, while 
the associated cache flush only applies to the M532x platform, which 
implies that we'd now be relying on the non-coherent allocation actually 
being coherent on other Coldfire platforms.

Would it work to do something like this to make sure dma-direct does the 
right thing on such platforms (which presumably don't have caches?), and 
then reduce the scope of this FEC hack accordingly, to clean things up 
even better?

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index b826e9c677b2..1851fa3fe077 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -27,6 +27,7 @@ config COLDFIRE
  	select CPU_HAS_NO_BITFIELDS
  	select CPU_HAS_NO_CAS
  	select CPU_HAS_NO_MULDIV64
+	select DMA_DEFAULT_COHERENT if !MMU && !M523x
  	select GENERIC_CSUM
  	select GPIOLIB
  	select HAVE_LEGACY_CLK


Thanks,
Robin.

> +static void *fec_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		gfp_t gfp)
> +{
> +	return dma_alloc_noncoherent(dev, size, handle, DMA_BIDIRECTIONAL, gfp);
> +}
> +
> +static void fec_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		dma_addr_t handle)
> +{
> +	dma_free_noncoherent(dev, size, cpu_addr, handle, DMA_BIDIRECTIONAL);
> +}
> +#else /* CONFIG_COLDFIRE */
> +static void *fec_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		gfp_t gfp)
> +{
> +	return dma_alloc_coherent(dev, size, handle, gfp);
> +}
> +
> +static void fec_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		dma_addr_t handle)
> +{
> +	dma_free_coherent(dev, size, cpu_addr, handle);
> +}
> +#endif /* !CONFIG_COLDFIRE */
> +
> +struct fec_dma_devres {
> +	size_t		size;
> +	void		*vaddr;
> +	dma_addr_t	dma_handle;
> +};
> +
> +static void fec_dmam_release(struct device *dev, void *res)
> +{
> +	struct fec_dma_devres *this = res;
> +
> +	fec_dma_free(dev, this->size, this->vaddr, this->dma_handle);
> +}
> +
> +static void *fec_dmam_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +		gfp_t gfp)
> +{
> +	struct fec_dma_devres *dr;
> +	void *vaddr;
> +
> +	dr = devres_alloc(fec_dmam_release, sizeof(*dr), gfp);
> +	if (!dr)
> +		return NULL;
> +	vaddr = fec_dma_alloc(dev, size, handle, gfp);
> +	if (!vaddr) {
> +		devres_free(dr);
> +		return NULL;
> +	}
> +	dr->vaddr = vaddr;
> +	dr->dma_handle = *handle;
> +	dr->size = size;
> +	devres_add(dev, dr);
> +	return vaddr;
> +}
> +
>   static inline bool is_ipv4_pkt(struct sk_buff *skb)
>   {
>   	return skb->protocol == htons(ETH_P_IP) && ip_hdr(skb)->version == 4;
> @@ -1661,6 +1725,10 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
>   #endif
>   
>   #ifdef CONFIG_M532x
> +	/*
> +	 * Hacky flush of all caches instead of using the DMA API for the TSO
> +	 * headers.
> +	 */
>   	flush_cache_all();
>   #endif
>   	rxq = fep->rx_queue[queue_id];
> @@ -3288,10 +3356,9 @@ static void fec_enet_free_queue(struct net_device *ndev)
>   	for (i = 0; i < fep->num_tx_queues; i++)
>   		if (fep->tx_queue[i] && fep->tx_queue[i]->tso_hdrs) {
>   			txq = fep->tx_queue[i];
> -			dma_free_coherent(&fep->pdev->dev,
> -					  txq->bd.ring_size * TSO_HEADER_SIZE,
> -					  txq->tso_hdrs,
> -					  txq->tso_hdrs_dma);
> +			fec_dma_free(&fep->pdev->dev,
> +				     txq->bd.ring_size * TSO_HEADER_SIZE,
> +				     txq->tso_hdrs, txq->tso_hdrs_dma);
>   		}
>   
>   	for (i = 0; i < fep->num_rx_queues; i++)
> @@ -3321,10 +3388,9 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
>   		txq->tx_stop_threshold = FEC_MAX_SKB_DESCS;
>   		txq->tx_wake_threshold = FEC_MAX_SKB_DESCS + 2 * MAX_SKB_FRAGS;
>   
> -		txq->tso_hdrs = dma_alloc_coherent(&fep->pdev->dev,
> +		txq->tso_hdrs = fec_dma_alloc(&fep->pdev->dev,
>   					txq->bd.ring_size * TSO_HEADER_SIZE,
> -					&txq->tso_hdrs_dma,
> -					GFP_KERNEL);
> +					&txq->tso_hdrs_dma, GFP_KERNEL);
>   		if (!txq->tso_hdrs) {
>   			ret = -ENOMEM;
>   			goto alloc_failed;
> @@ -4043,8 +4109,8 @@ static int fec_enet_init(struct net_device *ndev)
>   	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
>   
>   	/* Allocate memory for buffer descriptors. */
> -	cbd_base = dmam_alloc_coherent(&fep->pdev->dev, bd_size, &bd_dma,
> -				       GFP_KERNEL);
> +	cbd_base = fec_dmam_alloc(&fep->pdev->dev, bd_size, &bd_dma,
> +				  GFP_KERNEL);
>   	if (!cbd_base) {
>   		ret = -ENOMEM;
>   		goto free_queue_mem;

