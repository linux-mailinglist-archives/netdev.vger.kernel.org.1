Return-Path: <netdev+bounces-124139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D889396843C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CBD283473
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD318593D;
	Mon,  2 Sep 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1e/PKF4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286313D521
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271858; cv=none; b=ffsbd1wYepCT+MLx5iyMNmKtt3gXpcXeA8mH+sDT0seHwa3vV4+oOuO4FFa3l2MfC5B1RIUciBMmYw5gHyzYpbGqzkbHogbXc/kFknb54HSPvIJC6s7BUyxi6Os4U1gEr6ETeo2vUwjrGXo7YaAFI9p9gXoWqn5H4wV/96sMMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271858; c=relaxed/simple;
	bh=yGexeTk3DFekN3ab0AQwkVA01UScZccfqJtztxw0B8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjTPLHh1KHeSy+HMyGcQnOCXhDs0DFLEbqF7F73KhdiY/00ElwXHhs6NvtBAyxg/OvQSLOWwGks+ir5sV/UszIk6gToheX5f4c9ZdW4XPZyH2xYZBqRcq87gROIBhvqaQFmr14blOVKywSqoQDY1896dMP65q4bMQhglYOvTGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1e/PKF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko0VtalU6TRd2mcjtdDzNrGiHlfUv5J7DOtlyGXRSv8=;
	b=P1e/PKF4ITrNYMbXt4WsBEXHOY67VPTreGceh23W4rwYVr9KpDaUtXVxoTGbaf/KbTgkYM
	+fw/RGlTuLrqhB7I/XNhtWD4dooyGQvfe5kGZ+m562rVpeyrExMELJv8q7siCnS5OaYm2Z
	UQ6zyYdKeqz3RPsWzsk+awRVlJRy/OU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-BQ4GNFTgPserLK4u1QnxYQ-1; Mon, 02 Sep 2024 06:10:54 -0400
X-MC-Unique: BQ4GNFTgPserLK4u1QnxYQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bbe9083d1so25247115e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 03:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271853; x=1725876653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ko0VtalU6TRd2mcjtdDzNrGiHlfUv5J7DOtlyGXRSv8=;
        b=GKuzLeV/24oS/bpU1U8SnY32m2cEsFx/efwELiXvnKg71ZlUnZcFBQoL5tZJcDY9FN
         aTd7SB0u8p3PaxbNlvBO1eAUvB/WDqoeGXSQvfwNhYkhz7rPjxKuE1+sDT4N/fV/yE28
         mcxUWWC4y2JcPQtBKMFPI0VmyjN7b7gjsMe7OW/QkKYP09X5p2xH0+Oa40YAzkDxEBi4
         zxO98bN/cmcLMuXcps6Q1Lnm+a0zHJYYytcsV8WxKsLR1id9t7BAnXf0f7Cs72qnbHsT
         mtH736I5UdFfizo2qyYOhr2OhHCIA1C31BI+Kwxm4zRGVthArUSHpT9HT3S98mtm29T3
         Aq3Q==
X-Gm-Message-State: AOJu0YxQ3sbUg79STL3452rRZ87QOKt8qSfnoXDABPo9KeN47SFyKIEe
	0iQpN/rcAqBHxsph5h1TOBNe4UbmpcS1tzC8KW5X32M4qQAZsLJaAbCnK9Fzh7S/okk4D3K6SyZ
	nxAUQk2L1xY4PK6yLXAEzcb31jbILX9ScpaUN2MD+Nj0YUPw448hfbw==
X-Received: by 2002:a05:600c:1c09:b0:423:791:f446 with SMTP id 5b1f17b1804b1-42c7b59e335mr44157535e9.7.1725271853548;
        Mon, 02 Sep 2024 03:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeJOyJ/Ar6rX0WhVMfQs2myZpFdPxS2VVeL1tGE/EIyhRLHqUFol+/by50MHVDasgoZUwWZQ==
X-Received: by 2002:a05:600c:1c09:b0:423:791:f446 with SMTP id 5b1f17b1804b1-42c7b59e335mr44157165e9.7.1725271852979;
        Mon, 02 Sep 2024 03:10:52 -0700 (PDT)
Received: from [192.168.179.247] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9d54f98sm7541793f8f.69.2024.09.02.03.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:10:52 -0700 (PDT)
Message-ID: <c6d8052c-c5a0-48e2-8984-0063afc1e482@redhat.com>
Date: Mon, 2 Sep 2024 12:10:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1724944116.git.pabeni@redhat.com>
 <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
 <20240829182019.105962f6@kernel.org>
 <58730142-2064-46cb-bc84-0060ea73c4a0@redhat.com>
 <20240830121418.39f3e6f8@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830121418.39f3e6f8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/30/24 21:14, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 17:43:08 +0200 Paolo Abeni wrote:
>> Please allow me to put a few high level questions together, to both
>> underline them as most critical, and keep the thread focused.
>>
>> On 8/30/24 03:20, Jakub Kicinski wrote:
>>   > This 'binding' has the same meaning as 'binding' in TCP ZC? :(
>>
>> I hope we can agree that good naming is difficult. I thought we agreed
>> on such naming in the past week’s discussion. The term 'binding' is
>> already used in the networking stack in many places to identify
>> different things (i.e. device tree, socket, netfilter.. ). The name
>> prefix avoids any ambiguity and I think this a good name, but if you
>> have any better suggestions, this change should be trivial.
> 
> Ack. Maybe we can cut down the number of ambiguous nouns elsewhere:
> 
> maybe call net_shaper_info -> net_shaper ?
> 
> maybe net_shaper_data -> net_shaper_hierarchy ?

Is everybody fine with the above?

>> [about separate handle from shaper_info arguments]
>>   > Wouldn't it be convenient to store the handle in the "info"
>>   > object? AFAIU the handle is forever for an info, so no risk of it
>>   > being out of sync…
>>
>> Was that way a couple of iterations ago. Jiri explicitly asked for the
>> separation, I asked for confirmation and nobody objected.
> 
> Could you link to that? I must have not read it.

https://lore.kernel.org/netdev/ZqzIoZaGVb3jIW43@nanopsycho.orion/

search for "I wonder if the handle should be part of this structure"

I must admit by wannabe reply on such point never left my outbox.

> You can keep it wrapped in a struct *_handle, that's fine.
> But it can live inside the shaper object.

That is basically the opposite of what Jiri asked. @Jiri would you be ok 
reverting to such layout?

>> Which if the 2 options is acceptable from both of you?
>>
>> [about queue limit and channel reconf]
>>   > we probably want to trim the queue shapers on channel reconfig,
>>   > then, too? :(
>>
>> what about exposing to the drivers an helper alike:
>>
>> 	net_shaper_notify_delete(binding, handle);
>>
>> that tells the core the shaper at the given handle just went away in the
>> H/W? The driver will call it in the queue deletion helper, and such
>> helper could be later on used more generically, i.e. for vf/devlink port
>> deletion.
> 
> We can either prevent disabling queues which have shapers attached,
> or auto-removing the shapers. 

I think/fear that prevent disabling queues would lead to 
weird/unexpected results and more difficult administration, I prefer the 
callback option.

> No preference on that. But put the
> callback in the core, please, netif_set_real_num_rx_queues() ?
> Why not?

It makes sense. I'll add a net_shaper_set_real_num_rx_queues() callback 
there.

/P


