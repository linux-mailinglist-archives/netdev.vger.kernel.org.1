Return-Path: <netdev+bounces-216560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30573B3483B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95BA3B301E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA555301017;
	Mon, 25 Aug 2025 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Aj9PipZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796126A0F8
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141716; cv=none; b=kxhFz6Td4bGmwT7xeDBV11BCnfPe1VzK2X1r1u9h/7r97RJsTPqUXsedntXUmjMtUTn3ba/0yE6YfbvGd6h3BJlk30Xa9fSA5FF2WAsovtbVD45GTFKdVr8WnMre0KWWTJB6t6MwCNxg6SOHAqc08N4OeH6tp4343dAdCgRxrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141716; c=relaxed/simple;
	bh=96EhrU7mBWPOOGgnPers3hMdXLya4Uf6CGl8BnpedR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAIVidfUDwR+FaOPK5DEmDq6qoF4Z/ApefoaYyoLBRFhG22V9iX/iCZoGjRatpPCJ0ErL5HsYaTJ7e6oQMr6lKail5s/MWJKOTIs+dgn5p5jgk2BEhw5AxdRKt8cmDbVkDz34OBcbtj3I++9besoUOsbrlHbMIhuY6V7z3OvLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Aj9PipZN; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-52252e9e907so294109137.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141714; x=1756746514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1OkKoFIZDmEc1p3CKBZkkR1VvuCl//7dh2s4eHyiiw=;
        b=MwHWw7BeXmmg20FBTszejN3y/Y3vBTrbTYrwOewIGcR+3J67eUE+IH36cfmkFNdD9w
         xXQcoZJGxVmJ7caw6QYf+V/HMZuPgFmVzftvZKYTHZ88GE6DPW9sIESzzIhe8jT/LbqQ
         0vTlZPVABaWj9OnrafUfjEz71t0ZCc34Sp89It9OZ67fNMob+2klieDGrz62eziMFR4W
         trN5ePjz9Af1T2XeNmHOsw5g9T6GCYr0unFAABPdbWthDAD602gLP7GXlhvr1WLmm9aW
         eHrozTr2QuZE2Sm7P/p2GGtCJV+ykh54DB0zQw/5plurAgb22vpTb2QU60mmeF86jhqP
         XbFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJBMzg98zKM2nrpHHr+azbCtl6rLRqIka8rHdrrPd49Z7GOpuZVqPs7FoFajMgq44nmJAKB5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj4ltxxEHLUvZ6/xWn5ZI0CXOD27cRjUOGZ+OHQBPddiQ3kDo
	GOUux8/HlHK71hTbygsRREcSylSWg1uePDyZm+dswN4OGmNWcjTvkMu0EqHU5hi8pHugmXP0k65
	1YBAI/j8fEKZFFSeqI6bbmj/yrsUoeJuHm/h3VoFKjzLRs8qqR9QCjoCPsaMNGq0r3OdhGCixFR
	hQf82kcNNuA9xYQwAXfyrqZOu+EZK++QrJf67o6YpLdPx66nqXQuzs9lq1RWrPlfos4swrO+PJL
	1Sr9nWiFMhi7bd+
X-Gm-Gg: ASbGnct5GDbTbqwOePBSy0D/E2pHZqMrJaz+g452KIuOjwBwYcF7xjf9KfjsD6Fr9gO
	6/36hWjvxDMnzWuFfjN3C4WnvivRPM7eSuwNAPKQgGMBVx4TWehrgJ0jKm2e1clen62Dan6TTLW
	nGFaFlXOKRT3VP9eVhyiP0/O/c/i8mkld5zDGpCmm6uqCV1AMuevWE+cMsZ0cukBj44Kbq8iK98
	moKsaBOMDpXgRiMMcbyvPCqBjvoz4wvAAahvib/OxW8DjVH6HhR4xwQ1di5M+J6ENASGd+62QMj
	sQx55LESr8CU2qp9g3gtJ6bh8rHsuQ19KfPR/dxXbXsROp6TNMWVNDtmqDUdBdycf2HEvJhZoKU
	GrEc8hNXyin2ApJYpZuW55ZqhT08UuNqBa2uIrzn0zvXWlE5aaqDO4sH1J0Dw2F78BfOigWawHW
	IFWY1I
