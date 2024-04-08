Return-Path: <netdev+bounces-85898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095989CC68
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D11F24DF3
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5342F145B03;
	Mon,  8 Apr 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4+QKVmT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CA1442E3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604513; cv=none; b=QLWZeKpX16qpp3Ex9zEnM7jLBjVXTDn+LRxjPUTOnwEagcg7g2099OQkC8cL1Cud5+852c9Vi4Ds9PedI8XCcrxhw4ZObcZZTpbgTsT3pWQEXzTUkMnkVk2SD3qMuC/cgEKoBm+q5QmSkYl462PXVnKjqiOp/Il6oY/NxOBWAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604513; c=relaxed/simple;
	bh=8cUA+FdAAF4Ec4Z4HTE1vK+Td7ijCg4z5qbRzMG08vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwu+/lN29wKUvw5T3Mv5IAmS9GqRyPRNgVZEPoamj4OM55peGZLY7usrmpnRAjIOdTRiH5o0Si3+ZLE2QafQk5vC+6Ei595dZIEdsUNBMwisb9bNAX9rALJkYEQbfvOXawT5O2HGyTSea6nDyb4z8LkirWKY15diJWw6rxIzZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4+QKVmT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712604510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAou/CMWzBfn5OVlLzFZnjRVpS64wwZORmC1Hh2OlDc=;
	b=A4+QKVmT2l53npUSj7PKTyK/v2UrmZQoLXiJpk1dSMtm8huNP0kDCTc2e5VjetH0Olah0W
	w/VynwnefkJir27H7bp6t0pzB3D9K7gnyRWCv2uvJZG6YqpE4jYC1D45I0NLYmGvH4VEhi
	Mc/uCxGu2zxDKdkSRMbZ7u8mMcV+tWs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-N0shza94MKWruJmQrdUJAg-1; Mon, 08 Apr 2024 15:28:28 -0400
X-MC-Unique: N0shza94MKWruJmQrdUJAg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43493db2263so19326471cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604508; x=1713209308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAou/CMWzBfn5OVlLzFZnjRVpS64wwZORmC1Hh2OlDc=;
        b=NRENNz6wwWdT59J9DHfxx2N7s15RiYTPO+rugb44SExdWPVLLBQIgHNr6RR4ghWVlc
         2xBEXPnA+/EaPA/+095XvJ5h/EJcl0mjGsacJRfhQM6PjAurddY11kITbKPtc82A5RcF
         HAhdSQ8YeafpDsRJMjVvSPgNURqMpnbmkqcOrJBuXANPSMfoCVSuLTEaqr/nAfAqVtxD
         3amjrOVO67JZvLgxJDuQ4N2PWnLChIYbef1CC3O4AM/TsG9FLK91urNirmS+SJWMjSqd
         U3qCxiA7SAsPI9EzqxQtu47vovdaIY2i9ajt9Bq8ULEkli9IA4pNxMR49+hb5E61jN/E
         2TIA==
X-Forwarded-Encrypted: i=1; AJvYcCVRnKkF31mXiVZ3umSqQ4xzhYIeL3ooeIkrwcoirUE1s/n/GFWZ4Ab/8kdmNirzWl8hmVqUkUHzPuvbBvPspcV7yWflSb4Z
X-Gm-Message-State: AOJu0YyLj4r5bnAlgM+dd8q6dYLoIaXawhbt5nJAd5YKj40fbnQXQyvW
	PaoiD5UpxWj6CjaAym9SE0ORdguO+QvU/2/cWqRQriEMd7rhXRqjxhcyNS22yjuAhgFD1UiBADi
	7cpRTNVy8fVssD5yR51Z8qZ4UhEqu/J2FlkQsWBHCUhfVm7KXgGIOsA==
X-Received: by 2002:a05:622a:190b:b0:434:a4dc:b271 with SMTP id w11-20020a05622a190b00b00434a4dcb271mr3574071qtc.2.1712604508272;
        Mon, 08 Apr 2024 12:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcQr1kpRtH3jncQG3xUg9dSY3QYMaiOuqjPljxfJJ1M5Em2YFMuVh1ZNT7ae8meB33x14mKg==
