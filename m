Return-Path: <netdev+bounces-178824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E3A790F6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4064D188E66F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D42236458;
	Wed,  2 Apr 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGpOPsLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9821E9B0D;
	Wed,  2 Apr 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603405; cv=none; b=rGKwCWlm6uL+TaN/tpIUd7vZGcl/SfUvcOZP37oLGahhZJlfhyeELsqvO6ppq7A2GVMsZdgn8FjpDBjh3+VJjgUeQDWHwxXY+XT4MVBM8DQoXLlYlcxT1bLGIAvUZv2jqmxCo3OfsnoFmVLmEUVZDZOKxP5hYBPEbMkdkcuTXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603405; c=relaxed/simple;
	bh=r6lJAGgboC7cYskrH82DaVdQg4hKHkLaP+aIUrpPYIE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WIX1q8Bt2YAbs8IN9RJKnxbQcQmRqNE6hSDyXqrnSegUkN0KyUZyJkKcxupkJ0gjFxPgziP/zlINRzeQLwFqzfz7B5JL5++3KlYcP5W9TPsRsk8x2kIML/kAEqAUIJ5jbkRUd8lCESXjvwu+2ng8ZGnAGQQI6/shZ4A7kpdehqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGpOPsLs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22435603572so125139675ad.1;
        Wed, 02 Apr 2025 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743603403; x=1744208203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dEWhfK+nea9OPuzRfRRADxivQdl600DDzELneSshW0=;
        b=nGpOPsLswQeCjdSoPsY+9HFk8+XxGcUGHMFwx7JdmGJxz/hNYEFmNxy/qQvEGFtWbA
         CYHGaNUDClk2sy1n19eOHKtfbOUuWI3D4TM0bOmp0wX3M1+q82Mli6vPuECa4LiizcqH
         GAozbnQIsS7B7wW8Kf60APzBFEdFaIvgbKPU+aFsT3Id6t+hXDFtemD/8JYnPMqrqwzQ
         hUFVb7xIS9PVkAzJF345y7yScBB0Qo+VGejY1iK4SLYuwAOKGLzGfBwJ7wo2mfc2WnrH
         00zksVIUnbATQVot1xL5M6cfwNZ1m99/IJ3fubk4inOqucLlBi6WKMPJa143FW7jNyYI
         UGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603403; x=1744208203;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dEWhfK+nea9OPuzRfRRADxivQdl600DDzELneSshW0=;
        b=rwF7wVyJ6E8qR5qPDWDaGi12D673fsnJ9LRqazgQL5lQf4UjWYEFQziStqF7FCbus/
         2500Ya84xrDNKXejada0bAm+YLP6LTgJ7hugSh+hpzjN2SBVGJnZJGuvdz4dIRIkICoj
         LTS+Km8AdeopU22/2fzYeJyq+7wdR8lSV4XbsOR5k2VGXxKgBQJkeSDxpZrPrRou4l39
         9zAddIUlB+W158Rkz45+we3USnOvRoVnGLeB4UhipGrFdM7Gos7pijm7xNJKaoBodymt
         rkbTIlmINzqCOhoIyp2ox1xdLhUqbgYKyWt++Uuwi+qa+fbQLXXz8rJEsros5KzbtCyn
         eDAw==
X-Forwarded-Encrypted: i=1; AJvYcCVFyWowkvtvKRU1paTVrkA3GY54zNhCR+o7l2mTyH1RqjcdluJ8Z4EtNJ9q+AGeBoKaEpr+Yv4dASlDIk0UL0Y=@vger.kernel.org, AJvYcCWJNtPaNzK1ZPqMm/xfftfX1Ws9BvEf3z5eoUE7+LGKHPLYjm/Yyxfnbd3tV1gJIW2vj8uPOUhsGBKbzwg=@vger.kernel.org, AJvYcCXkm9FyXQNUMxIXhjVBOlitzTgAmDzQDFnmzQ+XNtO5dOHWsh0Vt0B3vzaETVI6ij16RL9r0eck@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhCTxHAhENtmqsPsMEjEkkyEpA8DnaL30rT8fpFe3lfHPDU/W
	9naSXmc7HCq43L8AIAXBi9K6IIvqUd3gNdMp9bR2OFBmlnGduyHf