X-Google-Smtp-Source: AGHT+IEVfTfwzSjm6BxxHRCFWxrsgt4Nu9yDSPS/i3Q3qSkwJEU2GH83TPxAboTIfrgMQvunllAJW1Kp7bP5
X-Received: by 2002:a05:6102:4247:b0:4e6:ddd0:96ff with SMTP id ada2fe7eead31-51d0edcbb3bmr3839782137.16.1756141713737;
        Mon, 25 Aug 2025 10:08:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-892373232e8sm214389241.3.2025.08.25.10.08.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 10:08:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d9a65c170so70067826d6.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756141712; x=1756746512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1OkKoFIZDmEc1p3CKBZkkR1VvuCl//7dh2s4eHyiiw=;
        b=Aj9PipZNM0rm8JNzVLhgI3dHaKA0QpgMaSpZHfCMHfzuQlU6zrKApDuH02/n6FCdRQ
         Bt66bm0/H6f9kEdT+3KEMi2lIUOdwFNzE4/7E2712N+yXMvURHuSwjNQ5cxcVnYtxQqv
         DgzKu8iKBd/tYyCvbX7QkrvuPX7SaQ4Uga8HI=
X-Forwarded-Encrypted: i=1; AJvYcCXvbcQU3YMXAUR9E9s6/RnA7zq9R3dUfmNBrfFobMsMF96VfohB2k+ZdT7qh2d+t2qV/4ojDu4=@vger.kernel.org
X-Received: by 2002:a05:6214:19e7:b0:70d:b1ea:25ed with SMTP id 6a1803df08f44-70db1ea286fmr97989536d6.23.1756141712144;
        Mon, 25 Aug 2025 10:08:32 -0700 (PDT)
X-Received: by 2002:a05:6214:19e7:b0:70d:b1ea:25ed with SMTP id 6a1803df08f44-70db1ea286fmr97989006d6.23.1756141711715;
        Mon, 25 Aug 2025 10:08:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dc09b892asm22575876d6.50.2025.08.25.10.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 10:08:30 -0700 (PDT)
Message-ID: <77d8a847-424e-4757-a703-709b6042236b@broadcom.com>
Date: Mon, 25 Aug 2025 10:08:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: macb: Disable clocks once
To: Sean Anderson <sean.anderson@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
 Neil Mandir <neil.mandir@seco.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20250825165925.679275-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250825165925.679275-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/25/25 09:59, Sean Anderson wrote:
> From: Neil Mandir <neil.mandir@seco.com>
> 
> When the driver is removed the clocks are twice: once by the driver and a
> second time by runtime pm. Remove the redundant clock disabling. Disable
> wakeup so all the clocks are disabled. Always suspend the device as we
> always set it active in probe.

There is a missing word in that first sentence which I assume is "disabled".

> 
> Fixes: d54f89af6cc4 ("net: macb: Add pm runtime support")
> Signed-off-by: Neil Mandir <neil.mandir@seco.com>
> Co-developed-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce95fad8cedd..8e9bfd0f040d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5403,14 +5403,11 @@ static void macb_remove(struct platform_device *pdev)
>   		mdiobus_free(bp->mii_bus);
>   
>   		unregister_netdev(dev);
> +		device_set_wakeup_enable(&bp->pdev->dev, 0);
>   		cancel_work_sync(&bp->hresp_err_bh_work);
>   		pm_runtime_disable(&pdev->dev);
>   		pm_runtime_dont_use_autosuspend(&pdev->dev);
> -		if (!pm_runtime_suspended(&pdev->dev)) {
> -			macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk,
> -					  bp->rx_clk, bp->tsu_clk);
> -			pm_runtime_set_suspended(&pdev->dev);
> -		}
> +		pm_runtime_set_suspended(&pdev->dev);
>   		phylink_destroy(bp->phylink);
>   		free_netdev(dev);
>   	}

-- 
Florian


