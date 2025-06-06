Return-Path: <netdev+bounces-195392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0FDACFFDD
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206743A8F49
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66F286881;
	Fri,  6 Jun 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="DnvPduGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EE286880
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203842; cv=none; b=PC+Rssk9MC3ZH8kxs+PVJU2r1FzSBQnE673AC70FOZ+nax6eMCJohQntIm5Tpr/xa4JIsvdcptQWXtkWS40zKbaal4BMn7BgiBeB+oX/RKlN4mtTmmEydtIGXY5OAXaJQzsPGxaooJRsSGY5UqQIlwzhazKuyaYI4haaIGAD7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203842; c=relaxed/simple;
	bh=sOirZ7eYb7y1UO9MMdszGYY3cPSpGPLQ3FL9sduITUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYN4UPwimJhBZinBWRKI11h+2pMteFgTROzvHnjefGiFfLXV2n7FKAyliIcSSXnTK1jJ5nrC2X9of+zC45rRFpDA+iTqX8mVTxvEhtw3rfP891Sw/Z0EgzboNWHKPB7IAXBsMlPdBz9hh/AxPNmjH0iqM6HAdZCm1rq374RcnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=DnvPduGO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747e41d5469so2240305b3a.3
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749203838; x=1749808638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ek+hT4560E7PcChw1SCdDE2YGHVY0ATIzA/WxFP43NM=;
        b=DnvPduGOIF8+2jSdVEHpqbzAmE6x5af886WtiiVsL0Yt8ITr4IqsQW5pUf9QtYvZCX
         DVmGvMkG0GGmPSr5NDK55KBJ5LhhtmJd+HjIuqqmAcjEdmjM4SFHSVQNseiWrJzeOmON
         6c1TtM1rsGvxgWlA2gFWZt1qA2O3Sw/TToNzgy85dgvtmTkW+5CSBkHWzly96F8s1pFw
         eD4Jt58b3Iffw2OS2rqD8qS5Cl9nUL8uylKFxk2BRYkiltctFIeWF6DGBV2zVtm0v88h
         zaY52+kEnuPgJsUL5fd7/wmvDXbgVRciSXKMXTAkTAEuuR3k7LodlBn6b9IzaEZFqRrz
         P7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749203838; x=1749808638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ek+hT4560E7PcChw1SCdDE2YGHVY0ATIzA/WxFP43NM=;
        b=jIy96CVlWpKr7JIeyeYxLPsNV/J1QupiQMEEzfQ/jrAXjG6fgUkLsVBiKL4euvqccf
         S0/b41vkUrweUev1/C5AIJpBBiJCY6n7pibU3pWDWQji7glsADqLiNR+zFSTdKyPrj5S
         GYt1sigt0K6bBMROziMAhCYDXrFNrlxayDnHyYYVh0QPLMpVgzFSANPSkQ0KDhGSCP9j
         uVi9x9Xl+mK23EB292E5N9ZtSO2chFP18Qj5gjd10CwN1NXXFyYrkvCCWU55OYRR5zgn
         IrvVJWQY+rjPrQdeH4gvYewKbUvKFfa2ntKUuwwUmrprtGfAB6uXU3UstXty+xaZ2Wxt
         VeCw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Iy23rERW/ZT/gcsCiSjVw9AjGdxKk+0Sv3xWsceNhN4eMLi+d0aUVk6ZE9vL0ePkaHCkU1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tbd+VEspHfgO0tilG4oBkyYk/2kKSEhAtg4daPUoPGknx2jW
	iz9dx5cyrLHfz4EmTTDQ6G+RmgtCo3mw5LoxYqXafgV5XlG/LrzORqQj7gDgcKAnIpA=
X-Gm-Gg: ASbGncsEJYqBVBC+mCkAeNLhef+mdQkBzz9N5f3OEFVkvJRRVU2dOLZroaHukKlA+Ka
	XwPYVjnZp8fyW1UN8l+1DMj7u4UVZ8/2XDuPQ0faAqEq/4drjHgab+uze8zXk0ZN74ryPk6Rbt/
	GE0PkKFzu1R46ngSmG0sV33f0iDN/QCHsdnJPuTlwxcENMW8mL1ZYBPuI4YBZeNrrDKk/J6otXi
	mRYf5+6Xu2Nlmv8Gov/Nxfihlo9kbqxxRiJoMtrfRMBN+9kmAVSBryIyTXpH3oWLX21FIgaEs8a
	1bvFE/dfMM8m9N5twfsrwcdRDhJGsziEjploSND3uwt9o5/RCZNsJeg3+AgDLGD4l5pmwKSl59s
	=
X-Google-Smtp-Source: AGHT+IFMWrbaAriqzlw98FQShXPzRTZew1R66AEp3JLaUcbgoytS6fZHgKdSxG380PejwUYGS7f5rw==
X-Received: by 2002:a05:6a00:21d3:b0:746:3200:5f8 with SMTP id d2e1a72fcca58-74827f304f8mr3677897b3a.22.1749203838464;
        Fri, 06 Jun 2025 02:57:18 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7b29esm945812b3a.70.2025.06.06.02.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 02:57:18 -0700 (PDT)
