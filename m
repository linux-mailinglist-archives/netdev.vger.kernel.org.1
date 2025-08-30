Return-Path: <netdev+bounces-218479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF0B3C949
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68296566DB0
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797826A0B9;
	Sat, 30 Aug 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTzGVXD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423AC2FB;
	Sat, 30 Aug 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756542575; cv=none; b=Ez1LsG09v9ku89hzoLZzku3cJZ8nB6ngg8i1IKugdy0as6WmC4QHYYjQ+L3uiF8pkXCQRJW6B1yxNjTO2BvEofT4clVkr9UoF8xIUKoeFd6sqQpZ4pm5jTmhncUir189eP7jiQBb18xPuv5p/g7zeCwsHWWiv/2kyosW8WzZ3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756542575; c=relaxed/simple;
	bh=YJa9g1jQmxJsnpiOk6+vb73pEF7Vldl8B3RcOMIWCBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laiOgpCuEK38M0NzfrzWGnWEveWKqDKUeJTKHrFHuPcwSohYMOAH1cLdaqsqfv8LHMx/4wp+pYhQAStGIE+353S9JQ1m4UrtxxPPl3O29zElCWXBblu/ee7p6wtLgIw1xL0zudhlRBoPJqgoXDb3gqijblCne9/lQIYy6JFYDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTzGVXD0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aff0365277aso217928466b.1;
        Sat, 30 Aug 2025 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756542571; x=1757147371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UyI9OoarlZqQH0hzHYoO1L3pvcQCbPCNVJRIJtvp8wM=;
        b=XTzGVXD09vLbvg1XjhPsU/xLEXklyLGQXPeoXrkwEY9H/gPB/jPBIRaviH24o0xW9Q
         h0qDp2sCBD7iPhIw/lO2bQtFFWSxfLjekQjgE5emKb/SYH57rrZR8b8nUuWj7PbxpgAN
         QNM/TAg5UtFgQQiDF9XPheifL8POwE21Fj2CqI+hVf9bpHU93WjbDuKGknfuny7jROqi
         WYxwZz8iBe8XyWqk/PO1sTnoXUS5Gx6aDdZpeHJadgieUW7sG9rZeGNxlCqxUKE/x/Qe
         ctC7pBzeRmqbEVGoFUWyCdXmZdagkqX5QixTbkWjuMcjXBBOyZpMwv0mY2E6J87Ua1kB
         wV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756542571; x=1757147371;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyI9OoarlZqQH0hzHYoO1L3pvcQCbPCNVJRIJtvp8wM=;
        b=A0BjuqFJqNtFr6Q9whmtXnBoQ/fvUsNZvkANh7XyPzxwSdklBGWj6hSgb0s9iqBW9y
         /Mg1ZzEg5FvIFXn15FwZdGTr48ckO+aDIvB8X7YHCYoHcwkCuaIgxinHaGT/vY17NMfF
         VzgrRB/jmUYkpmzt+Vhvu+GXqkxY/uaiSKAKBifzNc+6+P3f5nuntkaUp6mALYN2UjgO
         ncRrOFtCZccYy2+IpQft+0hjt5ZSDEeRzre7ZAxb4qHr29FJVDWAtJOTS5AdSuv/oYYL
         kow5A09nnI7N9KShx93YXGvUQDeOQ8L/bxjSWgJSsgEqK6/X30BHFASvUFewLLJrp5hg
         HjMA==
X-Forwarded-Encrypted: i=1; AJvYcCVpEEn9rKNvJnEAJC4ty2RctO5DRE5IMEBtVHxPLOyxvLu3obVue8JDfCRhmacjuquYLk58DytX@vger.kernel.org, AJvYcCXpHzv44zlbV+h4/D5d7Ta3kPaPNwAmD1/4ddxZwnakuxkAfVgNUOBXI2It+I3MYW7LV0sfWLPXaMOh30g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2l6M3H6i3W+K97kZQzmfsEXhD5QP/qE61tY1Q/kqB5mmcBE/o
	nusZ0ECdy/WG1WmSnmLxT3qlMmXK+R+sqGyIJWpXKZfhUKC7j7YMmFZFWaQUgA==
