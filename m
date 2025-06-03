Return-Path: <netdev+bounces-194789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D85ACC7DD
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E1C3A5A58
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB632040B6;
	Tue,  3 Jun 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Ga6MFe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9122DFE8
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957541; cv=none; b=tQfCGjEdHh0Dg46uoY+yfefIaSyLmKzBbp0t63bs1fpWrHDkl8/SU5Zc0wl/1saozhSseBCU35gtNOH2q4gZOne6XajBH35MXYpTZgXQhEPZd2Z4HAeWBPnByqTk6aBGhxwbCEJOdM+ljp2lQkR1yGA4c9/n+s2D9paC19j7J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957541; c=relaxed/simple;
	bh=hgrKRGr/bJsrA/KEB2BfjffXjMgdvvx1sCK5IHQ9hwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiBxSroB9ls/QjUJhTyI4o0g36M57mGK3wHt6SuxsKwAkvuEYGdvwpcC8zjeyVTTwbDSwpaG8hCnhQFrHBfa5HmI+eQDaGh9NzeisCba8GIu97KxAAN0q7s8RhjLU5k2sYWeyc2r7uarLu9njhJE2G96ttBt7059q44GaA0iVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5Ga6MFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748957538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzBXMB1UkdXo9l9ESHxPhGCM724oqaX2W4jhpDSOmTI=;
	b=A5Ga6MFeTPt/VgSnsBvLULVmpaIeI9Vqhxo7jEKAFNmz5ilIk3I97t1TvTO2MVScr1Wj0A
	W7v6w8p025E61BuO2ymtFlntgtO+iyodw+z3iWeYNgZkgGlbjZdGZxMf2pLwJ7CYLCNrI6
	kurNg1d8ioaY56L1vBb0nyb305bKWxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-rBbSeoKKMMiYzEMRj-Ypyw-1; Tue, 03 Jun 2025 09:32:17 -0400
X-MC-Unique: rBbSeoKKMMiYzEMRj-Ypyw-1
X-Mimecast-MFC-AGG-ID: rBbSeoKKMMiYzEMRj-Ypyw_1748957536
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-445135eb689so32301935e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 06:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957536; x=1749562336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzBXMB1UkdXo9l9ESHxPhGCM724oqaX2W4jhpDSOmTI=;
        b=bsiBcUAEnID1UjaxD6rzc+1GzGUCUG0SSMcWUIjd5efwXxYlrlLTqy2zJbIqTv/dAW
         aud156UrSGhfK3Bih9w10ScnaxOP2ms3cZflQ0HE0JoBTn0WsZVbc7PHk7X3TcHUH30S
         vIJo55kGVKDE4IOJ9yjbrk8xecKbhPjg2Y8gMGYqGizU/iyWxhSsM0+odxtAUJw+9noS
         hchC1HSpSqBgioWBt5xES9ehIjrG/qwfqvtgqXr3HlptchEiKTgyXQUzMpEa4RwQoFsn
         dizPBHoaiok+lURi+4rb+eATBE/Lki363ek8KrN0SkVwrsL2bNEAxEDpWi7Oz/Bt6Jm+
         4tzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV2HiBfAN4VpD5CjyhJ7h+cMq0J6PlGfByCWVvfTNmbi4K9RT7zvQlz2ita/gvbqmnFy7IRfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqgWFEQYlUo2qwb+FL3ycNk0uSse86tDb82OKfZCtNzU+ERvt
	npiFgAZS57lqpL4+qC5RG8/jCYTXx7IFFgFSlOiwD8myLOm1GIkh2l7KD+2NAG/ae3n1sG+taHD
	61se+Wj8we2ILIoKiwYptjIk4wd4B9pbzwqu4RVOGzl0IYunZxHeU/Zuimg==
X-Gm-Gg: ASbGncu5j5EI2EXeJQYiWWTS8pX3Y64SmDdqbAwVJOKWaOyBZySqkWniMFn2kGWIAoZ
	9PQcWyL7F1VYAJHJXj3oFuT4l9sGiZDAuyCsjf2eJUGGQVKOo6mh5heYE0veF0SK0zN5j0Vn+97
	b4LDEOYzQWreCsaTiooiCkXQlpZlg8wm2wYkoKBvcTzQTIi1ggOrj6qOidw3c5sYQl6V7Uz1SA4
	KhdRvVxX3qQnUMAlAdK/mYGtmu/wkqKsrOxYjl0Hn2qOADyeQtBme6tn53tPzEzX3aRgTWhiFOK
	W+oTyG0nktJvmPix+hg=
