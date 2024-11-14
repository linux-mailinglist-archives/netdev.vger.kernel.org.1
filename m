Return-Path: <netdev+bounces-145023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528D9C91EB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FB3282C44
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B517A583;
	Thu, 14 Nov 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG3ZCKWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD473199E8D
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610432; cv=none; b=pg13HooRepBPQ9bI/7UmPp55RAYubLaZDS3asF9Jukw4su231MduTuyvUNb5m98ehiUmw/cSoNOzqTOjOgprDQMFmHSX41oZ2GTgH3xfQ80v8oL3AOMqoXYI9srYR2xKZ3vIy2BizS+i4TnEMHpaTFmsZv28qYoC6/E/1iZS5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610432; c=relaxed/simple;
	bh=4sESwwmOqkCWvHw+pndneTQ0omPnAfbeq93SPPpDLm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8KG2JsK2id1wcBZyNRxCQTuNPl8zcJu/QiVwMNZcDWg5JegR8meN4imDfxJi5PLjCkuUHZZhire3RXf0+NJwUaDaecOZfW0mFgLLB+hqjwfmwDmHwssRuNAguHNYKRqKpeTWPXABO9RkG/LF+3i4cu0zUjIOHmMTUQ2Qffysvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG3ZCKWH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43158625112so9038325e9.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731610429; x=1732215229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+act8H8vBI0kssh+d2SqywPLeFhuuqkPtiKdY3nWas=;
        b=nG3ZCKWHSw2CIKDmGP9nPYG+NoIkZ6yFWgk3eOWrCd0SVk8HMZv8ZDyDM0puZzRunM
         CEMiOn6CJukA+8Bo3z3dSn967mKH8YWWSLZQhpWjEKlBnxTRXq5TeTwGI0UO5474mNec
         DQP5GGvrfC7m84XG/MZgXw1wNdzKz+SWpBXplU1nAz3vQghyOVyK+Y/vugmEQlDlag0/
         BFjL1im+3hlfqd0PwRH+lFy/gAI64RK46zxw/sqXnh1YCyRLgBZEENK8MFJbcj0VA5bb
         CKqh3Tw/Sm3vJeV5EIMGFr+yqZXwhVA9IXv1A7YWDCtAICTEA+HX2U9XjOiKJiqWA4AI
         fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731610429; x=1732215229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+act8H8vBI0kssh+d2SqywPLeFhuuqkPtiKdY3nWas=;
        b=dGymplr4R3OL6CfZNed3B2THzP7u6cRouDMkfEEybN8N8euENbVhFwHcx1Jil3SLql
         3FgOtCvC+Pk2pDG9JDUtjx/JnkiysLmxDFRpzAYOEZ4t7OdI95Y1R37lb7FxlSZdi7nC
         wFLlqww2xPehPNPogoxTmvWXgs7SdBBSWuoGdbAQ+GNiL2Fn15XbCaB4ycei8JZcHEIC
         /J6hRsKQ2FIDH0NTCIq2fDTpf44cJrD9y+59TMaSDsbkSo+xUVrionESHgZkvD421tM6
         82oyQs/wbvFDhMqgKS6Cysm2vzKIM4VC2sbkW9vKJ850QQJiTmabn/A2DRUBoc7HXRHy
         MZmg==
X-Gm-Message-State: AOJu0Ywbhmp5+/YblEZ8rcvdXdXu/LC88GXDdEMKF2GTs3ao1IsS0U0L
	mYVge4093tK/JCjDU5VSUbqAaeEZXeB3S/ZY2SPhpZBcBe13yFOJ
X-Google-Smtp-Source: AGHT+IELUfVKeMhRwtzYKmzZRv1LYcmCpcb3hbTxVOGXrsYtHnsfVttlc2lV8lA+TvnfMtpATpXodQ==
X-Received: by 2002:a05:6000:1785:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-3821851c6a4mr2752224f8f.26.1731610428830;
        Thu, 14 Nov 2024 10:53:48 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbc44sm2208283f8f.45.2024.11.14.10.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:53:48 -0800 (PST)
Message-ID: <6835fde6-0863-49e8-90e8-be88e86ef346@gmail.com>
Date: Thu, 14 Nov 2024 20:54:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com
References: <20241114102002.481081-1-wojackbb@gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241114102002.481081-1-wojackbb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Jack,

On 14.11.2024 12:20, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of t7XX,
> change auto suspend time to 5000.
> 
> The Tests uses a script to loop through the power_state
> of t7XX.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> * If Auto suspend is 20 seconds,
>    test script show power_state have 0~5% of the time was in D3 state
>    when host don't have data packet transmission.
> 
> * Changed auto suspend time to 5 seconds,
>    test script show power_state have 50%~80% of the time was in D3 state
>    when host don't have data packet transmission.
> 
> We tested Fibocom FM350 and our products using the t7xx and they all
> benefited from this.

Possible negative outcomes for data transmission still need 
clarification. Let me repeat it here.

On 06.11.2024 13:10, 吳逼逼 wrote:
> Receiving or sending data will cause PCIE to change D3 Cold to D0 state.

Am I understand it correctly that receiving IP packets on downlink will 
cause PCIe link re-activation?


I am concerned about a TCP connection that can be idle for a long period 
of time. For example, an established SSH connection can stay idle for 
minutes. If I connected to a server and execute something like this:

user@host$ sleep 20 && echo "Done"

Will I eventually see the "Done" message or will the autosuspended modem 
effectively block any incoming traffic? And how long does it take for 
the modem to wake up and deliver a downlink packet to the host? Have you 
measured StDev change?

> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> ---
> V2:
>   * supplementary commit information
> ---
> ---
>   drivers/net/wwan/t7xx/t7xx_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index e556e5bd49ab..dcadd615a025 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -48,7 +48,7 @@
>   #define T7XX_INIT_TIMEOUT		20
>   #define PM_SLEEP_DIS_TIMEOUT_MS		20
>   #define PM_ACK_TIMEOUT_MS		1500
> -#define PM_AUTOSUSPEND_MS		20000
> +#define PM_AUTOSUSPEND_MS		5000
>   #define PM_RESOURCE_POLL_TIMEOUT_US	10000
>   #define PM_RESOURCE_POLL_STEP_US	100
>   


