Return-Path: <netdev+bounces-200641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D1AE66D5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AAB1894000
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3522C15A3;
	Tue, 24 Jun 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qkby1Lrg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14142C1583
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772556; cv=none; b=K8naP9hCsJfmiC6QyRQY9+PWtJATl4375/IWRTrM/7Nff8nyuFgTgM10ouRELFoAbBckYL9bNr9DWuq6WJch1Z+7qUEYJefeE5LLu451x2UnE2m+4RONGE4VRsxL7SV4uqeGTX+GZ/Zjnm9B+7otoWDuHtlCGnlDfat9k9c7+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772556; c=relaxed/simple;
	bh=fkCKFp+R4NgDfnzuO2tWofrBCbSr7XsJ+eRJJT2WB5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvrICUQMozKMr0+E97vL46ElRTdamJK7xCvgZEn/kH3octGHRFIAcruHjr4NE0l2XpVTRIioaTNgm0c24NgtRs9aHlM8YtdVr8BSLnxBWgImU1ozYNoUyAXam7rB4cHHbW6OIARYFEkGfttM6VO+cgxw7BovAJWicp5NQIrzKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qkby1Lrg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750772553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvwWzJ+xEypawpGYP8KNWgLGz+0unVKUFrWTYj+42lI=;
	b=Qkby1Lrgsnp1FijgZ22z+kxOJ6KQu+sMgdu5Sj4UZSBUIIxZ+DkfbwVCpvdKYmZW6kOlie
	ldJpPFlNmNQ3Kdv7zIRZrjOqKbIOTdCg6bIOJc2ZkIDMYBp1UUaV6HXBpuSC6Va/n67b1J
	oa7mzaj9EDX0W4I9fs6t+YlSNkIS5fE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-ckCfVOpgM1iE5JoHX8XO_A-1; Tue, 24 Jun 2025 09:42:32 -0400
X-MC-Unique: ckCfVOpgM1iE5JoHX8XO_A-1
X-Mimecast-MFC-AGG-ID: ckCfVOpgM1iE5JoHX8XO_A_1750772551
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4535ee06160so37979245e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 06:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750772551; x=1751377351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvwWzJ+xEypawpGYP8KNWgLGz+0unVKUFrWTYj+42lI=;
        b=bZpOem3FWt2+CNP8d7VA4N8Zhqm1vwENXBdnO0c/+3kuTM61PRirs0MNtXuUSQyQnV
         sgps+5eGMIPfmJYrrg1iGgdX2Xrh6L4zfmsV/AjnuCgh4w42x/LgagtC4K1CFNEnQ1fK
         MkogshSGqlQ5uWuTlBEBs0251zg6BPysTftAQhNiwMcQ3gntXQgRgAf68C+UOPGes3ZU
         cfPzZtsghFbWyj5yKyPlNj8Em/xfBA0cSHDHSpCS8x2CsXXI3XhQ5YzjlHJ0l4ZTMzmx
         uIDZlkaWRYzRMr5YtMrqdp8LxQ1IHYY3rIx4O9MGRy5dJ56FQvm1S9nrOyQ03XBiqtr0
         3qwg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5x/dRKa9ltVURX/V0I2r9l7D3A0LCMCEp+zvXwKuJs9FwvT1iEZlt2Sc3rOpizhXnabWINU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dqFi5EJ1vnVZNvlrE07gzqTrvf7EDtzj9Fz2lbEI1v1dvUE8
	CTDm8pYKFZTKtxEJ37AFSpG0iFpKh/ksI7rr4ySMjybd0u3qkIl02sC8diiGCVV8Ckj4DJsZEAw
	eUrT77d/0AtXfWRlw+ID2Cv8liwvBPeNEXrDuUBVVbo1DiSnmtjbSIH7+Vw==
