Return-Path: <netdev+bounces-115811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E7947DBF
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78161F21674
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073213C81C;
	Mon,  5 Aug 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyijvzCj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B73F9D5
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870677; cv=none; b=mC31owLgP78g41N9jGYY7i+B/oPdORnunL/g+vz8BCVk+RJ5p4JuMnghlbcRcyU17dUeS/BCzG2zJoeJuEJp1fqCjY8bUnqVQ1GH1FPA4vo9vH1CinAE7jBVUDr3DxVmikQ5iWExwKWC/92ecjAVcUvWUS0vnh00RuHohIb+jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870677; c=relaxed/simple;
	bh=HVMgTpGl8bhh7aJMDh2fTYiipBFwllthvdVQmG3ckak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVrwMUB7oDieaeapjXXkc592ICUDk6X4eRHy0oUJcJY/IS8uj23CyKICMukHtGcp136u9tlvckcmCKgbXCUVfhY0SOBlUX889IVW7tlHjibT+C7MvY3+38n30bUOK+a/P7ckjoERNvVrUROQdGr8m5OSZtzGcvF87Z1+sj0D+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyijvzCj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722870675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPD3uGCjSR2+POGyy3mC3vHskslm3ZxBw0trVqWqt3A=;
	b=YyijvzCjQl1Rk8jgNaD+gC2JIi1ynMOVPnr9tSuV5sTk6/uuc+bA9DMuB/BL/vKTcsrPPX
	dVhtZ102kUY6l2oVMGrsSc5RGVYhzfox4ikmCZzgHkUwMEd/XHzuEIxT9cP8w7/tda9nrs
	AjELOyXyYfdpKjuC4sPCpDlWdRoe0ls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345--JwPDLYRM8O-JTpDrYGWuA-1; Mon, 05 Aug 2024 11:11:13 -0400
X-MC-Unique: -JwPDLYRM8O-JTpDrYGWuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42808f5d220so17791695e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 08:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870672; x=1723475472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPD3uGCjSR2+POGyy3mC3vHskslm3ZxBw0trVqWqt3A=;
        b=OcX2+pZ10MJLVcbD/bhqqMW9k09Coi0dUo7TQHGZDrjXSmhmzkddVna2ZV0BQtOA+V
         x/iiD8Xduaz/rvD0KIG/4dgkZPxL1Umo1kz2e4mAwC1xHmCGtfqA8nEJR/sSjtKTpzMj
         QFguDiNTNvvMkl3eFxY9x/ew1xaGjWQq4lhh4VwdWPym7+o9miNx7sTAn1O5wBJCzhAx
         1r8bf7RT+Lhx0YyWwcw+TK0jNSOjKIgIi94KgThO2W7sxZ8iXYIK0iyXSuhAXmfNU8Q6
         6o63DYwFOXl7a+GG7908/oyAz1cm3qc7W9wBocBnc2rjxTFK9YWHani2Jf/J6ZbiuOrW
         wBhg==
X-Gm-Message-State: AOJu0Yzh1PhrEsgrAIVdolDjzkWagevuNRIxXL5U0lZxbqxiuWtOpidi
	AUJExFi8pzuEazqmSh1gvf84IsQGESRIMbLfMNL6O1r0b16dZzvKMJ01YyJvpZe19Jqg2Xyq+1J
	8EYuP/M9NoStVv8s0iVhYYhFxO5xVZbg4oVkLuYATd3LMkGg4nqLxJQ==
X-Received: by 2002:a05:600c:1c15:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-428e6affdebmr56307775e9.2.1722870671939;
        Mon, 05 Aug 2024 08:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLB0a+Qp+Vf3o8mqtAwxGnpq7VlkIXZh0Eh/af8CzJVQWb7DVGnHiUyqiB4/Dj7QVkby31zg==
X-Received: by 2002:a05:600c:1c15:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-428e6affdebmr56307545e9.2.1722870671384;
        Mon, 05 Aug 2024 08:11:11 -0700 (PDT)
