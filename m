Return-Path: <netdev+bounces-158862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E784A13966
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F4D3A698C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C11D6DAA;
	Thu, 16 Jan 2025 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD/XW26x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022824A7C2;
	Thu, 16 Jan 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028176; cv=none; b=ALxthYr/gSzVBNusGNoADgwDhOZ3i/9AnmOyu1s1G2PLakV/4ox1rBbbK82mdxsnW1ha+ZiNDE1wTqGDbcV7nTSvdedMx9U8Dd8V0SL7b3pCwYLICixj2ST6lvDID6orJgKl/3PVKYOo+pJWn4F0RRZZnyLeuSXArgpZP+TGnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028176; c=relaxed/simple;
	bh=dGCCs0wZljmzF+WoZHjxEVm1mblSgrgaAI14RgXrxyg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oE3NSTVXboXU0Qiwd0IjqXbv6ZBD7ssDslfx0NS9kCikJvHr1zmnzE8aHyKUQzwm887cEWAQcKBYsQwh1HwP994u4kURmxqM6KtVkRcP258mueeyGsdy80BcK/UVRgj2L7AOhd3YRItHl5rf0Tz2H8uHJO9HJrB9tpBVAmnbxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD/XW26x; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so1207212a91.2;
        Thu, 16 Jan 2025 03:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737028174; x=1737632974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgM6c5VN8iYPpN/9zUMPAKnu4jX/hwo/oYFrBgCwh84=;
        b=dD/XW26xh7ZpftBOKXK6H5V9FpXZWz0mHCn+A1mCyfmdc2QMcwPo9vI5SOoprAv+Um
         Y2F8fOrf/UeqLYvtLwYoCuIOfAWiFZlddzd6FZExHYKB/LnGViCbn274G/nW3FZtl3Lb
         +BeVkPwjaZL5X4G6LbmXg3xEhd4VHNhoF1Zui1mTIkOzLanh6DRpnNRHxF0fWkEYYe70
         BoFYsvgp1K/uQfEilr7V777i9fcVYS6u5KDgD9l7tvtVT1z50w5e+ZzrG/ijDKvNFC5+
         d6e7JsEU+W+UDkDKBVij+Vj9k5z1uoxYzD1WM86zION4RCIGPdYXD0L8T9+KebxodjR6
         JKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737028174; x=1737632974;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MgM6c5VN8iYPpN/9zUMPAKnu4jX/hwo/oYFrBgCwh84=;
        b=t438YXbE53vNARNynns2d7BulnB1cK5mslWwNPz3bFJaWt8+HYjXZsWrLlucQS240f
         AZRgzUClsG7Knt5vu7KElkfFGAC7r77pBHBusQja5evkwGq7zbw0yYRR2qNNgikrldVH
         C5b/xWsTs2Yreb+wo15x+7UU4Ae4oXLI4Gfh24FfRC0lZstosRid+6l6yHCVh5DznNgE
         K4TH514eRoAzCDQVBUP6TTcUqUaYqsRVe9GP07BmkE6Gu9QT6SI/+YGV6mjlkGdRfJxJ
         cJaQ74Np2IpZCLKRIJW2gTRxTaOtWnP3HAJw9NhfdzHTuOCJbHklRRYvU2dZnuiqWPs/
         2lpA==
X-Forwarded-Encrypted: i=1; AJvYcCXOPZompv6MRvwfbN/yL8JY5hMP25sWsw5qotGpba/DbH4ozKWtVyquj+atnsilI6udz4fhI8JH@vger.kernel.org, AJvYcCXpaPkutX2tsDcVp3hsWzXbk54XUcdZtKjn/OYk12B0xJmu3QHboI5gZa8lvKIDfFRPCa2pkFJKPp725A4=@vger.kernel.org, AJvYcCXz9fE0w+7F46QjOrQovYVmljiGivvwe239qFvSYkPGAwBhAHaF2/+YyLDUpirO2ZBFHum+XHlBsZVvgFZvWeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQHLQ+uXHsRigGa2J/OOXAUa1HvA2MDAFypWcWEj2issKVp8M
	ZM8I7nAPaXB2e+ZvGdQEg6xLZ9mWDk7SPgTRWkyC9IsamzZ/nr1L
X-Gm-Gg: ASbGncsDQ7aZIwuUAXPQH41bK+sIoNLprm/iB7eZLMUvnhA3gN3A8d2wF9kQsrRfYTP
	dTGtZAhSiSNfRxPrJwBae5bnItIjbHt8Wsf8iXJ4TBpDCEjeNCrm18QapZ9Jd1stuyZ5rJAP627
	ZuXyh3Sx2eyo+GJces96o2BOqFDv2biHhA1y2iVzVL6TTzS2KfwU1MjRbVPDUqMwJKY07d00DoQ
	tb+IDe3QIM/DbvCe1ymwOT6LGXC6vwVHJyv/sQXTSsDJ5ESQIDUISnFG9xPiQnQ7H6tb3Uvf0P3
	fIbfkj2hNxvjCr1lQ3+O/rpcqdlOnP+gxbi5CA==
X-Google-Smtp-Source: AGHT+IEBfXT0HtMfkQVT0nFAjlNbzqIzXFA/zdzKTQdrGqEfkabMVAmFFj54uC2VMiE0tbSt+mgtyw==
X-Received: by 2002:a17:90a:f94b:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-2f6d266fa49mr29618473a91.2.1737028174252;
        Thu, 16 Jan 2025 03:49:34 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c15012asm3099701a91.9.2025.01.16.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:49:33 -0800 (PST)
Date: Thu, 16 Jan 2025 20:49:25 +0900 (JST)
Message-Id: <20250116.204925.363421369123965269.fujita.tomonori@gmail.com>
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
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLggF2oXV=p5iO7HvEOitd38XxNnKhZuinhk2A=OdmVfuFg@mail.gmail.com>
References: <CAH5fLgjoAzv1Q0w+ifgYZ-YttHMiJ9GV95aEumLw4LeFoHOcyg@mail.gmail.com>
	<20250116.203224.774687694231808904.fujita.tomonori@gmail.com>
	<CAH5fLggF2oXV=p5iO7HvEOitd38XxNnKhZuinhk2A=OdmVfuFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 12:42:57 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> If so, rather than adding a Rust-specific helper function to the C
>> side, it would be better to solve the problem on the Rust side like
>> the previous versions with c_str()! and file()! for now?
> 
> I would be okay with a scenario where older compilers just reference
> the read_poll_timeout() function in the error message, and only newer
> compilers reference the location of the caller. Of course, right now,
> only older compilers exist. But if we don't get nul-terminated
> location strings, then I do think we should make the change you're
> currently making.

Okay, let's see if we can get ACK from the scheduler maintainers with
your version, which has less impact on the C code.

