Return-Path: <netdev+bounces-198964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC82ADE706
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363A0403882
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA3283121;
	Wed, 18 Jun 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd+VL/gu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24C28F5
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238989; cv=none; b=d2nYd3Q8IyYY/mOEkzh7tbOnGkvwrWEqD32e57NMwqy8Lf2SA3SNGBDehppcAGmnHXUhW38KF5g/W8+yFEcKl+t5pxUQOYCjWYypWz4uOKg9+Ym8tN+FfRbOm9bdCZOoRd9jpA75O0kuPhfdxL/QFv5eYmG+N1jjKYk9LB7i3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238989; c=relaxed/simple;
	bh=jjNlmHBcaxShHoPQ1BOaxdlhQ3qJO/+cOCvjTnVHmo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzgfd6y+bYuzupAc0FDwXs9vaY3BQUXshcUuIsiUfQi/w4Ht1cuqWo7xhQzZ4jGULGUo7h3RJI5z45Sq0LZot4FXSADqXvQt4xDXR/JH284MEHfCW+1zfcE5CCnmQlyvNhFOJ6Z7l/GcvppO7TiGI1goNvRrUOqhbavr1GkvgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd+VL/gu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750238984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+HaWI7OzQLBgz2QNz0jyieeF0YKXhz+FU7MoJE7o3Q=;
	b=Nd+VL/guFMKq4FRO0uwerI1CAPPqPpnyLvO7k1a1J9rHtAGt6Z9HK2xQnfir6lKvThjpBt
	6w3BK6mdv6nRQA+cu7eLkhV93Tyisvc8qPAhJeULCfd8C2w4O64URo+jApPZgD8DLA8Zgn
	F2MqJY1guGEHrXGxMaNnMvZpB9S7uck=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-hqCBze9uOICvRifC8mx7_w-1; Wed, 18 Jun 2025 05:29:43 -0400
X-MC-Unique: hqCBze9uOICvRifC8mx7_w-1
X-Mimecast-MFC-AGG-ID: hqCBze9uOICvRifC8mx7_w_1750238982
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606c46b8b9cso574717a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238982; x=1750843782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+HaWI7OzQLBgz2QNz0jyieeF0YKXhz+FU7MoJE7o3Q=;
        b=vWh6ETLoev4PEdvMg61Itqj380dPhNqaydVNZcdW67fNXIbBwDFYEhkIiKsmNKCvYN
         s1riRsfVDERarqkb+mZXBqNjPyCtqzt55Mg4kezGyNRDLidEc1KNvzn7y78uWs4E4bww
         Q3+Ap/Xm/b2xKnBwAtlSxcuDO0weDcmI6+5MPS/MRCP8v2G1YF9QaarGo4FuYVpLTtE0
         jAfKtVA/YtyK5k+3+bpWXjarA9KoF5Ke3hSlHFz3cyhZfPGQJJU49yliA1MI9YmU2YQ+
         cezC5RK9L0IO2NZasagBCDgAKBJnv01QmPGycwR+PTA66z4pLtiO6TJxrmcdnXD8j06m
         FanA==
X-Gm-Message-State: AOJu0YwrHmPjs8WSPpLUQ3/EP2tHVHNGgruQ/J/te32X5QadwEu0uTsw
	L59/guOoFM0n84jbNtbYXFbQSVlR17Fr3PiU4+qbLVX8scbbKyi47UhcFXQGP1IUMAsiYR7CrNp
	Xy1X4NMkxvzfBk4Oy73mL+uSjLOcKFeSKDl6VV4ppwiiT2rWDgmAeXmoECDZgf/x5XgEc
