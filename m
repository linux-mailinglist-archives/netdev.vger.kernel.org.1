Return-Path: <netdev+bounces-287291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBaIGbSPA2qM7QEAu9opvQ
	(envelope-from <netdev+bounces-287291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478152963C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DABB308AF93
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C93C9EDF;
	Tue, 12 May 2026 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQfYjtqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCE3BB13A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617840; cv=none; b=RcZvNtiR14wG1oK9n2HjFj+BSQ/MQStj2+W/1x/QYPdgqzVAOkmZvVZEkftzcK8PJrLsc/5NyYR4DRxgIgPok7EKTO92hEaWXsOGVxECDXwJ3og3rRfDuvtkIjo06IjDgxN+WB04ILw2N/o2LJjQ1QbnowieURHrcYGAwAlDNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617840; c=relaxed/simple;
	bh=xEjbSd03AEqF56W5JQp+tlvPw6vwMv+uTO2jL7BCgwU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FOsniIUJAlRmoxPUF4dYjfNhjyBaeMwvjeFD1CifPgJNn4OihgHY7uUQadTecWQrL0QHd3r+CoSKsNvXWKwXjspl4Rf9x4tG3+VF5ua18kwbfKlPrqg1PxnD9WI/J9YVAG5ix+vIHYp3IgGG/WXIfQYSpUSRzY++U0HyaC44qY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQfYjtqA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so3108657f8f.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617837; x=1779222637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQqkMs5rzijAsNU858PzEAUmb8Oapc0XAI2uPfZhi94=;
        b=BQfYjtqAM6PvY8j9QPSCHW/32gDPYJ5vP2nnWkhJNAIVLaI7RvEZQ0h9CD4JJnYNUg
         UDZsvk109qf6iIQ5BtCaP7zwIEu80j7vxB7qzHYjHf5s0BwjnHpBUFFwsLPtzIQAUWJm
         U4XgZMADNbQNhIILHMKIukqfviQmD06aW10g/sIw9sPkrbxcFZGA/G2/p7+QvIYujfjJ
         f4c2J7IPzbLstVXrFDg2v737AhjJ2gL3LioZSaQSOJoSF1Osndyq0VMCKfBDDFfnYD/V
         DdvUNNVFASrLwCme8gdz9ww+oovOu3ybX7aMDIZxQbxxi64FzZECuvtaeMdoYuKcsHkS
         sM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617837; x=1779222637;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQqkMs5rzijAsNU858PzEAUmb8Oapc0XAI2uPfZhi94=;
        b=mYCwsaGK5E1mas9AouGG+ZWfEJNJPqR3lEeP5K8NZHDTlvx734O+oW/UnwbsGgvth6
         4ZV/ULVp25fyTRnclpoNSGTlUDoUe5E3F2dRAoxJ+A1yEArbYvZn7rnhyODAmJyZIMfp
         jR29StnWvlSqojpJ/8tpVMM2nd0X6n41JEQLl6eHo4lyL1qq7DArfDKzTL476l3sAJJ6
         vcxNjPQ5QFquvU6tHbkkQ70Su/bcnIHjgLuQ1OXjrjeVCQJa1P/zCIi+lhgmWVxZWHkh
         CnwnTGI4CM0Nln8JQGzBBznCoN/p2SrtLQrxwXwUoNe6ZHWgX8TVMiy58pjt1Oev78VV
         fdxg==
X-Gm-Message-State: AOJu0Yx/RT+EsHIGxsAYAk+WxIMFIUoO3CJOYtUWY9S7h738HK6ts1r1
	s3a9jB2GtV2ZGI4K3A+DmQrT+Yf1D5oJd5uMo3mtx+XXzt/1vWzZYVZ0qQyNPg==
X-Gm-Gg: Acq92OHJagnRCQHy1qHNukGEa7hpBwwcN9oyEE6nbZiTMuJuVrtT7q0b6KxCYtBnDfB
	IdtLQY5WDxxZUfNpZPTF8yM0muNfowRPBcdMz94At9+yXhL6Zfkb2O9NEtwMoDo1W0BiHZz40fL
	rhIReXhppVOKzwI0IPpiXiFpIgkaESxyqd7lP0xkZmdN+Gvl8e93SEJtMiuAty4EGhBDEgCqYu5
	DJE6ERL2sOOa+XZ4a0QI0nuDthrwFg5nHzv/K5uCtQP1GQArUD05pqa7vxf3R0SMqpCxerKx0FN
	0W+iNOUKpBUrLbGTqmaIh9KDiOFlSs+EwbozQEEeJtBgBMKnYH0TyCkN0Fy7AkE/RULb02Eebcx
	p1mResMr77U6gM6f8AhUu6hURN6VOTtbLIdTNaCu/MXFrf2FRr9L0CCvlyi2ZfEDKa74uKlHscK
	7X3gzC2gIN9ws+tauVny4Kh3n0gJf7muRS2Vl3METOxMfhuYzusPJxuOSFKnz22VoJLZCIUky0J
	zPQzbzuYieoBZHzszudeZflKpIpMkrUZChakHgADkd+9FKovvo0PyPSvFMXqIA7cg==
X-Received: by 2002:a05:6000:1841:b0:451:2157:6291 with SMTP id ffacd0b85a97d-45c5ad4b0e5mr349658f8f.41.1778617836889;
        Tue, 12 May 2026 13:30:36 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3200:655a:16b8:d272:9436? (p200300ea8f473200655a16b8d2729436.dip0.t-ipconnect.de. [2003:ea:8f47:3200:655a:16b8:d272:9436])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm30698945f8f.4.2026.05.12.13.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:30:36 -0700 (PDT)
Message-ID: <4487f8da-1cb7-4683-b96a-6b8613d8654c@gmail.com>
Date: Tue, 12 May 2026 22:30:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v2 3/7] r8169: add support for new interrupt
 mapping
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508121802.2010-1-javen_xu@realsil.com.cn>
 <20260508121802.2010-4-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260508121802.2010-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4478152963C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287291-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 08.05.2026 14:17, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 158 ++++++++++++++++++++--