X-Gm-Gg: ASbGncv5Zfnq+/uSVIMZpIIk8pZtSwLu4WolcGuLu2n76c624O87yMX38nAhlOHqe5Z
	LARys8mo1oUonUnMjXNTOQ1Owa8nO38Io82fwFaNL8ia/qUX3PZuxmgWeE4NjpTcnkAo0exe88Y
	pSVeO3wx+J1i8FWMsB8yH0560l7vTEv4ARa6tl4Nlq9SKVoeRtbIRp/6SbAWs/k7cK9PNbzySYF
	BLTiiRybOUf6oE5n2+mPfXe2e0E7junJW32uk3sA0xLqMeIuqoSgq6AqSmiDIMlV7Hnzoi8UGGL
	kFcttY5FzwvMKxr0KS4Lp2WPZEijCfamMFAsOvGmalcJ537HJf98kz8717x6PEFuUs+Nf1Ypw49
	zrHZ1Gp/3k8h8sA0sdpdJeTSbo/xp3vEbMKiuspIsb0BAPUi0Ys0LFOBzPrhv9OyFDlhTCOuTDb
	MHpp97aYaR2jj597NEXzs4zgySQe2/nSTc/DAo2FLxyKIp18/nAdPnJShyvJny6kmQt8zBWvrP
