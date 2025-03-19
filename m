Return-Path: <netdev+bounces-176187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10AA6945B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA04884A2D
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90901DED4B;
	Wed, 19 Mar 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y+r2+hEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF019B3CB
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400452; cv=none; b=NQc8B8lr8z2FfzCwLmI+u2TYWwqh8yGIv76hOwFnWKlsHZ7+hqatwX119TZAkO8B2FGh6xpW6ZaiTQGRFSFalIRQrt/7KrbtXH3gapqYpzyasg4h3V1wzUMxTdJQbhCQF4aXQUt/higANWYCxXIKMMzEuZYGAIqG1gh75tzvoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400452; c=relaxed/simple;
	bh=n24KzPzMfIDbuu7S5CaFyw0UePwN7haHff4RjRQuRy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tm9DxORHnGN56Ifr1PwyE6NvdhOlp7lpX+AlwTw+99jl649uZAICSmQU5snjMAPeMKbiIm6iY4hovwpz8cLqmYh3037VGKPzWvC/nkNFTkNnes5acY+603GSh3Qxq4hP2hIIDuNTEekzx5Rdu0fdJQh2WAnpwNeuLxHAaM6U/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y+r2+hEf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso48860155ab.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742400450; x=1743005250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=y+r2+hEfjU2Zz7ALNOq5svFqzJiE9cuXQdmJA+P20x3ThNxa4mu8TtLObqNVlmroGR
         OlmZyYGQuf90qEw4W3uFuM+qnOHzzxc8ucTo7UpOKYtNKkyBbOReAsQhAQo3E/IP7leE
         E9wx4qFx45Oa2aV/2THQw+dab2TirOSA0A+EQ6K560wTR4bka8wphawWRyI/d1vJFHr+
         qzQXF+jXmP7T7oWdIYtu4AfbRAkJbRlbzJRgprCtUulnirrdugfhtvRDW6HS5GWmBfRc
         krNJStKgc3sx9SLXZLXnd0wZOcaGEL7gXh4wuw7XqjLN2dft+wd5LxMmSpHgutBnovf3
         PLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400450; x=1743005250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ija8XGDNXdwDWcF7Obpxn5AkOPtI89VS3WVbcU/kpys=;
        b=DGhalq+RZUKykgWkp1UQefQ+H3a9+sU5AWD8zpUOh/ebODG0cOtaYyz/TtRkTETnr3
         zR/DOdT3h5iDc/D5vbzpj/8zgCszXvQ+LP9poKHUcSBJ+JBQcW53WN86ONch1u2sW7C7
         qWpa6QZiSa5cuihlaEIFbPWpwf4ayZzsQimXTPQ3r24UN+4CGSr6CX1pzfyk6yquLVNF
         ZuoLTZfxCdZVFYqCU3etgIS4XOnkQJ3+Ty282g8KXsNTmnsO7Pt3UEa+2wNroicpl7bz
         lyS8nxLjBq90T7Ov7JMWDFAeBGw6o31lmQSY3YN2Uwj9PeYqEnxkUr5Oy/kO31G3hk/O
         d0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUyUtvkJzvRS4acpTLrql32xfmQ7xEgj4YApo/RNJBlq2i20HgOH11R25rAK0h5QTr/hXRV9X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznF7guBkYRhxkxSLLYBxrzD252jFK1aKviMmtTbZg3gEgQ7+Z8
	I3EnaHHKnYiyP39BCaemoaHNW3LswEOGZkqwqZUyP/GgbSrThBOmGa+LBg36HUc=
X-Gm-Gg: ASbGncv2Dnf6m/D706yo/Grv5YO2V2AZLLBxS2yvVZzbyLRK9iyKsGX15QsF4AqNJ28
	GVMCbMwQphSBpwJRirvgOvXrk/jDZ9lveeSoUPZRI5J1Gp/ONHCbcg2ggb/5OgMXvkdlw0COOVr
	Ru49SolqlrzW8my4OGkgmAfxt9XYgrMjMC5u2pQsjAkvSOsIsaiz4HiwsnSU9tUHDHEyGLYJHAf
	zVcOrnmMie+cCeeazu1qHjTzJhoj7bqAsv2Mp2+Rp8CMvwymsq1gnPVZXI13zrMhslcwe4bjHy3
	EOkXBChfVzaz5OhAuxjPSfpKPii4x8KDF9MKcdsl36tHRn9PJfs=
X-Google-Smtp-Source: AGHT+IFDBCFWtf4DEWZHOAZhQMfKg6BVxtB70LM/11gT5po4hUy91hL9GfbCfrY2dAmweb9btJ2fRg==
X-Received: by 2002:a05:6e02:1d1d:b0:3d4:3aba:e5ce with SMTP id e9e14a558f8ab-3d586bb9f32mr38295495ab.20.1742400449657;
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263719730sm3269768173.36.2025.03.19.09.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:07:29 -0700 (PDT)
Message-ID: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Date: Wed, 19 Mar 2025 10:07:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:32 AM, Joe Damato wrote:
> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>> extensive work done by Pavel [1].
>>
>> What is a "zerocopy notification" 
> 
> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> sendmsg and passes MSG_ZEROCOPY a completion notification is added
> to the error queue. The user app can poll for these to find out when
> the TX has completed and the buffer it passed to the kernel can be
> overwritten.
> 
> My series provides the same functionality via splice and sendfile2.
> 
> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> 
>> and why aren't you simply plugging this into io_uring and generate
>> a CQE so that it works like all other asynchronous operations?
> 
> I linked to the iouring work that Pavel did in the cover letter.
> Please take a look.
> 
> That work refactored the internals of how zerocopy completion
> notifications are wired up, allowing other pieces of code to use the
> same infrastructure and extend it, if needed.
> 
> My series is using the same internals that iouring (and others) use
> to generate zerocopy completion notifications. Unlike iouring,
> though, I don't need a fully customized implementation with a new
> user API for harvesting completion events; I can use the existing
> mechanism already in the kernel that user apps already use for
> sendmsg (the error queue, as explained above and in the
> MSG_ZEROCOPY documentation).

The error queue is arguably a work-around for _not_ having a delivery
mechanism that works with a sync syscall in the first place. The main
question here imho would be "why add a whole new syscall etc when
there's already an existing way to do accomplish this, with
free-to-reuse notifications". If the answer is "because splice", then it
would seem saner to plumb up those bits only. Would be much simpler
too...

-- 
Jens Axboe