X-Gm-Gg: ASbGncvCQLgobkrF87O1QQT32GX9VjI63Iwl08Vab1tt3xiS+30Qkl8Mjn3RhqH5r3+
	f4j0FHyDstVdnxEjnH5WnYsRuCQqEmEphtaweER1ii0SVUEE/tdBrXecZNUmz+vofiD0yp+Fh/D
	AghreaYHXpHirCErhbt9DWaFFpvh4Bj4Yxdazjs+c874t+8/WyIRnsmw5B+yQvxj95dju1GaGa8
	eVTpfI6EqxsaMJh7K8d4OpmuCBLyoI2NTZfylGW8d1p3HEIcbgQZAMXk7xDgrRXZihclUqGTU7A
	43c5hVP3hOYt3vdhXCE8yVzbF2MHvgLMDec+6yNWpxwfwOQvt6HCNDwooPbMeRGKSiPlrwBF1yO
	P2oR2zZRFwSYb7Tf/WwxSQq+x8tY=
X-Google-Smtp-Source: AGHT+IHAUnZugO7bekE6NDAS+iO7XgUV8ewF8Zpd5kxeKjRJDw+p16Np/nqRLdsScQvdxML3q4JFwA==
X-Received: by 2002:a17:903:230e:b0:224:e33:8896 with SMTP id d9443c01a7336-2292f949d93mr273604545ad.11.1743603402721;
        Wed, 02 Apr 2025 07:16:42 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ce08csm108772425ad.127.2025.04.02.07.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:16:42 -0700 (PDT)
Date: Wed, 02 Apr 2025 23:16:27 +0900 (JST)
Message-Id: <20250402.231627.270393242231849699.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: a.hindborg@kernel.org, fujita.tomonori@gmail.com, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z-qgo5gl6Qly-Wur@Mac.home>
References: <Z96zstZIiPsP4mSF@Mac.home>
	<871puoelnj.fsf@kernel.org>
	<Z-qgo5gl6Qly-Wur@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 07:03:15 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

>> My recommendation would be to take all of `rust/kernel/time` under one
>> entry for now. I suggest the following, folding in the hrtimer entry as
>> well:
>> 
>> DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>> M:	Andreas Hindborg <a.hindborg@kernel.org>
> 
> Given you're the one who would handle the patches, I think this make
> more sense.
> 
>> R:	Boqun Feng <boqun.feng@gmail.com>
>> R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Tomo, does this look good to you?

Fine by me.

So a single entry for all the Rust time stuff, which isn't aligned
with C's MAINTAINERS entries. It's just for now?


>> R:	Lyude Paul <lyude@redhat.com>
>> R:	Frederic Weisbecker <frederic@kernel.org>
>> R:	Thomas Gleixner <tglx@linutronix.de>
>> R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
>> R:	John Stultz <jstultz@google.com>
> 
> We should add:
> 
> R:      Stephen Boyd <sboyd@kernel.org>
> 
> If Stephen is not against it.
> 
>> L:	rust-for-linux@vger.kernel.org
>> S:	Supported
>> W:	https://rust-for-linux.com
>> B:	https://github.com/Rust-for-Linux/linux/issues
>> T:	git https://github.com/Rust-for-Linux/linux.git rust-timekeeping-next
>> F:	rust/kernel/time.rs
>> F:	rust/kernel/time/
>> 
>> If that is acceptable to everyone, it is very likely that I can pick 2-6
>> for v6.16.
>> 
> 
> You will need to fix something because patch 2-6 removes `Ktime` ;-)

I'll take care of it in the next version.

>> I assume patch 1 will go through the sched/core tree, and then Miguel
>> can pick 7.
>> 
> 
> Patch 1 & 7 probably should go together, but we can decide it later.

Since nothing has moved forward for quite a while, maybe it's time to
drop patch 1.

