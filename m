Return-Path: <netdev+bounces-287296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFWDGziSA2pm7gEAu9opvQ
	(envelope-from <netdev+bounces-287296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:48:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D54045298C3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81D73086A08
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019FA3C3425;
	Tue, 12 May 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVM82ISP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD93BF672
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618931; cv=none; b=j9ArClDdQxBQ4z1MM/ye6gFpQQebFwdT82xzaYwmTC1cpHTCirVUG7D7D+EFl04EK9jS8OfegT9nzyWpRtmGO4RVpfq3sy0YOmFDkDR8mILd3sXfVxfGMO55WEoOyKjrOnIAwXzf/2gaVU0Buet89YuGOTrPS1pSTuWY9A9EW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618931; c=relaxed/simple;
	bh=QMyBmJloi5EUMSnyjWkxXl2hUdzrWSUhMhaAkWzyBIY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QEsgavwr5r3dE1rD0pL88WRrzUe+ScAGdiLm56WVtI6Zot2SLPI+iRBpbwUplqF3cD4bSdbpRkLNJygolSvAL0Ie+/iaAaaleh6G8pCIPYn+uKJjNT2im+lRXvLSelJHil0484vnxpvBeW7UnaH/4BptOEXexKXaFkWFeLxfEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVM82ISP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so72881575e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778618928; x=1779223728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYcdWBfrbMOtZ/5eUXwVKNW9hm2kOf/rLx+RY3/eMME=;
        b=lVM82ISPd2t7URs7xmUSTTj+aSeyma8wh+vfMN7yHc+hfAjsytRJEjpeDBFWgyH3Oe
         JH06nZ5fI0KZpWw0k+DvTY83X1xXgG9pj0iW6z91TGdaXmHYXEjex+nxWkQnhuUTz5yB
         kFCW8QzzRyR7odijtBLH6S5DJ3uB2XAzn3U7KVjDPo/NxRkpUa9xS3qVY3UcMOpi2B6I
         PGxycMEdrBD5KdIWl1ZJ9002kHJBxQlHX6JXfpVb84+RGpGykFXxirUa/SbHNBTCp/39
         FHFuAvMLrbsR+1HzUcaJ/JBTI73VVf+6npMN2s0aHTSkReKtCbjHCxbhyxiDk5s8+PkN
         FsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618928; x=1779223728;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYcdWBfrbMOtZ/5eUXwVKNW9hm2kOf/rLx+RY3/eMME=;
        b=kMxorY5ZV2uXfLs5fLfWdLmIzSCEPY/4XiI+id++43wltOUgOLpPdDt8aaZFvOy0ne
         HxyWQeTVE6Z18sVKqw2q4EO1SrBCVsFEUWeV8GoooRV/JLOpWanYm/LE6t8QS/KA9EJr
         +c+iiC8WPjaG8xih0Vo+wu+3YVBB5nHnv2uoQ9Do28zsGtgMpC+XnpMwakFer9fBzbqm
         1G4DdqEEjje+XDYrpRF7U/gce4pQ8krKQk2VLDzNTxSMx7te9FpPCscI6gSHQHF23MrY
         ubB6jiHjv/M+TIr2V2hw6seIqe1HSZ4wavFtiTiPD3C3AjapxnPxOzDB28JtoUbrYY8P
         KFWQ==
X-Gm-Message-State: AOJu0YwHEfEfYHYeMkpc+r31I1aXw0i5DDMp3kI7vi5e95CokWBS7Jy3
	4GKPOvF8h50t6YCc5Ondfqvl9Q+M24iCanQe/tSNIoh2usJ8heIQHQH/
X-Gm-Gg: Acq92OFu07Mmf8RGZcS4Mpo4CGay6LMaaocJowAmx6PbLCWMHi46/+CCVOVmpeyPpmB
	qC610fVcvrc36OSWioEUECgCuptq+q1tbhdlXjrl3TN58vY25Ep8OP/tc55a1zoIuW54QSz0uXe
	7VSZUzTmYHulvDL3dgxheGqMgEdZCywd7aSeA0fF6fWKAJclG/Lfa77jmGUCALTlFrR7X5NWHCN
	jWeHBozfNsBrej8XPLgjeL+l3F2fmi3BcRGiYU2poBXXe08wrrBl4cgFLWYkdeLGpVhth12ndwm
	ZjrwfQMrM0uITUyVkBoIP7B+FM4hdlkn8zEPkv/cGGfpip7zXJg994MZt6SU2gtmfj2AtmFZ7KJ
	hhLPvRhGjGQbzRaT4HYqRNOppD/kl9T/CFQRZKTsjXi1tijCzPv3+I7OMuK2O1AletpegGcXuAA
	viRSv5U5R1AuvkBG1M19qfkCjJRVKbF7RSeYDxxDD19QblSjHISdCEB2h+vmTpRTFm3KpZDCk2G
	T7YTa9q8rw2VSrQPHCzbQRGDiIOWeBbhhQXKxJTvsTVaq6LxDpoWPLdDLbTGzE2o94htUKq47Yf
X-Received: by 2002:a05:600c:19c9:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-48fc999e736mr6447565e9.0.1778618927601;
        Tue, 12 May 2026 13:48:47 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3200:655a:16b8:d272:9436? (p200300ea8f473200655a16b8d2729436.dip0.t-ipconnect.de. [2003:ea:8f47:3200:655a:16b8:d272:9436])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3f5174sm40332025e9.5.2026.05.12.13.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:48:45 -0700 (PDT)
Message-ID: <f514063b-24d9-4d1a-aa37-fc9592e287c6@gmail.com>
Date: Tue, 12 May 2026 22:48:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v2 2/7] r8169: add support for multi rx queues
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
 <20260508121802.2010-3-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260508121802.2010-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D54045298C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287296-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 08.05.2026 14:17, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for multi rx queues. RSS requires multi rx
