Return-Path: <netdev+bounces-196861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D474AD6B9C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07CD18967B4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE1221F3E;
	Thu, 12 Jun 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYp4N1M+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C2156F45
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719121; cv=none; b=J7uST/bW2y/OEvcKcsKRg9DPbBwkBBi2T/tibo/gJfAmlPevzCXw4bItJ59T2WP0qcAd8yikemvn7Yct7HylRSYFXm9e2YtG7DAAv7BtacI4ZiHzcfFQJ7rI88ZZrVreNBjeSsuo45wC8suMT1Zof4lVNRLOXL3q3j9ea0//jFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719121; c=relaxed/simple;
	bh=W3nifrGaJTVu11+37zh+htUyCWWe4+ouNiwekOr9E/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/UF24EvjnCLFyTbQVmLMVVVz7hjq8VkB4SmnTfd8HNyIsE0/nALwwlZm+Z5eFHvVo9nrCvSf2Vgq5owNIEjaXrFd9kZ1mlfl6oVlprU38wpHJo4qQKpW4K38mH2bE90MnpDSERJAOudTOwjfHP6WM4+zTiPA7UzEPlL0wVE2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYp4N1M+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749719118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=la7I67fpYtKDvu65uRhLGaZkwWzuwESfAMSxd5HPN0g=;
	b=XYp4N1M+2JPomMrZYkMNqOu3sMYFdSJElv0amWmHWpIE0Y5k4ZCcyiPj1NH+ACPqnozMIp
	WLWF9wwlvDVpNL87RD81GmS2Jc9uvaHe1zTwnVB45+ihY539WUtuWnG9zHyJGUyn8ItPTm
	ONKNjYB6/vJjsqjMUzgk5eNCkB3gtJM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-WW5odRNDNXuZHTcUWp2-5g-1; Thu, 12 Jun 2025 05:05:17 -0400
X-MC-Unique: WW5odRNDNXuZHTcUWp2-5g-1
X-Mimecast-MFC-AGG-ID: WW5odRNDNXuZHTcUWp2-5g_1749719116
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-607c91a207dso707797a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 02:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719116; x=1750323916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la7I67fpYtKDvu65uRhLGaZkwWzuwESfAMSxd5HPN0g=;
        b=J+MV/iXS0BbSys76KZoDEeeqP5Eywie3hdsAilpq3pLcnkl+dxAwDWMKBo9S6VgKQp
         yjnWLNf7e5LvBc74bqXFEEgEj//6JNWu2/ZBXwSANyooiln3KeDM17E6uxOwnucY8t33
         +/hqQTo0ljuBRRhpfHgmjttWsJNydbHDSGpGh8mVaFlfze/6b2KpgF4ZqLmPp9gGUwZr
         w3mnEz2r8tP2jtsMIv3xNnbiXiy83pV82IBZd4CFA5MMscR38QoARYwctU6MP2NWCi/g
         O3zGWtkRJsGDspJlOFrEugrK/TxhmqzZmoYHbyGIrGPWuY8yrGg3lqtnLzm+P3bHiX7R
         ExxA==
X-Gm-Message-State: AOJu0YyQzQaFK/3HsgpQ1ee2gITWQ1vmaGEvczxcZwelp8CEPGDgj2N3
	WBtHIJoxrBFsEbjVzz5c5rVAxF+pG/AaPAJ6QCri22c5kkQVisrochHJxgC0tMBj1Ie+z+v2UBu
	R80aPV30aCKxcFe2IRjQ8hQrKFS/3v40lb6f81HNufzxVYJ7LWEQZbR9j6w==
X-Gm-Gg: ASbGnctEFqfwZOL/9UTocjynu24bnL7I3ENV82bixaWlOt2Ubb4AurssK34HyAMGvMJ
	UY5ZETntngvMotMfk5uZIWfbWL4mPPmOW+Ne2uLPE2tszgoPP2zNllfvDj0LA+mjH1XBKcFBc51
	aX/6w1J0NotwrU30k2LGUkHO3Nh4RuzPk6+7S5MLm9LpqmBTPqlSDYSI4hZ+JtOuGzvfn1Xks+4
	PUV/OVuA0AzCQ8iLfFX2hN9j4nciIluDiXsOS3k002sdkZwsi2W38AfHPyr/HFhagWdViyTV+Oy
	WmYjxB6Ga73ONy9+u8QaK7on
