Return-Path: <netdev+bounces-129005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EF97CE9B
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 22:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387D11F2374B
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5F143866;
	Thu, 19 Sep 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLUnylzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA95381B8
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779459; cv=none; b=f4oizUdg8kZZCDgTHmVLcwvXIlfzJD+b3jrjorq6ezBdiI4G8uEJk3HiCl0rurNJTjyp8kDffM8snP8z/7esHg8+4gETMDXK57WS+Ynskk0XWq4EoMLakzozUVtX97m6nuJDF9Wn/aRVzz3VEz7ZySTnK8t/iFE7GF5fTkQtk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779459; c=relaxed/simple;
	bh=DJfyhXhFpnqahmqCEvRPHnVcq8m8mDV85y6HU7KLD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W0/LszFSvnWefhVeLuR7NT9h6zy3OehDBI7Y+pbskWiKFowbv2Bzz2Da+WXHAwC5Dk4E1kK9ggsiq48wP8j+oJ2ngP/oBQsk9w7VYKk/2d9M22Q2UJ68oB7FpshLKSugs/PEaNy8Je/Nqn9iAK9eSOCYwOnEnRDYmUfTzOo3jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLUnylzc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d13b83511so152662966b.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726779453; x=1727384253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TqNNWG5+/kZlHtP0pWgdcSeT7qPKatvBpH/sgYzxRfM=;
        b=NLUnylzcmxMTLGJoMqQ77dhZV0VSfVwHsJXdjwO4b7qyhaKo5r0FmSgur02jNH7j0L
         u3YzjoDaHq8m6ptrTVx14ZEqVD25rD6k10yf83m/8rg40miAq8J54hFCXUEn1ySUP54V
         a8HOfTD1/wc3loViKm2xI4UGFBarsYoh1Hp1mw4FBxvi0PV14XpYqGsrFDKRkgWmjdee
         A8RuRUXAC2vA0uGxLPRc8UKzZV64t87ZloZJorPiivgrtLwZYsCEQfTPl81pkrmmiOVL
         f4cVCmhLmXyuJ5KAxukvaY7xj8y2lldkB0ksIfOUdAaiFlrYn5ElUn9Z848yip5NR+iZ
         3Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726779453; x=1727384253;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqNNWG5+/kZlHtP0pWgdcSeT7qPKatvBpH/sgYzxRfM=;
        b=RozAld2D5h5FNRNmT7GpHUvIBKOqGCer99T4gHqMuIqgC6mDACshc4Vw5AeU6DUnZC
         aSWpjWtZgufOkDgzQZhwr4hLqY2ZMiR3bDPqdv1Uef0/MmCGZKy7xTCPpfp/HgiMjObx
         qHU4JTqms5kC4Sk6r3srDJpj3sbLAy8q4Ht0cJCEW3Uikx/21dHlnEPjU9aPJsu4oMKH
         WGOOn5mh8bzNZo2FRnU8hdNO2EA65fBI0qOHGKxWaxwRZ3mUr9ZH1poC4ppMC8SNlR52
         4DH6tLnm+Caq4uv3B3gskEEELw29z+ckl9tv+qQR0RIR19dfEU4hqFtQs6uTWPdHThqr
         b7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVPelnSKQHD1By9YRnhFhu48Y9lWKNcnoVb2Ssq6s/zP58+pioEx0HK/qco+toypCpzXu8zajE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFafBEOM+Kfqw+ZgOVvkbq8agtZZJuVN/dd0u/y65vRk716gbI
	rBGzdcRo7MdYc68C/N37OJsGCqRGCWbrF/XkKZBksIejkQoVmWukKehsrG/m
X-Google-Smtp-Source: AGHT+IEvW+bDt0dmv7iBUmKZ6aAviX/VTeVIMJjb8ID+W7v6SBoBie+zZxCbYd0nCf14lvBJaAAG+A==
X-Received: by 2002:a17:907:a4b:b0:a86:aee7:9736 with SMTP id a640c23a62f3a-a90d59257d4mr31447566b.46.1726779452881;
        Thu, 19 Sep 2024 13:57:32 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:2e00:5cf0:9f97:8137:f553? (dynamic-2a02-3100-a14c-2e00-5cf0-9f97-8137-f553.310.pool.telefonica.de. [2a02:3100:a14c:2e00:5cf0:9f97:8137:f553])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a90610f4416sm760603066b.60.2024.09.19.13.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 13:57:32 -0700 (PDT)
