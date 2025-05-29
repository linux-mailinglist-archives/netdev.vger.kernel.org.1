Return-Path: <netdev+bounces-194203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37BFAC7C68
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74245169814
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD9288C8D;
	Thu, 29 May 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+58N/XL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0331925AB
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517052; cv=none; b=lIycFr7YZrd0AXkUf0lffRHBTQTUGuLg3NGhF2HvlfMSllaCGPVKtK+uHBZr8Nr1d0k12nm5RKJGsqdXtEHEqRX+JTaQGTFTFVYbDFIKAd4nCHV5SOvPBfhSKpkJNY51Umg82wuHqsR2zlX+6ky4rVBJQqO2xYWSqTCT/CP72to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517052; c=relaxed/simple;
	bh=OVYnlfBgOtZMqaNA1uwXppafaXaUpBsogZkXrxBzals=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dXLrqJ9WNTHWlCx0Opg/FljItpq+ZiCQKBqhkOoIeCnJ+JkLC5q/L4ImDP+wiFIIzndAsYk47jSYkKZ51oOzjMWt7dazTUzRv/HWo23DwimgWkQzop/4N7sLvfB5Xa4bRtRf8XBYb+FPKFBuWy0j4lS+jI/uYDjRKnSY0Px6B7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+58N/XL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748517049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCtHDPUqSgUkQ4Z2iph91ACxz9kuBADISGFVISCaMUo=;
	b=C+58N/XLyXa9rbhZoxjjgC5Tpi0mfG6BOCXwC+7VTexrkUOYHuZ7yUN/HxYU7Nn5LuLnuS
	pyiesg6HbMr39M8nnwB+TLOexUmd4N9p2MHNjtg+sjHpoH6nVnDlQRBS9P4bjThGPbYTAy
	FqMmA4DyEuVVJtGtSSH7/N47AlJ10II=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-EF-F0Ex2PyuYhf2mGBRy5w-1; Thu, 29 May 2025 07:10:46 -0400
X-MC-Unique: EF-F0Ex2PyuYhf2mGBRy5w-1
X-Mimecast-MFC-AGG-ID: EF-F0Ex2PyuYhf2mGBRy5w_1748517045
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-445135eb689so3913235e9.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 04:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748517045; x=1749121845;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCtHDPUqSgUkQ4Z2iph91ACxz9kuBADISGFVISCaMUo=;
        b=HjjztzwnkvZY8W0eqOsdTDEGGWYeHJP3Pq5BEvq6Lsyv2U1CT0QOj2MsExkDWoROU3
         br1OdXoDceSVu/JYCopaooUAz/tSDUEArNFNKICJPTkr9ppo8WOuMpkyseBtyNaPNwcu
         8CZGSzYyqSWC7U2nm5HTnJ5RHDgaJgjb41BziyITq3G3kQ+/uvTcZdXmX/BJQxNWppMB
         lXo81OHq8tBS4HvO73N0nPpRzKfsZH7daJ0jyS56pOzZAmmZzAAB5SrGnxs9xyha60hP
         VOOb9IpqWWz4ZO4uJKfDq8pokSjxFOu0s+ZUQsjaA2C9HsDFVlNqbuKwdfxJe9LpnPPM
         TeQA==
X-Gm-Message-State: AOJu0YxFl9lUwpWbtl0tg2eqjlMRyF1ZAMupzTgfblo2XdQJB5hXGF4Q
	v+tp1oKjoM0Ei+WqYTiyTQSPihu1nejlAnV410VlhbFE4L8UJ82LPJhya69huLojyYSjz1J1eHt
	XQWMkriWnrfFUUEqFrHSmhTSejT52draZSaP6PU6AitHUyWYzHXuxO6rwjw==
X-Gm-Gg: ASbGncuL2v1YEPMLX2NbRC5lDgrBTGepx5ibUYx4VN3oONC54nLB0pvhKvha26KhA4u
	1w4UZDDqzy1P1VG59F9AkPRrN8ImX1/T5mixRBoCdjQ4OJIJq0uu1wTJLil9/j7m/L7/kBII5Vd
	xW50VZnmJuCK+Atqj+V9ZaVjnLLnrr0rMhoElte1zQznrwz9ikdgaxMqhkmzHc99deZiv6W50rq
	gxhFjxsUIIlQ7qYHDDE84FDKGnfib+w6lgtiegClp0b4GNHg4wbVVg/h7zX0Xgz4BTaGBxmvi+4
	9f+1HlAHf26Bz+tXbSI0goto6E80Cn5m8dfytwCgc3qKKJ1vt9MHS2jv23o=
