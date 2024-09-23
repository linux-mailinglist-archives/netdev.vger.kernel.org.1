Return-Path: <netdev+bounces-129359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FEF97F092
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 20:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC91281D3D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D91A0BF8;
	Mon, 23 Sep 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5cTxbKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AF1A072C;
	Mon, 23 Sep 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115688; cv=none; b=syi2mm6bqz46o97eTqXrReXBS3ZIgOD++aUT5EUYi1W37r5Th6MJbKkkTxe3wik2jBAr48P04BPWwbvaULv2JweZzNpVMcXPXtVquBePfS1OtGrLxy9kYOzJr/cCd54xO2ODXQOmrrBZSd2EPoC4VxipivBKxiyhXD/x37s3iuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115688; c=relaxed/simple;
	bh=4ymZnMyZGtT6UYFulOD/DYIYTVeFJgXF6MGj7sQm6Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UqtBnbH3yOqUVYL/iogQ0gl3zLro8eqf3Be4nE4Lk854X0r4H55KrqjbbXc2w5XnjTpCSbPgIDqfdButC3at5LOJ5S0TZjfD5zG5CKM3eSP8/xnG0ofNeB8fXfj6oD2I3txrsWdaP4OJdIQ855osbhg69bsxGrRJWIYCOaLNsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5cTxbKF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2054e22ce3fso45801075ad.2;
        Mon, 23 Sep 2024 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727115685; x=1727720485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C5N8zqrjLqH1Y9p5/idxazVzjCi4LkorIqH28d1Q4uo=;
        b=f5cTxbKFHtrhVh8f7Yt5dbU3Xs4V3LofTIGan5cAoDfeJT7iQXLT6YetQ7QTZOg9vd
         kylxf4hKX2o94g7fkUAr8mfGdvOThHV3bqftgd4tRVk63bUQMFDbhFWZgd0DWN5UdueO
         uyDaaaCgCfb3M6HTX1koWGXfCxphspUtRZb/JWJ27pjePgJRi5qeq7kOvn1URRmsnNKV
         sUafjGJuDm9/vwhK8ZpSLyhYHV8mUsDrzFoFxIUHaoNsQkPj8LIHzDBN+y0hieodI0E+
         HQeWC9h8GAsH5L2564lK3cNGNj3QOMHHEJFp6R/i/vqVgssZN4M0EOBBp/ic9cBJRQfR
         yACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115685; x=1727720485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5N8zqrjLqH1Y9p5/idxazVzjCi4LkorIqH28d1Q4uo=;
        b=NWXiCJDaclU+PY39VGw5Wxv+J5TZQ8teVU+83m4aiaJNLoHPml8OKZiEdSK9cqbsAx
         cGNqHjeJhE1MhIT2kFEeIufmNctNuhykJOjGla/R7RjiazwZb+VTGdQzWloQTyiwZBMb
         9O0L4II74xjYFYsgJqrblrkPBfcK+cIrnuzMF3GL1KxMO1xrQpUbT5cSQekQs0XOtB/N
         WI8695d1GU0j+xLAzH720EitibQJ5yUZ+Nh6Cnv8ME/43AlOFr2gEDLj+zk42pBlWhlZ
         ma5JTIgQefqdcAMd/7hHyJVmPhExEDd0Fla7NGwZs5KN8X3ypELf5T6+0GHF1WAbVTNF
         8aAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXov9VkAyJTqeftLMf5/AzopfRCuSrHmyioqU/RX8LTSXmJucLX/AufK3uAxDcj7GgCA+gT3RY@vger.kernel.org, AJvYcCW4/orA3m7RWovAEUd22K8kfhlL9VS85krsMGknhWCvCh26W91lBXCY4BtaF6dxA6KSHxRPHV6KUXyEsl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRc1MXv4vsvv8vH186P7U8Wld8x05vTA0/oVp7Ah6IjQVKrfl
	6HIgNvE6iK1ZxsDCo8K9ZSKX/UoIFI/fXr+B04U6+MYdhpgloWCg
X-Google-Smtp-Source: AGHT+IE2d1T2d7dq1cTkk+7HY1Bll4PQQiyiD5lbMZcZpfW9xPKz6R96UC7tCV4rfcbUaUDDoAjyTg==
X-Received: by 2002:a05:6a21:a24c:b0:1ce:dd2e:d875 with SMTP id adf61e73a8af0-1d30aa0a41dmr17942165637.37.1727115685417;
        Mon, 23 Sep 2024 11:21:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b5c6sm14124299b3a.128.2024.09.23.11.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:21:24 -0700 (PDT)
Message-ID: <0a9830fe-790d-4ccd-bec9-3fbb32f18aa8@gmail.com>
Date: Mon, 23 Sep 2024 11:21:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, andrew@lunn.ch, horms@kernel.org,
 john@phrozen.org, ralph.hempel@lantiq.com, ralf@linux-mips.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921105801.14578-1-olek2@wp.pl>
 <20240921105801.14578-2-olek2@wp.pl>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240921105801.14578-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/24 03:58, Aleksander Jan Bajkowski wrote:
> When applying padding, the buffer is not zeroed, which results in memory
> disclosure. The mentioned data is observed on the wire. This patch uses
> skb_put_padto() to pad Ethernet frames properly. The mentioned function
> zeroes the expanded buffer.
> 
> In case the packet cannot be padded it is silently dropped. Statistics
> are also not incremented. This driver does not support statistics in the
> old 32-bit format or the new 64-bit format. These will be added in the
> future. In its current form, the patch should be easily backported to
> stable versions.
> 
> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
> in hardware, so software padding must be applied.
> 
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>   drivers/net/ethernet/lantiq_etop.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 3c289bfe0a09..36f1e3c93ca5 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -477,11 +477,11 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
>   	struct ltq_etop_priv *priv = netdev_priv(dev);
>   	struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>   	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
> -	int len;
>   	unsigned long flags;
>   	u32 byte_offset;
>   
> -	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
> +	if (skb_put_padto(skb, ETH_ZLEN))
> +		return NETDEV_TX_OK;

You should consider continuing to use the temporary variable 'len' here, 
and just re-assign it after the call to skb_put_padto() and avoid 
introducing potential user-after-free near the point where you program 
the buffer length into the HW. This also minimizes the amount of lines 
to review.
-- 
Florian

