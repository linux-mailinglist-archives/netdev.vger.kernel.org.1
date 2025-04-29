Return-Path: <netdev+bounces-186833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87134AA1B3A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FF49C0C1F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40E259C9B;
	Tue, 29 Apr 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjuM9PTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B28259C8B;
	Tue, 29 Apr 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954050; cv=none; b=Xil2Vp8ORCx5WQICNeUZt7TCiRaWHzqHQe24YgYUtYKlNtoElFQSP5wunbu1RBalHd/e7VdKpnRvL/9R9ti7giWNDovHWcD2xZW0U9cQieZ0wtnNJbEEa+3NIwHyMx0Ga1UJ2fOaWlRs93o2JgJ2c/ZdLxZ8JHvVxiOOao2yqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954050; c=relaxed/simple;
	bh=bXMh2cJRh+9ydETl6x40GBlZQ5pmvR4iwuMwvvfSNzw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIKFbcPdaGXw64Fz4EEj7gxljeDTQSg2r5PHPo1ZWnTi6n+i8ahBL1ScMeU9rxYbfCkEQ8Fgy5TPYn2wPfiU7+Id8YCdPRFMa5pMf7Q6GomZv/NZPOWCeHOvEw2Ufh93RjqVppWqLN5EFMALx3oNs4qzUS9Fil2jiuD0QN3qDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjuM9PTV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47ae894e9b7so139113531cf.3;
        Tue, 29 Apr 2025 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745954048; x=1746558848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwoYbphLMOzlYBJwgvrvLEBsbX7HMccyFEchsF8fvLs=;
        b=KjuM9PTVM+N9s4Dr3RZxCD0TOm+EmwXUg9B2KizMiwWigb+mdT4ilS9X2LxFb5gs/f
         MDWBN+0T4zzReyiGRpBjqNQTQkLEZIJAAgj+gPYHzho45y118C/LxgitDrHuM3S4JOZ7
         iJNYOlvsLbc1dio2gBUhAXnhLZE02hPCTFbfEbD/rHIGU/SuC3lJf05dltCB+yllHFWM
         5OCgBGVvE3eyISZI4o22EbX48ZNPyybBqeyHpRZbQ39ItHtz69JY9RtaT/W/1XKewIEa
         kYfzG1uGPSJXYgFWAnHWzNIWL/7JtxeZGlTf1U/oTUKhtRVIHx94migg6UuwGS5mySXk
         eHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745954048; x=1746558848;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwoYbphLMOzlYBJwgvrvLEBsbX7HMccyFEchsF8fvLs=;
        b=VD3zETXf+CLRCQdDHEdJgx03Wtn0ixrPHsUKXhThAV8wloky9Av18mw6lAET79Kr42
         dccw5YG9HHYBgwuG6zV6YoYIXJIXA2J9pFh58hzqxLi5FrzfElXMsv18KT28FI07OxJz
         cztZ0w/Q6G9VvW+5C47scFCl+uYYUX/A6xHGzFue/oTz29+EvrnAZwN8BR9kGnpKOLjq
         26ZOjeIKz1oh5MHmnltzRhqXob8O8FPE1DxNX1nIdb5YsYqbdTKsgAHQ+TDHmurrGhiW
         vo/Wxli8kWFTIHdsH6SQYfmBnBNQoG5HqC0Uy2NU078ZqWTit5PrOjqay3cdPgoXfs61
         qORQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzLPvdBRU0X6/vBJ2cKFJMolU+1YkKNWH0Eo9lJUQaXFWxJr3G8vZKMrBcpoPUHHrO+7rUtWlJjPjQ+++Dp3E=@vger.kernel.org, AJvYcCWz/n2AC5dSG3WDHDBwNnfsGOZ+TNolcWNeGA4vvmdbpx0HzGrRwaA3r3s4aaEarWiWQ1w78gX5@vger.kernel.org, AJvYcCXxc4ngra7NBI58/mY66WLjASW//XKKTP1dUB17KE5/7gSS3K/1Ke+4K18QV0WERwu/LZWFWl+mxaORDWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywRCUBUARxogxEQJaRpTDp9hw3BWqTog5HpEj8sIn5VudB0K4M
	vNm/B6KvmBKpKki/WPbO4kum0dHj2BLn8H/2Wai5CLIQ9RY5+1Tk
X-Gm-Gg: ASbGncsmRiJpe1wMLFliiEfyGygAyhzJB0jlm0ipaUGmF3zppeuowiaZpLKHzpHbWyR
	yLNk2OF8AH88NEchBWjMbyg6LwnkUmjjYNbxWCLUfQLclSpK8DqZ9+Z6mGBYSRgppD8shPiMNPW
	gd7YnIp6yTk4emefcoDtogxA/gbXMQM8Sz+QfFmgKp+gjFCg8JJiWsXRaqy0gCgTKriROn14Ajg
	ntdDlZENDSg4tKLoa85GLew6G7zFieWoJE/NhF7crcj6REuj512KnoOeey2rnhwkGnN+3UpGzHj
	p/i/6jrcqbrldVXOnwzxvMooe0+J0G/MAlQ7z4NxcyGTFcaZs06iHGDwO8IdOMe9vZ7C0vUZAKz
	pRu4ZZglb3Mv9c0aceKo86wNn9ygh+YqFSM+MZzmjow==
