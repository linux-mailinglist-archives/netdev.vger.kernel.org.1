Return-Path: <netdev+bounces-185585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39B7A9B009
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A43A466E7C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD4B143895;
	Thu, 24 Apr 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdfzO5Bj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA9130E58
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503349; cv=none; b=tt2N8ZaLCFBmJ0EqsM2RaCtxsbHk3Hr625VpLKJdMzVWJJvatde1Cs09gOFAhXfV/sxES/KjTw83hjH5RKu1ghfw13etr7Ksxndm3D1RKo6b5MeGVOLw+jrf/fPD16MJ0a5F1R4j5uaJnMeNs3tjptnQyFJNPGBFbVFZgR1cvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503349; c=relaxed/simple;
	bh=zwdZgqdDKmE3Viq+cnCSXsknPD78NVVb7eQv3Kk0QXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjPcBHEBurWVB+hB3spOF3wT8cT9tcmcKaNtCvtMGdFpsD80jKJKCXQ1PlJF3XonCyilr6kELZvi+WsZZmYF+k+uU5zXluNsSOGeMcEc2kUex11/fH0DXVAkRq9LI6BUmbRz5cN95k6+DeN7kQRcl2mvgUMphhK4kZ45E1gAhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdfzO5Bj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745503345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Aaw3Dx4UhHqcEGsD63cd3h5ILZfjEGKNvg/X0u8iQ8=;
	b=KdfzO5BjhPgy7oPBiU08Q2jdnbg50rmbOeTL3j320bTzTI7rBLTE8h3itsHHYTUsPzy0vI
	KaGRMLY5Zx+0gIGXPVBL8Q1EtsPWNmazDQdaISh36UlaU7JdqXLE3DwaVLHxgAAMf40oKW
	xqq3sYoOINVPF9Eez33lC29Cx0HobSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-FlM72np9Mlq7ay3Hck5koA-1; Thu, 24 Apr 2025 10:02:24 -0400
X-MC-Unique: FlM72np9Mlq7ay3Hck5koA-1
X-Mimecast-MFC-AGG-ID: FlM72np9Mlq7ay3Hck5koA_1745503343
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eed325461so5096755e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 07:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503343; x=1746108143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Aaw3Dx4UhHqcEGsD63cd3h5ILZfjEGKNvg/X0u8iQ8=;
        b=tHvDhH1AXecoAxkPqBbkB9KoVs5/TamrXI5s/RaZfsXOUN08/d15kJaW3pjrFjtKBR
         +8Sg0EgX4z2R9snYaHdiC0EqxWW0YLqYhjgERUXvJtgSerY0yQDmhQo8xODAsEgGr07P
         B61/ce47aKDtiSU9nvFCb6jkAu8hWiYWKetoIkmagKBJ8lhXXXHIWzdH2ok1MWrGpql4
         +mpqiTVqDpJiXhFjm6mnd19T71+Rd20x851t1vp5thoh8aV19LwIaJ8Uqj/LNhGhntdm
         eGtzYtgXeeJAPou0lmrBRO3pIL4c7mjFB+IKnMv9KATpIZU5lNXS/x732WTy9WbWVifn
         syeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTLRKLjZ3QIiv+5esn0yCIFKCTkFvxuFQy95hckDJdxxtu9QgorZ2nvVOGHpgNSgznIoS8KjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6z3gfw7M4mc27TxdencNNNCnYfjglWCoEr9qU/pmQVJvxtLiW
	wMZRkSWNyWnoMj1iX6W/j8+xWIsl+mcajTIJesxfuufS8wNumx9ZZAXJuqTG5HJLOrOrzxEYu7e
	8weijXOlCv0zymr/ESF1voKSuKEKGrNEQBqEbfoEfMFOvAhjadtnF+A==
