Return-Path: <netdev+bounces-151154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198DC9ED0E5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2082845BB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3F1D934C;
	Wed, 11 Dec 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0F/ebTLD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD161D5CDD
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933435; cv=none; b=rBhymj8zRK2VUMDeW/PiA6iliYtvGqGze0mbhRuf5wWDSBNtzqWftH30IrO7vIY3s5U7Pc1/2PgYuCNybyCktVukQtyhDJiUfmxbvEysd3n6mpyJwyHfAXkdBG4oMQanv+DGcMMK2XaSgDjG/JBKmRZJoGbtTFZLl62NKW66nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933435; c=relaxed/simple;
	bh=Vx+pvR0ic8PlMNefbnZYsnytyBQtbRDDTzl0QhoAsjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGiQBAJonEXqqejj1zF670NIaO2Q8CZiaJdVwLwwODPXKD+6PTZUB9jNqIaQa62x+78c1olwlPoW+gAYjMmv+BZPF+EIHSNspu88P2pMrS8gxVXpw65e2vCYFxhFizsS0NHUQBN4uDFG5jq16yBIj249dA5uIKm7/cDfO4dPKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0F/ebTLD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21636268e43so48887895ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733933433; x=1734538233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMZa2fSiX57QHDCk5EXJQriREt01VSZddkKw9KIqgvM=;
        b=0F/ebTLDqQl804vJyXT4pJqc1LqjvZzFjvfjQAgz7b4i8L4nkfZpB6/Rqq3Jg3ae9o
         Qo8YsWYMCl/Xm2eUJxMzEee0b6Kf88OENk30e7eLIgB0y+NAHCFPoAQMxGU3beMhSD0N
         KQesBOtQ0VAoORqU6oeqkwg2+9c3yIzpoJTXVlVy/x+cENEJB92LRvGQxfxOigPuf0Qt
         55g2dqZiNKPy846GlIefNKfFJI8e0vyfs5WkFHGhDR6EQCV+QsRqB9ukMvW8Ay6i006B
         StaQnCCBclv5tIEOzAjuM8L7IDH6Giyd21soSdqIJG2quD0uzwNdEYqvdAcRQslrFyFS
         flCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933433; x=1734538233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMZa2fSiX57QHDCk5EXJQriREt01VSZddkKw9KIqgvM=;
        b=IBfVSF+xkGsFjcn+cFc8wifp3bV0wuOeUaTS48R9esLvLsjf5VVPHXgGX9pIqa6AOl
         IdJ7e3UboZWezPco4uBAdd9ycBmxd2I5ry4/ltirwDSmTuWAIB+/btQxTsAROlndke83
         W/9ZnRCDytNd7bcO+SzARvk8S3S4Ie+VMN/LJ1iI/bnecRtum4h5n6jUPteLS3VTrsIN
         nD8lfOkooUMqwmbSNL8j+QNI+b1BAuWsZYwxexFmBupb3CWHc9Z+eX3TmYQAjtknm/lI
         UvEBnDG1D+aW9rAjL6HvwgeXD5ac9Khscf+yzigxYD619Aejvn+wqN3aUu3KTsyz5Ew+
         ZAdw==
X-Forwarded-Encrypted: i=1; AJvYcCUw2bRAKp68/DDk24m5sSDqAvdkg5eTADQCI6QBhuvpcdWwTGakLzulK9Vj9zrWFhGVYbSAXN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz632ODCxR9g+9oKTtEj4NxBhnCQQFWreKevXFwYQuJMUnZNyBg
	jE5w1u4fMLbTdpbKVJq6guOh3+esOIMJpKXqeqOQ/qIaO5z9orBerehF0i7dksI=
X-Gm-Gg: ASbGncsi12nmp6W5r2UuS2fi6RTlDzbMHD8LerdypwsEmi2yIY6N0DgtwQ3Vz8OXD2V
	9Q20KgSxIBnvMwzzdiTBG//ZXDl8elKKlb+UuQPwIZM6VB3bRH3LzSlXvHYn663SfoLO5dmo9i2
	lJ6+86dULb4qLH8MiGxGT1bkdkVO9muU9Abby8YYOLCp5jSARRFcJlX4ytVjR06QZeJbBzT7+nC
	/hYC2rU85Eh87SAB04IBreTLNYEIWMT+F/3XWOV2myVpCMxczn2CA5VpwA0JxGLvrzNTBKqW/JD
	4td99lkQSDOe9WQ=
X-Google-Smtp-Source: AGHT+IGbMGCKWsTrKWwXl6vM6t9U3o7t9tmI/Bkans+DJLmKkFvB7AFdRqk8ua+ato4iwbTYgAua1Q==
X-Received: by 2002:a17:903:40cb:b0:215:30d1:36fa with SMTP id d9443c01a7336-21778697539mr55936065ad.39.1733933433204;
        Wed, 11 Dec 2024 08:10:33 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::7:df75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e519f6bsm74390025ad.30.2024.12.11.08.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 08:10:32 -0800 (PST)
Message-ID: <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
Date: Wed, 11 Dec 2024 08:10:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
 <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-11 04:32, Yunsheng Lin wrote:
> On 2024/12/11 2:14, David Wei wrote:
>> On 2024-12-10 04:25, Yunsheng Lin wrote:
>>> On 2024/12/4 12:10, David Wei wrote:
>>>
>>>>  	bnxt_copy_rx_ring(bp, rxr, clone);
>>>> @@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>>>>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>>>>  	rxr->rx_next_cons = 0;
>>>>  	page_pool_disable_direct_recycling(rxr->page_pool);
>>>> +	if (bnxt_separate_head_pool())
>>>> +		page_pool_disable_direct_recycling(rxr->head_pool);
>>>
>>> Hi, David
>>> As mentioned in [1], is the above page_pool_disable_direct_recycling()
>>> really needed?
>>>
>>> Is there any NAPI API called in the implementation of netdev_queue_mgmt_ops?
>>> It doesn't seem obvious there is any NAPI API like napi_enable() &
>>> ____napi_schedule() that is called in bnxt_queue_start()/bnxt_queue_stop()/
>>> bnxt_queue_mem_alloc()/bnxt_queue_mem_free() through code reading.
>>>
>>> 1. https://lore.kernel.org/all/c2b306af-4817-4169-814b-adbf25803919@huawei.com/
>>
>> Hi Yunsheng, there are explicitly no napi_enable/disable() calls in the
>> bnxt implementation of netdev_queue_mgmt_ops due to ... let's say HW/FW
>> quirks. I looked back at my discussions w/ Broadcom, and IIU/RC
>> bnxt_hwrm_vnic_update() will prevent any work from coming into the rxq
>> that I'm trying to stop. Calling napi_disable() has unintended side
>> effects on the Tx side.
> 
> It seems that bnxt_hwrm_vnic_update() sends a VNIC_UPDATE cmd to disable
> a VNIC? and a napi_disable() is not needed?

Correct.

> Is it possible that there may
> be some pending NAPI work is still being processed after bnxt_hwrm_vnic_update()
> is called?

Possibly, I don't know the details of how the HW works.

At the time I just wanted something to work, and not having
napi_enable/disable() made it work. :) Looking back though it does seem
odd, so I'll try putting it back.

> 
>>
>> The intent of the call to page_pool_disable_direct_recycling() is to
>> prevent pages from the old page pool from being returned into the fast
>> cache. These pages must be returned via page_pool_return_page() so that
>> the it can eventually be freed in page_pool_release_retry().
>>
>> I'm going to take a look at your discussions in [1] and respond there.
> 
> Thanks.

