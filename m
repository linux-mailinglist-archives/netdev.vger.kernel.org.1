Return-Path: <netdev+bounces-83089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DAE890AA1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 21:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5591C1F22BFB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E9135A4D;
	Thu, 28 Mar 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpnfpnTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B54436D
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656523; cv=none; b=A7DFuSaFjlzSL/xxMgu7EtZlPTJRn+DyZX+pZEzwk+H/nwuQ04Ai0176XxJpBufHJ/DK1RDzBoElpeorM+gxsj4c4QO26QyvDg8uUqsgWwnp/YIhPgKclYgVHPn+V1fUDcdynkntQNw+pWDqIlBJ4vNO7R0yTpwZrzWRazoXxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656523; c=relaxed/simple;
	bh=I6t3KgEjU2qRRP9KcrIVac26J7Ptg9Ppmc9MupShoAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Adi8ZY8epQEk2PmQ4DIppo51Q/6g8eozWS2a4Z85HCn27tM1a5aPEJe1sRIiSVr5DYtHEnLpXa8ZlPddbYC6CGflwy7PVRFLosWCjAkBPFprXcVkEctvbS6pgFqWsyvoYSyjypXmE2XGVmuaI2NaJnKlHzAE0ptfPNdTmp55dxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpnfpnTg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3686ab64840so1944905ab.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711656521; x=1712261321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hX2UbkZLAvO5S7Uy00v/GVOeEJGGpXwNcZ+Fuf8n4FI=;
        b=YpnfpnTgwIdALWq7x4aoH3uydG5qqCsPZLAMPt2eGGQWzMyiwd4n7tdUkOBVCul53E
         +71MEGOl7faNC6m4tVQ0sFXcWvOz+G7zyTeO0P5v812bXSx97B9u04C6gYcn1lQ1JqE3
         8UY8hnjtoIeLlvrXm4BXSJHAy958jGBzRg9mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656521; x=1712261321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX2UbkZLAvO5S7Uy00v/GVOeEJGGpXwNcZ+Fuf8n4FI=;
        b=d/F+NSq/xYytkAIiwgwV2e1fQys/OKg+/9+9hvG612IjqVWWAFyIY/DYQGUCPcn/Yy
         AGSVhIbIw1p58lUTQ1HV/62YpMslHZLMgmsA3XkqusnMYL2PMxjJNN4fMR3qpib97YCn
         jUF6Mk5zRKEBv+jdTjc7CM9e4kU9X3/zyiP5rbf95z2ee1pum2/Si0c1fQOmrpI2iifZ
         LzfOLzvjdiBXCtn/Pv+TQ6BFA2tBtWNum98BI3VvFaASVDl3kyEFtQCRWNLh8CssTO6m
         ZYGu2SKIWhcrrXh7JzOHpAnnlbFgOkp6xvQRg0yg772pfWa0TaOLXzW7X/DKwu5R/Q8O
         VDYA==
X-Forwarded-Encrypted: i=1; AJvYcCVBsoE0Gq3ONKBMf+kClYJSzL8U7cGIyZRxEmBO9LhI/eeOueLzKvp7c77nRaOllVWEsDTXwo7EFhXkCXveB7fnSatyte2p
X-Gm-Message-State: AOJu0YxOzhLWlFXkZGCxJQ1l3/jrheYVv8HYMTXpoJfbFgzd634ecFI3
	nPcN2ehQvrnpOzQpbXUrnoVZYy+6RIpX63h0eTzdIEY7meRTLZvXDa9MNeu+wTk=
X-Google-Smtp-Source: AGHT+IH5wuRtwUVhmqx4NqxWb5J05EXj4zhK6mJCrXso5RB+soobtzV7zz03fOsFxx7Dm/XUqXlavQ==
X-Received: by 2002:a5d:9b1a:0:b0:7d0:8461:7819 with SMTP id y26-20020a5d9b1a000000b007d084617819mr243559ion.1.1711656521397;
        Thu, 28 Mar 2024 13:08:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x101-20020a0294ee000000b0047ecf81bea3sm367165jah.84.2024.03.28.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 13:08:40 -0700 (PDT)
Message-ID: <6591ea0d-572b-4deb-b2a7-da58ed91c8f9@linuxfoundation.org>
Date: Thu, 28 Mar 2024 14:08:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kunit alltests runs broken in mainline
To: David Gow <davidgow@google.com>, Johannes Berg
 <johannes@sipsolutions.net>, SeongJae Park <sj@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
 Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
 "x86@kernel.org" <x86@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
 <20240325185235.2f704004@kernel.org>
 <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
 <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 04:09, David Gow wrote:
> On Tue, 26 Mar 2024 at 15:55, Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> On Tue, 2024-03-26 at 01:52 +0000, Jakub Kicinski wrote:
>>>
>>> I'm late to the party, but FWIW I had to toss this into netdev testing
>>> tree as a local patch:
>>>
>>> CONFIG_NETDEVICES=y
>>> CONFIG_WLAN=y
>>
>> I'll send this in the next wireless pull, soon.

You are welcome to send this with wireless pull if you like
or I can include it in my pull request.

Either way let me know:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

>>
>>> CONFIG_DAMON_DBGFS_DEPRECATED=y
>>
>>> The DAMON config was also breaking UML for us, BTW, and I don't see
>>> any fix for that in Linus's tree. Strangeness.
>>
>> I noticed that too (though didn't actually find the fix) against net-
>> next, wireless trees are still a bit behind. I guess it'll get fixed
>> eventually.
>>
> 
> + Shuah, sj
> 
> Thanks for fixing this. I've sent out a fix (though I'm not 100% sure
> it's the right one) to the DAMON issue here:
> https://lore.kernel.org/linux-kselftest/20240326100740.178594-1-davidgow@google.com/
> 

I applied this to linux-kselftest kunit-fixes branch

I am planning to send this up tomorrow.

> I don't think it'd conflict with the wireless fix, but if so, I'm
> happy for them both to go in via KUnit if that's easier.
> 

thanks,
-- Shuah

