Return-Path: <netdev+bounces-202969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36BDAEFFB7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7C5163E5D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F3F27933C;
	Tue,  1 Jul 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jyq1DZvi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F51AA1DB;
	Tue,  1 Jul 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387150; cv=none; b=MxdJMVcLjWCssF/nzwUyui80ZynsNZXzIbwtGyDVEIEZ0q2Bk3NFgEjIBMWKwMBFGHCrolY798sJ4K6+HbncaTSuAlj35sRd+bvKb2Xh7rv7SzkA3p1ht5UyZj2QrA5b0CevgY1hV0kS6Had8dC8dyzmerPx1udSk/dgml+VOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387150; c=relaxed/simple;
	bh=cbh0BSreiXKSj1oPzakyKs+0sCcZrfx5leGyiQZugyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjs/S6DxJTHA7+UOGhYsyqQY/LoBxqSvTCIq2DRCzsaEidM1xH1W8YwqTcPeh791XmcUbQdMV8DgX5JOPlmxk40J+V98RP9t6Dv6RKu6j6EdF16L7XtbjswbAhLVLY6vIEwdcl5DGnM5yHzd3CN2PT4uMl+I0U2Z9xAEWOK2SjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jyq1DZvi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751387149; x=1782923149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbh0BSreiXKSj1oPzakyKs+0sCcZrfx5leGyiQZugyY=;
  b=Jyq1DZviItYAYkEKr3GDxMf/FGKCvhF7kR2HSRBmxszfsTEhCVbYxyqz
   BZLIA2d2NNxGxnil7xRqdSV4QgCb/OaSWYKcLgZSL4G2mHK+qttJRW9eW
   ooQb/A///YaDdYWuI9xAPXNwswhE+qFOaEktoYrVH3+OBy8KLBv3aqPW2
   GpplQr6LVbwNB8M4C4UUwmCUNwA411ckSVSdlIu2AIoWdtVFZw957jdUA
   35a9/FS4EIScuqcIb5nIDD6lJtj6CI9pTIYNofYk+aaR+qlH2fafbK76F
   Sja1BR4ZNKd0+0tzjBUQeOA7x2HX13HmCg/iz+vofGD7jgBj4OhooWs8m
   w==;
X-CSE-ConnectionGUID: DQT9nv/8To6qvMRufEIu9g==
X-CSE-MsgGUID: 9g2qLEBgRl+X8qcFdm3SvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71226086"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71226086"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:25:46 -0700
X-CSE-ConnectionGUID: 10p101UFTpe0G/yTS6HTEw==
X-CSE-MsgGUID: wed+KAP/QT22NeH7EQwAig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177483682"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:25:45 -0700
Message-ID: <b29bf20f-456f-4772-959b-2287ec0f54d4@intel.com>
Date: Tue, 1 Jul 2025 09:25:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
 <30d7f613-4089-4e64-893a-83ebf2e319c1@intel.com>
 <20250630172005.0000747c@huawei.com>
 <34d7b634-0a4f-4cbe-a96f-cd1a8cea72ef@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <34d7b634-0a4f-4cbe-a96f-cd1a8cea72ef@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/1/25 9:07 AM, Alejandro Lucero Palau wrote:
> 
> On 6/30/25 17:20, Jonathan Cameron wrote:
>> Hi Dave,
>>
>>>> +/*
>>>> + * Try to get a locked reference on a memdev's CXL port topology
>>>> + * connection. Be careful to observe when cxl_mem_probe() has deposited
>>>> + * a probe deferral awaiting the arrival of the CXL root driver.
>>>> + */
>>>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> Just focusing on this part.
>>
>>> Annotation of __acquires() is needed here to annotate that this function is taking multiple locks and keeping the locks.
>> Messy because it's a conditional case and on error we never have
>> a call marked __releases() so sparse may moan.
>>
>> In theory we have __cond_acquires() but I think the sparse tooling
>> is still missing for that.
>>
>> One option is to hike the thing into a header as inline and use __acquire()
>> in the appropriate places.  Then sparse can see the markings
>> without problems.
>>
>> https://lore.kernel.org/all/20250305161652.GA18280@noisy.programming.kicks-ass.net/
>>
>> has some discussion on fixing the annotation issues around conditional locks
>> for LLVM but for now I think we are still stuck.
>>
>> For the original __cond_acquires()
>> https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/
>>
>> Linus posted sparse and kernel support but I think only the kernel bit merged
>> as sparse is currently (I think) unmaintained.
>>
> 
> Not sure what is the conclusion to this: should I do it or not?

Sounds like we can't with the way it's conditionally done.
> 
> 
> I can not see the __acquires being used yet by cxl core so I wonder if this needs to be introduced only when new code is added or it should require a core revision for adding all required. I mean, those locks being used in other code parts but not "advertised" by __acquires, is not that a problem?

It's only needed if you acquire a lock and leaving it held and then releases it in a different function. That allows sparse(?) to track if you are locking correctly. You don't need it if it's being done in the same function.

DJ


> 
> 
>>>> +{
>>>> +    struct cxl_port *endpoint;
>>>> +    int rc = -ENXIO;
>>>> +
>>>> +    device_lock(&cxlmd->dev);
>>>> +> +    endpoint = cxlmd->endpoint;
>>>> +    if (!endpoint)
>>>> +        goto err;
>>>> +
>>>> +    if (IS_ERR(endpoint)) {
>>>> +        rc = PTR_ERR(endpoint);
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    device_lock(&endpoint->dev);
>>>> +    if (!endpoint->dev.driver)> +        goto err_endpoint;
>>>> +
>>>> +    return endpoint;
>>>> +
>>>> +err_endpoint:
>>>> +    device_unlock(&endpoint->dev);
>>>> +err:
>>>> +    device_unlock(&cxlmd->dev);
>>>> +    return ERR_PTR(rc);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
>>>> +
>>>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>>> And __releases() here to release the lock annotations
>>>> +{
>>>> +    device_unlock(&endpoint->dev);
>>>> +    device_unlock(&cxlmd->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");
>>


