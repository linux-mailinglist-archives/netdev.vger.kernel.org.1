Return-Path: <netdev+bounces-89475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB578AA609
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBEA1F22953
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53209757F6;
	Thu, 18 Apr 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrOYcUrP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945B11CB4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713484385; cv=none; b=Ir55d071v5snTru1uZ6r/4NNKOk+kt80oS5T+qUU48lAX6tvmauCPeeEnRij88zxv83/ZGqzD5auVGJFdpdXnkxL5q0FuAnuHQk2Mx3AU25iz+WbctAqLGHbqqT+ig+S4yZZ3yD8nzEHDSPHOgNddW0Zdj4/EWnqv2Pm1KC0LXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713484385; c=relaxed/simple;
	bh=EDzBhMg3yje1/eGD1XEWICChoTbSZ81Zm8yXEhJtxxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnkP2TbOWvgj6vuuZygdhs8yZmvIxhGfvwdjWdGVoLtOhQmEijFUutnillx80Ufdj2Cr2deJ+jpkgJDSdQY8i2pv8cKSWl1rKFcZYVmPUXxYckWzyLQgSm7zfOrYTH0i/4IlKbLx3WqV0j5BnA59mBozlVbv+rVThbJhRwlGVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XrOYcUrP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e504f58230so13116615ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713484382; x=1714089182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzX9pV7TdTXrgXQbegjfNEKAsh+k3EiRMkuLKOr5KHA=;
        b=XrOYcUrP+x6nO1eZ8FWERz1skw94W/NFrPCtW4E+CSmQEs4G7LBEGZxkHrdbxiSMmW
         kBbXzt3SLvPEssXin/p6tSMoPriB79AMFJiMY9pwDYPr6cxiYReOoImSarZqmPjEq6N5
         0Z/MH4o2d0Q8rDF7cNp+cRysxLj7ty3jbIEdES/HcGO8vOte+69XGxzpgFtWpvzZdiRC
         2ZjxQ9YPotL3BvphPmgHRDtZPtrHyI7ec1WYOrIqPBr858Q0TG35ywIHtciJBzc7LWqm
         AMQy+HjpfbyjksodLcTEX52tztROd9DGl0WSSMiHPxvb8L3FMjOPOJr+T2AR0Uq7LvIn
         aUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713484382; x=1714089182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzX9pV7TdTXrgXQbegjfNEKAsh+k3EiRMkuLKOr5KHA=;
        b=DeH0wi20+x6BOkWx/vQNmuYQg47mYjiywdE9Sz2C+9SxPK0mUNTSAIlvnLa1Lld7Vg
         fQBhG1UI/IQ2UFk5yY1id8YpRG6rjfSumjE6Z0DHJJgFsxXKkSy8KmCH4/7WQL1huj+B
         jQglkJMdOMaWVquBBMjPbiM+nbK1gR95Z0ahvssmdKPc8OvqQ1EEdmSu8fb74hGo3RiH
         w/Z7zvUBtZ9gW6HDogPLLiiNOkLTuzgd8S9k88qGUI5a4nn1oseuGIBQdeK9RUrhHuvH
         ETKPlL1coqu6fr3GbVx5BVxSDN8GFaYKx8YWHQHk1Rtnn4doHAdFFFknPjfqV8p9M/4M
         x3uA==
X-Forwarded-Encrypted: i=1; AJvYcCVhs4JF1AzXgEImiwgegEQqhHx/C2keGTwZBceHHagxZeKXs6SdOlyFM6NaB0DbyR6OkuLzsUZywY3p77YRnkiObMN/VmSS
X-Gm-Message-State: AOJu0Yzk4bLjPDZxB4EXFouY9vfKcSBfUU/n+N9aNtbJy4bXL5yEgdX7
	2AoZ3USETbv/Y/0yiaaKc69VrpgG4OHp3J7tB4yTBmhiMZFR4qu910Ukj2tZ4DQ=
X-Google-Smtp-Source: AGHT+IGW0RLkSC3AZg6v7pfLU2MxaV8C6m7IOIUWMOVzP3hN/gFj68l3mm8pTK5mB7H109tSbfYIoQ==
X-Received: by 2002:a17:902:6b49:b0:1e3:f2d0:1a4d with SMTP id g9-20020a1709026b4900b001e3f2d01a4dmr601126plt.45.1713484382187;
        Thu, 18 Apr 2024 16:53:02 -0700 (PDT)
