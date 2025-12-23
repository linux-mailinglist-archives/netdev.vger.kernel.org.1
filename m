Return-Path: <netdev+bounces-245837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA4CD8F9C
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C2DF3009C02
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAC30AAA6;
	Tue, 23 Dec 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLcCf/CJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjQ8ltHO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D222C028B
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487305; cv=none; b=SymqPD0FXqR2om/ITymy/D6kXs2YVar5i2GTCspPZJso2H5oT4ImqEsnXUShgITOM7SuBeKI1PQPse7U/BhxvtzEynFDY8iSD6bFrZJ74pyf20CVgG+fAr76lBu/MVjZyNpiJu3ZPfoSBNy4oaI8Q9JpaMS0Svv/tEt5yc/rf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487305; c=relaxed/simple;
	bh=2KZ/oiMjj087n2gLvlATOIeAFN5Upu/8jYwP5FZ0tMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1xulAwk4RUSfkm1FkOL1nRuuC1Ty8WsoeKnfrxbrlwwy3WcAlBHyZQifzuBb9sRyNj9n1WySFQj7FxMjMLWplYgdnkK5fwhQwxGqjb1sGjWNqMfQnBwcwl5oBoSxpB/OH7NuhYx4GYoKZk89F6oBCDiz1GS4bRsv+EwCPdiA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLcCf/CJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjQ8ltHO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766487302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sYwZ6PZ24k47siPq31g866A7i3bVoXpTNTMANfxwr0=;
	b=NLcCf/CJbrwbwvfOtezJ3xT7VmU4WIMiLwH4NI6nyrFPUV48BRwomEHEkZCRSqO1JG7C25
	Gt4RBpCrTswj3/7k+VdNJVuUIk5FIPwCa6K7E+W+9uSRZ8EkhROFvcA2eWGYLI5hDCTIKY
	jRGDjRlOkHqtozaRGas7yfycODbLC8o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-6y4P2xq6Nzyg243pcQuNRA-1; Tue, 23 Dec 2025 05:55:01 -0500
X-MC-Unique: 6y4P2xq6Nzyg243pcQuNRA-1
X-Mimecast-MFC-AGG-ID: 6y4P2xq6Nzyg243pcQuNRA_1766487300
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso48451015e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766487300; x=1767092100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sYwZ6PZ24k47siPq31g866A7i3bVoXpTNTMANfxwr0=;
        b=LjQ8ltHOP05/pak22X0kbypP3MA+ao5FvbP0mRsEbqN+0G55UnlV9EF4uwTKquKxNK
         KP8PMhFZtJkUQpB2Wu3R7KsMuq+tv8j2eg/Bj+3WrA3Fg4Ux2Jebr7KUPVZWWWhgfJbQ
         EaA7ZCR3VEvp3zZBWlf2lvsr6z6BfZtHF+KRMU2ZCdAjqXldvDJ5jlXAMXC29ORI5Q6s
         3plq2uoVN3AqHjNdxzFJwP3zBMkQbdRyQjzTTd/UF/eZIbxKmiSl0TCEqvio4CPJN3lQ
         vgkgvzsuMJsHhydUj9txTevtRFUfzHnBbSm2VklsCpJ1t1dwH/QRtjgsxS6mUEIlrWf/
         pUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487300; x=1767092100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sYwZ6PZ24k47siPq31g866A7i3bVoXpTNTMANfxwr0=;
        b=e0AmP1p6RuCEaGNaW5gVadXMYGJY4eeHuWIuAPLT3y4SQgDk6BVwue1qVZhiLMmP8Q
         jcqhKnHMNqs7or4SWHFHopP9ryoXG1+z1xBgEQNiRDdYVdDjxmqr/P9vFkTAOIGxoMWi
         a6/p9DErORnwIAXtuasEyGPuYhUiv5zgnZwEVjlCV9UC8Uhk5Ecn9eP9rB25a7dMv0Gz
         72cNSmlItwUdXh9ygk5VDVbtxmrBwl31Kax8z7zUOFicqugI4znPkoZH5R61g4JfKeyK
         lSg/Toe1T/FkHfE6MR1QhDe6PvL/bHpeGk/9F7pDZMIvpwskW+qJVjD7PxKkC2fymdD1
         EudA==
