Return-Path: <netdev+bounces-281130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 00o8ISFB7Wk0hQAAu9opvQ
	(envelope-from <netdev+bounces-281130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 00:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5EB4680AC
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 00:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2969A300E3C4
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D8738AC9E;
	Sat, 25 Apr 2026 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7jd198I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23157389118
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156381; cv=none; b=f7FBB5bAt/FTxXF37nJtirVyaNER6FxSsZ/FqZcOW3D25ABOLH7D/jaOsBy0GTTdYk+UvRY+XkEklkebGxOlD8/XgQ3JmIzj6qGdXEwLges/hy1g4rfT26vtb/pA/0TCvYDkmcJFnKx2Pal67hSKFsAwoFcf8PQgzsXoKl6Oilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156381; c=relaxed/simple;
	bh=m5SN8mCi/cYgJ/qYPLWh9WbMMatRz89JBtv/dD9HBYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLdjLcl4iaq47iWfiFyV0ou/Bndylr4XJnfnxeZXlCdJQ+sk/qDtNNGzRjiaaYnv39YhEYKM4QF5jUkwD85KjnJlDvoEXGK0I/jZmoc6fP0y1an2X+xgUBf0Zou0YVcoxukRfcF9fpKEsLva/Ld9NePCoU45AzHFJ8pVoVkF/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7jd198I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso72137015e9.2
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777156378; x=1777761178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDXuSJGcsOjV9tNsyeSrRiiV1r6rYhR37dEofe2GQMY=;
        b=j7jd198IMpieO18vLKDJhLEU4fWk3LUqhsEdWLjWZNarvY65i9qWpZmOS7zam/6zkh
         iO1BzD2UCTF1k0rNGBiki26MgSNbr+YfAzIu5gZmCG1KkLOO5CjKSelqVwzIiBStoCzm
         VRZOfFOEytK8pnpLpZ4DyAByncEwyONDW/NZPQzz9xFiXj6D3qNpDvrdNB9cTfnvm8Z7
         26xyl2vBJ0lAC3D/2sD8QRzGQ6cWsTQMi3vWZWfmscS/vO2d+5wArkJm+/AF36gaANrJ
         iA0ZmASdtT4RXPIQEaVVkCId24d+sLX29M++BCzkhrJKBMoN760DaS3mPclSMXcc2nI8
         Eoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156378; x=1777761178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDXuSJGcsOjV9tNsyeSrRiiV1r6rYhR37dEofe2GQMY=;
        b=AjQQR78UceyEUOynrtbHuD64CavGnQtXxo/v4arj/79gtB3NqyXTS1s7LLouA1near
         kWKh18hhvMCK0xDCgMehNDtJzkGHoP1bE5nPLVCioD4ZJ5k+tijenW2dkYKVMKdwbxWS
         KY5+aSnVdxN/1+ZEody3C6+FYXgm9Qzq7X37+5j5elbptZyeTnzgR23ZuRLBt653IwkU
         Py/kxUEPf/U4//ocA9sy3mzxTYTWUon4SVhVGo+lYH50sPQ1eVCjl6w07Diijxe/z8X4
         rZIBXnZP9JHubtdbgwSbfc40wfCXSauhFHsD0pFdkStS6qnLm4nvdYthL5QrciTMjE0G
         Vxzg==
X-Gm-Message-State: AOJu0Yz1vrfJaMaghgAKIgPTt20zLX3PRhFZFO4m7/bEBUOnMo9hQgBN
	ZQ4QGkxbfD/yCDzjZuTRSwGAXEooQKwdV5v9VsQQ0MMjKP1YuN1S/HM5
X-Gm-Gg: AeBDieu1dWYVTWpmu6TYglw9TDuApIkWeKO4UcudvzB1XjMJogV/zq/abfMmIx1WJZb
	RV8qeoTThggEtjDd1HjdYXn5yuQpm4DbylfYANHSZxsVAADmeAWYvYQDtxFg2SscLrKDJjXaDTl
	zrxhxNg2iEc27j5jOqIdyyw0YB4ZZHZ8xmRl7ctFls1tRhIB3E9sQa7bf+T195oRyx4quyC/Fl6
	m9rzGmBO8cyIC1SxMazQAeiTAeU8NJybgdVMEV+DS6kdDOiuEdKzsEgongzz6OtWctuLDnUtwxo
	ex6anQw1CCK+h6Ms4RGSB6AoRvWR+r+JgB2R9jexamgeXyxgEYCA6nY1yjlaDhePrzQouWknRPs
	x9ogMSF+RipG1XNxEDW0LuoxiwZav8hZarhXPlMCcgthxdxoA6xVMn2gcI0PMw3BS73eIu72hXQ
	EBkSkpwixNGBOc2k/OvymyVJmEU2sWZ8gySBBBqnX6AGZ/Wl8JyLTzdG1uajJhcQtkv/KvDfcPH
	cZPQaZhXo/edifP7f628vYGk0yIMlcIkozmj06I9UaRWsw3xs2dyDkwg7cPUa03AyDhPhiNG1SH
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id 5b1f17b1804b1-48a52d95604mr367935715e9.30.1777156378411;
        Sat, 25 Apr 2026 15:32:58 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f34:b800:6020:70f3:48c1:ca3e? (p200300ea8f34b800602070f348c1ca3e.dip0.t-ipconnect.de. [2003:ea:8f34:b800:6020:70f3:48c1:ca3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm700139325e9.4.2026.04.25.15.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 15:32:57 -0700 (PDT)
Message-ID: <546ff9b7-68b0-46ff-9db4-5fcde421f7df@gmail.com>
Date: Sun, 26 Apr 2026 00:32:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch net-next v1 1/9] r8169: add some register definitions
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260420021957.1756-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF5EB4680AC
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281130-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 20.04.2026 04:19, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support rss, this patch adds some macro definitions and register
> definitions.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 75 +++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..0fbec27e4a0d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -77,6 +77,23 @@
>  #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8169_MAX_TX_QUEUES	1
> +#define R8169_MAX_MSIX_VEC	32
> +#define R8127_MAX_TX_QUEUES	1

Then why multi tx queue support?

> +#define R8127_MAX_RX_QUEUES	8
> +#define R8127_MAX_IRQ		32
> +#define R8127_MIN_IRQ		30

This isn't self-explanatory. What do min and max refer to here?

> +#define RTL8127_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_OFFSET	16
> +#define RSS_MASK_BITS_OFFSET	8
> +#define RTL8127_MAX_INDIRECTION_TABLE_ENTRIES 128
> +#define RXS_8125B_RSS_UDP_V4 BIT(27)
> +#define RXS_8125_RSS_IPV4_V4 BIT(28)
> +#define RXS_8125_RSS_IPV6_V4 BIT(29)
> +#define RXS_8125_RSS_TCP_V4 BIT(30)
> +#define RTL8127_RXS_RSS_L3_TYPE_MASK_V4 (RXS_8125_RSS_IPV4_V4 | RXS_8125_RSS_IPV6_V4)
> +#define RTL8127_RXS_RSS_L4_TYPE_MASK_V4 (RXS_8125_RSS_TCP_V4 | RXS_8125B_RSS_UDP_V4)
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -435,6 +452,8 @@ enum rtl8125_registers {
>  #define INT_CFG0_CLKREQEN		BIT(3)
>  	IntrMask_8125		= 0x38,
>  	IntrStatus_8125		= 0x3c,
> +	IntrMask1_8125		= 0x800,
> +	IntrStatus1_8125	= 0x802,
>  	INT_CFG1_8125		= 0x7a,
>  	LEDSEL2			= 0x84,
>  	LEDSEL1			= 0x86,
> @@ -444,6 +463,36 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	TNPDS_Q1_LOW		= 0x2100,
> +	RDSAR_Q1_LOW		= 0x4000,
> +	IMR_V2_SET_REG_8125	= 0x0d0c,
> +	IMR_V2_CLEAR_REG_8125	= 0x0d00,
> +	IMR_V4_L2_CLEAR_REG_8125 = 0x0d10,
> +	ISR_V2_8125		= 0x0d04,
> +	ISR_V4_L2_8125		= 0x0d14,
> +};
> +
> +enum rtl8127_msix_id {
> +	MSIX_ID_V4_LINKCHG	= 29,
> +};
> +
> +enum rtl8127_rss_register_content {
> +	RSS_CTRL_TCP_IPV4_SUPP		= (1 << 0),
> +	RSS_CTRL_IPV4_SUPP		= (1 << 1),
> +	RSS_CTRL_TCP_IPV6_SUPP		= (1 << 2),
> +	RSS_CTRL_IPV6_SUPP		= (1 << 3),
> +	RSS_CTRL_IPV6_EXT_SUPP		= (1 << 4),
> +	RSS_CTRL_TCP_IPV6_EXT_SUPP	= (1 << 5),
> +	RSS_CTRL_UDP_IPV4_SUPP		= (1 << 11),
> +	RSS_CTRL_UDP_IPV6_SUPP		= (1 << 12),
> +	RSS_CTRL_UDP_IPV6_EXT_SUPP	= (1 << 13),
> +	RSS_INDIRECTION_TBL_8125_V2	= 0x4700,
> +	RSS_KEY_8125			= 0x4600,
> +};
> +
> +enum rtl8127_rss_flag {
> +	RTL_8125_RSS_FLAG_HASH_UDP_IPV4  = (1 << 0),
> +	RTL_8125_RSS_FLAG_HASH_UDP_IPV6  = (1 << 1),
>  };
>  
>  #define LEDSEL_MASK_8125	0x23f
> @@ -474,6 +523,10 @@ enum rtl_register_content {
>  	RxRUNT	= (1 << 20),
>  	RxCRC	= (1 << 19),
>  
> +	RxRES_RSS	= (1 << 22),
> +	RxRUNT_RSS	= (1 << 21),
> +	RxCRC_RSS	= (1 << 20),
> +
>  	/* ChipCmdBits */
>  	StopReq		= 0x80,
>  	CmdReset	= 0x10,
> @@ -576,6 +629,9 @@ enum rtl_register_content {
>  
>  	/* magic enable v2 */
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +	ISRIMR_V6_LINKCHG	= (1 << 29),
> +	ISRIMR_V6_TOK_Q0	= (1 << 8),
> +	ISRIMR_V6_ROK_Q0	= (1 << 0),
>  };
>  
>  enum rtl_desc_bit {
> @@ -633,6 +689,11 @@ enum rtl_rx_desc_bit {
>  #define RxProtoIP	(PID1 | PID0)
>  #define RxProtoMask	RxProtoIP
>  
> +	RxUDPT_v4	= (1 << 19),
> +	RxTCPT_v4	= (1 << 18),
> +	RxUDPF_v4	= (1 << 16), /* UDP/IP checksum failed */
> +	RxTCPF_v4	= (1 << 15), /* TCP/IP checksum failed */
> +
>  	IPFail		= (1 << 16), /* IP checksum failed */
>  	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
>  	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
> @@ -659,6 +720,11 @@ struct RxDesc {
>  	__le64 addr;
>  };
>  
> +enum features {
> +	RTL_FEATURE_MSI		= (1 << 1),
> +	RTL_FEATURE_MSIX	= (1 << 2),
> +};
> +
>  struct ring_info {
>  	struct sk_buff	*skb;
>  	u32		len;
> @@ -728,6 +794,13 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +enum rx_desc_ring_type {
> +	RX_DESC_RING_TYPE_UNKNOWN = 0,
> +	RX_DESC_RING_TYPE_DEAFULT,
> +	RX_DESC_RING_TYPE_RSS,
> +	RX_DESC_RING_TYPE_MAX
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -763,6 +836,8 @@ struct rtl8169_private {
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
>  	bool sfp_mode:1;
> +	bool rss_support:1;
> +	bool rss_enable:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;


