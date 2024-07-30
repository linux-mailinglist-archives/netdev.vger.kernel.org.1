Return-Path: <netdev+bounces-114228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C197F94192A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458F21F22F7D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C018455C;
	Tue, 30 Jul 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="URAzUQcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C71A619E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356981; cv=none; b=W1mAERUpSWZNmZz5kpHXgNpA2F0EApgmMrKtGyEMyxGJ6bkUI62ajXWnKTjbF+zSvRQVEQTYyp4djllF7AJ8n+aPw+45zHhIr90A7rg8J1AOPd5F/rCWLiHPEfuUVGUi/Kt2PbC8UN2NYJz1Sf9Fumi47R/zINmj0R7FyfZv2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356981; c=relaxed/simple;
	bh=OWoGdwhwYZW5tY59QsQSyPvrPY75gV1c7fzfG1/iMv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OlY4emb593FW5qk70GIbOwJlU9i0JSJVkbdLzvXTbPBUqVcbtGLQBkXsAM+AIqjt4mqDceBPIbFrU2FusfXg24zB9G/5aUBTxG+5Np2q11Xl9hH/NwlPDwRVPRNRwdSeeUuMaMTjJp+jMcu3wzyhfulNNQeN7ugEJyj+QQ/Z42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=URAzUQcM; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3993c6dd822so17992505ab.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1722356978; x=1722961778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqTqk5AYvzMGB0HtIG2FuLVHpIAW43yrLDffT8nbEjA=;
        b=URAzUQcMBZE7eu1MvvHc6EsvbX1Iv1oGpeJ2v8tpVYMANc0Mip4PqOswWctQMcpL48
         vcTPL/6z33qM6tJoM+AHcOU2Vqdk7Z5R7992lrYtR46UxFRgcJGUJaba71kpdAwo+sKc
         1nYAd2LZ0Ep+KOljJKsPChVEVtpHsndvKAmKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356978; x=1722961778;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqTqk5AYvzMGB0HtIG2FuLVHpIAW43yrLDffT8nbEjA=;
        b=mhIAvEsyE39DpDP5q+5EadEqCjOGlMcY1FJbJ45pS6w9f3kLIQgg7gnbWZj8IXe99S
         qhM5/IiqLZD1ocNHpCaLQwogb1xK9ggfpqWwhuGB7byRoyYaNpTNB3J+wpbLlNSqniYC
         dG4UpnTnBtzD94mxUo/j8f848GvznmVSlEhoymhIwBoIXBfyoc+C/fq7yFmV53Hwpc10
         5Qyim1dgfRlmZmIKQsDcqVXLvaNGlTA+Ip2y247AxeOUuglwjx7k/ot6qC3WNkjnfsKY
         N0b41ueomFh6R1/0f5rj3cQNWX2LD8d+tHjNGhWyN2VNwG2K7Uv9wUDqyEgwAwJLuNEU
         2L/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp3a/VqzR3/zcRcBWsxQJ3QZoNb6pCI2jIZjDVPnnm9Q67cIkpcHp3Fx4NzgplTXpCLHpbgeyQ1WPP0FgUXxFkM1x6LfQ6
X-Gm-Message-State: AOJu0YwySs5P6Uo1XCy0HHTqJ+v0hhMtkRkXmAk/4WCwU6u4UitQBby5
	UcJwLel53pRgU6qHxSSaY+K8weUYmeKhtT5T1/QyBQdIbaxKzKT2RFcLUSGQ6g==
X-Google-Smtp-Source: AGHT+IFlSlLAVsqGKByHNiTQAtcMhfy7nQe5qrcqVBYZdOj+zvzXelBObOYgl7N2haohCixMcpBCNQ==
X-Received: by 2002:a92:cdac:0:b0:375:8b0e:4434 with SMTP id e9e14a558f8ab-39aec2eda9cmr117641025ab.16.1722356978241;
        Tue, 30 Jul 2024 09:29:38 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-39af2425345sm27113615ab.75.2024.07.30.09.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:29:37 -0700 (PDT)
Message-ID: <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
Date: Tue, 30 Jul 2024 11:29:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to
 "maintained"
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 5:40 AM, Krzysztof Kozlowski wrote:
> To the best of my knowledge, Alex Elder is not being paid to support
> Qualcomm IPA networking drivers, so drop the status from "supported" to
> "maintained".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I hadn't thought much about the distinction, and it might not
make a lot of difference right now.  But it's true I'm not
being *paid* to maintain the IPA driver (but will continue).

Acked-by: Alex Elder <elder@kernel.org>


> ---
> 
> ... or maybe this should be Odd Fixes?
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43e7668aacb0..f1c80c9fc213 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18452,7 +18452,7 @@ F:	drivers/usb/misc/qcom_eud.c
>   QCOM IPA DRIVER
>   M:	Alex Elder <elder@kernel.org>
>   L:	netdev@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>   F:	drivers/net/ipa/
>   
>   QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT


