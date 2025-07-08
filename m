Return-Path: <netdev+bounces-205037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55342AFCF20
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467A0581C4E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F12E11DA;
	Tue,  8 Jul 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuvyT2zn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F92E11B5;
	Tue,  8 Jul 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988232; cv=none; b=JbgG2rqrVyNxU2KG7Zw/yM80v/axu7VeIiz9iKgvAC8oOB9ONSmhxuXa1V63U/MU+N9FIuJLBpYiosfQ4SZoPwgG5FeF7rlCBgwSz+LHfgx/S4qcvNtLCVHdXJz2zeTG5xIk3fTxAdrkmbjyfFr7PGNxRITuUQQnOJxRvEV0qpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988232; c=relaxed/simple;
	bh=t0zhsMdWcVtROYyTguyTKLpSA22YsdUrHGfVAEnY4hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROEgx3QV4G4V3cTaRybsD42AzNAfGke4J8DxkPRM+gdnO9OtdJooqc+YFsd5ZkS+c5qBqjwtg7ml55cdG5mVv4LmkoBn/6RxEDEOTSEY96JVCGulDec8ENl9+6Ns3MjMYrpwliayoHhjQjCMlFNa1NDHx2niDK49O1wozw+by2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuvyT2zn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso38982525e9.2;
        Tue, 08 Jul 2025 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751988228; x=1752593028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcMUZCgeyReQcwT7hAu7bby9I4CBSBEcQAsKrmRUZHU=;
        b=PuvyT2zn1yIrIZFJUdRZ8levt3/HmGfLYqqwjNkk4lucAEHpoDJGCXDN2LD4up2FgR
         Fr8cnUtqnrBP722pc+dhjWqQumSW6wX3iP7SFAwpFIsh276GUOuzD/IFouqFqyD1Vagu
         qDCb+wPqQjYU6XT/c9Zx6D7afzZDH6s3MJYDfAD7tpYcUSuTFToTvqu54lKHBKfKsy7t
         0LZ6nMNMfZ3cshTPGoQPEEBLUrfRBVPJ9tVTJOl+0O95cl98duDq1Fjwd6Y6CkDWcMD5
         /lLbmW7QpPdr9RMo9hzOVgN9c/OD4bZZ4vUkbLtyosWxFVXYmne3f/Q7NmO35HigWlQv
         zWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988228; x=1752593028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcMUZCgeyReQcwT7hAu7bby9I4CBSBEcQAsKrmRUZHU=;
        b=q3LZ+h2oSumlmVYBwzIMZUa9yM3pzStmwR1nQugIDvwCGxUQ8KcltRfm1hdRQU2rrO
         SV1lGXj/L4qEAorRr3ksEQbGPx/qnsnxp7xgw4jV1sP0EfFv9hFuFMSt5IJythhzij8Z
         gICt28OWjOL1FfWNIExuw2/COGDG9h/7CKF3QXOJvoGSBzUUt2ubUqCxR1YPMfwP2Wx5
         soai6zI+ZX5uNT3lG6mFitQh2e/bpunMsSwsIHwolV1kxVA1gaDDH93GLmTbAVNT88YE
         pCv5Pt29vcwOJm2BHZ5auQltauhupkxg3JhV3eMets4RtB9qdp/ZaVh2Wf8c28sFMPGM
         9Gbw==
X-Forwarded-Encrypted: i=1; AJvYcCV5EK1rcMGNOoKnssNlpiK9+I+iBG2G28h50ipiMv2WZx3xOOtFWjuGn3DMwVL4mY5Vehha37++iVJ6KB8=@vger.kernel.org, AJvYcCW6lOAeZp3+OswamrP3X8ZjwVG7buoxgj5uBKJll71Pev2G2/54VXTVb97LQRSbjXSRya89XIOK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TQgP9LfadVnqLSnfodfoxHb3Ii+Q2cPogvjSB0GF38FoYj9D
	M5GV0p9Q3yVg/LVwY4uMxNr374LfS7NvIV6S+JTarnsTdszYTQOwpOHe
