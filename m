Return-Path: <netdev+bounces-210286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40ABB12A6E
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2604540F78
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CA24500A;
	Sat, 26 Jul 2025 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ci45f1C4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD323D28F
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532624; cv=none; b=L2VBSDYoKI2+jTc2TKuhseRUMSnyLuUsuJH0dzitqg0YORy6pGxtZe3Fqx4W/vagTKvQEs+gmKeb20hGbjQ8IAsX6UZXPf/UoD9+ywcjKkPVBAIoxCLZJp7uIvkUuo0/8d7XmG1t2iPriifdIOG0VQ2M+8uLObqn/xIT4TjNHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532624; c=relaxed/simple;
	bh=K+ZyX4NZ9Y0Bd+OP7PaApm7Ot4JhXOd39MayyruHhbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LA8Jkvjp5mFXS/RlujxQv4TKOVkzAJkiJzbnBDBGcv/bksADkaud6ohG75/ItbT+ZPxt5BHRElmgLhQO2/V32fhIU5s6pm1mF75R1DKieRIfbhTEW6ANfnoFrLV2OXYVcdywSwKWxSZp6acDkpqje+NGHrW3oP8P84kwT/No81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ci45f1C4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d54214adso19497925e9.3
        for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753532619; x=1754137419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QAlqHI6bjxX+3N3V2BeEfRbS0GkoEtbk8LjkTExiq0=;
        b=Ci45f1C4egBfQpe5fkuR2UtnpuEh6BMclCjM+ZK1WrBtzIuQpVTs8nehUz674pxMQW
         PnFQ5CeWzaqQYReFir7uO+Jh1yKn4FQqknPcD93S6xLEU5hnKny1IQOPZ48S+2nyi8VH
         +7goAloUHDFobuXuqg0nltHDFm1CatQ809EbHvcdqTrzza9Dx/0OjxE1nRpDoKpYSauW
         +gbJWnwsrLEQJASrZZwCZk80aYzq1F1Ot8d+S97fVVg3yAq9slacTXXMXPKSbhF2bly6
         gUsDb/ltISvYp7PPSnJZnRBDTHPcByLxizqW9KtXezrdfwmBsKnMoNfX+Pua1UeXikA6
         cxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753532619; x=1754137419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QAlqHI6bjxX+3N3V2BeEfRbS0GkoEtbk8LjkTExiq0=;
        b=wbZcYrkJIUCATj3nPCn5jLN6vgqK3AxEebjZbepCzkbc+NJhVWmTM94I/JWBiSICsa
         KhWC0eMoEn2/351K+dqou48qy94wGJekWmgUNvHnTJKuHsLHmg8wOOweQhQsHMAoKsMD
         7dS1L+ep/P+ekFchUU+Q1iY7JI5sRNgHlbMHqCi0ZRTI60GgI7xE0eSHk4qJgZlOENVY
         G08rWpdeFskjZ8sFn+swSTLQ6w8qq36Lc1Ww+EYZn9F8IU+e5lIxR8CTTkBrwvmfT507
         yS1secsWM4w9EE7ITeNLscVN8jyYauHtumEPQaMUprOnw2j2Lfe8ZKXHJ/Zs3R7GIb1/
         nAeA==
X-Forwarded-Encrypted: i=1; AJvYcCW39aJ1BWi65d4c215QvTeX074d1ktKZvrnj41par1EluboBWRMPUaKV49qOmbDz9zc98bPAjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfzY+GPsMRBseA0xSXufwNZxSP7biciEPu89oF6YQgCtf+/a/W
	iwpnWSC8eNRaKYi5LiujdRkZSOJPDqKZw0aA1GXtdAYIwrPBZtmTq5lDhcpFl4uJvwA=
X-Gm-Gg: ASbGnctsHflui8spKSB8YIZt0Am2m10X6VaXiL4SLQUtB48Ly1MnqvxSA3AxKceke9B
	kNuGrGMLKEgv6Ic0RUFF0NmIBI1vSw6tmwdzztG1BJtupJ8hBKXW5RK0fCTsoRgliEIYll9yxr7
	Q6ehgo3zDhbtwIMuMTNKv323JJ6rAVlDau9AVlt316ywxhR7SxGnAe/F8GHdcrNnhdfkAo9fPFe
	MyA4mtMDHTXH2ZakstqGVRppab80Yo9SsrmNImARXEiwbiDq7uHT9Tp9aaSy+Zj2qDGO66OPj1r
	NEAuFnr7k/zGTBqaJOXcwar2/KOx4Ciu87dgpETfadMMge55em8MLH8QFARSD4J4vDJssOvVJHj
	Nf9RZOQYutQ3fFVdMpfJgu/w5cDfA1KU=
