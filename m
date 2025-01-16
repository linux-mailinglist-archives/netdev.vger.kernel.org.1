Return-Path: <netdev+bounces-158868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B8A139B4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA83A6940
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2E1DE4C4;
	Thu, 16 Jan 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C00U3LG9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BCC24A7C2;
	Thu, 16 Jan 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029215; cv=none; b=rtGoFYtCfenEnqBVmrt0Z+6ZT+PgFq1m02qYbv+vbop43qQ5mmzk1F9FxUu6EsWRwh3b246rh1G7ZHvXwy7mG520dqfYgtdiadwco58pxyBwonHCcxxP6pDVYG6HQezxs8VH6EHdjJKPvvjS4djaUbDSgljdVC2fhAKjS+zYsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029215; c=relaxed/simple;
	bh=L9mkDRuPqIygOACOYZTrX9gcufaqvke3x/yoEoWXP+M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MIWhDE+cPZghAqA7KPOEiJ6i3PiA8BXYxLjJki4UtijcUO2gAXxISWqjSiuo448uZfX1qLqKHuxemmCgDMkLmxC0pzAtUCrRpEnJspDaqKrRTkw+u+fz+ujN0COMAUulNK7KRsi1P8JoBb9wuXqNtqyP/OChjNzQie/g5Cfzhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C00U3LG9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216401de828so12933055ad.3;
        Thu, 16 Jan 2025 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737029213; x=1737634013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7Jj4W9qOv89woHsRoJoR3AO8gjFZKouiLUxttkELCY=;
        b=C00U3LG9iyBBVsQGiI0HhNG0InpFz31gu9zuwQO9NIx+5kUeec5zfevld0gx9W6Ajx
         zKQYQkNzAgdRx72h2IiiqIJ2r0V3Q2xbSmTbzzFB8ULw56rknlYyQSHX68Shj1ziJj2u
         v76yx8K26k8FdyH72N98RstgIVZSmYDCLh+zuvufGqWHVP6fKO49xQ71ZFGDe3NfYs/B
         V84cd5vyWMaOgu1OzIWTAwpQrYrhukm2bnDiP1G3FfD78P1aCllKKeVO6KWgRJhMaw6I
         p6+9AwU0C2LKa1dTkEdooiDsdSGdhThyleFarVsQhpsdS7LWKO22IsirQXqgTIjlclg9
         diBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737029213; x=1737634013;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h7Jj4W9qOv89woHsRoJoR3AO8gjFZKouiLUxttkELCY=;
        b=EvAmdkKlcr9T2NG/c5J+B0sfMospksYsjYQeQuc5gm5bjjjvfJ8L2wOTWynwV6nrz/
         JBsCOJp+9Grgrbu9iEXgR5q0NhnJ1zBpQFouldvufw4aQr7x6EloK7HE6XDHZDo0PZSz
         4KkCbkgdi1XL6uMcaShIDByAzD6Eu3KCCo/3cIL0Hq0k38ZliXAwW+DqW/nV76vu9ilT
         HUp7ZN214jXfIIdDA1r3cUTG4x70sPHgkg6LoPQ7WPIji5B3PliTUBQg9AeCzqUDoe6L
         DjAbsA3Vn3fS5MFWZ2h9Sx/YUSgnSOL5NTdAmsafjBPyLE6nRBwWG3wsr4RnJ87hG8cM
         cw2g==
X-Forwarded-Encrypted: i=1; AJvYcCWjkUqCqPQSoW/RmOm860AMsPLLZ6BJou5oBhmjVhpHQk/MI+yhquEDwOO2bHe9pfzrODMnQnR7@vger.kernel.org, AJvYcCX539jczow+f0k4dt+XcKwlrRIJ7gu3zex5BlBU0D4VeGnxUURv9MkNNrbHArIj1T34KXsQky/CwfPAPTNaWXg=@vger.kernel.org, AJvYcCXqkDCV0TKGYbDPipKVl3ICJSLyPVSQhU+W2434x4odL7upXZe1HX9nDcB46Q2HzndH19pQRigS94oyPlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwYB+e0RDpv/B3tVQkv+7UVnfM1Mzr+s3568mSb/CghDyvY5X
	VGSRYsVJ5VJgANQ6TYeHdDE1OUuUnM0nf2NwYtllh7VYRSTuARid
X-Gm-Gg: ASbGncth3njUV37gsAyT0hOoOxxLR5i8mP11OvTMBxBmYDLfnCpl7qfMZ0j+6lanzna
	9lt+tZtg1QmqAuuHbTlZG2iNyjeGKhVJ5+pVOytv9U0ma+rY6yDPFFtFkA3ap85pDqAi1vAYBx9
	x4p+o3XmoeAX6SXtZuuy39DVTMJ4TUmX3pn0rjXSGG0rMifCGzynYzZtE5DG4POmmjBrOKwsIVq
	5CnojZQ1VQstxaY6dnxKAxFSmnvwoYFJu/4TySqyoAYdtu+e74DkvBG3eb7hSn7lpJpOfEkPRQv
	XU3VfMEm7ZfuuIyixvo+0OJHDnHET9hfariJTA==
X-Google-Smtp-Source: AGHT+IG3jtjqESKxYEnHCCqm+jzLXjcniorNnWsxN3TlLXNv7edXjR2b3y6eEUDcNdJE/55FXL4zFA==
X-Received: by 2002:a05:6a00:3c93:b0:724:bf30:147d with SMTP id d2e1a72fcca58-72d21f4bc93mr44547304b3a.11.1737029213371;
        Thu, 16 Jan 2025 04:06:53 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658d2bsm11046492b3a.107.2025.01.16.04.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 04:06:52 -0800 (PST)
Date: Thu, 16 Jan 2025 21:06:44 +0900 (JST)
Message-Id: <20250116.210644.2053799984954195907.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLggz0t3wTxSNUw9oVBDbR_PSWpQysaSSt6drd7vw8AXQfw@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-4-fujita.tomonori@gmail.com>
	<CAH5fLggz0t3wTxSNUw9oVBDbR_PSWpQysaSSt6drd7vw8AXQfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 10:32:45 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> -impl Ktime {
>> -    /// Create a `Ktime` from a raw `ktime_t`.
>> +impl Instant {
>> +    /// Create a `Instant` from a raw `ktime_t`.
>>      #[inline]
>> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
>> +    fn from_raw(inner: bindings::ktime_t) -> Self {
>>          Self { inner }
>>      }
> 
> Please keep this function public.

Surely, your driver uses from_raw()?

>>      /// Get the current time using `CLOCK_MONOTONIC`.
>>      #[inline]
>> -    pub fn ktime_get() -> Self {
>> +    pub fn now() -> Self {
>>          // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
>>          Self::from_raw(unsafe { bindings::ktime_get() })
>>      }
>>
>> -    /// Divide the number of nanoseconds by a compile-time constant.
>>      #[inline]
>> -    fn divns_constant<const DIV: i64>(self) -> i64 {
>> -        self.to_ns() / DIV
>> -    }
>> -
>> -    /// Returns the number of nanoseconds.
>> -    #[inline]
>> -    pub fn to_ns(self) -> i64 {
>> -        self.inner
>> -    }
>> -
>> -    /// Returns the number of milliseconds.
>> -    #[inline]
>> -    pub fn to_ms(self) -> i64 {
>> -        self.divns_constant::<NSEC_PER_MSEC>()
>> +    /// Return the amount of time elapsed since the `Instant`.
>> +    pub fn elapsed(&self) -> Delta {
> 
> Nit: This places the #[inline] marker before the documentation. Please
> move it after to be consistent.

Oops, I'll fix.

