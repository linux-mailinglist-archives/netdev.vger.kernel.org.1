Return-Path: <netdev+bounces-285044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOxzO662+2njDgAAu9opvQ
	(envelope-from <netdev+bounces-285044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 755814E0B7B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232513004C4F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A230FC1C;
	Wed,  6 May 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An1uEFv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F563101C0
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103961; cv=none; b=Hm06u3J9sE+Kgu5B5dUVkOC9JdD/ZnVvsyBo3e3LV5z5aeMeschL6OAsly1WIggwtDMjQT+MjMlf709dX8n4kOS/Jq8WyDrkHdLLFkPs02wFSMEWuWOW5RCbg/dIZ5UVsVivTQQCYB8xqP09w5PYqLKiEzffSWjIC//mM3eFC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103961; c=relaxed/simple;
	bh=Wz7zeCAdqlhonEL+q9pXw3EkDlRshJTFP0DIzzU+QtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES/odQP/SU1UzIKI9x5r0il4xvT+JrhRDO7XDMbNE0T+eKW0um0spJgI36x/SGj2gKMpZ7uPnXCQMq1P1UVo6jJgNGtrrmpLLUWlDKBqPuTcffW+3+n0IS4qeqBMrlPAW33WU2m/unTzrGGhX8GsIE3FENsv/gI50Fty7rBe2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An1uEFv+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a74032ff8so121083f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778103957; x=1778708757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYv6dOQyiJI/Mez+VrG2R7WKPSkXT3pnt5PkXAaA9Ws=;
        b=An1uEFv+im+u9NhsBCJW0v1yy2HJ5TsgLdJT7azn1yIv9Wg7GkTrm8i/Sa0a/6Opme
         BFwwQzq0BQ16/dt65nOjTX7kT+Prfte2oRhXDMMerSCMCDSiaIisfQlrMArGFht6386a
         cCknhG6UFIK3NyGc4H6fpILK+7gl6MYsf7Gy8sGPTMgtjvfEDKiLqswXZvw4uXF1WAI6
         XbRkOzu/MzOMWbFViqfmp0qGBec2ZbDv4oPkn92Edn0nhLtFtWONT936MyRhiBFzmX2R
         KxcMb9wqht3CYBHGiJk63g5icXp3vlMCeueDMTfU12EEI8E/B79Ufr0EsdKw2UBCKcZM
         DKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778103957; x=1778708757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYv6dOQyiJI/Mez+VrG2R7WKPSkXT3pnt5PkXAaA9Ws=;
        b=s9m5AgkPFJxu2yhp2TXj7yr2Z1jkfGKTnQs0G7+7usu6fiI9hOpFtbHmqB3ZPfuqHo
         EFSbyCf83ojP0Ssz7pODYv7IAFrSy6RWjvEhtIC80MUpUdnVV5to9lbgtYz19Cxj+SmI
         dLe5BubN1ZAhbxbzzr6gNHmJzGic4Kr+CCXV85sVYD0p+2MzrGrFUagB1joHuoQnbxsp
         nuKDyBJ/qEUBytC/aq+EP00Az25yd8YzRzW00w8hRVOpeC2H4jvkFVSstoGsT1AJ0XZ1
         wMAQwciQamYayoXzBn19KHcnOPDvTJdBsXjByUb1NvQrFpsj7QAoinKCnfpjwlEfDY+k
         /4QA==
X-Gm-Message-State: AOJu0Yzys0TYjkUlfbRtz/fqMDjsx+HEW510U+cZEE9L8fo/8W1sbaFZ
	DivgV7H/fPe/joV4r87Noy0dV40o3zVhvdYYrHt16QrKhn5+t/cRpLQb
X-Gm-Gg: AeBDieuwuZNzq4aBAzz4foDOmde0E7/Bc9QHSR0/RLdMptO08yAGNnzhZIu8HNKyH4e
	57VWi0yw8xBYWmwKXkPWFfJaDugMs+Z7bCNQZTchsNaDPS08FXfuSx75aagv+7lZEf3oW/wYQyx
	0Gwy0BxoJ8/Ds5LIdRzG9z9khl1o3t7RIN5cVSpg+gc2nA4EjqypcSHrFZ+vPkCz222EWcOcCQn
	cnstSwnP0nmbmTjUBXW+aGdF3/g+8XFNqhTnN9FIaB6Booo/d5ZJslUC7TCbeaMcrb8CF7oOPVC
	Tw5vxlntDgnY/NEbIPApP+14Pf43N71ZCLi2NeK7GZcUa+yjkvvwifrT4mHPLDoc5izsPRsDZQG
	H6hWrQJN6HCybOD1SVJIRs+xhU1R6Ed/wfOCo5j2n6edZeHZJK/xqAjLWw7iZC21v2gXi48SqPB
	RNjXulrLZp1vOOQnEiUqtn1PrEKWJr/JpTHa4JkT8Y2gCfVMlRglG+DB1dWgXHNZYPwGNjnBoSh
	hCZc0uAIQMHcIEI6fJINmz0Q92/Sriznfqd1204Xg7QIMUrpkJOQ8nxSGWWaO0XkHKrT94Kxr7s
X-Received: by 2002:a05:6000:1789:b0:441:1c06:17e4 with SMTP id ffacd0b85a97d-4515da9544cmr8968473f8f.39.1778103957259;
        Wed, 06 May 2026 14:45:57 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:7800:4039:5b18:9ac5:4054? (p200300ea8f24780040395b189ac54054.dip0.t-ipconnect.de. [2003:ea:8f24:7800:4039:5b18:9ac5:4054])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505558e213sm16228108f8f.25.2026.05.06.14.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 14:45:56 -0700 (PDT)
Message-ID: <9010eca8-5ae1-4b32-8641-b310aa9e317a@gmail.com>
Date: Wed, 6 May 2026 23:45:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v1 2/7] r8169: add support for multi rx queues
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
 <20260506081326.767-3-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260506081326.767-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 755814E0B7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285044-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On 06.05.2026 10:13, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for multi rx queues. RSS requires multi rx
