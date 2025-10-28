Return-Path: <netdev+bounces-233558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A81C1562F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 785A73528F9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5A33EAEB;
	Tue, 28 Oct 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkTT+cT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0E2741A0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664785; cv=none; b=J1GRxTPPEpAgv0htknCsYzzSjj2mu2Q2XCz22JAJjKYPYbAweDBLqGLViWf08Jszg6ODOXInW/YFazlITysub00sYL3dLcs+SpeuI2zcJ0hy9Th4+zKqhLufaXUXFNBziR/q6OGsJsHnH4kRuYL70Ij7su0qCxlougPvy2qclq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664785; c=relaxed/simple;
	bh=BjbzetwQv6Bsilu89J5EpXRhOw8Ysn7y7vFao6Ssjy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffTPrGKqgbsG2g+D/MvKOd1r/7m/Jepz/s+/7pfjlVGxHbIhT1ib1m6T1DPls4kByYj9Oa2Dq0Ej0OZJM+zyy8bHLovSkHAhLuVEzG2T74+dPrUAjt6fFnmmcD6mbFSUhmxeZiyrg8gsYuyjDVmBpJ8gZvq6xDc2g8YWpd/BpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkTT+cT5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711b95226dso76988775e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761664782; x=1762269582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BioniqG27FeE1CBYn4tPxLiuT1Y01dzhZXQilAmS4sI=;
        b=UkTT+cT5gtxms1WsgTuhokxlwr0zBer/lJmuxCmnzz9UVClWmjqXOKH+26QxuT3+qv
         h+qp0kmh1VTFTWAf88YH5nLuhQHcs6U9SH/QhO2oN5N+DLo/hLCJF0a+Wde6kzJp/VLE
         rOSmK1jA7IPjqadtJNmvT20v4eNZ5LJ8OZPGWZK4s4g0e5zcYX9V5d45jS/lX1l4TXyu
         gGlw0wZ9s8KuajdgecH113ObPFmXMztnesON/I2OBJZP4wVMFoYDQ0GTQ6K2N67gCbi4
         8u51+sEhPJtPp2uQqH1D34s2/UoQKdum4Bcc0tNOlbY9x0TzML31Iv5WoCxcBf08UJSv
         k6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664782; x=1762269582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BioniqG27FeE1CBYn4tPxLiuT1Y01dzhZXQilAmS4sI=;
        b=bBejcjWo2JsoF7hP4ITl3PKC2rkGwx32PCfhI6oYR81eyl8Y/km8+HQt9tJMDKaNhP
         Hy/SgauTM++ybBu6vuaMoVXjosfNEP/FRRPLK9G1Mq+wHuln+0mZmsa69xSF8ui3Z34J
         QVUc3/wGzTI3ercT71WqzXOE0QI+NK00yxwNT+mflkISptrSLVexiFmWqljbDXMxcFPo
         X88EzsJuFQNIuynuNhcJUPudcz4DokGA6roeKpvoOaanvxHyf9DruT9vm8fR0Zxw3zXg
         gIkxObi60U8v+i1XI+EQeO6RzOjj0mLcdJVTuIe2O+RMjNYPPISTuRY/p4niphxYjbd3
         X6ig==
X-Forwarded-Encrypted: i=1; AJvYcCUHrxpCIgY/aN3xhQZn8hrb+oVcA2cuR4yNuEVCjab/CRUnpT8wPYT6T34xaIsZl/zlSU5LoIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWvSttsfWR8k+UQnRheeHfgptCN36OXSaOHYw4OT18qufzF8Z
	2VrQTz36wG7XqdHW3+1K79O60HFnewj8OalPD1trw7cFHOzKBqa99OATgiVcig==
X-Gm-Gg: ASbGnctlakkhI1Zms/jfUVol1VNVpvTNJqOzBFBtpSFB366n4LxpPki+wsWAAqu4JsS
	cem3wbqSr6KR3a16RDCyJQ+gzbPPTeaBQrzZ7zCCFRn8jd1Udo9VOeCrqKTzGLzs5Wl4cMUlNDB
	XJ4s0tDQh7N1IDZJqG93whzaqWW20/g7D04Q5SikSKKX9QOBX/efQrQmD/3xsCH24KSoFry5o7Q
	Utb1MX8IpNINBLXnG19NYSG+SkbIjqdieVdWyBh/ZhtyiI/dUcHlNi4n7JAHqno45SXSDT2p6Ee
	295VJcVgjweMrWNQTCN8mxEYp3VSshDCQtqvkvE4SR6F2UoFDIMuDQXh5T7+w9Gq/Jo2yMTAR6f
	/+DpFFUuZQd0LoYbNwZWCJwLPbQycIVg3NJy+m5EH/wvjIrZctPX2AsLG55/9xlh/D33feaWdPz
	XpzoBpvizo2xDrbkM3dbGwLqThxd0NNCHmWdOxygYdlVCSHJCPqfg=
X-Google-Smtp-Source: AGHT+IGYRyw4Duw/YLIGUsBx6zkDmCTv/uBD5BMN2eCudueFMvGTUNv+wFlSzZU8uJW0IDaVSzTanw==
X-Received: by 2002:a05:6000:3107:b0:427:690:1d84 with SMTP id ffacd0b85a97d-429a7e7c43cmr3158305f8f.32.1761664781689;
        Tue, 28 Oct 2025 08:19:41 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7d1sm21214094f8f.16.2025.10.28.08.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 08:19:40 -0700 (PDT)
Message-ID: <64101298-06d3-4db6-9156-42343dcbdfff@gmail.com>
Date: Tue, 28 Oct 2025 15:19:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] io_uring/rsrc: rename and export
 io_lock_two_rings()
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
 <20251026173434.3669748-2-dw@davidwei.uk>
 <c3a45eaa-0936-41a7-92cd-3332fd621f6a@gmail.com>
 <74cac804-27b5-4d25-9055-5e4b85be20d6@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <74cac804-27b5-4d25-9055-5e4b85be20d6@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 14:54, David Wei wrote:
> On 2025-10-27 03:04, Pavel Begunkov wrote:
>> On 10/26/25 17:34, David Wei wrote:
>>> Rename lock_two_rings() to io_lock_two_rings() and export. This will be
>>> used when sharing a src ifq owned by one ring with another ring. During
>>> this process both rings need to be locked in a deterministic order,
>>> similar to the current user io_clone_buffers().
>>
>> unlock();
>> double_lock();
>>
>> It's quite a bad pattern just like any temporary unlocks in the
>> registration path, it gives a lot of space for exploitation.
>>
>> Ideally, it'd be
>>
>> lock(ctx1);
>> zcrx = grab_zcrx(ctx1, id); // with some refcounting inside
>> unlock(ctx1);
>>
>> lock(ctx2);
>> install(ctx2, zcrx);
>> unlock(ctx2);
> 
> Thanks, I've refactored this to lock rings in sequence instead of both
> rings.
> 
>>
>> And as discussed, we need to think about turning it into a temp
>> file, bc of sync, and it's also hard to send an io_uring fd.
>> Though, that'd need moving bits around to avoid refcounting
>> cycles.
>>
> 
> My next version of this adds a refcount to ifq and decouple its lifetime
> from ring ctx as a first step. Could we defer turning ifq into a file as
> a follow up?

The mentioned sync problems is about using a ring bound to another
task. Decoupling of the zcrx object from io_uring instance should
do here as well. Please send out the next version since it sounds
you already have it prepared and we'll take it from there.

-- 
Pavel Begunkov


