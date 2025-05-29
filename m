Return-Path: <netdev+bounces-194202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4EAC7C64
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F281167F9C
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56A230BFD;
	Thu, 29 May 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nkkqn5i4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A211202F6D
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516861; cv=none; b=QiiW31BAK5+9LnYP2bJPIBinzctIBW08zNK8A3+oV47uU3IlxpyahGqY2MbKe6HgTttO5tDysBbvXOIAa5wTPTyFM14tW8PQoPPG78GRNpmx/8XC9ve0Rfmn65FCk09JBWhMVRm9xHB4LZM5rxo8W97MLM/LcvE0NEz652Y6ZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516861; c=relaxed/simple;
	bh=2H5p9yQ2FVDJm98bAUcL4circOXiqz/VbjeybKWJpKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wr0Ss2dIIP7tFoq9SUx3jdvLPmLmSGyBWERnzu5TEtqLQCLS+VJp5wQuQl9fd8FA+z6jS9C1T1IzCs7Vrq1Bi0ma66Fz0NLGX9vCQSpHKbM7rtNEe2EE3jyYHt2V7xkWEIkUZ67oiwxDDaTqgX8m/tbT/vsBtwsYTkdjuiYVdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nkkqn5i4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748516858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqGgrV86JX6BZkcDgUew6hZz2yDK6/8TJmLdPatOCQ=;
	b=Nkkqn5i4PiTBMPDGwznCKe4pi5e+qRUF2ZpjUc+CTiPwVNZhNxh4xEzsd3IAbJQIxiMzeO
	q8hDn0TcQJ8q2qAoyEeB53y/sisy6cYCqhrX0vlbq65x56ChoWT7XcSziCNzFdHM7a26Pn
	Q2dxnSrK7NGOnTp4izf681ASLGhqjMo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-rv3c92m2NE-pVcKy1IboEQ-1; Thu, 29 May 2025 07:07:34 -0400
X-MC-Unique: rv3c92m2NE-pVcKy1IboEQ-1
X-Mimecast-MFC-AGG-ID: rv3c92m2NE-pVcKy1IboEQ_1748516854
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4ea7e46dfso339433f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 04:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748516853; x=1749121653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOqGgrV86JX6BZkcDgUew6hZz2yDK6/8TJmLdPatOCQ=;
        b=ty96uuXVYkArwo0r07AOgggTpB6PpLIvufkvH6f5BKwhX+vbjimzB+Mqt1p9wbY9PK
         QoVv7uOwGqOuD348+aB8blm/0thlNJMAP8bpjvxuPFFWhenHOaxl0HGHzRwij+PKqz1W
         InOB3iPrkvCcLsNL02VIlWC6MfgJ0aF2dwYUKd3nlJSsHjJiFsjTsrw13R9GIuw+lCL5
         gZEM95ySLUtRV8BS95OnnUQl1pjvuG0pD19wZxIcLxWf5HCUX8Zi/bt4aDHygDHqhRAn
         cVLLhix6LdoTYL91n4YjehVqiCAGlFCk6iFpvq2pO7SFivLtv1k5b4alK98mk6Fdh+lM
         /UFQ==
X-Gm-Message-State: AOJu0Yyx86E9c3W8HcMS+e2xEMsrOMZugGHxDHm0pI9PiWjp8PHa0ljZ
	56j90rxBhDfIvjxdU7hKYV1J4sl8D/qEgK8jM9RgYorNbUMLSsfCpfhlaInApT/tCFBpTGd30Cj
	FWeGzu/ZDavqw0pzCqfAarFM2G4vTb7/LzqF2AEx4U728PUh9/yl2VOvoJA==
X-Gm-Gg: ASbGncsGBB/v/a+6lYTbtSA6JD/PMLR8OD6CQIX4iNXFRLIRYyNllZRTwzi69vzCx8x
	+N2EUXL38TViR367XDfx6qQGhvys2euYAytN0CjxZA4yfh04N3D9Nn0E8ME+NbUe/93bGYRBf0L
	pVFrEhjfZPyURT1rM46e0RtWBsSiMS/aSG0QYhji6Z7BHp1rVkgo7KVx2XHz/YmdhB4yF4pySaV
	ypBOSPgQ+h13tj1Zjlg1oSz6l6qf8LU+5Fuqjf15BDzqTXpIVPH0nWQ+fRtsjLd3a9rk3/3oJBL
	JAfzTyyS1Jbt2nqTm7dI7oanI2TlZlbgfmFs+ToKUZPRnjtILuA730GAzgI=
