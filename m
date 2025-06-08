Return-Path: <netdev+bounces-195533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E36AD1109
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 07:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CECD3AA467
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70892191499;
	Sun,  8 Jun 2025 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Sxwj6HFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46EAE573
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749360512; cv=none; b=HfGypp+Otr9K5jSrR/wucpH9tgreYltccFJwKqEvv3pYZazp631CV60PHOohiKPdB0eydrkoCfVlMKsmAmkLScIpLWm8Fw0Sau0+L6PFg/qztlegl8CUypP1bt5RcsqIQ1ZlM5aS0v+v4NjmltBzY7mS0WiphtabO/akD6VRC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749360512; c=relaxed/simple;
	bh=IINu2gAbLpFxYv4xnlnDp6lZR9HUu7c5unpKANkeHXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHBpUzSc+/OFOze/i9h6KrEPgLZXKiDWZjl9lNr2VNVARUGuoyK1fVbYZKfdGgBQUmt+k75tabzyIyriUjfdWl22EcxQr6Cz/eHGmWgvY/f7wDo0jX1fCiYuzWjfVvYL7FEqWvnkB+wPiUg1nGLxFuM6RYA2UMiceQhMv+EQAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Sxwj6HFA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-312a62055d0so3363907a91.3
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 22:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749360510; x=1749965310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTIrSIuhxPxy2+kWPEOiaK5ZIVwsN/kS2fj/ol82KfA=;
        b=Sxwj6HFAUuUZLzP7RnqFkKKcM4zr7N826XsKUygGAM+3GosFdT2/Fi6/DJduhm8gAC
         UUvPMUXB7jJF/hKBpPvyq2fhV7h2eTi6ruvBf2wWtDca6KbsZ9zdzy7csvp6IWUXjKmD
         Rv1XUqoLe2PbsZ1G2g7V8T8aBxMwd2eIHcr9J2xA3KT8xj/+c1HMA/YW5OtTQImZpXq1
         1s08IYsFddqv1Bh8BjqS2EzUvTwKAWGqq8aTtht15ra3zFxDNDhjzdT2HYmck+7Py3l8
         C7DNO3mKe4feSAChrxTRbw10844q/Lx3mCvwz0E601jpKhSFW0tOJjLDVIsHYEg/1vFN
         6nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749360510; x=1749965310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTIrSIuhxPxy2+kWPEOiaK5ZIVwsN/kS2fj/ol82KfA=;
        b=thWiT0C2yeb5HVvKzjtgejy6Rw4sG/mIVyQdhp5gPulPn9muwpsbmOKDln92Eans8F
         PcIxv6pe3iivOh5GhMOOhkhQO1yJHBzhwi+cZfiz+l6xGeEFGhIc22DehsuU2V+vmRMY
         92lmlWKRg0qddY4efZ5+VfTkeNM5T0a7xWXsK22gdHsQ+HGCiTKm1lcd/qFUXuKcoGO5
         DNp9/9237soV0TpFxvcBcxaHNpyN+pTr0L6S1uelGwpNcGfkgRNnIAOxjImewJW58JX4
         8ZgogVYclcQKAoWc86qFUl/7Hmev5eUe+SK+QUalWaBFyVNqdrbkdtANdu+67B+kAcKl
         lIPw==
X-Forwarded-Encrypted: i=1; AJvYcCVIP+tTXsvxPfPpfd3LjPwrL6TY4UV4FxumMvq4zY1WJcVchDIWVRQSA5VJeJ/xG7QQwKMrbKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Yip+DvNyJl+kpNYJbzeQS0t9GJicOHkCqI2trecsrM5l+sNc
	ylDOfgNKuxlJduZDtM8Xcge+m3naoU/5jd3Nh4PV/7FWLI/KFKOiM2A3dlL35gawGGE=