X-Received: by 2002:a05:600c:34cb:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-450725539f8mr71964575e9.10.1748517045289;
        Thu, 29 May 2025 04:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8/ZcoA56EBOAiim/L1SeUuQnQyCSQxeHwbb/Xdp0vRhXDOE24Vs6T7bjywvBYFCStPytLQA==
X-Received: by 2002:a05:600c:34cb:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-450725539f8mr71964225e9.10.1748517044817;
        Thu, 29 May 2025 04:10:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfbf498bsm17423515e9.1.2025.05.29.04.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 04:10:44 -0700 (PDT)
Message-ID: <546a1ee3-7003-4acf-879f-d67f65b534c2@redhat.com>
Date: Thu, 29 May 2025 13:10:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/8] vhost-net: allow configuring extended
 features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <b1d716304a883a4e93178957defee2c560f5b3d4.1747822866.git.pabeni@redhat.com>
 <CACGkMEuzWGQB=kQeX-bA8jVn=5Sj_MP_Q2zbMS=tvKGYrNmWLw@mail.gmail.com>
 <df320160-88d4-44fc-92f8-dd7a9efb8569@redhat.com>
 <CACGkMEsrPVYzva_EOHMnoqYWajqiRsMoXsfUrPfuimvG=8EKsQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGkMEsrPVYzva_EOHMnoqYWajqiRsMoXsfUrPfuimvG=8EKsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/25 5:56 AM, Jason Wang wrote:
> On Mon, May 26, 2025 at 6:57 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/26/25 2:47 AM, Jason Wang wrote:
>>> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> Use the extended feature type for 'acked_features' and implement
>>>> two new ioctls operation to get and set the extended features.
>>>>
>>>> Note that the legacy ioctls implicitly truncate the negotiated
>>>> features to the lower 64 bits range.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>>  drivers/vhost/net.c        | 26 +++++++++++++++++++++++++-
>>>>  drivers/vhost/vhost.h      |  2 +-
>>>>  include/uapi/linux/vhost.h |  8 ++++++++
>>>>  3 files changed, 34 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>> index 7cbfc7d718b3f..b894685dded3e 100644
>>>> --- a/drivers/vhost/net.c
>>>> +++ b/drivers/vhost/net.c
>>>> @@ -77,6 +77,10 @@ enum {
>>>>                          (1ULL << VIRTIO_F_RING_RESET)
>>>>  };
>>>>
>>>> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
>>>> +#define VHOST_NET_FEATURES_EX VHOST_NET_FEATURES
>>>> +#endif
>>>> +
>>>>  enum {
>>>>         VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>>>  };
>>>> @@ -1614,7 +1618,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>>>>         return err;
>>>>  }
>>>>
>>>> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
>>>> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>>>>  {
>>>>         size_t vhost_hlen, sock_hlen, hdr_len;
>>>>         int i;
>>>> @@ -1704,6 +1708,26 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>>                 if (features & ~VHOST_NET_FEATURES)
>>>>                         return -EOPNOTSUPP;
>>>>                 return vhost_net_set_features(n, features);
>>>> +#ifdef VIRTIO_HAS_EXTENDED_FEATURES
>>>
>>> Vhost doesn't depend on virtio. But this invents a dependency, and I
>>> don't understand why we need to do that.
>>
>> What do you mean with "dependency" here? vhost has already a build
>> dependency vs virtio, including several virtio headers. It has also a
>> logical dependency, using several virtio features.
>>
>> Do you mean a build dependency? this change does not introduce such a thing.
> 
> I mean vhost can be built without virtio drivers. So old vhost can run
> new virtio drivers on top. So I don't see why vhost needs to check if
> virtio of the same source tree supports 128 bit or not.
> 
> We can just accept an array of features now as
> 
> 1) the changes are limited to vhost so it wouldn't be too much
> 2) we don't have to have VHOST_GET_FEATURES_EX2 in the future.

AFAICS the ioctl() interface code wise only impacts on the device
implementing extended features support, I guess it could be changed to
to something alike:

struct vhost_virtio_features {
	__u64 count;
	__u64 features[];
};

#define VHOST_GET_FEATURES_VECTOR _IOR(VHOST_VIRTIO, 0x83, struct
vhost_virtio_features)
#define VHOST_SET_FEATURES_VECTOR _IOW(VHOST_VIRTIO, 0x83, struct
vhost_virtio_features)

I could drop the above #ifdef, and the implementation would copy in/out
only the known/supported number of features.

WDYT?

/P


