Return-Path: <netdev+bounces-241788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3235C883C8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A93D74E433F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F741EC01B;
	Wed, 26 Nov 2025 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chepW5mW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pG8WQ0GE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFD2192EE
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137815; cv=none; b=SknmiMhma0tsdUpmZVsBLTBZ8p1+pYtvqw2uy3jBXX1CYBDxDvGIJYPeSXGNAOWIZH4ImD4ZPREiklB1GeRtADmcqn23lIPTYAaYN4CvQAwTmTnmiu5/K5CLQxfJ26J2SP6U0Izboe6N/gZUo+QEvf23Kgr91PrY94dkwto5aOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137815; c=relaxed/simple;
	bh=9eZFQ/q2ekN9iEIvDQdSQ38X/rI9wfSyOhAKw/Kv9D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEctBaTwx8IIJoAY24hLLuT1BohGjjV+ktxb9balU8ZDm2QjInJPXAWrwrLisqEXHx0/05yLBqRfjyCxr2K5RF7ty6fNzCdkBb4gHMB6L3ihYLN8GqQTmWqsdG80sJf6row1LenrmfV60Mq7rEqCddoRB/2jS+GyEZ1wz10C6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chepW5mW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pG8WQ0GE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3+pnApkvuyBTQ8Q+gd0V8CxAyLJyzgJMoX4H7LnP6Q=;
	b=chepW5mWSki+81b6YdHJS+u2GRjfwrF12KlsSqHXCnCL0L120oU2Jr9Mxp6ep872jHxdiL
	kGrMLPKzF+bSqmVQoRgK9tZFj2VsonlSo13BZ37SKR7SKBkSureY73Q+EgtYNtFLwuQbZ4
	1rQov14eYl33wfkesZO9fO+y7gp5YJs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-WZOHfW0UOLqddiYMaIiZXw-1; Wed, 26 Nov 2025 01:16:50 -0500
X-MC-Unique: WZOHfW0UOLqddiYMaIiZXw-1
X-Mimecast-MFC-AGG-ID: WZOHfW0UOLqddiYMaIiZXw_1764137810
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-641738a10c4so7391479a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764137809; x=1764742609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3+pnApkvuyBTQ8Q+gd0V8CxAyLJyzgJMoX4H7LnP6Q=;
        b=pG8WQ0GE1jW3XU+z9vw6vV+VbETeuBP/bpUG0CU8bYTuwywO9NqSvd9ci484K6F9q+
         VVYBbH0xlR/Dto+SVDkMOvfaV2Ql1yeR1hT6mBVp5RJwCwZCVf1avVLgfSPTtmuUe6O1
         t0pYkwtbv/RI3EZ4KHql2eGo6iF/D+DtAc4c6Z4Ys88ctiEMIL+VpP9y9v55hMXbel60
         Mdoiagi0H8d0a55ZmuurFWQ3+a1Swgomm8Ufe47hGz105pXQ5xYTCwClfPRt5gWRqQUY
         D1vNuIqsTI4/JuqNBvsF8yiWMVEqZ7esTGW3nzaaATtbG6aOf+Q2oqgvkFBOTwzuxY0g
         sj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137809; x=1764742609;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3+pnApkvuyBTQ8Q+gd0V8CxAyLJyzgJMoX4H7LnP6Q=;
        b=IHhg7ydvDf9SAhMSqzW7G1OLLBIl4T458y8vTBdEwRZtAB0bmRd90mRvFM7EMbk1aZ
         rdpu7kYJqsapTtckTRq6S525sreINT/PeIFfeljYGM5o+AdsWjutZDL3SGXORKo4zuW/
         I34kyiUt9EaKpYY5fdidRoEu0p1LOKq2zMV2XbgWf2e6yRBWoCcpuw3JAinw6lZkNnNx
         Lmcx0vxtAyGsUFdQD1pgS0xVKqgOujurYhgOvEM+HiUmifQaFq78QBzYNKvj12l4/BTi
         3V+JBMlcLyLlSTix7cwasrLDXOGUldV5zl5MF5XvhaWwshroRP/Rp8cuOtDdIbXhyk0S
         +yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVvYT5pWnp1ZcF8rz86iGWhihGdZjjtAK4staWtFdJRlGylZMFqFboiUOMr58JCHWnkIm8cn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2olRPg14X8mhJpVuKWAKzllpZc3Es6osCCxVMs1G9GtBuUa2A
	y2MZSjCv9c3+Lg3I1/bgou24rOihS2R72H0YbTTa+WUH77P1SVuttXMxpWl7N1QGtC6VbywX1Sh
	fIZyaFlSbJjV4ag+6WLSZQE8fyiFpL/QTMt2r2Yh6M2EKdzLQHIGqL3Ke
