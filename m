Return-Path: <netdev+bounces-217197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7D4B37B62
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57377AC1CD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70F2C15AF;
	Wed, 27 Aug 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htpDpUq7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB31EA7CF
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279286; cv=none; b=hURaCND4HxhlwX+zctwm9fuDo0dZEh7NIfwoxDqXnNeYTGo8JM0xXTA4Xn2MYfA7BDkPtTfJ/atORksAEwFnR/F595g1VlxHRJs3x5yQVEwlcMpe669DenRx4891Z0vL5PSgmldKNG0/3i54PTKvi5S9eNXvWbJkAbjMTofR2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279286; c=relaxed/simple;
	bh=kI+3LthwjG22y7VcirsJ4BmcsSRBi1+iY3WJee8vZsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n27C+oRqxyDWUXkwsafJaXq9Fy+POTNbbTDGo++GUpA2H5Vw+o3Gw2Tk4A0s5rOUbRgNWR9Vb9Fmmi7N5hhC2p/oHYs8l23Sq80ZVq7jjnW/ncmgTLRUBDc6+L/2eTczVQnTMsWIIn5kekSz2KYe4aNW2F+cAfL9U0A6s8L0qaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htpDpUq7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756279283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JGC+85HqbaPLKuXMq3g087QMtLlIBsZdKv3F1ohVrk=;
	b=htpDpUq7+A4NqwJkL05w/CIFJ3PugcPhTorXP138za0JZ4cfJwIukt4W7QTsTqvRDhzz4T
	0YzLFlZ01EXoZ4iX+eZ0HyysbFiDlJWQnU8jDteHV4Ou0ZqQ1p6FN9BZ8B5JF/h9L5CL6b
	ielSnCCdkTdMfGlnm+O8CxRaTuIxIyM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-tnmme-oCOdKeXlEzoS5D7A-1; Wed, 27 Aug 2025 03:21:21 -0400
X-MC-Unique: tnmme-oCOdKeXlEzoS5D7A-1
X-Mimecast-MFC-AGG-ID: tnmme-oCOdKeXlEzoS5D7A_1756279281
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c85ac51732so959988f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 00:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756279281; x=1756884081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JGC+85HqbaPLKuXMq3g087QMtLlIBsZdKv3F1ohVrk=;
        b=hGLWJJx65UCzOQ9M3hlXWtthM1Qf2TBbefpXKyvPn9865fYlC9VpakVZjVYY+Pcf9p
         uusytUsJVCobm6rN2+Glfm99wVoTCDgl1vzK/EC1/z9wyCIFR60C7vGUw3Ra+H+SaDoe
         Zb32+90fLr218v6ZmD73zrriAwNh4SRRDShnFWI/JmVQuRKanXmxXSRdkdDfs5wfmaB6
         29iPwoQazD6LkGnU2iGM440wvX3Y9ZU7ztgo1dCQmDh6bHNxUdDAMVVY5ZmRT51SFTyl
         0SDOCJI6dEVbS/X1mQAaPVypcGXu138eudKw8JoRHOr0AVCj8iHxlO24a0s0qzrhqfpP
         SSsA==
X-Gm-Message-State: AOJu0Yz0feGZIcQEijrJWwXMg4Y0zUIwHdHpn9wh/j/Sp5iWGhAnRgV+
	hPRyX6TRiiCfxVsJ/QgNU+kv8UcauwO2x47iCQD+x+5832vWqo3QFy55t7QQTd6NPUQMbsnXEvU
	nCx+g6fcUATo7ooKFc/q9W0Xws4jjVBXA1K7RQunkwW5u03T5ItjQngigGw==
X-Gm-Gg: ASbGncuVk9r4GLia+Bqc+5yqkyASEviKs+9NZ/8srzlWUJcgEStBFlrtr8cugf5cxXi
	F2WSOiiDybXu3Bwg2GIOdfxglbZHNb8aVsvCoPDmAag6jZIeC01vmYSZmyk3DJWgp5NWOSypXp3
	8bMR41fahZhStiAkA4Jc0HA7fP2stIJ/Blg8sQYlC0gpAfccwilMBpGZ2vg0USpzpAaFAWkzVEN
	JkEIBmiXCjH0XufbdskHTxA/cLk+W16V4C/Vho0hTzngrfOkkr3M+wKV3Y61QksGCCoBviwoqMh
	cYLSla4rnNBxx4PkcTIFn+iv2ZzwGJrocV9IKCikyxgovB7IRaAJfB9+Qk1zXmIOIk9o/KrEG9T
	tWHHxc7N5rlM=
