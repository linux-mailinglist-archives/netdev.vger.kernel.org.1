Return-Path: <netdev+bounces-288668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOF9K5zqCGpD/QMAu9opvQ
	(envelope-from <netdev+bounces-288668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098F55E0A2
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC2263012CF6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92FE38656D;
	Sat, 16 May 2026 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9UQHZ05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201337B03F
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969240; cv=none; b=R6tc+jldnm1Cti9kn9skgvN4qDvX9ciIIdjCDySwH/LGXHLAG0ezg1BXO0Z0tJk04AMj8V3axHA5FjO4OrCy6+hpm3fCbNl2qMtmBudqpmTmfI1VEqkY/vgJxOqdVIKKXkHUV515Wslu6PNKl3gNiOGGT4xkk1Zav008PQLEqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969240; c=relaxed/simple;
	bh=v5WMsobLP3+7NvnMSKh4MkZkRDlzzHlGVopThjLS3fg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GWtToyE2sXzFIGejPttVKJHa3Do/oNGBeHPRym5WWRMVr1sIRCoS/vIkWk/D+8/5fnjbcXVdjEibCacOo4wJG0r2/2sXKNBYVZ8vUvKISsZPSoY7VZQYPRlEsLv4h5Ut/m+3lThDqtWptp2wrP3J2KIwus7jUbMn46gOfJR9CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9UQHZ05; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e82c23840so6370185e9.3
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969237; x=1779574037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xlIBwqbdv6cuvPd/rpAHCKGTYDcTOu7bp7HgOAVWHN8=;
        b=H9UQHZ05IJOpx57kOK5J/EdwnsiJX1SjKxUxyX4CqAB1NCw1W6GHxjBak3lAUQvkul
         y8wO6lHn+lcbPLdcLpNMH63ktPwaThAHurWpMsZ98SUX17256JeuaWkjbZiYNTQUVRyF
         jFRV3XdddF7YGWq7+jGbSwUnJA7AJXAl9wn0RA0I7uqjBqWIYTKG95Wc6NQKuunB3qCN
         +/q/GMHDuQikQ/YovsojDQa2kGWhgfCohqEFT4JW+h9NGwkzY0CvOLwSKFqGbUCCy0kJ
         s7tmyl2HzmcuvZmXy+KVpwFWvOBdXSGWzsbEWWi8ttAIzNRMBWeZPFZPbrOFxlfwDj5X
         nDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969237; x=1779574037;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlIBwqbdv6cuvPd/rpAHCKGTYDcTOu7bp7HgOAVWHN8=;
        b=Zp2+GyQtAGYqr8UIrxv8JgaGpikLT9/OruuIlZmr4NAmU/b+XAyu9oL3vC1B6p7Mr7
         UmlWbBwWkCH0sqkMdqRh2BZ+I/l5YC2lzpLW5IjxENSQuAJn/9k8uamCR4EYedakvl8S
         wK7RVTrxFzm9cQhRK1mo3W1+cSyGCzT63TjZmgXd02BQd+PJc3l568Ltaq0Mo8Mr3ypD
         9yRKWYe8RL2DtH8KuAityAEfJYrr7BzvpjuHc9+l3dutbZjAwc9vOabGN5llzT/B1fkN
         MzNB1hW1y2ARB34mJ6xH7oVA3JJ6wE3H3bwIN9HCZwWcGmxC0gkX87KfbkkEnum0Qc8b
         s66Q==
X-Gm-Message-State: AOJu0YwV3neEzP+iykQGcFpK4+lva1vp/+BOffd9HcBikWPM8na/vRDy
	A0IRfA0ZWU4N4HyyUlP8Myd3QnL/NUqy5nXHRhhfs95D1NzwtVr2R8bV
X-Gm-Gg: Acq92OEoKzhqr3KDHmLVDkTds7gxJ8x/yOmK1J8VAZvwF8gyFRjDIupmWhgNcpoyiu4
	WXu7PoQDR2OFjDpk4+A3Gk/SWPQuWuVkvkp+byXQnQm1ccCfnJnhKFWbv0k+MTOMAFS4OWerNT1
	hrdfLuz8Y4oU16PjXfZNc1GBRoq6KiJ80ijjZFf9RemWY1N62/jERV8/eS8dONaofiCz+7x1eXz
	Mky7ujSkGnKwJWNqZ9l0Naef0bnhgPaM9aDsOM7KIEXAf8kxJZp3fZ60naYiMEuXBmU41JfOQau
	cdd7hNi6vsoQay5BRKX7e0kXrUOkx6hrCmqmxiuM/yJyqxZ1mA3PY+ZDFjhKrP5oTYm8UZLx7zL
	9tuicxJLgUlLO4wvpjnQuAGMtUdJnuTctYfNtgZlSofnZm/Sr8D6/lg1I5EPCwrsvtcVEuLPDLD
	EiUKjFhaO4GvyHSoam9t0o8T1TEGuP+9UwdCKw6O+4V8lXx33odnFjyjAzXnhX9eIn1LbX4aOy6
	4FdOu0tCSBrUIbiEQGldxTg/n9tvgMFLKtPD3aMvlkNZw3Ziv/t3bMyQyVKqSk=
X-Received: by 2002:a05:600c:4fc9:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fe60e368amr114162145e9.6.1778969236869;
        Sat, 16 May 2026 15:07:16 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:8500:bde1:c576:18ad:a53? (p200300ea8f2c8500bde1c57618ad0a53.dip0.t-ipconnect.de. [2003:ea:8f2c:8500:bde1:c576:18ad:a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm144690005e9.12.2026.05.16.15.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 15:07:16 -0700 (PDT)
Message-ID: <841ca1ee-fc93-4735-b006-88735132e064@gmail.com>
Date: Sun, 17 May 2026 00:07:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v3 1/7] r8169: add support for multi irqs
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
 <20260513115543.1730-2-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260513115543.1730-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2098F55E0A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288668-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
> Changes in v3:
>  - add enum rtl_isr_version to replace macro definition
>  - remove struct rtl8169_napi, use napi_struct array instead and alloc
>    memory for this array dynamically
>  - remove struct rtl8169_irq
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 146 +++++++++++++++++++---
>  1 file changed, 127 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..e4fc84c97c1e 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -77,6 +77,7 @@
>  #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_MSIX_VEC	32
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -435,6 +436,8 @@ enum rtl8125_registers {
>  #define INT_CFG0_CLKREQEN		BIT(3)
>  	IntrMask_8125		= 0x38,
>  	IntrStatus_8125		= 0x3c,
> +	INTR_VEC_MAP_MASK	= 0x800,
> +	INTR_VEC_MAP_STATUS	= 0x802,
>  	INT_CFG1_8125		= 0x7a,
>  	LEDSEL2			= 0x84,
>  	LEDSEL1			= 0x86,
> @@ -578,6 +581,11 @@ enum rtl_register_content {
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
>  };
>  
> +enum rtl_isr_version {
> +	RTL_ISR_VER_DEFAULT = 0,
> +	RTL_ISR_VER_8127,
> +};
> +
>  enum rtl_desc_bit {
>  	/* First doubleword. */
>  	DescOwn		= (1 << 31), /* Descriptor is owned by NIC */
> @@ -733,7 +741,6 @@ struct rtl8169_private {
>  	struct pci_dev *pci_dev;
>  	struct net_device *dev;
>  	struct phy_device *phydev;
> -	struct napi_struct napi;
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
>  	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
> @@ -745,9 +752,16 @@ struct rtl8169_private {
>  	dma_addr_t RxPhyAddr;
>  	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
> +	struct napi_struct *rtl8169_napi;
> +	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	u16 hw_supp_num_rx_queues;

Sized types should only be used if the value directly represents
a register value. Why not simply use unsigned int here?

> +	enum rtl_isr_version hw_supp_isr_ver;
> +	enum rtl_isr_version hw_curr_isr_ver;
> +	u8 irq_nvecs;
> +	bool recheck_desc_ownbit;

Can't this flag be moved to, and handled the same as,
the following bool xxx:1 flags?

>  	int irq;
>  	struct clk *clk;
>  
> @@ -763,6 +777,8 @@ struct rtl8169_private {
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
>  	bool sfp_mode:1;
> +	bool rss_support:1;
> +	bool rss_enable:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -2680,6 +2696,21 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
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

I don't see hw_supp_isr_ver used anywhere else, so do we need to store it?

> +}
> +
>  static void rtl_request_firmware(struct rtl8169_private *tp)
>  {
>  	struct rtl_fw *rtl_fw;
> @@ -4266,9 +4297,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
>  	netdev_reset_queue(tp->dev);
>  }
>  
> +static void rtl8169_napi_disable(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		napi_disable(&tp->rtl8169_napi[i]);
> +}
> +
> +static void rtl8169_napi_enable(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		napi_enable(&tp->rtl8169_napi[i]);
> +}
> +
>  static void rtl8169_cleanup(struct rtl8169_private *tp)
>  {
> -	napi_disable(&tp->napi);
> +	rtl8169_napi_disable(tp);
>  
>  	/* Give a racing hard_start_xmit a few cycles to complete. */
>  	synchronize_net();
> @@ -4314,7 +4357,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
>  	for (i = 0; i < NUM_RX_DESC; i++)
>  		rtl8169_mark_to_asic(tp->RxDescArray + i);
>  
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	rtl_hw_start(tp);
>  }
>  
> @@ -4820,7 +4863,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> +		skb = napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
> @@ -4844,7 +4887,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->napi, skb);
> +		napi_gro_receive(&tp->rtl8169_napi[0], skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> @@ -4856,7 +4899,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  
>  static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
> -	struct rtl8169_private *tp = dev_instance;
> +	struct napi_struct *napi = dev_instance;
> +	struct rtl8169_private *tp = netdev_priv(napi->dev);

Revers xmas tree

>  	u32 status = rtl_get_events(tp);
>  
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
> @@ -4873,13 +4917,41 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		phy_mac_interrupt(tp->phydev);
>  
>  	rtl_irq_disable(tp);
> -	napi_schedule(&tp->napi);
> +	napi_schedule(napi);
>  out:
>  	rtl_ack_events(tp, status);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static void rtl8169_free_irq(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		struct napi_struct *napi = &tp->rtl8169_napi[i];
> +
> +		pci_free_irq(tp->pci_dev, i, napi);
> +	}
> +}
> +
> +static int rtl8169_request_irq(struct rtl8169_private *tp)
> +{
> +	struct net_device *dev = tp->dev;
> +	struct napi_struct *napi;
> +	int rc = 0;
> +
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		napi = &tp->rtl8169_napi[i];
> +		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> +				     NULL, napi, "%s-%d", dev->name, i);
> +		if (rc)
> +			break;
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
> @@ -4914,9 +4986,9 @@ static void rtl_task(struct work_struct *work)
>  
>  static int rtl8169_poll(struct napi_struct *napi, int budget)
>  {
> -	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
> -	struct net_device *dev = tp->dev;
> -	int work_done;
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp = netdev_priv(dev);

Reverse xmas tree

> +	int work_done = 0;
>  
>  	rtl_tx(dev, tp, budget);
>  
> @@ -5035,7 +5107,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	phy_init_hw(tp->phydev);
>  	phy_resume(tp->phydev);
>  	rtl8169_init_phy(tp);
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
> @@ -5053,7 +5125,7 @@ static int rtl8169_close(struct net_device *dev)
>  	rtl8169_down(tp);
>  	rtl8169_rx_clear(tp);
>  
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  
>  	phy_disconnect(tp->phydev);
>  
> @@ -5082,7 +5154,6 @@ static int rtl_open(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  	struct pci_dev *pdev = tp->pci_dev;
> -	unsigned long irqflags;
>  	int retval = -ENOMEM;
>  
>  	pm_runtime_get_sync(&pdev->dev);
> @@ -5107,8 +5178,7 @@ static int rtl_open(struct net_device *dev)
>  
>  	rtl_request_firmware(tp);
>  
> -	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
> -	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
> +	retval = rtl8169_request_irq(tp);
>  	if (retval < 0)
>  		goto err_release_fw_2;
>  
> @@ -5125,7 +5195,7 @@ static int rtl_open(struct net_device *dev)
>  	return retval;
>  
>  err_free_irq:
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  err_release_fw_2:
>  	rtl_release_firmware(tp);
>  	rtl8169_rx_clear(tp);
> @@ -5328,7 +5398,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
> +	struct pci_dev *pdev = tp->pci_dev;
>  	unsigned int flags;
> +	int nvecs;
>  
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
> @@ -5344,7 +5416,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +
> +	if (nvecs < 0)
> +		return nvecs;
> +
> +	tp->irq_nvecs = nvecs;
> +
> +	return 0;
>  }
>  
>  static void rtl_read_mac_address(struct rtl8169_private *tp,
> @@ -5539,6 +5618,17 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int rtl8169_set_real_num_queue(struct rtl8169_private *tp)
> +{
> +	int retval;

Sometimes you use retval, sometimes rc. This driver typically uses ret.

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
> @@ -5599,6 +5689,12 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +}
> +
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_chip_info *chip;
> @@ -5703,11 +5799,16 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
> +	tp->rtl8169_napi = devm_kcalloc(&pdev->dev, tp->irq_nvecs,
> +					sizeof(struct napi_struct), GFP_KERNEL);
> +	if (!tp->rtl8169_napi)
> +		return -ENOMEM;
>  
>  	INIT_WORK(&tp->wk.work, rtl_task);
>  	disable_work(&tp->wk.work);
> @@ -5716,7 +5817,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev->ethtool_ops = &rtl8169_ethtool_ops;
>  
> -	netif_napi_add(dev, &tp->napi, rtl8169_poll);
> +	if (!tp->rss_support)
> +		netif_napi_add(dev, &tp->rtl8169_napi[0], rtl8169_poll);
> +	else
> +		r8169_init_napi(tp);
>  
>  	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
>  			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> @@ -5778,6 +5882,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


