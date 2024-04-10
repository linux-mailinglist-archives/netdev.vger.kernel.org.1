Return-Path: <netdev+bounces-86529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1327389F1C2
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1A82859CF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C8515B10D;
	Wed, 10 Apr 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0xkzE5Oy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299515ADAD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751171; cv=none; b=YlAv6qtz4jS5UKlJCLEl+efOrFArwp4so/g85Vbcud53+8DutI6kubFvZqagtY+cGM7MA4v9C6ojvxyfUzngZoseVx4fBIPklJSVuvLyvrB/76oTqJwfePnGpsZAVDQskKXIOB2KmqvaSok0askciaA5Grm9m3JRg+HvoxglyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751171; c=relaxed/simple;
	bh=H21IK5kaNxJvV7WV8XeSBXhrOO9f1Hme4WViXUTcysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDSDEfywPxuAA1qCE82D7aTOkctWL0KzaaUuuyvm0n0+GTHiGEOvFfNH28JF1+x5StxjxaxZYcGZFJ0OCoIsFByOo3FZOdlEJyn+HZADG0WY08kpfb0w66WWozQyfSb60x6f560QYiljXnbLA+KzeHPeP+BIFnKPhsDHJC0QW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0xkzE5Oy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450bedffdfso928894366b.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712751167; x=1713355967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AfPWn54N7knEAS1AXT/Gw/Pc7DAeDG1cBFQXDzRacMY=;
        b=0xkzE5OyA2q7IYKiIObh9hYU5OK4n1vK6dsDJfE10OTiBUchcKfUyMvLgObcP9+ZG1
         LDNKGIILMxmvdxSWGAgBeBFSXjqHMTGjwpITNmO7Db4csHVkdCGUomXdwXmUyijagxtZ
         ffIfLbhLglLGGAnCRwaSiWSzZ1+TrjkHiNukQWzFPUDIjMbUkm6JlWmuF7DPvuA1Vzbh
         B3/W9bTz4A1PJwWDDrZENqw52N9BRH60JCP+vLTd2OYfcVuCGIZqPr0IFMg3eC/CKvDv
         vRaXK8tgyfpwQoVdvDDLM01RZ++Tuw6h0/hwjMVTBT/BPCzW65rBCLmFxbeeLiKrnvdy
         MmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751167; x=1713355967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfPWn54N7knEAS1AXT/Gw/Pc7DAeDG1cBFQXDzRacMY=;
        b=SPrbRdbdxVZInAyKYmnoF0IqvU7Er6v/beYE/KFbhW6M1Nd+crtiquYXWSeKyJ3j9e
         DspvivOwHi0sl1M+vwCQ8h4Poa+BC3UnTUArv61mr2pjRUb7TmLBE4cjKZLwYPR4WhBI
         BXmrjW5uiq8Sunej9kTGe6BdUCMYUOYyYuyVbj4IzEAorgP9QYrjWHn5VdhaPXGf2Fbl
         m6YL6MgU8Y4KW3ZorFKEDAldxGlqFiupcgsGQXr8fxD93nw+Iql99s3QWv/uhG+N3I6v
         aS2cWa9YwO6CjEP6W6yFXm8lbY17wwmajdBAa3FtLiCLyuaI9jN0IZ/izLrFYegZcLxX
         dr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5XwDSTzg7qQxJF9IsCd+wBlNCgGFGzCn4kG3JDZ1Iu3F0h5XirA7njALhlmeaJ7nPqDcPrLibiunit1TixLhq4VJWdM4
X-Gm-Message-State: AOJu0Yz54KbQ6w05z8RYPbBscNfqetXku1jzrg6kqelWRt6idpGt2rU+
	7nGNjzNNdem8oHNgBDioJGIvKOxUcSNaOeDcIUiuzEYOduK/g/N0JPcSqC4Mx/k=
X-Google-Smtp-Source: AGHT+IGDmR4gdoHnckU6TWE0tDNbUAIWbD6AMJ0CXEJf+TLoL3L/SDjPimz7MwydmYJdQ5AO7amrkQ==
X-Received: by 2002:a17:907:ea5:b0:a51:c281:60f3 with SMTP id ho37-20020a1709070ea500b00a51c28160f3mr1775965ejc.77.1712751166607;
        Wed, 10 Apr 2024 05:12:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906041000b00a4e781bd30dsm6832583eja.24.2024.04.10.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:12:45 -0700 (PDT)
