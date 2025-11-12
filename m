Return-Path: <netdev+bounces-237936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1CDC51C2B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3513A6448
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDF029BD9B;
	Wed, 12 Nov 2025 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvFc7Ss/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT4iLg4j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CE29BD82
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943927; cv=none; b=NSWDTILONZT/I9gIUiEfntvPt3LwwdblITfO2UGmJosAkrNdy+NENlegrkuXxZpP+ufdWhzvAo9NYmEPPxDS28w4l7tFaygLpMmpgW2gWgZAsPVQTaG1zqkpr0PuOmoJMiCFZphzijuggsoNNit4yQz1WaEIK2fLwH1IamqhmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943927; c=relaxed/simple;
	bh=3UgjvU3UA+2bDaXAMaiYbwqYDEnxBe0zRFdWoB7//xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmMwsenmDp5+Na6/vlbRimh0KzL6FSLta+znPwGRoASQklQoyY94qL5eCAJLE/ZQovz8TVeNzuX7kTAEHDqWzhO33Bjf9159arnckE+K4BFc+rRHwIFeK3PLRW+PZ3j9TinLoARIKHsExevrwt8nJd5RR3NCnG3tmZmnpfhhBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvFc7Ss/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eT4iLg4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762943925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z9SdVWZWRjtRiWR9M8+O0YgmamDXnzXPQ1vlD1AV2o=;
	b=KvFc7Ss/H3aDqnv4C9Qv7iaOrSYaZy69qW1ejUSus3GJsyKuXBF7BqkaxLkqSeHxidw1wT
	w11JT/eQyIT1DSM9VomUksDnthofOpF/SOBWYdMfRvt5Su0S8UvAcrRghoJlqvIoQ69GLY
	Z8h3Fnv3+PJXw1FV/ufDokKcuJLpYJ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-PKQ0NQdIOQ-Xk7uYcEzhBA-1; Wed, 12 Nov 2025 05:38:43 -0500
X-MC-Unique: PKQ0NQdIOQ-Xk7uYcEzhBA-1
X-Mimecast-MFC-AGG-ID: PKQ0NQdIOQ-Xk7uYcEzhBA_1762943923
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47754c0796cso5195265e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762943922; x=1763548722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0z9SdVWZWRjtRiWR9M8+O0YgmamDXnzXPQ1vlD1AV2o=;
        b=eT4iLg4je9TRE3C4h+irUF2sF9CG0YQ6BGWupLzEXJjV8oOLRUV8veawRl1UmbrEvV
         QNz74XvFV+P7QHzjyikBUrMxfJVqCOGkzZ4PDz2CGoZm1wRyQrAStLbEsH7QERZRqgKL
         lxVGLkW0p0hp/YmqxuP5gMk39W8CWSkxQZiHlwU2Mm4uVIOKjuEvbQ+3r/KQsAZRMLo1
         P+7IsRxqblaau6HlV/iHALFi4HBfwZuM1CRb0i2LwbnT34dKOhnE2OMRG51zAYFFY/Pw
         z6HPdKMwWZnWHzzmEoLOuEo2qSCHUCNgZuek61KLtfjOhGw1gDakOLtdckbCj7umOgo9
         zYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943922; x=1763548722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z9SdVWZWRjtRiWR9M8+O0YgmamDXnzXPQ1vlD1AV2o=;
        b=Kb5imoVnyZsX3hSvSZmt2QsiPQWH+z0kUtFYoqCfoRGD7kBzLc5ji8oFZcdBc2iDGB
         V9JA4LfSdd4aWU2S35uV2vY6sfN9rvRQh6wEoGcOvnKZE4X2ur8bQLDxDMQGXhlL6Vov
         ON/i3zGSYoG9DElDEP2/PE0kEVL/exSfWfGbDzKJpAN+cnAcUdS4iEa1RKzxOoOZAYV2
         xN2LKjh1aqWKQIq4fps8uAMMEbGmZLED7K9whwJhighcSz1V1bHpNEwkTRmVRLMCvArN
         2dLzbCNHCnFOlahMvRq+4Vr+kZtM1EfVwevYyHtnmXjQZT0iMmhKIo0xQh98r/MR9bjX
         ZYtw==