X-Google-Smtp-Source: AGHT+IEpTYqGMWDsgiNa0lxYUQVUOPKetW/12njdwFNnNVm1xWaLJxKNd5NG2QSocZRXj3BKEidqQw==
X-Received: by 2002:a05:600c:35c3:b0:456:2020:166a with SMTP id 5b1f17b1804b1-45879bf0bb0mr26655315e9.20.1753532619152;
        Sat, 26 Jul 2025 05:23:39 -0700 (PDT)
Received: from [10.181.147.246] ([82.79.79.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054ef47sm84962135e9.8.2025.07.26.05.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:23:38 -0700 (PDT)
Message-ID: <1fd25ba2-578c-46f2-acf2-903ae5d9e8bf@tuxon.dev>
Date: Sat, 26 Jul 2025 15:23:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: macb: Define ENST hardware registers
 for time-aware scheduling
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-2-vineeth.karumanchi@amd.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <20250722154111.1871292-2-vineeth.karumanchi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Vineeth,

On 7/22/25 18:41, Vineeth Karumanchi wrote:
> Add ENST (Enhanced Network Scheduling and Timing) register definitions
> to support IEEE 802.1Qbv time-gated transmission.
> 
> Register architecture:
> - Per-queue timing registers: ENST_START_TIME, ENST_ON_TIME, ENST_OFF_TIME
> - Centralized control of the ENST_CONTROL register for enabling or
>    disabling queue gates.
> - Time intervals programmed in hardware byte units
> - Hardware-level queue scheduling infrastructure.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>   drivers/net/ethernet/cadence/macb.h | 43 +++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index c9a5c8beb2fa..e456ac65d6c6 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -184,6 +184,13 @@
>   #define GEM_DCFG8		0x029C /* Design Config 8 */
>   #define GEM_DCFG10		0x02A4 /* Design Config 10 */
>   #define GEM_DCFG12		0x02AC /* Design Config 12 */
> +#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
> +#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
> +#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
> +#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
> +#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
> +#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
> +#define GEM_ENST_CONTROL	0x0880 /* ENST control register */
>   #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
>   #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
>   
> @@ -221,6 +228,15 @@
>   #define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
>   #define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
>   
> +#define GEM_ENST_START_TIME(hw_q)	(0x0800 + ((hw_q) << 2))
> +#define GEM_ENST_ON_TIME(hw_q)		(0x0820 + ((hw_q) << 2))
> +#define GEM_ENST_OFF_TIME(hw_q)		(0x0840 + ((hw_q) << 2))
> +
> +/*  Bitfields in ENST_CONTROL. */
> +#define GEM_ENST_DISABLE_QUEUE(hw_q)	BIT((hw_q) + 16) /* q0 disable is 16'b */
> +#define GEM_ENST_DISABLE_QUEUE_OFFSET	16
> +#define GEM_ENST_ENABLE_QUEUE(hw_q)		BIT(hw_q) /* q0 enable is 0'b */

There is an extra tab here ------------^

> +
>   /* Bitfields in NCR */
>   #define MACB_LB_OFFSET		0 /* reserved */
>   #define MACB_LB_SIZE		1
> @@ -554,6 +570,33 @@
>   #define GEM_HIGH_SPEED_OFFSET			26
>   #define GEM_HIGH_SPEED_SIZE			1
>   
> +/* Bitfields in ENST_START_TIME_Q0, Q1. */
> +#define GEM_START_TIME_SEC_OFFSET		30
> +#define GEM_START_TIME_SEC_SIZE			2
> +#define GEM_START_TIME_NSEC_OFFSET		0
> +#define GEM_START_TIME_NSEC_SIZE		30
> +
> +/* Bitfields in ENST_ON_TIME_Q0, Q1. */
> +#define GEM_ON_TIME_OFFSET			0
> +#define GEM_ON_TIME_SIZE			17
> +
> +/* Bitfields in ENST_OFF_TIME_Q0, Q1. */
> +#define GEM_OFF_TIME_OFFSET			0
> +#define GEM_OFF_TIME_SIZE			17
> +
> +/* Hardware ENST timing registers granularity */
> +#define ENST_TIME_GRANULARITY_NS 8
> +
> +/* Bitfields in ENST_CONTROL. */
> +#define GEM_DISABLE_Q1_OFFSET			17
> +#define GEM_DISABLE_Q1_SIZE			1
> +#define GEM_DISABLE_Q0_OFFSET			16
> +#define GEM_DISABLE_Q0_SIZE			1
> +#define GEM_ENABLE_Q1_OFFSET			1
> +#define GEM_ENABLE_Q1_SIZE			1
> +#define GEM_ENABLE_Q0_OFFSET			0
> +#define GEM_ENABLE_Q0_SIZE			1
> +

Please introduce these defines along with the code that uses it. This way it is 
simpler to follow what is actually used.

Thank you,
Claudiu

>   /* Bitfields in USX_CONTROL. */
>   #define GEM_USX_CTRL_SPEED_OFFSET		14
>   #define GEM_USX_CTRL_SPEED_SIZE			3


