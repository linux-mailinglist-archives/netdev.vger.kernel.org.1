Return-Path: <netdev+bounces-135138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE099C6F3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF711C220E1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDE15AAB6;
	Mon, 14 Oct 2024 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTPO5U1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062801BC58;
	Mon, 14 Oct 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900898; cv=none; b=DuPKhdjIlva74crf5NHQW3EeplZr8NUA6vGdGWsBc+pHjmDjnOADgzA6SlGi8bYN+JmG3zeQtjv0hApW8C+U8048FZQldsXX4H2xXykZ8hSLpiKC4kLl6dlH6wUvDm24w18AYU0Omvq8T2GeA876r/UfixpimwXjoyaB/ocmvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900898; c=relaxed/simple;
	bh=XcZO780BYECysxbejWj6eP3Dd/BXOvd6UYgS2nNe76g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHja6cL1g6SKtxT0g0s7a9WTf/iZi6Uq6E3lnuf77gLlVDCrY+fvW96ACPPzF1+s1CYozXyRQ3Sb9xbf0EHLIVXBwVp2KLGQq0py9uYLVWYTBF5j9yOSE/QqQkLIUXiG5maAVnvzwCVuvMtvVJZUCZM4gNubW6mwL+WpOov57w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTPO5U1t; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1329387e87.2;
        Mon, 14 Oct 2024 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728900895; x=1729505695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygX1r+qVAqcleK4Xq+ypD6oUa+7g/TFUrrDfFds1s1w=;
        b=TTPO5U1tsSEbLQlztVD9n+O2NtTWZiZ7eggoX8FM21MuCC5/wyOlVg+47+W9FbezH8
         QV73g3YHoU5rnWETE/Rlr5vTzbYo847MQfEUNCH2PvlNpT2L93OiUeiia+qVG00/ZPjF
         f/3Llm1LzaJvhXBPZ74Qp25+ORhW9kBmct8y3weAWkecLVATCcmFNtKAUhe6V6m2VqgH
         0Z/8TxWlSkZfrhAcKU832KZumSL/sD2xasQklOY/CTOjXT4x13rn2HgzmW90jfYYmyKZ
         sNTVltd1uGwCjplhVFxbjd/6lCUUagC5f96AhNExAaSzqavLgTUCipoophkncWj3P02T
         BW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900895; x=1729505695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygX1r+qVAqcleK4Xq+ypD6oUa+7g/TFUrrDfFds1s1w=;
        b=iPSIsm3nC3VuGVa9XojBS5JdTNPvAJ7RwfcY55VPl5f7U9xkB1JO6nwEbPa5ou1lYD
         O/s/2eP1LLqgMRenOvRzontxJzE3j0igFWukCEq6p1IZtSpXSL5a2GXdh3FNnnwrM/Fm
         glzVBlG1hcA2StpuYYfGsNwOQDyUxMTyGxZrVETiwanR+BjSQUEHGjcwQKYEBjm0Rifu
         skYOSpLwmLSE6GQKwgEDGwdLegWt1F0lfRUrsRvZWjy9WConbnYFXPSlyPQM9PiGW8kn
         PEyhWoGhqDwoB92NQIxQOvI8fK/JqUyf2IbwjHVb+aDe3MHVN76RMBto/Dt+K47JWwiE
         39Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUn7JTHiqGGM5KapKBQfO2sY5Zcu9PS0+w2U6FELUET7MPsGITm+L0BJJ0TCaxMzBAxT6hC/Ctu@vger.kernel.org, AJvYcCWr/Cxk9ek/EkpMoRshpUZfsxm0p5El5x9+KLK7AMce8rRSk+4Qq+2TB/yKwLIXVM4VCeH9WbzE/baAC8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXdBrbUw7WBTLZGDlGJLS1IJXqLBjvxT6vY8SnBcVt8TQm4He
	D2cfvObb/kXWyjwwVo+TbAwe7RFRxX5gGhYB5Quukkl3RYze1ImMTvt83g==
X-Google-Smtp-Source: AGHT+IErJeAEbsFChIAXvDCX17RyOAIMAO5DK/v6A+M+mgtii0XxBWAo3oLpBRUOtMJznv2mCt4lpg==
X-Received: by 2002:a05:6512:2255:b0:52e:9762:2ba4 with SMTP id 2adb3069b0e04-539e5501c0bmr2588193e87.25.1728900894929;
        Mon, 14 Oct 2024 03:14:54 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f797sm149715175e9.4.2024.10.14.03.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:14:54 -0700 (PDT)
Message-ID: <a71e0909-dc4c-43d7-88b2-8e92df89b386@gmail.com>
Date: Mon, 14 Oct 2024 11:14:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio_net: support device stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <eb09900a-8443-4260-9b66-5431a85ca102@gmail.com>
 <20241014054305-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20241014054305-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 10:47, Michael S. Tsirkin wrote:
> On Mon, Oct 14, 2024 at 10:39:26AM +0100, Colin King (gmail) wrote:
>> Hi,
>>
>> Static analysis on Linux-next has detected a potential issue with the
>> following commit:
>>
>> commit 941168f8b40e50518a3bc6ce770a7062a5d99230
>> Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Date:   Fri Apr 26 11:39:24 2024 +0800
>>
>>      virtio_net: support device stats
>>
>>
>> The issue is in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c
>> as follows:
>>
>>          if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>>                  queue_type = VIRTNET_Q_TYPE_CQ;
>>
>>                  ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
>>                  ctx->desc_num[queue_type] +=
>> ARRAY_SIZE(virtnet_stats_cvq_desc);
>>                  ctx->size[queue_type]     += sizeof(struct
>> virtio_net_stats_cvq);
>>          }
>>
>>
>> ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
>> VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
>>
>> include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL <<
>> 32)
>>
>> ..and hence the bit-wise or operation won't set any bits in ctx->bitmap
>> because 1ULL < 32 is too wide for a u32.
> 
> Indeed. Xuan Zhuo how did you test this patch?
> 
>> I suspect ctx->bitmap should be
>> declared as u64.
>>
>> Colin
>>
>>
> 
> In fact, it is read into a u64:
> 
>         u64 offset, bitmap;
> ....
>          bitmap = ctx->bitmap[queue_type];
> 
> we'll have to reorder fields to avoid wasting memory.
> Like this I guess:
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Colin, can you confirm pls?

Fix looks sane to be, with u64 bitmap[3] struct size field re-ordering 
does not seem to make any difference on x86-64 (64 bytes) and i586 (56 
bytes) when I compiled with gcc-12, gcc-14 and clang-20.

I can't functionally test this though (not sure how).

Reviewed-by: Colin Ian King <colin.king@gmail.com>

> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..ef221429f784 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4111,12 +4111,12 @@ struct virtnet_stats_ctx {
>   	/* Used to calculate the offset inside the output buffer. */
>   	u32 desc_num[3];
>   
> -	/* The actual supported stat types. */
> -	u32 bitmap[3];
> -
>   	/* Used to calculate the reply buffer size. */
>   	u32 size[3];
>   
> +	/* The actual supported stat types. */
> +	u64 bitmap[3];
> +
>   	/* Record the output buffer. */
>   	u64 *data;
>   };