X-Received: by 2002:a05:600c:1d98:b0:441:d43d:4f68 with SMTP id 5b1f17b1804b1-450d64e249fmr159455985e9.15.1748957536090;
        Tue, 03 Jun 2025 06:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEATHdjgjlMSYDYv4JhpH58dcqODfa4naOytvhMKwxONc9OrXZOaV4Qobq6Kq0ftMq55sRIcA==
X-Received: by 2002:a05:600c:1d98:b0:441:d43d:4f68 with SMTP id 5b1f17b1804b1-450d64e249fmr159455435e9.15.1748957535618;
        Tue, 03 Jun 2025 06:32:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210::f39? ([2a0d:3341:cc2d:3210::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451e505c350sm24708085e9.0.2025.06.03.06.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 06:32:14 -0700 (PDT)
Message-ID: <f0ee95b7-6830-4a53-8d6b-0edf1a7ab142@redhat.com>
Date: Tue, 3 Jun 2025 15:32:13 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9eae960a-0226-46e2-a6f4-95c91800268c@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/25 8:15 AM, Akihiko Odaki wrote:
> On 2025/05/30 23:49, Paolo Abeni wrote:
>> Use the extended feature type for 'acked_features' and implement
>> two new ioctls operation allowing the user-space to set/query an
>> unbounded amount of features.
>>
>> The actual number of processed features is limited by virtio_features_t
>> size, and attempts to set features above such limit fail with
>> EOPNOTSUPP.
>>
>> Note that the legacy ioctls implicitly truncate the negotiated
>> features to the lower 64 bits range.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>    - change the ioctl to use an extensible API
>> ---
>>   drivers/vhost/net.c              | 61 ++++++++++++++++++++++++++++++--
>>   drivers/vhost/vhost.h            |  2 +-
>>   include/uapi/linux/vhost.h       |  7 ++++
>>   include/uapi/linux/vhost_types.h |  5 +++
>>   4 files changed, 71 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 7cbfc7d718b3..f53294440695 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -77,6 +77,8 @@ enum {
>>   			 (1ULL << VIRTIO_F_RING_RESET)
>>   };
>>   
>> +#define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
>> +
>>   enum {
>>   	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>>   };
>> @@ -1614,7 +1616,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>>   	return err;
>>   }
>>   
>> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
>> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>>   {
>>   	size_t vhost_hlen, sock_hlen, hdr_len;
>>   	int i;
>> @@ -1685,8 +1687,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>   	void __user *argp = (void __user *)arg;
>>   	u64 __user *featurep = argp;
>>   	struct vhost_vring_file backend;
>> -	u64 features;
>> -	int r;
>> +	virtio_features_t all_features;
>> +	u64 features, count;
>> +	int r, i;
>>   
>>   	switch (ioctl) {
>>   	case VHOST_NET_SET_BACKEND:
>> @@ -1704,6 +1707,58 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>>   		if (features & ~VHOST_NET_FEATURES)
>>   			return -EOPNOTSUPP;
>>   		return vhost_net_set_features(n, features);
>> +	case VHOST_GET_FEATURES_ARRAY:
>> +	{
>> +		if (copy_from_user(&count, argp, sizeof(u64)))
>> +			return -EFAULT;
>> +
>> +		/* Copy the net features, up to the user-provided buffer size */
>> +		all_features = VHOST_NET_ALL_FEATURES;
>> +		for (i = 0; i < min(VIRTIO_FEATURES_WORDS / 2, count); ++i) {
> 
> I think you need to use: array_index_nospec()

Do you mean like:
			i = array_index_nospec(i, min(VIRTIO_FEATURES_WORDS / 2, count));

?

Note that even if the cpu would speculative execute the loop for too
high 'i' values, it will could only read `all_features`, which
user-space can access freely.

>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index d7656908f730..3f227114c557 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -110,6 +110,11 @@ struct vhost_msg_v2 {
>>   	};
>>   };
>>   
>> +struct vhost_features_array {
>> +	__u64 count; /* number of entries present in features array */
>> +	__u64 features[];
> 
> 
> An alternative idea:
> 
> #define VHOST_GET_FEATURES_ARRAY(len) _IOC(_IOC_READ, VHOST_VIRTIO,
>                                             0x00, (len))
> 
> By doing so, the kernel can have share the code for 
> VHOST_GET_FEATURES_ARRAY() with VHOST_GET_FEATURES() since 
> VHOST_GET_FEATURES() will be just a specialized definition.
> 
> It also makes the life of the userspace a bit easier by not making it 
> construct struct vhost_features_array.
> 
> Looking at include/uapi, it seems there are examples of both your 
> pattern and my alternative, so please pick what you prefer.

I'm ok either way, but I don't see big win code-wise. The user-space
side saving will be literally a one liner. In the kernel the get/set
sockopt could be consolidated, but there will be a slightly increase in
complexity, to extract the ioctl len from the ioctl op value itself.

/P


