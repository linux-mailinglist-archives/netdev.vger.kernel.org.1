Return-Path: <netdev+bounces-115036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC92944ED5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8567F283060
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2313B79F;
	Thu,  1 Aug 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKq9iVjw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292013B5B4
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525129; cv=none; b=Rq8XTBG46omygHqqQpGZy97xYgMpz6+4GPhcST9JBwNLuAX7zfYByMfwYTdpmMm/uIQG/qcf9YXWXZY/a+qGjglk5NkpmDxb3XP9mLsSTAC+aPMhyEJcZuA9jhazubWbnjbs1Ouu07pIFv8e3Rd7rQSk/qhBTAdZkq6WoWJtqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525129; c=relaxed/simple;
	bh=18bVSiMv7eVZikV8wL2VJ9F4KdLM9g98GSiK8BhKXec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aK2egp03qHIrNIq13ITXDjisodJwB4G1jN4ItexHXaNesf8z511oYKacp3BLjjIhWJ6NLPpodF3gRdr+6kPu4dWLCPIxxVcmu0YdKs7Ng22tdPC4uNoSS3XzfRC/sAHJrEGs8EPhjXfdzYaKY7QxPcFO5fxSJW6kJ+HYoPMwfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKq9iVjw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri6zj3SniWU6hKqHkuXV/xv9Ufh1jmbL+jJxpaOWsBY=;
	b=JKq9iVjw4XHpFQRxDbX+adzxNuwVQCMcXf9iw/llPem8EmvzJIjKxNtLROOpDscQXQod91
	lDJTUnPqAo6sqPkbuO9+JJzwUE6IweNxfHoV4WovALzQivbneN4o1CDzqSFyNDS7J8Kxi0
	6qK16uyjhzfYLUf+ZRXD8prFcU7oZe4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-BlhppSfDMGq-QoWS9JhzFw-1; Thu, 01 Aug 2024 11:12:05 -0400
X-MC-Unique: BlhppSfDMGq-QoWS9JhzFw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280ec27db9so6783635e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 08:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525124; x=1723129924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri6zj3SniWU6hKqHkuXV/xv9Ufh1jmbL+jJxpaOWsBY=;
        b=XFTY6XVXaF3fvOTID2yYT17BszYWTYjp/e/5yomr/SM78I3gFrhKxrnEo4qGv6Sbyq
         kOELK+NCB3Y2rp/IVt6Y+NIYwrZo0Lsdc5rtlotclYzO4dELL2DdbFLPw2eBpeiTcJkZ
         w9aP6yOk0jbpmAUNWoRyWm1roZSpRwiBjVvji5tQXw4EREJ38c7NR7lh5oilANH7kn8e
         6gxSNWAIj9fM2w1R56Tj9Vj/T8Q40CEuGeVg4TEKNHeTgk/YWiEv8WYU9CU6NwSBOrUP
         ftvoAU/ssLutSFVU4p2GEnMC6KFenypFvnM4GUc0mDCB92h3EOt8LNn87EDdnD87Z9sg
         KO7w==
X-Gm-Message-State: AOJu0YxMbYGCvS2ZacV+ZjuO5uWJszNBGUvR+X6TqFR42/Wofr9npDbK
	JHSY0a5ZVvAp/EYJSqrYiQKivsPbmUBDCbDxWSfgzsZmwmhdArrK07WHycf62ilEu9BQYmG/IK1
	fYN31salobKqMIv7pP5dI1M8BfDUsJiZUJD3mcgWn/XFmtdlAqWlH5A==
X-Received: by 2002:a05:600c:1c0a:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-428e6b96d8bmr758995e9.4.1722525124367;
        Thu, 01 Aug 2024 08:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc/6lr1dfOIPgniFvfV1XUZNC3wGj9XxFfgsqVpWsWXWsQcKLxv7Q2eYPI0kWo2R1mTXrdoQ==
X-Received: by 2002:a05:600c:1c0a:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-428e6b96d8bmr758875e9.4.1722525123880;
        Thu, 01 Aug 2024 08:12:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adc7dsm61343485e9.14.2024.08.01.08.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:12:03 -0700 (PDT)
Message-ID: <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
Date: Thu, 1 Aug 2024 17:12:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZquJWp8GxSCmuipW@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 15:10, Jiri Pirko wrote:
> Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:
>> +    type: enum
>> +    name: scope
>> +    doc: the different scopes where a shaper can be attached
>> +    render-max: true
>> +    entries:
>> +      - name: unspec
>> +        doc: The scope is not specified
>> +      -
>> +        name: port
>> +        doc: The root for the whole H/W
> 
> What is this "port"?

~ a wire plug.

>> +      -
>> +        name: netdev
>> +        doc: The main shaper for the given network device.
>> +      -
>> +        name: queue
>> +        doc: The shaper is attached to the given device queue.
>> +      -
>> +        name: detached
>> +        doc: |
>> +             The shaper is not attached to any user-visible network
>> +             device component and allows nesting and grouping of
>> +             queues or others detached shapers.
> 
> What is the purpose of the "detached" thing?

I fear I can't escape reusing most of the wording above. 'detached' 
nodes goal is to create groups of other shapers. i.e. queue groups,
allowing multiple levels nesting, i.e. to implement this kind of hierarchy:

q1 ----- \
q2 - \SP / RR ------
q3 - /    	    \
	q4 - \ SP -> (netdev)
	q5 - /	    /
                    /
	q6 - \ RR
	q7 - /

where q1..q7 are queue-level shapers and all the SP/RR are 'detached' 
one. The conf. does not necessary make any functional sense, just to 
describe the things.

>> +    -
>> +      name: group
>> +      doc: |
>> +        Group the specified input shapers under the specified
>> +        output shaper, eventually creating the latter, if needed.
>> +        Input shapers scope must be either @queue or @detached.
>> +        Output shaper scope must be either @detached or @netdev.
>> +        When using an output @detached scope shaper, if the
>> +        @handle @id is not specified, a new shaper of such scope
>> +        is created and, otherwise the specified output shaper
>> +        must be already existing.
> 
> I'm lost. Could this designt be described in details in the doc I asked
> in the cover letter? :/ Please.

I'm unsure if the context information here and in the previous replies 
helped somehow.

The group operation creates and configure a scheduling group, i.e. this

q1 ----- \
q2 - \SP / RR ------
q3 - /    	    \
	q4 - \ SP -> (netdev)
	q5 - /	    /
                    /
	q6 - \ RR
	q7 - /

can be create with:

group(inputs:[q6, q7], output:[detached,parent:netdev])
group(inputs:[q4, q5], output:[detached,parent:netdev])
group(inputs:[q1], output:[detached,parent:netdev])
group(inputs:[q2,q3], output:[detached,parent:<the detached shaper 
create above>])

I'm unsure if this the kind of info you are looking for?

Thanks,

Paolo