Received: from [172.20.10.110] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001e26b7d3e8dsm2087342plb.266.2024.04.18.16.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 16:53:01 -0700 (PDT)
Message-ID: <2614c8b3-ee7f-4ac0-9b43-20905759756e@linaro.org>
Date: Fri, 19 Apr 2024 00:52:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] net: ipa: maintain bitmap of suspend-enabled
 endpoints
Content-Language: en-US
To: Alex Elder <elder@linaro.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com, elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240418204729.1952353-1-elder@linaro.org>
 <20240418204729.1952353-2-elder@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240418204729.1952353-2-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 21:47, Alex Elder wrote:
> Keep track of which endpoints have the SUSPEND IPA interrupt enabled
> in a variable-length bitmap.  This will be used in the next patch to
> allow the SUSPEND interrupt type to be disabled except when needed.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   drivers/net/ipa/ipa_interrupt.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index c44ec05f71e6f..0e8d4e43275ea 100644
> --- a/drivers/net/ipa/ipa_interrupt.c
> +++ b/drivers/net/ipa/ipa_interrupt.c
> @@ -37,11 +37,13 @@
>    * @ipa:		IPA pointer
>    * @irq:		Linux IRQ number used for IPA interrupts
>    * @enabled:		Mask indicating which interrupts are enabled
> + * @suspend_enabled:	Bitmap of endpoints with the SUSPEND interrupt enabled
>    */
>   struct ipa_interrupt {
>   	struct ipa *ipa;
>   	u32 irq;
>   	u32 enabled;
> +	unsigned long *suspend_enabled;
>   };
>   
>   /* Clear the suspend interrupt for all endpoints that signaled it */
> @@ -211,6 +213,7 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
>   		val |= mask;
>   	else
>   		val &= ~mask;
> +	__change_bit(endpoint_id, interrupt->suspend_enabled);
>   
>   	iowrite32(val, ipa->reg_virt + offset);
>   }
> @@ -246,7 +249,16 @@ int ipa_interrupt_config(struct ipa *ipa)
>   
>   	interrupt->ipa = ipa;
>   
> -	/* Disable all IPA interrupt types */
> +	/* Initially all IPA interrupt types are disabled */
> +	interrupt->enabled = 0;
> +	interrupt->suspend_enabled = bitmap_zalloc(ipa->endpoint_count,
> +						   GFP_KERNEL);

why not use devm_bitmap_zalloc() instead and skip managing the cleanup ?

> +	if (!interrupt->suspend_enabled) {
> +		ret = -ENOMEM;
> +		goto err_kfree;
> +	}
> +
> +	/* Disable IPA interrupt types */
>   	reg = ipa_reg(ipa, IPA_IRQ_EN);
>   	iowrite32(0, ipa->reg_virt + reg_offset(reg));
>   
> @@ -254,7 +266,7 @@ int ipa_interrupt_config(struct ipa *ipa)
>   				   "ipa", interrupt);
>   	if (ret) {
>   		dev_err(dev, "error %d requesting \"ipa\" IRQ\n", ret);
> -		goto err_kfree;
> +		goto err_free_bitmap;
>   	}
>   
>   	ret = dev_pm_set_wake_irq(dev, irq);
> @@ -270,6 +282,8 @@ int ipa_interrupt_config(struct ipa *ipa)
>   
>   err_free_irq:
>   	free_irq(interrupt->irq, interrupt);
> +err_free_bitmap:
> +	bitmap_free(interrupt->suspend_enabled);
>   err_kfree:
>   	kfree(interrupt);

You could also use devm_kzalloc() and do away with the kfree()s you have 
here on the probe path.

>   
> @@ -286,6 +300,7 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
>   
>   	dev_pm_clear_wake_irq(dev);
>   	free_irq(interrupt->irq, interrupt);
> +	bitmap_free(interrupt->suspend_enabled);
>   }
>   
>   /* Initialize the IPA interrupt structure */

Just suggestions though.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

