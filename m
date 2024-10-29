Return-Path: <netdev+bounces-139833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535649B45BE
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62851F21C1D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826D1E0E04;
	Tue, 29 Oct 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfoVoXJj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCEA1DED7D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194165; cv=none; b=mn5mx2hNgfslNyfZMOuqKpy8qIobxra+Iu/diUkL0mO3Rj7Em5fO5KXL9v+7ulcTFAAn5mfVA0UwECGB6n2h1dmxBXUtIodL5M/JcT0GM++COpPs+Kez8VE8AVZuLLDpATK4hXbkiGU7fmZGimXUyF99BLgzfg1bpKfkkT2OAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194165; c=relaxed/simple;
	bh=64gd4JJ9PPNFDgKbR5eNFHXIzEkp1rCU6eghQgzIcmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfYmUyOEmnCAml9d/46YunkXUHx7zZGwEOHPTdGkpKSw9eAsZPjBmYWipT/uHcZBsCWlll4pxIvKA9JJuNg2cYKzIxolVksopOcN6ukEL9mc8Dwb+vym/Zu1uQPTa4eviVjS9dUXDwJ4K5cYCutxR/8xIMw7+cr4JcbmFws+EQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfoVoXJj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730194161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK6VtE8TVucGO/UD6l26VE5fms10Y2iwMIjUQQir04s=;
	b=DfoVoXJjmR96Ox7YLR9iQkidsz/sFN2OmIU314bwK7B/6H5VOI3S9dAdGE883W+fZURgxy
	fYhPVwL/OK/4dHai2zmhdk1bHNifYHmyusAR+kEhOTmpsCyIC9wsbTvtEzZkOQQvQDYCTZ
	ARWsKEk2DBVVuTU53jwg+Fu2UjLQ5n0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-8p9Zmw4VNxiCn-890idvuA-1; Tue, 29 Oct 2024 05:29:19 -0400
X-MC-Unique: 8p9Zmw4VNxiCn-890idvuA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53b1eddcf4aso3993242e87.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 02:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730194158; x=1730798958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK6VtE8TVucGO/UD6l26VE5fms10Y2iwMIjUQQir04s=;
        b=qKo2lxVH1+UjB4qZDHlxtwknquhLlBYUFFCz077FzTEd/Q2YAuMJ63gcTnkP8lKS70
         cwR+WW66a4yzKQPu0sYKmH/slRrm0G1k/rW9bp2z5UuvGoSEd8tL8s51LIWq6Zk+8LGL
         /JpvzsEzLDTSQiwUpLPRbOd3QEIqwYtKJmRv6LIgSg3hmnhVZhTlONH8CZ4BiRkVr1DD
         HxByCr3pXQ6AggCJB1R2Xkl3TDP3+1S9VLBai7LTKOIJDXBgXdJSekT36EiaSnkRqZzF
         Cuz0hWbllUL5WbeuqRbUpn2VC76LrAR2+QjvtwELzdJUED5GO5KJhYSsTKSgIvMF/X2R
         Olrw==
X-Forwarded-Encrypted: i=1; AJvYcCUc5BRthczFDo2r6+Nz8Z+TWrdvOhvOituPoFhsnU/CA5Oeiqz/sEzdzl+ttQ6dt0/8DjNCkYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTK0Hm+rIYtaLa4ix/9oFFmfhBe+x13eRREle/nJ11Dnw8vQ9Y
	IqlyMxU6gB/pwf+7OwKs4uwGTPM5QglBX5qo5xb/8Q1oWcV0mDqzIhSiEW129ojBuZPzb5Z1r9d
	WS/nLPfqT3rRXBjAXoGwaXXvbhEH3bPJFwpGr0/k7wXkxZsIcqBhssg==
X-Received: by 2002:a05:6512:39c7:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-53b348c0c88mr5879055e87.4.1730194158207;
        Tue, 29 Oct 2024 02:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsiohyMD1Fa5A1pCW/+a+P90ueatOcOedNJitBrEVxfph4Q5/LjV18oOcCLFHVfV6FoHrl1A==