X-Forwarded-Encrypted: i=1; AJvYcCXRwYS6rk5wRPi2rYoLEabKebJV4oZDHBqybPCsiFQ/4y7cuZtyY/pE0VdmY/hVtPj9Z3mlrJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxow8Iky+TWJGc5KFTg/Y5UvFhI1srB/sYCYkAsROrdWFgsUqVU
	4b7U3nCKdlvNxIQLb+t9rfU9zjeqf4S924TCNO6DdE+O+Y1Z4VeOBXwdWzmZpTNWcjrnJkYNgOG
	CH8Ityn7cv99TtIRGROBVAhf8nXWHqe4g9xyXu+vI8mq8+clZsB2l58zOHxObdvbhxQ==
X-Gm-Gg: AY/fxX7IUDxFDEywYb/l8OocdIJ5XkEELdKGMB1BT/GNTxOyXSOMcNAUCelko8hksCU
	BZDhGVmfqIGhWUhso0WVLlMgrBCsY2c7+ClxpYj87T1i68S68O2HcwtCR+IzkPW7EEQkcuHSgKA
	rlLi0AyqNArBf3KbsDM68bg/2DfV/HL2SN5I57N0lT+xBxfvKwbJ2K4Djefw7h51sc5c+K01Xi7
	OXZ9gV956of622Yum8iChdUrta+cmIbMsklKeHcEtesn8EQQSSSzdMFhCeOk9LXPSsoXLPyp151
	CVZ0iBnaDSnpcW6XJnXXI0xZ3wuYs8XZeRc/NTwWdgNywhN1N2z2rY5LlI+ezcYwoevr4h7NyVi
	N8KIuEQ95WCXL
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d18be144fmr126363315e9.14.1766487299841;
        Tue, 23 Dec 2025 02:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9e28h+sgc6tHR2qqTwofz+8iEUvk7r5sbq7P4CgDGskq+0oixw93Ki3WhWVAY+A/C17FpkA==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d18be144fmr126363145e9.14.1766487299482;
        Tue, 23 Dec 2025 02:54:59 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm27316641f8f.20.2025.12.23.02.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:54:59 -0800 (PST)
Message-ID: <eae60389-27a5-4e8f-af49-7f75d4c116d8@redhat.com>
Date: Tue, 23 Dec 2025 11:54:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdev: increment TSO only if TSO is not enabled on
 any slave device
To: Di Zhu <zhud@hygon.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: lijing@hygon.cn, yingzhiwei@hygon.cn
References: <20251216085210.132387-1-zhud@hygon.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216085210.132387-1-zhud@hygon.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 9:52 AM, Di Zhu wrote:
> Unconditionally increment the TSO flag has a side effect: it will also

This changelog is IMHO quite confusing. The code does not 'increment
TSO'. Instead it increments the features set to include ALL_TSO.

Please reword the changelog accordingly.

> directly clear the flags in NETIF_F_ALL_FOR_ALL on the master device,
> which can cause issues such as the inability to enable the nocache copy
> feature on the bonding network card.

bonding network card -> bonding driver.

> So, when at least one slave device's TSO is enabled, there is no need to
> explicitly increment the TSO flag to the master device.
> 
> Fixes: b0ce3508b25e ("bonding: allow TSO being set on bonding master")
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
>  include/linux/netdevice.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index bf99fe8622da..2aca39f7f9e1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5322,7 +5322,8 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
>  static inline netdev_features_t netdev_add_tso_features(netdev_features_t features,
>  							netdev_features_t mask)
>  {
> -	return netdev_increment_features(features, NETIF_F_ALL_TSO, mask);
> +	return (features & NETIF_F_ALL_TSO) ? features :
> +		netdev_increment_features(features, NETIF_F_ALL_TSO, mask);

NETIF_F_ALL_TSO is not a single bit, but a (later large) bit mask; the
above will yield incorrect result when:

	features & NETIF_F_ALL_TSO != NETIF_F_ALL_TSO

/P


