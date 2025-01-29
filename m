Return-Path: <netdev+bounces-161442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3758A21730
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 06:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4073A253C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 05:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5618C011;
	Wed, 29 Jan 2025 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COOTfXFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A95672;
	Wed, 29 Jan 2025 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738127082; cv=none; b=tXllCjwlq88f0kGrQfQqBEzJy/QLMcGm3vHl2bResP/IpSyX7LNqbAYlIf823l7OllU86O8V0nrYkp4eVY3qsV1l0KKIv/Yq+Yrl7XOEqnXs2C+AEz7Js1fpLOoAt5qt9fRjQIqbM4i/ee2VF4K9j7rnhDsAnuJmxN43fMwRUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738127082; c=relaxed/simple;
	bh=4WBKXgF8Cf856+qEXxp3BJUre6ROUsn8IVszJznHNLg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f1O32jDo4olf43++cQtegmg4NS4SolOlYHf3U+1RwzL9CEW3XJBwhIEaE6u/W9XqbPaXQuakrbMQfzN+VDZ+WXW5ywfS6tgtNBDrEbLog8vrmU5RDaNEzo697jmWCQPkoC+J1j8H1r/Qam1Ws3o9BapnqBGJaaWnUWwmz9/SBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COOTfXFg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efb17478adso10966378a91.1;
        Tue, 28 Jan 2025 21:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738127080; x=1738731880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG0i3I3uM5KhBy3JGEIxWbqBQoplftLjoVsAnm18yIg=;
        b=COOTfXFghTJv+9Lvcjc6F+AZHsF/eeejV8PdFNbX/IMDJCRkimgaBFo7lvvrVZyyIp
         dk8+1wN7OKgDvMUS/3RR4eu3Zs2VGR0jv1Xu7mwnG/jbGfIPHKWAQ5a2+dqGMLztOT9U
         t4UqKzrsr6UE5KoijTlVKvTDX3u9ukmv9Y5tg8VpEDMJ9SFrXTqp1MHhnA5mZgZ/8cyP
         LaEl7ZepRXkpnhe51dABNbIowo1E4uybPY4J7bPPSZWG9O8ccnnHXBKIvSEPzT05bZI6
         w0+F0c/HvquWhbGkotBwDd7H865805esW2DjhGMx388XtVo4K/nvDdSPofRaSerlt80c
         pyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738127080; x=1738731880;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NG0i3I3uM5KhBy3JGEIxWbqBQoplftLjoVsAnm18yIg=;
        b=Z5rtpYf1D4aofAjzD1PvptiQ+iEs1PHDRntOtY8MP0u/kScL1I50V+TDg4yofPeYzA
         lAFqmhxsDrEUTtr2f4qR+pYgFerZVlo666CwMWiprcYMGN2pPKPekVZ7b3woB0dTrFbb
         XMuSVRbtqrPD2USaS+3eQfKgrUS7PYj0qXQNPnaHl+GNkRr5NbnDT3f41lQrWe5AfLhX
         hLy1eggY9D/NJbMSTsfgO9PzQRSqa92xXnsoWSB+GVxpD2BP0DpJB6qK1hgvOh0dCrxu
         nZG/9Feh+XEm1rQQCEwxTe58/KSdfIsuKSqjBATiGrYE2WSwcP8rPWYyfJQYYhbndVUn
         ziGA==
X-Forwarded-Encrypted: i=1; AJvYcCUxcv2fiLknEpdGsMkcn3BzFgSxdIi+bxxVOW248Ke7YSRZHTOtky1S+CVF01yFHvEo+Uyt1BJ6@vger.kernel.org, AJvYcCWEIcqO/59vvnoeRSOGKwb+TyNXhbaBVGUVBE8Y74CfD9WqWZTYz/hqjfZhocd80j0E7c+5VqK+Plg/br50ES8=@vger.kernel.org, AJvYcCXIa5A4wJWQwhGF6INH6OFvzzSY7QdLwKDMVZdDcPHW9Qw/o0BaRCOcVI0aKGHjC5WFmBQ0FGjBPGUsigs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqS2liy1zpYP46G5oXJb/lU2ySBKv4I0SSGW2kbw5gK84k7vJ
	HeS61bOAJ7V0TSRI/dVJNRWV9xiU4dHQ8puRwKclGOYC0+pz1fyv
