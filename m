Return-Path: <netdev+bounces-121149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFD95BF8B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BD21F21A62
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F014D6FE;
	Thu, 22 Aug 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmKIuhqT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAE14A4CC
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358644; cv=none; b=GQ0cgyo1alxUZB0expfUX2dCU2BQseqBhER5uMmeN9u1m2jm6gN+v6mrRWltN4HqndxVr/VUeXqWBZ0fSfCiYH2/eu0iwNk5uTQVVS/BCh4BQZ1MX2bqkWKJB4ytphwvWAJh6lFzrpd8VaAD5zTEMTnmRA8RlTa/W2vhPQ8uaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358644; c=relaxed/simple;
	bh=jp7XcK/hDvVqhcDfS94j5bOJ03kDyaOgbQ3YQHINPGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnPbCFFMVRKJixlPav0h1jhasIvE8P6joEHtB9sNf4qhdiFhBh1utw65XAeCJQrz/UM+B4ODIHua0JZxDSaTJC4N4Ew3Mjlt8LqmQinfq8sfdKAi9nFD79adRL66Ynes0wKIS3Ckd2Wz+Arw+Xp+AGVQlEevpwCF7qevbLX6VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmKIuhqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724358641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDVvuoCc3SOTB14Kr52XC/89hx5287+LkkOgGi0UgNc=;
	b=TmKIuhqTpXm/NIbb3D/dlTQcpwdfJNoqHf3GalfjJoWxHlbtdcklX7ODLINpaxE/CSrTOv
	EVjGZCqPgo/+CcKvymNOjWzUBO4P0u24304gNogLObvgwxdDCs589r8culSlfTd1K9ZHDB
	AD6L1KknJ4OTUbQnd6J8IE+s5qYYzbI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-2zDQB7imP9-aJGfFRyCufw-1; Thu, 22 Aug 2024 16:30:39 -0400
X-MC-Unique: 2zDQB7imP9-aJGfFRyCufw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816096cb8so12567005e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358638; x=1724963438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDVvuoCc3SOTB14Kr52XC/89hx5287+LkkOgGi0UgNc=;
        b=wchKY9D4+r6xZ+ca7a+TkATvAG19zDRkDhWGUE9L5iCLJyC/8A9BdAwKnDqC9EyPZ/
         m5WnbL7v1gzeR8BE/WiKwvQiFOLbafJkdgDAK8AKqgz/F7eE1TKunJiLHA19TFigrmXD
         ZS8YC/nM3NOu1sZnR+Q5YGXGoweRh7DdrozXXXX9TYW9gHVK1aj0m+0k6AbjJn45k6B9
         stjQqKJZhKzLDMjQwhJkxfEDoaGT1rvSxiuKdkEaRuWkB+TbZ8A4X45rjnho9StsDH2l
         xcMIjKwabLKyhlRhCX7bSYFJJaPUyDRPni05nMmhigWxm6BsuqY7q/6VDWCjGu3/0/g6
         CFfQ==
X-Gm-Message-State: AOJu0YxtVf8bMxVbdkRdH3by+oTqK9Mat/HjRG2yvppmLc3gTZRWljOX
	u3PEMjM56eSH+GtMPvNmDTRICu1VQeQGn0zeS4NIBDKNlZzu3QXBani1rSsnJ9X3EbDJfBt37KU
	v0CQ+tFQGOIJLH4TfNoSoVU9FGBurE8/dJQaopBx10wk6wLsyNV2APA==
X-Received: by 2002:adf:f841:0:b0:371:7d3c:51bd with SMTP id ffacd0b85a97d-37311855c11mr27362f8f.14.1724358638475;
        Thu, 22 Aug 2024 13:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLIM5V8pv3TwtIFSYbcEAGV8rMh5bGPF2QAK0yMrkRb0zhlWHpXgjS26tRwSyCRQdxbezM0A==
X-Received: by 2002:adf:f841:0:b0:371:7d3c:51bd with SMTP id ffacd0b85a97d-37311855c11mr27341f8f.14.1724358637937;
        Thu, 22 Aug 2024 13:30:37 -0700 (PDT)
Received: from [192.168.0.114] (146-241-9-58.dyn.eolo.it. [146.241.9.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ffb40sm2483961f8f.76.2024.08.22.13.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 13:30:37 -0700 (PDT)
Message-ID: <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
Date: Thu, 22 Aug 2024 22:30:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion> <20240822074112.709f769e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822074112.709f769e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 16:41, Jakub Kicinski wrote:
> On Thu, 22 Aug 2024 14:02:54 +0200 Jiri Pirko wrote:
>>>> This is what I understood was a plan from very beginning.
>>>
>>> Originally the scope was much more limited than what defined here. Jakub
>>> asked to implement an interface capable to unify the network device
>>> shaping/rate related callbacks.
>>
>> I'm not saying this is deal breaker for me. I just think that if the api
>> is designed to be independent of the object shaper is bound to
>> (netdev/devlink_port/etc), it would be much much easier to extend in the
>> future. If you do everything netdev-centric from start, I'm sure no
>> shaper consolidation will ever happen. And that I thought was one of the
>> goals.
>>
>> Perhaps Jakub has opinion.
> 
> I think you and I are on the same page :) Other than the "reference
> object" (netdev / devlink port) the driver facing API should be
> identical. Making it possible for the same driver code to handle
> translating the parameters into HW config / FW requests, whether
> they shape at the device (devlink) or port (netdev) level.
> 
> Shaper NL for netdevs is separate from internal representation and
> driver API in my mind. My initial ask was to create the internal
> representation first, make sure it can express devlink and handful of
> exiting netdev APIs, and only once that's merged worry about exposing
> it via a new NL.
> 
> I'm not opposed to showing devlink shapers in netdev NL (RO as you say)
> but talking about it now strikes me as cart before the horse.

FTR, I don't see both of you on the same page ?!?

I read the above as Jiri's preference is a single ndo set to control
both devlink and device shapers, while I read Jakub's preference as for
different sets of operations that will use the same arguments to specify
the shaper informations.

Or to phrase the above differently, Jiri is focusing on the shaper
"binding" (how to locate/access it) while Jakub is focusing on the 
shaper "info" (content/definition/attributes). Please correct me If I 
misread something.

Still for the record, I interpret the current proposal as not clashing
with Jakub's preference, and being tolerated from Jiri, again please 
correct me if I read too far.

Thanks,

Paolo


