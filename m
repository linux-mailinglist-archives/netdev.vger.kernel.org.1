Return-Path: <netdev+bounces-72207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BB85707E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 23:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A805B20BFB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92113DB8A;
	Thu, 15 Feb 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdFclUaJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41C13AA23
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035860; cv=none; b=UFWfLpzVu0vTImSRJEqyoVSVqk/ieDDgZbD0SqB1p5CyQME/+846M51cEoaa/anPP4Ny7kRz1eeqLvHa9exX87YjViCDAxRYSBxQUtjt+ImYmt/x49FtUVsQA7KoCfC+/ptU63+LA+Df3oocOuqM3AWBOwxM0kiJFiBt/hXAME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035860; c=relaxed/simple;
	bh=FlOeB14g7XPlY0lWO+nPX0pgn6/DaydlAMk3PaFsxqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmAzYe8x+9ZjUTXKEUbhnGGMVRATGiCFIkHF5k/q0kqrJmFx+BcRDY2EIkPvGz8rqyfgHWI4TWVcsyru4SK5pjB8YSAbyFkW+MmEb2Wo+2cLMYEyNx0LNEEcdkh+7bf/gzgEV+px/ma/LGasMGbkh36s5ztqkGURWuDhJtCL1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdFclUaJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708035857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YXBGVigttC7QmcBk6NwcAGt/Sy/uu7p0sS4OKpvrpg=;
	b=TdFclUaJW0uVL2v3yiwk7PbkA1bAaX204gBssqUI4Z6MZUnO2o1LIeeAI63IEZvqaBaZ9m
	TFxG5SHD9JF9IDnD6QLVf01BpP/QmbyHfSGA1vkYGE2ruIfEpWfTBEdH52v76ujuFC5AGs
	p6i2g5+Vz/2+HqsJol/FBEcQf9XFFD8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-6junO8kzNO6V3zTLav2fhQ-1; Thu, 15 Feb 2024 17:24:15 -0500
X-MC-Unique: 6junO8kzNO6V3zTLav2fhQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6800aa45af1so861466d6.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035855; x=1708640655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YXBGVigttC7QmcBk6NwcAGt/Sy/uu7p0sS4OKpvrpg=;
        b=hcvEOZrBF6C8yUK79+O1n1oV6vcw+pkcYzdSlwJeMr+QhccwojTYv52vjhaYMqPBL/
         694Vr0PWJAXLGcq9gG5Bim+bIIGrhXcj6oeA+9l7mNQ6Le+K9N+6GjRGJ6HAQQUQ8mdK
         nNW+oBXhIaNbTuDQV6coj8jGUUPqtZsg7upnOt0XeLM9fdL+UcMH082dbemDFa8lemnM
         tSTs35D7TG/m3J7bNz8tIHnD6yHcJ2zymSrKg+RJP0YQPZ+9/hHtLgYyLZaYbBD09aU8
         YzCArFwYDZGvQZQLrRtYnNg/fD+O2ZTULY2BzvJUMPPBQpylzwr/zlo5nwh2dpubVS3Y
         w17A==
X-Forwarded-Encrypted: i=1; AJvYcCVbjoIsvWjm6hxAmvy60EiaLNdJWHN6iwee18xlTy3gd+wrUHpg5TwZifn0r7G8XZvZ7M19cB15kSQdgxHTZnvhTCSRiqFp
X-Gm-Message-State: AOJu0Yxf7vdTPgB3a8Y4PeIthfOLzFt7Vjj/5xL0bdi9srLiuq4rtZ/I
	YJ+pDASF5SSMSBfJslNzF+4kPyF2XPlu92uhq8rPar2QgtRR1ATJjbgRO1Dzj+50jG2BaZEPGTZ
	DVCA+AuvjgKeFuxhSqH3eJ6dyfWQhX9M+od8Thnv+hp0mC6zQVf/dOQ==
X-Received: by 2002:a0c:aa57:0:b0:68c:385b:ac93 with SMTP id e23-20020a0caa57000000b0068c385bac93mr2917806qvb.59.1708035854998;
        Thu, 15 Feb 2024 14:24:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq7Oyos+vNgmyZC6riAM35fisfzbFhnLijJltKt9f3k+WqZXKLZW2/S7nMIza4yz2B1z+efA==
X-Received: by 2002:a0c:aa57:0:b0:68c:385b:ac93 with SMTP id e23-20020a0caa57000000b0068c385bac93mr2917796qvb.59.1708035854648;
        Thu, 15 Feb 2024 14:24:14 -0800 (PST)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id pa6-20020a056214480600b00686ac3c9db4sm1094662qvb.98.2024.02.15.14.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 14:24:14 -0800 (PST)
Message-ID: <89f263be-3403-8404-69ed-313539d59669@redhat.com>
Date: Thu, 15 Feb 2024 17:24:13 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com, dgibson@redhat.com, netdev@vger.kernel.org,
 davem@davemloft.net
References: <20240209221233.3150253-1-jmaloy@redhat.com>
 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com>
 <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
 <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-02-15 12:46, Eric Dumazet wrote:
> On Thu, Feb 15, 2024 at 6:41 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> Note: please send text-only email to netdev.
>>
>> On Thu, 2024-02-15 at 10:11 -0500, Jon Maloy wrote:
>>> I wonder if the following could be acceptable:
>>>
>>>   if (flags & MSG_PEEK)
>>>          sk_peek_offset_fwd(sk, used);
>>>   else if (peek_offset > 0)
>>>         sk_peek_offset_bwd(sk, used);
>>>
>>>   peek_offset is already present in the data cache, and if it has the value
>>>   zero it means either that that sk->sk_peek_off is unused (-1) or actually is zero.
>>>   Either way, no rewind is needed in that case.
>> I agree the above should avoid touching cold cachelines in the
>> fastpath, and looks functionally correct to me.
>>
>> The last word is up to Eric :)
>>
> An actual patch seems needed.
>
> In the current form, local variable peek_offset is 0 when !MSG_PEEK.
>
> So the "else if (peek_offset > 0)" would always be false.
>
Yes, of course. This wouldn't work unless we read sk->sk_peek_off at the 
beginning of the function.
I will look at the other suggestions.

///jon



