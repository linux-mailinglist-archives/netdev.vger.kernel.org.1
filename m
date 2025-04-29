Return-Path: <netdev+bounces-186805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2290AA14B4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1991BA6D20
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA025393E;
	Tue, 29 Apr 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAKnOquk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD8253354;
	Tue, 29 Apr 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946925; cv=none; b=saTU7ckFyj4ijoU+Vfl3LWRIjvP5/4TSlVTM6cj+qRTAR2z4ITv8HwQeJtuY5O8uqltnnznyMHUSyZE8WsbLbiyQtH9lr5CcYjmsrGr4AlA8puOzNmR+tylQE3+DWwGwq3ygl2rlll/5y+PDLXscUcCOTDts0PwZvFbo5R70zXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946925; c=relaxed/simple;
	bh=J2dDK33QVlVsGOMfWBz/CSOixKepXiTCR9mMLhsRO2E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msqjUrKVKnuVN4G2Sqn+Pow/+37/MNSKs7bB95ZAV5G/3bBRmLOwTzjozgs9b/2dWX95qXFWzGgbmSP4j91cQkoIOl5WWwbXtzp6W18r1k15xv3JmhEds++XT452fZ6sQaqocu6xhTGRACaOIktxqiPmctV+FdBbyeaj93WcGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAKnOquk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774ce422easo76493741cf.1;
        Tue, 29 Apr 2025 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745946923; x=1746551723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XqCfwz88Yr+Nnr1Fpu/NIeG2sCG+K67kbeALk/yJmQ=;
        b=lAKnOqukofR8irEb1/vnwUul4Avflv0oFixqzp9BNlUU7uLGOtiHQrajSKF4OOAxtZ
         f/GeFNoQjr85osNoYjnDnnkopKJ6y4yU7qpaYF3axmSus686JOTHhsUSnXBZssT49CWe
         I7+vJNzmch/z9I/leXymOHaSRJPXwPy2OGGeBi3/TwlgsczyaTNWAyYIcqtij36u3PnY
         UqDX79PsGdJgRLs++FVpJEM7u/xvBQz/JqkPmi7spq1vEknQoWibTXw6+MhymIJvdfaM
         RBWOAYohEBUf1J2XUbkBJXgOeJXbbdX+vu+d5YlpTGQ9+5A07CZSv24t7DTXprZhS9Yp
         VYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946923; x=1746551723;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XqCfwz88Yr+Nnr1Fpu/NIeG2sCG+K67kbeALk/yJmQ=;
        b=n61/BLnMdpOyQCW5xkLMAl79jyMfu/Yn8wnRl2Olh3o3UPMjFmThXNo6uDAgWU07FH
         R0MLMHNCXrYMDIIuTDj/3gCLXILeQg3CqXBwYsxVlBi9wPko1AsUrIjVwD+2n5PPBTN9
         820e8p1+fu3J/XgjxLhXgp/KNmjw7EAqq5vIXdY7MPw4heLPbJMWLwYAW4zgunbM/uR2
         BFTP2PnGrSuM60a2T4OqRTRUfkwQ3EDXJDmENrp28xtyejojYejbxyeELczJ5cHsHJ1K
         n1avDwcI4JvtEcWc+tLt631/ORlZuUyxJsrbBDVFZdZkLK1nSQ4wmigd7ggFMgv+j4Ko
         ajRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7mWpX4wx/UXliWdZc6TZ1F8HGmBbMXb5vi4b1g41FhgiEpAQFLkPBtVAtAh70cYPjkUQPOM9q@vger.kernel.org, AJvYcCVg/12s7jS/9IX7GEQFRb510cBTUA2qM2HJHSYFRw9t3niTDmPcUrINO8P6zqY+h5LGvEvlIVIex1EbpLR9JXc=@vger.kernel.org, AJvYcCXZ0woYEXey9RdLjD9blXJ0q0EMDmfKM2F/i5gzAYo9IW0LYAQojnNuRQivk4CNTb0UjBOQL+o7HP+wNaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBsq5joVd41HSl0OyD+2HcuirjKGD27FajDFD1fbnOnQPUaBHd
	v5mdB7sDqas+giagJPb4ydnAbmD/LCX+PsqPZnfzRAkHvyGrX5Yl
X-Gm-Gg: ASbGncuZtq9XZ6M18saoxRInbZS0PUqj4fN4dKKpDGAUurQR4A+QtGJGb128Un5Ma2u
	WXNaEQ9fuXI6ZkYRnG9spH+/JAFeET2bK6GJOITwqVVyj9WuBJs2TZkNmqLgsAWKE5xsc/Wqkhj
	x396UIbH4WowV27xop41Dq/r4ujb1aLH/pgWWAtau//2lp6o2AWcJwSzGTn0bxdj1iL/SjD3+K0
	jZBBzoChpSr7cxeE+as27DMFZCyEhu67Jnh4+9LFuE7Fy+nKKu6lLisLA91hbwrZwtsuY7XkGq6
	xOTYKtJ2Rrqy1h0W1vnQDuBV9qJaTYnO7bY53Gvia8e+UcYJ6MoehRdXJ4EUyyvCGM0SLSSE14t
	O2enD3NhHyvmZUA0/FBYTzRAGYDF7HcE=