X-Gm-Gg: ASbGncuyFuJyW9V0M7WIU8eqhKVCPQ+JlCC9Ol3M5gVr65JKXNvi7rT8Pt25TZwCrP1
	gQ7Guket8n+VNxb/4DnZL2sEjOK3mwE1rRI59bAMhI102ss3Q9/tJGW3Oo7r/cmt1++JlFZw3of
	THQZAvRRbSa8G7utc3hQhqtv5PLpKIUIX+0ZdSXSbasv1Xe4RsYxgbF9tSpELSehPgt+J2p11GW
	0bribot2mcXUDI1Kk8tlRo+IFsUXuN5yOqEukhCk+80NgxOlQ0TL5Dlige9SDnp+gUr6ZkOV91r
	obCKxvCy3J2I88M1IQstFjytxQkF/KWlDhbJpfAR+VLl51blHGlBLxQMsi5N8kCpVHQ3UVbsqaU
	=
X-Google-Smtp-Source: AGHT+IEE8tI2u8ucfQU7WyYCTdrk+OAbUP4wpQT9Z0fDhYvJfRms1v711D1BM8a7JuW+VzQt1/Dl9w==
X-Received: by 2002:a17:90a:e7d2:b0:311:c1ec:7d05 with SMTP id 98e67ed59e1d1-31347077473mr12786035a91.35.1749360509797;
        Sat, 07 Jun 2025 22:28:29 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b044e2bsm3571939a91.5.2025.06.07.22.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 22:28:29 -0700 (PDT)
Message-ID: <ece8f139-fcd4-4b55-b4bb-3a62da66ad01@daynix.com>
Date: Sun, 8 Jun 2025 14:28:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
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
 <936eaedc-d4e0-446c-9667-82ee4d0e1ab2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <936eaedc-d4e0-446c-9667-82ee4d0e1ab2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/06 20:52, Paolo Abeni wrote:
