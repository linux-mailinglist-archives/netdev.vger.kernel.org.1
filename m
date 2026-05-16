Return-Path: <netdev+bounces-288669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD0nFLbqCGpD/QMAu9opvQ
	(envelope-from <netdev+bounces-288669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:07:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1855E0B7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6314C301DEEC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0F388E6B;
	Sat, 16 May 2026 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDiVY21K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB538839C
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969244; cv=none; b=gJJKYCrcmMEOjNYZ0eCf2bVcSeC+hngfhzyGVB63xBExbjlaxPHpacdn4XzB1gPoelWDhipq3E8lkUlGIU4IFQmMgyoa+bdjE/3WSmOGyPcq7VmYnBeJ7OGQNdL8oqUVQgccnfZ40XksqNZKwC6m1X6IhH761KF5ODAZXapIH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969244; c=relaxed/simple;
	bh=T2dKDsyx9MI+ivQAkslbYD20o2rVWb5R87+yKf3ftx0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gGORQ3be79ABpoYcmrrPEIjO5Ut0JjtDk85I0GiAHORqeTxmv03A/8w1ksLtv/1TUngOtS0Y/Hr7kDljfg+5Rk+9RWsk7g6Xz7f3+c2F1RUCw5JqNjuv7eX2huN3oZKkL5InzHMJyIT+MjVtzBdUVrdJCM4tn4k0IqH1tctxKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDiVY21K; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d102471a4so6828635e9.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969241; x=1779574041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FkJ4DN8+pI71cj2jxzm4I6Bd6/GbAIemsJkwhChK4Pg=;
        b=NDiVY21Kmw5UzJYj3E1Rgo47VF4RgDYKu8nEA8sOHxkrCd+0Ppy5W+ytfF/DcYI7Xo
         KUr6dtowZrqvaeioTVWuJftncJwkJIAMFH0RzPomtQxmZFqN1fCRnmVotkyuDMWWRl0m
         +q4pne2KH5KhBwtGRQyL3MU1CqR+cBi1aBIA5jeAXGr2BJ2nhEWW5J9z8O1IpZ9TW3zm
         qTQP6Pqnbu+okDlXfnP0VJ9p7dyKM+d7HRzTGcitW5AenjI8rH6qt68n2sqFnsTeOEjc
         5e+tDlOzclZQL4549XN+l2q6EAu6BRDSrdP4gqcR2PxkNhODXCb9mGg8zwv/Byu7bzHa
         2PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969241; x=1779574041;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkJ4DN8+pI71cj2jxzm4I6Bd6/GbAIemsJkwhChK4Pg=;
        b=RhMopTssu5wmZlF7M2AwS2u2nVAKJ7Z+oiGp/ZyXPilnAIRrzaox+fGKX5ADmHoptP
         X0RBY4XMK9/aHJcCyEu6i7dmAy9LjeWB4xAxKuUWE1T+CvWchKptYaBvVSKh2XXURSXV
         amRgc2xI1c03KjI5bsuRHubvLrEOahtOubhQE+Mp/TBqifcc8KfInf4TzyEMQrsSGfpB
         nqkOKobnKeneATBHp4y6oyTTt9jZu+pShEYBPHAwYtpG010kGulomIaF+RXi8qtzY8TA
         8+rmA7NO8NA/1i+xb7Iaw6syZObjpU2QhANhFuiNB4JfRNytNO3KpdTZCvqiIWT8oTNE
         St7w==
X-Gm-Message-State: AOJu0YzaR64HcBhYAdz5QLypPEurt1gpquAPd4YHLrk6dkfafsWSutka
	L3rOc8SVpnrptlF77n/qS9PoPW2XcnIeHY4rEG6y9mcQ7Erg4uswZdLP
X-Gm-Gg: Acq92OEJGagAgwIpG35MDR0iZIlAmz6s6iLePiVT90b89A0nZhSM9Xf7UX3QvGSjN0X
	zvg57Az3WD2Vil3tUUyDEjTeYw1dm+biYg3TkaZLhz8x5oJCC79QhjvxBpk1sSdmM0zX0eDi7Vn
	dty//vac0XBDg2rCEgsPAkzSZNFwmeJ8mWUwcBCjkROpcPJRF8ULQbaMY07/xvawFpe+9y85Of5
	6z41L8kVkxVnJacbS75prB+o8GCdjcEi6uzhg223cK4gfynD0yAkRPgN3E9fRwfbgzaAgKIJ2A5
	vyVmJKYAQmvdJwUiuRMvPIjh4zefRN/G5lZBoLpezAWkL21uK5IE/QbHzZilqozvV+QAu0rEZ4c
	oK8MXPUoeaCl/y527lxGzO+irH+JNAq6E8syAFKNPyFs80OMyhugPRmQ2vuSAPm9rBDJp787ykW
	M77cntEOETm1uP6mG9l9hBVMMnh5AGEKphwwtfAob6E2nsc2dRpwO/G3jpnIYgvhgud2BXufYyd
	Y/GmxmK84dgWTr2ZYFa2/PY029Yk2YlawrkHByeWhAB0HIPi/wFLUFnTUT5GBM=
X-Received: by 2002:a05:600c:8209:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48fe61f2a2fmr137965775e9.16.1778969240977;
        Sat, 16 May 2026 15:07:20 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:8500:bde1:c576:18ad:a53? (p200300ea8f2c8500bde1c57618ad0a53.dip0.t-ipconnect.de. [2003:ea:8f2c:8500:bde1:c576:18ad:a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm144690005e9.12.2026.05.16.15.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 15:07:20 -0700 (PDT)
Message-ID: <6e28df14-9717-4c2d-b191-c052e9fecc9b@gmail.com>
Date: Sun, 17 May 2026 00:07:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v3 2/7] r8169: add support for multi rx queues
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
 <20260513115543.1730-3-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260513115543.1730-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B7C1855E0B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288669-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 13.05.2026 13:55, javen wrote:
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
> Changes in v3:
>  - remove ring->rx_desc_alloc_size, use constant instead
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 262 ++++++++++++++++------
>  1 file changed, 199 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index e4fc84c97c1e..9dab0fbcca61 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,10 +74,13 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> -#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
> +#define R8169_RX_RING_BYTES	((NUM_RX_DESC + 1) * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
>  #define R8169_MAX_MSIX_VEC	32
> +#define R8127_MAX_RX_QUEUES	8
> +#define R8169_DEFAULT_RX_QUEUES	1
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -444,6 +447,7 @@ enum rtl8125_registers {
>  	TxPoll_8125		= 0x90,
>  	LEDSEL3			= 0x96,
>  	MAC0_BKP		= 0x19e0,
> +	RDSAR_Q1_LOW		= 0x4000,
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> @@ -736,6 +740,21 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +enum rx_desc_ring_type {
> +	RX_DESC_RING_TYPE_DEFAULT,
> +	RX_DESC_RING_TYPE_RSS,
> +};
> +
> +struct rtl8169_rx_ring {
> +	u32 index;					/* Rx queue index */
> +	u32 cur_rx;					/* Index of next Rx pkt. */
> +	u32 dirty_rx;					/* Index for recycling. */
> +	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
> +	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
> +	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -743,16 +762,13 @@ struct rtl8169_private {
>  	struct phy_device *phydev;
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
>  	struct napi_struct *rtl8169_napi;
> +	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
>  	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
> @@ -2635,9 +2651,27 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		memset(ring->rx_desc_array, 0x0, R8169_RX_RING_BYTES);
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
> @@ -2702,9 +2736,11 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
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
> @@ -2835,6 +2871,8 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  
>  static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>  {
> +	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
> +
>  	/*
>  	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
>  	 * register to be written before TxDescAddrLow to work.
> @@ -2842,8 +2880,16 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
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

Not clear why u16 instead of unsigned int?

> +
> +		RTL_W32(tp, rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
> +		RTL_W32(tp, rdsar_reg, ((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
> +	}
>  }
>  
>  static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
> @@ -4190,12 +4236,13 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
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

Reverse xmas tree

>  
>  	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
>  	if (!data)
> @@ -4209,55 +4256,100 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
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
> +
> +	return 0;
> +}
> +
> +static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct rtl8169_rx_ring *ring;
> +	struct pci_dev *pdev = tp->pci_dev;

Reverse xmas tree. I won't check this any further, please check
yourself and fix in all affected places.

>  
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
> +							 R8169_RX_RING_BYTES,
> +							 &ring->rx_phy_addr,
> +							 GFP_KERNEL);
> +		if (!ring->rx_desc_array)
> +			return -1;
> +	}
>  	return 0;
>  }
>  
> +static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct rtl8169_rx_ring *ring;
> +	struct pci_dev *pdev = tp->pci_dev;
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		if (ring->rx_desc_array) {
> +			dma_free_coherent(&pdev->dev,
> +					  R8169_RX_RING_BYTES,
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
> @@ -4346,16 +4438,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
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
> @@ -4749,6 +4848,11 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
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
> @@ -4801,9 +4905,10 @@ static inline int rtl8169_fragmented_frame(u32 status)
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
> @@ -4811,22 +4916,58 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
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
> +static void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
> +				      dma_addr_t mapping)
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

Do we need this helper for one register read?
Description says "re-read to avoid missing RX", but you read the LED_CTRL
register. This needs an explanation, best extend the comment accordingly.
Do you have to read just a random register, or has it a specific reason
why you read exactly this register?

> +			status = le32_to_cpu(READ_ONCE(desc->opts1));
> +			if (status & DescOwn)
> +				break;
> +		}
>  
>  		/* This barrier is needed to keep us from reading
>  		 * any other fields out of the Rx descriptor until
> @@ -4834,20 +4975,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
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
> @@ -4863,14 +4998,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);
> +		skb = napi_alloc_skb(&tp->rtl8169_napi[ring->index], pkt_size);
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
> @@ -4879,7 +5014,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
>  
> -		rtl8169_rx_csum(skb, status);
> +		rtl8169_rx_csum(skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
>  		rtl8169_rx_vlan_tag(desc, skb);
> @@ -4887,10 +5022,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->rtl8169_napi[0], skb);
> +		napi_gro_receive(&tp->rtl8169_napi[ring->index], skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> +		rtl8169_set_desc_dma_addr(desc, ring->rx_desc_phy_addr[entry]);
>  		rtl8169_mark_to_asic(desc);
>  	}
>  
> @@ -4917,6 +5053,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		phy_mac_interrupt(tp->phydev);
>  
>  	rtl_irq_disable(tp);
> +	tp->recheck_desc_ownbit = true;
>  	napi_schedule(napi);
>  out:
>  	rtl_ack_events(tp, status);
> @@ -4992,7 +5129,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  
>  	rtl_tx(dev, tp, budget);
>  
> -	work_done = rtl_rx(dev, tp, budget);
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done))
>  		rtl_irq_enable(tp);
> @@ -5120,21 +5258,19 @@ static int rtl8169_close(struct net_device *dev)
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
> @@ -5165,13 +5301,11 @@ static int rtl_open(struct net_device *dev)
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
> @@ -5198,11 +5332,10 @@ static int rtl_open(struct net_device *dev)
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
> @@ -5705,7 +5838,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


