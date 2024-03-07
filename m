Return-Path: <netdev+bounces-78527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA508758F0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EA51F2213E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C413A256;
	Thu,  7 Mar 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXhpBD0B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C451139597
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845179; cv=none; b=KxX8BTNoP8bOU/8+k5tACH7tFae3lPr9URW5kyjuz1xsuyqEi4JUyDr1bVNNnPVdAhyc/jfvnNtl/CFWDcitTeno6lkQbUk/t2pkh7Fs4FCOWZyGUaIFg5WE+VKaTDL9wAaBWvyJrGStt26krFKBRl5JsNi94qQLIViiUIKjc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845179; c=relaxed/simple;
	bh=M71wyK4rA8dTBNQOdAZrnaf/Nd7F0d9mNgjJmo9Usug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlWDgRfQAr3zJoRWEO6bvUwfVaXRSlvtwkSxqhvqc0D/wNBxGQmgT02ONPoqMYWpq5kT6VqKDuD81detAsN0Fe7QRrlkyTy9rzZplmz2UNr/EG6jh9cg0dcguhbeKj98Ba9R0Z1ngWJ46SFumoWKn/W5l6KPLQlugsWwnab8xtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXhpBD0B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709845173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bifhLCWZ9SRinNQtW2a737RoJZugUxnSf8lBMCsZPSs=;
	b=OXhpBD0BWprxYsyxsKQauUoj2WEmcPJgDY/eIFI3UpqGB78oIkEKUCN6/kxJQ4lQZaX81A
	cLOvwF7pwyGipYiFkUYBjPmoMQiKXo1CAefhdTS67jCD3liIJQe9V9JMbuQvjOR+OT0h9o
	/rmdrxsyDaePDqMcdiGaU2mYTKV6Yf0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-1egyrg_sORaTQ0eZvKMYGQ-1; Thu, 07 Mar 2024 15:59:32 -0500
X-MC-Unique: 1egyrg_sORaTQ0eZvKMYGQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5a1202521easo152273eaf.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 12:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845171; x=1710449971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bifhLCWZ9SRinNQtW2a737RoJZugUxnSf8lBMCsZPSs=;
        b=Ra/0PHsTZhGqP2EO4rNJIlqzEvGJV0SedSnIkpwS5H2lf34/A6v4UtOOGj/eRYcCnE
         t8lZlg32lNQvhFg13yzEWtXMmMLC7VuJFnaMJ+GBMedLQYMKEFvtsBY/bh6rdNBHNvzV
         7cLCdR1SrFMwJ76kJvGfcuITNsgeo+7l7zMz2xC6iZPc6gvXpUvO8GDrc5TO0LsgjALZ
         Uirgx0+UhGGoUwXWC6bDVzUQHtVOnslsIzR35PQmNyKi+HbQ3P3GY7P2gsekGUE1brkA
         XvWrRqNk3G72okVnVQXH0Ph8CMJ5UsCYg/waKBciXh3dOLh+vqwmEOk7dT7m9Af6aDPQ
         602A==
X-Forwarded-Encrypted: i=1; AJvYcCWsmX410Q8QDA3RyA/XUor432mVl3N5AR3lJYStXZ+U78z/o+76cutsfDPryhBagjsiq9USmc8BGzBCHjxhvhoxt4vI1WXs
X-Gm-Message-State: AOJu0Yx8kRsVrsCQWeF+8zBUXEaNe1iBhO2baRiBSA60t0OGu9VIyaYC
	vLZ1LRcsdjHNRzbHUKlIcrm/k69icOVOagxuzVpRIUA9AEKcJF646YXtJSU5ze+ec8vTWMalVtG
	21GAsR7g4J6yZKGPBZAqgISuOVZxLprv9HOt63D7Y3o6ED31xq2oOWg==
X-Received: by 2002:a05:6358:724b:b0:17b:f319:9449 with SMTP id i11-20020a056358724b00b0017bf3199449mr10630578rwa.7.1709845171365;
        Thu, 07 Mar 2024 12:59:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH6aTbnKUUF6lNOdkr66pdn36uJgDTDBzWV9uean8o2VO5YMsvPVcvUah4Jxy39sKE7dyQ9g==
X-Received: by 2002:a05:6358:724b:b0:17b:f319:9449 with SMTP id i11-20020a056358724b00b0017bf3199449mr10630567rwa.7.1709845171044;
        Thu, 07 Mar 2024 12:59:31 -0800 (PST)
Received: from [192.168.1.132] ([193.177.210.103])
        by smtp.gmail.com with ESMTPSA id lq9-20020a0562145b8900b0069055b05705sm7976363qvb.132.2024.03.07.12.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 12:59:30 -0800 (PST)
Message-ID: <6d4da824-a33f-42ae-88ef-be094f563684@redhat.com>
Date: Thu, 7 Mar 2024 21:59:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] net: openvswitch: Add sample multicasting.
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 dev@openvswitch.org
Cc: cmi@nvidia.com, yotam.gi@gmail.com, aconole@redhat.com,
 echaudro@redhat.com, horms@kernel.org, Dumitru Ceara <dceara@redhat.com>
