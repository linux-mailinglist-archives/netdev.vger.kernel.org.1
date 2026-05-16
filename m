Return-Path: <netdev+bounces-288671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P7XLOrqCGpD/QMAu9opvQ
	(envelope-from <netdev+bounces-288671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:08:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0D55E0D7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14010301C93D
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1538AC97;
	Sat, 16 May 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu5Ffag0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE2388E49
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969252; cv=none; b=t8/b1D6e8bav0dld3dwOs5Lm1LUFEVhYibWQHnAJZ/KZiLnQwyLaTJiFL7+7Df94Znbh2FKAUu1NliRn4zPu3DjuwIAB5Ch0GPY+VKC9gK7b3J0gOeG3ZZ/8a4nZSBsWWqXA9/F5wOCRRNeN/y3YlJfjuueHGOF6ZZA+VxpdySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969252; c=relaxed/simple;
	bh=v9Ua/eB7YS5sZG/kLlxsZ0E7rBPMtplVJl2vy5YQtLo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lTfh8GrS6phZtbC00h+h1+aSdMVIRd2uRkKYUY0mPD5BqWnT+2ubGVDMfhagJFzPxL5qV5hTg5MW8wHv8D0uZbLReJaNDV1iweaLrtt2KXuM7QYd3nKkYCi+cBIkfV1J/VQGUtwnI1Xz8f6+uolLAMdrAbwnPvPoeege7biYORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu5Ffag0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d146705b4so10318525e9.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969248; x=1779574048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHnvIUG29fi8VLJ/4/HdgIAtSkM2QQEgFmWJrhR1ltc=;
        b=Qu5Ffag0/0vPDjVmqKYoqu50UrnLX3NnginAzKxZZbvuUlY+emM+CI9JHhEcEzkJYX
         VxUGkaF2xFvBoJZIlUjCnmMNf7C4xgW0PtCdupL7ZB8jVB3ttZP/sIZHUoYsZYounw2n
         WRmkIiTc3gzhojNQRFOhvgeYVa9CaIVFWhv7PdZo3GZEmCIZkHEyDRoFUzwSIvy9pnWX
         YzlbgrFGofUxBlcfGNWqLS/ZgTuSe6NK0Nm1MMzZMU9OrierdLJpNzaXe60rOCp/s4lg
         Ib8zz9351PMmJebBLZSLApwe2p1WS+JuecpqHNYcAMNilBofpAvPPgt+JCU6hctb+3az
         EgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969248; x=1779574048;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHnvIUG29fi8VLJ/4/HdgIAtSkM2QQEgFmWJrhR1ltc=;
        b=NMUQg3GdrimJPSf+/AzOId7TEm2ZqV4rWghOEwBbh+67qIspC2FstMO0wgoa0F1iVh
         DNwZOd4k7mSNpeG1GXuiuterGmzekGoG4TkdOxYNOcIlr6O9cmE/dJvY11YiB76YfUoQ
         oKqns50oqq/NPcHlSHwFXHuABy6itcvCCsdduaZDiDDH2gfZVVXSDC3wqgBqp+odp5Vl
         OTYaN4PJX1PcIlET5Tahqp3cfET1jdZRatisZB7djOcgUwXVyankHC2vNdm8mK6ud51B
         4U28JoVCo5jZraHkMX/XqDhRHONSXfxHzW0Vwo2if7IbohfslkQPpPXZSLnSZg5y6fP6
         qBvg==
X-Gm-Message-State: AOJu0Yy/HNF9Pk/BfohXu+WihzRN/7P4lpDM5Df8ZPgsGbsiMUlDPTGz
	/kFSk/8Qm3CtZsGWhx3pfQ9n2MDWx0oOALD4tlkMaWAtJh17hooLwCgh
X-Gm-Gg: Acq92OFu2G6SFsVh+YYkg0xBi+uE8U8ZxqSjnpcDNdabzCW+uoAppefntyKRfRC4iA9
	8Z+ra8XAi8mnIcEm+REO/Hol26ElIglSZwcy2ZCl/DXSVzONYY7q5EYqCiPpiVv/gwcm3JSV5dQ
	T+/tCMN7OalUKTuhTPmIVw4nU4LkteXkS6kfd6PMj4d2tTRPf5yu5h/m2VYEXIyJY7TPS3OLb6A
	oMqaOsmAN++zZQnK0XJohyiLjjEDai5iklvzTrVbqu3t2oyhrsIIth+fvTEZ/mB0+RZUC/9Hshe
	IhtTVp6xZom+rVqHvvS/MRF/oXUnxzjlM0B0jeigPBEb8SOBzNiaJrjSP3F4vovydnKnqO/Hmtu
	lMVWjp5FrDge8stqyrItMQNsYElymbOeg99n+kE+dVvGR870e34BDbMqUkeCyZp15O0ZCzNx53p
	H3VXu+kvgB4daWoC+bvkQxOxetL/pjKy3wYx7JM2npxJTsIHBCHQqqU6xplwbJ9bTtBhF1FdChP
	nlj1wqIMYH+tK6Tqdc5sPRm7VweDv2uvDdswHsbdZBc5FagINgDQuJKk9VEN3A=
X-Received: by 2002:a05:600c:8184:b0:48f:d1b8:9aa5 with SMTP id 5b1f17b1804b1-48fe60ecd7dmr126994885e9.8.1778969248282;
        Sat, 16 May 2026 15:07:28 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:8500:bde1:c576:18ad:a53? (p200300ea8f2c8500bde1c57618ad0a53.dip0.t-ipconnect.de. [2003:ea:8f2c:8500:bde1:c576:18ad:a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm144690005e9.12.2026.05.16.15.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 15:07:27 -0700 (PDT)
Message-ID: <a1a9fbcb-6a2c-43f9-8947-cf47e573e6aa@gmail.com>
Date: Sun, 17 May 2026 00:07:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v3 5/7] r8169: add support and enable rss
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
 <20260513115543.1730-6-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260513115543.1730-6-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2EF0D55E0D7
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
	TAGGED_FROM(0.00)[bounces-288671-lists,netdev=lfdr.de];
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
> This patch adds support and enable rss for RTL8127.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - some changes moved from Patch 2/7
> Changes in v3:
>  - add struct rtl8169_rss_data. Allocate it dynamically when needed.
>  - define rss_key as an u32 array
>  - replace some magic bit numbers in rtl8169_set_rss_hash_opt() and
>    rtl8125_set_rx_q_num()
>  - use union to combine different rx descriptor, refactor struct RxDesc
>  - remove dead code from rtl8169_double_check_rss_support()
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 405 ++++++++++++++++++++--
>  1 file changed, 371 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b9c505e4bc0a..b90375cef724 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -82,6 +82,19 @@
>  #define R8169_MAX_MSIX_VEC	32
>  #define R8127_MAX_RX_QUEUES	8
>  #define R8169_DEFAULT_RX_QUEUES	1
> +#define R8127_MAX_IRQ		32
> +#define R8127_MIN_IRQ		30
> +#define R8169_IRQ_DEFAULT	1

These name are somewhat misleading. Would something like
R8127_MAX_NUM_IRQVEC better describe the usage?

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
> @@ -592,6 +605,25 @@ enum rtl_register_content {
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
>  enum rtl_isr_version {
> @@ -654,6 +686,11 @@ enum rtl_rx_desc_bit {
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
> @@ -675,9 +712,27 @@ struct TxDesc {
>  };
>  
>  struct RxDesc {
> -	__le32 opts1;
> -	__le32 opts2;
> -	__le64 addr;
> +	union {
> +		/* RX_DESC_RING_TYPE_DEFAULT */
> +		struct {
> +			__le32 opts1;
> +			__le32 opts2;
> +			__le64 addr;
> +		};
> +
> +		/* RX_DESC_RING_TYPE_RSS */
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
> @@ -764,6 +819,13 @@ struct rtl8169_rx_ring {
>  	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
>  };
>  
> +struct rtl8169_rss_data {
> +	u32 rss_flags;
> +	u32 rss_key[RTL_RSS_KEY_SIZE / sizeof(u32)];
> +	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
> +	u8 hw_supp_indir_tbl_entries;

Like in other places: Why not use unsigned int here?

> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -783,9 +845,11 @@ struct rtl8169_private {
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
>  	u16 hw_supp_num_rx_queues;
> +	struct rtl8169_rss_data *rss_data;
>  	enum rtl_isr_version hw_supp_isr_ver;
>  	enum rtl_isr_version hw_curr_isr_ver;
>  	u8 irq_nvecs;
> +	u8 init_rx_desc_type;

Type should be the respective enum, not u8.

>  	bool recheck_desc_ownbit;
>  	unsigned int features;
>  	int irq;
> @@ -1620,6 +1684,13 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static bool rtl_check_rss_support(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return true;

Typically an empty line is inserted before the return statement.

> +	return false;
> +}
> +
>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
> @@ -1919,9 +1990,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
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
> +	case RX_DESC_RING_TYPE_RSS:
> +		opts2 = le32_to_cpu(desc->rss_opts2);
> +		break;
> +	default:
> +		opts2 = le32_to_cpu(desc->opts2);
> +		break;
> +	}
>  
>  	if (opts2 & RxVlanTag)
>  		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
> @@ -2750,6 +2832,14 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
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
> @@ -2757,6 +2847,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
>  		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
> +		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
>  		tp->hw_supp_isr_ver = RTL_ISR_VER_8127;
>  		break;
>  	default:
> @@ -2764,6 +2855,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  		tp->hw_supp_isr_ver = RTL_ISR_VER_DEFAULT;
>  		break;
>  	}
> +	tp->init_rx_desc_type = RX_DESC_RING_TYPE_DEFAULT;
>  	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
>  }
>  
> @@ -2889,6 +2981,72 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>  }
>  
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)
> +{
> +	u32 *rss_key = tp->rss_data->rss_key;
> +	const u16 rss_key_reg = RSS_KEY_REG;
> +	u32 num_entries = RTL_RSS_KEY_SIZE / sizeof(u32);
> +
> +	/* Write redirection table to HW */
> +	for (int i = 0; i < num_entries; i++)
> +		RTL_W32(tp, rss_key_reg + (i * 4), rss_key[i]);
> +}
> +
> +static void rtl8169_store_reta(struct rtl8169_private *tp)
> +{
> +	u16 indir_tbl_reg = RSS_INDIRECTION_TBL_REG;
> +	u32 i, reta_entries = tp->rss_data->hw_supp_indir_tbl_entries;
> +	u32 reta = 0;
> +	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
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
> +	u32 rss_flags = tp->rss_data->rss_flags;
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
> +	if (rss_flags & RTL_RSS_FLAG_HASH_UDP_IPV4)
> +		rss_ctrl |= RSS_CTRL_UDP_IPV4_SUPP;
> +
> +	if (rss_flags & RTL_RSS_FLAG_HASH_UDP_IPV6)
> +		rss_ctrl |= RSS_CTRL_UDP_IPV6_SUPP |
> +			    RSS_CTRL_UDP_IPV6_EXT_SUPP;
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
> @@ -3955,6 +4113,18 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>  	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>  }
>  
> +static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
> +{
> +	u16 q_ctrl;
> +	u16 rx_q_num;
> +
> +	rx_q_num = (u16)ilog2(tp->num_rx_rings);
> +	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
> +	q_ctrl &= ~RTL_RX_Q_NUM_MASK;
> +	q_ctrl |= FIELD_PREP(RTL_RX_Q_NUM_MASK, rx_q_num);
> +	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
> +}
> +
>  static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
>  {
>  	u8 tmp;
> @@ -3994,6 +4164,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	    tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
>  
> +	/* enable rx descriptor type v4 and set queue num for rss*/
> +	if (tp->rss_enable) {
> +		rtl8125_set_rx_q_num(tp);
> +		RTL_W8(tp, RTL_DESC_TYPE_CTRL,
> +		       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
> +	}
> +
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
>  	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> @@ -4230,6 +4407,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
>  	rtl_hw_aspm_clkreq_enable(tp, true);
>  	rtl_set_rx_max_size(tp);
>  	rtl_set_rx_tx_desc_registers(tp);
> +	if (rtl_is_8125(tp)) {
> +		if (tp->rss_enable)
> +			rtl_set_rss_config(tp);
> +		else
> +			RTL_W32(tp, RSS_CTRL_8125, 0x00);
> +	}
>  	rtl_lock_config_regs(tp);
>  
>  	rtl_jumbo_config(tp);
> @@ -4257,14 +4440,26 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
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
> +	case RX_DESC_RING_TYPE_RSS:
> +		eor = le32_to_cpu(desc->rss_opts1) & RingEnd;
> +		desc->rss_opts2 = 0;
> +		/* Force memory writes to complete before releasing descriptor */
> +		dma_wmb();
> +		WRITE_ONCE(desc->rss_opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +		break;
> +	default:
> +		eor = le32_to_cpu(desc->opts1) & RingEnd;
> +		desc->opts2 = 0;
> +		/* Force memory writes to complete before releasing descriptor */
> +		dma_wmb();
> +		WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +		break;
> +	}
>  }
>  
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
> @@ -4287,9 +4482,12 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  		return NULL;
>  	}
>  
> -	desc->addr = cpu_to_le64(mapping);
>  	ring->rx_desc_phy_addr[index] = mapping;
> -	rtl8169_mark_to_asic(desc);
> +	if (tp->init_rx_desc_type == RX_DESC_RING_TYPE_RSS)
> +		desc->rss_addr = cpu_to_le64(mapping);
> +	else
> +		desc->addr = cpu_to_le64(mapping);
> +	rtl8169_mark_to_asic(tp, desc);
>  
>  	return data;
>  }
> @@ -4310,6 +4508,18 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring
>  	}
>  }
>  
> +static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
> +		desc->rss_opts1 |= cpu_to_le32(RingEnd);
> +		break;
> +	default:
> +		desc->opts1 |= cpu_to_le32(RingEnd);
> +		break;
> +	}
> +}
> +
>  static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
>  {
>  	int i;
> @@ -4326,7 +4536,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
>  	}
>  
>  	/* mark as last descriptor in the ring */
> -	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
> +	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
>  
>  	return 0;
>  }
> @@ -4476,7 +4686,7 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
>  		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>  
>  		for (int j = 0; j < NUM_RX_DESC; j++)
> -			rtl8169_mark_to_asic(ring->rx_desc_array + j);
> +			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
>  	}
>  }
>  
> @@ -4937,35 +5147,104 @@ static inline int rtl8169_fragmented_frame(u32 status)
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
> +	case RX_DESC_RING_TYPE_RSS:
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
> +static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
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
> +	case RX_DESC_RING_TYPE_RSS:
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
> +	case RX_DESC_RING_TYPE_RSS:
> +		desc->rss_addr = cpu_to_le64(mapping);
> +		break;
> +	default:
> +		desc->addr = cpu_to_le64(mapping);
> +		break;
> +	}
>  }
>  
>  static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
> @@ -4982,7 +5261,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		dma_addr_t addr;
>  		u32 status;
>  
> -		status = le32_to_cpu(READ_ONCE(desc->opts1));
> +		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>  
>  		if (status & DescOwn) {
>  			if (!tp->recheck_desc_ownbit)
> @@ -4996,7 +5275,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  			 */
>  			tp->recheck_desc_ownbit = false;
>  			rtl8169_desc_quirk(tp);
> -			status = le32_to_cpu(READ_ONCE(desc->opts1));
> +			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>  			if (status & DescOwn)
>  				break;
>  		}
> @@ -5045,11 +5324,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		skb->tail += pkt_size;
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
> -
> -		rtl8169_rx_csum(skb, desc);
> +		if (tp->rss_enable)
> +			rtl8169_rx_hash(tp, desc, skb);
> +		rtl8169_rx_csum(tp, skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
> -		rtl8169_rx_vlan_tag(desc, skb);
> +		rtl8169_rx_vlan_tag(tp, desc, skb);
>  
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
> @@ -5058,8 +5338,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
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
> @@ -5607,6 +5887,43 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int get_max_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MAX_IRQ;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static int get_min_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MIN_IRQ;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static void rtl8169_double_check_rss_support(struct rtl8169_private *tp)

Needing such a function indicates that checks in other places are not sufficient.

> +{
> +	if (tp->hw_curr_isr_ver > RTL_ISR_VER_DEFAULT) {
> +		if (!(tp->features & RTL_VEC_MAP_ENABLE) || tp->irq_nvecs < get_min_irq_nvecs(tp))

Can this happen? If yes, then why not adjusting hw_curr_isr_ver in a first place?

> +			tp->hw_curr_isr_ver = RTL_ISR_VER_8127;

This looks wrong.

> +	}
> +
> +	if (tp->rss_support && tp->hw_curr_isr_ver > RTL_ISR_VER_DEFAULT) {
> +		u8 rss_queue_num = netif_get_num_default_rss_queues();
> +
> +		tp->num_rx_rings = min(rss_queue_num, tp->hw_supp_num_rx_queues);
> +		if (!(tp->num_rx_rings >= 2 && tp->irq_nvecs >= get_min_irq_nvecs(tp)))
> +			tp->num_rx_rings = 1;
> +	}
> +
> +	tp->rss_enable = 0;
> +
> +	if (tp->num_rx_rings >= 2) {
> +		tp->rss_enable = 1;

Function name just mentions a check, but you set/change values here.


> +		tp->init_rx_desc_type = RX_DESC_RING_TYPE_RSS;
> +	}
> +}
> +
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5627,7 +5944,10 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
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
> @@ -6069,6 +6389,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	tp->dash_type = rtl_get_dash_type(tp);
>  	tp->dash_enabled = rtl_dash_is_enabled(tp);
> +	tp->rss_support = rtl_check_rss_support(tp);
> +
> +	if (tp->rss_support) {
> +		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data), GFP_KERNEL);
> +		if (!tp->rss_data)
> +			return -ENOMEM;
> +	}
>  
>  	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
>  
> @@ -6095,6 +6422,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (!tp->rtl8169_napi)
>  		return -ENOMEM;
>  
> +	rtl8169_double_check_rss_support(tp);
> +
> +	if (tp->rss_support)
> +		rtl8169_init_rss(tp);
> +
>  	INIT_WORK(&tp->wk.work, rtl_task);
>  	disable_work(&tp->wk.work);
>  
> @@ -6112,6 +6444,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> +	if (tp->rss_support) {
> +		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->features |= NETIF_F_RXHASH;

Seems to me like you have different flags, all with the same meaning:
RSS active, MSI-X vec mapping used, hw_curr_isr_ver > DEFAULT, ..
Can't this be consolidated?

> +	}
> +
>  	/*
>  	 * Pretend we are using VLANs; This bypasses a nasty bug where
>  	 * Interrupts stop flowing on high load on 8110SCd controllers.