X-Received: by 2002:a5d:588e:0:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3c5dd8a9fa2mr13685356f8f.37.1756279280683;
        Wed, 27 Aug 2025 00:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFzc1iRnfdv7Uz78ukwWUS52/akIOKNurW4UrrjZQJ6s/znsbudcOgNbIUMuo1lIv4bKS1Rw==
X-Received: by 2002:a5d:588e:0:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3c5dd8a9fa2mr13685338f8f.37.1756279280212;
        Wed, 27 Aug 2025 00:21:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba078sm21180994f8f.4.2025.08.27.00.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 00:21:19 -0700 (PDT)
Message-ID: <6d99c24c-a327-471b-964f-cfe02aef7ce2@redhat.com>
Date: Wed, 27 Aug 2025 09:21:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com>
 <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/25 1:10 AM, John Ousterhout wrote:
> On Tue, Aug 26, 2025 at 2:06 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 8/18/25 10:55 PM, John Ousterhout wrote:
>>> +/**
>>> + * struct homa_net - Contains Homa information that is specific to a
>>> + * particular network namespace.
>>> + */
>>> +struct homa_net {
>>> +     /** @net: Network namespace corresponding to this structure. */
>>> +     struct net *net;
>>> +
>>> +     /** @homa: Global Homa information. */
>>> +     struct homa *homa;
>>
>> It's not clear why the above 2 fields are needed. You could access
>> directly the global struct homa instance, and 'struct net' is usually
>> available when struct home_net is avail.
> 
> I have eliminated net but would like to retain homa. I have tried very
> hard to avoid global variables in Homa, both for general pedagogical
> reasons and because it simplifies unit testing. Right now there is no
> need for a global homa except a couple of places in homa_plumbing.c,
> and I'd like to maintain that encapsulation.

Note that there is no kernel convention against global per protocol
variables, when that does not prevent scaling.

> 
>>> +/**
>>> + * homa_clock() - Return a fine-grain clock value that is monotonic and
>>> + * consistent across cores.
>>> + * Return: see above.
>>> + */
>>> +static inline u64 homa_clock(void)
>>> +{
>>> +     /* As of May 2025 there does not appear to be a portable API that
>>> +      * meets Homa's needs:
>>> +      * - The Intel X86 TSC works well but is not portable.
>>> +      * - sched_clock() does not guarantee monotonicity or consistency.
>>> +      * - ktime_get_mono_fast_ns and ktime_get_raw_fast_ns are very slow
>>> +      *   (27 ns to read, vs 8 ns for TSC)
>>> +      * Thus we use a hybrid approach that uses TSC (via get_cycles) where
>>> +      * available (which should be just about everywhere Homa runs).
>>> +      */
>>> +#ifdef CONFIG_X86_TSC
>>> +     return get_cycles();
>>> +#else
>>> +     return ktime_get_mono_fast_ns();
>>> +#endif /* CONFIG_X86_TSC */
>>> +}
>>
>> ktime_get*() variant are fast enough to allow e.g. pktgen deals with
>> millions of packets x seconds. Both tsc() and ktime_get_mono_fast_ns()
>> suffer of various inconsistencies which will cause the most unexpected
>> issues in the most dangerous situation. I strongly advice against this
>> early optimization.
> 
> Which ktime_get variant do you recommend instead of ktime_get_mono_fast_ns?
> 
> I feel pretty strongly about retaining the use of TSC on Intel
> platforms. As I have said before, Homa is attempting to operate in a
> much more aggressive latency domain than Linux is used to, and
> nanoseconds matter. I have been using TSC on Intel and AMD platforms
> for more than 15 years and I have never had any problems. Is there a
> specific inconsistency you know of that will cause "unexpected issues
> in the most dangerous situations"? 

The TSC raw value depends on the current CPU. According to the relevant
documentation ktime_get_mono_fast_ns() is allowed to jump under certain
conditions: with either of them you can get sudden/unexpected tick
increases.

> If not, I would prefer to retain
> the use of TSC until someone can identify a real problem. Note that
> the choice of clock is now well encapsulated, so if a change should
> become necessary it will be very easy to make.

AFAICS, in the current revision there are several points that could
cause much greater latency - i.e. the long loops under BH lock with no
reschedule. I'm surprised they don't show as ms-latency bottle-necks
under stress test.

I suggest removing such issues before doing micro optimization that at
very least use APIs that are explicitly discouraged.

/P