X-Google-Smtp-Source: AGHT+IF84CyHlEuo5GJQfLI/neYy1T6WPo9fcqPp+3+2ph4jT5u/Vsi4HxpHyDu/W1EES00OqZBfwQ==
X-Received: by 2002:ac8:5755:0:b0:476:c656:4e80 with SMTP id d75a77b69052e-48132e8c0c0mr250826151cf.34.1745946922788;
        Tue, 29 Apr 2025 10:15:22 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f0cf12fsm83203531cf.21.2025.04.29.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:15:22 -0700 (PDT)
Message-ID: <6811092a.050a0220.27f104.5603@mx.google.com>
X-Google-Original-Message-ID: <aBEJJvS2enY0Icns@winterfell.>
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 59C111200043;
	Tue, 29 Apr 2025 13:15:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 29 Apr 2025 13:15:21 -0400
X-ME-Sender: <xms:KQkRaFcQssbYdF8bXv09rQ4_iEt5Q-K1E1w4yqGS8NbXMFUdtEGTUQ>
    <xme:KQkRaDM7qV6EUXGZCHlXWQnK4w7G83qBj3ohjV4YSTqD7qxNo2Q05WFifmpOmYGOr
    QADgsrVGIIlMJXtGg>
X-ME-Received: <xmr:KQkRaOheoh3HJ9kI-Ao52G9j0JWs1v5DJ9eIPxoAUzDWlcj0G3pz0XCxEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeetgedujeejudehveekteetfeefhfffheet
    gfeugfetffekieetiedtudehgfffgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgedtpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohep
    fhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegrrd
    hhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhr
    qdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegurg
    hnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KQkRaO9EKnJAUUNmHmqkvLZR89ctTlTOvjYdKcqqA4LAkRNcchrAsQ>
    <xmx:KQkRaBvYhaCWlByxqJZxSnY34EPFnxImDe9uB66G0D53e6LHsIxIrQ>
    <xmx:KQkRaNHh77xBpJfF0c4GhmVRaRqunokSrMOu26joUiZzuNbeBr95-A>
    <xmx:KQkRaIN9TtQcHoYSwHJuHZdrHPkvspssTYI7djBUgxTaNRP269G_4w>
    <xmx:KQkRaKPvo0ED7Ki1F1gLQkRMVinssHoqbT1BAICB5FFVleB56s57EeYs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 13:15:20 -0400 (EDT)
Date: Tue, 29 Apr 2025 10:15:18 -0700
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9e8761-b71f-4015-bf7d-29072b02f2ac@app.fastmail.com>

On Tue, Apr 29, 2025 at 06:11:02PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 29, 2025, at 18:03, Boqun Feng wrote:
> > On Tue, Apr 29, 2025, at 8:51 AM, Arnd Bergmann wrote:
> >> On Tue, Apr 29, 2025, at 15:17, FUJITA Tomonori wrote:
> >>> On Mon, 28 Apr 2025 20:16:47 +0200 Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >>>      /// Return the number of milliseconds in the [`Delta`].
> >>>      #[inline]
> >>> -    pub const fn as_millis(self) -> i64 {
> >>> -        self.as_nanos() / NSEC_PER_MSEC
> >>> +    pub fn as_millis(self) -> i64 {
> >>> +        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)
> >>>      }
> >>>  }
> >>
> >> I think simply calling ktime_to_ms()/ktime_to_us() should result
> >> in reasonably efficient code, since the C version is able to
> >> convert the constant divisor into a multiply/shift operation.
> >>
> >
> > Well, before we jump into this, I would like to understand why
> > this is not optimized with multiply/shift operations on arm in
> > Rust code. Ideally all the dividing constants cases should not
> > need to call a C function.
> 
> I think it's just because nobody has rewritten the
> macros from include/asm-generic/div64.h into rust code.
> 
> The compiler could do the same transformation, but they
> generally just fall back to calling a libgcc function.
> 

FWIW, I found this:

	https://github.com/llvm/llvm-project/issues/63731

seems a WIP though.

Would it make sense if we rely on compiler optimization when it's
avaiable (for x86_64, arm64, riscv, etc), and only call ktime_to_ms() if
not? The downside of calling ktime_to_ms() are:

* it's a call function, and cannot be inlined with LTO or INLINE_HELPER:

	https://lore.kernel.org/all/20250319205141.3528424-1-gary@garyguo.net/

* it doesn't provide the overflow checking even if
  CONFIG_RUST_OVERFLOW_CHECKS=y

Thoughts?

Regards,
Boqun

>      Arnd

