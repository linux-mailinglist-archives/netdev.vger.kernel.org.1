Return-Path: <netdev+bounces-178532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE757A777AD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879A7166F18
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7031EDA0D;
	Tue,  1 Apr 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPdcnHQZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535511C7006
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499622; cv=none; b=Y4ZqMxKtz1s1hPtjaiN+Ru6+HuR4Ass52RBlxswDsldqQX4elub6qeQurDRANQHCmYgcP/LlIwfZPNdDXcMOOUZVHJ9uEK+KW1kWdKKZlFbXVm4hiz9025HTsOT0k1mig/6gOK7sVsp6qSrSLyAo1tCS+EHvOWl2DIIDCtRFWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499622; c=relaxed/simple;
	bh=RGDowPCAGuj867zdN5U68AnSEqQazuLOkGo5GI4oCYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3r6u8qnIau1EYplyTyS8EgFRx1eYq0/5WmPxunU35/v9l+Vt1yInD4MtXFxMwP0FctoCqICJ1KzAmXw9B0xw/mjDzguWidTLiAzJfQwjLsGC4TAed7cvVaWbL4B8edssRyFqxaKf6L4u+rx2Zu7dv3pYp+0el9hsvxTeXIiJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPdcnHQZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743499620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rv7jpfmifiJSCwlwKmjavmbnONcngGxU5yqNRTT6nzM=;
	b=FPdcnHQZRqE5cXwfx+HpFRSwvzuhFLMYR6SJO/+FQ4ZUyOcPZpcVDaGtrAVIFfKgUDUDZQ
	2pl4rkigLa5JbJ6tbtLwZXCr4nwRxOxu44wY34N5P4bxiAkZoXaK//XSPmO0flYQNJ5sMp
	WRl9vbKzkGMVq7jvDovvub4WB5yHmOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74--6dXuXEnPiq6_EkXdfhtmg-1; Tue, 01 Apr 2025 05:26:59 -0400
X-MC-Unique: -6dXuXEnPiq6_EkXdfhtmg-1
X-Mimecast-MFC-AGG-ID: -6dXuXEnPiq6_EkXdfhtmg_1743499618
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so38818385e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 02:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499618; x=1744104418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rv7jpfmifiJSCwlwKmjavmbnONcngGxU5yqNRTT6nzM=;
        b=U28elXHTAMzHGnXwACNDnILOy/97V1T2Hr+4XnA0mqz3emYT0otzsAEMfoDLvdAUH0
         tjgu9cQlGTKi9EPBLiXbMGyoEBamJW+SCgN9U8ug16r7GWeZ8CqyPbruPErgPaDCmAR7
         GGOt03ltKOxDSnSMTqQvDy6pacnetxosZF07ZOynqia48uyCq7wYSydOdCuQL+i9ShLt
         yvglgD0PW/kxFESVlGGv6tMqNM+wNmYNCNB70mThBMM84IoF/kfgVgnAmKMDolTjEFSK
         5dfUkacsP8Fil0xu69hJgluXa2ghMwHzgXkkmGxqx0ZneVTMzlrcyFgc//Z8srgjfNCV
         +Jmg==
X-Forwarded-Encrypted: i=1; AJvYcCXGHv+t6YHbopUgh8fig4ctcFyuM0A5ElFcl+GJpCjFugRZTJQAtCCko4JeRp+yQzgVPP8hU5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkVIX0iBhizrIpqcCzTmXLYNJKJorxRR1XMGmzwQ3gixpZxzg
	ykTZsKUIE+stNJVtTs8kB0sRdc6YoOQpa+JhcatoKi/C8g3QvfAuESoVlHQtVC2qPnBQSKd/e9A
	O4MBjg7wwtFqCY0vuHEsr5FpgRAPrajinDj79RijGEa2r7dDpEi1Mkg==
X-Gm-Gg: ASbGncvCBKd036fu3qYLj48bRFtICNYNZLSXwQ4uRwA0nmtxW+Q+yntnbpi3PTWdtrB
	K+nYCSMbdH+fvnEZ/qsIdxYhABKG3N4KNrfOm4W5GsBCtURBOb0V5A7RiOa6NNw1HZ6ywYTCNd0
	AGg+JNatvqidqlmW9netHDagm8Wml2v7SMCthYtAeUTBTRXHBy8yXiHvt9wpJg8fNuWo1ybJXE1
	eZ/GmOQzIs+aihUOE7VrB6qb4VjaK8C2FjPtV6O1qjpUFfL+8uVKYl23/chYBBjZra6ybZvm+Is
	G7Bbt4MOv29Df4P7xLRUNvp+4xeT1KisyQi0oIw6LFKHPQ==
X-Received: by 2002:a05:600c:3d8e:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43db6228293mr125405355e9.10.1743499617774;
        Tue, 01 Apr 2025 02:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK/gJwnwUGeCgqE+r9MWZUBTdjxnbDuFOZNWFHvltqYEKrV2WwlMUD+8wRfy3qo0w27wcgfQ==
X-Received: by 2002:a05:600c:3d8e:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43db6228293mr125405005e9.10.1743499617238;
        Tue, 01 Apr 2025 02:26:57 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b663860sm13774077f8f.39.2025.04.01.02.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 02:26:56 -0700 (PDT)
Message-ID: <5f493420-d7ff-43ab-827f-30e66b7df2c9@redhat.com>
Date: Tue, 1 Apr 2025 11:26:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net_sched: sch_sfq: use a temporary work area for
 validating configuration
To: Cong Wang <xiyou.wangcong@gmail.com>, Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org
References: <20250328201634.3876474-1-tavip@google.com>
 <20250328201634.3876474-2-tavip@google.com>
 <Z+nYlgveEBukySzX@pop-os.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z+nYlgveEBukySzX@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 1:49 AM, Cong Wang wrote:
> On Fri, Mar 28, 2025 at 01:16:32PM -0700, Octavian Purdila wrote:
>> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
>> index 65d5b59da583..027a3fde2139 100644
>> --- a/net/sched/sch_sfq.c
>> +++ b/net/sched/sch_sfq.c
>> @@ -631,6 +631,18 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
>>  	struct red_parms *p = NULL;
>>  	struct sk_buff *to_free = NULL;
>>  	struct sk_buff *tail = NULL;
>> +	/* work area for validating changes before committing them */
>> +	struct {
>> +		int limit;
>> +		unsigned int divisor;
>> +		unsigned int maxflows;
>> +		int perturb_period;
>> +		unsigned int quantum;
>> +		u8 headdrop;
>> +		u8 maxdepth;
>> +		u8 flags;
>> +	} tmp;
> 
> Thanks for your patch. It reminds me again about the lacking of complete
> RCU support in TC. ;-)
> 
> Instead of using a temporary struct, how about introducing a new one
> called struct sfq_sched_opt and putting it inside struct sfq_sched_data?
> It looks more elegant to me.

I agree with that. It should also make the code more compact. @Octavian,
please update the patch as per Cong's suggestion.

Thanks,

Paolo


