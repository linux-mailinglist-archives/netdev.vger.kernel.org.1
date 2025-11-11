Return-Path: <netdev+bounces-237711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A73C4F419
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79959189A078
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51F36CE11;
	Tue, 11 Nov 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="iLsp+OB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945E369960
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882511; cv=none; b=MCpwBxEuxgsBwO2hMy3AwS4Da95sqiuU528yXD7TPzamzYjYKe7waVQolFksj7LQgexW/4XRXmSWNx6vhkU8ciR0+JsYXA7AXNgjowz+aT6DL8ESzc8wDg7pX9Im4XFxsbcq4KVVNXu598Ol6C2PcFv05Xv/gcRW7btQel09kY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882511; c=relaxed/simple;
	bh=EE+WvBsWH1KNgw2W8XtWypIxgQcREqPyb1uWJ2mPK4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fd9VZFQaf4QSvBabUIaa9nsz/l7/t7/HQABRLbrPAeXDRKs9DdxIKVDUqzETvciI67tD48OeMK3UdMiPgvuJvAA124k+1lYL0dkeXBMwl9LKLos7vjadlfaUX20xeKvzvmMOXo5/eGSqqNXxPQyD9js9efpyV9LK81FUFiXvr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=iLsp+OB0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so4897758b3a.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1762882509; x=1763487309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fn7wodOlLmLsT5jl+y7mwvvOyNWafbKyZT24/lhSKsU=;
        b=iLsp+OB028yaFvcgC1JvtYs5K3+FA7KMpMnCPeqJ8I4B5f7HQeHllb/9dBCMMe7bpw
         GfhucaD6wvy851iS/b8d22UI+lm54YCIbLPvrw9DaKRuMa43l/IjojTZOXZnCpdlWiXc
         OajUZPoPmh0EmEIqexG7b2H4IUspfqpJsDpGKJAnq7AT6zp66gNtECU96TVjcE3oZYQv
         ceVyLXjWcKtJQjhc+HMrUsbVbt9RKP0rpIRLb1grK+Jn8IZ4abPNdaPcMoo/8yuwZHVd
         KKNQT+icGsXhOaAn7nIfD35L8ZUxlHTgx7hvxiRkyKX0itPOkPqCraaKbWdfqHCboMZv
         3zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882509; x=1763487309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn7wodOlLmLsT5jl+y7mwvvOyNWafbKyZT24/lhSKsU=;
        b=UJDG2vU0Sr6sZekfOk+9n7MtJqFPulzG5pJmfyJIY7SNw7IZAZ6egk1InYSu2qF3Ow
         HoyzNUd/KDgWMO9QRSoe2BvlLaSQ3U64WwlbJy0rRW7Hrd90zl/76TtE7mOpbJQP9G0g
         ni5w9HeqqU9J4UdDFBoETrqArSBwdUCdVm4uadvQuA37shnxEqa5mQbw5dWmQZUTiksH
         sbb1bYoFWqX05T2GPa9y7Jklvwp8NZ/PE0HCwuvvc6boPCT8BHXopSpF4KIXHXAxxx+o
         o9aq4aMZB2xd0fUGWZQeey+h7bMqd9m5G8bdzfm8fA7wP0fEyrFjL49Bc4Krl0/JIP1E
         Nyyw==
X-Forwarded-Encrypted: i=1; AJvYcCW/oqRYEfZy6weEUe/zi0XM0j3iocBNfjWaac/SYw8igM5afuEx02suIdMUVO1UYGCcTKDy9pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXS+qmLOBawggzQNebMgTA4pClNXgAj9esPOhHsrXWhn+D3Ki
	AZeFbwLfCgECK37kLz36Z4W/bBZPasHLQtMZFdM83mKH/hSlFIPt6IQAsgByrnls5g4=
X-Gm-Gg: ASbGncv42NZhzijnsK9pv6/C55l2RPDC6xPQpkaPBcSWeXlKB70DZAa5O193UVEgEsf
	FPTKNGAJ/VXZsYY2tKhgU2EkiDphyTxAGGS94XXalOa9S/A1emfBt3sgQrpcADk6XSIaIU+Jtmg
	d7MueXgOohaIdjj6FCT3XVh07HNRPA5/UxuZChFwLIHFiSWuPsmSPjhok+FvG3fC9A6wjTL8BRB
	d83PHZV6+eFNKLbN5pDz8QXdb0PN5DnEPtxAULnLyP240KLk2HBEVaKaQVDt5l2T7ZpnGYc0T3T
	3iuKgmv9RCh9pzegWw7bcKH7Ke6c9sGtZ8KYLPnUehESvIcdef/8Kk7GuI2tqTlQ5LcKT2Vdqb5
	DEDRh5QKGrPOoQCuUzjsoK7VFMJC9rDbVYDba96ZzwZKe+7ks0rdrOxipscdR/8QQEvj6ahKObN
	WjZord4Z0gOhujfmv6oUSe0/NtRbjtFI7is/u5Rck2ZyZ4FM7AchK4USSF3lIQQPumcdVP
X-Google-Smtp-Source: AGHT+IEz0LrvTesjoq9sqvJhE7WDXqU+vmtvWV1dJIaEtss7fo1N4X5gKRr8bhaxc3JVEmkbc6B2QQ==
X-Received: by 2002:a05:6a00:a0e:b0:7ab:995a:46af with SMTP id d2e1a72fcca58-7b225ac9db4mr16166106b3a.4.1762882509376;
        Tue, 11 Nov 2025 09:35:09 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7:7ef1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b783087c08sm131191b3a.3.2025.11.11.09.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 09:35:09 -0800 (PST)
Message-ID: <17aaebdb-aee4-4a00-926b-847943aea14c@davidwei.uk>
Date: Tue, 11 Nov 2025 09:35:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] io_uring zcrx ifq sharing
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251108181423.3518005-1-dw@davidwei.uk>
 <f933fe15-6bd5-4acc-94ce-d5ce498ecf79@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <f933fe15-6bd5-4acc-94ce-d5ce498ecf79@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-11 06:40, Pavel Begunkov wrote:
> On 11/8/25 18:14, David Wei wrote:
>> Each ifq is bound to a HW RX queue with no way to share this across
>> multiple rings. It is possible that one ring will not be able to fully
>> saturate an entire HW RX queue due to userspace work. There are two ways
>> to handle more work:
>>
>>    1. Move work to other threads, but have to pay context switch overhead
>>       and cold caches.
>>    2. Add more rings with ifqs, but HW RX queues are a limited resource.
>>
>> This patchset add a way for multiple rings to share the same underlying
>> src ifq that is bound to a HW RX queue. Rings with shared ifqs can issue
>> io_recvzc on zero copy sockets, just like the src ring.
>>
>> Userspace are expected to create rings in separate threads and not
>> processes, such that all rings share the same address space. This is
>> because the sharing and synchronisation of refill rings is purely done
>> in userspace with no kernel involvement e.g. dst rings do not mmap the
>> refill ring. Also, userspace must distribute zero copy sockets steered
>> into the same HW RX queue across rings sharing the ifq.
> 
> I agree it's the simplest way to use it, but cross process sharing
> is a valid use case. I'm sure you can mmap it by guessing offset
> and you can place it into some shared memory otherwise.
> 
> The implementation lgtm. I need to give it a run, but let me
> queue it up with other dependencies.
> 

Yeah there's no reason why shm + mmap wouldn't work cross process with
the right offsets, but I do suspect that it'll be niche with most users
running iou across threads in the same process.

We can add cross process support in the future.

