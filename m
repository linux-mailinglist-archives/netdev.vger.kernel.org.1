Return-Path: <netdev+bounces-281129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7evzLto+7WnlhAAAu9opvQ
	(envelope-from <netdev+bounces-281129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 00:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A1146808B
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 248DF3004D1D
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3BC383C7C;
	Sat, 25 Apr 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL/QNQIP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F0383C6C
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777155795; cv=none; b=avwTidirEBQ1PiAwPcpUGf3tv06i54U00NuhFDu/eloDRJALEZaQTVNe0+wz86SPYc/3cMWsQKgVRT9EdQxaTkQczASzHSy56KvRThgV29Qilhr8Hc1VeVnQ++9mWEV6Oa2CdrkWFoJJqzpnAx6ws0RUb36ffZPFO4bwrX7dpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777155795; c=relaxed/simple;
	bh=+F/eZiuE7hjNSXgYnEaJPXAjEmR7xWIClZW+kpS9oww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOazoK3fVEWWXNINsxx1sjAkziRGJjBQY1SVKVqBd+O/KPiDVTT0F6cXfYi4oSQS1zs5PkthZLV9pNujUTR26HaSSLIkkFEaJcRGC/RI8Pk07DjkYDcV0VMc4TQZb0z/6AlcnT8TwauyqgQg94kAKYViSM6aFS1waLtzWtOpNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL/QNQIP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso59308265e9.1
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777155791; x=1777760591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+b4Rv8yEnqq+GjNzq0g5WzYUhj+5zjO7NRy7iMUNcjw=;
        b=VL/QNQIPwX3HOLHe2YE0cfQ/QT57dkpicsMGk3jOHoIznYHMK3Ao9XS7HdTAo8HKYQ
         LrLz3cxnj86N5AzXFCD0eOF5Svp43ND5ZuGuzkGRxueuNv4491WYybucGtmNxc1GG53m
         ecXZHaiwNdRvNVxsSFOEb3nuBLgTa938TjStcxMz9+GYoe0gbZ8kgppC92Kyn6PveQ6c
         c1uPPLBlc7LfBrioAPe5Vf1tWxj/KWhQkOey9NhB7NKjMOg6eVBtyLy59HOt45KC+9d5
         4b6Q6erdMf7+9Im4CUCZpteE2m+dcDGShvdBhN8y0E4lSizIor+ynpMHugXxjimIjmhk
         T9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777155791; x=1777760591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b4Rv8yEnqq+GjNzq0g5WzYUhj+5zjO7NRy7iMUNcjw=;
        b=WttPexlmN80NNPPer07UVLpXSM2H24+tvB/8ITH5wvq8siNGQuppNR8nFv1q0l14fC
         wHAorO0U+A5nXkP6GUAVBeB2Wdr2aYKS6esV56eKsCWFr/y7TFPYmczTbndhCRe896nL
         87AlJdJk5Qu5ZTnL7fCEan/Pmth76bTa8nTtFdxDnFNWUAwdOn5NhMPh/HE0oH2ZnCl1
         CnS81djBNRJhguXqW7y7/yXl+gzYAAIkRXrPVkpvVkvkGWlONcLyT6+XbiHKWGGWYkTL
         NlFB4U5fda/juM/hIbFzZMj8liPrwW3dK8Blj+eGQO5KRlWhtFJtj7qpqNYOMOgRjkP8
         C1QQ==
X-Gm-Message-State: AOJu0Yw13OSu/S6O1YQQwcOtCR/c7eJCcbF3kEvy1giMxmR6/+s3nMnb
	vUPbm4SK5vQdmQy/MCcBt5/smHbMewMrHhHleJTU8wYOqGIVGrPleO0t
X-Gm-Gg: AeBDievCyrUv3sWF1Xve5LbfY5JjNe4VzJQeba0sz8Z9xkqH4YOsEX0EXGxVjAyX70m
	3o+c65DzSKqcdQesmRMDFmsahOIDtcG7B98QAlXOf9eg6ULD8Nxu6oD4XeRkzD1+xtlTS8cGtBC
	tS23DJstQpX4N/CNMa3zwLraG1pA/XGJvZgRIxbHZ8nuvi31Q/f6zvJkHZhRghx8Xb+Vi0gprA8
	sr+2xrRtftwv0tsSFu2qI/jsotGyToBOtjYI0W1APRt9gapFtAXHM7P9sjNres9bQuIOz6QqpNc
	MVM+zNFH3wktJSuU8xKRxOU8nBEpLrWxRyvPZ9Gy13PdBeNuCS33XYzgut0q4bPbaYOE0nXqMRS
	adgEyyRJBlkXTPNx3UUJ5JxJzlKP8/TFyCg8vwdRNHEqkzmvk+ZrM2rmO+4sZyro3QoeQ56V2bi
	pbDsOj0rQWkX13JGB03WvH1sSc5A9R8O8aGvZL8wVHHYrp4dIwT8Pr7I6/9nC/2I1zUzgwAath7
	SrppNHGHonjVI/ikUfa2Kt48RpE4a8dbeKUIWHfF/Zp2eQPNNnABM9oIRZDGGfNCI3cF2FiCcFA
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488fb796fa0mr516831485e9.25.1777155791195;
        Sat, 25 Apr 2026 15:23:11 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f34:b800:6020:70f3:48c1:ca3e? (p200300ea8f34b800602070f348c1ca3e.dip0.t-ipconnect.de. [2003:ea:8f34:b800:6020:70f3:48c1:ca3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489207ebd3asm223733265e9.6.2026.04.25.15.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 15:23:10 -0700 (PDT)
Message-ID: <cfa27bb9-98ad-40af-b9c6-bdbc93f6d39f@gmail.com>
Date: Sun, 26 Apr 2026 00:23:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch net-next v1 4/9] r8169: add support for multi rx
 queues
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-5-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260420021957.1756-5-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A9A1146808B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281129-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:email]

On 20.04.2026 04:19, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch supports for multi rx queues. But we set rx queue num 1 here.
> We will add support for rx queue num 8 in rss patch.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 272 +++++++++++++++++-----
>  1 file changed, 212 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 05f0cb532a31..52e690eba644 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -73,7 +73,6 @@
>  #define R8169_RX_BUF_SIZE	(SZ_16K - 1)
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
> -#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
>  #define R8169_MAX_RX_QUEUES	8
> @@ -793,6 +792,19 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_rx_ring {
> +	u32 index;				/* Rx queue index */
> +	u32 cur_rx;				/* Index into the Rx descriptor buffer of next Rx pkt. */
> +	u32 dirty_rx;				/* Index into the Rx descriptor buffer for recycling. */
> +	u32 num_rx_desc;			/* num of Rx desc */
> +	struct RxDesc *RxDescArray;		/* array of Rx Desc*/
> +	u32 RxDescAllocSize;			/* memory size per descs of ring */
> +	dma_addr_t RxDescPhyAddr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
> +	dma_addr_t RxPhyAddr;			/* Rx desc physical address */
> +	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
> +	u16 rdsar_reg;				/* Receive Descriptor Start Address */
> +};
> +
>  struct rtl8169_tx_ring {
>  	u32 index;				/* Tx queue index */
>  	u32 cur_tx;				/* Index into the Tx descriptor buffer of next Tx pkt. */
> @@ -833,12 +845,9 @@ struct rtl8169_private {
>  	struct napi_struct napi;
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
> -	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
> -	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
> -	dma_addr_t RxPhyAddr;
> -	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
>  	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
> +	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
>  	struct rtl8169_tx_ring tx_ring[R8169_MAX_TX_QUEUES];
>  	u16 isr_reg[R8169_MAX_MSIX_VEC];
>  	u16 imr_reg[R8169_MAX_MSIX_VEC];
> @@ -848,11 +857,13 @@ struct rtl8169_private {
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
>  	u16 HwSuppNumTxQueues;
> +	u16 HwSuppNumRxQueues;
>  	u8 min_irq_nvecs;
>  	u8 max_irq_nvecs;
>  	u8 HwSuppIsrVer;
>  	u8 HwCurrIsrVer;
>  	u8 irq_nvecs;
> +	u8 InitRxDescType;
>  	u8 recheck_desc_ownbit;
>  	unsigned int features;
>  	int irq;
> @@ -2728,6 +2739,15 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		memset(ring->RxDescArray, 0x0, ring->RxDescAllocSize);
> +	}
> +}
> +
>  static void rtl8169_tx_desc_init(struct rtl8169_private *tp)
>  {
>  	for (int i = 0; i < tp->num_tx_rings; i++) {
> @@ -2750,6 +2770,14 @@ static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
>  		ring->index = i;
>  		netdev_tx_reset_queue(netdev_get_tx_queue(dev, i));
>  	}
> +
> +	for (int i = 0; i < tp->HwSuppNumRxQueues; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		ring->dirty_rx = 0;
> +		ring->cur_rx = 0;
> +		ring->index = i;
> +	}
>  }
>  
>  static void rtl_jumbo_config(struct rtl8169_private *tp)
> @@ -2810,6 +2838,9 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  
>  static void rtl_set_ring_size(struct rtl8169_private *tp, u32 rx_num, u32 tx_num)
>  {
> +	for (int i = 0; i < tp->HwSuppNumRxQueues; i++)
> +		tp->rx_ring[i].num_rx_desc = rx_num;
> +
>  	for (int i = 0; i < tp->HwSuppNumTxQueues; i++)
>  		tp->tx_ring[i].num_tx_desc = tx_num;
>  }
> @@ -2820,6 +2851,10 @@ static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
>  	for (int i = 1; i < tp->HwSuppNumTxQueues; i++)
>  		tp->tx_ring[i].tdsar_reg = (u16)(TNPDS_Q1_LOW + (i - 1) * 8);
>  
> +	tp->rx_ring[0].rdsar_reg = RxDescAddrLow;
> +	for (int i = 1; i < tp->HwSuppNumRxQueues; i++)
> +		tp->rx_ring[i].rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
> +
>  	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
>  		tp->isr_reg[0] = IntrStatus;
>  		tp->imr_reg[0] = IntrMask;
> @@ -2845,15 +2880,18 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  		tp->min_irq_nvecs = R8127_MIN_IRQ;
>  		tp->max_irq_nvecs = R8127_MAX_IRQ;
>  		tp->HwSuppNumTxQueues = R8127_MAX_TX_QUEUES;
> +		tp->HwSuppNumRxQueues = R8127_MAX_RX_QUEUES;
>  		tp->HwSuppIsrVer = 6;
>  		break;
>  	default:
>  		tp->min_irq_nvecs = 1;
>  		tp->max_irq_nvecs = 1;
>  		tp->HwSuppNumTxQueues = 1;
> +		tp->HwSuppNumRxQueues = 1;
>  		tp->HwSuppIsrVer = 1;
>  		break;
>  	}
> +	tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
>  	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
>  
>  	rtl_setup_mqs_reg(tp);
> @@ -2989,14 +3027,18 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>  	 * register to be written before TxDescAddrLow to work.
>  	 * Switching from MMIO to I/O access fixes the issue as well.
>  	 */
> -	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
> -	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
>  	for (int i = 0; i < tp->num_tx_rings; i++) {
>  		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
>  
>  		RTL_W32(tp, ring->tdsar_reg, ((u64)ring->TxPhyAddr & DMA_BIT_MASK(32)));
>  		RTL_W32(tp, ring->tdsar_reg + 4, ((u64)ring->TxPhyAddr >> 32));
>  	}
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		RTL_W32(tp, ring->rdsar_reg, ((u64)ring->RxPhyAddr) & DMA_BIT_MASK(32));
> +		RTL_W32(tp, ring->rdsar_reg + 4, ((u64)ring->RxPhyAddr >> 32));
> +	}
>  }
>  
>  static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
> @@ -4332,7 +4374,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>  	return 0;
>  }
>  
> -static void rtl8169_mark_to_asic(struct RxDesc *desc)
> +static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
>  {
>  	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
>  
> @@ -4342,13 +4384,19 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
>  	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
>  }
>  
> +static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	rtl8169_mark_to_asic_default(desc);
> +}
> +
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
> -					  struct RxDesc *desc)
> +					  struct rtl8169_rx_ring *ring, unsigned int index)
>  {
>  	struct device *d = tp_to_dev(tp);
>  	int node = dev_to_node(d);
>  	dma_addr_t mapping;
>  	struct page *data;
> +	struct RxDesc *desc = ring->RxDescArray + index;
>  
>  	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
>  	if (!data)
> @@ -4361,44 +4409,56 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  		return NULL;
>  	}
>  
> +	ring->RxDescPhyAddr[index] = mapping;
>  	desc->addr = cpu_to_le64(mapping);
> -	rtl8169_mark_to_asic(desc);
> +	rtl8169_mark_to_asic(tp, desc);
>  
>  	return data;
>  }
>  
> -static void rtl8169_rx_clear(struct rtl8169_private *tp)
> +static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
>  {
>  	int i;
>  
> -	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
> +	for (i = 0; i < NUM_RX_DESC && ring->Rx_databuff[i]; i++) {
>  		dma_unmap_page(tp_to_dev(tp),
> -			       le64_to_cpu(tp->RxDescArray[i].addr),
> +			       ring->RxDescPhyAddr[i],
>  			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> -		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
> -		tp->Rx_databuff[i] = NULL;
> -		tp->RxDescArray[i].addr = 0;
> -		tp->RxDescArray[i].opts1 = 0;
> +		__free_pages(ring->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
> +		ring->Rx_databuff[i] = NULL;
> +		ring->RxDescPhyAddr[i] = 0;
> +		ring->RxDescArray[i].addr = 0;
> +		ring->RxDescArray[i].opts1 = 0;
>  	}
>  }
>  
> -static int rtl8169_rx_fill(struct rtl8169_private *tp)
> +static void rtl8169_mark_as_last_descriptor_default(struct RxDesc *desc)
> +{
> +	desc->opts1 |= cpu_to_le32(RingEnd);
> +}
> +
> +static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	rtl8169_mark_as_last_descriptor_default(desc);
> +}
> +
> +static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
>  {
>  	int i;
>  
>  	for (i = 0; i < NUM_RX_DESC; i++) {
>  		struct page *data;
>  
> -		data = rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
> +		data = rtl8169_alloc_rx_data(tp, ring, i);
>  		if (!data) {
> -			rtl8169_rx_clear(tp);
> +			rtl8169_rx_clear(tp, ring);
>  			return -ENOMEM;
>  		}
> -		tp->Rx_databuff[i] = data;
> +		ring->Rx_databuff[i] = data;
>  	}
>  
>  	/* mark as last descriptor in the ring */
> -	tp->RxDescArray[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
> +	rtl8169_mark_as_last_descriptor(tp, &ring->RxDescArray[NUM_RX_DESC - 1]);
>  
>  	return 0;
>  }
> @@ -4438,6 +4498,40 @@ static void rtl8169_free_tx_desc(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct rtl8169_rx_ring *ring;
> +	struct pci_dev *pdev = tp->pci_dev;
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		ring->RxDescAllocSize = (ring->num_rx_desc + 1) * sizeof(struct RxDesc);
> +		ring->RxDescArray = dma_alloc_coherent(&pdev->dev,
> +						       ring->RxDescAllocSize,
> +						       &ring->RxPhyAddr,
> +						       GFP_KERNEL);
> +		if (!ring->RxDescArray)
> +			return -1;
> +	}
> +	return 0;
> +}
> +
> +static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct rtl8169_rx_ring *ring;
> +	struct pci_dev *pdev = tp->pci_dev;
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		if (ring->RxDescArray) {
> +			dma_free_coherent(&pdev->dev,
> +					  ring->RxDescAllocSize,
> +					  ring->RxDescArray,
> +					  ring->RxPhyAddr);
> +			ring->RxDescArray = NULL;
> +		}
> +	}
> +}
>  
>  static int rtl8169_init_ring(struct rtl8169_private *tp)
>  {
> @@ -4445,6 +4539,7 @@ static int rtl8169_init_ring(struct rtl8169_private *tp)
>  
>  	rtl8169_init_ring_indexes(tp);
>  	rtl8169_tx_desc_init(tp);
> +	rtl8169_rx_desc_init(tp);
>  
>  	for (int i = 0; i < tp->num_tx_rings; i++) {
>  		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
> @@ -4452,9 +4547,14 @@ static int rtl8169_init_ring(struct rtl8169_private *tp)
>  		memset(ring->tx_skb, 0x0, sizeof(ring->tx_skb));
>  	}
>  
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>  
> +		memset(ring->Rx_databuff, 0, sizeof(ring->Rx_databuff));
> +		retval = rtl8169_rx_fill(tp, ring);
> +	}
>  
> -	return rtl8169_rx_fill(tp);
> +	return retval;
>  }
>  
>  static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp,
> @@ -4549,16 +4649,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
>  	rtl8169_init_ring_indexes(tp);
>  }
>  
> -static void rtl_reset_work(struct rtl8169_private *tp)
> +static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
>  {
> -	int i;
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		for (int j = 0; j < ring->num_rx_desc; j++)
> +			rtl8169_mark_to_asic(tp, ring->RxDescArray + j);
> +	}
> +}
>  
> +static void rtl_reset_work(struct rtl8169_private *tp)
> +{
>  	netif_stop_queue(tp->dev);
>  
>  	rtl8169_cleanup(tp);
>  
> -	for (i = 0; i < NUM_RX_DESC; i++)
> -		rtl8169_mark_to_asic(tp->RxDescArray + i);
> +	rtl8169_rx_desc_reset(tp);
>  
>  	rtl8169_napi_enable(tp);
>  
> @@ -5033,9 +5140,11 @@ static inline int rtl8169_fragmented_frame(u32 status)
>  	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>  }
>  
> -static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
> +static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
> +					   struct sk_buff *skb,
> +					   struct RxDesc *desc)
>  {
> -	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
> +	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
>  
>  	if (status == RxProtoTCP || status == RxProtoUDP)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -5043,22 +5152,67 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
>  		skb_checksum_none_assert(skb);
>  }
>  
> -static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
> +static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
> +				   struct sk_buff *skb,
> +				   struct RxDesc *desc)
> +{
> +	rtl8169_rx_csum_default(tp, skb, desc);
> +}
> +
> +static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	return READ_ONCE(desc->opts1);
> +}
> +
> +static int rtl8169_check_rx_desc_error(struct net_device *dev,
> +				       struct rtl8169_private *tp,
> +				       u32 status)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(status & RxRES)) {
> +		if (status & (RxRWT | RxRUNT))
> +			dev->stats.rx_length_errors++;
> +		if (status & RxCRC)
> +			dev->stats.rx_crc_errors++;
> +		ret = -1;

If not using bool, then at least use a proper ERRNO.

> +	}
> +	return ret;
> +}
> +
> +static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
> +					     struct RxDesc *desc,
> +					     dma_addr_t mapping)
> +{
> +	desc->addr = cpu_to_le64(mapping);
> +}
> +
> +static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
> +		  struct rtl8169_rx_ring *ring, int budget)
>  {
>  	struct device *d = tp_to_dev(tp);
>  	int count;
>  
> -	for (count = 0; count < budget; count++, tp->cur_rx++) {
> -		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
> -		struct RxDesc *desc = tp->RxDescArray + entry;
> +	for (count = 0; count < budget; count++, ring->cur_rx++) {
> +		unsigned int pkt_size, entry = ring->cur_rx % ring->num_rx_desc;
> +		struct RxDesc *desc = ring->RxDescArray + entry;
>  		struct sk_buff *skb;
>  		const void *rx_buf;
>  		dma_addr_t addr;
>  		u32 status;
>  
> -		status = le32_to_cpu(READ_ONCE(desc->opts1));
> -		if (status & DescOwn)
> -			break;
> +		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
> +
> +		if (status & DescOwn) {
> +			if (!tp->recheck_desc_ownbit)

This flag needs an explanation.

> +				break;
> +
> +			tp->recheck_desc_ownbit = false;
> +			rtl8169_desc_quirk(tp);
> +			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
> +			if (status & DescOwn)
> +				break;
> +		}
>  
>  		/* This barrier is needed to keep us from reading
>  		 * any other fields out of the Rx descriptor until
> @@ -5066,20 +5220,15 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		 */
>  		dma_rmb();
>  
> -		if (unlikely(status & RxRES)) {
> +		if (rtl8169_check_rx_desc_error(dev, tp, status) < 0) {
>  			if (net_ratelimit())
>  				netdev_warn(dev, "Rx ERROR. status = %08x\n",
>  					    status);
> +
>  			dev->stats.rx_errors++;
> -			if (status & (RxRWT | RxRUNT))
> -				dev->stats.rx_length_errors++;
> -			if (status & RxCRC)
> -				dev->stats.rx_crc_errors++;
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;
> -			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> -				goto release_descriptor;
>  		}
>  
>  		pkt_size = status & GENMASK(13, 0);
> @@ -5095,14 +5244,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
> +		skb = napi_alloc_skb(&tp->r8169napi[ring->index].napi, pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
>  		}
>  
> -		addr = le64_to_cpu(desc->addr);
> -		rx_buf = page_address(tp->Rx_databuff[entry]);
> +		addr = ring->RxDescPhyAddr[entry];
> +		rx_buf = page_address(ring->Rx_databuff[entry]);
>  
>  		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
>  		prefetch(rx_buf);
> @@ -5111,7 +5260,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
>  
> -		rtl8169_rx_csum(skb, status);
> +		rtl8169_rx_csum(tp, skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
>  		rtl8169_rx_vlan_tag(desc, skb);
> @@ -5119,11 +5268,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->r8169napi[0].napi, skb);
> +		napi_gro_receive(&tp->r8169napi[ring->index].napi, skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> -		rtl8169_mark_to_asic(desc);
> +		rtl8169_set_desc_dma_addr(tp, desc, ring->RxDescPhyAddr[entry]);
> +		dma_wmb();

Several parts of the code indicate that you didn't run checkpatch on it.
All memory barriers require a comment with an explanation.

> +		rtl8169_mark_to_asic(tp, desc);
>  	}
>  
>  	return count;
> @@ -5239,7 +5390,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  	for (int i = 0; i < tp->num_tx_rings; i++)
>  		rtl_tx(dev, tp, &tp->tx_ring[i], budget);
>  
> -	work_done = rtl_rx(dev, tp, budget);
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done))
>  		rtl_irq_enable(tp);
> @@ -5371,16 +5523,16 @@ static int rtl8169_close(struct net_device *dev)
>  	netif_stop_queue(dev);
>  
>  	rtl8169_down(tp);
> -	rtl8169_rx_clear(tp);
>  
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
>  
>  	rtl8169_free_irq(tp);
>  
>  	phy_disconnect(tp->phydev);
>  
> -	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
> -			  tp->RxPhyAddr);
> -	tp->RxDescArray = NULL;
> +	rtl8169_free_rx_desc(tp);
> +
>  	rtl8169_free_tx_desc(tp);
>  
>  	pm_runtime_put_sync(&pdev->dev);
> @@ -5411,11 +5563,12 @@ static int rtl_open(struct net_device *dev)
>  	 * dma_alloc_coherent provides more.
>  	 */
>  
> -	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
> -					     &tp->RxPhyAddr, GFP_KERNEL);
>  	if (rtl8169_alloc_tx_desc(tp) < 0)
>  		goto err_free_tx_0;
>  
> +	if (rtl8169_alloc_rx_desc(tp) < 0)
> +		goto err_free_rx_1;
> +
>  	retval = rtl8169_init_ring(tp);
>  	if (retval < 0)
>  		goto err_free_rx_1;
> @@ -5444,11 +5597,10 @@ static int rtl_open(struct net_device *dev)
>  	rtl8169_free_irq(tp);
>  err_release_fw_2:
>  	rtl_release_firmware(tp);
> -	rtl8169_rx_clear(tp);
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
>  err_free_rx_1:
> -	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
> -			  tp->RxPhyAddr);
> -	tp->RxDescArray = NULL;
> +	rtl8169_free_rx_desc(tp);
>  err_free_tx_0:
>  	rtl8169_free_tx_desc(tp);
>  	goto out;


