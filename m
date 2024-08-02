Return-Path: <netdev+bounces-115317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197C945D37
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91A3B233D9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B64A1BE87A;
	Fri,  2 Aug 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9wsXYjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC741E2105
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597825; cv=none; b=MG3GIWp2gfYpWVVCjp6aRdoOhZ8tzvomjf9R1ywpiSpglAHnwijzYJdxhz2jRCw3k0A9K5LY/pHWcVMLwBUNHUT7zMlZa5ZMgPJy49H5aYI07Yk53EgWCUWK9WNtUt1XbmyjG/wkNChaxV24EHRLlFQb26WvJod2SKMLhQEypjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597825; c=relaxed/simple;
	bh=HK70yXsR9aZWezVLI9CCM1DkJCHBVP2/I3fqBVM+ELs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GD+Cqe1347dVUbazi1bXkc4jP44z6t0krQfz/h8gBYsjpJe/IcCbcyIFHWVLuBBRghj1DOBoiVyyilHP6J9i4VfPXIjJbA2dvUhMoDiv2YBRfqstseK4Nv0NxsBfjeXxdtpE6fMlys9eK1mmG/xlsDUu7gQjiF1laZOsvW9+qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9wsXYjl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428243f928cso31352805e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722597822; x=1723202622; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDx3eMMxICOBZCrFI1F1Tld3RkqbQ7pLe0KGfCPJhzo=;
        b=H9wsXYjlV/MWTRdMv23/vHWX90yoPnrc/0Cftp9udI3VJP44FpE31BNedV9E9K+Q4L
         weKJ88ecNc2ssveXck0zk5rgZGqibYuubAS0v6muJ6MW1HNsZN5esiCscsf9tZdT8/lz
         4Z+I2FDXFqQSkwcbMPnKH8MEh2MMBc0oSrmlsmT0F8xIOGCWmE6pOJ0WqPmbQjDUkkMa
         DWE7i87dxVS54Jz5ycyb5BW1ztIJq2oKFztbyo2PgN+RDgP1BNKy5qaAFKQed1OdP8sA
         RCydNDCye7i5PXOLGURJnPowx/WpibNH+KHpYxzlSCZr/RTUpjPvWM8bv1v9YMwkC9yx
         /oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597822; x=1723202622;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDx3eMMxICOBZCrFI1F1Tld3RkqbQ7pLe0KGfCPJhzo=;
        b=cQAHy38ekzWMFQH0B4sZ6f02H14FECrgXGDUfZToxj7TUa/U8dCro7syKsBy7ZhY0E
         tdutaYLAY0s5dA57fie2biasViMjeYuaH5fxouH43s7r+g0UYscJ+Y9JGagkwYwAqAzV
         d2ytghplwH822m0OeqZ7KjM0Lg9Pqz28w9H10f1xKyF9eCuYDhyltSuMvQzYt5igufAK
         5n9V3mhIeRnyIp8RxlpYSAXcVAEIXrEeVqE5GKF5ZOcIWFIy16HOWjQsuTocu3XBH2zO
         UQiPUQZjPpgheCTgE1gAofCBRcQ7SJB0wAY3mMhN6qHsyfTdHH6XqYN8ZVCYGwp4mKto
         7NhA==
X-Gm-Message-State: AOJu0YzJDBcoyL+eaMUqUAB15IrAUc9I7UD5Smxtp8GqYX8mUOF455qx
	Q3lw9tQ/1TYYzbHxz3fVhiJrjeD3hLYzszMd7Xa3slpS5EOX3n/T
X-Google-Smtp-Source: AGHT+IHzew68rWDtDIHh0H+Vk/0dr6xoqqO+Ld3Q36p6je3L3n3F8n5lwSZV7Qe7pGNcKP4aPwfJJA==
X-Received: by 2002:a05:600c:4e8e:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-428e6a60397mr23558115e9.0.1722597821532;
        Fri, 02 Aug 2024 04:23:41 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e8ca:b31f:8686:afd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7d585sm29261455e9.35.2024.08.02.04.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:23:40 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Madhu Chittim <madhu.chittim@intel.com>,  Sridhar
 Samudrala <sridhar.samudrala@intel.com>,  Simon Horman <horms@kernel.org>,
  John Fastabend <john.fastabend@gmail.com>,  Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