X-Gm-Message-State: AOJu0YxXl+yXbw4Ns9lt/fgSmG11PCXm4G+Ca9Xrc1LdCm/7o2gxv4nX
	T2e8mpHJjmSXdwcOa98rNbZtlFwPKQ7TeAhMexnPAO2u/Jsu0ZLKeYWry9jxyQxgaX/PETcVMIB
	R/nXcQ2s4bvloWNztz66AX/8ANQ5cluhXjqjTBID2YFsge5TguFpF+wUAGg==
X-Gm-Gg: ASbGnctJ8pE+2rCiGHHmxabtpgKQtS/t962XcyaZ29sXoQih2XXMtQWZ+C4EhNdtZYy
	/7dPptbjLVK9MHdXDgw1+p+/PmyWc0eeHfdPbOKMWFGD/w36+CjoAcvO/Yp92Jw7HDJ5VbmKgjc
	jNyF4Y5oZJXDub44blqpcKK9xZ1BkwCt5D2GxTJJgwsShDdcicYJXHNZ1xL09V8r9jDtp8B7JOm
	6si3X3/tsF9DKaEFVqFLrJ7qX4/6Q0mDKHeZxu6UFMLUbOcF6Z7NSSPKZkxPW5ayreIcyI9VvDE
	UXMS2T88WYW2cI7p/6Qz8IPQm8/ijAXIMuhBcbqi6sqj5zNJvC1zGiOaqOVF9RErXhsPrTRdYrJ
	QjVQgwQW1lrF3MFHq2hI6MthtMyQB8ESLdIQ3RfShj60r/K4JLPh7Vfyli34EgD9Kml7183HPsF
	MJeye0T83AYgcu9BbnoQSheR5qyNZv
X-Received: by 2002:a05:600c:3145:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-477870718b7mr21848945e9.7.1762943922520;
        Wed, 12 Nov 2025 02:38:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxMFTecpazD3F3NJEcM1Uo0iaB4jWJHVUmBQgi4Na0O+B5GvqUYDal0Yh8ck+1rnrxK+aSpQ==
X-Received: by 2002:a05:600c:3145:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-477870718b7mr21848705e9.7.1762943922082;
        Wed, 12 Nov 2025 02:38:42 -0800 (PST)
Received: from ?IPV6:2003:cc:9f0f:f0f1:37d7:b7e5:eda1:1fa0? (p200300cc9f0ff0f137d7b7e5eda11fa0.dip0.t-ipconnect.de. [2003:cc:9f0f:f0f1:37d7:b7e5:eda1:1fa0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787daab3fsm32741345e9.0.2025.11.12.02.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:38:41 -0800 (PST)
Message-ID: <886abd74-9589-44af-a6f6-4bdeefffa54f@redhat.com>
Date: Wed, 12 Nov 2025 11:38:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] hsr: Send correct HSRv0 supervision frames
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com,
 m-karicheri2@ti.com, arvid.brodin@alten.se
References: <cover.1762876095.git.fmaurer@redhat.com>
 <20251112100319.YFgqZLH9@linutronix.de>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <20251112100319.YFgqZLH9@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.11.25 11:03, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 17:29:31 [+0100], Felix Maurer wrote:
>> The selftests can still fail because they take a while and run into the
>> timeout. I did not include a change of the timeout because I have more
>> improvements to the selftests mostly ready that change the test duration
>> but are net-next material.
> 
> I added a -W10 to ping and it passes while -W5 fails. I can't remember
> that this happen before but whatever. Sure, fix the testsuite via -next
> if you have more things in order to improve it.

I was referring to the timeout for the net/hsr tests in
tools/testing/selftests/net/hsr/settings, set to 50 seconds at the
moment. I didn't observe that -W10 is needed but I'll take a look at it.

Thanks,
   Felix


