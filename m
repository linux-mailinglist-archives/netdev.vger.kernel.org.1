Return-Path: <netdev+bounces-235219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFFC2DADD
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 19:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53721882883
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8A313273;
	Mon,  3 Nov 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ukNjzSjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0C302776
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194575; cv=none; b=N51x2W6T28cqXMcPoW2d6deCPHX/SHyhbLenjuk2uuP0f63n82bspUonPfXPbJGLO+P219WTnlboLN5OmpFxGaGKchVh6xX/INY0uOFR/DY5dVJULKpOSQjHwFJDKaokS7MpIoVMvBTZaN7Hw6RDveIheu9w1hvIMsYHqcdll7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194575; c=relaxed/simple;
	bh=wmAoFKWLR75h67tOzpzFWAsENGf3eJMEMC/hDrfVXjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzleMIJ+KkTQqpNlDDlbvd0YXnN/nSyBYvpkswVtZxBHyfdmr8VGCpzpio6ei9AgD8VoaynLkHnILBnS7hDQon059yVVgeEE0kYCWam4IRvUzztANFimgbTTpD8FVbrdFMqIySolWt1jqA0tkc9F01rk8d0JTsrv7UgwVdCvipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ukNjzSjM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29568d93e87so15701375ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762194573; x=1762799373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PitSUlDm1go9vcuGwrxc/qigK0RG9QByQoNdiaE+6vo=;
        b=ukNjzSjMp8FXrdxXksyuuuTwyVobQBLBdIuqVY4PVD8hRIiSVhxXtfN/rGbg5mPauc
         9+QgzcYCiScNDOeciF5E10LcP9P6z5lluX3sNpf7cpWE3ev+JQHMSwgRPOEU0hHejdvX
         MpaQoLYHZwJFtGldxlQRPCI798l9eL1n6tarvNCTsV5S+r2qx75ay5OWHQ3L5IZ0fKPr
         B2jJKUi/4ii6lDq0m3IaPAmcE7Jtjeg/RZTK1TOghh6Js0bolulbvcRCnxyYUUUR7Bvj
         3kvFM7HiIaikqcmr8FeG822uDwNnIqM7PD4lwC/4nR15qxTKt/eSaMDStw+4iEut4K7T
         YicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194573; x=1762799373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PitSUlDm1go9vcuGwrxc/qigK0RG9QByQoNdiaE+6vo=;
        b=cYAjGsstuh1ZLI9WW/KN31iRRhRYMhgGDgOSIJcS4VwqVmev/ksC8HmMugIIuQ57VN
         IeMNQ8fBERfat+BGbtD4MyDequDzUqjO+P/+ADkAMcwwspVbggFg+hGPRFJ/1qaJBRDR
         VjwlGh5NSQQza/iUalemn89au2hD+6J6E9K3J8LpOgZN6kkLUPqnG2D8bj97iEszKGLB
         J3Ok0StFDsMj5z8wdGeA9Pv+Nvdf+9T9pasG6+EVhcRaTPhtu4OPUuz9g0xXOgtZyAZT
         L8Ia7YSos5rhRw9xXAx9D3T6cmIKagDzZPpCma7qH3SPE/kDTEejewcZBXbtip+JdcOi
         HisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoTGZrkvZ9hZ0rkyIUCOrkErrrn/IF/KE/4KfNyu1mTw45zay300uSSkGbgrk8xd6oAaaUgWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8ecEoGMKAh8EkTcxPQtRJGcmVew0k5nCDIdaXAWxm80EWxxT
	0KX2GvZKiFOTQWRonqzUv25er0586J6S7UJ9UIlKIkK+Y0P/wjGGIpsh+L8SWXb4UC8=
X-Gm-Gg: ASbGnctvsiSsSj5D9H8qLKqfL1ZBZcuket6XNGpBBZue20KMF+w8wKeUXIzaYj5f70p
	94e/9AGHzGc7v08W8kp7/wT8kk9f67yBdcN9vzHLA2cvM3rLttvY22C63lg2Ks0Mw761QPLPV0W
	OdmEXIsOBuLJ3JjOnLljmO+3ib9ColkbbQAzigOx6WxwH+4dKU3ThfmGlZnQrCr6sWUOlyJ22UL
	tgzwENrUQwXKtMLRbSj3oOzFflQASpCTwPjlt3RO23PZm41ihJUw4ADkrp3LOmOVG3+LM0H2gnT
	Grz3JwWecou2Z3iWuXvWqFGFpxXeAW9fMHIuA6aMF0BaEi19lizosBpsP1f+kOuCoHa8yJSRJlC
	R46AzdLpny733zE98KjCGcBmcfnPQvjJ8VEtqlV7oz9US1O0IweIP/ihopDgSew9f82uJBKiCZU
	SUF2CipLPZwCqN+7yDFRiL+/S9rGzTOIJDHPpNR52hnznTxMx+sQ==
X-Google-Smtp-Source: AGHT+IGW2nkRcJ3o/X5DXan+YDTZlhzqN1S6emKnORTiA21dPoo0N/2D2LoJeQBefEjC3aZZYzoH/g==
X-Received: by 2002:a17:902:c40f:b0:295:a1a5:baee with SMTP id d9443c01a7336-295a1a5c06cmr51543855ad.4.1762194572902;
        Mon, 03 Nov 2025 10:29:32 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm130124765ad.84.2025.11.03.10.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 10:29:32 -0800 (PST)
Message-ID: <1f708620-303f-4466-b248-3490a8e9e424@davidwei.uk>
Date: Mon, 3 Nov 2025 10:29:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <c8d945a3-4b12-4c04-9c68-4c5ad6173af5@davidwei.uk>
 <7805c473-448a-430c-a53b-a42e8d2c24bf@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <7805c473-448a-430c-a53b-a42e8d2c24bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-11-03 10:21, Pavel Begunkov wrote:
> On 11/3/25 17:47, David Wei wrote:
>> On 2025-11-03 05:51, Pavel Begunkov wrote:
>>> On 11/1/25 02:24, David Wei wrote:
>>>> netdev ops must be called under instance lock or rtnl_lock, but
>>>> io_register_zcrx_ifq() isn't doing this for netdev_queue_get_dma_dev().
>>>> Fix this by taking the instance lock using netdev_get_by_index_lock().
>>>>
>>>> Extended the instance lock section to include attaching a memory
>>>> provider. Could not move io_zcrx_create_area() outside, since the dmabuf
>>>> codepath IORING_ZCRX_AREA_DMABUF requires ifq->dev.
>>>
>>> It's probably fine for now, but this nested waiting feels
>>> uncomfortable considering that it could be waiting for other
>>> devices to finish IO via dmabuf fences.
>>>
>>
>> Only the dmabuf path requires ifq->dev in io_zcrx_create_area(); I could
>> split this into two and then unlock netdev instance lock between holding
>> a ref and calling net_mp_open_rxq().
>>
>> So the new ordering would be:
>>
>>    1. io_zcrx_create_area() for !IORING_ZCRX_AREA_DMABUF
>>    2. netdev_get_by_index_lock(), hold netdev ref, unlock netdev
>>    3. io_zcrx_create_area() for IORING_ZCRX_AREA_DMABUF
>>    4. net_mp_open_rxq()
> 
> To avoid dragging it on, can you do it as a follow up please? And
> it's better to avoid splitting on IORING_ZCRX_AREA_DMABUF, either it
> works for both or it doesn't at all.
> 

Of course, follow ups are always my preference.