In-Reply-To: <07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com> (Paolo Abeni's
	message of "Thu, 1 Aug 2024 16:31:04 +0200")
Date: Fri, 02 Aug 2024 12:15:30 +0100
Message-ID: <m2v80jnpkd.fsf@gmail.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<m25xslp8nh.fsf@gmail.com>
	<07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paolo Abeni <pabeni@redhat.com> writes:

> On 7/31/24 23:13, Donald Hunter wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>> 
>>> +        name: inputs
>>> +        type: nest
>>> +        multi-attr: true
>>> +        nested-attributes: ns-info
>>> +        doc: |
>>> +           Describes a set of inputs shapers for a @group operation
>> The @group renders exactly as-is in the generated htmldocs. There may be
>> a more .rst friendly markup you can use that will render better.
>
> Uhm... AFAICS the problem is the target (e.g. 'group') is outside the htmldoc section itself, I
> can't find any existing markup to serve this purpose well. What about sticking to quotes ''
> everywhere?
>
> FTR, I used @ following the kdoc style.

Yeah, I was just thinking of using .rst markup like ``code`` or
`italics`, but the meaning of @ is pretty obvious when reading the spec.
If you stick with @ then we could always teach ynl-to-rst to render it
as ``code``.

>
> [...]
>>> +    -
>>> +      name: group
>>> +      doc: |
>>> +        Group the specified input shapers under the specified
>>> +        output shaper, eventually creating the latter, if needed.
>>> +        Input shapers scope must be either @queue or @detached.
>> It says above that you cannot create a detached shaper, so how do you
>> create one to use as an input shaper here? Is this group op more like a
>> multi-create op?
>
> The group operation has the main goal of configuring a single WRR or SP scheduling group
> atomically. It can creates the needed shapers as needed, see below.
>
> The need for such operation sparks from some H/W constraints:
>
> https://lore.kernel.org/netdev/9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch/
>
>>> +        Output shaper scope must be either @detached or @netdev.
>>> +        When using an output @detached scope shaper, if the
>>> +        @handle @id is not specified, a new shaper of such scope
>>> +        is created and, otherwise the specified output shaper
>>> +        must be already existing.
>>> +        The operation is atomic, on failures the extack is set
>>> +        accordingly and no change is applied to the device
>>> +        shaping configuration, otherwise the output shaper
>>> +        handle is provided as reply.
>>> +      attribute-set: net-shaper
>>> +      flags: [ admin-perm ]
>> Does there need to be a reciprocal 'ungroup' operation? Without it,
>> create / group / delete seems like they will have ambiguous semantics.
>
> I guess we need a better description. Can you please tell where/how the current one is
> ambiguous?

My expectation for 'group' would be to group existing things, with a
reciprocal 'ungroup' operation. I think you intend 'group' to both be
able to group existing shapers/groups and create a group of shapers.

Am I right in saying that delete lets you delete something from a group
(with side-effect of deleting group if it becomes empty), or delete a
whole group?

It feels a lot like each of 'set', 'group' and 'delete' are doing
multiple things and the interaction between them all becomes challenging
to describe, or to handle all the corner cases. I think part of the
problem is the mixed terminology of input, output for groups, handle,
parent for shapers and using detached to differentiate from 'implicitly
attached to a resource'.

Perhaps the API would be better if you had:

- shaper-new
- shaper-delete
- shaper-get/dump
- shaper-set
- group-new
- group-delete
- group-get/dump
- group-set

If you went with Jakub's suggestion to give every shaper n x inputs and
an output, then you could recombine groups and shapers and just have 4
ops. And you could rename 'detached' to 'shaper' so that an attachment
is one of port, netdev, queue or shaper.

