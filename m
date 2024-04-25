Return-Path: <netdev+bounces-91230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEC88B1C91
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AD9B21E9F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4606EB56;
	Thu, 25 Apr 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EprHx6Ci"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAA7764E
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032567; cv=none; b=iTdm+8Rlmrzkn0XL9WhZicmFfbB/h70a5HKqeybTzdWDA2MZDoWjkDyETDWIWio0EwCAVOScVXpPhNP7NuFnhwcU3cQrAEMthrAEIYEO4mdGvRQv7iY3/chzp5ZKE336dXPLwe7j7ET5xmyj8uUcJygaK4m/MtAMsYYsc7tKPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032567; c=relaxed/simple;
	bh=l0jiUqdNehcJ1uEXJAjkz8s3fwgUGIyM3j70jvBunbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gx05dD7A/E845O7HK4AUs5EY+TepbgkISKgekiBaQfp9DKOdE0rfjygaVE+S1JNha0FnoAVQCUlIPG0tTErxeEelUL8jiV+bJGkT+RO3eprN6KTnB+XcfZ8sCJiuU8p3pwXoOd8jRTo+RKrl9xaSN5MXkHaQ5Xtam70U2TCdvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EprHx6Ci; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714032563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imLBDNxLbLfTF3AQIa4pWQdaDJOp7Wo4CTIwtWcPDxs=;
	b=EprHx6CiD+hPgZOkyvsx6Cx9pCsGTjV8XpGVaF8qrHp8jvtNkWCoXdXQcvoyYdGnhCMrdp
	TYwBInzNZr+eXfMFdT/EYz/392edia9NKHTa5kyhK8tFjytIf+p+b+42oAC+MSF8CCQt6k
	4vZwY74nuMHyMM9CRsE4mBmC4oRP+Qc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-VeNVKtr9MSiRzGndZ6FgDw-1; Thu, 25 Apr 2024 04:09:22 -0400
X-MC-Unique: VeNVKtr9MSiRzGndZ6FgDw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78f13d7aa36so93241485a.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714032561; x=1714637361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imLBDNxLbLfTF3AQIa4pWQdaDJOp7Wo4CTIwtWcPDxs=;
        b=jyw4VFRVuVvUdvoeykhUHqpqtVvaOwTWy2Vo4wj8RQq250yMK31v8ZB8i9AQGV/3gK
         JgLNZJZI4VtaB1i3roLPF9Vpbyau2ZXD+GEob8x9oWzX+Wgt6sYHz/Ec4AHElJZe+HuG
         u44/kykaY/xUw3DOlHYA/5qOmESrmDbxali2GgvLeAaKaY3pD5DOci5cJNMthZZ7uL/P
         KrsAPpl667bh/iGmtvJZZT6w++O7QPpVdtHTjD41KcYqITTFi245VQFa62QSxCzH8HNS
         n7oruT4YpdQi8Q8Bb+Y8KzclEDZHNIGw8EmslyzsX0yZlMdx8IX6+cgu0IA0B/3ALy51
         ppsg==
X-Gm-Message-State: AOJu0Yy82949TXPMayvyuk84gWuxNymuUAZPADrNxsVlvuAXT8LagB5v
	pBL9ksjgvrtFijIcNGGczZX7wz0SNSK5lzUAo9JlebBIX8qACkm3RvO0jmv3qiGu4WgPBlpkxK/
	KHF0C+mOjgjGShGkWSTep+21sma0gAfFD/eRobl86jEasbKnrmBPPkqpkWWqN6w==
X-Received: by 2002:a05:620a:4611:b0:790:94bd:ce74 with SMTP id br17-20020a05620a461100b0079094bdce74mr3755993qkb.74.1714032561545;
        Thu, 25 Apr 2024 01:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoEMapR4L20I5rH3ZzbY5ZSn/sNQYpNOfzg6Nj+hoEIjvFCko16TRwE2UAIDl3hQ6xd0d7fA==
X-Received: by 2002:a05:620a:4611:b0:790:94bd:ce74 with SMTP id br17-20020a05620a461100b0079094bdce74mr3755979qkb.74.1714032561264;
        Thu, 25 Apr 2024 01:09:21 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.210.114])
        by smtp.gmail.com with ESMTPSA id r28-20020a05620a03dc00b0079068b347e0sm4414822qkm.92.2024.04.25.01.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 01:09:20 -0700 (PDT)
Message-ID: <43b722cd-f449-4910-8a15-1fcc096f19bc@redhat.com>
Date: Thu, 25 Apr 2024 10:09:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] net: psample: add user cookie
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-4-amorenoz@redhat.com> <ZioHJtWPNbb3bcqT@shredder>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <ZioHJtWPNbb3bcqT@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/25/24 09:32, Ido Schimmel wrote:
> On Wed, Apr 24, 2024 at 03:50:50PM +0200, Adrian Moreno wrote:
>> @@ -579,6 +580,15 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
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
> 
> Did you consider using nla_put() instead?
> 

That's way simpler, thanks. I'll update it and send another version.


> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 92db8ffa2ba2..ea59ca46b119 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -589,15 +589,10 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>                          goto error;
>          }
>   #endif
> -       if (md->user_cookie && md->user_cookie_len) {
> -               int nla_len = nla_total_size(md->user_cookie_len);
> -               struct nlattr *nla;
> -
> -               nla = skb_put(nl_skb, nla_len);
> -               nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
> -               nla->nla_len = nla_attr_size(md->user_cookie_len);
> -               memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
> -       }
> +       if (md->user_cookie && md->user_cookie_len &&
> +           nla_put(nl_skb, PSAMPLE_ATTR_USER_COOKIE, md->user_cookie_len,
> +                   md->user_cookie))
> +               goto error;
>   
>          genlmsg_end(nl_skb, data);
>          psample_nl_obj_desc_init(&desc, group->group_num);
> 