X-Gm-Gg: ASbGncsqESttodiJM92hJovXJkRo9JXgfAzPGR7bCJVE3UsqN8i/dYWB+LE4VKyFSW3
	KxcyHz4WQii2mlJawthvIk2aiq+RH4STuby/Vv8UiCWzmDAGZJ2H4EoIAwX4nW+3Fti/sbfKdW1
	Ig67R9/HAvr/X2j4nes5t4bYZnVmT1Zs8C1QUKQHF9Jb+XI9SQZ6cOWU5GD4Q1AhIyfNkC6qOYB
	72Mpg41V4nYaqIlwR5wABBBfbN5kpiEckVOgsT5kW9hBgi04A+YSxQAtpOIlfJQ5zQuaIkwKEcJ
	6CBKieL6QDghMO4UPkLi9yAVYrpLwA==
X-Received: by 2002:a05:600c:a07:b0:450:d3c6:84d8 with SMTP id 5b1f17b1804b1-453659caaddmr170383405e9.14.1750772551210;
        Tue, 24 Jun 2025 06:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2Sny+uxCfoL7TQtqauFQPpY8QI669KPmHR2EgF9N41ErRRuNQBKLCDGmFU7bbd2Ddpv4HTQ==
X-Received: by 2002:a05:600c:a07:b0:450:d3c6:84d8 with SMTP id 5b1f17b1804b1-453659caaddmr170382835e9.14.1750772550636;
        Tue, 24 Jun 2025 06:42:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45374582452sm67189385e9.31.2025.06.24.06.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:42:30 -0700 (PDT)
Message-ID: <c82c19a6-fd0f-4efe-9d93-838b52102ff4@redhat.com>
Date: Tue, 24 Jun 2025 15:42:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v13 05/11] net: mtip: Add net_device_ops functions to
 the L2 switch driver
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
References: <20250622093756.2895000-1-lukma@denx.de>
 <20250622093756.2895000-6-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250622093756.2895000-6-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 11:37 AM, Lukasz Majewski wrote:
