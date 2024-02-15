Return-Path: <netdev+bounces-71982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5B855F08
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875801C20A75
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA165BBB;
	Thu, 15 Feb 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Satc0Gr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807D69D03
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992402; cv=none; b=gqlZvIKKZwnxLucRisxCCSPHeztUUBv5q/NA+Lw79Y07ZahHdEsybD+lzuK7KNhwaX9O12QN3dvnz0WTszcanniDrIBjU9A8tnCS304u9cc3RxJ4kCYd2y/0DgjU7tmJEMAFdVbhzbgLNf80kA5WcGXyXylaXncdiAvgcnAUAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992402; c=relaxed/simple;
	bh=6T+B23RM48DgKeyvyI3A1orWH9VcY1C1hi6ykGKmpV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpW1xRKJ8o7cHjlsGXYXGp/3fVVG9QtscIYWGfu0A0rmSkAASfSpKgywwe1R/7bQn71pmuSBlhRmdpcGwh+VhpblMq+wd/tJeT58Vo/PnK8fQtxSNw/WAPfMGobYDbEgT1H2PS2nfsFSOjTFMEg5XlOXKi/s9BlKW9wOvGFHuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Satc0Gr7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-411e71d8a2bso4986855e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 02:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707992399; x=1708597199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3f0rb4C5lvPslwqInmE+iQAff85wgbT5AhACglF67s=;
        b=Satc0Gr7dlkIf4mTMylvPBzcysXP5Y0We7A2r+7GRPVKq0ypgv6NB+ymw81vh29Nf+
         5B+1Q+sQz/8x+cUC1zc2ul+wcXyWcWqKva7+TEAE5A2q24sAixzu0aRMUsFAqNFwLuDr
         VmIrEYo1uh0aAZRqDThQCrbb/KdDQsRjVONkpmnnct1cWsyeJHxhXlydF1DQdS0q5/eG
         OuxvAfva4GXpcHJxtpd+b1NQVUwXaOmnWDuVWwDXW77oupIbE835nIJVh7EAeaXM2q9o
         k0ysVx+jBM2BvslKpXrg9vtE4Wp6rS3cHpUntG230L34nIJ8WwCJaNAApMQYeV0+b53k
         N/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992399; x=1708597199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3f0rb4C5lvPslwqInmE+iQAff85wgbT5AhACglF67s=;
        b=onTxTTB8CXHTiooVCC9fTWocv0Y/HUfAJ+mWnH2d+RekIpfMPXVFbm1XC+n3PjwfN1
         10XfXLdVOF4GzRBoI46Cj4gj3b70WtQ4gy/2rXzQeW7ZDJEv63EaTX1xc1bG8MRv2oaO
         YzCJW8WOfmLaGVwUALnvIMk+y6KV1hEuCQo93xEfTqDUkJDvvs/zKuMGqrb12d70DOTo
         TuXlk6gaQA7bHwr8/bVB3pxT5jw9LJEGjdzEty6qMlkOihyrY9/ylrMkenKy3zOCCQgc
         H7g5I/W8rX9k5pJP2fLPlLkUkuI4EaATuP1ZstHMXmZyltdNHzBeDURNDC12iR6xmk5z
         cmIQ==
X-Gm-Message-State: AOJu0YxX4/jlK55ePKmX/LbjZu10hKde4AD4/82P6sZlhVK8pnl2wA/B
	2EwP+POc+xpLUozlj7+Jwmq7ylf8ukh9dldDnRQKPCnOwVsvVeuFZrwBb86ZGgs=
X-Google-Smtp-Source: AGHT+IEMO7O+5pkB5+NxkwSGjJ6icX5ZUnJ2Axo2drnnhvTA2O1MS5a8l4X/yqzJHPWAoy7WsV1Yxg==
X-Received: by 2002:a05:600c:1f8d:b0:410:c5a9:a24a with SMTP id je13-20020a05600c1f8d00b00410c5a9a24amr908467wmb.20.1707992398598;
        Thu, 15 Feb 2024 02:19:58 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b004107686650esm1518508wmq.36.2024.02.15.02.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:19:57 -0800 (PST)
Message-ID: <0815e67c-36b8-4626-90a2-f11607915da2@tuxon.dev>
Date: Thu, 15 Feb 2024 12:19:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: macb: queue tie-off or disable during
 WOL suspend
Content-Language: en-US
To: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>,
 nicolas.ferre@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-2-vineeth.karumanchi@amd.com>
 <d8c48839-8b22-47ad-b270-e96a1ad1adee@tuxon.dev>
 <6a8d100c-57a5-4c92-b744-453c106352ad@amd.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <6a8d100c-57a5-4c92-b744-453c106352ad@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Vineeth,

On 15.02.2024 07:43, Karumanchi, Vineeth wrote:
> Hi Claudiu,
> 
> On 2/3/2024 9:08 PM, claudiu beznea wrote:
> <...>
>>>           queue->tx_skb = NULL;
>>> @@ -2568,6 +2574,16 @@ static int macb_alloc_consistent(struct macb *bp)
>>>       if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>>>           goto out_err;
>>>   +    /* Required for tie off descriptor for PM cases */
>>> +    if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
>>> +        bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
>>> +                            macb_dma_desc_get_size(bp),
>>> +                            &bp->rx_ring_tieoff_dma,
>>> +                            GFP_KERNEL);
>>> +        if (!bp->rx_ring_tieoff)
>>> +            goto out_err;
>> You also need to free the previously allocated rx buffers.
> 
> Are you referring to (bp->macbgem_ops.mog_alloc_rx_buffers(bp)) allocation ?
> It was freed in macb_free_consistent():
>              ...
>              bp->macbgem_ops.mog_free_rx_buffers(bp);
>              ...

You're right, my bad.

> 
> Please let me know if you are referring to different buffers.

I was referring to bp->macbgem_ops.mog_alloc_rx_buffers but hat is covered
as you pointed out.

Thank you,
Claudiu Beznea

