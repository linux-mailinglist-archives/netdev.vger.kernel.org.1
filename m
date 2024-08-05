Return-Path: <netdev+bounces-115798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBC947CF1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B18F3B2177B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA3762D2;
	Mon,  5 Aug 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK7uKspC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FE159217
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868538; cv=none; b=jpW7L2/KCFTptYVhBd599Sdaz3kvQS9jw8NBAmZsrahoYha9z3t7B/ruVzKFYawctoha42bjjoTHUFeDGRAG6fqXYPNUnPu2Dk8g2H6kWIOc98wFVhEu7l8IElT7voMh8KgYea1qdDmUHnjd296eDyh/JSLb4GLcXuK6dA/t/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868538; c=relaxed/simple;
	bh=nLqDGAaoPV1ls6Na4nPfEc0tAiCTzqxwc7qBaBbXkyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSpajXpT1TjP3W8L3txPyNrGxC9r12WEpX4gMDMxmmWBN655j7xYUeYeqS8Iui9uGfU5J9iFan4WwCGPEz+hDH6KcKfi1oOK3ITcsEa7xdJn34gEgnao4CGu+lMjWqCNU8hSZslvdaXF7zFqSPBfAgRDPq/XcQmLHG6aLWu4wWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SK7uKspC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722868535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uetgKu07sTScp6T9LqoWY4ycV7y20tNtEFZYGj7KqxQ=;
	b=SK7uKspCtCJHiznIaVGC4G465ljk8dN+/GJdn2ysAQ7z675uh/X259Q6ejUEoGlNTdz2vy
	mFigK4jLmsn1BSOHiNvc+rTRAlL5jXxSinJacBilzkw4niU7i6lD5pAMBk9gyrLyR9O9Fn
	W8LzFsACWT3D6ydvT/IzQLJxHjkaGI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-aYngrK8bPeCkj7C1fItCYg-1; Mon, 05 Aug 2024 10:35:34 -0400
X-MC-Unique: aYngrK8bPeCkj7C1fItCYg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso13661475e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 07:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868532; x=1723473332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uetgKu07sTScp6T9LqoWY4ycV7y20tNtEFZYGj7KqxQ=;
        b=YBmJQ6khBd8ivlQSxBd7As7hy42UUlOjTOj4NbqjSdh0ippVs2JSFRg/JxufXiqGrF
         3TcSj2ljsLt9UXD05HRdCKkZzIhgCVU1pCT5d1t9QP67cxTSVCdQvDlA96rtD4+fwk24
         WSypF1COr7jSOGc/x5XCsC5sma1tOgW+0X73qHdvov3P4ubVEAVuwA79lKBH80IaEvSz
         zrc66VWei99zqpt4UJjJVpM/0evIC0Ywl62KAsrpptT5+aRxZBcZywv6qrqipvhWARS6
         wBfbY7EZb5KXquxBz58t1CNPmmT7y5aMULAkW77s+60OBCmC/ww3iYiuEmndsruD/HoU
         AaPg==
X-Gm-Message-State: AOJu0Yzlfhir4dTmHCa4DIfhw3K8w9WJVhx4ubF7wtPotu1JeAtDywoS
	1pJL0+cIFtgyoYhN9bRmILBwcLpO/OUb2WqnIPy98zSu9GHhlisR5LIHLpWlDWlo5bTyindRBZN
	iV4es6TVDOCnjDSPpRvmh4nCFPwS+HBqXiMT6V6OHc/UK9oto4m7tdbLlNQLPA6FC
X-Received: by 2002:a05:600c:3b21:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-428e6b803abmr53478945e9.3.1722868532452;
        Mon, 05 Aug 2024 07:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOjPoTxSMRIu0HmlVT5NK/yUw9vhX5FDFDos+nSLFbwKDTTo6lQW8OtQrgNTS7BZ+j03JcZw==
X-Received: by 2002:a05:600c:3b21:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-428e6b803abmr53478735e9.3.1722868531775;
        Mon, 05 Aug 2024 07:35:31 -0700 (PDT)