X-Gm-Gg: ASbGnctyVHwh+X4Ui9FXBv5emCk0XGsz8lxUDjSAEB5fhfBuRZmqs0WXBVMRQ224nff
	btpOmdG6gdbn/z/G5PCEPMFz6Lpb8Jdw6DuBPp0LMmDiYih/KgegERjOm9csG1e18YKU5Sz4hgl
	pwOhOzmfoyUSkxkRYS9B87FCldPxfI+0s6F0HsB6AcwWQ9/d1hoKkb41YATpAuo5gMkMQmzx56B
	3Kl4fPHd/0Sd0FJw7TxxLgY19ZqUezI2SaLSOj+xHC7AqOQBU4uS8Nx66P5ODQbgTkKgNruKGg2
	OkxgOYwTnjoaUojXZRW6MNX9tPbYR7PnGtSpdwcaTt2+Ktvn+mRG7Mrta6ayd84ArV250+kg/M8
	311w2XwQ=
X-Google-Smtp-Source: AGHT+IH/WzIXMqyh9eowbNZMxokRcEhxeKvchlzqWCiAh2ZCeiJpCW4FGs0F1Bodrm5TJtJqwnrc0Q==
X-Received: by 2002:a05:6a00:10d1:b0:72a:8b8f:a0f1 with SMTP id d2e1a72fcca58-72fd0c9460cmr2641985b3a.20.1738127079671;
        Tue, 28 Jan 2025 21:04:39 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78e41dsm10571828b3a.173.2025.01.28.21.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 21:04:39 -0800 (PST)
Date: Wed, 29 Jan 2025 14:04:29 +0900 (JST)
Message-Id: <20250129.140429.1135515133511021153.fujita.tomonori@gmail.com>
To: me@kloenk.dev
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 5/8] rust: time: Add wrapper for fsleep() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <EED019B1-8DEB-43BF-8F59-1A71520F5ABB@kloenk.dev>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-6-fujita.tomonori@gmail.com>
	<EED019B1-8DEB-43BF-8F59-1A71520F5ABB@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 11:37:41 +0100
Fiona Behrens <me@kloenk.dev> wrote:

>> Add a wrapper for fsleep(), flexible sleep functions in
>> include/linux/delay.h which typically deals with hardware delays.
>>
>> The kernel supports several sleep functions to handle various lengths
>> of delay. This adds fsleep(), automatically chooses the best sleep
>> method based on a duration.
>>
>> sleep functions including fsleep() belongs to TIMERS, not
>> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
>> abstraction for TIMEKEEPING. To make Rust abstractions match the C
>> side, add rust/kernel/time/delay.rs for this wrapper.
>>
>> fsleep() can only be used in a nonatomic context. This requirement is
>> not checked by these abstractions, but it is intended that klint [1]
>> or a similar tool will be used to check it in the future.
>>
>> Link: https://rust-for-linux.com/klint [1]
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> One question below, but fine with this as well
> 
> Reviewed-by: Fiona Behrens <me@kloenk.dev>

Thanks!

>> +pub fn fsleep(delta: Delta) {
>> +    // The maximum value is set to `i32::MAX` microseconds to prevent integer
>> +    // overflow inside fsleep, which could lead to unintentional infinite sleep.
>> +    const MAX_DELTA: Delta = Delta::from_micros(i32::MAX as i64);
>> +
>> +    let delta = if (Delta::ZERO..=MAX_DELTA).contains(&delta) {
>> +        delta
>> +    } else {
>> +        // TODO: Add WARN_ONCE() when it's supported.
>> +        MAX_DELTA
>> +    };
> 
> Did you try that with std::cmp::Ord you derived on Delta? This `.contains` looks a bit weird, maybe it also works with `delta <= MAX_DELTA`?

Do you mean using either if or match?

The link to the discussion that led to the current implementation is:

https://lore.kernel.org/lkml/CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com/#t