> This patch provides callbacks for struct net_device_ops for MTIP
> L2 switch.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v13:
> - New patch - created by excluding some code from large (i.e. v12 and
>   earlier) MTIP driver
> ---
>  .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 273 ++++++++++++++++++
>  1 file changed, 273 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 5142f647d939..813cd39d6d56 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -43,6 +43,15 @@
>  
>  #include "mtipl2sw.h"
>  
> +static void swap_buffer(void *bufaddr, int len)
> +{
> +	int i;
> +	unsigned int *buf = bufaddr;
> +
> +	for (i = 0; i < len; i += 4, buf++)
> +		swab32s(buf);
> +}
> +
>  /* Set the last buffer to wrap */
>  static void mtip_set_last_buf_to_wrap(struct cbd_t *bdp)
>  {
> @@ -444,6 +453,128 @@ static void mtip_config_switch(struct switch_enet_private *fep)
>  	       fep->hwp + ESW_IMR);
>  }
>  
> +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> +					struct net_device *dev, int port)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	unsigned short status;
> +	struct cbd_t *bdp;
> +	void *bufaddr;
> +
> +	spin_lock_bh(&fep->hw_lock);
> +
> +	if (!fep->link[0] && !fep->link[1]) {
> +		/* Link is down or autonegotiation is in progress. */
> +		netif_stop_queue(dev);
> +		spin_unlock_bh(&fep->hw_lock);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	/* Fill in a Tx ring entry */
> +	bdp = fep->cur_tx;
> +
> +	status = bdp->cbd_sc;
> +
> +	if (status & BD_ENET_TX_READY) {
> +		/* All transmit buffers are full. Bail out.
> +		 * This should not happen, since dev->tbusy should be set.
> +		 */
> +		netif_stop_queue(dev);
> +		dev_err(&fep->pdev->dev, "%s: tx queue full!.\n", dev->name);
> +		spin_unlock_bh(&fep->hw_lock);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	/* Clear all of the status flags */
> +	status &= ~BD_ENET_TX_STATS;
> +
> +	/* Set buffer length and buffer pointer */
> +	bufaddr = skb->data;
> +	bdp->cbd_datlen = skb->len;
> +
> +	/* On some FEC implementations data must be aligned on
> +	 * 4-byte boundaries. Use bounce buffers to copy data
> +	 * and get it aligned.spin
> +	 */
> +	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
> +		unsigned int index;
> +
> +		index = bdp - fep->tx_bd_base;
> +		memcpy(fep->tx_bounce[index],
> +		       (void *)skb->data, skb->len);
> +		bufaddr = fep->tx_bounce[index];
> +	}
> +
> +	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +		swap_buffer(bufaddr, skb->len);
> +
> +	/* Save skb pointer. */
> +	fep->tx_skbuff[fep->skb_cur] = skb;
> +
> +	fep->skb_cur = (fep->skb_cur + 1) & TX_RING_MOD_MASK;
> +
> +	/* Push the data cache so the CPM does not get stale memory
> +	 * data.
> +	 */
> +	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
> +					  MTIP_SWITCH_TX_FRSIZE,
> +					  DMA_TO_DEVICE);
> +	if (unlikely(dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr))) {
> +		dev_err(&fep->pdev->dev,
> +			"Failed to map descriptor tx buffer\n");
> +		dev->stats.tx_errors++;
> +		dev->stats.tx_dropped++;
> +		dev_kfree_skb_any(skb);
> +		goto err;
> +	}
> +
> +	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
> +	 * it's the last BD of the frame, and to put the CRC on the end.
> +	 */
> +
> +	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
> +			| BD_ENET_TX_LAST | BD_ENET_TX_TC);
> +
> +	/* Synchronize all descriptor writes */
> +	wmb();
> +	bdp->cbd_sc = status;
> +
> +	netif_trans_update(dev);
> +	skb_tx_timestamp(skb);
> +
> +	/* Trigger transmission start */
> +	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
> +
> +	dev->stats.tx_bytes += skb->len;
> +	/* If this was the last BD in the ring,
> +	 * start at the beginning again.
> +	 */
> +	if (status & BD_ENET_TX_WRAP)
> +		bdp = fep->tx_bd_base;
> +	else
> +		bdp++;
> +
> +	if (bdp == fep->dirty_tx) {
> +		fep->tx_full = 1;
> +		netif_stop_queue(dev);

You may want to stop the queue earlier, i.e. when 75% or the like of the
tx ring is full. Also you can use netif_txq_maybe_stop() - with txq ==
netdev_get_tx_queue(dev, 0)

[...]
> +static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct cbd_t *bdp;
> +	int i;
> +
> +	dev->stats.tx_errors++;
> +
> +	if (IS_ENABLED(CONFIG_SWITCH_DEBUG)) {
> +		dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
> +		dev_info(&dev->dev,
> +			 "Ring data: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
> +			 (unsigned long)fep->cur_tx,
> +			 fep->tx_full ? " (full)" : "",
> +			 (unsigned long)fep->dirty_tx,
> +			 (unsigned long)fep->cur_rx);
> +
> +		bdp = fep->tx_bd_base;
> +		dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
> +		for (i = 0; i < TX_RING_SIZE; i++) {
> +			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
> +				 (kernel_ulong_t)bdp, bdp->cbd_sc,
> +				 bdp->cbd_datlen, (int)bdp->cbd_bufaddr);
> +			bdp++;
> +		}
> +
> +		bdp = fep->rx_bd_base;
> +		dev_info(&dev->dev, " rx: %lu buffers\n",
> +			 (unsigned long)RX_RING_SIZE);
> +		for (i = 0 ; i < RX_RING_SIZE; i++) {
> +			dev_info(&dev->dev, "  %08lx: %04x %04x %08x\n",
> +				 (kernel_ulong_t)bdp,
> +				 bdp->cbd_sc, bdp->cbd_datlen,
> +				 (int)bdp->cbd_bufaddr);
> +			bdp++;
> +		}

Here you are traversing both rings without any lock, which looks race prone.

/P