> queues to receive packets. So we need struct rtl8169_rx_ring for each
> queue.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 318 +++++++++++++++++-----
>  1 file changed, 251 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ef74ee02c117..bc75dbb9901d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,10 +74,11 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> -#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
>  #define R8169_MAX_MSIX_VEC	32
> +#define R8127_MAX_RX_QUEUES	8

Why two MAX_RX_QUEUES constants with the same value?

>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -447,6 +448,7 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	RDSAR_Q1_LOW		= 0x4000,

Better sort register ids by register number?

>  };
>  
>  #define LEDSEL_MASK_8125	0x23f
> @@ -731,6 +733,19 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_rx_ring {
> +	u32 index;					/* Rx queue index */
> +	u32 cur_rx;					/* Index of next Rx pkt. */
> +	u32 dirty_rx;					/* Index for recycling. */
> +	u32 num_rx_desc;				/* num of Rx desc */
> +	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
> +	u32 rx_desc_alloc_size;				/* memory size per descs of ring */
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
> +	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
> +	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
> +	u16 rdsar_reg;					/* Receive Descriptor Start Address */
> +};
> +
>  struct rtl8169_napi {
>  	struct napi_struct napi;
>  	void *priv;
> @@ -744,6 +759,13 @@ struct rtl8169_irq {
>  	char		name[IFNAMSIZ + 10];
>  };
>  
> +enum rx_desc_ring_type {
> +	RX_DESC_RING_TYPE_UNKNOWN = 0,
> +	RX_DESC_RING_TYPE_DEFAULT,
> +	RX_DESC_RING_TYPE_RSS,
> +	RX_DESC_RING_TYPE_MAX

UNKNOWN and MAX seem to never be used in this series.
So do we need them?

> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -752,28 +774,28 @@ struct rtl8169_private {
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
>  	u16 isr_reg[R8169_MAX_MSIX_VEC];
>  	u16 imr_reg[R8169_MAX_MSIX_VEC];
>  	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	u16 hw_supp_num_rx_queues;
>  	u8 min_irq_nvecs;
>  	u8 max_irq_nvecs;
>  	u8 hw_supp_isr_ver;
>  	u8 hw_curr_isr_ver;
>  	u8 irq_nvecs;
> +	u8 init_rx_desc_type;
> +	u8 recheck_desc_ownbit;

This seems to be a flag. Then why type u8?

>  	int irq;
>  	struct clk *clk;
>  
> @@ -2647,9 +2669,27 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
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
> @@ -2708,8 +2748,18 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl_set_ring_size(struct rtl8169_private *tp, u32 rx_num)
> +{
> +	for (int i = 0; i < tp->hw_supp_num_rx_queues; i++)
> +		tp->rx_ring[i].num_rx_desc = rx_num;
> +}
> +
>  static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
>  {
> +	tp->rx_ring[0].rdsar_reg = RxDescAddrLow;
> +	for (int i = 1; i < tp->hw_supp_num_rx_queues; i++)
> +		tp->rx_ring[i].rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);

This looks like array rx_ring[] isn't actually needed.

> +
>  	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
>  		tp->isr_reg[0] = IntrStatus;
>  		tp->imr_reg[0] = IntrMask;
> @@ -2733,17 +2783,21 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  	case RTL_GIGA_MAC_VER_80:
>  		tp->min_irq_nvecs = 1;
>  		tp->max_irq_nvecs = 1;
> +		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
>  		tp->hw_supp_isr_ver = 6;
>  		break;
>  	default:
>  		tp->min_irq_nvecs = 1;
>  		tp->max_irq_nvecs = 1;
> +		tp->hw_supp_num_rx_queues = 1;
>  		tp->hw_supp_isr_ver = 1;
>  		break;
>  	}
> +	tp->init_rx_desc_type = RX_DESC_RING_TYPE_DEFAULT;
>  	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
>  
>  	rtl_setup_mqs_reg(tp);
> +	rtl_set_ring_size(tp, NUM_RX_DESC);
>  }
>  
>  static void rtl_request_firmware(struct rtl8169_private *tp)
> @@ -2877,8 +2931,13 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>  	 */
>  	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
>  	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
> -	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
> -	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
> +
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +
> +		RTL_W32(tp, ring->rdsar_reg, ((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
> +		RTL_W32(tp, ring->rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
> +	}
>  }
>  
>  static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
> @@ -4214,7 +4273,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>  	return 0;
>  }
>  
> -static void rtl8169_mark_to_asic(struct RxDesc *desc)
> +static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
>  {
>  	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
>  
> @@ -4224,13 +4283,19 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
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
> +	struct RxDesc *desc = ring->rx_desc_array + index;
>  
>  	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
>  	if (!data)
> @@ -4244,55 +4309,111 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	}
>  
>  	desc->addr = cpu_to_le64(mapping);
> -	rtl8169_mark_to_asic(desc);
> +	ring->rx_desc_phy_addr[index] = mapping;
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

Do we actually need this in this patch?

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
> +	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
> +
> +	return 0;
> +}
> +
> +static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
> +{
> +	struct rtl8169_rx_ring *ring;
> +	struct pci_dev *pdev = tp->pci_dev;
>  
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		ring = &tp->rx_ring[i];
> +		ring->rx_desc_alloc_size = (ring->num_rx_desc + 1) * sizeof(struct RxDesc);
> +		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
> +							 ring->rx_desc_alloc_size,
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
> @@ -4381,16 +4502,24 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
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
> +		for (int j = 0; j < ring->num_rx_desc; j++)
> +			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
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
> +
>  	rtl8169_napi_enable(tp);
>  
>  	rtl_hw_start(tp);
> @@ -4784,6 +4913,11 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
>  	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>  }
>  
> +static void rtl8169_desc_quirk(struct rtl8169_private *tp)
> +{
> +	RTL_R8(tp, tp->imr_reg[0]);
> +}
> +
>  static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
>  		   int budget)
>  {
> @@ -4836,9 +4970,11 @@ static inline int rtl8169_fragmented_frame(u32 status)
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
> @@ -4846,22 +4982,71 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
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

I don't see which benefit the helper provides. Instead it may cause side effects
due to the READ_ONCE().

> +
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
> +static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
> +					     struct RxDesc *desc,
> +					     dma_addr_t mapping)
> +{
> +	desc->addr = cpu_to_le64(mapping);
> +}

