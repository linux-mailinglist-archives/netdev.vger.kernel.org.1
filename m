Return-Path: <netdev+bounces-285038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKT7C56y+2ncDQAAu9opvQ
	(envelope-from <netdev+bounces-285038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386D4E0981
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA163013AB4
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75953603C9;
	Wed,  6 May 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBnrpjHF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282F3128CA
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102937; cv=none; b=V9AXOedvvfFXOkQIMrI5t8iHNYirdp0cUMZzWg4NH95dZryQGjJvd9Q9RFuG/4Mf9rJXb49p6Uhs7lLg1ITsWBkyE0FSVq9Or7U30rfyKKYlO3VWD5DvsPGBIfSLxia6RxvJOmpyXnBBuSHtATc5lHG31mbftjUpY0wBZFE0Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102937; c=relaxed/simple;
	bh=SknxZIPJR31bHrn3AXhH8TtjO1A0FGHG83/sjdZoRDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/dSie3TF+hcMziipazRqGKAl8GKXHuyRl79TMsCKQ/Zs/WWHNaeJJAX2qyJCIQKNO06kX7ITaWUfvamPOS7sPbe77V0sUywOzfl3a0E4oZydV2LFGSGbQ+aJ3Mqz9vA5Kiut6BFCad4IKqayPWflKHpxfNAIgNr15PHEtb6q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBnrpjHF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso1632655e9.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778102934; x=1778707734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hf2nkeR6YZn7Hn0dvg+zmCA7+DAgAngg05jYmwRslmA=;
        b=NBnrpjHFRWgmOs5Ha5RPNi6j4CCblrcQZnPr8GMhPYKC+ZBoT0SIyV2LlofeyRLS+a
         3ZVjiTh2eIpNo9Ltuws6KPp7K6iPAfM0guWsucJDqnj7JfC9jcBFpZ/jSYe/8/npzYHm
         7MwJ1EyPYwbwPvujJ5X7xHJSocw3TZ50CHQ00GyY8+SC77iP0z+Ro2/ZXc0xPCLS6IcH
         yt4n3qOWZ7JS5AftGVV5lNuDDRuxqmICKZRUsaOFWRIR5OUXpJOsV0D+wVfN3qBsdGfU
         xK3+NTGD4EfZlfrLrrxa0p4egQ5UruklkVPRtchbgxBX/j3pBTpdWlJjHTEpCdT9Nwzo
         xKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102934; x=1778707734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf2nkeR6YZn7Hn0dvg+zmCA7+DAgAngg05jYmwRslmA=;
        b=IQUPhZ6DGaxX3fQtBVMumsIqXfjKxKHW4fj0Mir3SSXRodqaXUCkOUJn5EKPnowfs/
         sEHKXK8vLHFbvGHF4P3cECztHBQe57S9bQNXhZIpunPBSzTzrZGOg7dCb2X3MUJplEMx
         +iS8zpgli0Z6iGxIcg1G8ZC/biLfvh1gUv50okiYzHlONJob9YxVy40WAHdUviA0cr5X
         HS3KCi1LA6AsD7VZcdf+ZKN4TWqQHEt+D8flAvNwHBrmVhjjMt0rClibYjxri+etnWjc
         DZGgzYQRwWVrqGz1d3SGbIxMFkopuiEJMTNHT6xkBYJ8kb7oDh7xsFfhYj1Omikrpzen
         BuBw==
X-Gm-Message-State: AOJu0YyfMqoBCo94UO3sDZ+8aDjOxtYkJFXARrw+HJ5ll9JxyEW1fk9w
	AVimgl9+82PpkFzjgaGcN7h9wqG0vymyIMZbZzNOueith1AIKRuA9FjapME1Jg==
X-Gm-Gg: AeBDievzfiAwZRHFWO3WNUhKTNlZ+rVd1ww9zdWH0cREAdN1ykYuuX4CEbMrkOjhHy/
	tDTXwLT1hov/WuyEKaV0ehOGqwZ/EJsr8o9M83yZ4PNIcWJu2djELe70YCx6Uiu84Ljw36Km7pN
	VeHVJdc8oKiTtEY8qWzn5NN7+CielAAy6z+O2zuT+rcv1TBPbEJomNAfnMpUVytN26wUxo4laf2
	G/wwxJNDKGN+z9xefjttC7I8q5tnIYTXq7R+D+dQNL6jnN5Viw9s/hYQZf8nZF1h8GNNVPt2vqS
	QQiv4MGLTxV8EdfF2kTf7gWjhqz/U6snWUjyJPxdfJkjEKcHWukZdZNEGVt3c/ZDjGtVKVb00C1
	NP0ugVWwNwjrDg10+BTzOHKWuuh1kHQecNbkz1B+JDiEQyUy4tQebPx6uqLS+aERw/TPRvCDvpI
	VDZMgaiWqjafjqqx2vMTdQH7dTVWn9nitNRnUntwAwq3P0BKAkUWseGWllOdJZOKgagSuaSu+LZ
	/DIaUXPda/rcLTink+61xNLqyuRv3X82KzKp9bohqqQTlZCUmuJPVhv9x5No4R/Gi9vNoXrI4Rl
	jW2QIPuyKK4=
X-Received: by 2002:a05:600c:a110:b0:488:ae6c:42c6 with SMTP id 5b1f17b1804b1-48e51f2e8a3mr63504015e9.14.1778102934151;
        Wed, 06 May 2026 14:28:54 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:7800:4039:5b18:9ac5:4054? (p200300ea8f24780040395b189ac54054.dip0.t-ipconnect.de. [2003:ea:8f24:7800:4039:5b18:9ac5:4054])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538acf23sm71882505e9.8.2026.05.06.14.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 14:28:53 -0700 (PDT)
Message-ID: <bbbb2a7d-c6a3-4dcf-94f9-0e580d43897e@gmail.com>
Date: Wed, 6 May 2026 23:28:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v1 1/7] r8169: add support for multi irqs
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
 <20260506081326.767-2-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260506081326.767-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7386D4E0981
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-285038-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[209.85.128.53:received,100.90.174.1:received,2600:3c0a:e001:db::12fc:5321:from,2003:ea:8f24:7800:4039:5b18:9ac5:4054:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2003:ea:8f24:7800:4039:5b18:9ac5:4054:received,100.90.174.1:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 06.05.2026 10:13, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RSS uses multi rx queues to receive packets, and each rx queue needs one
> irq and napi. So this patch adds support for multi irqs and napi here.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 199 ++++++++++++++++++++--
>  1 file changed, 184 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..ef74ee02c117 100644
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

These register names don't have a chip version reference.
Does this mean they can be used on other chip versions
with RSS as well?

>  	INT_CFG1_8125		= 0x7a,
>  	LEDSEL2			= 0x84,
>  	LEDSEL1			= 0x86,
> @@ -728,6 +731,19 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_napi {
> +	struct napi_struct napi;
> +	void *priv;
> +	int index;

It seems the index is never used in this patch.

> +};
> +
> +struct rtl8169_irq {
> +	irq_handler_t	handler;
> +	unsigned int	vector;
> +	u8		requested;
> +	char		name[IFNAMSIZ + 10];
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -745,9 +761,19 @@ struct rtl8169_private {
>  	dma_addr_t RxPhyAddr;
>  	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
> +	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
> +	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
> +	u16 isr_reg[R8169_MAX_MSIX_VEC];
> +	u16 imr_reg[R8169_MAX_MSIX_VEC];

These arrays result in unecessarily high memory consumption on all other
chip versions. Can't they be dynamically allocated, only in case driver
supports RSS for the respective chip version?

> +	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	u8 min_irq_nvecs;
> +	u8 max_irq_nvecs;

It seems these values are actually constants.
Can't we avoid these members?

> +	u8 hw_supp_isr_ver;
> +	u8 hw_curr_isr_ver;
> +	u8 irq_nvecs;
>  	int irq;
>  	struct clk *clk;
>  
> @@ -763,6 +789,8 @@ struct rtl8169_private {
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
>  	bool sfp_mode:1;
> +	bool rss_support:1;
> +	bool rss_enable:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -2680,6 +2708,44 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
> +		tp->isr_reg[0] = IntrStatus;
> +		tp->imr_reg[0] = IntrMask;
> +	} else {
> +		tp->isr_reg[0] = IntrStatus_8125;
> +		tp->imr_reg[0] = IntrMask_8125;
> +	}
> +
> +	for (int i = 1; i < tp->max_irq_nvecs; i++)
> +		tp->isr_reg[i] = (u16)(INTR_VEC_MAP_STATUS + (i - 1) * 4);
> +
> +	for (int i = 1; i < tp->max_irq_nvecs; i++)
> +		tp->imr_reg[i] = (u16)(INTR_VEC_MAP_MASK + (i - 1) * 4);

This populates the array with constant values. Therefore, can't you avoid
using this array?

> +}
> +
> +static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
> +{
> +	tp->num_rx_rings = 1;
> +
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_80:
> +		tp->min_irq_nvecs = 1;
> +		tp->max_irq_nvecs = 1;
> +		tp->hw_supp_isr_ver = 6;

Magic value 6 requires at least an explanation and a constant.

> +		break;
> +	default:
> +		tp->min_irq_nvecs = 1;
> +		tp->max_irq_nvecs = 1;
> +		tp->hw_supp_isr_ver = 1;
> +		break;
> +	}
> +	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;

This indicates that the current version can be set to a version
which is not the supported one. This is misleading.
- Is supp_isr_ver the highest supported isr version?
- And does this mean that each chip is backwards-compatible and
  supports also all lower isr versions?

> +
> +	rtl_setup_mqs_reg(tp);
> +}
> +
>  static void rtl_request_firmware(struct rtl8169_private *tp)
>  {
>  	struct rtl_fw *rtl_fw;
> @@ -4266,9 +4332,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
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
> @@ -4313,8 +4391,8 @@ static void rtl_reset_work(struct rtl8169_private *tp)
>  
>  	for (i = 0; i < NUM_RX_DESC; i++)
>  		rtl8169_mark_to_asic(tp->RxDescArray + i);
> +	rtl8169_napi_enable(tp);
>  
> -	napi_enable(&tp->napi);

This moves the empty line. It should remain where it is.

>  	rtl_hw_start(tp);
>  }
>  
> @@ -4820,7 +4898,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> +		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
> @@ -4844,7 +4922,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->napi, skb);
> +		napi_gro_receive(&tp->r8169napi[0].napi, skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> @@ -4856,7 +4934,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  
>  static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
> -	struct rtl8169_private *tp = dev_instance;
> +	struct rtl8169_napi *napi = dev_instance;
> +	struct rtl8169_private *tp = napi->priv;
>  	u32 status = rtl_get_events(tp);
>  
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
> @@ -4873,13 +4952,53 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
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
> +		struct rtl8169_irq *irq = &tp->irq_tbl[i];
> +		struct rtl8169_napi *napi = &tp->r8169napi[i];
> +
> +		if (irq->requested) {

Is this check actually needed? Wouldn't pci_free_irq()
also be fine with irqs not having been requested?

> +			irq->requested = 0;
> +			pci_free_irq(tp->pci_dev, i, napi);
> +		}
> +	}
> +}
> +
> +static int rtl8169_request_irq(struct rtl8169_private *tp)
> +{
> +	const int len = sizeof(tp->irq_tbl[0].name);
> +	struct net_device *dev = tp->dev;
> +	struct rtl8169_napi *napi;
> +	struct rtl8169_irq *irq;
> +	int rc = 0;
> +
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		irq = &tp->irq_tbl[i];
> +
> +		napi = &tp->r8169napi[i];
> +		snprintf(irq->name, len, "%s-%d", dev->name, i);

I don't think this is needed. pci_request_irq() supports dynamic
irq name generation.

> +		irq->handler = rtl8169_interrupt;
> +		rc = pci_request_irq(tp->pci_dev, i, irq->handler, NULL, napi, irq->name);
> +		if (rc)
> +			break;
> +
> +		irq->vector = pci_irq_vector(tp->pci_dev, i);
> +		irq->requested = 1;
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
> @@ -4914,9 +5033,10 @@ static void rtl_task(struct work_struct *work)
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
> @@ -5035,7 +5155,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	phy_init_hw(tp->phydev);
>  	phy_resume(tp->phydev);
>  	rtl8169_init_phy(tp);
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
> @@ -5053,7 +5173,7 @@ static int rtl8169_close(struct net_device *dev)
>  	rtl8169_down(tp);
>  	rtl8169_rx_clear(tp);
>  
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  
>  	phy_disconnect(tp->phydev);
>  
> @@ -5108,7 +5228,8 @@ static int rtl_open(struct net_device *dev)
>  	rtl_request_firmware(tp);
>  
>  	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
> -	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
> +
> +	retval = rtl8169_request_irq(tp);
>  	if (retval < 0)
>  		goto err_release_fw_2;
>  
> @@ -5125,7 +5246,7 @@ static int rtl_open(struct net_device *dev)
>  	return retval;
>  
>  err_free_irq:
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  err_release_fw_2:
>  	rtl_release_firmware(tp);
>  	rtl8169_rx_clear(tp);
> @@ -5328,7 +5449,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
> +	struct pci_dev *pdev = tp->pci_dev;
>  	unsigned int flags;
> +	int nvecs;
>  
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
> @@ -5344,7 +5467,18 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	return pci_alloc_irq_vectors(tp->pci_dev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, tp->min_irq_nvecs, tp->max_irq_nvecs, flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);

This may be dangerous. If the first allocation fails, you may here allocate an
interrupt of a type not supported by the chip.

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
> @@ -5539,6 +5673,17 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
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
> @@ -5599,6 +5744,19 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
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
> +		netif_napi_add(tp->dev, &r8169napi->napi, poll);
> +		r8169napi->priv = tp;
> +		r8169napi->index = i;
> +	}
> +}
> +
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_chip_info *chip;
> @@ -5703,11 +5861,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
> @@ -5716,7 +5875,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev->ethtool_ops = &rtl8169_ethtool_ops;
>  
> -	netif_napi_add(dev, &tp->napi, rtl8169_poll);
> +	if (!tp->rss_support) {
> +		netif_napi_add(dev, &tp->r8169napi[0].napi, rtl8169_poll);
> +		tp->r8169napi[0].priv = tp;
> +		tp->r8169napi[0].index = 0;
> +	} else {
> +		r8169_init_napi(tp);
> +	}
>  
>  	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
>  			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> @@ -5778,6 +5943,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