> queues to receive packets. So we need struct rtl8169_rx_ring for each
> queue.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - sort some registers by its number
>  - remove some unused definitions, like RX_DESC_RING_TYPE_MAX
>  - change recheck_desc_ownbit type
>  - remove rdsar_reg in rx_ring struct
>  - opts1 are different in rx_desc and rx_desc_rss, move the judgement
>    to Patch 5/7
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 264 ++++++++++++++++------
>  1 file changed, 201 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f02c4aa66b9d..29fcd469eebb 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,10 +74,12 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> -#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
>  #define R8169_MAX_MSIX_VEC	32
> +#define R8127_MAX_RX_QUEUES	8
> +#define R8169_DEFAULT_RX_QUEUES	1
>  #define RTL_ISR_VER_DEFAULT	1
>  #define RTL_ISR_VER_8127	6
>  
> @@ -446,6 +448,7 @@ enum rtl8125_registers {
>  	TxPoll_8125		= 0x90,
>  	LEDSEL3			= 0x96,
>  	MAC0_BKP		= 0x19e0,
> +	RDSAR_Q1_LOW		= 0x4000,
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> @@ -733,6 +736,17 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_rx_ring {
> +	u32 index;					/* Rx queue index */
> +	u32 cur_rx;					/* Index of next Rx pkt. */
> +	u32 dirty_rx;					/* Index for recycling. */
> +	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
> +	u32 rx_desc_alloc_size;				/* memory size per descs of ring */
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
> +	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
> +	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
> +};
> +
>  struct rtl8169_napi {
>  	struct napi_struct napi;
>  	void *priv;
> @@ -742,6 +756,12 @@ struct rtl8169_irq {
>  	irq_handler_t	handler;
>  	unsigned int	vector;
>  };
> +
> +enum rx_desc_ring_type {
> +	RX_DESC_RING_TYPE_DEFAULT,
> +	RX_DESC_RING_TYPE_RSS,
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -750,17 +770,14 @@ struct rtl8169_private {
>  	struct napi_struct napi;
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
> -	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
>  	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>  	u32 dirty_tx;
>  	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
> -	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
>  	dma_addr_t TxPhyAddr;
> -	dma_addr_t RxPhyAddr;
> -	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
>  	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
>  	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
> +	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
>  	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
> @@ -2643,9 +2660,27 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		memset(ring->rx_desc_array, 0x0, ring->rx_desc_alloc_size);
> +	}
> +}
> +
>  static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
>  {
> -	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
> +	tp->dirty_tx = 0;
> +	tp->cur_tx = 0;
> +
> +	for (int i = 0; i < tp->hw_supp_num_rx_queues; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		ring->dirty_rx = 0;
> +		ring->cur_rx = 0;
> +		ring->index = i;
> +	}
>  }
>  
>  static void rtl_jumbo_config(struct rtl8169_private *tp)
> @@ -2710,9 +2745,11 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
> +		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
>  		tp->hw_supp_isr_ver = RTL_ISR_VER_8127;
>  		break;
>  	default:
> +		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
>  		tp->hw_supp_isr_ver = RTL_ISR_VER_DEFAULT;
>  		break;
>  	}
> @@ -2843,6 +2880,8 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  
>  static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>  {
> +	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
> +
>  	/*
>  	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
>  	 * register to be written before TxDescAddrLow to work.
> @@ -2850,8 +2889,16 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>  	 */
>  	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
>  	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
> -	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
> -	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
> +	RTL_W32(tp, RxDescAddrHigh, ((u64) ring->rx_phy_addr) >> 32);
> +	RTL_W32(tp, RxDescAddrLow, ((u64) ring->rx_phy_addr) & DMA_BIT_MASK(32));
> +
> +	for (int i = 1; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +		u16 rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
> +
> +		RTL_W32(tp, rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
> +		RTL_W32(tp, rdsar_reg, ((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
> +	}
>  }
>  
>  static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
> @@ -4198,12 +4245,13 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
>  }
>  
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
> -					  struct RxDesc *desc)
> +					  struct rtl8169_rx_ring *ring, unsigned int index)
>  {
>  	struct device *d = tp_to_dev(tp);
>  	int node = dev_to_node(d);
>  	dma_addr_t mapping;
>  	struct page *data;
> +	struct RxDesc *desc = ring->rx_desc_array + index;
>  
>  	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
>  	if (!data)
> @@ -4217,55 +4265,101 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	}
>  
>  	desc->addr = cpu_to_le64(mapping);
> +	ring->rx_desc_phy_addr[index] = mapping;
>  	rtl8169_mark_to_asic(desc);
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
> +	for (i = 0; i < NUM_RX_DESC && ring->rx_databuff[i]; i++) {
>  		dma_unmap_page(tp_to_dev(tp),
> -			       le64_to_cpu(tp->RxDescArray[i].addr),
> +			       ring->rx_desc_phy_addr[i],
>  			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
> -		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
> -		tp->Rx_databuff[i] = NULL;
> -		tp->RxDescArray[i].addr = 0;
> -		tp->RxDescArray[i].opts1 = 0;
> +		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
> +		ring->rx_databuff[i] = NULL;
> +		ring->rx_desc_phy_addr[i] = 0;
> +		ring->rx_desc_array[i].addr = 0;
> +		ring->rx_desc_array[i].opts1 = 0;
>  	}
>  }
>  
> -static int rtl8169_rx_fill(struct rtl8169_private *tp)
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
> +		ring->rx_databuff[i] = data;
>  	}
>  
>  	/* mark as last descriptor in the ring */
> -	tp->RxDescArray[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
> +	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
>  
>  	return 0;
>  }
>  
> +static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct rtl8169_rx_ring *ring;
> +	struct pci_dev *pdev = tp->pci_dev;
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		ring->rx_desc_alloc_size = (NUM_RX_DESC + 1) * sizeof(struct RxDesc);

Why member rx_desc_alloc_size if value is a compile-time constant?

> +		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
> +							 ring->rx_desc_alloc_size,
> +							 &ring->rx_phy_addr,
> +							 GFP_KERNEL);
> +		if (!ring->rx_desc_array)
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
> +		if (ring->rx_desc_array) {
> +			dma_free_coherent(&pdev->dev,
> +					  ring->rx_desc_alloc_size,
> +					  ring->rx_desc_array,
> +					  ring->rx_phy_addr);
> +			ring->rx_desc_array = NULL;
> +		}
> +	}
> +}
> +
>  static int rtl8169_init_ring(struct rtl8169_private *tp)
>  {
> +	int retval = 0;
> +
>  	rtl8169_init_ring_indexes(tp);
> +	rtl8169_rx_desc_init(tp);
>  
>  	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
> -	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
>  
> -	return rtl8169_rx_fill(tp);
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
> +		retval = rtl8169_rx_fill(tp, ring);
> +	}
> +
> +	return retval;
>  }
>  
>  static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
> @@ -4354,16 +4448,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
>  	rtl8169_init_ring_indexes(tp);
>  }
>  
> -static void rtl_reset_work(struct rtl8169_private *tp)
> +static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
>  {
> -	int i;
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>  
> +		for (int j = 0; j < NUM_RX_DESC; j++)
> +			rtl8169_mark_to_asic(ring->rx_desc_array + j);
> +	}
> +}
> +
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
>  	rtl_hw_start(tp);
> @@ -4757,6 +4858,11 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
>  	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>  }
>  
> +static void rtl8169_desc_quirk(struct rtl8169_private *tp)
> +{
> +	RTL_R8(tp, LED_CTRL);
> +}
> +
>  static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>  		   int budget)
>  {
> @@ -4809,9 +4915,10 @@ static inline int rtl8169_fragmented_frame(u32 status)
>  	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>  }
>  
> -static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
> +static inline void rtl8169_rx_csum(struct sk_buff *skb,
> +				   struct RxDesc *desc)
>  {
> -	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
> +	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
>  
>  	if (status == RxProtoTCP || status == RxProtoUDP)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -4819,22 +4926,58 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
>  		skb_checksum_none_assert(skb);
>  }
>  
> -static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
> +static bool rtl8169_check_rx_desc_error(struct net_device *dev,
> +					struct rtl8169_private *tp,
> +					u32 status)
> +{
> +	if (unlikely(status & RxRES)) {
> +		if (status & (RxRWT | RxRUNT))
> +			dev->stats.rx_length_errors++;
> +		if (status & RxCRC)
> +			dev->stats.rx_crc_errors++;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static inline void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
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
> +		unsigned int pkt_size, entry = ring->cur_rx % NUM_RX_DESC;
> +		struct RxDesc *desc = ring->rx_desc_array + entry;
>  		struct sk_buff *skb;
>  		const void *rx_buf;
>  		dma_addr_t addr;
>  		u32 status;
>  
>  		status = le32_to_cpu(READ_ONCE(desc->opts1));
> -		if (status & DescOwn)
> -			break;
> +
> +		if (status & DescOwn) {
> +			if (!tp->recheck_desc_ownbit)
> +				break;
> +
> +			/* Workaround for a hardware issue:
> +			 * Hardware might trigger RX interrupt before the DMA
> +			 * engine fully updates RX desc ownbit in host memory.
> +			 * So we do a quirk and re-read to avoid missing RX
> +			 * packets.
> +			 */
> +			tp->recheck_desc_ownbit = false;
> +			rtl8169_desc_quirk(tp);
> +			status = le32_to_cpu(READ_ONCE(desc->opts1));
> +			if (status & DescOwn)
> +				break;
> +		}
>  
>  		/* This barrier is needed to keep us from reading
>  		 * any other fields out of the Rx descriptor until
> @@ -4842,20 +4985,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		 */
>  		dma_rmb();
>  
> -		if (unlikely(status & RxRES)) {
> +		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
>  			if (net_ratelimit())
>  				netdev_warn(dev, "Rx ERROR. status = %08x\n",
>  					    status);
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
> @@ -4871,14 +5008,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
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
> +		addr = ring->rx_desc_phy_addr[entry];
> +		rx_buf = page_address(ring->rx_databuff[entry]);
>  
>  		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
>  		prefetch(rx_buf);
> @@ -4887,7 +5024,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
>  
> -		rtl8169_rx_csum(skb, status);
> +		rtl8169_rx_csum(skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
>  		rtl8169_rx_vlan_tag(desc, skb);
> @@ -4895,10 +5032,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->r8169napi[0].napi, skb);
> +		napi_gro_receive(&tp->r8169napi[ring->index].napi, skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> +		rtl8169_set_desc_dma_addr(desc, ring->rx_desc_phy_addr[entry]);
>  		rtl8169_mark_to_asic(desc);
>  	}
>  
> @@ -4925,6 +5063,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		phy_mac_interrupt(tp->phydev);
>  
>  	rtl_irq_disable(tp);
> +	tp->recheck_desc_ownbit = true;
>  	napi_schedule(&napi->napi);
>  out:
>  	rtl_ack_events(tp, status);
> @@ -5006,7 +5145,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  
>  	rtl_tx(dev, tp, budget);
>  
> -	work_done = rtl_rx(dev, tp, budget);
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done))
>  		rtl_irq_enable(tp);
> @@ -5134,21 +5274,19 @@ static int rtl8169_close(struct net_device *dev)
>  	struct pci_dev *pdev = tp->pci_dev;
>  
>  	pm_runtime_get_sync(&pdev->dev);
> -
>  	netif_stop_queue(dev);
>  	rtl8169_down(tp);
> -	rtl8169_rx_clear(tp);
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
>  
>  	rtl8169_free_irq(tp);
>  
>  	phy_disconnect(tp->phydev);
>  
> -	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
> -			  tp->RxPhyAddr);
>  	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
>  			  tp->TxPhyAddr);
>  	tp->TxDescArray = NULL;
> -	tp->RxDescArray = NULL;
> +	rtl8169_free_rx_desc(tp);
>  
>  	pm_runtime_put_sync(&pdev->dev);
>  
> @@ -5179,13 +5317,11 @@ static int rtl_open(struct net_device *dev)
>  	tp->TxDescArray = dma_alloc_coherent(&pdev->dev, R8169_TX_RING_BYTES,
>  					     &tp->TxPhyAddr, GFP_KERNEL);
>  	if (!tp->TxDescArray)
> -		goto out;
> -
> -	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
> -					     &tp->RxPhyAddr, GFP_KERNEL);
> -	if (!tp->RxDescArray)
>  		goto err_free_tx_0;
>  
> +	if (rtl8169_alloc_rx_desc(tp) < 0)
> +		goto err_free_rx_1;
> +
>  	retval = rtl8169_init_ring(tp);
>  	if (retval < 0)
>  		goto err_free_rx_1;
> @@ -5212,11 +5348,10 @@ static int rtl_open(struct net_device *dev)
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
>  	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
>  			  tp->TxPhyAddr);
> @@ -5726,7 +5861,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	u32 txconfig;
>  	u32 xid;
>  
> -	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
> +	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
> +				      1,
> +				      R8169_MAX_RX_QUEUES);
> +
>  	if (!dev)
>  		return -ENOMEM;
>  


