Return-Path: <netdev+bounces-210289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A02B12A77
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 14:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8879A1C801AD
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA824503C;
	Sat, 26 Jul 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WSBWYHnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301921401B
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532794; cv=none; b=UbTCJDhYEBk23DEWJo3Jnivn0nkKnTQLw62Dq7Q918MuZuZ9b+0x/pA+NqdGmr3bIZIVnub+wR7VhwIWh8YOEQgM8+Mi2rfYBAofMR6PUd7zbKoKFU2OVjtRw1zNMXOoJOg2OibNzjBVnlb+PtHps6fzU6nfVgUF9wt2hNsFrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532794; c=relaxed/simple;
	bh=ORT+AyzCNauahigfOOr8rKaf1lI9LpQh+BWhq5gZ6T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4jLSN7kWV6obX6RRJ1U8Awv1ULZoqGEhSmOAs/9Ye1zjeeSwrbTXI16ZiL1zt4gWe/5j886EZZhhfdhIvwRtWo3MaoXtu6Gx3WsrMM73ckJGfYY4mxz+8fb7obd85ULDLo7URo2923HsPKtNV1ntrQ34hNe9ftl0Zd02AIUrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WSBWYHnx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so19513135e9.3
        for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532790; x=1754137590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXz74LT5V7fJ3YDNhO9MJuXuVY37cDbTp53DDZ/S1x0=;
        b=WSBWYHnxLKBlJSRKeatVVyE3eRzzYHHVTNm/ew9F8HvKLErsPWj7yjsiH2ssCTghJe
         K+xghI8AtrxGk7VfBLk40KP8im+4NRHfR+Tt8F0V2P9f/gw/Dkg6sMTW7YvfkvkK/LJb
         kUR/QlE5cokutXZisZ2/V46HJJzBpsuRjs8fGrngMqF91BphTkcMQq63km1yoqRxe22x
         ZvZcVi3NCquCtvL7w4Ir2Dk+NQ8n17Yd+sEV1IgfGO/9VsgMEGt/QcoJ3xD1cR33YIIw
         flKLGQF8GMivjNIFYEAH5HATdnUBtRicBMk8eTl3XGvCpQBuYWlnM+EECEzoFeS7Plpo
         3jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532790; x=1754137590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXz74LT5V7fJ3YDNhO9MJuXuVY37cDbTp53DDZ/S1x0=;
        b=XvnCBv9vn6NjNDq1qS8jWXZ1VwWZRLT//PEwh//XwS69IhOfBHpybcWD9DDe2T9XtF
         1PE/Q7KRLh8gO3G6jS+o8f2nFU4pka/b9jkrrvNvVgOcYOwJg5dlUDs/Ul5ffvbLbzNz
         V4WQW0y+BEvHi7AQ7StZocmonw6/s03DAoNP2KfNX/iu4XYuKHw5Jwd2xevDORYqKMbO
         ZrIEoMGs4+83McY/Xyhu1q4nAYacFTFKutTCGOda1DOsforwIoF5e1KKveLD+wtxIEBm
         2ztuuQgo6CXWYX6ckYR973AL9RMyrJz4ts8hkmKqiDfX4gZVF2D9UiD9pL/gklkNsISO
         uXlA==
X-Forwarded-Encrypted: i=1; AJvYcCUCQJ3TYj5hFp5tBOdVfIyiXKklaKiyzvyXVpn783seZiUsot/9z/HNnX7MqsThwthgaUbBIoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJqi/TyhzsA9dOEgUaFLkfVbJjQ8MIr1L09hiud0trNMPBVZT
	lc250NtjozH4B9cQLJSl5UUurN76wcKqxgVu6McjksIFCdZbVC3TC1EBTzU5ieOOzJA=
