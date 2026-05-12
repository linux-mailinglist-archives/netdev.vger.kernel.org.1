Return-Path: <netdev+bounces-287293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC/0AFSSA2pm7gEAu9opvQ
	(envelope-from <netdev+bounces-287293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:49:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0085298E7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 193E430F76F8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91A3CB918;
	Tue, 12 May 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhk+KOm0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF23CB902
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617849; cv=none; b=aC8cmQt8zZePLKEkDnaa2EiR2GMhK1PV1NOeDJR4YB/BTL+0M8rCjU908+Zl846SHllZe3yPxmhOvvAuWitlBVKOws6MJTs8YEex+Xq2xMGxHEr7gJVeCguGjwwriG0A1twI2HsLOhjnFJyyVg3dCUtqeTYvFbYz+ptKJh+D5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617849; c=relaxed/simple;
	bh=AC0h8JV6MW+u+xLQnXoN4UwQBERMKf3J/koXwm8TzME=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IwVkx75cKn2stwAz3GLSqDC/D3O9keC45GNY/BTo/7QAllvxHKA3ZugGOYAcD6e4PkqZKPHuWlgxyq/PzxnR1rU0FSnv3dDGKrP9G8RUTZyB8U8xekxLLPEK2NylNt+f5dPmTkMrDG3D473R0mdsrlgiF4EUtRs3ujC5Jac09Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhk+KOm0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3558880f8f.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617845; x=1779222645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3eyQ3dHVufxIBcgd8OVaMAyUHMqt+nOKjDfuX1JHj0c=;
        b=Bhk+KOm0DawjWZZYEBvMD1lu1j8gQkXceMuIb4q7qZ0FOG9hN4i3l+DuXWdrWXAXaF
         5n0OupbaMSzmIP0SocInxnAJiNjQFR//mV4++sKdqxUftij+Ew9kIIOgNTSDFkfrjFXc
         uJCKU8MdyE5DWODbKBx3i+BXWgeWVoawet5wggRbcjV9KZABFLvQB0JSz02Tyz92eClB
         5fOuImtAaPe1LNGaMqHhRcrmAlSoCgtEKwwZP7hzdgSY9A5h2AENAGyUP+MnjiiEy+6p
         D+SfUEhL5D/2w3cVJLcd9fnGwffBsESLUtY92rZTom3EomcDq9h06eWCWiyq4+kuGKIh
         m/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617845; x=1779222645;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eyQ3dHVufxIBcgd8OVaMAyUHMqt+nOKjDfuX1JHj0c=;
        b=ZRrR6jSebm3PxTk+/I/rlmYTXjc+AQoZF+zAkAH7Wi8CmlQVh9foLAV8OFwuer/5Ul
         PvH5PZTLvluuUuUXRPc/C3xb1H/3S86TLl8cwrVH4YmXUNccmoKUfAKjh5rpbddS9+zX
         ADkmSeZVTf2T3cK/VLUMIzJ4JWkJZfNUz3g1FqCcn+Fz16gDDfaKn1hwz5Aod/vtJVc/
         4pLUvr+P2of9JNfDZxZ1G8u+fRC8toF7J1P1qSOFmf/VJ7F8BabCIIJV9yX5vI5XKeBl
         0YwFtCz2auDcwjiHTafrahO6uJSvCUKzQQ0E+GhHkQtA3/3ECeoxTq3u0glhJOCbJYY+
         zlvQ==
X-Gm-Message-State: AOJu0Yx8Hvc8gh7soNGX0Nrveu4NwibZBxKcZPsRor3hL+I8U+W8aHUV
	5uy3wt64t39rz0OWls+ba5ZCwRkqgSa+QvnzFgnKv+tV4MWBZn4NglXK
X-Gm-Gg: Acq92OEaOGf5GNkBfNP68nOY/ZJkoH7vhtP+w6W2N/aRR1kcAZ7S0l5yOJAfvJPyTEs
	39phXeNiEFUY3QoYIrhhEI1nogTypJXZRUDHVarBPfUIY8b65yUZqbB3K/8nnHAJkx6ugXH8mlM
	lMLIGagG12BoFefuruK0VxDH1TBKmoUo7o0FIX/QSmebrlXYyJaMLdzjBkq0umZLIdC4yQDZV7h
	IQWtLJCaffGUfnLYhx3Ngav8z75dm2nhVdICWzfQlggmg61uD5zO/eytwJhzDc7CeFM3B9BxVqU
	78ygPVrAV2z8Gs+My/Ls6dhsa15Rom3e5CvgSbZhJE6DVrh21V0mwkgDMIw9NvCXb9my+04NZRo
	qGWDi1n24zqflrp1rbhY7Lq24nMfV0LZ3M5ce1yHlRL9+PnrbpbGiBfa15x89uAkN7ZOdBYBxVb
	C9mQ5skofVWlLvG0IZyA9nYT3bvWB35oRjRBqm1rO/UNFEw8DrXgwzS/zhwZSYXxBA+HnZ82Wlk
	zA3Xcm3krx+aqcXZhxikENzI6PHjD3Dxr0O1x6rq0LJn3vzS4gg3P8kg1+tgtzdaQmDuRPGpAnC
X-Received: by 2002:a05:6000:2081:b0:454:86d:b4d2 with SMTP id ffacd0b85a97d-45c57536c87mr410133f8f.8.1778617844968;
        Tue, 12 May 2026 13:30:44 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3200:655a:16b8:d272:9436? (p200300ea8f473200655a16b8d2729436.dip0.t-ipconnect.de. [2003:ea:8f47:3200:655a:16b8:d272:9436])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm30698945f8f.4.2026.05.12.13.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:30:44 -0700 (PDT)
Message-ID: <172ee303-9dab-47bb-92a0-9e2c2243dfc2@gmail.com>
Date: Tue, 12 May 2026 22:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v2 5/7] r8169: add support and enable rss
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
 <20260508121802.2010-6-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260508121802.2010-6-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AE0085298E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287293-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 08.05.2026 14:17, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support and enable rss for RTL8127.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - some changes moved from Patch 2/7
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 420 ++++++++++++++++++++--
>  1 file changed, 395 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 0ff0671fc2ac..86cb97cb6074 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -83,6 +83,19 @@
>  #define R8169_DEFAULT_RX_QUEUES	1
>  #define RTL_ISR_VER_DEFAULT	1
>  #define RTL_ISR_VER_8127	6
> +#define R8127_MAX_IRQ		32
> +#define R8127_MIN_IRQ		30
> +#define R8169_IRQ_DEFAULT	1
> +#define RTL_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_OFFSET	16
> +#define RSS_MASK_BITS_OFFSET	8
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
> @@ -593,6 +606,22 @@ enum rtl_register_content {
>  #define	ISRIMR_LINKCHG	BIT(29)
>  #define	ISRIMR_TOK_Q0	BIT(8)
>  #define	ISRIMR_ROK_Q0	BIT(0)
> +#define RSS_KEY_REG			0x4600
> +#define RSS_INDIRECTION_TBL_REG		0x4700

As these register names don't include a chip version indicator:
Are they used on all chip versions supporting RSS?

To prepare for the use case, that we might want to add RSS
support for RTL8126 too.

> +#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
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
>  };
>  
>  enum rtl_desc_bit {
> @@ -650,6 +679,11 @@ enum rtl_rx_desc_bit {
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
> @@ -676,6 +710,21 @@ struct RxDesc {
>  	__le64 addr;
>  };
>  
> +struct rx_desc_rss {
> +	union {
> +		__le64 addr;
> +		struct {
> +			__le32 rss_info;
> +			__le32 rss_result;
> +		} rx_desc_rss_dword;
> +	};
> +
> +	struct {
> +		__le32 opts2;
> +		__le32 opts1;
> +	} rx_desc_opts;
> +};
> +
>  struct ring_info {
>  	struct sk_buff	*skb;
>  	u32		len;
> @@ -789,13 +838,18 @@ struct rtl8169_private {
>  	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
>  	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
>  	unsigned int num_rx_rings;
> +	u32 rss_flags;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	u8 rss_key[RTL_RSS_KEY_SIZE];
> +	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
> +	u8 hw_supp_indir_tbl_entries;

All the RSS-specific member may be allocated dynamically,
saving memory in chip versions not supporting RSS.

>  	u16 hw_supp_num_rx_queues;
>  	u8 hw_supp_isr_ver;
>  	u8 hw_curr_isr_ver;
>  	u8 irq_nvecs;
> +	u8 init_rx_desc_type;
>  	bool recheck_desc_ownbit;
>  	unsigned int features;
>  	int irq;
> @@ -1630,6 +1684,13 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static bool rtl_check_rss_support(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return true;
> +	return false;
> +}
> +
>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
> @@ -1929,9 +1990,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
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
> +		opts2 = le32_to_cpu(((struct rx_desc_rss *)desc)->rx_desc_opts.opts2);
> +		break;
> +	default:
> +		opts2 = le32_to_cpu(desc->opts2);
> +		break;
> +	}
>  
>  	if (opts2 & RxVlanTag)
>  		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
> @@ -2760,6 +2832,14 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl8169_init_rss(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->hw_supp_indir_tbl_entries; i++)
> +		tp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
> +
> +	netdev_rss_key_fill(tp->rss_key, RTL_RSS_KEY_SIZE);
> +}
> +
>  static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  {
>  	tp->num_rx_rings = 1;
> @@ -2767,6 +2847,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
>  		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
> +		tp->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
>  		tp->hw_supp_isr_ver = RTL_ISR_VER_8127;
>  		break;
>  	default:
> @@ -2774,6 +2855,7 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
>  		tp->hw_supp_isr_ver = RTL_ISR_VER_DEFAULT;
>  		break;
>  	}
> +	tp->init_rx_desc_type = RX_DESC_RING_TYPE_DEFAULT;
>  	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
>  }
>  
> @@ -2899,6 +2981,76 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>  }
>  
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)
> +{
> +	const u16 rss_key_reg = RSS_KEY_REG;
> +	u32 i, rss_key_size = sizeof(tp->rss_key);
> +	u32 *rss_key = (u32 *)tp->rss_key;

Why don't you define rss_key as an u32 array from the beginning?

> +
> +	/* Write redirection table to HW */
> +	for (i = 0; i < rss_key_size; i += 4)
> +		RTL_W32(tp, rss_key_reg + i, *rss_key++);
> +}
> +
> +static void rtl8169_store_reta(struct rtl8169_private *tp)
> +{
> +	u16 indir_tbl_reg = RSS_INDIRECTION_TBL_REG;
> +	u32 i, reta_entries = tp->hw_supp_indir_tbl_entries;
> +	u32 reta = 0;
> +	u8 *indir_tbl = tp->rss_indir_tbl;
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
> +	u32 rss_flags = tp->rss_flags;
> +	u32 hash_mask_len;
> +	u32 rss_ctrl;
> +
> +	rss_ctrl = ilog2(tp->num_rx_rings);
> +	rss_ctrl &= (BIT(0) | BIT(1) | BIT(2));

Constants for these magic bit numbers?

> +	rss_ctrl <<= RSS_CPU_NUM_OFFSET;
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
> +	hash_mask_len = ilog2(tp->hw_supp_indir_tbl_entries);
> +	hash_mask_len &= (BIT(0) | BIT(1) | BIT(2));
> +	rss_ctrl |= hash_mask_len << RSS_MASK_BITS_OFFSET;
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
> @@ -3965,6 +4117,20 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>  	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>  }
>  
> +static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
> +{
> +	u16 q_ctrl;
> +	u16 rx_q_num;
> +
> +	rx_q_num = (u16)ilog2(tp->num_rx_rings);
> +	rx_q_num &= (BIT(0) | BIT(1) | BIT(2));
> +	rx_q_num <<= 2;
> +	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
> +	q_ctrl &= ~(BIT(2) | BIT(3) | BIT(4));

Also here better use constants instead of magic bit numbers.

> +	q_ctrl |= rx_q_num;
> +	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
> +}
> +
>  static void rtl8125_hw_set_interrupt_type(struct rtl8169_private *tp)
>  {
>  	u8 tmp;
> @@ -4004,6 +4170,12 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	    tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
>  
> +	/* enable rx descriptor type v4 and set queue num for rss*/
> +	if (tp->rss_enable) {
> +		rtl8125_set_rx_q_num(tp);
> +		RTL_W8(tp, 0xd8, RTL_R8(tp, 0xd8) | 0x02);

Again a magic register write.

> +	}
> +
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
>  	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> @@ -4240,6 +4412,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
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
> @@ -4267,7 +4445,17 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>  	return 0;
>  }
>  
> -static void rtl8169_mark_to_asic(struct RxDesc *desc)
> +static void rtl8169_mark_to_asic_rss(struct rx_desc_rss *descrss)
> +{
> +	u32 eor = le32_to_cpu(descrss->rx_desc_opts.opts1) & RingEnd;
> +
> +	descrss->rx_desc_opts.opts2 = 0;
> +	/* Force memory writes to complete before releasing descriptor */
> +	dma_wmb();
> +	WRITE_ONCE(descrss->rx_desc_opts.opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +}
> +
> +static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
>  {
>  	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
>  
> @@ -4277,6 +4465,18 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
>  	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
>  }
>  
> +static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
> +		rtl8169_mark_to_asic_rss((struct rx_desc_rss *)desc);
> +		break;
> +	default:
> +		rtl8169_mark_to_asic_default(desc);
> +		break;
> +	}
> +}
> +
>  static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  					  struct rtl8169_rx_ring *ring, unsigned int index)
>  {
> @@ -4297,9 +4497,15 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  		return NULL;
>  	}
>  
> -	desc->addr = cpu_to_le64(mapping);
>  	ring->rx_desc_phy_addr[index] = mapping;
> -	rtl8169_mark_to_asic(desc);
> +	if (tp->init_rx_desc_type == RX_DESC_RING_TYPE_RSS) {
> +		struct rx_desc_rss *descrss = (struct rx_desc_rss *)(ring->rx_desc_array) + index;
> +
> +		descrss->addr = cpu_to_le64(mapping);
> +	} else {
> +		desc->addr = cpu_to_le64(mapping);
> +	}
> +	rtl8169_mark_to_asic(tp, desc);
>  
>  	return data;
>  }
> @@ -4320,6 +4526,28 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring
>  	}
>  }
>  
> +static void rtl8169_mark_as_last_descriptor_default(struct RxDesc *desc)
> +{
> +	desc->opts1 |= cpu_to_le32(RingEnd);
> +}
> +
> +static void rtl8169_mark_as_last_descriptor_rss(struct rx_desc_rss *descrss)
> +{
> +	descrss->rx_desc_opts.opts1 |= cpu_to_le32(RingEnd);
> +}
> +
> +static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
> +		rtl8169_mark_as_last_descriptor_rss((struct rx_desc_rss *)desc);
> +		break;
> +	default:
> +		rtl8169_mark_as_last_descriptor_default(desc);
> +		break;
> +	}
> +}
> +
>  static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
>  {
>  	int i;
> @@ -4336,7 +4564,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
>  	}
>  
>  	/* mark as last descriptor in the ring */
> -	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
> +	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
>  
>  	return 0;
>  }
> @@ -4487,7 +4715,7 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
>  		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>  
>  		for (int j = 0; j < NUM_RX_DESC; j++)
> -			rtl8169_mark_to_asic(ring->rx_desc_array + j);
> +			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
>  	}
>  }
>  
> @@ -4948,8 +5176,30 @@ static inline int rtl8169_fragmented_frame(u32 status)
>  	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>  }
>  
> -static inline void rtl8169_rx_csum(struct sk_buff *skb,
> -				   struct RxDesc *desc)
> +static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
> +				   struct rx_desc_rss *desc,
> +				   struct sk_buff *skb)
> +{
> +	u32 rss_header_info;
> +	u32 hash_val;
> +
> +	if (!(tp->dev->features & NETIF_F_RXHASH))
> +		return;
> +
> +	rss_header_info = le32_to_cpu(desc->rx_desc_rss_dword.rss_info);
> +
> +	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
> +		return;
> +
> +	hash_val = le32_to_cpu(desc->rx_desc_rss_dword.rss_result);
> +
> +	skb_set_hash(skb, hash_val,
> +		     (RXS_RSS_L4_TYPE_MASK & rss_header_info) ?
> +		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
> +}
> +
> +static inline void rtl8169_rx_csum_default(struct sk_buff *skb,
> +					   struct RxDesc *desc)
>  {
>  	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
>  
> @@ -4959,24 +5209,81 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb,
>  		skb_checksum_none_assert(skb);
>  }
>  
> +static inline void rtl8169_rx_csum_rss(struct sk_buff *skb,
> +				       struct rx_desc_rss *descrss)
> +{
> +	u32 opts1 = le32_to_cpu(descrss->rx_desc_opts.opts1);
> +
> +	if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
> +	    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	else
> +		skb_checksum_none_assert(skb);
> +}
> +
> +static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
> +				   struct sk_buff *skb,
> +				   struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
> +		rtl8169_rx_csum_rss(skb, (struct rx_desc_rss *)desc);
> +		break;
> +	default:
> +		rtl8169_rx_csum_default(skb, desc);
> +		break;
> +	}
> +}
> +
> +static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
> +		return READ_ONCE(((struct rx_desc_rss *)desc)->rx_desc_opts.opts1);

