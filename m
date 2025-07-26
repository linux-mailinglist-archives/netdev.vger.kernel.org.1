Return-Path: <netdev+bounces-210287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62797B12A70
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61120189800A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A42405F9;
	Sat, 26 Jul 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PMDQg5YK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF91C84D6
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532689; cv=none; b=Pwidd4U4PK5juAZhBPbkoXfspex5wudMrthq7DO1Z7N1b7HAH/DcTuNEqzdlO0OqT8X3tdkxRkVqFl/fEJgRRm3/3iO43Y9jmaCsxwSBbGonJ+32LlemP39r7Iy2t8FgriCkMWWhjZJyBFsTSLtPgEw62q64uoZNSyH1glqaKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532689; c=relaxed/simple;
	bh=Gcg7oQZ0Cs0mV7ViF/tp6fRs8Jom9HiTXVsGYMDCurI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATEfUci0xDy+vdR8pkCKaoG71Jfn0sC2P/KSpQ4eaxfd7m3NHkAOZdR3c/M9vUQvgbPbFADgt1wQcpLJ8UJ4QkUmPmZeqKHWrM1S76mc1rbZbmVgihL+x3g/PtbMn5nvXDN1gAR1sGsf9c3fHFZWqnIm4LP28ijCZJuHBxDWlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PMDQg5YK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7746135acso1091396f8f.2
        for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532686; x=1754137486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEeI24M9CKXGYXMqbCaZiOJCU3qI95QDta4O7potMz0=;
        b=PMDQg5YKmx+8xLZ2zlib6zcQ3XDaj7XQuFaIMNYcPdqhX2e0Eo14b4uy9bUiDtoPeX
         G1WjRCLZigQo1rm7HrYE1LgrMJGr6vZgPVaMJ1YXNv9iHj4lVTZeM2F5R1JCerPghnI0
         jm3oJWRPK/Tajv4Y4cEY1VGLeXjqcwESawTN9Cdr6NInkhCCf94lYPRZoXbku0hCH1aM
         o538CyMz5HnCUX53K1Z5fNyoBT0GtDMSwidCm8gFJcIe+jxAlZdik5ukBPwXyBgvK1bN
         tqEvHu2/9SbkRkEa5RzTTKz6GnpgAcekBa2Ophw/PSGUMXln4iXEDB65NDwD+CMdH3jK
         h79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532686; x=1754137486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEeI24M9CKXGYXMqbCaZiOJCU3qI95QDta4O7potMz0=;
        b=EsC359V12zviEaK/7PUZXBZOiOn4LrCJSQZBHixED9Hbqd5+hKJf5WbKMhqExRLfB0
         lENTZJQsBWBGGre3CTznWJ2PhAtjTePmqidz7d2TajSx+Lb7evNQoHKKtZorpBSSGI+r
         zW0S2sPDQcVrbT04x6uK1ANZ/JYP3hVKXcmoFHVKBWeeA1Ti5NpIFi80/XPJxjiBjpsM
         Yh29aimu2Q1k6NAc0HFYaAyuOgerpbVh9UqsI+KK8Yz5wnlEYAi3fe6YLVyvRI63mLoh
         BR5zr4ilchFnxiweMcg2qaJKqFLOPB2KwoTjo6Rxt9DUNSHzYv41TbRt/aL7JZHKKIuw
         +Shg==
X-Forwarded-Encrypted: i=1; AJvYcCV9XDPMl+rs2mtg0mJr2TpSKVkYdjMCAYwqf1HK7OuAecJ9NLBvoOgfBg8qag+9HTVpaJW3NP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+sMf7uQxnhuPkk4JHDteLn8J1UiWwO+eRMoBKJrbefSCILOg
	Kf2q98DkPTm5QgDugmlkSv8HJIuiIDvuJ//8Rr+4klUsioGGibprcqQ96vTTgNV8Wbk=
X-Gm-Gg: ASbGnctp9NcN7OgY9eA7nTcrNFklyLcPMM5Rh2ZBEKQkIJeWjocxMm/HQnTRyz0zJpH
	WVmw2A6j4YYIQtbXI0D1ZNJuFQjgX/JEc/GiixvlLmCwI5W1mqWgxexa1982S260SbIi5Z1qeBJ
	ILxs8oOIwCN6Zzt1upS85iq/9L5qUD53UQYp3Gkhje3MIt+VOkmqe+2x+tANkfNO36rPkcSt/3/
	6AjeQ7YfwsCXfMJYj0Wy4EC8JzLr7T9AU2ww++h+VM6rcWLZMnsH1C33antXrQMSwnF7jmjUJIA
	1eH2rOAIZ80VOSi42pz8Icyl6Z7+2ipU+mKsqBoPHi1UMGzEZZpS25vg6H+JPIiYImtfRPykm4s
	p3vJQhLA661wTThYOCTNsNOAv9MGebc4=
X-Google-Smtp-Source: AGHT+IE0jHlZPoPK8hKHJN3yPZz6TMVC1vW7UvpmfxXPIn46UPBQb25NsX9NHtvvmEs7OLsBgg+hmw==
X-Received: by 2002:a5d:588f:0:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3b7765ee46cmr3851519f8f.19.1753532686049;
        Sat, 26 Jul 2025 05:24:46 -0700 (PDT)
