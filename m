Return-Path: <netdev+bounces-194019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9436AC6D66
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F881BC4EBA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5028B7E4;
	Wed, 28 May 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjXag/zX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B2288C9B
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448174; cv=none; b=Q8eHESb6oskatldEWuFqNNpo9aYdo/oGsSA1n5N5nO6PD/UorCJwT0MG9BlhjwNm9p7ajnXGpbbFzdWvZGwFWQoAtDbZzszLnGfvhoNFLiXYTp/boGBJL6rJlEF4hhOsLV73ahwhO12H6aXCwu8K1IMEvphbD1Kl9W8d23kt600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448174; c=relaxed/simple;
	bh=5dMNkyAkkKCHQ8nk96nUpCIg8aNDTpHpWOanPItI2W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhH6awblIaVcFew2TlyYj5JE9eTi9NobjJEChKah2ZwDxdudoq8mZaj9EIlmuSgXRO2Ia24OqWSa8xTWVVdEI+ZmqpNj1ann42Ja/thc+sIDU5SDM2I32yamj7uszQykixe/pCING8AqfsyvlvVOU8YesK/uAVh59nzUu55Bwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjXag/zX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748448171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPZcTDbaHEgC6QA8pqKhITUMnEMQXbUu1Yd8hb8N/98=;
	b=IjXag/zXkqerKRV4SFcCIaTEAT4HtV3JmDhkJOmFTppQJo2OLK/q8iIDpYGc7RnW/hbFZo
	Laj8IQ5r123qVeU8rKX6DSEpXvfStE+y8nSIDvrKwmydxwceAzDKXQSZAGatzs+MgPeduk
	ZpFh8cmyaIJ2UkHRbcy3s6dwId0gQpU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-mJuoMB1_OCmaU8pTaI2bBg-1; Wed, 28 May 2025 12:02:49 -0400
X-MC-Unique: mJuoMB1_OCmaU8pTaI2bBg-1
X-Mimecast-MFC-AGG-ID: mJuoMB1_OCmaU8pTaI2bBg_1748448168
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43f251dc364so26795e9.2
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 09:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448168; x=1749052968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPZcTDbaHEgC6QA8pqKhITUMnEMQXbUu1Yd8hb8N/98=;
        b=BsoiC5sgnBXWa9ZSX6oei5HXzMPcWfypbYdA82B/eflWYieF/yln/zZUquqmgvzoQc
         xNKeH7DwNFi6M/FE2s74kRfo1x0tciJkF9GvSDx4QXk1MfSrzmoyyXw3v1vKh8RLzTyK
         1rd5fRDCkXPPcHOjpTBYane5kW98rqx9VXBdDb4t1shX9QUhoHRHkNpOBlhw/S1xeU6l
         orLa/E9CHhiYZ04A4x/bnuZoNbZJe6bndeX4AH/BNThGQMWbu9J+QG/1vy1LpWLiOLlR
         nE8GCh6ooHDM8x/a6YFhRXztXlha4z+c01DXXRAEOU1pCH5MeaLXq2AqI2wRfCYZ7NI6
         95zA==
X-Gm-Message-State: AOJu0YxOjZvez5qM1aivRYBD1dO3JVVPNNAJQc20riN/rTrSguLu33mu
	ZLBHNhs90ZWRU2Z7CjWa5W9w1uQ1nnv0lrSAqGnTEH8EmykyUXYhbK2QM94gGkIff8LYZjEGlK5
	q1iBcBMosfGKXzZOoEU/DRfxp+vBCN8ut9qGImTFIJ2NWB63w8AP348qtvQ==
X-Gm-Gg: ASbGnct5aeCX215u2x3y5nLCydIv4eAuohWGm5Ns/KyqvjBBlfVCM6HZGrGSan4XGgu
	zF+kcAVYMrEm5VSyQAhlGKvfcaitEsMKcccF+6ublIOjO1lutKDn4B10SSbo4t8k8+/h8m+0tlo
	TCxMJrgbJWFDMr1ID43vQ1jaRtFYNIW5yjulducXaLXL/en4+6VkGMKMsEUMCqFL48/xEcLo5Zj
	Is8yTnv+XIa5VsaZ2m0ZoVBq7q6v47CzKIBVKM+DUrtdtzLUgJYB/9MPsdJVsAQb2So0jBd83aa
	0JyDKlH9jd38wcPs+j4=
X-Received: by 2002:a05:600c:4e0c:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-44c917f3ea8mr186028995e9.2.1748448166128;
        Wed, 28 May 2025 09:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7J6z6bavS14nGuTd5J+LOu471BlIGeD4kc+EtOhpJRpu75fQN+EuXQJm2iH3/KDZIwEcUTg==
X-Received: by 2002:a05:600c:4e0c:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-44c917f3ea8mr186028285e9.2.1748448165617;
        Wed, 28 May 2025 09:02:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450787d418dsm22351825e9.40.2025.05.28.09.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 09:02:45 -0700 (PDT)
Message-ID: <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>
Date: Wed, 28 May 2025 18:02:43 +0200
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
 <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com>
 <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/25 5:04 AM, Jason Wang wrote:
> On Mon, May 26, 2025 at 6:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/26/25 2:49 AM, Jason Wang wrote:
>>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> The virtio specifications allows for up to 128 bits for the
>>>> device features. Soon we are going to use some of the 'extended'
>>>> bits features (above 64) for the virtio_net driver.
>>>>
>>>> Extend the virtio pci modern driver to support configuring the full
>>>> virtio features range, replacing the unrolled loops reading and
>>>> writing the features space with explicit one bounded to the actual
>>>> features space size in word.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
>>>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>>>> index 1d34655f6b658..e3025b6fa8540 100644
>>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
>>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
>>>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>>>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>>>>  {
>>>>         struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>>>> -       virtio_features_t features;
>>>> +       virtio_features_t features = 0;
>>>> +       int i;
>>>>
>>>> -       vp_iowrite32(0, &cfg->device_feature_select);
>>>> -       features = vp_ioread32(&cfg->device_feature);
>>>> -       vp_iowrite32(1, &cfg->device_feature_select);
>>>> -       features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
>>>> +       for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
>>>> +               virtio_features_t cur;
>>>> +
>>>> +               vp_iowrite32(i, &cfg->device_feature_select);
>>>> +               cur = vp_ioread32(&cfg->device_feature);
>>>> +               features |= cur << (32 * i);
>>>> +       }
>>>
>>> No matter if we decide to go with 128bit or not. I think at the lower
>>> layer like this, it's time to allow arbitrary length of the features
>>> as the spec supports.
>>
>> Is that useful if the vhost interface is not going to support it?
> 
> I think so, as there are hardware virtio devices that can benefit from this.

Let me look at the question from another perspective. Let's suppose that
the virtio device supports an arbitrary wide features space, and the
uAPI allows passing to/from the kernel an arbitrary high number of features.

How could the kernel stop the above loop? AFAICS the virtio spec does
not define any way to detect the end of the features space. An arbitrary
bound is actually needed.

If 128 looks too low (why?) it can be raised to say 256 (why?). But
AFAICS the only visible effect would be slower configuration due to
larger number of unneeded I/O operations.

/P


