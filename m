Return-Path: <netdev+bounces-139425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8A9B23E7
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3169728205B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C77189BAA;
	Mon, 28 Oct 2024 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX1Ub9hL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB6161;
	Mon, 28 Oct 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730090328; cv=none; b=t6jtkofWCDcAWoYbvMayQXiUuH5uPkxa40YXhS/AXHNDhGjDcq0MSIOKV0LxDwgalzn35ov0vAYiOy22DQe7p0YNQhG8DfBb7as633L2hf4zVzVBWbVUAWtyQPOvNReOxzJ9GostfBbO5IsAOubXBn6iQdqkoWMkYXCKs0BuEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730090328; c=relaxed/simple;
	bh=6o0ifikepTCRcu+r8FTNK3ked3GNiahPcgCyGovyuR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA1HEvkprw0fz4R5s14YDyxsF6kQRKuys/LHFThe5QnRK3YBhwri+R20x8Ze85wxTTJl1DE8vewRlxHgkf0aNG880lZp1GCNcrJERJt4qk7JBftWnwo+msy4z2vyayxq60or2lhf22LKqiN1xuzHB4vXnrVdCHixMa78f3zqOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX1Ub9hL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b152a23e9aso310611385a.0;
        Sun, 27 Oct 2024 21:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730090325; x=1730695125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDsmRV9dxkuLo+lcRi0FmcQocxYesaruu+VZ0yqpU5Q=;
        b=ZX1Ub9hLw9I1GmnLThaddaZ/oe/DWtXLFVcpOfuN1arulLpRvnmaVBY2GhKF4dR+Q+
         KilwCmNMmTjViKNCmLuClW4eCNjQKccPboRDOG9lA2nYpNpyMLto5G3tuJcwzWbpilJ6
         QGJyYG0I6hYN2V6Ecx0B/UpdfSssTDW4mbFmDqTwRcDAx1WUAqWRhDi50HPa6snARNc6
         PucgLoCK7Uf6IMDWCzJbtwKcRRTPEnvR+6InZI2REDvk+nqKFL8fcQWN/fXSWHt8ftS1
         7ngKqCeeLWWt7lzW0qqYNFSIJpMIDhUWRbuAFzUhYd6tV0Xps4hBifI9yoXhwr0iChFT
         hEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730090325; x=1730695125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDsmRV9dxkuLo+lcRi0FmcQocxYesaruu+VZ0yqpU5Q=;
        b=ZlOTHxsz2G9t8M8RSGLNpLNmnAmjeHMElrevi7D5LEn1LdvDCtS2Zj9yVjs1pDZD61
         T8W/9ZDF5bGl0DYRqMeRJ+BxIpQNF7RqgPKdUG1rwkuT2oBfU8SxwpZBGcVbpIpwxEIy
         rwaV/+3LycHVj6hI0tUBj4gYatZ++dAPkVYKKJLk9hoXWeNvr4fmqneBAYuF7cC0LokP
         3tIksC4SaDKxlaASDiIx0L5YcX1FciuDhVaLqwRWl9Ov2FyPiQXVHd6otPg49WPjSS1H
         Nf1Wzt2Fvm/V1oaAeGyh6/hn7I2ZG1if4tsC99roO/NfzlAaCf02yeYuxVzBwUj86nl9
         +mLw==
X-Forwarded-Encrypted: i=1; AJvYcCUBrLNul9MwKrQp5Tv9B7/l+GwO43+M0vma6iE1KhYFa0kXNG7ycF0lXpDejH08f2YkJFZ77o7FTYKhrTj7w7o=@vger.kernel.org, AJvYcCVpcRi+9SzdXfCk8CDMwFWJAN7ZzVu3U6dlRB6KLM67xVnI42Oy0Kaxo6pVOJs6pwS7z4GKb/KYEmUeEZc=@vger.kernel.org, AJvYcCXFig80y3bZLMqXjxaBceN+XwAwyJMkAIb9voQel1EEB3CQuOkmdCtpbdbkQGLC7rX8yPtrcrEK@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1zqaDOkhsjHQvZ6W6FCZpsh/N7oVRDMYekAueKk+xQW5OtFK
	C9Za/LLcaKMrnmp1hxs/xUWuLmHmTNI2noiE9bBvZpF/qKkSNDci
X-Google-Smtp-Source: AGHT+IE95qyuxsF2xxEjB6+YdNWcofW2LrawGJBkPpqZmHRs6TdkANUWXhIfvka29MkA1dW14FSPIg==
X-Received: by 2002:a05:620a:450b:b0:7b1:448d:ea8a with SMTP id af79cd13be357-7b193efa04dmr1116214185a.16.1730090325287;
        Sun, 27 Oct 2024 21:38:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279103sm288003385a.16.2024.10.27.21.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 21:38:44 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id C367A1200068;
	Mon, 28 Oct 2024 00:38:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Oct 2024 00:38:43 -0400
X-ME-Sender: <xms:UxUfZ0ekjiqZKpQ0zK-KICnaYmNZrEMbIGN_5XDbht1i-yth-CY6TA>
    <xme:UxUfZ2PYvZF_1MptfpmJquHXD5LoYLoCnpgcbYGCgcmd3MYpqmFixnw4mIHDzobY_
    JG0ZzELC7rr04T69w>
