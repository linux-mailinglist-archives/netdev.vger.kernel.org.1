Return-Path: <netdev+bounces-193417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179EDAC3E2C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC81C3A728D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362781F5838;
	Mon, 26 May 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/ThcJha"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA901F7580
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256813; cv=none; b=UVLaorA3/95Wj6hq/mTFVLtPR6GHqdsh4JwM4W968mmEdHn5f0H5GLUZKn0OCp740VLv+keXg6QoeWowV/u+ZheIcl78q5W9W9Zdp8gvtTsl03399AyI9lz5Y6paqrn1GDrZNFc5parlyZM9OvhfvN2yIqSx2FrQSk2OkbzoNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256813; c=relaxed/simple;
	bh=bYcwfyq9hHgMD6fhCdH9Yg2ZOT+GYQjhDnNra6xHRMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRk2rXRGPXCjOqfJPOPDQkKvRFW1PX93JnU4s2SUGKAYAmmRpp0sZ+NQH4AwPeCK0L0gNtEwZInfriT4REvUU6zG3D21hvdx0FNvqIgEgok6B0BhG06CH9cGnpCTNihQ2kTE4k8ciWqxQktuN1YZGp32jQ+AQSbGbjnyxPd1u3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/ThcJha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748256807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6LHWT8P9ZBF9e/Sv/nt8TAG0ALZSq3L9P21/3sUXeo=;
	b=Y/ThcJhaT97B25m+4Q7kFKkc2Rev/1rcROh37xR2UeCrtsVCjOUt8T75y7e6yJf2vTrch6
	dJrOKM/ajmKw3/rfyUnFfEqzghDTkhphU2NJ05TIjnICEessOii5oSrg/oJGnXKPdLiyZD
	fqkpVkaxvAvws/salZmQtDLW6BoMSQE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-derp1Y4iNXCUUmf1iKH7Lg-1; Mon, 26 May 2025 06:53:26 -0400
X-MC-Unique: derp1Y4iNXCUUmf1iKH7Lg-1
X-Mimecast-MFC-AGG-ID: derp1Y4iNXCUUmf1iKH7Lg_1748256805
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4cfda0ab8so564100f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 03:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748256805; x=1748861605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6LHWT8P9ZBF9e/Sv/nt8TAG0ALZSq3L9P21/3sUXeo=;
        b=ZPp1bft7r+AZfklp018Y4FSN2hjZpPFkyjDi7nlN4Q5Rv8svhNN8H1XSseI6nUDsyV
         WLpokwwz5DDKS492Am7K9WbWMZJtEn6wL+rdWf2CYB5H/UOFh3wBsLAU3WP6HhuTjcny
         ToLzA7JRXoZowkhEAQuIUo8Vd0sqOBZKWp0fTCm2Sop2Ti7T8ZKMI84x/hgDlF3sqNmm
         gv1lVIvupPn2vbl0aZuLTeL3yduwPZGbPrxa/OpWn+HJANzSfkDJ6qK4njch7ZgbihGk
         l6U0KzuIcFXauKeRcRfNks2ypOpcFhUftpfBo7DQ6ivE5YiLn5wmNDvz9E4fz1l1YhG5
         4OPQ==
X-Gm-Message-State: AOJu0YwBaguU0moPtYKkOYVQBtSz35MqB5M+n0cIF69HA+fCIu2ycT6M
	Yw1uRPd5qlYPBe7sZRzmgJaoQdLJGiNlSa+0QZulxad6MPdFHOV6j84q6o3ZQ1J+JBR63fy7dMp
	0tbSbAL9TfPYkUe6meDKXlaYP4ZFWcIxmZIlv86iyUhuKSNeAGVjKaHtNsw==
X-Gm-Gg: ASbGncuUPVlqsnandIZFILxmEsOA2u60dQuyd2xMjvdUrm1+/a/j8bR3hfcYqL9IJxt
	zZMrpeaR+hNfggyEwBYVzNR90+/RxW468vaZuguPQ4H8EP2vY1tSxtnAk8hf2p8L6Xg4sFgnFjB
	IGMaeftcVmQAlcbkV+T7UUJWxjYGSVIloFcmZczG1QzeT/WvFnKMBLYFLhvVGj6k2+DQgWZv1Wa
	6gAUbXYrXAhTdIi1sMdPHWxg+ugZ0IW/FT/Ejj0fSciMzd06etV5LKBHZc2cJC+aKjG8M10Fkq3
	R6iDuPxUPGhiq9JqUpY=
X-Received: by 2002:a05:6000:2301:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a4da873b5dmr1307790f8f.42.1748256804857;
        Mon, 26 May 2025 03:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFIwi7Z6PTIsn0kQwQ1nQ9Q+IiILtxgHXmLDKFj9iPlJWdYSE312VMfKeTnbD2706PK7VFOQ==
X-Received: by 2002:a05:6000:2301:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a4da873b5dmr1307773f8f.42.1748256804420;
        Mon, 26 May 2025 03:53:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d2d37445sm4734501f8f.88.2025.05.26.03.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 03:53:23 -0700 (PDT)
Message-ID: <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com>
Date: Mon, 26 May 2025 12:53:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] virtio_pci_modern: allow setting configuring
 extended features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
 <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 2:49 AM, Jason Wang wrote:
> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> The virtio specifications allows for up to 128 bits for the
>> device features. Soon we are going to use some of the 'extended'
>> bits features (above 64) for the virtio_net driver.
>>
>> Extend the virtio pci modern driver to support configuring the full
>> virtio features range, replacing the unrolled loops reading and
>> writing the features space with explicit one bounded to the actual
>> features space size in word.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>> index 1d34655f6b658..e3025b6fa8540 100644
>> --- a/drivers/virtio/virtio_pci_modern_dev.c
>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>>  {
>>         struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>> -       virtio_features_t features;
>> +       virtio_features_t features = 0;
>> +       int i;
>>
>> -       vp_iowrite32(0, &cfg->device_feature_select);
>> -       features = vp_ioread32(&cfg->device_feature);
>> -       vp_iowrite32(1, &cfg->device_feature_select);
>> -       features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
>> +       for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
>> +               virtio_features_t cur;
>> +
>> +               vp_iowrite32(i, &cfg->device_feature_select);
>> +               cur = vp_ioread32(&cfg->device_feature);
>> +               features |= cur << (32 * i);
>> +       }
> 
> No matter if we decide to go with 128bit or not. I think at the lower
> layer like this, it's time to allow arbitrary length of the features
> as the spec supports.

Is that useful if the vhost interface is not going to support it?

Note that the above code is independent from the feature-space. Defining
larger value of VIRTIO_FEATURES_WORDS it will deal with larger number of
features.

/P