Received: from [192.168.0.114] (146-241-0-122.dyn.eolo.it. [146.241.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baba4f1sm201303055e9.23.2024.08.05.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:35:31 -0700 (PDT)
Message-ID: <e971cd64-9cbf-46d2-89fc-008548d1d211@redhat.com>
Date: Mon, 5 Aug 2024 16:35:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <m25xslp8nh.fsf@gmail.com> <07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com>
 <m2v80jnpkd.fsf@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <m2v80jnpkd.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

My replies this week will be delayed, please allow for some extra latency.

On 8/2/24 13:15, Donald Hunter wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
> 
>> On 7/31/24 23:13, Donald Hunter wrote:
>>> Paolo Abeni <pabeni@redhat.com> writes:
>>>
>>>> +        name: inputs
>>>> +        type: nest
>>>> +        multi-attr: true
>>>> +        nested-attributes: ns-info
>>>> +        doc: |
>>>> +           Describes a set of inputs shapers for a @group operation
>>> The @group renders exactly as-is in the generated htmldocs. There may be
>>> a more .rst friendly markup you can use that will render better.
>>
>> Uhm... AFAICS the problem is the target (e.g. 'group') is outside the htmldoc section itself, I
>> can't find any existing markup to serve this purpose well. What about sticking to quotes ''
>> everywhere?
>>
>> FTR, I used @ following the kdoc style.
> 
> Yeah, I was just thinking of using .rst markup like ``code`` or
> `italics`, but the meaning of @ is pretty obvious when reading the spec.
> If you stick with @ then we could always teach ynl-to-rst to render it
> as ``code``.

I'm fine with using @ everywhere.

>> [...]
>>>> +    -
>>>> +      name: group
>>>> +      doc: |
>>>> +        Group the specified input shapers under the specified
>>>> +        output shaper, eventually creating the latter, if needed.
>>>> +        Input shapers scope must be either @queue or @detached.
>>> It says above that you cannot create a detached shaper, so how do you
>>> create one to use as an input shaper here? Is this group op more like a
>>> multi-create op?
>>
>> The group operation has the main goal of configuring a single WRR or SP scheduling group
>> atomically. It can creates the needed shapers as needed, see below.
>>
>> The need for such operation sparks from some H/W constraints:
>>
>> https://lore.kernel.org/netdev/9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch/
>>
>>>> +        Output shaper scope must be either @detached or @netdev.
>>>> +        When using an output @detached scope shaper, if the
>>>> +        @handle @id is not specified, a new shaper of such scope
>>>> +        is created and, otherwise the specified output shaper
>>>> +        must be already existing.
>>>> +        The operation is atomic, on failures the extack is set
>>>> +        accordingly and no change is applied to the device
>>>> +        shaping configuration, otherwise the output shaper
>>>> +        handle is provided as reply.
>>>> +      attribute-set: net-shaper
>>>> +      flags: [ admin-perm ]
>>> Does there need to be a reciprocal 'ungroup' operation? Without it,
>>> create / group / delete seems like they will have ambiguous semantics.
>>
>> I guess we need a better description. Can you please tell where/how the current one is
>> ambiguous?
> 
> My expectation for 'group' would be to group existing things, with a
> reciprocal 'ungroup' operation. I think you intend 'group' to both be
> able to group existing shapers/groups and create a group of shapers.
> 
> Am I right in saying that delete lets you delete something from a group
> (with side-effect of deleting group if it becomes empty), or delete a
> whole group?

In the current incarnation, delete() on the whole group is explicitly 
forbidden. Jakub suggested we should allow such behavior for the 
delegation use-case.

> It feels a lot like each of 'set', 'group' and 'delete' are doing
> multiple things and the interaction between them all becomes challenging
> to describe, or to handle all the corner case > I think part of the
> problem is the mixed terminology of input, output for groups, handle,
> parent for shapers and using detached to differentiate from 'implicitly
> attached to a resource'.
> 
> Perhaps the API would be better if you had:
> 
> - shaper-new
> - shaper-delete
> - shaper-get/dump
> - shaper-set
> - group-new
> - group-delete
> - group-get/dump
> - group-set
> 
> If you went with Jakub's suggestion to give every shaper n x inputs and
> an output, then you could recombine groups and shapers and just have 4
> ops. And you could rename 'detached' to 'shaper' so that an attachment
> is one of port, netdev, queue or shaper.

I'm unsure I read the above correctly, and I'm unsure it's in the same 
direction of Jakub's suggestion. AFACS the above is basically the same 
interface we proposed in the past iteration and was explicitly nacked 
from Jakub,

Additionally, one of the constraint to be addressed here is allowing to 
setup/configures all the nodes in a 'group' with a single operation, to 
deal with H/W limitations. How would the above address such constraint?

Thanks,

Paolo