X-ME-Received: <xmr:UxUfZ1hs4uqP1cCRgR-agJRATvRcxxYH9ej85cI25MmOb2vby63--8My2I8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegr
    nhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvug
    gvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhho
    nhhigidruggvpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhl
    ihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UxUfZ5-dwuU0aTvNRJQOVPCj9wecbIGVzsvT6HnxL1Th6WVWD_UcEQ>
    <xmx:UxUfZwu7URr1jCfX0eDkPs99jimmMKJqGyC6Os01cHzrJbfx6mDsEw>
    <xmx:UxUfZwEi4xs-Tx6J5AKBjJXAx1zvU9aEkSXNRWyzRfn_qi2bc2aDwA>
    <xmx:UxUfZ_Pxy5nTQ7ec3iszebtQDD_Gqep3pS1oEdKOrlZSPWe3Wq8f_A>
    <xmx:UxUfZ1Mj64Xin5sCyHVuXmIxkczonklqg52zmac1waBEaT-TRK_SIr-c>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 00:38:43 -0400 (EDT)
Date: Sun, 27 Oct 2024 21:38:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
Message-ID: <Zx8VUety0BTpDGAL@Boquns-Mac-mini.local>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
 <20241025033118.44452-5-fujita.tomonori@gmail.com>
 <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
 <20241028.095030.2023085589483262207.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028.095030.2023085589483262207.fujita.tomonori@gmail.com>

On Mon, Oct 28, 2024 at 09:50:30AM +0900, FUJITA Tomonori wrote:
> On Fri, 25 Oct 2024 15:03:37 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> >> +/// Sleeps for a given duration at least.
> >> +///
> >> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> >> +/// which automatically chooses the best sleep method based on a duration.
> >> +///
> >> +/// The function sleeps infinitely (MAX_JIFFY_OFFSET) if `Delta` is negative
> >> +/// or exceedes i32::MAX milliseconds.
> >> +///
> > 
> > I know Miguel has made his suggestion:
> > 
> > 	https://lore.kernel.org/rust-for-linux/CANiq72kWqSCSkUk1efZyAi+0ScNTtfALn+wiJY_aoQefu2TNvg@mail.gmail.com/
> > 
> > , but I think what we should really do here is just panic if `Delta` is
> > negative or exceedes i32::MAX milliseconds, and document clearly that
> > this function expects `Delta` to be in a certain range, i.e. it's the
> > user's responsibility to check. Because:
> > 
> > *	You can simply call schedule() with task state set properly to
> > 	"sleep infinitely".
> > 
> > *	Most of the users of fsleep() don't need this "sleep infinitely"
> > 	functionality. Instead, they want to sleep with a reasonable
> > 	short time.
> 
> I agree with the above reasons but I'm not sure about just panic with
> a driver's invalid argument.
> 

If a driver blindly trusts a user-space input or a value chosen by the
hardware, I would say it's a bug in the driver. So IMO drivers should
check the input of fsleep().

> Can we just return an error instead?
> 

That also works for me, but an immediate question is: do we put
#[must_use] on `fsleep()` to enforce the use of the return value? If
yes, then the normal users would need to explicitly ignore the return
value:

	let _ = fsleep(1sec);

The "let _ =" would be a bit annoying for every user that just uses a
constant duration.

If no, then a user with incorrect input can just skip the return value
check:

	fsleep(duration_based_on_user_input);

Would it be an issue? For example, you put an fsleep() in the loop and
expect it at least sleep for a bit time, however, a craft user input
can cause the sleep never happen, and as a result, turn the loop into a
busy waiting.

All I'm trying to say is that 99% users of fsleep() will just use a
constant and small value, it seems a bit over-doing to me to return an
error just for the <1% users in theory that don't check the input. But
that's not a blocker from me.

> >> +/// This function can only be used in a nonatomic context.
> >> +pub fn fsleep(delta: time::Delta) {
> >> +    // SAFETY: FFI call.
> >> +    unsafe {
> >> +        // Convert the duration to microseconds and round up to preserve
> >> +        // the guarantee; fsleep sleeps for at least the provided duration,
> >> +        // but that it may sleep for longer under some circumstances.
> >> +        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
> > 
> > If delta is 0x10000_0000i64 * 1000_000 (=0xf424000000000i64), which
> > exceeds i32::MAX milliseconds, the result of `delta.as_micros_ceil() as
> > c_ulong` is:
> > 
> > *	0 on 32bit
> > *	0x3e800000000 on 64bit
> > 
> > , if I got my math right. The first is obviously not "sleeps
> > infinitely".
> > 
> > Continue on 64bit case, in C's fsleep(), 0x3e800000000 will be cast to
> > "int" (to call msleep()), which results as 0, still not "sleep
> > infinitely"?
> 
> You mean "unsigned int" (to call msleep())?
> 

Ah, yes.

> You are correct that we can't say "the function sleeps infinitely
> (MAX_JIFFY_OFFSET) if `Delta` is negative or exceeds i32::MAX
> milliseconds.". There are some exceptional ranges.
> 
> Considering that Rust-for-Linux might eventually support 32-bit
> systems, fsleep's arguments must be less than u32::MAX (usecs).
> Additionally, Because of DIV_ROUND_UP (to call msleep()), it must be
> less than u32::MAX - 1000. To simplify the expression, the maximum
> Delta is u32::MAX / 2 (usecs)? I think that it's long enough for
> the users of fsleep().
> 

Agreed. Though I'm attempting to make msleep() takes a `unsigned long`,
but I already have a lot in my plate...

Regards,
Boqun