X-Google-Smtp-Source: AGHT+IGhibod5iCblM6f9Db/jiWaPe2ll5b1jbDUV61HU+ps+A9AEA0fjCLrfif71SWAs7I4W23gVg==
X-Received: by 2002:a17:907:980c:b0:afd:eb4f:d5d2 with SMTP id a640c23a62f3a-b01f20c8180mr131544666b.31.1756542570743;
        Sat, 30 Aug 2025 01:29:30 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:643c:ff5b:b443:1ddd? (p200300ea8f2f9b00643cff5bb4431ddd.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:643c:ff5b:b443:1ddd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afefcbd8628sm374797266b.68.2025.08.30.01.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 01:29:30 -0700 (PDT)
Message-ID: <9fdcc731-2b1e-4195-bd9e-5f91b660341d@gmail.com>
Date: Sat, 30 Aug 2025 10:29:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: hardening and stability improvements
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 nic_swsd@realtek.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250830073039.598-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250830073039.598-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/2025 9:30 AM, Mohammad Amin Hosseini wrote:
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> 
> This patch improves robustness and reliability of the r8169 driver. The
> changes cover buffer management, interrupt handling, parameter validation,
> and resource cleanup.
> 
Are there any known issues which require these changes?
Then changes which actually fix something should come with a Fixes tag.

Several changes IMO don't make sense because they try to handle error
conditions which can't occur.

Please split this wild mix of changes and explain per patch:
- What is the problematic scenario and can it actually occur?

> While the updates touch multiple areas, they are interdependent parts of a
> cohesive hardening effort. Splitting them would leave intermediate states
> with incomplete validation.
> 
> Key changes:
> - Buffer handling: add packet length checks, NUMA-aware fallback allocation,
>   descriptor zero-initialization, and memory barriers.
> - Interrupt handling: fix return codes, selective NAPI scheduling, and
>   improved SYSErr handling for RTL_GIGA_MAC_VER_52.
> - Parameter validation: stricter RX/TX bounds checking and consistent
>   error codes.
> - Resource management: safer workqueue shutdown, proper clock lifecycle,
>   WARN_ON for unexpected device states.
> - Logging: use severity-appropriate levels, add rate limiting, and extend
>   statistics tracking.
> 
> Testing:
> - Kernel builds and module loads without warnings.
> - Runtime tested in QEMU (rtl8139 emulation).
> - Hardware validation requested from community due to lack of local device.
> 
> v2:
>  - Resent using msmtp (fix whitespace damage)
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 150 ++++++++++++++++++----
>  1 file changed, 123 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9c601f271c02..66d7dcd8bf7b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3981,19 +3981,39 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>  	int node = dev_to_node(d);
>  	dma_addr_t mapping;
>  	struct page *data;
> +	gfp_t gfp_flags = GFP_KERNEL;
>  
> -	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
> -	if (!data)
> -		return NULL;
> +	/* Use atomic allocation in interrupt/atomic context */

Is there any scenario where rtl8169_alloc_rx_data() would be called in atomic context?

> +	if (in_atomic() || irqs_disabled())
> +		gfp_flags = GFP_ATOMIC;
> +
> +	data = alloc_pages_node(node, gfp_flags, get_order(R8169_RX_BUF_SIZE));
> +	if (unlikely(!data)) {
> +		/* Try fallback allocation on any node if local node fails */
> +		data = alloc_pages(gfp_flags | __GFP_NOWARN, get_order(R8169_RX_BUF_SIZE));
> +		if (unlikely(!data)) {
> +			if (net_ratelimit())
> +				netdev_err(tp->dev, "Failed to allocate RX buffer\n");
> +			return NULL;
> +		}
> +		
> +		if (net_ratelimit())
> +			netdev_warn(tp->dev, "Fallback allocation used for RX buffer\n");
> +	}
>  
>  	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
>  	if (unlikely(dma_mapping_error(d, mapping))) {
> -		netdev_err(tp->dev, "Failed to map RX DMA!\n");
> +		if (net_ratelimit())
> +			netdev_err(tp->dev, "Failed to map RX DMA page\n");
>  		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
>  		return NULL;
>  	}
>  
>  	desc->addr = cpu_to_le64(mapping);
> +	desc->opts2 = 0;
> +	
> +	/* Ensure writes complete before marking descriptor ready */
> +	wmb();

Changes messing with memory barriers need a thorough explanation.
What is the problematic scenario? Any known issues?

>  	rtl8169_mark_to_asic(desc);
>  
>  	return data;
> @@ -4150,11 +4170,30 @@ static int rtl8169_tx_map(struct rtl8169_private *tp, const u32 *opts, u32 len,
>  	u32 opts1;
>  	int ret;
>  
> +	/* Validate parameters before DMA mapping */
> +	if (unlikely(!addr)) {

Any scenario where addr would be NULL?

> +		if (net_ratelimit())
> +			netdev_err(tp->dev, "TX mapping with NULL address\n");
> +		return -EINVAL;
> +	}
> +	
> +	if (unlikely(!len)) {
> +		if (net_ratelimit())
> +			netdev_err(tp->dev, "TX mapping with zero length\n");
> +		return -EINVAL;
> +	}
> +	
> +	if (unlikely(len > RTL_GSO_MAX_SIZE_V2)) {
> +		if (net_ratelimit())
> +			netdev_err(tp->dev, "TX length too large: %u\n", len);
> +		return -EINVAL;
> +	}
> +
>  	mapping = dma_map_single(d, addr, len, DMA_TO_DEVICE);
>  	ret = dma_mapping_error(d, mapping);
>  	if (unlikely(ret)) {
>  		if (net_ratelimit())
> -			netdev_err(tp->dev, "Failed to map TX data!\n");
> +			netdev_err(tp->dev, "Failed to map TX DMA: len=%u\n", len);
>  		return ret;
>  	}
>  
> @@ -4601,9 +4640,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		if (status & DescOwn)
>  			break;
>  
> -		/* This barrier is needed to keep us from reading
> -		 * any other fields out of the Rx descriptor until
> -		 * we know the status of DescOwn
> +		/* Ensure descriptor ownership check completes before accessing
> +		 * other fields to prevent hardware race conditions
>  		 */
>  		dma_rmb();
>  
> @@ -4624,8 +4662,27 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  		}
>  
>  		pkt_size = status & GENMASK(13, 0);
> -		if (likely(!(dev->features & NETIF_F_RXFCS)))
> -			pkt_size -= ETH_FCS_LEN;
> +		
> +		/* Validate packet size to prevent buffer overflows */
> +		if (unlikely(pkt_size > R8169_RX_BUF_SIZE)) {
> +			if (net_ratelimit())
> +				netdev_warn(dev, "Oversized packet: %u bytes (status=0x%08x)\n",
> +					    pkt_size, status);
> +			dev->stats.rx_length_errors++;
> +			goto release_descriptor;
> +		}
> +		
> +		if (likely(!(dev->features & NETIF_F_RXFCS))) {
> +			if (pkt_size >= ETH_FCS_LEN) {
> +				pkt_size -= ETH_FCS_LEN;
> +			} else {
> +				if (net_ratelimit())
> +					netdev_warn(dev, "Packet smaller than FCS: %u bytes (status=0x%08x)\n",
> +						    pkt_size, status);
> +				dev->stats.rx_length_errors++;
> +				goto release_descriptor;
> +			}
> +		}
>  
>  		/* The driver does not support incoming fragmented frames.
>  		 * They are seen as a symptom of over-mtu sized frames.
> @@ -4674,26 +4731,44 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
>  	struct rtl8169_private *tp = dev_instance;
>  	u32 status = rtl_get_events(tp);
> +	bool handled = false;
>  
> +	/* Check for invalid hardware state or no relevant interrupts */
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>  		return IRQ_NONE;
>  
> -	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
> -	if (unlikely(status & SYSErr &&
> -	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
> -		rtl8169_pcierr_interrupt(tp->dev);
> +	/* Handle system errors based on chip version capabilities */
> +	if (unlikely(status & SYSErr)) {
> +		/* SYSErr handling for older chips and specific newer models
> +		 * based on vendor documentation and observed behavior
> +		 */
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06 || 
> +		    tp->mac_version == RTL_GIGA_MAC_VER_52) {
> +			rtl8169_pcierr_interrupt(tp->dev);
> +		} else {
> +			/* Log for diagnostic purposes on newer chips */
> +			if (net_ratelimit())
> +				netdev_warn(tp->dev, "SYSErr on newer chip: status=0x%08x\n", status);
> +		}
> +		handled = true;
>  		goto out;
>  	}
>  
> -	if (status & LinkChg)
> +	if (status & LinkChg) {
>  		phy_mac_interrupt(tp->phydev);
> +		handled = true;
> +	}
> +
> +	if (status & (RxOK | RxErr | TxOK | TxErr)) {
> +		rtl_irq_disable(tp);
> +		napi_schedule(&tp->napi);
> +		handled = true;
> +	}
>  
> -	rtl_irq_disable(tp);
> -	napi_schedule(&tp->napi);
>  out:
>  	rtl_ack_events(tp, status);
>  
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static void rtl_task(struct work_struct *work)
> @@ -4783,8 +4858,11 @@ static int r8169_phy_connect(struct rtl8169_private *tp)
>  
>  static void rtl8169_down(struct rtl8169_private *tp)
>  {
> -	disable_work_sync(&tp->wk.work);
> -	/* Clear all task flags */
> +	/* Synchronize with pending work to prevent races during shutdown.
> +	 * This is necessary because work items may access hardware registers
> +	 * that we're about to reset.
> +	 */
> +	cancel_work_sync(&tp->wk.work);
>  	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
>  
>  	phy_stop(tp->phydev);
> @@ -4798,6 +4876,10 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	rtl_disable_exit_l1(tp);
>  	rtl_prepare_power_down(tp);
>  
> +	/* Disable clock if it was enabled during resume */
> +	if (tp->clk)
> +		clk_disable_unprepare(tp->clk);

The clk functions can deal with NULL arguments.

> +
>  	if (tp->dash_type != RTL_DASH_NONE)
>  		rtl8168_driver_stop(tp);
>  }
> @@ -4812,7 +4894,6 @@ static void rtl8169_up(struct rtl8169_private *tp)
>  	phy_resume(tp->phydev);
>  	rtl8169_init_phy(tp);
>  	napi_enable(&tp->napi);
> -	enable_work(&tp->wk.work);
>  	rtl_reset_work(tp);
>  
>  	phy_start(tp->phydev);
> @@ -4962,12 +5043,27 @@ static void rtl8169_net_suspend(struct rtl8169_private *tp)
>  static int rtl8169_runtime_resume(struct device *dev)
>  {
>  	struct rtl8169_private *tp = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (WARN_ON(!tp || !tp->dev)) {
> +		dev_err(dev, "Critical: Invalid device state during resume\n");
> +		return -ENODEV;
> +	}
>  
>  	rtl_rar_set(tp, tp->dev->dev_addr);
>  	__rtl8169_set_wol(tp, tp->saved_wolopts);
>  
> -	if (tp->TxDescArray)
> +	if (tp->TxDescArray) {
> +		/* Enable clock if available */
> +		if (tp->clk) {
> +			ret = clk_prepare_enable(tp->clk);
> +			if (ret) {
> +				dev_err(dev, "Failed to enable clock: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  		rtl8169_up(tp);
> +	}
>  
>  	netif_device_attach(tp->dev);
>  
> @@ -4980,7 +5076,7 @@ static int rtl8169_suspend(struct device *device)
>  
>  	rtnl_lock();
>  	rtl8169_net_suspend(tp);
> -	if (!device_may_wakeup(tp_to_dev(tp)))
> +	if (!device_may_wakeup(tp_to_dev(tp)) && tp->clk)
>  		clk_disable_unprepare(tp->clk);
>  	rtnl_unlock();
>  
> @@ -4991,7 +5087,7 @@ static int rtl8169_resume(struct device *device)
>  {
>  	struct rtl8169_private *tp = dev_get_drvdata(device);
>  
> -	if (!device_may_wakeup(tp_to_dev(tp)))
> +	if (!device_may_wakeup(tp_to_dev(tp)) && tp->clk)
>  		clk_prepare_enable(tp->clk);
>  
>  	/* Reportedly at least Asus X453MA truncates packets otherwise */
> @@ -5059,7 +5155,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
>  	if (pci_dev_run_wake(pdev))
>  		pm_runtime_get_noresume(&pdev->dev);
>  
> -	disable_work_sync(&tp->wk.work);
> +	/* Ensure all work is completed before device removal */
> +	cancel_work_sync(&tp->wk.work);
>  
>  	if (IS_ENABLED(CONFIG_R8169_LEDS))
>  		r8169_remove_leds(tp->leds);
> @@ -5471,7 +5568,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	tp->irq = pci_irq_vector(pdev, 0);
>  
>  	INIT_WORK(&tp->wk.work, rtl_task);
> -	disable_work(&tp->wk.work);
>  
>  	rtl_init_mac_address(tp);
>  
> @@ -5593,4 +5689,4 @@ static struct pci_driver rtl8169_pci_driver = {
>  	.driver.pm	= pm_ptr(&rtl8169_pm_ops),
>  };
>  
> -module_pci_driver(rtl8169_pci_driver);
> +module_pci_driver(rtl8169_pci_driver);
> \ No newline at end of file