X-Received: by 2002:a05:622a:190b:b0:434:a4dc:b271 with SMTP id w11-20020a05622a190b00b00434a4dcb271mr3574050qtc.2.1712604507978;
        Mon, 08 Apr 2024 12:28:27 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id j17-20020ac86651000000b004348b9b9933sm1740137qtp.27.2024.04.08.12.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 12:28:27 -0700 (PDT)
Message-ID: <aa9392bc-13ac-4d96-8ef8-f9b08c25b154@redhat.com>
Date: Mon, 8 Apr 2024 21:28:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 3/5] net: psample: add user cookie
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, cmi@nvidia.com,
 yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com, horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-4-amorenoz@redhat.com>
 <281c9e36-6a83-488e-b104-09d80aef83fc@ovn.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <281c9e36-6a83-488e-b104-09d80aef83fc@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/24 15:19, Ilya Maximets wrote:
> [copying my previous reply since this version actually has netdev@ in Cc]
> 
> On 4/8/24 14:57, Adrian Moreno wrote:
>> Add a user cookie to the sample metadata so that sample emitters can
>> provide more contextual information to samples.
>>
>> If present, send the user cookie in a new attribute:
>> PSAMPLE_ATTR_USER_COOKIE.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   include/net/psample.h        |  2 ++
>>   include/uapi/linux/psample.h |  1 +
>>   net/psample/psample.c        | 12 +++++++++++-
>>   3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/psample.h b/include/net/psample.h
>> index 0509d2d6be67..2503ab3c92a5 100644
>> --- a/include/net/psample.h
>> +++ b/include/net/psample.h
>> @@ -25,6 +25,8 @@ struct psample_metadata {
>>   	   out_tc_occ_valid:1,
>>   	   latency_valid:1,
>>   	   unused:5;
>> +	u8 *user_cookie;
> 
> The code doesn't take ownership of this data.  It should probably
> be a const pointer in this case.
> 
> This should also allow us to avoid a double copy first to the
> psample_metadata and then to netlink skb, as users will know that
> it is a const pointer and so they can hand the data directly.
> 

Yep. You're right.


>> +	u32 user_cookie_len;
>>   };
>>   
>>   struct psample_group *psample_group_get(struct net *net, u32 group_num);
>> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
>> index 5e0305b1520d..1f61fd7ef7fd 100644
>> --- a/include/uapi/linux/psample.h
>> +++ b/include/uapi/linux/psample.h
>> @@ -19,6 +19,7 @@ enum {
>>   	PSAMPLE_ATTR_LATENCY,		/* u64, nanoseconds */
>>   	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
>>   	PSAMPLE_ATTR_PROTO,		/* u16 */
>> +	PSAMPLE_ATTR_USER_COOKIE,
> 
> A comment would be nice.
> 

Definitely.

>>   
>>   	__PSAMPLE_ATTR_MAX
>>   };
>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>> index a0cef63dfdec..9fdb88e01f21 100644
>> --- a/net/psample/psample.c
>> +++ b/net/psample/psample.c
>> @@ -497,7 +497,8 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>   		   nla_total_size(sizeof(u32)) +	/* group_num */
>>   		   nla_total_size(sizeof(u32)) +	/* seq */
>>   		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
>> -		   nla_total_size(sizeof(u16));		/* protocol */
>> +		   nla_total_size(sizeof(u16)) +	/* protocol */
>> +		   nla_total_size(md->user_cookie_len);	/* user_cookie */
>>   
>>   #ifdef CONFIG_INET
>>   	tun_info = skb_tunnel_info(skb);
>> @@ -596,6 +597,15 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>>   			goto error;
>>   	}
>>   #endif
>> +	if (md->user_cookie && md->user_cookie_len) {
>> +		int nla_len = nla_total_size(md->user_cookie_len);
>> +		struct nlattr *nla;
>> +
>> +		nla = skb_put(nl_skb, nla_len);
>> +		nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
>> +		nla->nla_len = nla_attr_size(md->user_cookie_len);
>> +		memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
>> +	}
>>   
>>   	genlmsg_end(nl_skb, data);
>>   	psample_nl_obj_desc_init(&desc, group->group_num);
> 


