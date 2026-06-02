Return-Path: <netdev+bounces-294421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KVy7F5dKH2q9jgAAu9opvQ
	(envelope-from <netdev+bounces-294421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887A63212F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IRopjsTS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294421-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294421-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A7F307FDD2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958539EF35;
	Tue,  2 Jun 2026 21:23:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340A3939B2
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:23:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435395; cv=none; b=QCFtgrdUIBFIjBrwlA+lZRyf0AgTWyeiUUGPql5wijeC+Xyh18FcbKYmTSgSQwkIAV8fLHPJVzBsDRszf1f9TQd933YBSMVugQSwZONR+HFHpTSjYUPX8EWaEibLCuBZH0djg08qOHVFT5kEdE2IrjyeJkjGIj4mk7dB+60/j3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435395; c=relaxed/simple;
	bh=stvEYqDOnf+oS/iCdVGhLSxXFJKK8kSFjDSJu4PKdN8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nx1+SkYaXZv3uUmlzElBNaUEmQRDY0BOXg99IdZNSJ4sbiB2fM5B+3p0KUDbhFiKQIkW50maU6EZZitxJGpCbMfVw1SuSfBvsbH7OS5kMvj9gcaZ6td+9PAuBbZ6e/5uAnfTGPOPr4OqYE1ZXsjnI/HGeBwG+zIIs+jjsJe1FY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRopjsTS; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso29254095e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780435391; x=1781040191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1OrAf/98h05Aier3BfT8MPgCH6ap6pj/NUvJOc/CyQ=;
        b=IRopjsTS813vlAJAGKda3aihFnjcx43YaVH7Wj2z1BWQ5TXKf7CQEgYxQWx9VzfinM
         ENmpwKjyX+NOnTZor1hMnhjkXJBamRFzycNq2apJwEBKXsA5H87Q4gQ2cfRbUHDHD/3e
         fXr9FC6nV6SQfeH029juO3/ZxkMOhGEnYaSZEVMzh/6MvFgtjCCgHgIDF7qjrUq32lMp
         KZN/0vYHlEWBnX5DPmBnJigKHl/K24wm0WOI4dqb08uCczkc4YJ3S5jP43Pk67yaHh4a
         oLHOtY9B0db2ervvYlx8M8JOWVIx5BP7YHZH8kMPvKRSdq/Uh8TO3DIJJgZTt/JPNBMm
         GokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780435391; x=1781040191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1OrAf/98h05Aier3BfT8MPgCH6ap6pj/NUvJOc/CyQ=;
        b=XJY3+ycnXZIfEiajKRuh1TVjsonkA197DvedUWM3/EWu8Tcd+AU/4WREmXL1fQUqPc
         11Ix6gACKQb8esGZDLM0LagMyo5FC5C7l8cbel/oF2QegA117YxtjZkM7cGosYgmrVy8
         nNfbqYqVzJeX5Qjh6AcF9VGh3DRZe6npVdwWzcWxR6xsCcHhOhKNN/QdF6TbglWhauim
         Fic53LvbvY6II//+hYQUR3OXGZCkHn88MlVfsSS67+PQf3ZtaehbLBP4BXauojsDQ0Vj
         fZ9tAIzZUW5RvSVqrxspUqt+y8l0qli95NuHUtqb3rDyCjC4PK7T4trv8T+J8b1OgeD2
         mw/w==
X-Gm-Message-State: AOJu0YyMbpaHrI6OTXBYRl6cyCey/9IMp6nGkPUGKHajt4mwLQfa1DCM
	tH9NPz5glPZlM1V07reG4y07qYK2zBYCu/pzU90z15ne+wRtJNeF1AyP
X-Gm-Gg: Acq92OGhN9n8weVp5LPe3uJoOsJfCTg2pG1u9RDszo++46SdZxzxjrVtNlj5nb0supT
	bUJxQnuX9vsvu9RFu6Ek8kfSneKKAdrVRKBYRhonOOiHlFpMJzoocFDpvCZEmQVCYGMNb18j8tV
	2f5yywi9+vbs+TESbbSYoN+wyDWme8jv7m3W74IdjXsuCwOZtj2gdtxTq/ncHi1s8ts0RQPMm48
	5iSX+X+7/W8R40YtY8RM+TPAGhITG9vKVfWOydxduM9sJNLsgy27ryfpjfHQ18W3EJSyXM/xccv
	CW1uecvrGdJs1loOpVfCuoe3BLS2H+Orf3l+W5IWhLrcxtF9uxe4+c8uaWOvpTcXczbWP800Kwk
	0B0/eW4hQoD9mBIdzqybeSHMyiAomT/l6dI/2iknrGYq1mLYgHmoE7fXjoDQQCj2e9PrUHUy4mj
	Cqx9NKfW559lgUVEO25q/qDN3tcXlkL/Swy3MCWk8IKjjLBNsTnP273k/sxAnCbmbak89gU58UQ
	zrTVFkMPFW9L/cMvF7UKT7p25/zoayTXc3RQJLZeUfEVr4OGr/IzFud9u1ZOI2sZQ+ZRUf/ZzFQ
X-Received: by 2002:a05:600c:458b:b0:490:548e:b854 with SMTP id 5b1f17b1804b1-490b5fda828mr8870565e9.26.1780435390792;
        Tue, 02 Jun 2026 14:23:10 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f35:a100:65ef:a45f:1f40:5f43? (p200300ea8f35a10065efa45f1f405f43.dip0.t-ipconnect.de. [2003:ea:8f35:a100:65ef:a45f:1f40:5f43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b444f4fesm36906265e9.12.2026.06.02.14.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:23:09 -0700 (PDT)
Message-ID: <6cb1a9b5-6872-4aaf-b6c3-4e1ebd36ac6c@gmail.com>
Date: Tue, 2 Jun 2026 23:23:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v6 5/7] r8169: add support and enable rss
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
 <20260526081117.173-6-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260526081117.173-6-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8887A63212F

On 26.05.2026 10:11, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support and enable rss for RTL8127.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - some changes moved from Patch 2/7
> 
> Changes in v3:
>  - add struct rtl8169_rss_data. Allocate it dynamically when needed.
>  - define rss_key as an u32 array
>  - replace some magic bit numbers in rtl8169_set_rss_hash_opt() and
>    rtl8125_set_rx_q_num()
>  - use union to combine different rx descriptor, refactor struct RxDesc
>  - remove dead code from rtl8169_double_check_rss_support()
> 
> Changes in v4:
>  - rename macro definition, e.g R8127_MAX_IRQ to R8127_MAX_NUM_IRQVEC
>  - change hw_supp_indir_tbl_entries type to unsigned int
>  - change init_rx_desc_type type to enum
>  - remove rtl_check_rss_support(), add helper function
>    rtl_hw_support_rss()
>  - remove hw_curr_isr_ver, use irq_nvecs to judge whether we should
>    enable vector interrupt mapping, use tp->num_rx_ring to judge whether
>    we should enable rss
>  - remove function rtl8169_double_check_rss_support(), use
>    rtl8169_set_rx_ring_num() to set num_rx_ring according to tp->irq_nvecs
> 
> Changes in v5:
>  - no changes
> 
> Changes in v6:
>  - change rss_queue_num type from u8 to unsigned int
>  - fix rx desc clear in rtl8169_rx_clear() for different desc type
>  - clamping num_rx_ring with rounddown_pow_of_two()
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 397 +++++++++++++++++++---
>  1 file changed, 358 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 13d955324037..a79a8756516d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -82,6 +82,19 @@
>  #define R8127_MAX_TX_QUEUES	8
>  #define R8169_DEFAULT_RX_QUEUES	1
>  #define R8169_MAX_TX_QUEUES	1
> +#define R8127_MAX_NUM_IRQVEC	32
> +#define R8127_MIN_NUM_IRQVEC	30
> +#define R8169_IRQ_DEFAULT	1
> +#define RTL_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_MASK	GENMASK(18, 16)
> +#define RSS_HASH_MASK		GENMASK(10, 8)
> +#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
> +#define RXS_RSS_UDP		BIT(27)
> +#define RXS_RSS_IPV4		BIT(28)
> +#define RXS_RSS_IPV6		BIT(29)
> +#define RXS_RSS_TCP		BIT(30)
> +#define RXS_RSS_L3_TYPE_MASK	(RXS_RSS_IPV4 | RXS_RSS_IPV6)
> +#define RXS_RSS_L4_TYPE_MASK	(RXS_RSS_TCP | RXS_RSS_UDP)
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -589,6 +602,25 @@ enum rtl_register_content {
>  #define	ISRIMR_LINKCHG	BIT(29)
>  #define	ISRIMR_TOK_Q0	BIT(8)
>  #define	ISRIMR_ROK_Q0	BIT(0)
> +#define RTL_DESC_TYPE_CTRL		0xd8
> +#define RSS_KEY_REG			0x4600
> +#define RSS_INDIRECTION_TBL_REG		0x4700
> +#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
> +#define RTL_DESC_TYPE_RSS		BIT(1)
> +#define RSS_CTRL_IPV4_SUPP		BIT(1)
> +#define RSS_CTRL_TCP_IPV6_SUPP		BIT(2)
> +#define RSS_CTRL_IPV6_SUPP		BIT(3)
> +#define RSS_CTRL_IPV6_EXT_SUPP		BIT(4)
> +#define RSS_CTRL_TCP_IPV6_EXT_SUPP	BIT(5)
> +#define RSS_CTRL_UDP_IPV4_SUPP		BIT(6)
> +#define RSS_CTRL_UDP_IPV6_SUPP		BIT(7)
> +#define RSS_CTRL_UDP_IPV6_EXT_SUPP	BIT(8)
> +#define RTL_RSS_FLAG_HASH_UDP_IPV4	BIT(0)
> +#define RTL_RSS_FLAG_HASH_UDP_IPV6	BIT(1)
> +#define	RX_RES_RSS			BIT(22)
> +#define	RX_RUNT_RSS			BIT(21)
> +#define	RX_CRC_RSS			BIT(20)
> +#define RTL_RX_Q_NUM_MASK		GENMASK(4, 2)
>  };
>  
>  enum rtl_desc_bit {
> @@ -646,6 +678,11 @@ enum rtl_rx_desc_bit {
>  #define RxProtoIP	(PID1 | PID0)
>  #define RxProtoMask	RxProtoIP
>  
> +#define	RX_UDPT_DESC_RSS	BIT(19)
> +#define	RX_TCPT_DESC_RSS	BIT(18)
> +#define	RX_UDPF_DESC_RSS	BIT(16) /* UDP/IP checksum failed */
> +#define	RX_TCPF_DESC_RSS	BIT(15) /* TCP/IP checksum failed */
> +
>  	IPFail		= (1 << 16), /* IP checksum failed */
>  	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
>  	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
> @@ -667,9 +704,27 @@ struct TxDesc {
>  };
>  
>  struct RxDesc {
> -	__le32 opts1;
> -	__le32 opts2;
> -	__le64 addr;
> +	union {
> +		/* RX_DESC_TYPE_DEFAULT */
> +		struct {
> +			__le32 opts1;
> +			__le32 opts2;
> +			__le64 addr;
> +		};
> +
> +		/* RX_DESC_TYPE_RSS */
> +		struct {
> +			union {
> +				__le64 rss_addr;
> +				struct {
> +					__le32 rss_info;
> +					__le32 rss_result;
> +				} rss_dword;
> +			};
> +			__le32 rss_opts2;
> +			__le32 rss_opts1;
> +		};
> +	};
>  };
>  
>  struct ring_info {
> @@ -741,9 +796,9 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> -enum rx_desc_ring_type {
> -	RX_DESC_RING_TYPE_DEFAULT,
> -	RX_DESC_RING_TYPE_RSS,
> +enum rx_desc_type {
> +	RX_DESC_TYPE_DEFAULT,
> +	RX_DESC_TYPE_RSS,
>  };
>  
>  struct rtl8169_rx_ring {
> @@ -756,6 +811,12 @@ struct rtl8169_rx_ring {
>  	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
>  };
>  
> +struct rtl8169_rss_data {
> +	u32 rss_key[RTL_RSS_KEY_SIZE / sizeof(u32)];
> +	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
> +	unsigned int hw_supp_indir_tbl_entries;
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -775,7 +836,9 @@ struct rtl8169_private {
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
>  	unsigned int hw_supp_num_rx_queues;
> +	struct rtl8169_rss_data *rss_data;
>  	unsigned int irq_nvecs;
> +	enum rx_desc_type init_rx_desc_type;
>  	struct clk *clk;
>  
>  	struct {
> @@ -1606,6 +1669,11 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static bool rtl_hw_support_rss(struct rtl8169_private *tp)
> +{
> +	return tp->mac_version == RTL_GIGA_MAC_VER_80;
> +}
> +
>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
> @@ -1907,9 +1975,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
>  		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
>  }
>  
> -static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
> +static void rtl8169_rx_vlan_tag(struct rtl8169_private *tp,
> +				struct RxDesc *desc,
> +				struct sk_buff *skb)
>  {
> -	u32 opts2 = le32_to_cpu(desc->opts2);
> +	u32 opts2;
> +
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		opts2 = le32_to_cpu(desc->rss_opts2);
> +		break;
> +	default:
> +		opts2 = le32_to_cpu(desc->opts2);
> +		break;
> +	}
>  
>  	if (opts2 & RxVlanTag)
>  		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
> @@ -2738,17 +2817,27 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl8169_init_rss(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
> +		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
> +
> +	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
> +}
> +
>  static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  {
>  	tp->num_rx_rings = 1;
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
>  		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
> +		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
>  		break;
>  	default:
>  		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
>  		break;
>  	}
> +	tp->init_rx_desc_type = RX_DESC_TYPE_DEFAULT;
>  }
>  
>  static void rtl_request_firmware(struct rtl8169_private *tp)
> @@ -2873,6 +2962,64 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>  }
>  
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)
> +{
> +	u32 num_entries = RTL_RSS_KEY_SIZE / sizeof(u32);
> +	u32 *rss_key = tp->rss_data->rss_key;
> +	const u16 rss_key_reg = RSS_KEY_REG;
> +
> +	/* Write redirection table to HW */
> +	for (int i = 0; i < num_entries; i++)
> +		RTL_W32(tp, rss_key_reg + (i * 4), rss_key[i]);
> +}
> +
> +static void rtl8169_store_reta(struct rtl8169_private *tp)
> +{
> +	u32 i, reta_entries = tp->rss_data->hw_supp_indir_tbl_entries;
> +	u16 indir_tbl_reg = RSS_INDIRECTION_TBL_REG;

Do these variables really require fixed-width types?
And why variable indir_tbl_reg at all?

> +	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
> +	u32 reta = 0;
> +
> +	/* Write redirection table to HW */
> +	for (i = 0; i < reta_entries; i++) {
> +		reta |= indir_tbl[i] << (i & 0x3) * 8;
> +		if ((i & 3) == 3) {
> +			RTL_W32(tp, indir_tbl_reg, reta);
> +			indir_tbl_reg += 4;
> +			reta = 0;
> +		}
> +	}
> +}
> +
> +static int rtl8169_set_rss_hash_opt(struct rtl8169_private *tp)
> +{
> +	u32 rss_ctrl;
> +
> +	rss_ctrl = FIELD_PREP(RSS_CPU_NUM_MASK, ilog2(tp->num_rx_rings));
> +
> +	/* Perform hash on these packet types */
> +	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP
> +		 | RSS_CTRL_IPV4_SUPP
> +		 | RSS_CTRL_IPV6_SUPP
> +		 | RSS_CTRL_IPV6_EXT_SUPP
> +		 | RSS_CTRL_TCP_IPV6_SUPP
> +		 | RSS_CTRL_TCP_IPV6_EXT_SUPP;
> +
> +	rss_ctrl |= FIELD_PREP(RSS_HASH_MASK,
> +			       ilog2(tp->rss_data->hw_supp_indir_tbl_entries));
> +
> +	RTL_W32(tp, RSS_CTRL_8125, rss_ctrl);
> +
> +	return 0;
> +}
> +
> +static void rtl_set_rss_config(struct rtl8169_private *tp)
> +{
> +	rtl8169_set_rss_hash_opt(tp);
> +	rtl8169_store_reta(tp);
> +	rtl8169_store_rss_key(tp);
> +}
> +
>  static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>  {
>  	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
> @@ -3939,6 +4086,18 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>  	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>  }
>  
> +static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
> +{
> +	u16 rx_q_num;
> +	u16 q_ctrl;
> +
> +	rx_q_num = (u16)ilog2(tp->num_rx_rings);

Is the cast needed here?

> +	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
> +	q_ctrl &= ~RTL_RX_Q_NUM_MASK;
> +	q_ctrl |= FIELD_PREP(RTL_RX_Q_NUM_MASK, rx_q_num);
> +	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
> +}
> +
>  static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
>  {
>  	u8 tmp;
> @@ -3978,6 +4137,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	    tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
>  
> +	/* enable rx descriptor type v4 and set queue num for rss*/
> +	if (tp->num_rx_rings > 1) {
> +		rtl8125_set_rx_q_num(tp);
> +		RTL_W8(tp, RTL_DESC_TYPE_CTRL,
> +		       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
> +	}
> +
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
>  	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> @@ -4214,6 +4380,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
>  	rtl_hw_aspm_clkreq_enable(tp, true);
>  	rtl_set_rx_max_size(tp);
>  	rtl_set_rx_tx_desc_registers(tp);
> +	if (rtl_is_8125(tp)) {
> +		if (tp->num_rx_rings > 1)
> +			rtl_set_rss_config(tp);
> +		else
> +			RTL_W32(tp, RSS_CTRL_8125, 0x00);
> +	}
>  	rtl_lock_config_regs(tp);
>  
>  	rtl_jumbo_config(tp);
> @@ -4241,14 +4413,26 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>  	return 0;
>  }
>  
> -static void rtl8169_mark_to_asic(struct RxDesc *desc)
> +static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
>  {
> -	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
> +	u32 eor;
>  
> -	desc->opts2 = 0;
> -	/* Force memory writes to complete before releasing descriptor */
> -	dma_wmb();
> -	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		eor = le32_to_cpu(desc->rss_opts1) & RingEnd;
> +		desc->rss_opts2 = cpu_to_le32(0);
> +		/* Force memory writes to complete before releasing descriptor */
> +		dma_wmb();
> +		WRITE_ONCE(desc->rss_opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +		break;
> +	default:
> +		eor = le32_to_cpu(desc->opts1) & RingEnd;
> +		desc->opts2 = cpu_to_le32(0);
> +		/* Force memory writes to complete before releasing descriptor */
> +		dma_wmb();
> +		WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +		break;
> +	}
>  }
>  
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
> @@ -4271,9 +4455,12 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  		return NULL;
>  	}
>  
> -	desc->addr = cpu_to_le64(mapping);
>  	ring->rx_desc_phy_addr[index] = mapping;
> -	rtl8169_mark_to_asic(desc);
> +	if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
> +		desc->rss_addr = cpu_to_le64(mapping);
> +	else
> +		desc->addr = cpu_to_le64(mapping);
> +	rtl8169_mark_to_asic(tp, desc);
>  
>  	return data;
>  }
> @@ -4289,8 +4476,25 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring
>  		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
>  		ring->rx_databuff[i] = NULL;
>  		ring->rx_desc_phy_addr[i] = 0;
> -		ring->rx_desc_array[i].addr = 0;
> -		ring->rx_desc_array[i].opts1 = 0;
> +		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS) {
> +			ring->rx_desc_array[i].rss_addr = 0;
> +			ring->rx_desc_array[i].rss_opts1 = 0;
> +		} else {
> +			ring->rx_desc_array[i].addr = 0;
> +			ring->rx_desc_array[i].opts1 = 0;
> +		}
> +	}
> +}
> +
> +static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		desc->rss_opts1 |= cpu_to_le32(RingEnd);
> +		break;
> +	default:
> +		desc->opts1 |= cpu_to_le32(RingEnd);
> +		break;
>  	}
>  }
>  
> @@ -4310,7 +4514,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
>  	}
>  
>  	/* mark as last descriptor in the ring */
> -	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
> +	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
>  
>  	return 0;
>  }
> @@ -4466,7 +4670,7 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
>  		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>  
>  		for (int j = 0; j < NUM_RX_DESC; j++)
> -			rtl8169_mark_to_asic(ring->rx_desc_array + j);
> +			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
>  	}
>  }
>  
> @@ -4922,35 +5126,104 @@ static inline int rtl8169_fragmented_frame(u32 status)
>  	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>  }
>  
> -static inline void rtl8169_rx_csum(struct sk_buff *skb,
> +static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
> +				   struct RxDesc *desc,
> +				   struct sk_buff *skb)
> +{
> +	u32 rss_header_info;
> +	u32 hash_val;
> +
> +	if (!(tp->dev->features & NETIF_F_RXHASH))
> +		return;
> +
> +	rss_header_info = le32_to_cpu(desc->rss_dword.rss_info);
> +
> +	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
> +		return;
> +
> +	hash_val = le32_to_cpu(desc->rss_dword.rss_result);
> +
> +	skb_set_hash(skb, hash_val,
> +		     (RXS_RSS_L4_TYPE_MASK & rss_header_info) ?
> +		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
> +}
> +
> +static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
> +				   struct sk_buff *skb,
>  				   struct RxDesc *desc)
>  {
> -	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
> +	bool csum_ok = false;
> +	u32 opts1;
>  
> -	if (status == RxProtoTCP || status == RxProtoUDP)
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		opts1 = le32_to_cpu(desc->rss_opts1);
> +		if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
> +		    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
> +			csum_ok = true;
> +		break;
> +	default:
> +		opts1 = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
> +		if (opts1 == RxProtoTCP || opts1 == RxProtoUDP)
> +			csum_ok = true;
> +		break;
> +	}
> +
> +	if (csum_ok)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	else
>  		skb_checksum_none_assert(skb);
>  }
>  
> +static __le32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		return READ_ONCE(desc->rss_opts1);
> +	default:
> +		return READ_ONCE(desc->opts1);
> +	}
> +}
> +
>  static bool rtl8169_check_rx_desc_error(struct net_device *dev,
>  					struct rtl8169_private *tp,
>  					u32 status)
>  {
> -	if (unlikely(status & RxRES)) {
> -		if (status & (RxRWT | RxRUNT))
> -			dev->stats.rx_length_errors++;
> -		if (status & RxCRC)
> -			dev->stats.rx_crc_errors++;
> -		return true;
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		if (unlikely(status & RX_RES_RSS)) {
> +			if (status & RX_RUNT_RSS)
> +				dev->stats.rx_length_errors++;
> +			if (status & RX_CRC_RSS)
> +				dev->stats.rx_crc_errors++;
> +			return true;
> +		}
> +		break;
> +	default:
> +		if (unlikely(status & RxRES)) {
> +			if (status & (RxRWT | RxRUNT))
> +				dev->stats.rx_length_errors++;
> +			if (status & RxCRC)
> +				dev->stats.rx_crc_errors++;
> +			return true;
> +		}
> +		break;
>  	}
>  	return false;
>  }
>  
> -static void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
> +static void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
> +				      struct RxDesc *desc,
>  				      dma_addr_t mapping)
>  {
> -	desc->addr = cpu_to_le64(mapping);
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		desc->rss_addr = cpu_to_le64(mapping);
> +		break;
> +	default:
> +		desc->addr = cpu_to_le64(mapping);
> +		break;
> +	}
>  }
>  
>  static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
> @@ -4967,7 +5240,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		dma_addr_t addr;
>  		u32 status;
>  
> -		status = le32_to_cpu(READ_ONCE(desc->opts1));
> +		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>  
>  		if (status & DescOwn) {
>  			if (!tp->recheck_desc_ownbit)
> @@ -4983,7 +5256,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  			 */
>  			tp->recheck_desc_ownbit = false;
>  			RTL_R8(tp, LED_CTRL);
> -			status = le32_to_cpu(READ_ONCE(desc->opts1));
> +			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>  			if (status & DescOwn)
>  				break;
>  		}
> @@ -5034,11 +5307,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		skb->tail += pkt_size;
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
> -
> -		rtl8169_rx_csum(skb, desc);
> +		if (tp->num_rx_rings > 1)
> +			rtl8169_rx_hash(tp, desc, skb);
> +		rtl8169_rx_csum(tp, skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
> -		rtl8169_rx_vlan_tag(desc, skb);
> +		rtl8169_rx_vlan_tag(tp, desc, skb);
>  
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
> @@ -5047,8 +5321,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> -		rtl8169_set_desc_dma_addr(desc, ring->rx_desc_phy_addr[entry]);
> -		rtl8169_mark_to_asic(desc);
> +		rtl8169_set_desc_dma_addr(tp, desc, ring->rx_desc_phy_addr[entry]);
> +		rtl8169_mark_to_asic(tp, desc);
>  	}
>  
>  	return count;
> @@ -5604,6 +5878,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int get_max_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MAX_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static int get_min_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MIN_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static void rtl8169_set_rx_ring_num(struct rtl8169_private *tp)
> +{
> +	if (tp->irq_nvecs >= get_min_irq_nvecs(tp)) {
> +		unsigned int rss_queue_num = netif_get_num_default_rss_queues();
> +
> +		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
> +							    tp->hw_supp_num_rx_queues));
> +		if (tp->num_rx_rings >= 2)
> +			tp->init_rx_desc_type = RX_DESC_TYPE_RSS;
> +	}
> +}
> +
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5624,7 +5924,10 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp), get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
>  
>  	if (nvecs < 0)
>  		return nvecs;
> @@ -6071,6 +6374,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	tp->dash_type = rtl_get_dash_type(tp);
>  	tp->dash_enabled = rtl_dash_is_enabled(tp);
>  
> +	if (rtl_hw_support_rss(tp)) {
> +		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data), GFP_KERNEL);
> +		if (!tp->rss_data)
> +			return -ENOMEM;
> +	}
> +
>  	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
>  
>  	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&
> @@ -6096,6 +6405,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (!tp->rtl8169_napi)
>  		return -ENOMEM;
>  
> +	rtl8169_set_rx_ring_num(tp);
> +
> +	if (rtl_hw_support_rss(tp))
> +		rtl8169_init_rss(tp);
> +
>  	INIT_WORK(&tp->wk.work, rtl_task);
>  	disable_work(&tp->wk.work);
>  
> @@ -6110,6 +6424,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> +	if (rtl_hw_support_rss(tp) && tp->num_rx_rings > 1) {
> +		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->features |= NETIF_F_RXHASH;
> +	}
> +
>  	/*
>  	 * Pretend we are using VLANs; This bypasses a nasty bug where
>  	 * Interrupts stop flowing on high load on 8110SCd controllers.


