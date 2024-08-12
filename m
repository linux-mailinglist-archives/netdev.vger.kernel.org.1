Return-Path: <netdev+bounces-117747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093A94F10A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728E81C22030
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270E184557;
	Mon, 12 Aug 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZeGYl8e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D71836E2
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474721; cv=none; b=Ni2a4WuFm601mEedBYppTxKMfL6Pb/NejwUEy/0iW2wAq0ZCx3CR3nVxeCPhIUQTBkgH3xYcBQzghbu2LaH7dstsGsZVA1CB7n0KJdgg9rZbVXSMJwag1kcSqX8H89lt1Sdjvqbt1nqeOJyMqrjVkmcycIarp/+baclM0Jlk/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474721; c=relaxed/simple;
	bh=BGnRhu1es7wTfA+ABQ9Sh/ew3tiGtlgG6ZsFHJXDqN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqM3RjKnWu0JkEgaKNqjle9BzLT3ikIZhIYcCdQDsYtm663WnDYGsuBz5mFiqPyFtNp8gA7j1lZV3tpnFA7Q0Flf0PInPBxCB8ePN4a2fERbp4/oS1nEwUDNC/eT2cOl7JLe9bTkfL5Xhw1nXE4dLtwJ3ACZWRLuDtwDV29VGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZeGYl8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723474719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNji2OkDY8AMqHZ8TqyfWOjKnJkG48UgbjacOddJ0zQ=;
	b=GZeGYl8ehGgPoRVNEYbpqxn0txPiKp3plTEf3sF+OeHI6R06F1MbjJY9TA1mz2AZAOHcp8
	BccvHPQOt4qcQm3FP+A5fXyRH3lhT7d5onTBWj0xs76mgjwFsK3zFWTYZ48G7vIEtilyrz
	8Y+Bav+9ErKsG6f/uo/svJBlA3e3tbA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-TvFJ9pY3OgSad1zi3a8ggA-1; Mon, 12 Aug 2024 10:58:37 -0400
X-MC-Unique: TvFJ9pY3OgSad1zi3a8ggA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4290cc01eb3so7669935e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 07:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474716; x=1724079516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNji2OkDY8AMqHZ8TqyfWOjKnJkG48UgbjacOddJ0zQ=;
        b=caLwH7VwuMHzqVJBd1wSmhENHnKzhUcb8iGVz9/77MKmmO/asfKvzRV8VqYnjaiVcL
         xkCqjzRc5jQYlgF/dfY+L6PMb7tNSrN01g+xLFd0oMQMIY9siV+v9DKKrScH8QiK/sEn
         So+S9rXp0A1GbZjiVa56/hGINT2PpJ5/qX+17+gFTeKXddE+igpwkGE7/lCPXEo8wJsV
         geJtLD1ShNA99EGjDBGEmTsddM8EGjTYt1AoBP/qqAkhS9YR3JW3kVCYq+WTuuFuiLGT
         mLTf3lxhpiP6qWjlLEPU1tbT+DCP1XznNZvswohJ1osGElSpWNGvbXgeyA00JwLHTRYF
         S3wA==
X-Gm-Message-State: AOJu0YxdSa8AffWEh1fB14negmfCAfeY0eYsr/D/IJiYrXVTVFJMTA4c
	dOUMeVn75aBBxBAzCSNQHDVS4+glrruS8f7s/RIYJfFZEB6tbgIyyVXJURSPidyrjpbwOE2bK93
	FfGcS84atS7+k6cpDKJDDTud9riNVRHKHF6rjCxKLe2BOWvbXWVSKXg==
X-Received: by 2002:a05:600c:3504:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429d47a0983mr3355665e9.0.1723474715600;
        Mon, 12 Aug 2024 07:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHju8baf90PvDVXH+Q/vAZgxeui/YKzJxzWBhG1f2inajrJ6ivO5DlM+E/An2pd5DcI/JfFkw==
