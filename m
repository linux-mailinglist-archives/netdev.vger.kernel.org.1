Return-Path: <netdev+bounces-134884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8281899B808
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 04:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7992832E2
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 02:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202311CBD;
	Sun, 13 Oct 2024 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODR33TDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C0EEA5;
	Sun, 13 Oct 2024 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728787849; cv=none; b=dxxIbMmnVAQSKchw3TozjPt3fkbsBz4zKNcgWGX300HF4pyGxtH4l5TH2ERFSJ95+4FM2TDtleuAPNdRTxPFYuEvsZuEfJzIPYG9WXkyGqrPUxsn6zaG7Q9ZlGK9QxGSFXL5oZeSKV6pxXjEvqRPCY0ThlYFBQyEaJ8QalQ7UHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728787849; c=relaxed/simple;
	bh=E5TURq1Z0LIr24E5z6qg27kYNYRDrW0uZ7qPQHWopXA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ROskMGMcGKC2gD3AduAio0eFnz0BLa5+HX+nQ/BOfC/WU6Nm1sAnFgoNF0/DaLI14Dz3H2MjCx3zHbXhVSzoReRddZd32rBLBjum2NtW620JIYXvz5iVpETbUd4/qD46O7PSVmZmeW4RyjC5Zvovlg4Cj+ZabLrKXNsnBJulBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODR33TDg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20caea61132so14830265ad.2;
        Sat, 12 Oct 2024 19:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728787847; x=1729392647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeGei88W0+d0BSDRcP1Zoi2PZ0WBm9nX2s9IkneDJLo=;
        b=ODR33TDgjs4PX34+43RC2pBOAQHXUyVK7wBKv26PLsKzvrEuLtIFC52bXM0w+qo8pn
         66d9v4x6AdYDkbEareHIZSaEKA9DxGO3FhWk5J9Zua20Cokvj/xz8XyRBxpytDZQfYhz
         iXT1XV3zJ38lfwsgkukPAIoPun5MXMrGMSwitljfRk5/C7TC8pEbVsOpbXBRlD7rGKzu
         4Pc+M2DyacB15RoPP/IHAxyBw2gj9JwoYFbbBFbap8qRT4E8sHF5ZYwPAFo1bCRVzMPl
         0Y6QNO1yqnQ2ueeKl/GNkE04ojQIF7HjPd4jf7EZBtc/hvWr96xFBBuILmwwvUWwOW6Y
         /WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728787847; x=1729392647;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VeGei88W0+d0BSDRcP1Zoi2PZ0WBm9nX2s9IkneDJLo=;
        b=KlxecFTbGq8h7AEEUDwxGhRK3POb4PdsLKGqkktH+4ODq7Q/pYBwswZHgT5iyr7SBQ
         A7XjWWXdHZ+gPWeEUBvOMQrqxYYdlEQfZ1p6T3veguFZ1PD6xD+wY1erie7ZQzWHrdxu
         3toDArYxN81dPi1u2Zqi28o9a4UQ0sRdGyshV/MFKS7sSkLA/gQPQgtQrzeJKWyyfXaA
         15W0/lfcHZ278rCWehwqSUycXTEaZvohTxhGBWHqIPD65bUAwniobgSLJnJdLq7mRPzF
         KCwNJ24l0ofU4aB2ExGkSUBkrQyG+hKfmIsxJ3jTo4PIAmpgiR3s00SeucLyszxGArbT
         24IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEJdIvCucP0fH8qddEz2gjGnTf2xK5k950WkGBHDJW6y8+XkryhWdgx4PMgr7mf6+9OPRV/UhM+gaFVdG/94A=@vger.kernel.org, AJvYcCWzZc57yqpf2lEVvQUbfhbzI4CdmfddUZqgAFumB/VjpY7PXAmdHqMr8wL1goOK12GNk1AKGKCC4z7jpEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRjiUdAaW5s2sp8ozaV4BnizXrYSoJMvBeThc6MvthhYKnsHr
	IulArDwjS9b8y4ZUaReLnl6GTqx3f0A8I5vdbEuqyhBz7uHCGJIg
X-Google-Smtp-Source: AGHT+IHhsFI+4eejxmbr1CmXjB+a7lHQcnFIoSpQbAGd/NaOoRW9hJdwzeCziaVS5gCEfaDjn1P4SA==
X-Received: by 2002:a17:902:e852:b0:20b:861a:25c7 with SMTP id d9443c01a7336-20cbb2a120amr65338275ad.54.1728787847345;
        Sat, 12 Oct 2024 19:50:47 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea706393d7sm1350342a12.51.2024.10.12.19.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 19:50:46 -0700 (PDT)
Date: Sun, 13 Oct 2024 11:50:33 +0900 (JST)
Message-Id: <20241013.115033.709062352209779601.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, linux-kernel@vger.kernel.org, jstultz@google.com,
 sboyd@kernel.org
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<ZwqVwktWNMrxFvGH@boqun-archlinux>
	<20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 10:15:05 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Sat, 12 Oct 2024 08:29:06 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
>> While, we are at it, I want to suggest that we also add
>> rust/kernel/time{.rs, /} into the "F:" entries of TIME subsystem like:
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b77f4495dcf4..09e46a214333 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23376,6 +23376,8 @@ F:      kernel/time/timeconv.c
>>  F:     kernel/time/timecounter.c
>>  F:     kernel/time/timekeeping*
>>  F:     kernel/time/time_test.c
>> +F:     rust/kernel/time.rs
>> +F:     rust/kernel/time/
>>  F:     tools/testing/selftests/timers/
>> 
>>  TIPC NETWORK LAYER
>> 
>> This will help future contributers copy the correct people while
>> submission. Could you maybe add a patch of this in your series if this
>> sounds reasonable to you? Thanks!
> 
> Agreed that it's better to have Rust time abstractions in
> MAINTAINERS. You add it into the time entry but there are two options
> in the file; time and timer?
> 
> TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
> M:      John Stultz <jstultz@google.com>
> M:      Thomas Gleixner <tglx@linutronix.de>
> R:      Stephen Boyd <sboyd@kernel.org>
> 
> HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
> M:      Anna-Maria Behnsen <anna-maria@linutronix.de>
> M:      Frederic Weisbecker <frederic@kernel.org>
> M:      Thomas Gleixner <tglx@linutronix.de>
> 
> The current Rust abstractions which play mainly with ktimer.h. it's 
> not time, timer stuff, I think.

Oops, s/ktimer.h/ktime.h/

No entry for ktime.h in MAINTAINERS; used by both time and timer
stuff.

> As planned, we'll move *.rs files from rust/kernel in the future,
> how we handle time and timer abstractions?

Looks like that we'll add rust/kernel/hrtimer/ soon. I feel that it's
better to decide on the layout of time and timer abstractions now
rather than later.