Message-ID: <fc27ca0b-c00e-4461-9890-746a237e48bc@daynix.com>
Date: Fri, 6 Jun 2025 18:57:14 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f0ee95b7-6830-4a53-8d6b-0edf1a7ab142@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/03 22:32, Paolo Abeni wrote:
> On 5/31/25 8:15 AM, Akihiko Odaki wrote:
>> On 2025/05/30 23:49, Paolo Abeni wrote:
>>> Use the extended feature type for 'acked_features' and implement
>>> two new ioctls operation allowing the user-space to set/query an
>>> unbounded amount of features.
>>>
>>> The actual number of processed features is limited by virtio_features_t
>>> size, and attempts to set features above such limit fail with
>>> EOPNOTSUPP.
>>>
>>> Note that the legacy ioctls implicitly truncate the negotiated
>>> features to the lower 64 bits range.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>>     - change the ioctl to use an extensible API
>>> ---
>>>    drivers/vhost/net.c              | 61 ++++++++++++++++++++++++++++++--
>>>    drivers/vhost/vhost.h            |  2 +-
>>>    include/uapi/linux/vhost.h       |  7 ++++
>>>    include/uapi/linux/vhost_types.h |  5 +++
>>>    4 files changed, 71 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>>> index 7cbfc7d718b3..f53294440695 100644
>>> --- a/drivers/vhost/net.c
>>> +++ b/drivers/vhost/net.c
>>> @@ -77,6 +77,8 @@ enum {
>>>    			 (1ULL << VIRTIO_F_RING_RESET)
>>>    };
>>>    
>>> +#define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
>>> +
>>>    enum {
>>>    	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>>    };
>>> @@ -1614,7 +1616,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>>>    	return err;
>>>    }
>>>    
>>> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
>>> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>>>    {
>>>    	size_t vhost_hlen, sock_hlen, hdr_len;
>>>    	int i;
>>> @@ -1685,8 +1687,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>    	void __user *argp = (void __user *)arg;
>>>    	u64 __user *featurep = argp;
>>>    	struct vhost_vring_file backend;
>>> -	u64 features;
>>> -	int r;
>>> +	virtio_features_t all_features;
>>> +	u64 features, count;
>>> +	int r, i;
>>>    
>>>    	switch (ioctl) {
>>>    	case VHOST_NET_SET_BACKEND:
>>> @@ -1704,6 +1707,58 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>>    		if (features & ~VHOST_NET_FEATURES)
>>>    			return -EOPNOTSUPP;
>>>    		return vhost_net_set_features(n, features);
>>> +	case VHOST_GET_FEATURES_ARRAY:
>>> +	{
>>> +		if (copy_from_user(&count, argp, sizeof(u64)))
>>> +			return -EFAULT;
>>> +
>>> +		/* Copy the net features, up to the user-provided buffer size */
>>> +		all_features = VHOST_NET_ALL_FEATURES;
>>> +		for (i = 0; i < min(VIRTIO_FEATURES_WORDS / 2, count); ++i) {
>>
>> I think you need to use: array_index_nospec()
> 
> Do you mean like:
> 			i = array_index_nospec(i, min(VIRTIO_FEATURES_WORDS / 2, count));
> 
> ?
> 
> Note that even if the cpu would speculative execute the loop for too
> high 'i' values, it will could only read `all_features`, which
> user-space can access freely.

I was wrong; I forgot you used a 128-bit integer instead of an array.

> 
>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>>> index d7656908f730..3f227114c557 100644
>>> --- a/include/uapi/linux/vhost_types.h
>>> +++ b/include/uapi/linux/vhost_types.h
>>> @@ -110,6 +110,11 @@ struct vhost_msg_v2 {
>>>    	};
>>>    };
>>>    
>>> +struct vhost_features_array {
>>> +	__u64 count; /* number of entries present in features array */
>>> +	__u64 features[];
>>
>>
>> An alternative idea:
>>
>> #define VHOST_GET_FEATURES_ARRAY(len) _IOC(_IOC_READ, VHOST_VIRTIO,
>>                                              0x00, (len))
>>
>> By doing so, the kernel can have share the code for
>> VHOST_GET_FEATURES_ARRAY() with VHOST_GET_FEATURES() since
>> VHOST_GET_FEATURES() will be just a specialized definition.
>>
>> It also makes the life of the userspace a bit easier by not making it
>> construct struct vhost_features_array.
>>
>> Looking at include/uapi, it seems there are examples of both your
>> pattern and my alternative, so please pick what you prefer.
> 
> I'm ok either way, but I don't see big win code-wise. The user-space
> side saving will be literally a one liner. In the kernel the get/set
> sockopt could be consolidated, but there will be a slightly increase in
> complexity, to extract the ioctl len from the ioctl op value itself.

The current patch also requires copy_from_user() to get the count, so I 
don't think they are different in that sense.

The difference will be marginal anyway, and it may turn out encoding the 
length in the ioctl number requires a bit more code.

Regards,
Akihiko Odaki

