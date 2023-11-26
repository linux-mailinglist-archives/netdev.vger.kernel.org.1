Return-Path: <netdev+bounces-51146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16B7F9536
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 21:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B408CB209E9
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762F412E5F;
	Sun, 26 Nov 2023 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpCP+zOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C86E5
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 12:14:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332d5c852a0so2231741f8f.3
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 12:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701029665; x=1701634465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G7X2t9LoHtZbARWkkZkRLKIxAHWZtRUQtdoPRPJ4qhc=;
        b=dpCP+zOrjL/FXjxOAT4brZH2uhMiCYs8ePcMbNHp5II79zH+7HsVm8Ex4ojy74+0q2
         JqPylgQ6Q7gtYCXuRKnn9dY9covu3F73Q/b/wUEH80kkzg50Ux6jWqnp7g5zPmSyEPrF
         /WwKK3K25xccdLDrNfEc1ggqOzwkfp8brpVA5cg/RAV2UZiTU0nxIzxCVW55Qg6MztzC
         53Tm6wUcK7eUf/aGhe/RcSACzp13Hxfo258SqS1Hk64pc6c17wvu30t3Lh0u9abvyXdw
         gyyFUoXDULuVV+G9PG/JV5VzRRChTYz3wpffqcXKTvvAqd8BWlMGmEIbOxLohEtXw7/i
         HKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701029665; x=1701634465;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7X2t9LoHtZbARWkkZkRLKIxAHWZtRUQtdoPRPJ4qhc=;
        b=ZkUom47VU1k0tJgvwUsfyoZOuCo3C8QdVFlSxEpScCoRYuW/fBWKHL0qU3x3GoKjnV
         9uqDDjyDC/LDSJw/HWYWtvAmSOayT7QyjQHJ0vB9r3Nt8VhH2f0kRb4L5NDgkl8g+9/O
         wrzvqPTYHlLP0wgqdA/xcr5t4iHJZOuSBWKWMdASt/J5Xqte7b4NsOoWVvxvpDkaVUlG
         fQFtVV8mILdE9AvVx2Gm9uJSEcROUmQWLBlYChi1A8LSpSL1MIlzjoMONXrJkAJ2lPG+
         ZTg837rD3u49NGkr3rxaSMif1esmH5dsrpPzB1cZC68K8XgrNvTjxrVANJyui1iUsDo7
         PI2A==
X-Gm-Message-State: AOJu0Yz73HXcRb+2rZ2wt8eHnckKaacywxg2yM0ye/R/NdyAc2ASbEMY
	SybjLFaDti+aGBzeY1uPK0M=
X-Google-Smtp-Source: AGHT+IGsBqzVvk3Tg3VKPSkrk/sgcGblZ7ZOULChLJ3co3Oc2hRyMsXLlRY8RDp5/aR3c1xJURREeQ==
X-Received: by 2002:adf:f64a:0:b0:331:6d16:dbd4 with SMTP id x10-20020adff64a000000b003316d16dbd4mr6031690wrp.20.1701029664628;
        Sun, 26 Nov 2023 12:14:24 -0800 (PST)
Received: from ?IPV6:2a01:c23:c42d:f800:9d4a:26da:56c3:eb86? (dynamic-2a01-0c23-c42d-f800-9d4a-26da-56c3-eb86.c23.pool.telefonica.de. [2a01:c23:c42d:f800:9d4a:26da:56c3:eb86])
        by smtp.googlemail.com with ESMTPSA id o18-20020adf8b92000000b00332e8dd713fsm7863795wra.74.2023.11.26.12.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 12:14:24 -0800 (PST)
Message-ID: <c66a65f0-7d45-4bdd-9387-9f0b8bb06eef@gmail.com>
Date: Sun, 26 Nov 2023 21:14:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: fix deadlock on RTL8125 in jumbo mtu mode
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ian Chen <free122448@hotmail.com>
References: <caf6a487-ef8c-4570-88f9-f47a659faf33@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <caf6a487-ef8c-4570-88f9-f47a659faf33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.11.2023 19:36, Heiner Kallweit wrote:
> The original change results in a deadlock if jumbo mtu mode is used.
> Reason is that the phydev lock is held when rtl_reset_work() is called
> here, and rtl_jumbo_config() calls phy_start_aneg() which also tries
> to acquire the phydev lock. Fix this by calling rtl_reset_work()
> asynchronously.
> 
> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
> Reported-by: Ian Chen <free122448@hotmail.com>
> Tested-by: Ian Chen <free122448@hotmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 0ee3579ce..e32cc3279 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -575,6 +575,7 @@ struct rtl8169_tc_offsets {
>  enum rtl_flag {
>  	RTL_FLAG_TASK_ENABLED = 0,
>  	RTL_FLAG_TASK_RESET_PENDING,
> +	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>  	RTL_FLAG_TASK_TX_TIMEOUT,
>  	RTL_FLAG_MAX
>  };
> @@ -4494,6 +4495,8 @@ static void rtl_task(struct work_struct *work)
>  reset:
>  		rtl_reset_work(tp);
>  		netif_wake_queue(tp->dev);
> +	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
> +		rtl_reset_work(tp);
>  	}
>  out_unlock:
>  	rtnl_unlock();
> @@ -4527,7 +4530,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
>  	} else {
>  		/* In few cases rx is broken after link-down otherwise */
>  		if (rtl_is_8125(tp))
> -			rtl_reset_work(tp);
> +			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
>  		pm_runtime_idle(d);
>  	}
>  

I noticed there's a potential issue with my approach.
So I have to rework this, please do not apply.