X-Received: by 2002:a05:6512:39c7:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-53b348c0c88mr5879040e87.4.1730194157757;
        Tue, 29 Oct 2024 02:29:17 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193594c8esm136354215e9.11.2024.10.29.02.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 02:29:17 -0700 (PDT)
Message-ID: <46b77837-2f87-44aa-a6f2-e61919591659@redhat.com>
Date: Tue, 29 Oct 2024 10:29:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: yaml gen NL families support in iproute2?
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
 <61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
 <ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
 <42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
 <20241028135852.2f224820@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241028135852.2f224820@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 21:58, Jakub Kicinski wrote:
> On Tue, 22 Oct 2024 09:55:08 +0200 Paolo Abeni wrote:
>> On 10/21/24 22:58, Joe Damato wrote:
>>> On Thu, Oct 17, 2024 at 12:36:47PM -0600, David Ahern wrote:  
>>>> On 10/17/24 11:41 AM, Paolo Abeni wrote:  
>>>>> Hi all,
>>>>>
>>>>> please allow me to [re?]start this conversation.
>>>>>
>>>>> I think it would be very useful to bring yaml gennl families support in
>>>>> iproute2, so that end-users/admins could consolidated
>>>>> administration/setup in a single tool - as opposed to current status
>>>>> where something is only doable with iproute2 and something with the
>>>>> yml-cli tool bundled in the kernel sources.
>>>>>
>>>>> Code wise it could be implemented extending a bit the auto-generated
>>>>> code generation to provide even text/argument to NL parsing, so that the
>>>>> iproute-specific glue (and maintenance effort) could be minimal.
>>>>>
>>>>> WDYT?  
> 
> Why integrate with legacy tooling? To avoid the Python dependency?

My guestimate is that the majority of the end users would prefer a
single tool (or at least a consistent 'look & feel') and they are
already accustomed to iproute and it's command line.

>>>> I would like to see the yaml files integrated into iproute2, but I have
>>>> not had time to look into doing it.  
>>>
>>> I agree with David, but likewise have not had time to look into it.
>>>
>>> It would be nice to use one tool instead of a combination of
>>> multiple tools, if that were at all possible.  
>>
>> FTR I'm investigating the idea of using a tool similar to ynl-gen-rst.py
>> and ynl-gen-c.py to generate the man page and the command line parsing
>> code to build the NL request and glue libynl.a with an iproute2 like
>> interface.
>>
>> Currently I'm stuck at my inferior python skills and -ENOTIME, but
>> perhaps someone else is interested/willing to step in...
> 
> How do your Python skills compare to your RPM skills?
> The main change we need in YNL CLI is to "search" the specs in
> a "well known location" so that user can specify:
> 
>  ynl --family netdev ...
> 
> or even:
> 
>  ynl-netdev ...
> 
> instead of:
> 
>  ynl --spec /usr/bla/bla/netdev.yaml
> 
> And make ynl in "distro mode" default to --no-schema and
> --process-unknown

Thanks for the hints.

I think that packaging the ynl tool is an orthogonal activity WRT the
goal/discussion here.

> That's assuming that by
> 
>   so that end-users/admins could consolidated administration/setup 
>   in a single tool
> 
> you mean that you are aiming to create a single tool capable of
> handling arbitrary specs. > If you want to make the output
> and input more "pretty" than just attrs in / attrs out -- then
> indeed building on top of libynl.a makes sense.

My understanding is that a similar/consistent command line and man page
based documentation will preferable for the end-user - say to configure
ip addresses and configure tx shaping on a given device.

i.e. libynl would be a good starting point, but IMHO ideally it should
include a few bells and whistles alike ifindex <> interface name
conversion, explicit 'required arguments' list, etc...

Cheers,

Paolo