X-Gm-Gg: ASbGnctfFPG11BsNOlON5oOyrwXfTLvYEnfGA1DCYqIgfww1l9l1XpwiH85gtChGWTk
	kAEAHs+NwaviXszRGfl7cxDupP0LAX7XRWu4JcxS/xG/v00IHcZiOIrwXRoVEdkChkOHHblvrMS
	WzzCvRUs3ON8FT11h8kdLmEvVA/AYCHMJctSrk5qqMIQF4a9TTHw5q8E2L9la30aLPiBompZFYQ
	5NoFjOwRXgHehDOr7W6HdEErmXyJq4pJt2e7mCGcDLAQc9mwN8vZLoxjPKiBi8z9ukyhVphL9gL
	RByscI/R1a8oKtQbzblMt887eIEbmyWd+RzttFaeXvjOPdkbyUNa8BbbwtTj8i6tPZqtXsc=
X-Google-Smtp-Source: AGHT+IFFRv7FyHwKi0RG8N4S4cEq/NWk0eTLY0KyjYMqoY8o5cwORJ/c7bHpDiinkUqtv3tNuYGFpw==
X-Received: by 2002:a05:600c:4706:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-454b4ead1c5mr181254015e9.17.1751988228002;
        Tue, 08 Jul 2025 08:23:48 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bc79sm13226959f8f.9.2025.07.08.08.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:23:47 -0700 (PDT)
Message-ID: <b6529a13-e967-4e4d-b934-707363b41f8b@gmail.com>
Date: Tue, 8 Jul 2025 16:25:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <32cb77d8-a4a5-4fc7-a427-d723e60efc59@gmail.com>
 <CAHS8izP5rLBYq-cdbEVmuaHBhFAd2ayRmvoiE-fqxr48zMp-qQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izP5rLBYq-cdbEVmuaHBhFAd2ayRmvoiE-fqxr48zMp-qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/25 15:10, Mina Almasry wrote:
> On Tue, Jul 8, 2025 at 4:05 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 7/2/25 18:24, Dragos Tatulea wrote:
>>> For zerocopy (io_uring, devmem), there is an assumption that the
>>> parent device can do DMA. However that is not always the case:
>>> for example mlx5 SF devices have an auxiliary device as a parent.
>>>
>>> This patch introduces the possibility for the driver to specify
>>> another DMA device to be used via the new dma_dev field. The field
>>> should be set before register_netdev().
>>>
>>> A new helper function is added to get the DMA device or return NULL.
>>> The callers can check for NULL and fail early if the device is
>>> not capable of DMA.
>>>
>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> ---
>>>    include/linux/netdevice.h | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 5847c20994d3..83faa2314c30 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -2550,6 +2550,9 @@ struct net_device {
>>>
>>>        struct hwtstamp_provider __rcu  *hwprov;
>>>
>>> +     /* To be set by devices that can do DMA but not via parent. */
>>> +     struct device           *dma_dev;
>>> +
>>>        u8                      priv[] ____cacheline_aligned
>>>                                       __counted_by(priv_len);
>>>    } ____cacheline_aligned;
>>> @@ -5560,4 +5563,14 @@ extern struct net_device *blackhole_netdev;
>>>                atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
>>>    #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
>>>
>>> +static inline struct device *netdev_get_dma_dev(const struct net_device *dev)
>>> +{
>>> +     struct device *dma_dev = dev->dma_dev ? dev->dma_dev : dev->dev.parent;
>>> +
>>> +     if (!dma_dev->dma_mask)
>>
>> dev->dev.parent is NULL for veth and I assume other virtual devices as well.
>>
>> Mina, can you verify that devmem checks that? Seems like veth is rejected
>> by netdev_need_ops_lock() in netdev_nl_bind_rx_doit(), but IIRC per netdev
>> locking came after devmem got merged, and there are other virt devices that
>> might already be converted.
>>
> 
> We never attempt devmem binding on any devices that don't support the
> queue API, even before the per netdev locking was merged (there was an
> explicit ops check).

great!

io_uring doesn't look at ->queue_mgmt_ops, so the helper from this
patch needs to handle it one way or another.

-- 
Pavel Begunkov