X-Gm-Gg: ASbGncvoifJ4gTE5jNUYkgOlDkE2fTgv+sJ8G95CRd7xaO0HFiD/X1rx41v5XeSfXvN
	SbX73VvWefVQ5G/NfeRApFcQr+d4Zm9ONOjkB+vHgNdu/DqfIO5SsIclwYtXxU/symyxWTn0VUz
	WoQZwY4galNNv3I25eyhZ57keb7Ug4U6c0imOhpwRqCzUH9GOf/7T11Ale0cFdaZSwR3dlPYV52
	oWAkqAXonkVa0reXrHMUjcLFbpUA7M00kHD/dz65TDC9mAYJGKTZqhTYVcDwA2Mgtpe9QEGcvBo
	6oF09z2c2/ar2ux/Y8QytZiNqv6eEGdSK5HcwftpwGKQFIZoWQXUV82UJxIjHEkjStBprGUySSQ
	1TZkpx18L5KF43O6xIfxqyoBP/ZnhkP4bTQRDXFLcmY8=
X-Received: by 2002:a05:6402:909:b0:641:24cc:26d7 with SMTP id 4fb4d7f45d1cf-645eb23d89emr5073802a12.14.1764137809594;
        Tue, 25 Nov 2025 22:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6sQiMKowZpXuXDvXhg7pCLn/B03mdbNUfdFSc/JPw5sFieDhc6SZi6GKr3IsucbbmQ6hX5A==
X-Received: by 2002:a05:6402:909:b0:641:24cc:26d7 with SMTP id 4fb4d7f45d1cf-645eb23d89emr5073780a12.14.1764137809168;
        Tue, 25 Nov 2025 22:16:49 -0800 (PST)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm17101222a12.20.2025.11.25.22.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 22:16:48 -0800 (PST)
Message-ID: <bd4ed630-b370-4dea-aa19-5c3797106dce@redhat.com>
Date: Wed, 26 Nov 2025 07:16:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-7-samitolvanen@google.com>
 <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
 <CABCJKudpUh7i9PTWV_k5ZWehkyRvHcRTwSOWQu_1yjCE9h_bTg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CABCJKudpUh7i9PTWV_k5ZWehkyRvHcRTwSOWQu_1yjCE9h_bTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/25 21:16, Sami Tolvanen wrote:
> Hi Viktor,
> 
> On Fri, Nov 21, 2025 at 8:06 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 7/28/25 22:26, Sami Tolvanen wrote:
>>> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
>>> indirect function calls use a function pointer type that matches the
>>> target function. I ran into the following type mismatch when running
>>> BPF self-tests:
>>>
>>>   CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
>>>     bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
>>>   Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
>>>   ...
>>>
>>> As bpf_crypto_ctx_release() is also used in BPF programs and using
>>> a void pointer as the argument would make the verifier unhappy, add
>>> a simple stub function with the correct type and register it as the
>>> destructor kfunc instead.
>>
>> Hi,
>>
>> this patchset got somehow forgotten and I'd like to revive it.
>>
>> We're hitting kernel oops when running the crypto cases from test_progs
>> (`./test_progs -t crypto`) on CPUs with IBT (Indirect Branch Tracking)
>> support. I managed to reproduce this on the latest bpf-next, see the
>> relevant part of dmesg at the end of this email.
>>
>> After applying this patch, the oops no longer happens.
>>
>> It looks like the series is stuck on a sparse warning reported by kernel
>> test robot, which seems like a false positive. Could we somehow resolve
>> it and proceed with reviewing and merging this?
> 
> I agree, it does look like a false positive.
> 
>> Since this resolves our issue, adding my tested-by:
>>
>> Tested-by: Viktor Malik <vmalik@redhat.com>
> 
> Thanks for testing! I can resend this series when I have a chance to
> put it back in the review queue. The CFI config option also changed
> from CONFIG_CFI_CLANG to just CONFIG_CFI since this was sent, so the
> commit message could use an update too.

That would be very useful, thanks Sami!

Viktor

> 
> Sami
> 


