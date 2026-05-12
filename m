Return-Path: <netdev+bounces-287290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBJSIiaSA2ru7QEAu9opvQ
	(envelope-from <netdev+bounces-287290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:48:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 847355298B4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A1BB30EE9D2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C53C873B;
	Tue, 12 May 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRImhpcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B73BD629
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617827; cv=none; b=BUuPWo12yVSF8fQJ/hS/nm2IHtbHtsd7UkwbXV467vH9TebQjE5dP+cJDqY0K+m8/oJlkhtuwxlMZBd6mepVV0M2KLtzYlmQ7DTzKuiuL3YS8ALn8tMj3CrRiYF0iyu7WS/Ede745qEF7WIXYB5HFynqo1AQsP8B8gRNT3Kz/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617827; c=relaxed/simple;
	bh=sFKP/vH9OwjNcNxzRbdEKH2SGC/oV00Ek1WWosU56KI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CuLSWBUxQHf6CT/4Le9/Rv4kVD/KGN80jfHPZ62zDDpWQanHDLJssCl8pz46fwT5Me0S1qlDkEH3wpu6L/Dfx/8cVafuVpLoE9Q4PRVHDNQehl19qleh6gHC2zD0i0u5CCfiEWXrArBFlMyRwngW45jsayLRUZTpEgcwhePwMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRImhpcJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso64843955e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617823; x=1779222623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K8G8L1tB0Zl4rvUJjGyZf65xYvyfiwx7ls4uE7jhV4U=;
        b=SRImhpcJxnk/MPNMe9SzZrX8YX/nasO9KkoxTN7mdjSnycCYI+LubDBBVFA/bMUWYU
         dMj3jWAJ5hbBEFQ81sJlBfgt0KOofPchsU//OGxMpuOqQiud1Du8CoyPvvhA5r5OfQnU
         +2RmBAdDzafHnT0r2gHo33gt2ZF9phWTyfLUJjJadmM6FWBvW0tf5JvEBh40GhhIjns3
         HukirRK7TvHtKKuDT0vou5lipHm2RX1ZjCGQpvE7Icc8iMRLbA08bXvc8dkBM7082ekX
         yZHLFnY5RO4MOtsj7MN3cOGCwA/GI7U0mG/qyXPs7AB/CUJTyV3A9M0dVqpBVd/hJwY+
         qt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617823; x=1779222623;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8G8L1tB0Zl4rvUJjGyZf65xYvyfiwx7ls4uE7jhV4U=;
        b=I1dit8/vANW5J+Bg1ty/8gB0na9Dd6TVp+S71qTm2lrK+PvANj0xCyIL9s0ReAW4qz
         9/J4E0pQoumTLqb/JXLck/mOHVKroZR1ZAn2vWSsOaopBR3br3xbE6QOx0Fc8lohJ2fd
         0aSvEj2+4PRLjGWIh7/h9+RhN/VJPw9JipWaDhsm7mIW/yoX0szp1zdLQYvzsVWJ1IFP
         BBk30q4MG91EU91xshKfU9zS+0XkLlLgSu/a9AgvuabNFNd3m/igV1YrHBjV+GGD1wyO
         g5GEkU6iuJrkZk4SJ5RPD7Wh9WQVDXtocT5coDtydAmGoiEnzo7PuEjx3G66OPU7JL6B
         GAEA==
X-Gm-Message-State: AOJu0YxXV5i12njCMYkzM6zj1D+jlCFAMMIo6+Uz3R+lvgJcxorG455l
	RYlOhqk5oNthEKkxEtsYk5OHs9bcmc8a09N2OvDhDkdFynRFvVHfeuRjkiHwfQ==
X-Gm-Gg: Acq92OFOy2/sAbi2yRvRRoA7gMaSvT7nzKqZ2pMLtsJ0TZlH0HOA9TGa1Xhz8lYdr4S
	MFGRTsJtTlr7A+WOAvh8Gci/I58TEoNy9k/NYDAjfRfVhk4Bmi/vyIpT8Rmel938Ma6OOY/FpJv
	28v5ScdaBzWMZT1jMDajJYwo/Gfw+YJ0E0qHIFjmQm53dnQ712yyArH4En9Mlxgj1ERkDpM6l7D
	x/v5gyWRl460N/eQVH4DKc+DEjlnG+jcKFW313ITqEPyfHdqCsoARZf1T8/tnAuUMP2hwX9W5n2
	2jYvce8dRCPCN+h+RvKAcCWAxyc6710xrWJAHcspCvg0pGvQE7xRKOwHltT4INN/gL/khMw6CbY
	xFbnvzKOJZZx1kGJ/0hOCLEWyQlaW3VBIvbhh+K8qxkmiHtgLc3r25kGLfX19Ur9CA3KO4oV260
	EwdI64N0ug1j1UDWwNpNMECSYaasdPIpzeH5S3SwxceDaaHx2eJu9sdSTmJgEBu9zBiueA/yhCB
	mprumVBhH87XT3Sl2VKJvinJRKYyUa1/BuCNOntOgSAUuKhpD/AgRO0AuYONTU7NA==
X-Received: by 2002:a05:600c:1d9a:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48fc9a4a248mr5020115e9.26.1778617822926;
        Tue, 12 May 2026 13:30:22 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3200:655a:16b8:d272:9436? (p200300ea8f473200655a16b8d2729436.dip0.t-ipconnect.de. [2003:ea:8f47:3200:655a:16b8:d272:9436])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f42a4c5sm25480355e9.19.2026.05.12.13.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:30:22 -0700 (PDT)
Message-ID: <d1435549-cbc0-4baa-a5b0-21fbb6c6d1db@gmail.com>
Date: Tue, 12 May 2026 22:30:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v2 1/7] r8169: add support for multi irqs
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
 <20260508121802.2010-2-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260508121802.2010-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 847355298B4
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
	TAGGED_FROM(0.00)[bounces-287290-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 08.05.2026 14:17, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RSS uses multi rx queues to receive packets, and each rx queue needs one
> irq and napi. So this patch adds support for multi irqs and napi here.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove some unused definitions, such as index, name in rtl8169_irq
>  - remove array imr and isr
>  - remove min_irq_nvecs and max_irq_nvecs, replaced with help function
>    get_min_irq_nvecs and get_max_irq_nvecs
>  - alloc irq by flags, instead of PCI_IRQ_ALL_TYPES
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 161 +++++++++++++++++++---
>  1 file changed, 144 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..f02c4aa66b9d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -77,6 +77,9 @@
>  #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_MSIX_VEC	32
> +#define RTL_ISR_VER_DEFAULT	1
> +#define RTL_ISR_VER_8127	6

You shouldn't use these Realtek-internal version numbers in the
mainline driver. Use proper enums instead, maybe named after the
chip version which introduced a certain MSIX vector layout.

>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -435,6 +438,8 @@ enum rtl8125_registers {
>  #define INT_CFG0_CLKREQEN		BIT(3)
>  	IntrMask_8125		= 0x38,
>  	IntrStatus_8125		= 0x3c,
> +	INTR_VEC_MAP_MASK	= 0x800,
> +	INTR_VEC_MAP_STATUS	= 0x802,
>  	INT_CFG1_8125		= 0x7a,
>  	LEDSEL2			= 0x84,
>  	LEDSEL1			= 0x86,
> @@ -728,6 +733,15 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_napi {
> +	struct napi_struct napi;
> +	void *priv;

Is this priv mamber actually needed? You use it to retrieve the
struct rtl8169_private. napi_struct includes a pointer to the
net_device, from which you can derive struct rtl8169_private.

> +};
> +
> +struct rtl8169_irq {
> +	irq_handler_t	handler;

Not clear what you need this for, as the handler is fixed to
rtl8169_interrupt().

> +	unsigned int	vector;
> +};
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -745,9 +759,17 @@ struct rtl8169_private {
>  	dma_addr_t RxPhyAddr;
>  	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
> +	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
> +	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];

In the reply to a review comment you stated that you want to allocate
these arrays dynamically, based on chip capabilities.


> +	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	u16 hw_supp_num_rx_queues;
> +	u8 hw_supp_isr_ver;
> +	u8 hw_curr_isr_ver;

As stated in a previous comment:
This should be proper enums instead.

> +	u8 irq_nvecs;
> +	bool recheck_desc_ownbit;
>  	int irq;
>  	struct clk *clk;
>  
> @@ -763,6 +785,8 @@ struct rtl8169_private {
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
>  	bool sfp_mode:1;
> +	bool rss_support:1;
> +	bool rss_enable:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -2680,6 +2704,21 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
> +{
> +	tp->num_rx_rings = 1;
> +
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_80:
> +		tp->hw_supp_isr_ver = RTL_ISR_VER_8127;
> +		break;
> +	default:
> +		tp->hw_supp_isr_ver = RTL_ISR_VER_DEFAULT;
> +		break;
> +	}
> +	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
> +}
> +
>  static void rtl_request_firmware(struct rtl8169_private *tp)
>  {
>  	struct rtl_fw *rtl_fw;
> @@ -4266,9 +4305,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
>  	netdev_reset_queue(tp->dev);
>  }
>  
> +static void rtl8169_napi_disable(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		napi_disable(&tp->r8169napi[i].napi);
> +}
> +
> +static void rtl8169_napi_enable(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		napi_enable(&tp->r8169napi[i].napi);
> +}
> +
>  static void rtl8169_cleanup(struct rtl8169_private *tp)
>  {
> -	napi_disable(&tp->napi);
> +	rtl8169_napi_disable(tp);
>  
>  	/* Give a racing hard_start_xmit a few cycles to complete. */
>  	synchronize_net();
> @@ -4314,7 +4365,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
>  	for (i = 0; i < NUM_RX_DESC; i++)
>  		rtl8169_mark_to_asic(tp->RxDescArray + i);
>  
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	rtl_hw_start(tp);
>  }
>  
> @@ -4820,7 +4871,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> +		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
> @@ -4844,7 +4895,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->napi, skb);
> +		napi_gro_receive(&tp->r8169napi[0].napi, skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> @@ -4856,7 +4907,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  
>  static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
> -	struct rtl8169_private *tp = dev_instance;
> +	struct rtl8169_napi *napi = dev_instance;
> +	struct rtl8169_private *tp = napi->priv;
>  	u32 status = rtl_get_events(tp);
>  
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
> @@ -4873,13 +4925,46 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		phy_mac_interrupt(tp->phydev);
>  
>  	rtl_irq_disable(tp);
> -	napi_schedule(&tp->napi);
> +	napi_schedule(&napi->napi);
>  out:
>  	rtl_ack_events(tp, status);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static void rtl8169_free_irq(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		struct rtl8169_napi *napi = &tp->r8169napi[i];
> +
> +		pci_free_irq(tp->pci_dev, i, napi);
> +	}
> +}
> +
> +static int rtl8169_request_irq(struct rtl8169_private *tp)
> +{
> +	struct net_device *dev = tp->dev;
> +	struct rtl8169_napi *napi;
> +	struct rtl8169_irq *irq;
> +	int rc = 0;
> +
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		irq = &tp->irq_tbl[i];
> +		napi = &tp->r8169napi[i];
> +		irq->handler = rtl8169_interrupt;
> +		rc = pci_request_irq(tp->pci_dev, i, irq->handler,
> +				     NULL, napi, "%s-%d", dev->name, i);
> +		if (rc)
> +			break;
> +
> +		irq->vector = pci_irq_vector(tp->pci_dev, i);
> +	}
> +
> +	if (rc)
> +		rtl8169_free_irq(tp);
> +	return rc;
> +}
> +
>  static void rtl_task(struct work_struct *work)
>  {
>  	struct rtl8169_private *tp =
> @@ -4914,9 +4999,10 @@ static void rtl_task(struct work_struct *work)
>  
>  static int rtl8169_poll(struct napi_struct *napi, int budget)
>  {
> -	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
>  	struct net_device *dev = tp->dev;
> -	int work_done;
> +	int work_done = 0;
>  
>  	rtl_tx(dev, tp, budget);
>  
> @@ -5035,7 +5121,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	phy_init_hw(tp->phydev);
>  	phy_resume(tp->phydev);
>  	rtl8169_init_phy(tp);
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
> @@ -5053,7 +5139,7 @@ static int rtl8169_close(struct net_device *dev)
>  	rtl8169_down(tp);
>  	rtl8169_rx_clear(tp);
>  
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  
>  	phy_disconnect(tp->phydev);
>  
> @@ -5082,7 +5168,6 @@ static int rtl_open(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  	struct pci_dev *pdev = tp->pci_dev;
> -	unsigned long irqflags;
>  	int retval = -ENOMEM;
>  
>  	pm_runtime_get_sync(&pdev->dev);
> @@ -5107,8 +5192,7 @@ static int rtl_open(struct net_device *dev)
>  
>  	rtl_request_firmware(tp);
>  
> -	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
> -	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
> +	retval = rtl8169_request_irq(tp);
>  	if (retval < 0)
>  		goto err_release_fw_2;
>  
> @@ -5125,7 +5209,7 @@ static int rtl_open(struct net_device *dev)
>  	return retval;
>  
>  err_free_irq:
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  err_release_fw_2:
>  	rtl_release_firmware(tp);
>  	rtl8169_rx_clear(tp);
> @@ -5328,7 +5412,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
> +	struct pci_dev *pdev = tp->pci_dev;
>  	unsigned int flags;
> +	int nvecs;
>  
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
> @@ -5344,7 +5430,15 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +
> +	if (nvecs < 0)
> +		return nvecs;
> +
> +	tp->irq = pci_irq_vector(pdev, 0);
> +	tp->irq_nvecs = nvecs;
> +
> +	return 0;
>  }
>  
>  static void rtl_read_mac_address(struct rtl8169_private *tp,
> @@ -5539,6 +5633,17 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int rtl8169_set_real_num_queue(struct rtl8169_private *tp)
> +{
> +	int retval;
> +
> +	retval = netif_set_real_num_tx_queues(tp->dev, 1);
> +	if (retval < 0)
> +		return retval;
> +
> +	return netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
> +}
> +
>  static int rtl_jumbo_max(struct rtl8169_private *tp)
>  {
>  	/* Non-GBit versions don't support jumbo frames */
> @@ -5599,6 +5704,18 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		struct rtl8169_napi *r8169napi = &tp->r8169napi[i];
> +		int (*poll)(struct napi_struct *napi, int budget);
> +
> +		poll = rtl8169_poll;

Unclear why you have this poll variable.

> +		netif_napi_add(tp->dev, &r8169napi->napi, poll);
> +		r8169napi->priv = tp;
> +	}
> +}
> +
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_chip_info *chip;
> @@ -5703,11 +5820,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	rtl_hw_reset(tp);
>  
> +	rtl_software_parameter_initialize(tp);
> +
>  	rc = rtl_alloc_irq(tp);
>  	if (rc < 0)
>  		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
>  
> -	tp->irq = pci_irq_vector(pdev, 0);
>  
>  	INIT_WORK(&tp->wk.work, rtl_task);
>  	disable_work(&tp->wk.work);
> @@ -5716,7 +5834,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev->ethtool_ops = &rtl8169_ethtool_ops;
>  
> -	netif_napi_add(dev, &tp->napi, rtl8169_poll);
> +	if (!tp->rss_support) {
> +		netif_napi_add(dev, &tp->r8169napi[0].napi, rtl8169_poll);
> +		tp->r8169napi[0].priv = tp;
> +	} else {
> +		r8169_init_napi(tp);
> +	}
>  
>  	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
>  			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> @@ -5778,6 +5901,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (jumbo_max)
>  		dev->max_mtu = jumbo_max;
>  
> +	rc = rtl8169_set_real_num_queue(tp);
> +	if (rc < 0)
> +		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
> +
>  	rtl_set_irq_mask(tp);
>  
>  	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),