Received: from [10.181.147.246] ([82.79.79.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587c9155a5sm21663515e9.19.2025.07.26.05.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:24:45 -0700 (PDT)
Message-ID: <3cb5f213-3c06-46c5-a314-ce9fb5b1d175@tuxon.dev>
Date: Sat, 26 Jul 2025 15:24:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: macb: Integrate ENST timing parameters
 and hardware unit conversion
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-3-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-3-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Vineeth,

On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Add Enhanced Network Scheduling and Timing (ENST) support to
> queue infrastructure with speed-dependent timing calculations for
> precise gate control.
> 
> Hardware timing unit conversion:
> - Timing values programmed as hardware units based on link speed
> - Conversion formula: time_bytes = time_ns / divisor
> - Speed-specific divisors:
>    * 1 Gbps:   divisor = 8
>    * 100 Mbps: divisor = 80
>    * 10 Mbps:  divisor = 800
> 
> Infrastructure changes:
> - Extend macb_queue structure with ENST timing control registers
> - Add queue_enst_configs structure for per-entry TC configuration storage
> - Map ENST register offsets into existing queue management framework
> - Define ENST_NS_TO_HW_UNITS() macro for automatic speed-based conversion
> 
> This enables hardware-native timing programming while abstracting the
> speed-dependent conversions
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb.h      | 32 ++++++++++++++++++++++++
>   drivers/net/ethernet/cadence/macb_main.c |  6 +++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index e456ac65d6c6..ef3995564c5c 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -857,6 +857,16 @@
>   
>   #define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
>   
> +/* ENST macros*/
> +#define ENST_NS_TO_HW_UNITS(ns, speed_mbps) \
> +		DIV_ROUND_UP((ns) * (speed_mbps), (ENST_TIME_GRANULARITY_NS * 1000))
> +
> +#define ENST_MAX_HW_INTERVAL(speed_mbps) \
> +		DIV_ROUND_UP(GENMASK(GEM_ON_TIME_SIZE - 1, 0) * ENST_TIME_GRANULARITY_NS * 1000,\
> +		(speed_mbps))
> +
> +#define ENST_MAX_START_TIME_SEC GENMASK(GEM_START_TIME_SEC_SIZE - 1, 0)

These are not used in this patch.

> +
>   /* struct macb_dma_desc - Hardware DMA descriptor
>    * @addr: DMA address of data buffer
>    * @ctrl: Control and status bits
> @@ -1262,6 +1272,11 @@ struct macb_queue {
>   	unsigned int		RBQP;
>   	unsigned int		RBQPH;
>   
> +	/* ENST register offsets for this queue */
> +	unsigned int		ENST_START_TIME;
> +	unsigned int		ENST_ON_TIME;
> +	unsigned int		ENST_OFF_TIME;
> +
>   	/* Lock to protect tx_head and tx_tail */
>   	spinlock_t		tx_ptr_lock;
>   	unsigned int		tx_head, tx_tail;
> @@ -1450,4 +1465,21 @@ struct macb_platform_data {
>   	struct clk	*hclk;
>   };
>   
> +/**
> + * struct queue_enst_configs - Configuration for Enhanced Scheduled Traffic (ENST) queue
> + * @queue_id:         Identifier for the queue
> + * @start_time_mask:  Bitmask representing the start time for the queue
> + * @on_time_bytes:    "on" time nsec expressed in bytes
> + * @off_time_bytes:   "off" time nsec expressed in bytes
> + *
> + * This structure holds the configuration parameters for an ENST queue,
> + * used to control time-based transmission scheduling in the MACB driver.
> + */
> +struct queue_enst_configs {

s/queue_enst_config/macb_queue_enst_config

> +	u8 queue_id;

Could you please move this above to avoid any padding?

> +	u32 start_time_mask;
> +	u32 on_time_bytes;
> +	u32 off_time_bytes;
> +};
> +

This structure is not used in this patch. Can you please introduce it in the 
patch it is used?


>   #endif /* _MACB_H */
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce95fad8cedd..ff87d3e1d8a0 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4305,6 +4305,9 @@ static int macb_init(struct platform_device *pdev)
>   			queue->TBQP = GEM_TBQP(hw_q - 1);
>   			queue->RBQP = GEM_RBQP(hw_q - 1);
>   			queue->RBQS = GEM_RBQS(hw_q - 1);
> +			queue->ENST_START_TIME = GEM_ENST_START_TIME(hw_q);
> +			queue->ENST_ON_TIME = GEM_ENST_ON_TIME(hw_q);
> +			queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(hw_q);

You can drop these lines here and move it outside of the if (hw_q) {} else {} block.

>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>   			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
>   				queue->TBQPH = GEM_TBQPH(hw_q - 1);
> @@ -4319,6 +4322,9 @@ static int macb_init(struct platform_device *pdev)
>   			queue->IMR  = MACB_IMR;
>   			queue->TBQP = MACB_TBQP;
>   			queue->RBQP = MACB_RBQP;
> +			queue->ENST_START_TIME = GEM_ENST_START_TIME(0);
> +			queue->ENST_ON_TIME = GEM_ENST_ON_TIME(0);
> +			queue->ENST_OFF_TIME = GEM_ENST_OFF_TIME(0);

With the above suggested change, these lines could be dropped.

On the other hand these lines are used in patch 3. So I would prefer to have 
them introduced there.

Thank you,
Claudiu

>   #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>   			if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
>   				queue->TBQPH = MACB_TBQPH;