Received: from [192.168.0.114] (146-241-0-122.dyn.eolo.it. [146.241.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baba5f2sm203572045e9.26.2024.08.05.08.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:11:10 -0700 (PDT)
Message-ID: <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
Date: Mon, 5 Aug 2024 17:11:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

(same remark of my previous email). My replies this week will be 
delayed, please allow for some extra latency.

On 8/2/24 12:49, Jiri Pirko wrote:
> Thu, Aug 01, 2024 at 05:12:01PM CEST, pabeni@redhat.com wrote:
>> On 8/1/24 15:10, Jiri Pirko wrote:
>>> Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:
>>>> +    type: enum
>>>> +    name: scope
>>>> +    doc: the different scopes where a shaper can be attached
>>>> +    render-max: true
>>>> +    entries:
>>>> +      - name: unspec
>>>> +        doc: The scope is not specified
>>>> +      -
>>>> +        name: port
>>>> +        doc: The root for the whole H/W
>>>
>>> What is this "port"?
>>
>> ~ a wire plug.
> 
> What's "wire plug"? What of existing kernel objects this relates to? Is
> it a devlink port?


I'm sorry, my hasty translation of my native language was really 
inaccurate. Let me re-phrase from scratch: that is actually the root of 
the whole scheduling tree (yes, it's a tree) for a given network device.

One source of confusion is that in a previous iteration we intended to 
allow configuring even objects 'above' the network device level, but 
such feature has been dropped.

We could probably drop this scope entirely.

>>>> +      -
>>>> +        name: netdev
>>>> +        doc: The main shaper for the given network device.
>>>> +      -
>>>> +        name: queue
>>>> +        doc: The shaper is attached to the given device queue.
>>>> +      -
>>>> +        name: detached
>>>> +        doc: |
>>>> +             The shaper is not attached to any user-visible network
>>>> +             device component and allows nesting and grouping of
>>>> +             queues or others detached shapers.
>>>
>>> What is the purpose of the "detached" thing?
>>
>> I fear I can't escape reusing most of the wording above. 'detached' nodes
>> goal is to create groups of other shapers. i.e. queue groups,
>> allowing multiple levels nesting, i.e. to implement this kind of hierarchy:
>>
>> q1 ----- \
>> q2 - \SP / RR ------
>> q3 - /    	    \
>> 	q4 - \ SP -> (netdev)
>> 	q5 - /	    /
>>                    /
>> 	q6 - \ RR
>> 	q7 - /
>>
>> where q1..q7 are queue-level shapers and all the SP/RR are 'detached' one.
>> The conf. does not necessary make any functional sense, just to describe the
>> things.
> 
> Can you "attach" the "detached" ones? They are "detached" from what?

I see such name is very confusing. An alternative one could be 'group', 
but IIRC it was explicitly discarded while discussing a previous iteration.

The 'detached' name comes from the fact the such shapers are not a 
direct representation of some well-known kernel object (queues, devices),

>>>> +    -
>>>> +      name: group
>>>> +      doc: |
>>>> +        Group the specified input shapers under the specified
>>>> +        output shaper, eventually creating the latter, if needed.
>>>> +        Input shapers scope must be either @queue or @detached.
>>>> +        Output shaper scope must be either @detached or @netdev.
>>>> +        When using an output @detached scope shaper, if the
>>>> +        @handle @id is not specified, a new shaper of such scope
>>>> +        is created and, otherwise the specified output shaper
>>>> +        must be already existing.
>>>
>>> I'm lost. Could this designt be described in details in the doc I asked
>>> in the cover letter? :/ Please.
>>
>> I'm unsure if the context information here and in the previous replies helped
>> somehow.
>>
>> The group operation creates and configure a scheduling group, i.e. this
>>
>> q1 ----- \
>> q2 - \SP / RR ------
>> q3 - /    	    \
>> 	q4 - \ SP -> (netdev)
>> 	q5 - /	    /
>>                    /
>> 	q6 - \ RR
>> 	q7 - /
>>
>> can be create with:
>>
>> group(inputs:[q6, q7], output:[detached,parent:netdev])
>> group(inputs:[q4, q5], output:[detached,parent:netdev])
>> group(inputs:[q1], output:[detached,parent:netdev])
>> group(inputs:[q2,q3], output:[detached,parent:<the detached shaper create
>> above>])
> 
> So by "inputs" and "output" you are basically building a tree. In
> devlink rate, we have leaf and node, which is in sync with standard tree
> terminology.
> 
> If what you are building is tree, why don't you use the same
> terminology? If you are building tree, you just need to have the link to
> upper noded (output in your terminology). Why you have "inputs"? Isn't
> that redundant?

The idea behind the inputs/outputs naming is to represent the data flow 
towards the wire.
I'm fine with the parent/children naming, but IIRC Jakub was not happy 
with it. Is there any intermediate ground that could satisfy both of you?

Thanks,

Paolo