Argument tp isn't used. Why is it there?

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
> +		struct RxDesc *desc = ring->rx_desc_array + entry;
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
> +				break;
> +
> +			/* Workaround for a hardware issue:

Hardware issue on which chip version(s)?

> +			 * Hardware might trigger RX interrupt before the DMA
> +			 * engine fully updates RX desc ownbit in host memory.
> +			 * So we do a quirk and re-read to avoid missing RX
> +			 * packets.
> +			 */
> +			tp->recheck_desc_ownbit = false;
> +			rtl8169_desc_quirk(tp);
> +			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
> +			if (status & DescOwn)
> +				break;
> +		}
>  
>  		/* This barrier is needed to keep us from reading
>  		 * any other fields out of the Rx descriptor until
> @@ -4869,20 +5054,15 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		 */
>  		dma_rmb();
>  
> -		if (unlikely(status & RxRES)) {
> +		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
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
> @@ -4898,14 +5078,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
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
> @@ -4914,7 +5094,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
>  
> -		rtl8169_rx_csum(skb, status);
> +		rtl8169_rx_csum(tp, skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
>  		rtl8169_rx_vlan_tag(desc, skb);
> @@ -4922,11 +5102,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->r8169napi[0].napi, skb);
> +		napi_gro_receive(&tp->r8169napi[ring->index].napi, skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> -		rtl8169_mark_to_asic(desc);
> +		rtl8169_set_desc_dma_addr(tp, desc, ring->rx_desc_phy_addr[entry]);
> +		rtl8169_mark_to_asic(tp, desc);
>  	}
>  
>  	return count;
> @@ -4952,6 +5133,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		phy_mac_interrupt(tp->phydev);
>  
>  	rtl_irq_disable(tp);
> +	tp->recheck_desc_ownbit = true;
>  	napi_schedule(&napi->napi);
>  out:
>  	rtl_ack_events(tp, status);
> @@ -5040,7 +5222,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  
>  	rtl_tx(dev, tp, budget);
>  
> -	work_done = rtl_rx(dev, tp, budget);
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done))
>  		rtl_irq_enable(tp);
> @@ -5168,21 +5351,21 @@ static int rtl8169_close(struct net_device *dev)
>  	struct pci_dev *pdev = tp->pci_dev;
>  
>  	pm_runtime_get_sync(&pdev->dev);
> -
>  	netif_stop_queue(dev);
> +
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
> +
> +	rtl8169_free_rx_desc(tp);
>  
>  	pm_runtime_put_sync(&pdev->dev);
>  
> @@ -5211,16 +5394,15 @@ static int rtl_open(struct net_device *dev)
>  	 * Rx and Tx descriptors needs 256 bytes alignment.
>  	 * dma_alloc_coherent provides more.
>  	 */
> +

It's not the only place with unmotivated changes. Please remove these changes.

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
> @@ -5249,11 +5431,10 @@ static int rtl_open(struct net_device *dev)
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
> @@ -5767,7 +5948,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