Date: Wed, 10 Apr 2024 14:12:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhaCOwc9oUqbkZoF@nanopsycho>
References: <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <66142a4b402d5_2cb7208ec@john.notmuch>
 <ZhUgH9_beWrKbwwg@nanopsycho>
 <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
 <ZhVThhwFSV0HgQ0B@nanopsycho>
 <043179b5-d499-41cc-8d99-3f15b72a27cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <043179b5-d499-41cc-8d99-3f15b72a27cc@intel.com>

Wed, Apr 10, 2024 at 01:45:54PM CEST, aleksander.lobakin@intel.com wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>Date: Tue, 9 Apr 2024 16:41:10 +0200
>
>> Tue, Apr 09, 2024 at 03:11:21PM CEST, aleksander.lobakin@intel.com wrote:
>>> From: Jiri Pirko <jiri@resnulli.us>
>>> Date: Tue, 9 Apr 2024 13:01:51 +0200
>>>
>>>> Mon, Apr 08, 2024 at 07:32:59PM CEST, john.fastabend@gmail.com wrote:
>>>>> Jiri Pirko wrote:
>>>>>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>>>>>>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>>
>>>>>>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>>>>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>>>>>>> should not be accepted.
>>>>>>>>>>>
>>>>>>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>>>>>>> enough to satisfy the "commercial" requirement?
>>>>>>>>>>
>>>>>>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>>>>>>> benefiting only proprietary software.
>>>>>>>>>
>>>>>>>>> Sorry, that was where this started where Jiri was stating that we had
>>>>>>>>> to be selling this.
>>>>>>>>
>>>>>>>> For the record, I never wrote that. Not sure why you repeat this over
>>>>>>>> this thread.
>>>>>>>
>>>>>>> Because you seem to be implying that the Meta NIC driver shouldn't be
>>>>>>> included simply since it isn't going to be available outside of Meta.
>>>
>>> BTW idpf is also not something you can go and buy in a store, but it's
>>> here in the kernel. Anyway, see below.
>> 
>> IDK, why so many people in this thread are so focused on "buying" nic.
>> IDPF device is something I assume one may see on a VM hosted in some
>> cloud, isn't it? If yes, it is completely legit to have it in. Do I miss
>> something?
>
>Anyhow, we want the upstream Linux kernel to work out of box on most
>systems. Rejecting this driver basically encourages to still prefer
>OOT/proprietary crap.

Totally true. Out of the box on as many systems as possible. This is not
the case. Can you show me an example of a person outside-of-Meta can
benefit from using this driver out-of-box?


>
>> 
>> 
>>>
>>>>>>> The fact is Meta employs a number of kernel developers and as a result
>>>>>>> of that there will be a number of kernel developers that will have
>>>>>>> access to this NIC and likely do development on systems containing it.
>>>
>>> [...]
>>>
>>>>> Vendors would happily spin up a NIC if a DC with scale like this
>>>>> would pay for it. They just don't advertise it in patch 0/X,
>>>>> "adding device for cloud provider foo".
>>>>>
>>>>> There is no difference here. We gain developers, we gain insights,
>>>>> learnings and Linux and OSS drivers are running on another big
>>>>> DC. They improve things and find bugs they upstream them its a win.
>>>>>
>>>>> The opposite is also true if we exclude a driver/NIC HW that is
>>>>> running on major DCs we lose a lot of insight, experience, value.
>>>>
>>>> Could you please describe in details and examples what exactly is we
>>>> are about to loose? I don't see it.
>>>
>>> As long as driver A introduces new features / improvements / API /
>>> whatever to the core kernel, we benefit from this no matter whether I'm
>>> actually able to run this driver on my system.
>>>
>>> Some drivers even give us benefit by that they are of good quality (I
>>> don't speak for this driver, just some hypothetical) and/or have
>>> interesting design / code / API / etc. choices. The drivers I work on
>>> did gain a lot just from that I was reading new commits / lore threads
>>> and look at changes in other drivers.
>>>
>>> I saw enough situations when driver A started using/doing something the
>>> way it wasn't ever done anywhere before, and then more and more drivers
>>> stated doing the same thing and at the end it became sorta standard.
>> 
>> So bottom line is, the unused driver *may* introduce some features and
>> *may* provide as an example of how to do things for other people.
>> Is this really that beneficial for the community that it overweights
>> the obvious cons (not going to repeat them)?
>> 
>> Like with any other patch/set we merge in, we always look at the cons
>> and pros. I'm honestly surprised that so many people here
>> want to make exception for Meta's internal toy project.
>
>It's not me who wants to make an exception. I haven't ever seen a driver
>rejected due to "it can be used only somewhere where I can't go", so
>looks like it's you who wants to make an exception :>

Could you please point me to some other existing driver for device
that does not exist (/exist only at some person's backyard)?


>
>Thanks,
>Olek

