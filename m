Return-Path: <netdev+bounces-195426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BFAD0181
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7F816D959
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F022874F5;
	Fri,  6 Jun 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fS7Uzo9n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59891E25ED
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210770; cv=none; b=VNtzpH9ojP17qOhWy4cAhXapY9ZXuan209JZ0rbBacUZg2IAHrNPvy4bwYgNBODyr6Uh4P0dRIN9L6QWyHQNkRJzgYEjQ6WtahnYz1TXmrjYq7pUVore4ntC6pRax6gKO+msgQA9ieBX0/lmjCFgwwITjUu5AQ27mZ+Z7dfpMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210770; c=relaxed/simple;
	bh=AsYoWuIZ2TlumsPFQa+gKY8SO3aLlzf9IANn1wpm98Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHKS0oq/8AxyhsyT4nQ8dcOkgCsnVLROCQEUgy8AaWm7ASeSwlZzuGsKMJ3GgZAQoCOwAmGqt0WHSKqV/WUcnAsO024G7bsgMftvQivky+8YB0P+R6pKW0xl0Ha2Y4SAfDdNEoZvS3YwFUhUK2Ppzwc7wJxxKkdN4m00YDeWZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fS7Uzo9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/AnD6TYPKXZEMWuI9mzXacHoAE18LdbfLk7+y7qQD4=;
	b=fS7Uzo9nBcuMkxh1oo5bYUSHqRuxpwB28Wg7xXXeoaLiqzN+xnXBDtVKu3sVFYPXrKFd1j
	ao6H9fJ+FMHvlfjk+oWrJn9FBJz1VbzuMI6f0vIOoMflv2ggAPggoNpeWyyPg0F/2WSKkA
	xehohiJ3zgn5pwHwXokW1khVHZfaoXg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-5HcXOmbjNC6SJ1NIujcAPg-1; Fri, 06 Jun 2025 07:52:46 -0400
X-MC-Unique: 5HcXOmbjNC6SJ1NIujcAPg-1
X-Mimecast-MFC-AGG-ID: 5HcXOmbjNC6SJ1NIujcAPg_1749210765
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so13208005e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 04:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749210765; x=1749815565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/AnD6TYPKXZEMWuI9mzXacHoAE18LdbfLk7+y7qQD4=;
        b=v1RtfMI9nJWg0bDq7P/d6uH9owbwTeBKJ5l9F+b9c9EwKyXFuxItx0jZBdmhQ8JuSZ
         GCVyCH8j42jrNyyzq0r8wstOfXr9Ro8ofzLkN4Av9xdGtW62AmLL3STOW1w1DjwYwjf3
         7SnSU4lGKSeFSdTrKQb/M1bQgkodPYOM4DZIVChg8TnHs0cED1AjrL6pFMQhJEkXJB/Y
         TzKhpPLD64hEJs91byb/qLbkMgzYSj1zWzlPEdOwvNn+hexFEkk829FcxE2419hX48EL
         0gYOAdbqWDRF804p5cIVA5ORI3Nnl5ZKft2sTioJDc0+RArpS/xiji8Rk4FATSdIb7Zy
         xJxw==
X-Forwarded-Encrypted: i=1; AJvYcCV1lcROnIFgrkXXk0SxfTu6z0eBJPmQLUlmI+q/kh5zArgHxfd4/7aTJXZ049Bng04N2XszOgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsE4QkCvXNvIldx0BO1q3/2xCovZqgzhzDUYllTDzzOMbY63hi
	LJgmNvYF35DaQQncz1QuNYv0hkJ9tZxrmHsPsrltgecB/6mdmrr5ZbEKB/pSrUISDKUX4v2T+uV
	YZNo9X4HMovnoX0a2uMUFhsEg1qC9f2JkwnZUh7Bj7aHwYYkFiodtQ4kFqw==
