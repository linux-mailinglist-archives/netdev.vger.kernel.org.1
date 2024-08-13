Return-Path: <netdev+bounces-118111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8A9508C0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B3B284B52
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665BB1A0712;
	Tue, 13 Aug 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7og9PxR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64741A08A1
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562240; cv=none; b=CkXTKFUaSA1Z4jxWIQC2oqfX6Bf0hS7SgPNTAnzd+zd5o6EjHhT+Vd/wPPHu+DtZXxMpJ+ipIijIoCHmkFh9KNLJhlMS7/RoANQF/UC1izvvUN6RVd76ygAo3zcRgwZz6WlG6UXVW96Mt97QquHRouDSBvVj9VW5XW6N9KrLBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562240; c=relaxed/simple;
	bh=Bq6znnGat20Ad00SAWKp+fWfe1BjcDK3uZZaqoSE3k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCB7a2dt0DJZWZZA4FuO1UpI3XCrAo9B1J8dz3YTZHgeCfhn1IENpJ0RAvmcgFEgCBTBivaNBuvPbxuc5ALwvl7oFf5imQI9HEq8tuy7mCS/feH6DELJ6wLLSIqHm6/TmV0Dbpp8OkUHQSU28KLMTy9JgJjdtzJ4leNOf3bLwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7og9PxR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723562237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZjcQvteijPS8JjH5ua+iZS3LbCVa2x8U59/CQKyXUQ=;
	b=a7og9PxRzdDs11rVcw2Mf5G0gQopeecOmFFVSlytkvA8YO1uCnu9PSpKNUwPqCQ2qQ4l++
	xYE6cFgSkCCJ3HTLr602XklJIUKJm7U/5J9hLsYhN25FZto960gYmo7xSCcjXzuPsYL60m
	BREbUArBhGCe/019WLTedldH8uAUXmM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-5BSL57wQO3WRaIkjnwZD4g-1; Tue, 13 Aug 2024 11:17:16 -0400
X-MC-Unique: 5BSL57wQO3WRaIkjnwZD4g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso10436205e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562235; x=1724167035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZjcQvteijPS8JjH5ua+iZS3LbCVa2x8U59/CQKyXUQ=;
        b=bh5SoAFVOKm+mrrR2JUnKUWaXOUuzJVA92NJ93tcfiFBykggHkxp3levGMEY4CyKw+
         D08WfYJuheNrRMjsrbdzeARDu2LPptp3B08bjKQCwc+T+ntJP9Ac3Mw66zz+NuouzGgv
         eukExNSvSB0Gos0/oknmJglpgOHcPSJfds9AgvZ3xFV2r3kjmi/0B/Zpg/obqpXlskgi
         mfi5tx97RfGdTIROLsy/VKn0nlYGj+cmtO67SwYumTDXkyb1yRZLgzmdYqPbWs40aTwP
         /L+R/F7rEYmiaeND+AhL3E+PJfmbc1j/4jwgLhiVlGcc1fy6vqH5D5gnp2NysMhHA4QT
         IeZQ==
X-Gm-Message-State: AOJu0YyFVImuOVSYw78gMCrVZrTkKRqScCZ52zawMilSxBkbrUdSjsoI
	EEmU2ngBtGWD+S2+HHtx9fogsdG6vSUTmCSSH4ShgyScdx0TuVZkfzBfrtxJKuVctKFfWGy0brx
	4+ozwtL1ADeEovKIrYS1wDcyZSFF6m5EurCau1meQuMfaYIgtUJGEMg==
X-Received: by 2002:a5d:584e:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-3716fcaa1e4mr1073008f8f.10.1723562234821;
        Tue, 13 Aug 2024 08:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE2T68L2nxUWhQu9yYSxkdgAPsPtlEJvz5tPSnoSOmRWT9hKefJFFDLo3dOLOTtQchjUDqSQ==
X-Received: by 2002:a5d:584e:0:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-3716fcaa1e4mr1072992f8f.10.1723562234264;
        Tue, 13 Aug 2024 08:17:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110::f71? ([2a0d:3344:1708:9110::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb10sm10589557f8f.84.2024.08.13.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:17:13 -0700 (PDT)
Message-ID: <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
Date: Tue, 13 Aug 2024 17:17:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZquQyd6OTh8Hytql@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 15:42, Jiri Pirko wrote:
> Tue, Jul 30, 2024 at 10:39:46PM CEST, pabeni@redhat.com wrote:
>> +/**
>> + * net_shaper_make_handle - creates an unique shaper identifier
>> + * @scope: the shaper scope
>> + * @id: the shaper id number
>> + *
>> + * Return: an unique identifier for the shaper
>> + *
>> + * Combines the specified arguments to create an unique identifier for
>> + * the shaper. The @id argument semantic depends on the
>> + * specified scope.
>> + * For @NET_SHAPER_SCOPE_QUEUE_GROUP, @id is the queue group id
>> + * For @NET_SHAPER_SCOPE_QUEUE, @id is the queue number.
>> + * For @NET_SHAPER_SCOPE_VF, @id is virtual function number.
>> + */
>> +static inline u32 net_shaper_make_handle(enum net_shaper_scope scope,
>> +					 int id)
>> +{
>> +	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, scope) |
>> +		FIELD_PREP(NET_SHAPER_ID_MASK, id);
> 
> Perhaps some scopes may find only part of u32 as limitting for id in
> the future? I find it elegant to have it in single u32 though. u64 may
> be nicer (I know, xarray) :)

With this code the id limit is 2^26 for each scope. The most capable H/W 
I'm aware of supports at most 64K shapers, overall. Are you aware of any 
specific constraint we need to address?

[...]
>> int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>> {
>> -	return -EOPNOTSUPP;
>> +	struct net_shaper_info *shaper;
>> +	struct net_device *dev;
>> +	struct sk_buff *msg;
>> +	u32 handle;
>> +	int ret;
>> +
>> +	ret = fetch_dev(info, &dev);
> 
> This is quite net_device centric. Devlink rate shaper should be
> eventually visible throught this api as well, won't they? How do you
> imagine that?

I'm unsure we are on the same page. Do you foresee this to replace and 
obsoleted the existing devlink rate API? It was not our so far.

> Could we have various types of binding? Something like:
> 
> NET_SHAPER_A_BINDING nest
>    NET_SHAPER_A_BINDING_IFINDEX u32
> 
> or:
> NET_SHAPER_A_BINDING nest
>    NET_SHAPER_A_BINDING_DEVLINK_PORT nest
>      DEVLINK_ATTR_BUS_NAME string
>      DEVLINK_ATTR_DEV_NAME string
>      DEVLINK_ATTR_PORT_INDEX u32
> 
> ?

Somewhat related, the current get()/dump() operations currently don't 
return the shaper ifindex. I guess we can include 'scope' and 'id' under 
NET_SHAPER_A_BINDING and replace the existing handle attribute with it.

It should cover eventual future devlink extensions and provide all the 
relevant info for get/dump sake.

>> +
>> static int __init shaper_init(void)
> 
> 
> 
> fetch_dev
> fill_handle
> parse_handle
> sc_lookup
> __sc_container
> dev_shaper_flush
> shaper_init
> 
> 
> Could you perhaps maintain net_shaper_ prefix for all of there?

Most of the helpers are static and should never be visible outside this 
compilation unit, so I did not bother with a prefix, I'll add it in the 
next revision.

Thanks,

Paolo


