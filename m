Return-Path: <netdev+bounces-181957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D96A87186
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D46817820C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89A1993B7;
	Sun, 13 Apr 2025 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9t+VG6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171F17D2;
	Sun, 13 Apr 2025 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540156; cv=none; b=hAqIq7tuYOqpvjH8sxfY9buFe8jZifvWZyiukr5fR12jjIrTXmA0w5uYkPZG0FHPk+GFPS6fTvg2kH0qOgIB5M51zqk5IS8IBsC+pJOceRagl907u4LFxi/w4kUJZw68DdMEMDknTLh/EEk/i5ULy2A4fFDonFFr1LYpB9dIH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540156; c=relaxed/simple;
	bh=E5I+371xCbmmhoKRmiKWPHATXCH8tSftADNyjEdTUPc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Czf1g+bhHu5x0hHCLIyNxexJ0fHPXpvHacxrDSvimwDi23fqUAgeFC6duonTfnY0EIyxHbmdlN3WMoeSXBVeI3Q5XJpcek+C4apvQCChUb7JUwnj6cApMVUF/oE7DOtAqHY9opRG+lV5YpBK9DfbLtw/N5fqBEQiBXytLEyV0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9t+VG6C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2241053582dso46048615ad.1;
        Sun, 13 Apr 2025 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744540154; x=1745144954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=062tQ8hBGhKHokYfu50dzJW+l9reruKrWiAaVbm9O38=;
        b=j9t+VG6CVUuzR9z1Z+PK2l4yHZhTdwUNEm9q/P2shh2id/1e8P59FJSo37QfJCnKpG
         tVd5TCiX6HuQMcFwqbNthKz1mbFDQJzUMvT5kr9oysIm8DZt39ZvzVA0BHjJqh1knQ1E
         MV/8/O1X8duE6koks7X+5eFtv5aYvHqNr9fJVIm0byuFuAapG5Yr3F56ZguOQkv8d8s0
         fDfawQirglC5eUwFgpskNsNWKmEz++a9aZrBod+BwkgBwe+0bgdaSAyZLpfhH7fkFrhQ
         i3XARV0549App7mxdzWaN5yx9yQeIouO8eb5ZeN5rUyEs4SO/h+43xRgk/zPkPW4jHUv
         6vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744540154; x=1745144954;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=062tQ8hBGhKHokYfu50dzJW+l9reruKrWiAaVbm9O38=;
        b=DKJG7eCH0b1wy5tvy4aPQnOXXmeuJ132RAW8nn+l2CvghZ19qD7/KKFccWoFzyJlqF
         Qrq03ci+shTmohoLUshe910oie2CbYVcZ/zaZYuNLWammini8sd1eJIzvvGDwx5h62Kz
         O1wJ0Ve0f3HgYuD7wydi3Vj5aJWBqjEh80THbjtPFbgJCZNaWss8rYQ5bbWq2keVhpQX
         K5YaJ5YsvA9nH58TjUJOI+A3AJpI220KoN9inSsi5PIGJXBpmHYvtQgHJevjlppwJfkj
         dyLm0J+iWkpEiaC5RZQDPR4NHk4nRGGOg0ZYeiHFvwIf/cE6Ib9SjCuF1pYAHIU/NUSm
         qlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Cd00GOEM2C0CYMU6aKHEoV6POPArisddPUZgrsA+L7jVjcOeBh7Pp4WVZWUesCbVIEGUTZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UW+ioXcDT53dm0X6Hnp8yJWadJEfFeojk0rDPcJHTpngrnB2
	FvFj7hXjQyyt5tBqjTUGyzqbCtoH2lXbQywsNG9gxf1dIL/5izjNnesPxXUd
X-Gm-Gg: ASbGncv89XhFOWjPuULmibqbKqKzVu07rsBloSzEY0S/UKRj4rr38s7I/pVtXA8mwy4
	a0Nl94Mm/Vx3bkmljX5mltOzcXvTTmlpjvr9PLLMTGnkbGEfyBuToV5gVTpLGt0AIpSV9WOqT9a
	jk2uZOhscKhIplseNHUzQIuEttMLObrP9iUqXcomc714cHGDOrCvEHsLnfH9Oo92iee36zRNSxp
	gUSdcZnaUr0Prz8bezxei/rWe8bS6VvDvonYF624fLDjXFZX8YEitq2HGHWNtqTuFyYeegIIsE2
	4J7Ur78b/kWdGv+/+1GZcoVp8SOacW+8xAXKTSQ539sZ0LuHVK+/xBWmY80OnwXopjnOffsBtHx
	TbbwxPhdpsu+1aZPrEVyxqEk=
X-Google-Smtp-Source: AGHT+IHeG+UtrVc8PdIkggjnL8HveX9JmsEGR1DnDLrWm4yaR8RwChPjC9cSMKyeCnF9wqnGD6DJWA==
X-Received: by 2002:a17:903:1450:b0:224:c46:d166 with SMTP id d9443c01a7336-22bea4ff1eamr146847065ad.40.1744540154072;
        Sun, 13 Apr 2025 03:29:14 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e31dsm4843100b3a.141.2025.04.13.03.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:29:13 -0700 (PDT)
Date: Sun, 13 Apr 2025 19:28:56 +0900 (JST)
Message-Id: <20250413.192856.741156280936917989.fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v12 5/5] MAINTAINERS: rust: Add a new section for all
 of the time stuff
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250406013445.124688-6-fujita.tomonori@gmail.com>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
	<20250406013445.124688-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun,  6 Apr 2025 10:34:45 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add a new section for all of the time stuff to MAINTAINERS file, with
> the existing hrtimer entry fold.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  MAINTAINERS | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d32ce85c5c66..fafb79c42ac3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10581,20 +10581,23 @@ F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
>  F:	tools/testing/selftests/timers/
>  
> -HIGH-RESOLUTION TIMERS [RUST]
> +DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>  M:	Andreas Hindborg <a.hindborg@kernel.org>
>  R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>  R:	Frederic Weisbecker <frederic@kernel.org>
>  R:	Lyude Paul <lyude@redhat.com>
>  R:	Thomas Gleixner <tglx@linutronix.de>
>  R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
> +R:	John Stultz <jstultz@google.com>
> +R:	Stephen Boyd <sboyd@kernel.org>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://rust-for-linux.com
>  B:	https://github.com/Rust-for-Linux/linux/issues
> -T:	git https://github.com/Rust-for-Linux/linux.git hrtimer-next
> -F:	rust/kernel/time/hrtimer.rs
> -F:	rust/kernel/time/hrtimer/
> +T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
> +F:	rust/kernel/time/
> +F:	rust/kernel/time/time.rs

Oops, it should have been as follows:

+F:	rust/kernel/time.rs
+F:	rust/kernel/time/