Such casts aren't nice.

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
> -static inline void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
> +static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
> +					     struct RxDesc *desc,
>  					     dma_addr_t mapping)
>  {
> -	desc->addr = cpu_to_le64(mapping);
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_RING_TYPE_RSS:
> +		((struct rx_desc_rss *)desc)->addr = cpu_to_le64(mapping);
> +		break;
> +	default:
> +		desc->addr = cpu_to_le64(mapping);
> +		break;
> +	}
>  }
>  
>  static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
> @@ -4993,7 +5300,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		dma_addr_t addr;
>  		u32 status;
>  
> -		status = le32_to_cpu(READ_ONCE(desc->opts1));
> +		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>  
>  		if (status & DescOwn) {
>  			if (!tp->recheck_desc_ownbit)
> @@ -5007,7 +5314,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  			 */
>  			tp->recheck_desc_ownbit = false;
>  			rtl8169_desc_quirk(tp);
> -			status = le32_to_cpu(READ_ONCE(desc->opts1));
> +			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>  			if (status & DescOwn)
>  				break;
>  		}
> @@ -5056,11 +5363,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		skb->tail += pkt_size;
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
> -
> -		rtl8169_rx_csum(skb, desc);
> +		if (tp->rss_enable)
> +			rtl8169_rx_hash(tp, (struct rx_desc_rss *)desc, skb);
> +		rtl8169_rx_csum(tp, skb, desc);
>  		skb->protocol = eth_type_trans(skb, dev);
>  
> -		rtl8169_rx_vlan_tag(desc, skb);
> +		rtl8169_rx_vlan_tag(tp, desc, skb);
>  
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
> @@ -5069,8 +5377,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
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
> @@ -5625,6 +5933,55 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
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
> +{
> +	if (tp->hw_curr_isr_ver > 1) {
> +		if (!(tp->features & RTL_VEC_MAP_ENABLE) || tp->irq_nvecs < get_min_irq_nvecs(tp))
> +			tp->hw_curr_isr_ver = 1;
> +	}
> +
> +	if (tp->rss_support && tp->hw_curr_isr_ver > 1) {
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
> +		tp->init_rx_desc_type = RX_DESC_RING_TYPE_RSS;
> +	} else if (tp->irq_nvecs > 1 && !tp->rss_support) {

Under which circumstances could this be true?

> +		pci_free_irq_vectors(tp->pci_dev);
> +		tp->irq_nvecs = pci_alloc_irq_vectors(tp->pci_dev, 1, 1, PCI_IRQ_ALL_TYPES);
> +
> +		if (tp->irq_nvecs > 0) {
> +			tp->irq = pci_irq_vector(tp->pci_dev, 0);
> +		} else {
> +			tp->irq = tp->pci_dev->irq;
> +			tp->irq_nvecs = 1;
> +		}
> +
> +		tp->features &= ~RTL_VEC_MAP_ENABLE;
> +	}
> +}
> +
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5645,7 +6002,10 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
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
> @@ -6090,6 +6450,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	tp->dash_type = rtl_get_dash_type(tp);
>  	tp->dash_enabled = rtl_dash_is_enabled(tp);
> +	tp->rss_support = rtl_check_rss_support(tp);
>  
>  	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
>  
> @@ -6111,6 +6472,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc < 0)
>  		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
>  
> +	rtl8169_double_check_rss_support(tp);
> +
> +	if (tp->rss_support)
> +		rtl8169_init_rss(tp);
>  
>  	INIT_WORK(&tp->wk.work, rtl_task);
>  	disable_work(&tp->wk.work);
> @@ -6132,6 +6497,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  
> +	if (tp->rss_support) {
> +		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->features |= NETIF_F_RXHASH;
> +	}
> +
>  	/*
>  	 * Pretend we are using VLANs; This bypasses a nasty bug where
>  	 * Interrupts stop flowing on high load on 8110SCd controllers.