X-Gm-Gg: ASbGncteESbg6rkvNBq3IHnyPGozQajM45pCvB/s5n6BcHG61WDorJj7OyPSbebQsPu
	6Hua0GqGcybhMqmaNUpsXgv+erse/PWI0nitZHeSsKH6d1wDPXN5Uj5+7Bk4tyAytubwgJIm1v3
	cWZoVAAN20nrj6GmUfb68Kmn2oMu82QSK3K60Qt17ih9m616F0Jxrq9N/bANi2WyX/Lq9OMoKj3
	9Upy8cNJswqgqCv3qBGKpqDGmAf/164yd5yiBWnt1aXiTpgGN44cb0Xsy9zKjij3Lf/N7qJwzwL
	WD3ExxzSfs/GlEaXy00ND1azMot9/9Ev8qlbz9IYVTRa
X-Received: by 2002:a05:6000:401f:b0:392:c64:9aef with SMTP id ffacd0b85a97d-3a06cf5c4cemr2510560f8f.20.1745503342829;
        Thu, 24 Apr 2025 07:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMmdHuRh26hxX1NOR2DOUw8CVhfW7e812bb/UgYtY/gXRNn/UEXH5+zfXwRwtCYWQHMcC6TA==
X-Received: by 2002:a05:6000:401f:b0:392:c64:9aef with SMTP id ffacd0b85a97d-3a06cf5c4cemr2510337f8f.20.1745503340675;
        Thu, 24 Apr 2025 07:02:20 -0700 (PDT)
Received: from [172.16.17.99] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a36c4sm22153595e9.13.2025.04.24.07.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 07:02:20 -0700 (PDT)
Message-ID: <a28ff624-c73a-4e16-867a-66e423315c29@redhat.com>
Date: Thu, 24 Apr 2025 16:02:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.04.25 09:44, Vincent Mailhol wrote:
> On Tue. 22 Apr. 2025 at 21:03, Felix Maurer <fmaurer@redhat.com> wrote:
[...]
>> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
>> index 7fe11e020a1c..8d43053824d2 100644
>> --- a/tools/testing/selftests/net/can/test_raw_filter.c
>> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
>> @@ -101,94 +101,113 @@ FIXTURE_VARIANT(can_filters) {
>>         int exp_num_rx;
>>         int exp_rxbits;
>>  };
>> +#define T_EFF (CAN_EFF_FLAG >> 28)
>> +#define T_RTR (CAN_RTR_FLAG >> 28)
> 
> I do not like this
> 
>   >> 28
> 
> shift. I understand that it is part of the original design, but for
> me, this is just obfuscation.
> 
> Why just not using CAN_EFF_FLAG and CAN_RTR_FLAG as-is for the
> expected values? What benefit does this shift add?

I agree, that looks like magic numbers and the original design is not
very nice here. The main reason for the >>28 is that later on values are
shifted by T_EFF and/or T_RTR, so they shouldn't be too large (with the
>>28, the shift value later is in the range 0-14). See below for a
slightly different idea.

>> +/* Ignore EFF flag in filter ID if not covered by filter mask */
>>  FIXTURE_VARIANT_ADD(can_filters, base_eff) {
>>         .testcase = 2,
>>         .id = ID | CAN_EFF_FLAG,
>>         .mask = CAN_SFF_MASK,
>>         .exp_num_rx = 4,
>> -       .exp_rxbits = 4369,
>> +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
>                          ^
> What is the meaning of this 1?

The 1 means that a packet will be received with no flags set.

The whole rxbit thing took me a while to understand and the result now
is not straightforward either. Let's see if we can come up with
something better.

The exp_rxbits is basically a bitfield that describes which flags should
be set on the received frames. Maybe this could be made more explicit
with something like this:

.exp_rxbits = FRAME_NOFLAGS | FRAME_EFF | FRAME_RTR | FRAME_EFFRTR,

And in the receive loop something like this:

rxbits |= FRAME_RCVD(frame.can_id);

Of course, the definitions of these macros would still have the >>28,
but at a central point, with better explanation. Do you think that's
more understandable? Or do you have a different idea?

Thanks,
   Felix