> On 6/6/25 11:57 AM, Akihiko Odaki wrote:
>> On 2025/06/03 22:32, Paolo Abeni wrote:
>>> On 5/31/25 8:15 AM, Akihiko Odaki wrote:
>>>> On 2025/05/30 23:49, Paolo Abeni wrote:
>>>>> Use the extended feature type for 'acked_features' and implement
>>>>> two new ioctls operation allowing the user-space to set/query an
>>>>> unbounded amount of features.
>>>>>
>>>>> The actual number of processed features is limited by virtio_features_t
>>>>> size, and attempts to set features above such limit fail with
>>>>> EOPNOTSUPP.
>>>>>
>>>>> Note that the legacy ioctls implicitly truncate the negotiated
>>>>> features to the lower 64 bits range.
>>>>>
>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>> ---
>>>>> v1 -> v2:
>>>>>      - change the ioctl to use an extensible API
>>>>> ---
>>>>>     drivers/vhost/net.c              | 61 ++++++++++++++++++++++++++++++--
>>>>>     drivers/vhost/vhost.h            |  2 +-
>>>>>     include/uapi/linux/vhost.h       |  7 ++++
>>>>>     include/uapi/linux/vhost_types.h |  5 +++
>>>>>     4 files changed, 71 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>>>> index 7cbfc7d718b3..f53294440695 100644
>>>>> --- a/drivers/vhost/net.c
>>>>> +++ b/drivers/vhost/net.c
>>>>> @@ -77,6 +77,8 @@ enum {
>>>>>     			 (1ULL << VIRTIO_F_RING_RESET)
>>>>>     };
>>>>>     
>>>>> +#define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
>>>>> +
>>>>>     enum {
>>>>>     	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>>>>     };
>>>>> @@ -1614,7 +1616,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>>>>>     	return err;
>>>>>     }
>>>>>     
>>>>> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
>>>>> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>>>>>     {
>>>>>     	size_t vhost_hlen, sock_hlen, hdr_len;
>>>>>     	int i;
>>>>> @@ -1685,8 +1687,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>>>     	void __user *argp = (void __user *)arg;
>>>>>     	u64 __user *featurep = argp;
>>>>>     	struct vhost_vring_file backend;
>>>>> -	u64 features;
>>>>> -	int r;
>>>>> +	virtio_features_t all_features;
>>>>> +	u64 features, count;
>>>>> +	int r, i;
>>>>>     
>>>>>     	switch (ioctl) {
>>>>>     	case VHOST_NET_SET_BACKEND:
>>>>> @@ -1704,6 +1707,58 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>>>     		if (features & ~VHOST_NET_FEATURES)
>>>>>     			return -EOPNOTSUPP;
>>>>>     		return vhost_net_set_features(n, features);
>>>>> +	case VHOST_GET_FEATURES_ARRAY:
>>>>> +	{
>>>>> +		if (copy_from_user(&count, argp, sizeof(u64)))
>>>>> +			return -EFAULT;
>>>>> +
>>>>> +		/* Copy the net features, up to the user-provided buffer size */
>>>>> +		all_features = VHOST_NET_ALL_FEATURES;
>>>>> +		for (i = 0; i < min(VIRTIO_FEATURES_WORDS / 2, count); ++i) {
>>>>
>>>> I think you need to use: array_index_nospec()
>>>
>>> Do you mean like:
>>> 			i = array_index_nospec(i, min(VIRTIO_FEATURES_WORDS / 2, count));
>>>
>>> ?
>>>
>>> Note that even if the cpu would speculative execute the loop for too
>>> high 'i' values, it will could only read `all_features`, which
>>> user-space can access freely.
>>
>> I was wrong; I forgot you used a 128-bit integer instead of an array.
>>
>>>
>>>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>>>>> index d7656908f730..3f227114c557 100644
>>>>> --- a/include/uapi/linux/vhost_types.h
>>>>> +++ b/include/uapi/linux/vhost_types.h
>>>>> @@ -110,6 +110,11 @@ struct vhost_msg_v2 {
>>>>>     	};
>>>>>     };
>>>>>     
>>>>> +struct vhost_features_array {
>>>>> +	__u64 count; /* number of entries present in features array */
>>>>> +	__u64 features[];
>>>>
>>>>
>>>> An alternative idea:
>>>>
>>>> #define VHOST_GET_FEATURES_ARRAY(len) _IOC(_IOC_READ, VHOST_VIRTIO,
>>>>                                               0x00, (len))
>>>>
>>>> By doing so, the kernel can have share the code for
>>>> VHOST_GET_FEATURES_ARRAY() with VHOST_GET_FEATURES() since
>>>> VHOST_GET_FEATURES() will be just a specialized definition.
>>>>
>>>> It also makes the life of the userspace a bit easier by not making it
>>>> construct struct vhost_features_array.
>>>>
>>>> Looking at include/uapi, it seems there are examples of both your
>>>> pattern and my alternative, so please pick what you prefer.
>>>
>>> I'm ok either way, but I don't see big win code-wise. The user-space
>>> side saving will be literally a one liner. In the kernel the get/set
>>> sockopt could be consolidated, but there will be a slightly increase in
>>> complexity, to extract the ioctl len from the ioctl op value itself.
>>
>> The current patch also requires copy_from_user() to get the count, so I
>> don't think they are different in that sense.
>>
>> The difference will be marginal anyway, and it may turn out encoding the
>> length in the ioctl number requires a bit more code.
> 
> I'm sorry, almost mid-air collision. I just send out the rfc v3, and I
> read your reply here only afterwards.
> 
> I stuck to separate ioctls operations; as an additional reason for that,
> I understand there is interest in extending the features space even
> more, and let user-space/kernel with different features space limits
> easily interact.
> 
> I think that with a single ioctl either the kernel or the user-space
> should be update to handle explicitly every additional features space
> expansion, while the API proposed here no additional changes should be
> required.

It is not a problem with the VHOST_GET_FEATURES_ARRAY() macro I 
suggested. It takes the size of array as a parameter, enabling it to 
grow without updating the ioctl definition.

Regards,
Akihiko Odaki

