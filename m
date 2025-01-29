Return-Path: <netdev+bounces-161570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F8A2270B
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF675165B46
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80C1DDC22;
	Wed, 29 Jan 2025 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgkciRK0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42AD1A2398;
	Wed, 29 Jan 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738195017; cv=none; b=IrGGJCE7GJpHHJ/8Xaea/QgF4IrO0hngAqkGxVEXzAVXAMFmhSwk3Rz3WMtLQ3sZLc4Hce+ADXiSIlZZOh0x5IMs0hgQd3NnfNuyO2ur1l/fXx9AtadnqXCSALqIa+XiS0v9mIrPwnoHsNn/NeWSk04x7yHnG+IFVIbSex8UXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738195017; c=relaxed/simple;
	bh=CUV6idxLMiMBeotyTkobqVkSejdUQmJ3omLElEEXwk8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HGjH52rkBzFz4dj1+Z/T7b4Se181Pyh2R9TJ+FZrjkH4/ndflAvQ4Z9TONIzgS8Y2awtNjopwUoVSHStEn0N8Iu1gvVEELDZIn4w/T/Zx1XAsgrJKqBe1Qy7nJ+GCzJsXDaCZmqplBfs1hFGEmP3Rvsfly8B/dhY8WLv4+sHCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgkciRK0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21649a7bcdcso3281075ad.1;
        Wed, 29 Jan 2025 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738195014; x=1738799814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHWUEFLBFWIm/AfPLL++N3GkQDYP6DoVXgxmhuGsEuM=;
        b=fgkciRK0MxY/frtPwkOeSr9zX0osZPCS3RXbISKxPjPkTWnyN2hmBWEaVZH6OoMKAe
         xJvAWebpRbZDGNKmjZEjNMJSMEwy2/5AsLJEYU5UOncD444vXWKTQCmARJvGZ/4HF5cF
         cCr5YfrqXMUQKmFCIHotOSok3ajR9t4+Wxig/inFEtsIkZ59xtnLn0CNlRvh/O9HR0Gp
         WYdx3MD220B8t+ZCwzl1TgKr7WzwOsyfFY3H59SOWgx0aiDsveZExI31nyRBbeHlZhTy
         R04UzLpyUM6bINWYqsM/riWy8WwX5DGRZCDG13K9Z2bGbjGVs7+Mx6zojy87q8y+TZZ7
         W7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738195014; x=1738799814;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHWUEFLBFWIm/AfPLL++N3GkQDYP6DoVXgxmhuGsEuM=;
        b=sYWDn4DltSo2/npFneRoIR2qiakqSPvwpnHoddqFmcyMWNRvI+p1M1gSv5dQQuryRA
         DQ0b/oCdecffs0ktC2h6X6a8g+qGdB++IKX2qepa5ZNGduFeBSppbyBkBoII8sXT6DWf
         nA9eTHEBICZSaRPSFWPi1WEftnuHbeuhjA4tELGVeru/MdWdcl55tzRlM8XMsTbr9SgN
         OWDGjugSSwGgWrgbzSqW5HwEdSlhyAQcsYTUu73beSKfB0QtSEO9i2Oqrq5SQ+wVM4f3
         HivIqSVPiHl2OVMjyMElVZBYez2mHdE55BNcxtvSf4pl6YC+DnvPRQwotWk+WSd/DDSG
         2TiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNOTOfRJ2wS9Hw+x4YBztDtYz3WFqJjyrE4aO3dxZknw6S1aLrtCdOAeMTXCdfFY24sSuT8l7l@vger.kernel.org, AJvYcCXb4B3NuYFjF1eOyF7LIzyHp6CRdFN9JKGhJo9zVE32fXk61PH/xlW4wYSGnbnAwCrh4LsmtwZVP3Lyvd8=@vger.kernel.org, AJvYcCXtxq6+ZkXkmc4QQOC5zXeD2+vV8iTa2MRGRmuJZsy464F3lsKjQGQ49cDPn5kU2UTPquAFc/kmP6cJAXxjnsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4wV3d0xe5MWuahBls1eqIN6TEIwi94vhiqbnb/b72DLxOJuU
	H6kuK/9B5DRLWkr2NZTRoBja/bpUKc9uNPoQtUNU/Byy/Pme+Qge
X-Gm-Gg: ASbGncuMu3IQYgmuhdb9NNbdl6fiy41dmzH69IBTMbDpp1+Wn0jeJn2kTfgfOcDMfh/
	K5a/DyVrn/QnOTqmYo90iYDOpRQQ+XyvQ5s774LMN2zT5jXXZdpSDn340jLZL6Cdo8PZ6Gr4fZU
	qmzG3SKZaYfR0/ocJMCG4dVCfby9zQBfiJju8HlUiXY5TbqkColKFT80nxeAdh9iRyHcIGQSVLF
	5tMJyqQCCh3nLI/58mKNeiPKOd9E2q5Pery/dbpc3UVP98VwBqRTpCjjvUp3mssSJDSld2M6Twr
	0E25L98QwAmMiM/KXG0wqu5g0beBsUVWROkMA9vdlWbbNdqoAAyfkDWwqd4ZagueJ64Bu38Y
X-Google-Smtp-Source: AGHT+IEqQHqIq3nQXCLQ1vzxdYZ9/MIsGlho7lL+QRLnpBBE205Ui9H7sSwJ72ErcpH3zk5dJUcvKQ==
X-Received: by 2002:a05:6a00:4642:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-72fd0c02ec9mr7271441b3a.14.1738195014049;
        Wed, 29 Jan 2025 15:56:54 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a958sm58138b3a.172.2025.01.29.15.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 15:56:53 -0800 (PST)
Date: Thu, 30 Jan 2025 08:56:44 +0900 (JST)
Message-Id: <20250130.085644.2298700991414831587.fujita.tomonori@gmail.com>
To: peterz@infradead.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 1/8] sched/core: Add __might_sleep_precision()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250128113738.GC7145@noisy.programming.kicks-ass.net>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-2-fujita.tomonori@gmail.com>
	<20250128113738.GC7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:37:38 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Jan 25, 2025 at 07:18:46PM +0900, FUJITA Tomonori wrote:
>> Add __might_sleep_precision(), Rust friendly version of
>> __might_sleep(), which takes a pointer to a string with the length
>> instead of a null-terminated string.
>> 
>> Rust's core::panic::Location::file(), which gives the file name of a
>> caller, doesn't provide a null-terminated
>> string. __might_sleep_precision() uses a precision specifier in the
>> printk format, which specifies the length of a string; a string
>> doesn't need to be a null-terminated.
>> 
>> Modify __might_sleep() to call __might_sleep_precision() but the
>> impact should be negligible. strlen() isn't called in a normal case;
>> it's called only when printing the error (sleeping function called
>> from invalid context).
>> 
>> Note that Location::file() providing a null-terminated string for
>> better C interoperability is under discussion [1].
> 
> Urgh :/

Yeah... so not acceptable?

Then I switch to the implementation with Rust macros, which gives a
null terminated string.

