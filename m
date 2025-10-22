Return-Path: <netdev+bounces-231687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D57BFC9AB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF41A1890497
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399C33FE30;
	Wed, 22 Oct 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jFcfKjpA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D3288502
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143696; cv=none; b=fwS64uX9YuW+J7lB53wiFtouDqe2GdGsUiREFvVo77xZe91kuDr1PXXi9DOBIKqGmtmm6OwG/jAxJgGZGJmDGn+NFIhhruyJG+FfunUchgI4JCKWbJCikahBBpxIjeoVJTGf3ouZy/dQm0lxbLxWNqOjijrhyiE5mJKGJDWghVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143696; c=relaxed/simple;
	bh=bhx4JIMOsOLyxoh5iaw6fY2106oxPWu40Tk17S5ixiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+8W2eXhmx0Fy+sE4BtsCEJzE/nMUJWmHVJi/PC2jE/+LjWskp15XefPmtZKg2GdACKcPv+5LnhycmVGNbwLziBXa+FXQaxzuQjktxuywj2VxuBRYGGMXB2BjBhKTiJJ9SS10/5yWshxQLxSMu/7W+FtaZ37xSDNKGZAr2zXIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jFcfKjpA; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430aeaffeaeso30766075ab.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761143692; x=1761748492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXKn3DvJBAZ9GweZX6DfWOhob/lcdXEQubsOfEnxg9Q=;
        b=jFcfKjpA+K748glxno7Hh7iGr87X2zo72FHrhDO2yLngXchqmTHRiVgEmgmIIsV40K
         I51PWjYsQ49oRW3R6aEwb8tevqfeJmJrRQI4Bh652UQjhMdE6WWS/Yf5EjkkBmEffNYo
         cv7XPJ5/p40tc/XSfV9xZ1DTyBIU6QL1sZuog5JeymMfjWIst4eB0NaMKMKPCi15Wzsw
         igYxchOloLQwJ+uJUFba/+Se+B+pZpKE01B9zVWDRrydZqO0OiJSX/NfzJcFzME1ux86
         coTwghW/Ib24LLLeAMQBXOzJGUqGwX6FqxQu7PbzgoN5gjOXjjtqNlgsTeGYmxVEt6h+
         7cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143692; x=1761748492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXKn3DvJBAZ9GweZX6DfWOhob/lcdXEQubsOfEnxg9Q=;
        b=T9nuCOfcQ+mHnck7jNxFa62c24qB6MX9id6AI7fZIpW0Sovv5TzXUDpeqTpSXnjSBg
         7prGej40/m50925vhq4NIl0GAj5HWBPNiZzEfZhV6ipgoGIC18Wd8C+G5dqh3zrBYhKY
         5ND+74R8GCeqmc1wLgTLlCvRZ0O3bIB8B/5tx0JSN2mtM1cWT1oL8bXaq2ScdjSr/uM+
         B2d+wdCmU1hxBXvJ7NGFTWru6nWVMU8C99c+jNBCcPvnoV5xCQPlwhO9Gmtz8iI5vumT
         7taI5wXImgocS3W6m0FGAOQwNTbdbm4UYH79dPIBJSUdQYTRdkANpMyId2HjvaCSUPBy
         pptg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWcYrPPSdn8dFhZL2ZeD0wLnfGFGa7BnhVPEEh6BnENLY2lrCbERcfJNoPES+IhDCTuvINh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZQbBMkH81JiWkz8Aog5BXk58kPqsLip4PDy4FIZ3Muhs9QUI
	GQg6vRIyyBzieawzNmJmyQ72y4oGLTzqx8H9kHv/3T3OuiwKrbA6Loivk2glpK18HPs=
X-Gm-Gg: ASbGncveuLt+hNWRMzcmy08U+UMe2AjvQW/aXur1K2/yhv0VxD1z4AjnGHwUl3qOXdL
	vKm5C/I/nur7q6mhXeHjyqChscdvczoYXMVREhXdkgrqo/FfTBqf/Sa/z2t8Z7b12CJCg8ilFHw
	l1LAdiW3RjP+iCJueXsZCfyVAnxp1Vwup9kiDh4gwCgNJj+LTUnHDFmjfK9VsOWzPxaH95zRQ7h
	/iSr2wqX+Hj5J356nz3YHf6CQNwjMUvkvORWCkJGJc27031dN1Ynytnh8BW4S3nm6uyE0yQVoS+
	q3i1+uvWla2mPrPxwesmCcrf1BsrTZh24ZqqnKjk9NFeO6NkqKzx5I+iK4Jm6VoOu6nshCHzjZ+
	PSpq/032DQ5Ox2D0BtI0yBjXm5NFVMKr86oVe+2Y7MfK5LCI3PausCC9uljuX04RaHoDDcTTr
