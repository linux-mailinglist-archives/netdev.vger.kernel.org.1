Return-Path: <netdev+bounces-135624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C299E92F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16EA281D8D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76831F8EE8;
	Tue, 15 Oct 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2uKkv4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D8F1EC006;
	Tue, 15 Oct 2024 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994342; cv=none; b=LDg/KC58s9PFEFIUFtahdPUQAPuD7R0Xol1kYkZM8Lbny7D4AzVv7F6N9qy1Qe5JBTV5goiFBJpY0OOh3HJN18CCwps8pVcDZu+SYqJXILR3eKhIeaa+qGPSOYWRX7ODEFwFD8HjAM9Zi+l3Ck7uqjhbE9XqRX8KwtBEzEcyhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994342; c=relaxed/simple;
	bh=0EytnEVYueFI5FkuBE6fvq65mtK2QNMq/P8GFScIGVY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BEOa+vkRWY3jGcMGBM2fvGlwgh2qUv25dNGwkh4oXibBiNtKzTjT0o1i5Z9G/8tYDkjXhb4kmCrN+jVwYS5U6G3pDnS48Yk0qIOFGignYyd2DE8MhITFw6TU3RUSKVD0eWtUXR6x3BiLx1mFBKGFZSkFxlSzCHtIkvs1uxDcWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2uKkv4K; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so3335232a91.1;
        Tue, 15 Oct 2024 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728994340; x=1729599140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OZGwvaXz1qhmiYlAOr7Vkc79vDlIxdvnur4NOMqdC0=;
        b=G2uKkv4KVnoi7xBWvOLCYMPlEOmgIuveSFLj9zTIVDGf4wxDlEdjwj14LZnhNEoW3W
         TkTG9wdKxqoroqymSi17MowKnEwlEHbdmKhyAglKLHHU0K+1sH+125kuTCGkiAbDHfHL
         nCJjrNuxpwbPHVz/YtcMjnloP1MkSfjTQRiDuOIP9qXd/xO9nGaz9j/InuzYIpdOkRq8
         2C04sZbqqf3onJpasEI9Owjq6itTtS0SdrAn2Kwm96MpMH1fv8UhBAfrZ3ax0GphMOeV
         eVokDYIn+xwoR/WslAZ6OSqebKW6tseWzFsvWRfDopRXn1NBWYBqukEhLx7a7bE3SXTq
         fhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994340; x=1729599140;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OZGwvaXz1qhmiYlAOr7Vkc79vDlIxdvnur4NOMqdC0=;
        b=d6LGbpHACfwDrd385+jEWtTPDHLor3qkvcquKHSxsHRXGK/863oSG/KpccEhnO6GrQ
         I0Esk2ZR/0giIjBUYhYgdLe723IWr1KxDI08NjMDiGCXfIw8k53eBBl8/FgJXotm8MFt
         Yjq21jMigYT84tPYdYzBoElrDNlnPrwPyI/0juuXmJgCCGcTIbSnPSQaoN7aZsUqp9iv
         MAIHGySvs9jsC7C9r02U7ZDwbhgTTP5pRM9f1QY908ipfb+88ty5ziaDtl9U4MtHJh4z
         yCkLkk9IkRtnOtP81pxXbtYCBUS+w2OKRi75yPDoqZnrumDgKbjfhRR6UoqB0OJ+hvUP
         Bg+g==
X-Forwarded-Encrypted: i=1; AJvYcCUuUzFZGAbCCBSPptBWjrIWhWTkXV4EfgodkGYkCq9Cwus+J99XIpqqAPoaEm7gkY2mF5nBOEPmzK2GzCucLnc=@vger.kernel.org, AJvYcCV4qpJW77bRNaULDxNU2yVRU05Hfl0UbTfRGU+povhVZZDPr259eKTe3c6e8Ev3Vfse4lZd14kv@vger.kernel.org, AJvYcCXp2QpTHWFPpmFl7h4ekaC79En8Rlp24z8tawJ9NOpPPmTn4ACIbKnXrrQOHmwT6YRZId7FZSILkaBno4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzy862VzzGyzdxN2/UQ9luNLeZbK0nalAH6SF6PtAYVvmE0LF
	FPq925sm5LuwGdLscI2GAqhGnZVQWiv8dqjOtocDI4xwcLmozZzS
X-Google-Smtp-Source: AGHT+IHgG1qhPjkaEMUuo8+ebYTUokTMKvZtaT2Lp7J8A+pJHdqpiVC4zBvQMqfCzZ5IBLu98Q8kmQ==
X-Received: by 2002:a17:90a:bf0c:b0:2e2:b45f:53b4 with SMTP id 98e67ed59e1d1-2e31536de0dmr13383839a91.25.1728994340498;
        Tue, 15 Oct 2024 05:12:20 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8cdc7sm1559086a91.10.2024.10.15.05.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:12:20 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:12:07 +0900 (JST)
Message-Id: <20241015.211207.1963272330702106304.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<20241005122531.20298-3-fujita.tomonori@gmail.com>
	<3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 20:02:55 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +/// A span of time.
>> +#[derive(Copy, Clone)]
>> +pub struct Delta {
>> +    nanos: i64,
> 
> Is there are use case for negative Deltas ? Should this be u64?

After investigating ktime_us_delta() and ktime_ms_delta() users, I
found that ten or so places which use nagative Deltas like:

timedout_ktime = ktime_add_us(ktime_get(), some_usecs);
// Do something that takes time
remaining = ktime_us_delta(timedout_ktime, ktime_get());
if (remaining > 0)
     fsleep(remaining)


Looks straightforward. On second thought, I feel it would be better to
support nagative Deltas. We could use i64 everywhere.

And i64 is more compatible with Ktime Delta APIs; ktime_us_delta and
ktime_ms_delta returns s64; we create Delta without type conversion.