>  1 file changed, 147 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 29fcd469eebb..bb72a2030f44 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -77,6 +77,7 @@
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
>  #define R8169_MAX_RX_QUEUES	8
> +#define R8127_MAX_TX_QUEUES	8
>  #define R8169_MAX_MSIX_VEC	32
>  #define R8127_MAX_RX_QUEUES	8
>  #define R8169_DEFAULT_RX_QUEUES	1
> @@ -452,8 +453,13 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
> +	ISR_VEC_MAP_REG		= 0x0d04,
> +	IMR_SET_VEC_MAP_REG	= 0x0d0c,
>  };
>  
> +#define MSIX_ID_VEC_MAP_LINKCHG	29
> +#define RTL_VEC_MAP_ENABLE	BIT(0)
>  #define LEDSEL_MASK_8125	0x23f
>  
>  #define RX_VLAN_INNER_8125	BIT(22)
> @@ -584,6 +590,9 @@ enum rtl_register_content {
>  
>  	/* magic enable v2 */
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +#define	ISRIMR_LINKCHG	BIT(29)
> +#define	ISRIMR_TOK_Q0	BIT(8)
> +#define	ISRIMR_ROK_Q0	BIT(0)
>  };
>  
>  enum rtl_desc_bit {
> @@ -750,6 +759,7 @@ struct rtl8169_rx_ring {
>  struct rtl8169_napi {
>  	struct napi_struct napi;
>  	void *priv;
> +	int index;

napi_struct has a member index for the same purpose,
can't you use this one?

>  };
>  
>  struct rtl8169_irq {
> @@ -787,6 +797,7 @@ struct rtl8169_private {
>  	u8 hw_curr_isr_ver;
>  	u8 irq_nvecs;
>  	bool recheck_desc_ownbit;
> +	unsigned int features;
>  	int irq;
>  	struct clk *clk;
>  
> @@ -1685,26 +1696,36 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
>  
>  static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
>  {
> -	if (rtl_is_8125(tp))
> +	if (rtl_is_8125(tp)) {
>  		RTL_W32(tp, IntrStatus_8125, bits);
> -	else
> +		if (tp->features & RTL_VEC_MAP_ENABLE)
> +			RTL_W32(tp, ISR_VEC_MAP_REG, 0xffffffff);
> +	} else {
>  		RTL_W16(tp, IntrStatus, bits);
> +	}
>  }
>  
>  static void rtl_irq_disable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> +	if (rtl_is_8125(tp)) {
>  		RTL_W32(tp, IntrMask_8125, 0);
> -	else
> +		if (tp->features & RTL_VEC_MAP_ENABLE)
> +			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
> +	} else {
>  		RTL_W16(tp, IntrMask, 0);
> +	}
>  }
>  
>  static void rtl_irq_enable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->features & RTL_VEC_MAP_ENABLE)
> +			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
> +		else
> +			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> +	} else {
>  		RTL_W16(tp, IntrMask, tp->irq_mask);
> +	}
>  }
>  
>  static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
> @@ -5080,6 +5101,44 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
> +{
> +	struct rtl8169_napi *napi = dev_instance;

Name napi is typically used for the napi_struct. This may cause confusion.
Better reflect in the name that this is about a custom struct.

> +	struct rtl8169_private *tp = napi->priv;
> +	int message_id = napi->index;
> +
> +	rtl8169_disable_hw_interrupt_msix(tp, message_id);
> +

Why do you disable interrupts here, and not directly before the
call to napi_schedule()?

> +	rtl8169_clear_hw_isr(tp, message_id);
> +
> +	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
> +		phy_mac_interrupt(tp->phydev);
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +		return IRQ_HANDLED;
> +	}
> +
> +	tp->recheck_desc_ownbit = true;
> +
> +	napi_schedule(&napi->napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int rtl8169_request_irq(struct rtl8169_private *tp)
>  {
>  	struct net_device *dev = tp->dev;
> @@ -5089,8 +5148,11 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  
>  	for (int i = 0; i < tp->irq_nvecs; i++) {
>  		irq = &tp->irq_tbl[i];
> +		if (tp->features & RTL_VEC_MAP_ENABLE && tp->hw_curr_isr_ver > 1)

What's the difference between this check and tp->rss_enable?

> +			irq->handler = rtl8169_interrupt_msix;
> +		else
> +			irq->handler = rtl8169_interrupt;

AFAIK indirect calls are expensive, what may hurt in a hot path.

>  		napi = &tp->r8169napi[i];
> -		irq->handler = rtl8169_interrupt;
>  		rc = pci_request_irq(tp->pci_dev, i, irq->handler,
>  				     NULL, napi, "%s-%d", dev->name, i);
>  		if (rc)
> @@ -5539,10 +5601,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->features & RTL_VEC_MAP_ENABLE) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>  }
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
> @@ -5573,6 +5641,9 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  	tp->irq = pci_irq_vector(pdev, 0);
>  	tp->irq_nvecs = nvecs;
>  
> +	if (nvecs > 1)
> +		tp->features |= RTL_VEC_MAP_ENABLE;
> +
>  	return 0;
>  }
>  
> @@ -5839,6 +5910,53 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	const int message_id = r8169_napi->index;
> +	struct net_device *dev = tp->dev;
> +	int work_done = 0;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	const int message_id = r8169_napi->index;
> +	int tx_ring_idx = message_id - 8;
> +	struct net_device *dev = tp->dev;
> +	unsigned int work_done = 0;
> +
> +	if (tx_ring_idx >= 0)
> +		rtl_tx(dev, tp, budget);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
> +{
> +	struct rtl8169_napi *r8169_napi = container_of(napi, struct rtl8169_napi, napi);
> +	struct rtl8169_private *tp = r8169_napi->priv;
> +	const int message_id = r8169_napi->index;
> +
> +	napi_complete_done(napi, budget);
> +	rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return 1;
> +}
> +
>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
>  	for (int i = 0; i < tp->irq_nvecs; i++) {
> @@ -5846,8 +5964,25 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  		int (*poll)(struct napi_struct *napi, int budget);
>  
>  		poll = rtl8169_poll;
> +		if (tp->features & RTL_VEC_MAP_ENABLE) {
> +			switch (tp->hw_curr_isr_ver) {
> +			case 6:
> +				if (i < R8127_MAX_RX_QUEUES)
> +					poll = rtl8169_poll_msix_rx;
> +				else if (i >= R8127_MAX_RX_QUEUES &&
> +					 i < (R8127_MAX_RX_QUEUES +
> +					 R8127_MAX_TX_QUEUES))
> +					poll = rtl8169_poll_msix_tx;
> +				else
> +					poll = rtl8169_poll_msix_other;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
>  		netif_napi_add(tp->dev, &r8169napi->napi, poll);
>  		r8169napi->priv = tp;
> +		r8169napi->index = i;
>  	}
>  }
>  
> @@ -5975,6 +6110,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (!tp->rss_support) {
>  		netif_napi_add(dev, &tp->r8169napi[0].napi, rtl8169_poll);
>  		tp->r8169napi[0].priv = tp;
> +		tp->r8169napi[0].index = 0;
>  	} else {
>  		r8169_init_napi(tp);
>  	}