X-Google-Smtp-Source: AGHT+IE10HHz3yYmx/uffRuhbNijBKwCmDk4nFNFl6cPcdopzfDt0ksJsMbZUdbdsJqXHbK4drp8pQ==
X-Received: by 2002:a92:c26c:0:b0:431:d864:3658 with SMTP id e9e14a558f8ab-431d864382dmr11809555ab.20.1761143691536;
        Wed, 22 Oct 2025 07:34:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973f39esm5060663173.40.2025.10.22.07.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:34:51 -0700 (PDT)
Message-ID: <8486dc74-44a3-4972-9713-2e24cefced22@kernel.dk>
Date: Wed, 22 Oct 2025 08:34:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
References: <20251021202944.3877502-1-dw@davidwei.uk>
 <60d18b98-6a25-4db7-a4c6-0c86d6c4f787@gmail.com>
 <832b03de-6b59-4a07-b7ea-51492c4cca7e@kernel.dk>
 <3990f8ee-4194-4b06-820e-c0ecbcb08af1@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3990f8ee-4194-4b06-820e-c0ecbcb08af1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 8:25 AM, Pavel Begunkov wrote:
> On 10/22/25 14:17, Jens Axboe wrote:
>> On 10/22/25 5:38 AM, Pavel Begunkov wrote:
>>> On 10/21/25 21:29, David Wei wrote:
>>>> Same as [1] but also with netdev@ as an additional mailing list.
>>>> io_uring zero copy receive is of particular interest to netdev
>>>> participants too, given its tight integration to netdev core.
>>>
>>> David, I can guess why you sent it, but it doesn't address the bigger
>>> problem on the networking side. Specifically, why patches were blocked
>>> due to a rule that had not been voiced before and remained blocked even
>>> after pointing this out? And why accusations against me with the same
>>> circumstances, which I equate to defamation, were left as is without
>>> any retraction? To avoid miscommunication, those are questions to Jakub
>>> and specifically about the v3 of the large buffer patchset without
>>> starting a discussion here on later revisions.
>>>
>>> Without that cleared, considering that compliance with the new rule
>>> was tried and lead to no results, this behaviour can only be accounted
>>> to malice, and it's hard to see what cooperation is there to be had as
>>> there is no indication Jakub is going to stop maliciously blocking
>>> my work.
>>
>> The netdev side has been pretty explicit on wanting a MAINTAINERS entry
> 
> Can you point out where that was requested dated before the series in
> question? Because as far as I know, only CC'ing was mentioned and
> only as a question, for which I proposed a fairly standard way of
> dealing with it by introducing API and agreeing on any changes to that,
> and got no reply. Even then, I was CC'ing netdev for changes that might
> be interesting to netdev, that includes the blocked series.

Not interested in digging out those other discussions, but Mina had a
patch back in August, and there was the previous discussion on the big
patchset. At least I very much understood it as netdev wanting to be
CC'ed, and the straight forward way to always have that is to make it
explicit in MAINTAINERS.

>> so that they see changes. I don't think it's unreasonable to have that,
>> and it doesn't mean that they need to ack things that are specific to
>> zcrx. Nobody looks at all the various random lists, giving them easier
>> insight is a good thing imho. I think we all agree on that.
>>
>> Absent that change, it's also not unreasonable for that side to drag
>> their feet a bit on further changes. Could the communication have been
>> better on that side? Certainly yes. But it's hard to blame them too much
>> on that front, as any response would have predictably yielded an
>> accusatory reply back.
> 
> Not really, solely depends on the reply.

Well, statistically based on recent and earlier replies in those
threads, if I was on that side, I'd say that would be a fair assumption.

>> And honestly, nobody wants to deal with that, if
> 
> Understandable, but you're making it sound like I started by
> throwing accusations and not the other way around. But it's
> true that I never wanted to deal with it.

Honestly I don't even know where this all started, but it hasn't been
going swimmingly the last few months would be my assessment.

My proposal is to put all of this behind us and move forward in a
productive manner. There's absolutely nothing to be gained from
continuing down the existing path of arguing about who did what and why,
and frankly I have zero inclination to participate in that. It should be
in everybody's best interest to move forward, productively. And if that
starts with a simple MAINTAINERS entry, that seems like a good place to
start. So _please_, can we do that?

-- 
Jens Axboe