X-Gm-Gg: ASbGncvS4EcdDmd6LFEndf68m+dbPoUu8MrNeh5NIbrdHQJckq3GcSuUg/0InTmBj5S
	vIu9R6LvVsN+kQrBYRTHpFGF0ZgB4dXJsHhfWILJw6mmSIig9+wXPs5UrKp0O2ucVLUKJGzKg5W
	JM9E9ThRZG9RYPbnw9uAlLZTzEtKqwsXD+kctTzPxwQuujO+LvHzAGtaDAxdpZ5BURXm2a0cjph
	GElt4pCllwqPWUSxs5nYQYRf0XVENMbkltBLrky/1WxzKGc08fNorV+dfqZeqy93Nnu0tfBbFPg
	zlCg45GzcUSwUIRCkqeyjsD0xhZcTw==
X-Received: by 2002:a05:600c:6205:b0:450:cfcb:5c9b with SMTP id 5b1f17b1804b1-452013fd8b1mr28296615e9.1.1749210765404;
        Fri, 06 Jun 2025 04:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu2V3Bs07Pkd0+6w4mBPdOWqC5KXdZ6VU7FULfifttZvnWnIiOWqst39sWlUD2AJCU96fMBA==
X-Received: by 2002:a05:600c:6205:b0:450:cfcb:5c9b with SMTP id 5b1f17b1804b1-452013fd8b1mr28296435e9.1.1749210764967;
        Fri, 06 Jun 2025 04:52:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc1d:fd10::f39? ([2a0d:3341:cc1d:fd10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de53sm1653539f8f.8.2025.06.06.04.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 04:52:44 -0700 (PDT)
Message-ID: <936eaedc-d4e0-446c-9667-82ee4d0e1ab2@redhat.com>
Date: Fri, 6 Jun 2025 13:52:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/8] vhost-net: allow configuring extended features
To: Akihiko Odaki <akihiko.odaki@daynix.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1748614223.git.pabeni@redhat.com>
 <b9b60ed5865958b9d169adc3b0196c21a50f6bca.1748614223.git.pabeni@redhat.com>
 <9eae960a-0226-46e2-a6f4-95c91800268c@daynix.com>
 <f0ee95b7-6830-4a53-8d6b-0edf1a7ab142@redhat.com>
 <fc27ca0b-c00e-4461-9890-746a237e48bc@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <fc27ca0b-c00e-4461-9890-746a237e48bc@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 11:57 AM, Akihiko Odaki wrote:
> On 2025/06/03 22:32, Paolo Abeni wrote:
>> On 5/31/25 8:15 AM, Akihiko Odaki wrote:
>>> On 2025/05/30 23:49, Paolo Abeni wrote:
>>>> Use the extended feature type for 'acked_features' and implement
>>>> two new ioctls operation allowing the user-space to set/query an
>>>> unbounded amount of features.
>>>>
>>>> The actual number of processed features is limited by virtio_features_t
>>>> size, and attempts to set features above such limit fail with
>>>> EOPNOTSUPP.
>>>>
>>>> Note that the legacy ioctls implicitly truncate the negotiated
>>>> features to the lower 64 bits range.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> v1 -> v2:
>>>>     - change the ioctl to use an extensible API
>>>> ---
>>>>    drivers/vhost/net.c              | 61 ++++++++++++++++++++++++++++++--
>>>>    drivers/vhost/vhost.h            |  2 +-
>>>>    include/uapi/linux/vhost.h       |  7 ++++
>>>>    include/uapi/linux/vhost_types.h |  5 +++
>>>>    4 files changed, 71 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>> index 7cbfc7d718b3..f53294440695 100644
>>>> --- a/drivers/vhost/net.c
>>>> +++ b/drivers/vhost/net.c
>>>> @@ -77,6 +77,8 @@ enum {
>>>>    			 (1ULL << VIRTIO_F_RING_RESET)
>>>>    };
>>>>    
>>>> +#define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
>>>> +
>>>>    enum {
>>>>    	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>>>    };
>>>> @@ -1614,7 +1616,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>>>>    	return err;
>>>>    }
>>>>    
>>>> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
>>>> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>>>>    {
>>>>    	size_t vhost_hlen, sock_hlen, hdr_len;
>>>>    	int i;
>>>> @@ -1685,8 +1687,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>>    	void __user *argp = (void __user *)arg;
>>>>    	u64 __user *featurep = argp;
>>>>    	struct vhost_vring_file backend;
>>>> -	u64 features;
>>>> -	int r;
>>>> +	virtio_features_t all_features;
>>>> +	u64 features, count;
>>>> +	int r, i;
>>>>    
>>>>    	switch (ioctl) {
>>>>    	case VHOST_NET_SET_BACKEND:
>>>> @@ -1704,6 +1707,58 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>>    		if (features & ~VHOST_NET_FEATURES)
>>>>    			return -EOPNOTSUPP;
>>>>    		return vhost_net_set_features(n, features);
>>>> +	case VHOST_GET_FEATURES_ARRAY:
>>>> +	{
>>>> +		if (copy_from_user(&count, argp, sizeof(u64)))
>>>> +			return -EFAULT;
>>>> +
>>>> +		/* Copy the net features, up to the user-provided buffer size */
>>>> +		all_features = VHOST_NET_ALL_FEATURES;
>>>> +		for (i = 0; i < min(VIRTIO_FEATURES_WORDS / 2, count); ++i) {
>>>
>>> I think you need to use: array_index_nospec()
>>
>> Do you mean like:
>> 			i = array_index_nospec(i, min(VIRTIO_FEATURES_WORDS / 2, count));
>>
>> ?
>>
>> Note that even if the cpu would speculative execute the loop for too
>> high 'i' values, it will could only read `all_features`, which
>> user-space can access freely.
> 
> I was wrong; I forgot you used a 128-bit integer instead of an array.
> 
>>
>>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>>>> index d7656908f730..3f227114c557 100644
>>>> --- a/include/uapi/linux/vhost_types.h
>>>> +++ b/include/uapi/linux/vhost_types.h
>>>> @@ -110,6 +110,11 @@ struct vhost_msg_v2 {
>>>>    	};
>>>>    };
>>>>    
>>>> +struct vhost_features_array {
>>>> +	__u64 count; /* number of entries present in features array */
>>>> +	__u64 features[];
>>>
>>>
>>> An alternative idea:
>>>
>>> #define VHOST_GET_FEATURES_ARRAY(len) _IOC(_IOC_READ, VHOST_VIRTIO,
>>>                                              0x00, (len))
>>>
>>> By doing so, the kernel can have share the code for
>>> VHOST_GET_FEATURES_ARRAY() with VHOST_GET_FEATURES() since
>>> VHOST_GET_FEATURES() will be just a specialized definition.
>>>
>>> It also makes the life of the userspace a bit easier by not making it
>>> construct struct vhost_features_array.
>>>
>>> Looking at include/uapi, it seems there are examples of both your
>>> pattern and my alternative, so please pick what you prefer.
>>
>> I'm ok either way, but I don't see big win code-wise. The user-space
>> side saving will be literally a one liner. In the kernel the get/set
>> sockopt could be consolidated, but there will be a slightly increase in
>> complexity, to extract the ioctl len from the ioctl op value itself.
> 
> The current patch also requires copy_from_user() to get the count, so I 
> don't think they are different in that sense.
> 
> The difference will be marginal anyway, and it may turn out encoding the 
> length in the ioctl number requires a bit more code.

I'm sorry, almost mid-air collision. I just send out the rfc v3, and I
read your reply here only afterwards.

I stuck to separate ioctls operations; as an additional reason for that,
I understand there is interest in extending the features space even
more, and let user-space/kernel with different features space limits
easily interact.

I think that with a single ioctl either the kernel or the user-space
should be update to handle explicitly every additional features space
expansion, while the API proposed here no additional changes should be
required.

Cheers,

Paolo