X-Received: by 2002:a05:6402:34cd:b0:602:346b:1509 with SMTP id 4fb4d7f45d1cf-6086a6dcd1cmr1735292a12.9.1749719115896;
        Thu, 12 Jun 2025 02:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ079WoFey7SiJ2O0oyxhF2BYyBlVFY5e1GuBCQG3FcjnoOQn2hKmYw/P3wRFkmroBuQvdkg==
X-Received: by 2002:a05:6402:34cd:b0:602:346b:1509 with SMTP id 4fb4d7f45d1cf-6086a6dcd1cmr1735268a12.9.1749719115470;
        Thu, 12 Jun 2025 02:05:15 -0700 (PDT)
Received: from [100.69.167.148] ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086a5d201csm841918a12.36.2025.06.12.02.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 02:05:15 -0700 (PDT)
Message-ID: <29837ab4-3682-4f2f-b8f7-7d367195525d@redhat.com>
Date: Thu, 12 Jun 2025 11:05:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/8] virtio: introduce extended features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
 <CACGkMEuNL+nLb2EvHWqSfKB6iiDScuKD6RJqxZ2-P9v5BDH1HA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEuNL+nLb2EvHWqSfKB6iiDScuKD6RJqxZ2-P9v5BDH1HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 2:50 AM, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> @@ -272,22 +272,22 @@ static int virtio_dev_probe(struct device *_d)
>>         int err, i;
>>         struct virtio_device *dev = dev_to_virtio(_d);
>>         struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>> -       u64 device_features;
>> -       u64 driver_features;
>> +       u64 device_features[VIRTIO_FEATURES_DWORDS];
>> +       u64 driver_features[VIRTIO_FEATURES_DWORDS];
>>         u64 driver_features_legacy;
>>
>>         /* We have a driver! */
>>         virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
>>
>>         /* Figure out what features the device supports. */
>> -       device_features = dev->config->get_features(dev);
>> +       virtio_get_features(dev, device_features);
>>
>>         /* Figure out what features the driver supports. */
>> -       driver_features = 0;
>> +       virtio_features_zero(driver_features);
>>         for (i = 0; i < drv->feature_table_size; i++) {
>>                 unsigned int f = drv->feature_table[i];
>> -               BUG_ON(f >= 64);
>> -               driver_features |= (1ULL << f);
>> +               BUG_ON(f >= VIRTIO_FEATURES_MAX);
>> +               virtio_features_set_bit(driver_features, f);
> 
> Instead of doing BUG_ON here, could we just stop at 128 bits?

I think it would be nice to have a sanity check to ensure the driver
code is sync with the core. What about a WARN_ON_ONCE?

>> @@ -121,6 +124,8 @@ struct virtio_config_ops {
>>         void (*del_vqs)(struct virtio_device *);
>>         void (*synchronize_cbs)(struct virtio_device *);
>>         u64 (*get_features)(struct virtio_device *vdev);
>> +       void (*get_extended_features)(struct virtio_device *vdev,
>> +                                     u64 *features);
> 
> I think it would be better to add a size to simplify the future extension.

Note that the array size is implied by the virtio-features definition.
Future extensions will be obtained by increasing the
VIRTIO_FEATURES_DWORD define, with no other change to the code.

I think a length here would be redundant.

>> +static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
>> +{
>> +       u64 diff = 0;
>> +       int i;
>> +
>> +       for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
>> +               diff |= f1[i] ^ f2[i];
>> +       return !!diff;
> 
> Nit: we can return false early here.

I can do in in the next revision.

[same disclaimer here: I'm traveling for the whole week, my replies will
be rare and delayed]

/P


