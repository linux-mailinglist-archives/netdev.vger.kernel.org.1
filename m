Return-Path: <netdev+bounces-235212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78497C2D878
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4E43BCD78
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B665284886;
	Mon,  3 Nov 2025 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Eibo1d5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38A271479
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192053; cv=none; b=mCF2oKYbK2bmw4gC7Ta8LQuWdvbfz82VJIAr0Ga9ZLPSGd6pI/C8v0+y4YnUbq5JKGkvTpW5THBq9GjJXUkwFCyUldTnLD4GI3oyaMKcLwGDKsFkFMLM9pyB5+yHinxFyRJ9sWmt6CCz/WAplKVfWuebFNoSp9w55MfYpdfstoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192053; c=relaxed/simple;
	bh=bh0yAI4guRADKICExO+ozJyyCC7NK4Wn9YrjOgiy/s0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bxGKC263VqDsbVR1bjgMFLbbktwRDFo+//n0jmEi6RS2P7NVaisMfJ/fMk5FdKpSFenyC+B9zK/8ym3dzM8+d69fYgYIuMm3r6sjFY5MOPJrRY9W3HBsnRFRFD4uzhLopXf0Sn4eA24PG2+RQU9oVT+bx2ecqX+1JkMhR4MmVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Eibo1d5P; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2952048eb88so47829165ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762192052; x=1762796852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALcsYF1OUvtb4WGfm5k6mvdAKsl5PnUMHIqpz80EbzE=;
        b=Eibo1d5PuX2TG8630QQflQQjhSAWR6tR1aOQNjKUqogU7yJTqOU0aevWoKIKysQuC8
         RkLfKjHBV4AHBAH/KmersDqp93I3FegQcUbWzXeyNDk6Nx0k8r3o9AujfbKBj5H0LYK/
         mdx/Y/MSjEblJ0aCPt54dXE5rqAzHoWn7or8ukev2MeB7ApgnhItjySAMsH1SqZhfuXJ
         gam/VdyXxUKS3SbhjzQZiqFd8tJPFxge579ut2GbeIfR4ecnJjCMTFvdRfaDlIsQ9eMj
         uuD8mWwZNUCIHY88Nm6zWc6i/W9Fiwmknq2bF0E/fkjnHzFvlNBvzNgekbVBmG/tbp5S
         JI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192052; x=1762796852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALcsYF1OUvtb4WGfm5k6mvdAKsl5PnUMHIqpz80EbzE=;
        b=DJMaYzWJgW9m68rlqpNDCkrtYGYZK1HyUNdER0MjIFpFvJ8szSnTmtUYSgXa7xfL52
         DXXc6RXp9avqBFITibBpSyix1zFN53MVIramNGLBK+pHTO28Ox6JXSzoAZQpgPk3lWIb
         pX+IM4O5/UYB+AQFJzK8NZnIc2F/jLijtZ6cVLO96NpL4gUSzNPhEbudbczSLfiqcbuD
         lTVZAzZzw/yB9nH4rrgp7rG9GhsNw9gsXxBXThRLjGw9LUIwoWbr1LZAM1KY/NuFG6Tg
         0VGBKNfyn+zBlYUCTe67dP3MSDFSVg0quY2ph4gb0YjWm8cKmMPPGAKX7c37s4Cs0wGw
         8gEg==
X-Forwarded-Encrypted: i=1; AJvYcCWkhfixCzCfGaWrAOJ9vBoQoIIOSKKYo6kOk2IujdavP07KxBb5C94n1kQ73f6RpxYhhhF989I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMZHpTyxROPSqxfJ+d+G5qemEDTnf9Zm9wFS0koBdYZrmBbGq
	OZTAVKIAy596FMeGj9l8n5f0wsUkRnDopoLezKw9ly6opgvFuWo41FdYc95jI5vHDUQ=
X-Gm-Gg: ASbGnctiLi2DvW9T1Xe/uhWSBl0uEXk7GjaCbkh1GZlZu9FM/eiIsftNDcyQBWInRkQ
	F1Ot+Sd3qX7aUJBlUVYUTAvJ1cEfrfPI0C/1T7OvpypbxPCBMMFXtSZajxHfHzmGEMKo6CAOIsw
	3rBVCLfnRIIqJC7YSuzKUSilxYQfmMMfC/2Xcw8kq0vaPiRakwHkGZ61xc8eYo9iV42EEP7gast
	KE6h/E4syoBOiqDnf/DM/ULMV8Pavocx0YnpzJ8CDVpQSElwLOmaAv5sw97Mu7guGL/eqNIJNK0
	Iy41UwI/GFJOIpG7zVKUAqGHI8Xympcpp2q/JRu7O4u83Wk6mGsQnEFQ1ZoiXJLyMot1bac99d9
	5UzRMCNdPSN7Y0Aiv+4Gis9Wt3uWFoGQdm8HTMwyqQeEgfi59XnbimtNAT9SZHvy0zVLNyLv6Qj
	VFDl5DR2vPWdqyodcL8eqkCvdIuDkoYeDvHcc1vm/cPvhvEOn0AA==
X-Google-Smtp-Source: AGHT+IGNmQFBAmom+D+nA/CZ+73dSGWaWutPFAyoNpXlhYxDh2dnxcQekJr3lu/MmiZoAsEctjDvzQ==
X-Received: by 2002:a17:902:e74e:b0:295:8db9:3059 with SMTP id d9443c01a7336-2958db9335emr85842325ad.38.1762192051708;
        Mon, 03 Nov 2025 09:47:31 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2953f35bc28sm108579535ad.109.2025.11.03.09.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 09:47:30 -0800 (PST)
Message-ID: <c8d945a3-4b12-4c04-9c68-4c5ad6173af5@davidwei.uk>
Date: Mon, 3 Nov 2025 09:47:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Wei <dw@davidwei.uk>
Subject: Re: [PATCH v3 2/2] net: io_uring/zcrx: call
 netdev_queue_get_dma_dev() under instance lock
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251101022449.1112313-1-dw@davidwei.uk>
 <20251101022449.1112313-3-dw@davidwei.uk>
 <c374df85-23ec-4324-b966-9f2b3a74489a@gmail.com>
Content-Language: en-US
In-Reply-To: <c374df85-23ec-4324-b966-9f2b3a74489a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-03 05:51, Pavel Begunkov wrote:
> On 11/1/25 02:24, David Wei wrote:
>> netdev ops must be called under instance lock or rtnl_lock, but
>> io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
>> Fix this by taking the instance lock using netdev_get_by_index_lock().
>>
>> Extended the instance lock section to include attaching a memory
>> provider. Could not move io_zcrx_create_area() outside, since the dmabuf
>> codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev.
> 
> It's probably fine for now, but this nested waiting feels
> uncomfortable considering that it could be waiting for other
> devices to finish IO via dmabuf fences.
> 

Only the dmabuf path requires ifq->dev in io_zcrx_create_area(); I could
split this into two and then unlock netdev instance lock between holding
a ref and calling net_mp_open_rxq().

So the new ordering would be:

   1. io_zcrx_create_area() for !IORING_ZCRX_AREA_DMABUF
   2. netdev_get_by_index_lock(), hold netdev ref, unlock netdev
   3. io_zcrx_create_area() for IORING_ZCRX_AREA_DMABUF
   4. net_mp_open_rxq()

Jakub, do you see any problems in relocking?