X-Google-Smtp-Source: AGHT+IHeDwDlPF3YwPfErQhp2D37bSRCWAUH+jLiRDa0yriSqvagsDhgnP50TuvKGU2I+T33zaL6oA==
X-Received: by 2002:a05:620a:6892:b0:7c7:af68:b6f3 with SMTP id af79cd13be357-7cac7614721mr50402185a.33.1745954047779;
        Tue, 29 Apr 2025 12:14:07 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c94880sm765528185a.14.2025.04.29.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:14:07 -0700 (PDT)
Message-ID: <681124ff.050a0220.13a0e7.2c80@mx.google.com>
X-Google-Original-Message-ID: <aBEk_KLf4sYQLPq5@winterfell.>
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 836E71200043;
	Tue, 29 Apr 2025 15:14:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 29 Apr 2025 15:14:06 -0400
X-ME-Sender: <xms:_iQRaPnrF2yScFZ6Xn-3psHmyZVV3Wb_VFz8rHE4ynHupDujBjbPLw>
    <xme:_iQRaC1Ls0PQLt8SLHYN6vPW6Rb0CGAmSMC-lHh_ntAUlMB8RQfPrOp0aC-gCa7py
    drpFGkTBxruisTX_Q>
X-ME-Received: <xmr:_iQRaFrIvTNnHZM-sbCsoavjEQO4Z_q5wFV4DGidQL-F2QS3FBE6xs_CzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehfuhhjihhtrgdrthhomhho
    nhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehmvgeskhhlohgvnhhkrdguvghvpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiug
    grsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_iQRaHmWqo1hvyjGT_eQCQEeT7870HnDEAZca3-3Ecm87zpYjHzUQg>
    <xmx:_iQRaN2LonZeX9wwsMXN_71KmG3x45OgSQlnactdoA7BtWY1cOJHug>
    <xmx:_iQRaGu3gKP4egsnb46tbp-3mLSmmv1YfHTXHdUW95eKUzWxN8tqgA>
    <xmx:_iQRaBXM2ZWJWOVrCtrFMI9RzUobdS1JFnUm8cSz6vxduXHgZpImbQ>
    <xmx:_iQRaM2PI933QEFU8-gho1PZD8PL9KK3oOipSwHeX7WhioK8Kn2plkYX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 15:14:05 -0400 (EDT)
Date: Tue, 29 Apr 2025 12:14:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,	rust-for-linux@vger.kernel.org,
 Gary Guo <gary@garyguo.net>,	Alice Ryhl <aliceryhl@google.com>,
 me@kloenk.dev,	daniel.almeida@collabora.com,
 linux-kernel@vger.kernel.org,	Netdev <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,	Heiner Kallweit <hkallweit1@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,	John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, tgunders@redhat.com,
	david.laight.linux@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
References: <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
 <de778f47-9bc6-4f4b-bb4f-828305ad4217@app.fastmail.com>
 <1b9e8761-b71f-4015-bf7d-29072b02f2ac@app.fastmail.com>
 <6811092a.050a0220.27f104.5603@mx.google.com>
 <2d89292f-b02c-47b1-9299-92c5f4ba4c9d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d89292f-b02c-47b1-9299-92c5f4ba4c9d@app.fastmail.com>

On Tue, Apr 29, 2025 at 08:33:47PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 29, 2025, at 19:15, Boqun Feng wrote:
> > On Tue, Apr 29, 2025 at 06:11:02PM +0200, Arnd Bergmann wrote:
> >> On Tue, Apr 29, 2025, at 18:03, Boqun Feng wrote:
> >
> > Would it make sense if we rely on compiler optimization when it's
> > avaiable (for x86_64, arm64, riscv, etc), and only call ktime_to_ms() if
> > not? The downside of calling ktime_to_ms() are:
> >
> > * it's a call function, and cannot be inlined with LTO or INLINE_HELPER:
> >
> > 	https://lore.kernel.org/all/20250319205141.3528424-1-gary@garyguo.net/
> >
> > * it doesn't provide the overflow checking even if
> >   CONFIG_RUST_OVERFLOW_CHECKS=y
> >
> > Thoughts?
> 
> The function call overhead is tiny compared to replacing a 64-bit
> division with a constant mult/shift.
> 

Just to be clear, are you essientially saying that even in C,
ktime_to_ms() is not worth inlining? Because the call overhead is tiny
compared to the function own cost?

My impression is that on x86 at least, function call is 10+ cycles, and
multiply is 3 cycles, so I would think that ktime_to_ms() itself is at
most 10 cycles. Maybe I'm out of date of the modern micro-architecture?

> What is the possible overflow that can happen here? For a constant
> division at least there is no chance of divide-by-zero. Do you mean
> truncating to 32 bit?
> 

I was referring the last part of Miguel's email:

	https://lore.kernel.org/rust-for-linux/CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com/

Regards,
Boqun

>      Arnd