X-Gm-Gg: ASbGncvRSa8CRvnlMM5opmyqbr9DZ4RckDlVSA240RJaB4laAN3y+HJCku0EmzpZP8B
	5Y/HN9Gg63VDNqldcnVKdlZSB8BdEvgJR3GhQPAI/w0AeQlcBO4UJy/5jh7EzvaXvgHz7RIhgSj
	k5mVhOh+DNH1L41v5KpXlO+qZhb9k7llYoYy5JMu5sybPhe2WWdujBVTmZhpYYjf5njLgjdQRK7
	FtnbRBkmeOdlSVEIk0ZKSPFDHpI8yPA/wUjHhIX2igDwvKwo28Cp/rSSRUMrSDevnTGEmdA012G
	4lnJWzgAqpFU1EchhaN061wsiE+jryjA8UmYkqSHHRN2XvETK7HHzQz2kDWUy7NxWzOjVlSxhqx
	3oxlKX3I2nNzdxEUV8okxQR0Imr4VTLw=
X-Google-Smtp-Source: AGHT+IFbQ7M+MHUoszE4dog/+tPFHS7TlxIikU0HmuOERDkjmR+L1tPTzLfHQsgc+ZBVZL843JY1SA==
X-Received: by 2002:a05:6000:2407:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b7765e6ba2mr3918155f8f.3.1753532790477;
        Sat, 26 Jul 2025 05:26:30 -0700 (PDT)
Received: from [10.181.147.246] ([82.79.79.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04546sm2622442f8f.53.2025.07.26.05.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:26:29 -0700 (PDT)
Message-ID: <9f16ace1-f1e7-41b0-bc7d-f358cd043271@tuxon.dev>
Date: Sat, 26 Jul 2025 15:26:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: macb: Implement TAPRIO DESTROY command
 offload for gate cleanup
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-5-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-5-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Add hardware offload support for "tc qdisc destroy" operations to safely
> remove IEEE 802.1Qbv time-gated scheduling configuration and restore
> default queue behavior.
> 
> Cleanup sequence:
> - Reset network device TC configuration state
> - Disable Enhanced Network Scheduling and Timing for all queues
> - Clear all ENST timing control registers (START_TIME, ON_TIME, OFF_TIME)
> - Atomic register programming with proper synchronization
> 
> This ensures complete removal of time-aware scheduling state, returning
> the controller to standard FIFO queue operation without residual timing
> constraints
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 4518b59168d5..6b3eff28a842 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4239,6 +4239,34 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
>   	return err;
>   }
>   
> +static void macb_taprio_destroy(struct net_device *ndev)

This function is unused in this patch. Nothing mentions it.

> +{
> +	struct macb *bp = netdev_priv(ndev);
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	u32 enst_disable_mask;
> +	u8 i;

unsigned int

> +
> +	netdev_reset_tc(ndev);
> +	enst_disable_mask = GENMASK(bp->num_queues - 1, 0) << GEM_ENST_DISABLE_QUEUE_OFFSET;

You can use GEM_BF(GENMASK(...), ENST_DISABLE_QUEUE) if you 
GEM_ENST_DISABLE_QUEUE_SIZE is defined

> +	netdev_dbg(ndev, "TAPRIO destroy: disabling all gates\n");
> +
> +	spin_lock_irqsave(&bp->lock, flags);

guard()

> +
> +	/* Single disable command for all queues */
> +	gem_writel(bp, ENST_CONTROL, enst_disable_mask);
> +
> +	/* Clear all queue ENST registers in batch */
> +	for (i = 0; i < bp->num_queues; i++) {

You can follow the pattern across macb_main.c and replace it with:

         for (unsigned int q = 0, queue = &bp->queues[q]; q < bp->num_queues; 
++q, ++queue)

> +		queue = &bp->queues[i];

And drop this line

Thank you,
Claudiu

> +		queue_writel(queue, ENST_START_TIME, 0);
> +		queue_writel(queue, ENST_ON_TIME, 0);
> +		queue_writel(queue, ENST_OFF_TIME, 0);
> +	}
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);
> +}
> +
>   static const struct net_device_ops macb_netdev_ops = {
>   	.ndo_open		= macb_open,
>   	.ndo_stop		= macb_close,