X-Received: by 2002:a05:600c:3504:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429d47a0983mr3355505e9.0.1723474714977;
        Mon, 12 Aug 2024 07:58:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:170c:dd10::f71? ([2a0d:3344:170c:dd10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7734595sm103846855e9.36.2024.08.12.07.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:58:34 -0700 (PDT)
Message-ID: <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
Date: Mon, 12 Aug 2024 16:58:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
 <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 09:06, Jiri Pirko wrote:
> Mon, Aug 05, 2024 at 05:11:09PM CEST, pabeni@redhat.com wrote:
>> Hi all,
>>
>> (same remark of my previous email). My replies this week will be delayed,
>> please allow for some extra latency.
>>
>> On 8/2/24 12:49, Jiri Pirko wrote:
>>> Thu, Aug 01, 2024 at 05:12:01PM CEST, pabeni@redhat.com wrote:
>>>> On 8/1/24 15:10, Jiri Pirko wrote:
>>>>> Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:
>>>>>> +    type: enum
>>>>>> +    name: scope
>>>>>> +    doc: the different scopes where a shaper can be attached
>>>>>> +    render-max: true
>>>>>> +    entries:
>>>>>> +      - name: unspec
>>>>>> +        doc: The scope is not specified
>>>>>> +      -
>>>>>> +        name: port
>>>>>> +        doc: The root for the whole H/W
>>>>>
>>>>> What is this "port"?
>>>>
>>>> ~ a wire plug.
>>>
>>> What's "wire plug"? What of existing kernel objects this relates to? Is
>>> it a devlink port?
>>
>>
>> I'm sorry, my hasty translation of my native language was really inaccurate.
>> Let me re-phrase from scratch: that is actually the root of the whole
>> scheduling tree (yes, it's a tree) for a given network device.
>>
>> One source of confusion is that in a previous iteration we intended to allow
>> configuring even objects 'above' the network device level, but such feature
>> has been dropped.
>>
>> We could probably drop this scope entirely.
> 
> Drop for now, correct? I agree that your patchset now only works on top
> of netdev. But all infra should be ready to work on top of something
> else, devlink seems like good candidate. I mean, for devlink port
> function rate, we will definitelly need something like that.
> 
> 
>>
>>>>>> +      -
>>>>>> +        name: netdev
>>>>>> +        doc: The main shaper for the given network device.
>>>>>> +      -
>>>>>> +        name: queue
>>>>>> +        doc: The shaper is attached to the given device queue.
>>>>>> +      -
>>>>>> +        name: detached
>>>>>> +        doc: |
>>>>>> +             The shaper is not attached to any user-visible network
>>>>>> +             device component and allows nesting and grouping of
>>>>>> +             queues or others detached shapers.
>>>>>
>>>>> What is the purpose of the "detached" thing?
>>>>
>>>> I fear I can't escape reusing most of the wording above. 'detached' nodes
>>>> goal is to create groups of other shapers. i.e. queue groups,
>>>> allowing multiple levels nesting, i.e. to implement this kind of hierarchy:
>>>>
>>>> q1 ----- \
>>>> q2 - \SP / RR ------
>>>> q3 - /    	    \
>>>> 	q4 - \ SP -> (netdev)
>>>> 	q5 - /	    /
>>>>                     /
>>>> 	q6 - \ RR
>>>> 	q7 - /
>>>>
>>>> where q1..q7 are queue-level shapers and all the SP/RR are 'detached' one.
>>>> The conf. does not necessary make any functional sense, just to describe the
>>>> things.
>>>
>>> Can you "attach" the "detached" ones? They are "detached" from what?
>>
>> I see such name is very confusing. An alternative one could be 'group', but
>> IIRC it was explicitly discarded while discussing a previous iteration.
>>
>> The 'detached' name comes from the fact the such shapers are not a direct
>> representation of some well-known kernel object (queues, devices),
> 
> Understand now. Maybe "node" would make more sense? Leaves are queues
> and root is the device? Aligns with the tree terminology...
> 
>>
>>>>>> +    -
>>>>>> +      name: group
>>>>>> +      doc: |
>>>>>> +        Group the specified input shapers under the specified
>>>>>> +        output shaper, eventually creating the latter, if needed.
>>>>>> +        Input shapers scope must be either @queue or @detached.
>>>>>> +        Output shaper scope must be either @detached or @netdev.
>>>>>> +        When using an output @detached scope shaper, if the
>>>>>> +        @handle @id is not specified, a new shaper of such scope
>>>>>> +        is created and, otherwise the specified output shaper
>>>>>> +        must be already existing.
>>>>>
>>>>> I'm lost. Could this designt be described in details in the doc I asked
>>>>> in the cover letter? :/ Please.
>>>>
>>>> I'm unsure if the context information here and in the previous replies helped
>>>> somehow.
>>>>
>>>> The group operation creates and configure a scheduling group, i.e. this
>>>>
>>>> q1 ----- \
>>>> q2 - \SP / RR ------
>>>> q3 - /    	    \
>>>> 	q4 - \ SP -> (netdev)
>>>> 	q5 - /	    /
>>>>                     /
>>>> 	q6 - \ RR
>>>> 	q7 - /
>>>>
>>>> can be create with:
>>>>
>>>> group(inputs:[q6, q7], output:[detached,parent:netdev])
>>>> group(inputs:[q4, q5], output:[detached,parent:netdev])
>>>> group(inputs:[q1], output:[detached,parent:netdev])
>>>> group(inputs:[q2,q3], output:[detached,parent:<the detached shaper create
>>>> above>])
>>>
>>> So by "inputs" and "output" you are basically building a tree. In
>>> devlink rate, we have leaf and node, which is in sync with standard tree
>>> terminology.
>>>
>>> If what you are building is tree, why don't you use the same
>>> terminology? If you are building tree, you just need to have the link to
>>> upper noded (output in your terminology). Why you have "inputs"? Isn't
>>> that redundant?
>>
>> The idea behind the inputs/outputs naming is to represent the data flow
>> towards the wire.
>> I'm fine with the parent/children naming, but IIRC Jakub was not happy with
>> it. Is there any intermediate ground that could satisfy both of you?
> 
> It's a tree, so perhaps just stick with tree terminology, everyone is
> used to that. Makes sense? One way or another, this needs to be
> properly described in docs, all terminology. That would make things more
> clear, I believe.

@Jakub, would you be ok with:

'inputs' ->  'leaves'
'output' -> 'node'
?

Also while at it, I think renaming the 'group()' operation as 
'node_set()' could be clearer (or at least less unclear), WDYT?

Note: I think it's would be more user-friendly to keep a single 
delete/get/dump operation for 'nodes' and leaves.

Thanks,

Paolo


