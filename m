Return-Path: <netdev+bounces-115815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6F947E05
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E50B26070
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832AA13CFAA;
	Mon,  5 Aug 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO21pVJt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF74D8BA
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871439; cv=none; b=GCY3R9K2ekSBakgp3eKJiK30Vc+66MRniZGBiAdR0X33EUbo0tjQGindJWqoimVQZM3kna3WDNEWm30y3wM9U/XhFq8/VIQ2tPBwCwe07KG7YMtZzGChfbjpG7x09n3LlGaAdVXanWyzSU4FYKup1RBuDDm6kCpdL1JD1OEvdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871439; c=relaxed/simple;
	bh=Fe+krHi1sJiUvqj2dx7v99b9tN3bSorZ8UI3bE0kJOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR3WUPkbo2Qott82+IAUjOsiRvm9ogV4z8IWkdMx13NfzJMih6YNlWFzq/C442fc9nPDmcWCbIFYuX+6qZDewFRT+ysqi41pvr/CRC/KD3RS35Wh3Htip4OfGKKj6y0LorbabCPDCix9D9TN+vOrQIAWalCHvg4jVS4rIEKJOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO21pVJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722871436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ5p6JP+yqjU2+1AeD8RnMVMPAEkcUwj6W2OcXIlPJA=;
	b=DO21pVJtElUzQfLQfaVLoQ3bxBIOgNq4YPz5pqixkjStQNIuXtY0SvWCG6aKZSK3QQKMBn
	Rykiy+to1LNhnHzN/ixvCGl782PeYiR8/Eh2JAPq9UhJqtbcD3vxmrNDcpHXFjoXXlcT/l
	1NT1yu1yyf+kj/uibtwFnUQg7kdlowU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-559tR8PYMx2jmyJpbveU1w-1; Mon, 05 Aug 2024 11:23:55 -0400
X-MC-Unique: 559tR8PYMx2jmyJpbveU1w-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25e65d02dd4so13678fac.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871434; x=1723476234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ5p6JP+yqjU2+1AeD8RnMVMPAEkcUwj6W2OcXIlPJA=;
        b=iqYtZRGxkioqGJ2jEXxhFUwmEc6ZundAcW0DaTpBm0zZqpAu0Yr+IUHfVkhP05cs0F
         lN2n3OTJLWgJ6zqb9D4ICYx7Wrt1rYJfapyXcSZq5UXrjZSwIkSbD5WF1lvLm/8qJJVw
         0XUE6EfaMEGuZoXainW9oMV+gmsTzW9Ov53uVlwBKBhwMkR4Xfjyw+cr2wK0PpFFZiAC
         e7s9H4M/+umqY1witzvnmqsLVlEjaMVnzxheFG7DJxT0uStC3iHvo8j+9v6fjlOKwlTT
         VozYmghsqeh8Gybj4qJDxKkiCkd7k7A71GaGGDdSkzwWvDzffiO/7zJkuw1nL3td5A/l
         7OZA==
X-Gm-Message-State: AOJu0Yykq22VdPJgg/dSqWKkCMoRbRdbsLdi7u9XDMzyzA4LthYj/m32
	CxZ21U9PrcorGxEIZrvM4DTM7xl2ruvV6YjrcY5tylTlKJ45v0jCXa+2EK3OULHoizHhIahXJyG
	h9DWhJyI28O1/ni6f8xKmKGHyl3PincLNj1j4734GHORvNjbTtzgnfo8e2hOwFYkS
X-Received: by 2002:a05:6358:5f1a:b0:1ac:f069:c64e with SMTP id e5c5f4694b2df-1af3bb4a8b0mr718704955d.5.1722871434507;
        Mon, 05 Aug 2024 08:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNZm9xojDDnDD5O/Ul3XMMl3PVIfSbgEJdXre0RKBklwOzHJ94YVjLb68UluBh3KuIudsgbg==
X-Received: by 2002:a05:6358:5f1a:b0:1ac:f069:c64e with SMTP id e5c5f4694b2df-1af3bb4a8b0mr718702855d.5.1722871434067;
        Mon, 05 Aug 2024 08:23:54 -0700 (PDT)
Received: from [192.168.0.114] (146-241-0-122.dyn.eolo.it. [146.241.0.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b64b3sm36503276d6.59.2024.08.05.08.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:23:53 -0700 (PDT)
Message-ID: <cb43ff1f-7f79-4f81-8d27-6efaa18945b5@redhat.com>
Date: Mon, 5 Aug 2024 17:23:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] net-shapers: implement NL set and delete
 operations
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
 <20240801080012.3bf4a71c@kernel.org>
 <144865d1-d1ea-48b7-b4d6-18c4d30603a8@redhat.com>
 <20240801083924.708c00be@kernel.org> <Zq0GJDGsfOt5MiAj@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zq0GJDGsfOt5MiAj@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 18:15, Jiri Pirko wrote:
> Thu, Aug 01, 2024 at 05:39:24PM CEST, kuba@kernel.org wrote:
>> On Thu, 1 Aug 2024 17:25:50 +0200 Paolo Abeni wrote:
>>> When deleting a queue-level shaper, the orchestrator is "returning" the
>>> ownership of the queue from the container to the host. If the container
> 
> What do you meam by "orchestrator" and "container" here? I'm missing
> these from the picture.
> 
> 
>>> wants to move the queue around e.g. from:
>>>
>>> q1 ----- \
>>> q2 - \SP1/ RR1
> 
> What "sp" and "rr" stand for. What are the "scopes" of these?

The scope is 'detached'

>>> q3 - /        \
>>>       q4 - \ RR2 -> RR(root)
>>>       q5 - /    /
>>>       q6 - \ RR3
>>>       q7 - /
>>>
>>> to:
>>>
>>> q1 ----- \
>>> q2 ----- RR1
>>> q3 ---- /   \
>>>       q4 - \ RR2 -> RR(root)
>>>       q5 - /    /
>>>       q6 - \ RR3
>>>       q7 - /
>>>
>>> It can do it with a group() operation:
>>>
>>> group(inputs:[q2,q3],output:[RR1])
>>
>> Isn't that a bit odd? The container was not supposed to know / care
>> about RR1's existence. We achieve this with group() by implicitly
>> inheriting the egress node if all grouped entities shared one.
>>
>> Delete IMO should act here like a "ungroup" operation, meaning that:
>> 1) we're deleting SP1, not q1, q2
> 
> Does current code support removing SP1? I mean, if the scope is
> detached, I don't think so.

The current code explicitly prevents the above. We can change such 
behavior, if there is agreement.

My understanding is that Donald is against such option.

>> 2) inputs go "downstream" instead getting ejected into global level
>>
>> Also, in the first example from the cover letter we "set" a shaper on
>> the queue, it feels a little ambiguous whether "delete queue" is
>> purely clearing such per-queue shaping, or also has implications
>> for the hierarchy.
>>
>> Coincidentally, others may disagree, but I'd point to tests in patch
>> 8 for examples of how the thing works, instead the cover letter samples.
> 
> Examples in cover letter are generally beneficial. Don't remove them :)

No problem to keep both examples and self-tests.

Thanks,

Paolo


