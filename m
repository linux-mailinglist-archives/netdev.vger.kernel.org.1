Return-Path: <netdev+bounces-101394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9EA8FE5FA
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE681F25204
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58F168C10;
	Thu,  6 Jun 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG8m01Ef"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91033178CC9
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675324; cv=none; b=QBNduZHJFn34Y+Hzw9eRe8XSiEgBgL/qkyft5lZVZWHrPKvY8tGbSv/fnDQEhoohIcRTgcLYAAThYj7ehUbxjl/tA8M4XRWHfo2RW09jO41ygUm2f9hM8bNmYxWvfhX0/59hOk8nu5qtaYeVS1JF6/SjRAouBtAOCzhJza3YfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675324; c=relaxed/simple;
	bh=XzA9XcS9J8/JaJGhY85xTyvzVAiJwfKIIBi3J6rxAwM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oSOX1XuGSIDs+z1jUIvzlXymCjxqMt1u9btTv8HR6s9v1nonMFhAEA/VYuBLA44miQAqQ+ey0BltIaECiRMLOJR5Dal/sAbtZIZyJ1lpYD4efeqjiYWAj5rHn0wvkKh8WggY/3c2Y747uKfaycfx4vCNIgv7KKjoZB6JqNahKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NG8m01Ef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717675321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1PVj6wl0RhMQ9aVu/kpZquF9TBmMzt7pDp7sPNrIU4=;
	b=NG8m01EfkrXJkJGwgDbOjTdlf4hxxSxa9y8ubtHu/+BShqnf0n4BsSXvfUNrkzGI1uC1kg
	iKqVUe3AmZpbH3D0TdclIGcpE71t1GWWeswoNLw9GYUOG9oo4lzbTGtlw5wVKX+W+FqQml
	jZ1tetsFdVDT4OjaKZLc9S3bskTfDpE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-JTd7b_KgNNee052XB_FukA-1; Thu, 06 Jun 2024 08:01:59 -0400
X-MC-Unique: JTd7b_KgNNee052XB_FukA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eaa74bfc18so6433791fa.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 05:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675317; x=1718280117;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1PVj6wl0RhMQ9aVu/kpZquF9TBmMzt7pDp7sPNrIU4=;
        b=iU82Ap2euemkP90KHxRp6Um5b8ELVCc0b3KsytZoP/Vswu+TFc1g62aKJoCeZeRwC7
         pRko9IF+pLSmopSXOJYCHqeg44G0h23/6a9y68twtUmy9HlmxFqH5R9KXOuaIcFUrlJe
         boWgAA3Plktf6hhSztPQIyiXORvoAaJHUHd+Xv/gwoMOFEorpfUce1Kj6H85dQVHso0z
         iK9J4JwLdPsy1mwUkvl//4DQ+67HL6VAorneF0kKolAN8BWz6ZzgyvnU1T5JnIiVtKL0
         5Uxmq/RKnjrKYlXQgpiGIJlPw0AI4w5nLlZCy61/09n3c30S09GROCi/7IiXIzHFJYEO
         tWVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZB54mSQxyq6LV94nO8wcFkwFOtUOyE6Q+zHLiaMhRjRaEXdj45RDStsYehqH6mSsqcPF8rlaI8aDKZyWEw9x3AacR4Iir
X-Gm-Message-State: AOJu0YwPsjOrSuKS4lVZPudkbS0UUcGp4bu6A5V9eJFT0k9mRTwUWZuE
	8qT8hdCPxB6YfVrHA0IAW2qY+oa6Lsgwns1zu94rn3NXyEKpY+XEY36n4DGRkgSBlBNXzeBgZPW
	VgGUIs8w+IrIvbendivj+OUl1lbHpVCjadB3HgsmiWKN7KYoBIsaBqw==
X-Received: by 2002:a2e:6804:0:b0:2d6:dba1:6d37 with SMTP id 38308e7fff4ca-2eac79c3350mr33444991fa.11.1717675317618;
        Thu, 06 Jun 2024 05:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2WITeGFROobQCTrCntY3Omdm5T0qGOCAwnVA1tvshsd8kmSQuctYu9lHc2+ZfKmWSvWTupQ==
X-Received: by 2002:a2e:6804:0:b0:2d6:dba1:6d37 with SMTP id 38308e7fff4ca-2eac79c3350mr33444781fa.11.1717675317163;
        Thu, 06 Jun 2024 05:01:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d296sm980451a12.7.2024.06.06.05.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 05:01:56 -0700 (PDT)
Message-ID: <9d821cea-507f-4674-809c-a4640119c435@redhat.com>
Date: Thu, 6 Jun 2024 14:01:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Hung tasks due to a AB-BA deadlock between the leds_list_lock
 rwsem and the rtnl mutex
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Linux LEDs <linux-leds@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, johanneswueller@gmail.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Genes Lists <lists@sapience.com>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
 <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
 <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
 <42d498fc-c95b-4441-b81a-aee4237d1c0d@leemhuis.info>
 <618601d8-f82a-402f-bf7f-831671d3d83f@redhat.com>
 <01fc2e30-eafe-495c-a62d-402903fd3e2a@lunn.ch>
Content-Language: en-US, nl
In-Reply-To: <01fc2e30-eafe-495c-a62d-402903fd3e2a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 5/31/24 2:54 PM, Andrew Lunn wrote:
>> I actually have been looking at a ledtrig-netdev lockdep warning yesterday
>> which I believe is the same thing. I'll include the lockdep trace below.
>>
>> According to lockdep there indeed is a ABBA (ish) cyclic deadlock with
>> the rtnl mutex vs led-triggers related locks. I believe that this problem
>> may be a pre-existing problem but this now actually gets hit in kernels >=
>> 6.9 because of commit 66601a29bb23 ("leds: class: If no default trigger is
>> given, make hw_control trigger the default trigger"). Before that commit
>> the "netdev" trigger would not be bound / set as phy LEDs trigger by default.
>>
>> +Cc Heiner Kallweit who authored that commit.
>>
>> The netdev trigger typically is not needed because the PHY LEDs are typically
>> under hw-control and the netdev trigger even tries to leave things that way
>> so setting it as the active trigger for the LED class device is basically
>> a no-op. I guess the goal of that commit is correctly have the triggers
>> file content reflect that the LED is controlled by a netdev and to allow
>> changing the hw-control mode without the user first needing to set netdev
>> as trigger before being able to change the mode.
> 
> It was not the intention that this triggers is loaded for all
> systems.

<snip>

> Reverting this patch does seem like a good way forward, but i would
> also like to give Heiner a little bit of time to see if he has a quick
> real fix.

So it has been almost a week and no reply from Heiner. Since this is
causing real issues for users out there I think a revert of 66601a29bb23
should be submitted to Linus and then backported to the stable kernels.
to fix the immediate issue at hand.

Once the underlying locking issue which is the real root cause here
is fixed then we can reconsider re-applying 66601a29bb23.

Regards,

Hans






