Return-Path: <netdev+bounces-233543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31368C1546B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB21189AA13
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BD1531C8;
	Tue, 28 Oct 2025 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mR/3megF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD71F03D9
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663303; cv=none; b=qI4CpSbKwN/E+Crn0zcWg3RG6KhBRcspQdP/Z706XVNbMtFtm96rbb+hSZWBKHTHSYJ6/+Q3FJT2bMHqWBRFJtdkd2CDry/SPrW8yBrb5zlGUFt95DxwfEIZEvjir8Qllcq87K239E8616C5CgHzVV4qazQdDbjnBGFyYtMasZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663303; c=relaxed/simple;
	bh=2PFvZeR6FZ5y/R3/+WHESxKSPwUDsScr1IwZ5KkE4Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raA1PMM7DaGjFs/pokLrySYoIw8bBCg+Zf5xNPwqL0QNEN9K892DVReIW+Uodjz83QjJNqO7ISpw+oBkNcx7ivBGQ4NPx6AOM+t7+Yu277ppcqDe+Rbm8kRPyk1gK/KlNqtnk7ZDCpXb00WDnTqH8r1jSPlwFn/ctldjPDXQlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mR/3megF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so8035396b3a.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761663301; x=1762268101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7Xa21oSxQFb3c2s+CxJq7KCyQuGsxMn8gSjW30YCMI=;
        b=mR/3megFe1plV232xR6jXmuEoJmt9vUP88DqOKO6vYQ1M4z24FJh6FmExmzX6fX09j
         O0YXp0AaOlDu67jI8otM2x+1dnOE6dQsb+w8aPO1fi0l+4HAW9P+Xz1SM+ufRmxOkFok
         IqgvghS/seNrT/NXHh3Oo4FnvCtSUG6cyJ/a+Xbv19h/53eyOKkd0HvhI/nvRR5x6Cex
         uTYIJD5EgqQlZqcxqLu0qaB55mm9OMFFkubhtDqG7HBn1mzLw6A9YH51EPj8CCtOxngT
         87mHDEeuGMcwkd+pv9YTAcLR1dihB/l9dPpk/pZfyWzqwJz8VMbjNj88dKHEQsxpU5/1
         x7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663301; x=1762268101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7Xa21oSxQFb3c2s+CxJq7KCyQuGsxMn8gSjW30YCMI=;
        b=r7/TcqvjHHSq0z4NunVsjKKhrAv/L4u99H2Ej/6H/tQzNhmUINOqvKWFkuSgYA3drT
         BOj8GCTCoaHjqPJmbKTsn3iy1ql46uIHWy9hN2mumCSRrKqddwl/rWZfIugeS5Gc3aM/
         7QeEnVBRihpeZnPJXIbWBqNJFyTJa42yqPdjfORlimP0NqdpZ8E0OV9ILFaOmMkvpsBH
         Eso7Rr1OgeRwdXav5N3RuwuG1CemsBFEJEFDmE1xwfiPRcaFc6enctJvGsTPAr1PrsZE
         k6vTLkVLTLBmEMoW19y/24Dg0dam23P9l2Y9Sz0/KGfRD2lXsqA5MUHDBQqBVwNdoEkR
         WlXg==
X-Forwarded-Encrypted: i=1; AJvYcCWnufHZDsPEZX9jlS2AJqhcuYSk2WEQOtgAdpCniDjusOkynbXoH/NrsE4pQF7iawfoYo0UPds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCXCunZU6w456Ye2+lgYi0UyJl5l4SrvcoOEJE7CWryFMLdQe
	1zoPhDVplBtTIn0R2gegC+WZlT0e77u7RON1ir9jweKgouINJ5V1PZtScw3Hrlmvq5M=
X-Gm-Gg: ASbGncv7XQk/6wr54jVxP1ZBnRstidlopvDQ/j42V/a6i7Iu0GKhrQ7X4bCmaSU5Zi3
	XSqeyzoYafXj2vQ8kJ1ORTxPCNTUpI5NlwbK2CTD81Wpd/izTmq5bgT/UX4VeV62Wu144RXK0nT
	aF6s4s5mO2Gp5qAKSlTF1yZKoT/ZwkOQxW2jcgv+/4wc5woBPjI9o0xduE/fkXcYy6lSAInyhsn
	DiKs8phOphxM0tYcGBZED0CPvU+clkgij5a9jiROJ7W2vwjzqC1wr2wJUNpWCPBBVS9UJf7EbTx
	ADZ+XiBmjj0c34cck+u95aS5HofYPZWaTe4L9s1Q8IfWh+Fhz2pFAXhcgSNX3/3WS2+C+ENA52W
	H3tvMaJx5BCpPdb5md/Go1kKFesZqeoKZPvcUiF+J3PizIkwfmM895cW+fbMbhmMEApWQjQXsfB
	Oy8YY1qQGyAF7W4XxLjqkATohsGeqMVKXJA0iOR/COhgnGhmVARS/xKzxmt9BFXQ1Oe9nT
X-Google-Smtp-Source: AGHT+IERVBWP3CiTECEuDyQSl8za0TIzSRK2W4YtwpnPOl80PRQRDD5vRcY4w8hz6WjAmch11Vxu4w==
X-Received: by 2002:a05:6a20:6a28:b0:2ef:1d19:3d3 with SMTP id adf61e73a8af0-344d228dd62mr5056634637.14.1761663301065;
        Tue, 28 Oct 2025 07:55:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140530d3sm12157441b3a.40.2025.10.28.07.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:55:00 -0700 (PDT)
Message-ID: <74cac804-27b5-4d25-9055-5e4b85be20d6@davidwei.uk>
Date: Tue, 28 Oct 2025 07:54:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] io_uring/rsrc: rename and export
 io_lock_two_rings()
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
 <20251026173434.3669748-2-dw@davidwei.uk>
 <c3a45eaa-0936-41a7-92cd-3332fd621f6a@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <c3a45eaa-0936-41a7-92cd-3332fd621f6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-27 03:04, Pavel Begunkov wrote:
> On 10/26/25 17:34, David Wei wrote:
>> Rename lock_two_rings() to io_lock_two_rings() and export. This will be
>> used when sharing a src ifq owned by one ring with another ring. During
>> this process both rings need to be locked in a deterministic order,
>> similar to the current user io_clone_buffers().
> 
> unlock();
> double_lock();
> 
> It's quite a bad pattern just like any temporary unlocks in the
> registration path, it gives a lot of space for exploitation.
> 
> Ideally, it'd be
> 
> lock(ctx1);
> zcrx = grab_zcrx(ctx1, id); // with some refcounting inside
> unlock(ctx1);
> 
> lock(ctx2);
> install(ctx2, zcrx);
> unlock(ctx2);

Thanks, I've refactored this to lock rings in sequence instead of both
rings.

> 
> And as discussed, we need to think about turning it into a temp
> file, bc of sync, and it's also hard to send an io_uring fd.
> Though, that'd need moving bits around to avoid refcounting
> cycles.
> 

My next version of this adds a refcount to ifq and decouple its lifetime
from ring ctx as a first step. Could we defer turning ifq into a file as
a follow up?

