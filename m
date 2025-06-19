Return-Path: <netdev+bounces-199523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265DAE098F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943135A665D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21F219A8E;
	Thu, 19 Jun 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G025EUEe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540521C9E1
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344999; cv=none; b=KOPxIAvKRgLdh4S9b6UBmseYGGO6FjGROxWQgRA/8hSRgAe0l5rLDW7K1iz7rblca8ktJy5nJ8aXfgd+t2p5G/fUE7Zr+ENvtrrNqkQExnryCkrTfngN3L7XfRNd1lQWIqWiuSbXxwdmRg/lJzOjexGXgxRtLTJb8g2zph4ZouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344999; c=relaxed/simple;
	bh=Bs6wZXPXYllDO6Y8LuzaYH4HaVet2mdurt0J3vr7mSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVoF1DJO1qfuGVCqRSijkjdWNvYGbqshGNNeFNtzfj6aXepUKxo5+UjKDds48gIjTPbr/Qk8PrcwJ+5fUPpLZc7NHFN9QhpycWDfBwWyu8td8E1NCIB7ocF9fcp48cBPUG1EzhotNCxMDqYUGta0Y3t0X5bRMqK6OLeozAQ9WwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G025EUEe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750344996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv/T/ZUGYrYWzRjOEMw7h3N48nnM+7iDwaunDLxNK34=;
	b=G025EUEeJUVmKcwfUz1XO358VB+adouXkqbt3T4HMeuSEqdopDGUpTQg6Wcm5vCIIX1Knl
	zgfufewckYX2FO3NZEuvqOwHHQwjdmiFQXaZiei30qfjBkqg5leZIZ8MCNQY04Vr17vUz2
	z0EHEUg9rOgFgNZ+wHYVEHrw4Pp6a5A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-uzEAbl7ROoKe5nePmF6tkA-1; Thu, 19 Jun 2025 10:56:35 -0400
X-MC-Unique: uzEAbl7ROoKe5nePmF6tkA-1
X-Mimecast-MFC-AGG-ID: uzEAbl7ROoKe5nePmF6tkA_1750344994
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso4186975e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344994; x=1750949794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv/T/ZUGYrYWzRjOEMw7h3N48nnM+7iDwaunDLxNK34=;
        b=LWr8BqX9ec7Ft2Ol/S56KTP5tpyKgNOxSd+N1xU6rbK6VoaaV5urzxmtMeA4w3iFlt
         N6pm+sX+zsMKF1BWAnYARZdWU0O0NmuZGdp0lhh86b6kZcYGNoxK+ePk+cMDEPgPYfZL
         uFjWNmF+tgDSP2e7+YsuP0fCOtb81OpttEoJsLOWgeUTzZkb/rG76ALu66r3kzJ1ODGK
         3pJbxMOG9+s5JSkv0HvobvwlE9ed0n+47KSD4CKt6C3C1Fo9RUzQx1bSlARsJHgvEBEt
         5yNFvT+PJeyfscLCWH3wNAYvPn5+yQdqiL2xQorUb+m4NG13KDUU4gfK4edj+1E2BIQ+
         LrSg==
X-Gm-Message-State: AOJu0YxlcTbT9ZPwDVyBTdvWX4/bIA1Av2YoUNUyJaszYjGtwjo5WRzH
	AHnqUF8wUHDm+MZYHZrB1axV9l2vJJDjs8cE4VcbZz/BlPxqg/LyRl5pCpBPG6VLWKMOxAxNk0u
	2MWYTtdx4nTGcw7AzQw+EiBiiC/WUBX4otsZCro0vgiocPgYt2q3SUQ4iHg==
X-Gm-Gg: ASbGncshDqYhnseG4lw+YKC7XxlkrhRN/KbxAZpG4iBVpaUQm7VUAZYCu1vhxgFGvAC
	ZtgLtx2YeLs+2SP9ZkzoH4GCCgTMd2Q3M+fVET7m6OTny076ULzoPrJ1/jczpo31V6aOba7SMZA
	qL5EnPzBhX+QeVVcEqq6kL7wW8u1c4Ng1SwOzMByQQeU3CD2N3mWJ3V9Prd6EVhIcIc3Wwm51F0
	lv5yNZ5XUfteTClxSqIEugqx3Qvnpk+v4ld0oxLPfrE6MAxZEPo1DdS8mjcdrhwxF8oGI+ViNXf
	VXaRqP5uXGFQFQxIxIOvIo+BJfcD/Q==
X-Received: by 2002:a05:600c:540e:b0:450:d00d:cc with SMTP id 5b1f17b1804b1-4533ca40f80mr191781025e9.2.1750344993819;
        Thu, 19 Jun 2025 07:56:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ2JDXhu83SN9gN2DeoeJP+ZqKCDtxdGuUU05T54xP22/lVEEUXu0nntbkAUSMUE9+0vZKDQ==
X-Received: by 2002:a05:600c:540e:b0:450:d00d:cc with SMTP id 5b1f17b1804b1-4533ca40f80mr191780715e9.2.1750344993413;
        Thu, 19 Jun 2025 07:56:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebd02basm30809395e9.39.2025.06.19.07.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:56:32 -0700 (PDT)
Message-ID: <699dcc4f-dd49-43cb-a998-87eeee15b676@redhat.com>
Date: Thu, 19 Jun 2025 16:56:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/8] virtio_pci_modern: allow configuring
 extended features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1382006752c261a7d5ad42a06a365f252a9a0967.1750176076.git.pabeni@redhat.com>
 <CACGkMEuuLn20jWA_SzJxj1j+2AUnONoXc0MqPk6aWbS=kO=+kg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEuuLn20jWA_SzJxj1j+2AUnONoXc0MqPk6aWbS=kO=+kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/25 4:27 AM, Jason Wang wrote:
> On Wed, Jun 18, 2025 at 12:12 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> /*
>> - * vp_modern_get_features - get features from device
>> + * vp_modern_get_extended_features - get features from device
>>   * @mdev: the modern virtio-pci device
>> + * @features: the features array to be filled
>>   *
>> - * Returns the features read from the device
>> + * Fill the specified features array with the features read from the device
>>   */
>> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>> +void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
>> +                                    u64 *features)
>>  {
>>         struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>> +       int i;
>>
>> -       u64 features;
>> +       virtio_features_zero(features);
>> +       for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
>> +               u64 cur;
>>
>> -       vp_iowrite32(0, &cfg->device_feature_select);
>> -       features = vp_ioread32(&cfg->device_feature);
>> -       vp_iowrite32(1, &cfg->device_feature_select);
>> -       features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
>> -
>> -       return features;
>> +               vp_iowrite32(i, &cfg->device_feature_select);
>> +               cur = vp_ioread32(&cfg->device_feature);
>> +               features[i >> 1] |= cur << (32 * (i & 1));
> 
> Nit: why not simply cast features to u32 * then everything is simplified.

I can be (and usually I am) low on coffee, but I think that will work
only for BE architectures.

/P


