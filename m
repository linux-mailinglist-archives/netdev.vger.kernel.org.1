Return-Path: <netdev+bounces-294419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 37/vI79JH2qLjgAAu9opvQ
	(envelope-from <netdev+bounces-294419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E36632106
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TorQFpCf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294419-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99F72302DC50
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02F399D0C;
	Tue,  2 Jun 2026 21:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661139C621
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:23:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435385; cv=none; b=K2SxMYrFmS/RZgjoHKbYMWHhi+WGc4hzT41RxO7SMvgFYyjwoOn/qDVe7wA8SNTYffaVdW7c7fIdaILeOymTFzVlxXuvUIizuIsP6VTgUMm2BHh7tdqUkWK/dcrBQoIU4sZ9vDOvgeNA2P2po4HtkmCkTopjliSAklZUImfFCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435385; c=relaxed/simple;
	bh=iOb5bce8AlMUfmzzg1apxreDhrvc3eS+yzpGOaltS7A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=My9AM4yPxFR+qKoJ1MZX2L3VmygNVANwqhwSPA67lp0t3gDWA2UP+q6u8tG6AgMBKJft6vDRUsAZfzhJlxOlLjbO10o4PYR9qD82kaABbiMiZOn4OHQwjKZTe62h5O3R/sVBEk2Kd8DJqAzEHOwSpyENqrT+eDrLK0vOC+hGf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TorQFpCf; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490a7629380so30046735e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780435382; x=1781040182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R78z9m/9xYVCSoSmhtuAu/ike1JCBh17wYz8wZTNvXc=;
        b=TorQFpCf7bDnS+wRME2KWa+5OyGE4lH6zWehDSNvUEHjNUBGBD+AFT0lDQpBpRRpMT
         LMv9iW6dMDItpwAXFOIjaizdFK9z3G/F7JEmWJF0vLJ5Qm1vNkygS7wO785KEsy0pPRg
         DFf3flaqTabB3Eu/k6y84R3hRp8fh+lszrv7OYzKnEthk85bTJOI31KcyaT17/zHOnX1
         m77XtiMNsmm0bcmdiyNx9bHdExxf7l0AlY37xuM6Vv38esG4ZHMkna4P19kObObFhfNa
         h7JT/cQthn3Joqki0e6LmTTak7DPyvzBWD7lvyYgsCIujZkChVvVSGk7okYroV3uwiV+
         jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780435382; x=1781040182;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R78z9m/9xYVCSoSmhtuAu/ike1JCBh17wYz8wZTNvXc=;
        b=FuCFzz+O8jnkE7e+pNgVdNF8myCeKp99YOyKJi87rAZgDa6y4flKPaRM9G44f+qIF5
         mVvmIOFje8gF5VPjDDzZ/bx3AnTku8lf3UEM7E5+xNKY1JsYnp/FbScCoa/IkyOXm5eh
         w8/1JCPtgH5N2vIBBex9wIuQzWwJkmsvl/123Il340Mz12jo5v5PjQi9qqn2XA5AoCi1
         tyhMRFR8IUPH39KYUgf42/92YOKom+daoA1Secd0NFVMA+nUOGBMxKE8vPH9lNjCOfIP
         z3Oxaz6RNffxtAnKNvavXacQKkuGbriJdAk/R0B/EpQHcXvqWIb2yEYDYrHsK0vll03K
         KYDA==
X-Gm-Message-State: AOJu0YxCQRYhsNeKtmXenRc/FX2W+Huj0fUvAvKc9tuy/fHXEsKl2cvc
	VVEJdEVy7t6ABnSCQKHNVRWPcNN21zSpPx1mfjVpAMaT0BacDJcHGenj
X-Gm-Gg: Acq92OFZj7Xo6kRl2+ZG4B9jEe5awgkrQsdYQdEZI6xu+r3baDciIOk8t0OtDEQgGSJ
	FIkH5VMU0QfYJ/0rEf3uPDgOxmy9X9s+AuXAuFcRzWf4gP7eN0dUuYRZdbUC4PUQYGzSg0ZovvB
	ci4GeZFHTBLc+cM5NIWfvouEWJCSnZt54UNFn6KfBOERCdCQXYteJs7zbNlfTOAnjSXBUHYhrJm
	crDfpvMhza95aIjk+7MPOQ4DDDc3WpsyHlw9sRInamrXH/J3DAMsQIyfB7wTuTSmTndgQoAfghg
	f5PYAk4TCn+KwzuGYPajjvt/qs7IgwmOjCAb1W1KsyXif2KCnPCvVvlg52AeKlxUmFT+eJndNNj
	27EAo6DCP5t7D8rNiwbyi6nf8VgHM8x9/dVDEotThvTnIKJ7Pw/vDRFqWBfzFFCjr9SDz3UPrD1
	x9Bg0R6VYCe+soJmtq4sBRMf3uxdwnnI12bULd4Wd2LPHf33kq7vyYatf0Lehh+P3OrEHI1LfY+
	h7fgPk/LcAUoyiwblNI/1seNj3jro0ajRf5MQlPdCZabh2aUQQEk6GLaC87fBqnJGAsgLeKwdiO
X-Received: by 2002:a05:600c:6092:b0:490:b3fe:9732 with SMTP id 5b1f17b1804b1-490b5ec3f9amr9509815e9.16.1780435381838;
        Tue, 02 Jun 2026 14:23:01 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f35:a100:65ef:a45f:1f40:5f43? (p200300ea8f35a10065efa45f1f405f43.dip0.t-ipconnect.de. [2003:ea:8f35:a100:65ef:a45f:1f40:5f43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b444f4fesm36906265e9.12.2026.06.02.14.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:23:00 -0700 (PDT)
Message-ID: <940d66e4-97e0-4904-bcc7-8c3eaf2ef320@gmail.com>
Date: Tue, 2 Jun 2026 23:22:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v6 1/7] r8169: add support for multi irqs
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
 <20260526081117.173-2-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260526081117.173-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55E36632106

On 26.05.2026 10:11, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RSS uses multi rx queues to receive packets, and each rx queue needs one
> irq and napi. So this patch adds support for multi irqs and napi here.
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
> 
> Changes in v4:
>  - change retval to ret in rtl8169_set_real_num_queue()
>  - reverse xmas tree in rtl8169_poll() and rtl8169_interrupt()
>  - remove tp->hw_supp_isr_ver
> 
> Changes in v5:
>  - rtl8169_request_irq(), when failed, only free irqs which are
>    allocated
>  - remove rss_support, simplied napi init, call r8169_init_napi()
>    directly
>  - remove rtl_isr_version, INTR_VEC_MAP_MASK, INTR_VEC_MAP_STATUS,
>    R8169_MAX_MSIX_VEC, rss_enable, recheck_desc_ownbit
>  - rtl_software_parameter_initialize() this function will be expanded in
>    next patch, so i want to remain it here.
> 
> Changes in v6:
>  - Fix netpoll crash
>  - Fix use-after-free during driver unload by registering a devm action
>    for netif_napi_del()
>  - remove tp->irq
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 144 ++++++++++++++++++----
>  1 file changed, 120 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..22e843baffc7 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -733,7 +733,6 @@ struct rtl8169_private {
>  	struct pci_dev *pci_dev;
>  	struct net_device *dev;
>  	struct phy_device *phydev;
> -	struct napi_struct napi;
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
>  	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
> @@ -745,10 +744,12 @@ struct rtl8169_private {
>  	dma_addr_t RxPhyAddr;
>  	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
> +	struct napi_struct *rtl8169_napi;
> +	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> -	int irq;
> +	unsigned int irq_nvecs;
>  	struct clk *clk;
>  
>  	struct {
> @@ -2680,6 +2681,11 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl_software_parameter_initialize(struct rtl8169_private *tp)

"software parameter" is too generic IMO. Can the function name better describe
which kind of parameters is initialized here?

> +{
> +	tp->num_rx_rings = 1;
> +}
> +
>  static void rtl_request_firmware(struct rtl8169_private *tp)
>  {
>  	struct rtl_fw *rtl_fw;
> @@ -4266,9 +4272,21 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
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
> @@ -4314,7 +4332,7 @@ static void rtl_reset_work(struct rtl8169_private *tp)
>  	for (i = 0; i < NUM_RX_DESC; i++)
>  		rtl8169_mark_to_asic(tp->RxDescArray + i);
>  
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	rtl_hw_start(tp);
>  }
>  
> @@ -4820,7 +4838,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> +		skb = napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);
>  		if (unlikely(!skb)) {
>  			dev->stats.rx_dropped++;
>  			goto release_descriptor;
> @@ -4844,7 +4862,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (skb->pkt_type == PACKET_MULTICAST)
>  			dev->stats.multicast++;
>  
> -		napi_gro_receive(&tp->napi, skb);
> +		napi_gro_receive(&tp->rtl8169_napi[0], skb);
>  
>  		dev_sw_netstats_rx_add(dev, pkt_size);
>  release_descriptor:
> @@ -4856,8 +4874,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  
>  static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
> -	struct rtl8169_private *tp = dev_instance;
> -	u32 status = rtl_get_events(tp);
> +	struct napi_struct *napi = dev_instance;
> +	struct rtl8169_private *tp;
> +	u32 status;
> +
> +	tp = netdev_priv(napi->dev);
> +	status = rtl_get_events(tp);
>  
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>  		return IRQ_NONE;
> @@ -4873,13 +4895,43 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
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
> +	int i, rc;
> +
> +	for (i = 0; i < tp->irq_nvecs; i++) {
> +		napi = &tp->rtl8169_napi[i];
> +		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> +				     NULL, napi, "%s-%d", dev->name, i);
> +		if (rc)
> +			goto free_irq;
> +	}
> +	return 0;
> +
> +free_irq:
> +	while (--i >= 0)
> +		pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
> +	return rc;
> +}
> +
>  static void rtl_task(struct work_struct *work)
>  {
>  	struct rtl8169_private *tp =
> @@ -4914,9 +4966,9 @@ static void rtl_task(struct work_struct *work)
>  
>  static int rtl8169_poll(struct napi_struct *napi, int budget)
>  {
> -	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
> -	struct net_device *dev = tp->dev;
> -	int work_done;
> +	struct rtl8169_private *tp = netdev_priv(napi->dev);
> +	struct net_device *dev = napi->dev;
> +	int work_done = 0;
>  
>  	rtl_tx(dev, tp, budget);
>  
> @@ -5035,7 +5087,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	phy_init_hw(tp->phydev);
>  	phy_resume(tp->phydev);
>  	rtl8169_init_phy(tp);
> -	napi_enable(&tp->napi);
> +	rtl8169_napi_enable(tp);
>  	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
> @@ -5053,7 +5105,7 @@ static int rtl8169_close(struct net_device *dev)
>  	rtl8169_down(tp);
>  	rtl8169_rx_clear(tp);
>  
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  
>  	phy_disconnect(tp->phydev);
>  
> @@ -5074,7 +5126,7 @@ static void rtl8169_netpoll(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  
> -	rtl8169_interrupt(tp->irq, tp);
> +	rtl8169_interrupt(pci_irq_vector(tp->pci_dev, 0), &tp->rtl8169_napi[0]);
>  }
>  #endif
>  
> @@ -5082,7 +5134,6 @@ static int rtl_open(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  	struct pci_dev *pdev = tp->pci_dev;
> -	unsigned long irqflags;
>  	int retval = -ENOMEM;
>  
>  	pm_runtime_get_sync(&pdev->dev);
> @@ -5107,8 +5158,7 @@ static int rtl_open(struct net_device *dev)
>  
>  	rtl_request_firmware(tp);
>  
> -	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
> -	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
> +	retval = rtl8169_request_irq(tp);
>  	if (retval < 0)
>  		goto err_release_fw_2;
>  
> @@ -5125,7 +5175,7 @@ static int rtl_open(struct net_device *dev)
>  	return retval;
>  
>  err_free_irq:
> -	free_irq(tp->irq, tp);
> +	rtl8169_free_irq(tp);
>  err_release_fw_2:
>  	rtl_release_firmware(tp);
>  	rtl8169_rx_clear(tp);
> @@ -5328,7 +5378,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
> +	struct pci_dev *pdev = tp->pci_dev;
>  	unsigned int flags;
> +	int nvecs;
>  
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
> @@ -5344,7 +5396,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
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
> @@ -5539,6 +5598,17 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int rtl8169_set_real_num_queues(struct rtl8169_private *tp)
> +{
> +	int ret;
> +
> +	ret = netif_set_real_num_tx_queues(tp->dev, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return netif_set_real_num_rx_queues(tp->dev, tp->num_rx_rings);
> +}
> +
>  static int rtl_jumbo_max(struct rtl8169_private *tp)
>  {
>  	/* Non-GBit versions don't support jumbo frames */
> @@ -5599,6 +5669,22 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	return false;
>  }
>  
> +static void r8169_del_napi_action(void *data)
> +{
> +	struct rtl8169_private *tp = data;
> +	int i;
> +
> +	for (i = 0; i < tp->irq_nvecs; i++)
> +		netif_napi_del(&tp->rtl8169_napi[i]);
> +}
> +
> +static void r8169_init_napi(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	devm_add_action_or_reset(&tp->pci_dev->dev, r8169_del_napi_action, tp);
> +}
> +
>  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	const struct rtl_chip_info *chip;
> @@ -5703,11 +5789,16 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
> @@ -5716,7 +5807,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev->ethtool_ops = &rtl8169_ethtool_ops;
>  
> -	netif_napi_add(dev, &tp->napi, rtl8169_poll);
> +	r8169_init_napi(tp);
>  
>  	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
>  			   NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX;
> @@ -5778,6 +5869,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (jumbo_max)
>  		dev->max_mtu = jumbo_max;
>  
> +	rc = rtl8169_set_real_num_queues(tp);
> +	if (rc < 0)
> +		return dev_err_probe(&pdev->dev, rc, "set tx/rx num failure\n");
> +
>  	rtl_set_irq_mask(tp);
>  
>  	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
> @@ -5803,8 +5898,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  			tp->leds = rtl8168_init_leds(dev);
>  	}
>  
> -	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d\n",
> -		    chip->name, dev->dev_addr, ext_xid_str, xid, tp->irq);
> +	netdev_info(dev, "%s, %pM, %sXID %x, IRQ %d (%d total)\n",
> +		    chip->name, dev->dev_addr, ext_xid_str, xid,
> +		    pci_irq_vector(pdev, 0), tp->irq_nvecs);
>  
>  	if (jumbo_max)
>  		netdev_info(dev, "jumbo features [frames: %d bytes, tx checksumming: %s]\n",


