Return-Path: <netdev+bounces-160560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01492A1A2E4
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87B6188AF15
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B020E318;
	Thu, 23 Jan 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nToi4wlc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2920E02E
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737631564; cv=none; b=HEs22yiQxh2w/Z9joYDiY9cL0E4gj2Dc+0hjcmrN5fc7qZjPAR+GjoYcFrHcKEDCC0tZpe8c1QT1iEAuFvV7vGhLg+v8kFvwrJMRDymR+t+K62o1JUblZSEJJrlQB/rQ2E4hG2c+L9GdExwae1OsLhIBzq1guN1oaimsFgfX2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737631564; c=relaxed/simple;
	bh=gQZWUuyRZ0kdO1Y14bctDOS5xToDLSxP5ngP5lA6DrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9WzEplmiC5liXsGce5lkNLt8ECzDysovcZb2zW3UxZA7x0Baq0QCgg+kFwgp60jPkMMcz+gVsXty1dxOWxFJGDbWH+stR+FKAZBIs4m7LPyhgi/t+lqeKKrya1n/N71lgQmwkONlHjUMAwumzZN5NN4TxPXrq36fHMeoo8C5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nToi4wlc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so404382f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737631560; x=1738236360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17QdO0/moI8pjkSjSQ6CjXz21ry/HPxNynlS5bc6GPk=;
        b=nToi4wlcB4i5tVrEtQ4HTkSitf2Oy4N/gAPI4tZbrxErrv9CpASOHmGYU2G682CP+7
         iqMFVGWe7c/ctrCPrKYh4eGogGO+ULNo2FxE+C1CHX9BMqxjOQ0ryYHySTTTrsJm9gQG
         3hJMyxWTNe33SLFHym8H8IiY2IZSsws+g6wudkOqqH3hQYeAa86MhInmgtDDfHTC0rnN
         YghY5T9DC5U32Iqm1G57ud52nrvguXfJ7kqso1vw7261/GUwzymi+tDT6HUcN5/+wQYa
         q52RB81CI3NR6gWDog6yJSiXtCLONt2dHzqVUVSWYANujypBC2ZvKY+IoalAPXt8VhX6
         XfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737631560; x=1738236360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17QdO0/moI8pjkSjSQ6CjXz21ry/HPxNynlS5bc6GPk=;
        b=e8fUBjL0NuZQUFXe0BIo1Vp/DufG3bvc74O6jyDOT3//stT1G+5qUoa9mf58UFvvpQ
         EHuNnP3qQ7IagtVjbF0Q/sHZq/LyxAdlzzENSfxjo5j6TIa8SSal2xJArLk9J7lny5Hu
         OF/UdWPUvIF7O2z0RBGVRkk9U6qMujHpEg3iQOZ84Fjm12yN35J0OvhaDT6n40m84W+e
         z1BVDJymUYorWQeJOaCuV6m8T/mcCgOa0ONlth60UGLwk9wIUubLXBp+Z/jMWkxxXkO7
         UCnwP4Ko8BT1IOVY45EWui0ayNHkEmRXyrmp3+e+i3omSx5xhYR6lZ03QP30M8Y92PNw
         ah3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB4X9XwNz6Cz5Gw565Va8RL10bBcLsCYryrhs7Onsyhv2+qmr1/4m0unn3hpwx2O+3W/ziJuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcwpo+ngPFDtXCMvmY/3rSyNv+jlSdS/ZUSi5Uo0NdA5n5SQdU
	jMXCxlcdl6z2qRc/dCtSezgsDH2ILdq7LrltFgCqVO9ipLaYpH3brouBeNXzDro=
X-Gm-Gg: ASbGncvQ2fJTyBAb/aq+SIQ2jIfuOEbm5EANRRRBbiSD9GoQAZ3WgJrSxT4GPc82E/p
	VVln1pe91+RwvCkAkbc9N5nilKDdwfk03vGNObgAPVToYmxZVRzVfhZh204BdHuuvKdjh/I2Xnb
	DOX6ZU39VgXRg7lFUvdAH0X5ksrkBm2sK3grtrKlQL8wcLVOTHNOq4Z2BpOsvXwp62A8QznYAzy
	C0BNMxlyOlrb9CywGAxoZgaH3VyY0PEG1nvxRrvyu6Cr13Qi+Gxehik17t2I46nbYjbJrH9UA6R
	agcVVHkT7hOW
X-Google-Smtp-Source: AGHT+IHCFhTPZ6RFELqX2gS4UWyNs2luCfSeFhEo+KRPtfo5qgGeSbSrRgUDbJGnU2KUkFUQRRcYFA==
X-Received: by 2002:a05:6000:144f:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38bf57c0670mr24341033f8f.54.1737631560101;
        Thu, 23 Jan 2025 03:26:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm19216721f8f.10.2025.01.23.03.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 03:25:59 -0800 (PST)
Message-ID: <49d39ae2-fbe1-4054-bb78-7e0c54626a23@tuxon.dev>
Date: Thu, 23 Jan 2025 13:25:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
To: Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
 <20250120111228.6bd61673@kernel.org>
 <20250121103845.6e135477@kmaincent-XPS-13-7390>
 <134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
 <20250121140124.259e36e0@kmaincent-XPS-13-7390>
 <d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
 <20250121171156.790df4ba@kmaincent-XPS-13-7390>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250121171156.790df4ba@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Kory,

On 21.01.2025 18:11, Kory Maincent wrote:
> On Tue, 21 Jan 2025 15:44:34 +0000
> Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
> 
>> On 21/01/2025 13:01, Kory Maincent wrote:
>>> On Tue, 21 Jan 2025 11:34:48 +0000
>>> Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>>>   
>>>> On 21/01/2025 09:38, Kory Maincent wrote:  
>>  [...]  
>>  [...]  
>>>>  [...]    
>>  [...]  
>>  [...]  
>>>>
>>>> (Cc'ing Niklas and Sergey as this relates to the ravb driver)  
>>>
>>> Yes, thanks.
>>>   
>>>> Why do we need to hold the rtnl mutex across the calls to
>>>> netif_device_detach() and ravb_wol_setup()?
>>>>
>>>> My reading of Documentation/networking/netdevices.rst is that the rtnl
>>>> mutex is held when the net subsystem calls the driver's ndo_stop method,
>>>> which in our case is ravb_close(). So, we should take the rtnl mutex
>>>> when we call ravb_close() directly, in both ravb_suspend() and
>>>> ravb_wol_restore(). That would ensure that we do not call
>>>> phy_disconnect() without holding the rtnl mutex and should fix this
>>>> issue.  
>>>
>>> Not sure about it. For example ravb_ptp_stop() called in ravb_wol_setup()
>>> won't be protected by the rtnl lock.  
>>
>> ravb_ptp_stop() modifies a couple of device registers and calls
>> ptp_clock_unregister(). I don't see anything to suggest that this
>> requires the rtnl lock to be held, unless I am missing something.
> 
> What happens if two ptp_clock_unregister() with the same ptp_clock pointer are 
> called simultaneously? From ravb_suspend and ravb_set_ringparam for example. It
> may cause some errors.

Can this happen? I see ethtool_ops::set_ringparam() references only in
ethtool or ioctl files:

net/ethtool/ioctl.c:2066
net/ethtool/ioctl.c:2081
net/ethtool/rings.c:212
net/ethtool/rings.c:304

At the time the suspend/resume APIs are called the user space threads are
frozen.

Thank you,
Claudiu

> For example the ptp->kworker pointer could be used after a kfree.
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/ptp/ptp_clock.c#L416
> 
> Regards,