X-Received: by 2002:a5d:5f8b:0:b0:3a3:6b07:20a1 with SMTP id ffacd0b85a97d-3a4cb4742dfmr16618331f8f.40.1748516853464;
        Thu, 29 May 2025 04:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXBUpV5/6QvCB/XQ0PtO5fZ2ZAbRtYguIEyU0Ns/Xc0qTq+XvwGB5nsG0VIT+UjvIPuu3eQ==
X-Received: by 2002:a5d:5f8b:0:b0:3a3:6b07:20a1 with SMTP id ffacd0b85a97d-3a4cb4742dfmr16618307f8f.40.1748516853068;
        Thu, 29 May 2025 04:07:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc03147sm16776855e9.14.2025.05.29.04.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 04:07:32 -0700 (PDT)
Message-ID: <f0a36685-45d0-4c4a-a256-74f3d4a31bd5@redhat.com>
Date: Thu, 29 May 2025 13:07:30 +0200
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
 <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com>
 <CACGkMEuBrzozRYqrgu8pM-+Ke2-NhCbFRHr8NeVpP15Qo0RZGg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEuBrzozRYqrgu8pM-+Ke2-NhCbFRHr8NeVpP15Qo0RZGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/25 4:22 AM, Jason Wang wrote:
> On Thu, May 29, 2025 at 12:02 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/27/25 5:04 AM, Jason Wang wrote:
>>> On Mon, May 26, 2025 at 6:53 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> On 5/26/25 2:49 AM, Jason Wang wrote:
>>>>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>>>
>>>>>> The virtio specifications allows for up to 128 bits for the
>>>>>> device features. Soon we are going to use some of the 'extended'
>>>>>> bits features (above 64) for the virtio_net driver.
>>>>>>
>>>>>> Extend the virtio pci modern driver to support configuring the full
>>>>>> virtio features range, replacing the unrolled loops reading and
>>>>>> writing the features space with explicit one bounded to the actual
>>>>>> features space size in word.
>>>>>>
>>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>>> ---
>>>>>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++---------
>>>>>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>>>>>> index 1d34655f6b658..e3025b6fa8540 100644
>>>>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
>>>>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
>>>>>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>>>>>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>>>>>>  {
>>>>>>         struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>>>>>> -       virtio_features_t features;
>>>>>> +       virtio_features_t features = 0;
>>>>>> +       int i;
>>>>>>
>>>>>> -       vp_iowrite32(0, &cfg->device_feature_select);
>>>>>> -       features = vp_ioread32(&cfg->device_feature);
>>>>>> -       vp_iowrite32(1, &cfg->device_feature_select);
>>>>>> -       features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
>>>>>> +       for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
>>>>>> +               virtio_features_t cur;
>>>>>> +
>>>>>> +               vp_iowrite32(i, &cfg->device_feature_select);
>>>>>> +               cur = vp_ioread32(&cfg->device_feature);
>>>>>> +               features |= cur << (32 * i);
>>>>>> +       }
>>>>>
>>>>> No matter if we decide to go with 128bit or not. I think at the lower
>>>>> layer like this, it's time to allow arbitrary length of the features
>>>>> as the spec supports.
>>>>
>>>> Is that useful if the vhost interface is not going to support it?
>>>
>>> I think so, as there are hardware virtio devices that can benefit from this.
>>
>> Let me look at the question from another perspective. Let's suppose that
>> the virtio device supports an arbitrary wide features space, and the
>> uAPI allows passing to/from the kernel an arbitrary high number of features.
>>
>> How could the kernel stop the above loop? AFAICS the virtio spec does
>> not define any way to detect the end of the features space. An arbitrary
>> bound is actually needed.
> 
> I think this is a good question ad we have something that could work:
> 
> 1) current driver has drv->feature_table_size, so the driver knows
> it's meaningless to read above the size
> 
> and
> 
> 2) we can extend the spec, e.g add a transport specific field to let
> the driver to know the feature size

So I guess we can postpone any additional change here until we have some
spec in place, right?

/P