Message-ID: <3efb28df-e8e2-48e2-b80d-583ade67eefb@gmail.com>
Date: Thu, 19 Sep 2024 22:57:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Submitted a patch, got error "Patch does not apply to net-next-0"
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <2a39433c-3448-4375-9d69-6067e833d988@gmail.com>
 <PH0PR84MB2073021945EE35CCD20FAF33D8632@PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <PH0PR84MB2073021945EE35CCD20FAF33D8632@PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.09.2024 22:30, Muggeridge, Matt wrote:
>> -----Original Message-----
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Sent: Thursday, 19 September 2024 3:57 PM
>> To: Muggeridge, Matt <matt.muggeridge2@hpe.com>;
>> netdev@vger.kernel.org
>> Subject: Re: Submitted a patch, got error "Patch does not apply to net-next-0"
>>
> 
> Thankyou for your detailed and considerate reply, Heiner. As a new submitter, I was trying hard to comply with all the documented process.
> 
>> On 19.09.2024 04:23, Muggeridge, Matt wrote:
>>> Hi,
>>>
>>> First time submitter and it seems I did something wrong, as I got the error
>> "Patch does not apply to net-next-0". I suspected it was complaining about a
>> missing end-of-line, so I resubmitted and get the error "Patch does not apply
>> to net-next-1". So now I'm unsure how to correct this.
>>>
>>> My patch is: Netlink flag for creating IPv6 Default Routes
>> (https://patchwork.kernel.org/project/netdevbpf/patch/SJ0PR84MB2088B1
>> B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLO
>> OK.COM/).
>>>
>>> I followed the instructions at
>> https://www.kernel.org/doc/html/v5.12/networking/netdev-FAQ.html.
>>>
>>> Here's my local repo:
>>>
>>> $ git remote -v
>>> origin
>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>>> (fetch) origin
>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>>> (push)
>>>
>>> After committing my changes, I ran:
>>>
>>> $ git format-patch --subject-prefix='PATCH net-next' -1 95c6e5c898d3
>>>
>>> It produced the file "0001-Netlink-flag-for-creating-IPv6-Default-
>> Routes.patch".  I emailed the contents of that file to this list.
>>>
>>> How do I correct this?
>>>
>>> Thanks,
>>> Matt.
>>>
>>>
>> There's few issues with your submission:
>> - net-next is closed currently. There's a section in the FAQ explaining when and
>> why it's closed.
> 
> To clarify, do I wait for the "rc1" tag before submitting?
> 
It will be announced on the netdev list when net-next opens again.
If this sounds too cumbersome, you can check the net-next status here:
https://patchwork.hopto.org/net-next.html

> FWIW, I read that section, examined the torvalds git repo and saw that
> it had created a tag for v6.11. I presumed that meant that 6.11 is
> closed and the tree was open for 6.12 work. I also noted there were
> other net-next submissions and took that as further evidence the tree
> was open. Also, the top-of-tree has this commit message, which I took as
> evidence that 6.12 was open: 
> 
> Merge tag 'net-next-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>> - Please only one version of a patch per day
> 
> Understood.
> 
>> - Your commit message states that the patch fixes something. So you should
>> add a Fixes tag.
> 
> My patch is in a bit of a grey area. Some would call it a bug fix,
> others would call it new functionality. My patch extends the netlink API
> with some functionality that has previously been overlooked. Indeed,
> when there are multiple default routers in an IPv6 network it is
> expected to provide resiliency in the event a router becomes
> unreachable. Instead, when using systemd-networkd as the network
> manager you get instability, where some connections will fail and others
> can succeed. So, it fixes a network infrastructure problem for systemd-
> networkd by extending the netlink API with a new flag. 
> 
> I'm happy to be guided on this. Would you like to see it submitted to
> net as a bugfix, or net-next as new functionality?
> 
To me it looks more like a fix, in addition the change is rather simple.
However this is something I'd leave to the net maintainers to decide.
The tricky part will be to find out which change this fixes (for the
Fixes tag).
By the way: You sent the patch to the netdev list only and missed the
maintainers. The get_maintainers script gives you the mail addresses.

>>   If applicable also cc the patch to stable.
>>   https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst
>> - If the fixed change isn't in net-next only, your patch should be based on and
>> tagged "net".
> 
> Understood. I chose net-next as new functionality, but if you feel this
> should go in net, then I'll resubmit to net.
> 
>> - Patch title should be prefixed ipv6 or net/ipv6. Not sure which is preferred,
>> both are common.
>>   See change history of net/ipv6/route.c
> 
> Got it. Yes, I see what you mean. Some have net/ipv6 and others ipv6 and
> a few other variants. I will prefix mine with net/ipv6.
> 
> Thanks again!
> Matt.
> 