References: <20240307151849.394962-1-amorenoz@redhat.com>
 <4dcf82da-c6ad-47c1-8308-3f87820aeb1b@ovn.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <4dcf82da-c6ad-47c1-8308-3f87820aeb1b@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/7/24 17:54, Ilya Maximets wrote:
> On 3/7/24 16:18, Adrian Moreno wrote:
>> ** Background **
>> Currently, OVS supports several packet sampling mechanisms (sFlow,
>> per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
>> userspace action that needs to be handled by ovs-vswitchd's handler
>> threads only to be forwarded to some third party application that
>> will somehow process the sample and provide observability on the
>> datapath.
>>
>> The fact that sampled traffic share netlink sockets and handler thread
>> time with upcalls, apart from being a performance bottleneck in the
>> sample extraction itself, can severely compromise the datapath,
>> yielding this solution unfit for highly loaded production systems.
>>
>> Users are left with little options other than guessing what sampling
>> rate will be OK for their traffic pattern and system load and dealing
>> with the lost accuracy.
>>
>> ** Proposal **
>> In this RFC, I'd like to request feedback on an attempt to fix this
>> situation by adding a flag to the userspace action to indicate the
>> upcall should be sent to a netlink multicast group instead of unicasted
>> to ovs-vswitchd.
>>
>> This would allow for other processes to read samples directly, freeing
>> the netlink sockets and handler threads to process packet upcalls.
>>
>> ** Notes on tc-offloading **
>> I am aware of the efforts being made to offload the sample action with
>> the help of psample.
>> I did consider using psample to multicast the samples. However, I
>> found a limitation that I'd like to discuss:
>> I would like to support OVN-driven per-flow (IPFIX) sampling because
>> it allows OVN to insert two 32-bit values (obs_domain_id and
>> ovs_point_id) that can be used to enrich the sample with "high level"
>> controller metadata (see debug_drop_domain_id NBDB option in ovn-nb(5)).
>>
>> The existing fields in psample_metadata are not enough to carry this
>> information. Would it be possible to extend this struct to make room for
>> some extra "application-specific" metadata?
>>
>> ** Alternatives **
>> An alternative approach that I'm considering (apart from using psample
>> as explained above) is to use a brand-new action. This lead to a cleaner
>> separation of concerns with existing userspace action (used for slow
>> paths and OFP_CONTROLLER actions) and cleaner statistics.
>> Also, ovs-vswitchd could more easily make the layout of this
>> new userdata part of the public API, allowing third party sample
>> collectors to decode it.
>>
>> I am currently exploring this alternative but wanted to send the RFC to
>> get some early feedback, guidance or ideas.
> 
> 
> Hi, Adrian.  Thanks for the patches!
> 

Thanks for the quick feedback.
Also adding Dumitru who I missed to include in the original CC list.

> Though I'm not sure if broadcasting is generally the best approach.
> These messages contain opaque information that is not actually
> parsable by any other entity than a process that created the action.
> And I don't think the structure of these opaque fields should become
> part of uAPI in neither kernel nor OVS in userspace.
> 

I understand this can be cumbersome, specially given the opaque field is 
currently also used for some purely-internal OVS actions (e.g: CONTROLLER).

However, for features such as OVN-driven per-flow sampling, where OVN-generated 
identifiers are placed in obs_domain_id and obs_point_id, it would be _really_ 
useful if this opaque value could be somehow decoded by external programs.

Two ideas come to mind to try to alleviate the potential maintainability issues:
- As I suggested, using a new action maybe makes things easier. By splitting the 
current "user_action_cookie" in two, one for internal actions and one for 
"observability" actions, we could expose the latter in the OVS userspace API 
without having to expose the former.
- Exposing functions in OVS that decode the opaque value. Third party 
applications could link against, say, libopenvswitch.so and use it to extract 
obs_{domain,point}_ids.

What do you think?

> The userspace() action already has a OVS_USERSPACE_ATTR_PID argument.
> And it is not actually used when OVS_DP_F_DISPATCH_UPCALL_PER_CPU is
> enabled.  All known users of OVS_DP_F_DISPATCH_UPCALL_PER_CPU are
> setting the OVS_USERSPACE_ATTR_PID to UINT32_MAX, which is not a pid
> that kernel could generate.
> 
> So, with a minimal and pretty much backward compatible change in
> output_userspace() function, we can honor OVS_USERSPACE_ATTR_PID if
> it's not U32_MAX.  This way userspace process can open a separate
> socket and configure sampling to redirect all packets there while
> normal MISS upcalls would still arrive to per-cpu sockets.  This
> should cover the performance concern.
>

Do you mean creating a new thread to process samples or using handlers?
The latter would still have performance impact and the former would likely fail 
to process all samples in a timely manner if there are many.

Besides, the current userspace tc-offloading series uses netlink broadcast with 
psample, can't we do the same for non-offloaded actions? It enable building 
external observability applications without overloading OVS.


> For the case without per-cpu dispatch, the feature comes for free
> if userspace application wants to use it.  However, there is no
> currently supported version of OVS that doesn't use per-cpu dispatch
> when available.
>  > What do you think?
>  > Best regards, Ilya Maximets.
> 

-- 
Adrián Moreno