X-Gm-Gg: ASbGncuT4fklGARZU5c39pgOC5VVxWMWXVQQODbJEMVFb6MXQQSHIdVOvOg6fF48Sd2
	+UUmXIp8FYpv6vL64kBVDL4zeso+N3RRknJ5DXZT/d55Vasm+aWLP3GBWqmI61jmZpMiiBGqSiY
	tuRUsNDnC/yO0909OUuy90Fk/fYnHuN1GG3dBYp3Ed3PgfFqbCn8dvpxk5MlWVmEeJUolFUAJ6m
	OkXeh9AKY4+3YJMOWqMn6ZCOLmDjOcsiDpZEPt4LWAn/cluEerquQDL1KXD+6tedysQbFKgSnu0
	tY3WAF572LH4ekqii+yLO4H6bB1Wgg==
X-Received: by 2002:a05:6402:4615:b0:608:ce7d:c3b8 with SMTP id 4fb4d7f45d1cf-609c1c4f210mr1658674a12.17.1750238981775;
        Wed, 18 Jun 2025 02:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGncpkbOEkdFUjtLQceXbwmAIojrcJ5sOr06x17DDmBNCLGmjtchBCLAX0WETxKUlupAtrjKg==
X-Received: by 2002:a05:600c:4fd6:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-453599ada17mr14276895e9.16.1750235499871;
        Wed, 18 Jun 2025 01:31:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b27795sm16213817f8f.71.2025.06.18.01.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 01:31:39 -0700 (PDT)
Message-ID: <54923be8-8ab0-4b55-b599-5f20c999e60f@redhat.com>
Date: Wed, 18 Jun 2025 10:31:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/8] virtio: introduce extended features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
 <CACGkMEv8b33EeMuHU03EGByumHRMhT3C6_Xeq_Lig=gjroofRg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEv8b33EeMuHU03EGByumHRMhT3C6_Xeq_Lig=gjroofRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/25 3:51 AM, Jason Wang wrote:
> On Wed, Jun 18, 2025 at 12:12 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> The virtio specifications allows for up to 128 bits for the
>> device features. Soon we are going to use some of the 'extended'
>> bits features (above 64) for the virtio_net driver.
>>
>> Introduce extended features as a fixed size array of u64. To minimize
>> the diffstat allows legacy driver to access the low 64 bits via a
>> transparent union.
>>
>> Introduce an extended get_extended_features configuration callback
>> that devices supporting the extended features range must implement in
>> place of the traditional one.
>>
>> Note that legacy and transport features don't need any change, as
>> they are always in the low 64 bit range.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v3 -> v4:
>>   - moved bit sanity check in virtio_features_*
>>   - replaced BUG_ON with WARN_ON_ONCE
>>   - *_and_not -> _andnot
>>   - short circuit features comparison
>> v2 -> v3:
>>   - uint128_t -> u64[2];
>> v1 -> v2:
>>   - let u64 VIRTIO_BIT() cope with higher bit values
>>   - add .get_features128 instead of changing .get_features signature
>> ---
>>  drivers/virtio/virtio.c         | 43 +++++++++-------
>>  drivers/virtio/virtio_debug.c   | 27 +++++-----
>>  include/linux/virtio.h          |  5 +-
>>  include/linux/virtio_config.h   | 41 +++++++--------
>>  include/linux/virtio_features.h | 88 +++++++++++++++++++++++++++++++++
>>  5 files changed, 151 insertions(+), 53 deletions(-)
>>  create mode 100644 include/linux/virtio_features.h
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 95d5d7993e5b..5c48788cdbec 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
>>
>>         /* We actually represent this as a bitstring, as it could be
>>          * arbitrary length in future. */
>> -       for (i = 0; i < sizeof(dev->features)*8; i++)
>> +       for (i = 0; i < VIRTIO_FEATURES_MAX; i++)
>>                 len += sysfs_emit_at(buf, len, "%c",
>>                                __virtio_test_bit(dev, i) ? '1' : '0');
>>         len += sysfs_emit_at(buf, len, "\n");
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
>> +               if (!WARN_ON_ONCE(f >= VIRTIO_FEATURES_MAX))
> 
> Nit: Any reason why switching to use WARN_ON_ONCE()?

BUG_ON() are strongly discouraged. Since I touched the nearby code
checkpatch urged me to take action ;)

/P


