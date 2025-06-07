Return-Path: <netdev+bounces-195512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF88AD0D69
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84331188E275
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC657221DB2;
	Sat,  7 Jun 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qRNwsGkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F35218AC3
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749299341; cv=none; b=a5JAakZAwKxHt//yFdFUOPM7lBpbs1PCWeabAeC9HYuPeKYVY6Oh0qdLSL+dIPO23fJ6pI/piYOrzt6xfDEESJ9pATiWmbxx7gXEprsHdQsgXdPiYoCyG69pS1/Ihs2gjqGvpdBAdoCCWJHgtu5NvuNEI9oFqpiTdc4dQPoKYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749299341; c=relaxed/simple;
	bh=mOYIXQSgfPhZh9fXOpojbPonzPyR2relJWId2pZWqTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLezveyrIMiAjmsjolpWmRwfnxwjCovun3l5vyWPrkgwcd29OBoELqiyMWX0hDGvikJ1dukvq3jnas3drURCZlAlWfQQVHjfn9SwKnGkA9w+I7sDs1nYqEW1DKJs8xIo1jGotG1mh/cqXYqlA3dFbeIbCqe4Cb+2HFWAged1fSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qRNwsGkA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so3636405a12.3
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749299338; x=1749904138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFcvezHtTKFU/yLY9c/XHMI/P40/ElaQdRi+0Qte8ys=;
        b=qRNwsGkAAOjiLWji54gDHgxDd1zPZBy78zuuxdZ1lkGq7H0oRYkClGY8HPJjIwicl7
         EbhKuG2dZ++gUw6xP4n3B/nenvbFG+70UrNmJ+fsgN1i27ID21w3wEORwjl1T5pchhOm
         9scpiBRrUCGVGJpTrI4qFnhlCYxSHdWxDVUyyeMaXyRQO6Sz85gVIgAAoMRzt0QShIO/
         +uMmHhSxDEP4ngNQHH1tjL5tGq9Ma8YK1Vxh57GO+0DghrEharWtI7QSIikXMuiMR6qe
         50FiC4X13DS5l00V/SkGbCt829Bux15sF35WPkzCrPXb2gxVKLPa7rFkvZjWgQTsh2Ua
         5FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749299338; x=1749904138;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFcvezHtTKFU/yLY9c/XHMI/P40/ElaQdRi+0Qte8ys=;
        b=V1+1cvBTLMD8MBgqZndFN3e7MiUS240KcMlogjB7nMrzGtndehgzB8KvXsZVDx+pmn
         i++XD/tEA2PuhzRs30l+7B94rXTph/4ozj3aCIsz9wAVlkok5H9iDovcsVybIrqLYMQN
         6JSY8Z0aZNM27dUIYmSjFwRLAiLAQG6SV2lGaOPn14ySuuwwXJJlb3hAgkkhwYjXYH9X
         iqc4tXSzkvLy1Yab5OiZv3VCfvSH0smelked6Rwmh4dHTQYWzGtoa7VHVgYc2id6x2Nl
         E8u5V6NxEcfQay+VMua4GcmDoUW8ubIdpJ2oWTKKxArKJ3L49Oky8iGL2JS8tUxzaIIQ
         GoGg==
X-Forwarded-Encrypted: i=1; AJvYcCXUXj0OqCzsUlfJbdR+HZU4a9ASgldYvc8DWNa80qq8mio+Zyzk4LNSeTTBvUNaiV201aO1H1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YziWdUsAYM2UHX3DXoK0vcdKYJN4LSk3QcY6M+Q0zUZthzRv5iy
	hkBlrovLdLPGvyBhTsBszYNLPA/7AJvQ1n0JGEiMBsdJmGKzogkiQlb7M+pUQT+t2UY=
X-Gm-Gg: ASbGncsw0EIZRCBNE88mkmDEoIKkLLh3EV6GCzFAaNfykMXRf947s5uhBX9kT5tuA21
	FR+PSQMlRdK3olHMprPrZLtMTt76pgXMnUdpM0bsy54LF1hovIZ+K/WRgym65gkADOSm9q8e4vh
	fFM0BCoj39t+MAr82jUftKFZnNutX2k/0oFhwLLJ4QLYokZ/OeQPg/L//sXu7GKjrh1t6Ih4Qb7
	R/kfgPpfqRLKj9KhNEoaQSa//UDrFxN2tXiK2LJ5TupmPQeJ5BzKwFgZ3OCkzQrovzFNvdircsz
	Urrh6g2+5d/9S+GuoKViLmjHD/IeUyHLY02HHJNq7qsQMh7ptlkV99odDPf/
X-Google-Smtp-Source: AGHT+IFDAnUmiVsyjfygehYUr8ASHgYoLs98lcg7K2XPROZpb83wxSo3Nj+DR+TRSNXc7a0sWKTb0g==
X-Received: by 2002:a17:907:1c8e:b0:ad5:27b6:7fd1 with SMTP id a640c23a62f3a-ade1a9ed9a1mr624659966b.17.1749299337801;
        Sat, 07 Jun 2025 05:28:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc38a06sm267601466b.119.2025.06.07.05.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 05:28:57 -0700 (PDT)
Message-ID: <07d527e5-32d9-4e8c-ad19-92f5a722bfd5@tuxon.dev>
Date: Sat, 7 Jun 2025 15:28:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: macb: Add shutdown operation support
To: Abin Joseph <abin.joseph@amd.com>, nicolas.ferre@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607075713.1829282-1-abin.joseph@amd.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250607075713.1829282-1-abin.joseph@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Abin,

On 07.06.2025 10:57, Abin Joseph wrote:
> Implement the shutdown hook to ensure clean and complete deactivation of
> MACB controller. The shutdown sequence is protected with 'rtnl_lock()'
> to serialize access and prevent race conditions while detaching and
> closing the network device. This ensure a safe transition when the Kexec
> utility calls the shutdown hook, facilitating seamless loading and
> booting of a new kernel from the currently running one.
> 
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
> 
> Changes in v2:
> Update the commit description
> Update the code to call the close only when admin is up
> 
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index e1e8bd2ec155..5bb08f518d54 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5650,6 +5650,19 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static void macb_shutdown(struct platform_device *pdev)
> +{
> +	struct net_device *netdev = platform_get_drvdata(pdev);
> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +
> +	if (netif_running(netdev))
> +		dev_close(netdev);

Apart from closing the interface should we also invoke the remove?

Consider the new loaded kernel will not use this interface and some
hardware resources may remain on while not used by the newly loaded kernel.

E.g., there is this code in macb_remove():

		if (!pm_runtime_suspended(&pdev->dev)) {
			macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk,
					  bp->rx_clk, bp->tsu_clk);
			pm_runtime_set_suspended(&pdev->dev);
		}


Thank you,
Claudiu

> +
> +	rtnl_unlock();
> +}
> +
>  static const struct dev_pm_ops macb_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
>  	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
> @@ -5663,6 +5676,7 @@ static struct platform_driver macb_driver = {
>  		.of_match_table	= of_match_ptr(macb_dt_ids),
>  		.pm	= &macb_pm_ops,
>  	},
> +	.shutdown	= macb_shutdown,
>  };
>  
>  module_platform_driver(macb_driver);


