Return-Path: <netdev+bounces-187097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986AAA4F18
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE87D9C3FB4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BB189F3B;
	Wed, 30 Apr 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i29vCD8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D91411DE;
	Wed, 30 Apr 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024608; cv=none; b=dfGm5a3oIzl7gGxkLk5pTnUH/OaJzc6R3Xm1ZW8LtxqAUT12JFXadGA5MZ99l31ecuENfJ4KxEpCsIuhR4A/1r1XxY/r/vePtImWbk827LeyZt51JkuDYuWtuYKZRj7qaIPARnJhgF21zDXWGW6lH0cMpf0oDUhUAuGajAMZBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024608; c=relaxed/simple;
	bh=oRFFAwmreUKAQl4GaubuSrpvesoLAbJht/CpW/vi3Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgwWVPsgsyEuztAZffUd98rYCsy/3MFdWpaMvcoEvI01MDrolwdpbispNCy5I2iipvgkFKLuy3S4az/n2mxslk7OCD6sSWYptNt4GXzbp3CInlaxtm2mRKv3WH0g91/0TtGyoKul7CYwRwRTXkHACqcw1mpSFVe0vNGir/wH3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i29vCD8b; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c54f67db99so134739885a.1;
        Wed, 30 Apr 2025 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746024605; x=1746629405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivJGbPbRQxJmb19A5eHhq6GxMvN6uMGeDQRL4Erv6gQ=;
        b=i29vCD8bpU2NxUFgpNpt4RVkaW1Hdql4nbvzV5ftwdRvI3D/YtzZON3T6cnef+tL1p
         4aWnuU4Zxl9W1H7bvtvLQyr0zWhIx3WybYcsIe037IiHzpOB7jHG/Y+wOJbUjf75S5/W
         QNYwcyCrIH+OV1YdRhehiQGoCL0E+qTuSnDZzHRjA9BmqKMgeEi2QPQCk4zUiySOFXUa
         JZwxhx5L8BZPnluiu62pUhK7lBZJBA+0V5Q3dvLCVa3Lv6KjU2dQDFG3QXa+3q+MdDzI
         VkHQlYmeE1rytpUq3kUJuc0JqHsIJr299b5RjbzH9Tt7BpYO+W3U4Zd/6mnIpmQ/Tkjz
         h0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024605; x=1746629405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivJGbPbRQxJmb19A5eHhq6GxMvN6uMGeDQRL4Erv6gQ=;
        b=H0EXhh/zFYS4cjZwEvfamu8ii6GrHwQw9OcCWOfaf2aCId1guFLr5X5tZ5Gmgid9vi
         BonNnuqhG52zxLF/A73pCQ9+I1+FZNFk5CbmV4pkYYflzHqrtnpdx34Rl6xlI2IQwL4k
         Xil6scWNzZWVUZkVY2dIJrWjGtHvlNM3fPD2vaQbn+C9q/G9xJ4CwKV9+SNOR1HlWKve
         SUcT2K2Ri3rfIxt7ctuS/SCgs9c+hSFN1mT/07eQgZDIULygZ2zR//xoq3W2ing20+7b
         Ikrezc0gbW6TdsyYliTChq+BfyZvSQNF4bSiSBOwq4hoWyeavUKV/XQbaVI4FQOxLn11
         9qsw==
X-Forwarded-Encrypted: i=1; AJvYcCVGldPuNHK1T8aIwStwd78WKoYD+IFyYLXKBoJ7ODDkXCvvG9EZ6hkRjN0SxLg7h5/10mMRJuqBmloauqIDaSo=@vger.kernel.org, AJvYcCWGVgK+aX0pXv1c+1BRFcz8N6WJxLWJx5FxGru4a5zKhAUw50V1EIcqXI3GN32GOiVItIQiYyfB@vger.kernel.org, AJvYcCWj386GAYrVrMskoWYBXWaw9/r7eNlzyfWRIZpIUvIVP9TUwJF8IxOA/dSNKIlAxU5Vp8gUImq9bdZphDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHoeG9mj/Q3AkA6dGUtRHpXDpAzDdm5TSrLzBv86WB8l4Kdme
	1kmkA7ud1wSOiOIVUC/JbL0aCdQqReBJXD2632suz4DSjxhgVxgW
X-Gm-Gg: ASbGncu7betpGE+0ijpaXA1Dos5HaWHOUtICbPnMnkCq8r0ct/dO5ADVU5Y51WtQjrH
	iFtCG5SXv3Ba5YuDqzjyS2y8eKahqdr9/m0yhumnVxEwMOG+B5MXUPd8nWdWbtZI6VIvJx8DdOZ
	Uk4FpMVPqm2CwHbBUJZQUSY7vjs/7q5WCuEwC5I6hn+LeSO8eXHBFHyAbKdFKckFzytVA8hpH7u
	XULqu2fxrNZL7td3xcs2Z/sdutHxNnUP1wx/80fdryhq89aslB0epwyYYOsIm3jyorel7p4lWzq
	MXBJ/vqDfoys2viTcB8Q/OyVzb5VHZA0xVb1bAzHZBMQt4YQXCkgwsSwu1Psx4drO60Nz/o1w1Y
	+pZbVo4JyHDZGtpspZP20/bVV/472hSw=
X-Google-Smtp-Source: AGHT+IE+m0GrrxzhxSJDmEJ9GYN2oWngu+sxJoeRuTO/XymdfXTaQJBXj/EkOoo627ZAZoOe26Bovg==
X-Received: by 2002:a05:620a:44d0:b0:7c5:9566:83dc with SMTP id af79cd13be357-7cac7b5b539mr418731385a.25.1746024604856;
        Wed, 30 Apr 2025 07:50:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ce3d7esm858766785a.54.2025.04.30.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:50:04 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5A76E120007C;
	Wed, 30 Apr 2025 10:50:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 30 Apr 2025 10:50:03 -0400
X-ME-Sender: <xms:mzgSaAh62bBkFtLpqiQbr-P_I_6qmBXuE0ukaP2yKMDeSon2OYP88w>
    <xme:mzgSaJBBkmdINzceXLuJ299hXctq3044IdmU-cK0xeYDTIWrf60VrdAKUZaHDLatP
    -lgpBvt06bBNVXBrA>
X-ME-Received: <xmr:mzgSaIGiTcjXPYVwSmzM3Xw1dQ9fJv-jDB8UWH68qPdoPFR74IQTvMu7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgedupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnugho
    nhhishesghhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    mhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurg
    estgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mzgSaBSD3frZmn__VzozNS4LpYTVpOW5oAE0USqfo3MxOmv1kXhu9A>
    <xmx:mzgSaNyLyD6oE86JI5GhEALLNfMptoN1GzCisXMUnbp04BkZCkChxw>
    <xmx:mzgSaP7QwSAMiicJqAgAD-OU1s-NxayA0_JhegL_taIaGu6mf_c-AQ>
    <xmx:mzgSaKzBD3VoQ8DqUbAXk2WhdM3rzDMVe-k_tObDutsIIvncrTy8eQ>
    <xmx:mzgSaBjL9roN0z08mbPGPkC1iHEVyutGJ3GJI5KsRPPZq5uXMZ81Eaaj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 10:50:01 -0400 (EDT)
Date: Wed, 30 Apr 2025 07:50:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, a.hindborg@kernel.org,
	rust-for-linux@vger.kernel.org, gary@garyguo.net,
	aliceryhl@google.com, me@kloenk.dev, daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com,
	david.laight.linux@gmail.com, pbonzini@redhat.com,
	jfalempe@redhat.com, linux@armlinux.org.uk,
	chrisi.schrefl@gmail.com, linus.walleij@linaro.org
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Message-ID: <aBI4mEgKx23qh1Zp@Mac.home>
References: <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com>
 <20250430.225131.834272625051818223.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430.225131.834272625051818223.fujita.tomonori@gmail.com>

On Wed, Apr 30, 2025 at 10:51:31PM +0900, FUJITA Tomonori wrote:
> On Tue, 29 Apr 2025 16:35:09 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> 
> >> It appears that there is still no consensus on how to resolve it. CC
> >> the participants in the above thread.
> >>
> >> I think that we can drop this patch and better to focus on Instant and
> >> Delta types in this merge window.
> >>
> >> With the patch below, this issue could be resolved like the C side,
> >> but I'm not sure whether we can reach a consensus quickly.
> > 
> > I think using the C ones is fine for the moment, but up to what arm
> > and others think.
> 
> I don't think anyone would disagree with the rule Russell mentioned
> that expensive 64-bit by 64-bit division should be avoided unless
> absolutely necessary so we should go with function div_s64() instead
> of function div64_s64().
> 
> The DRM QR driver was already fixed by avoiding 64-bit division, so
> for now, the only place where we still need to solve this issue is the
> time abstraction. So, it seems like Arnd's suggestion to simply call
> ktime_to_ms() or ktime_to_us() is the right way to go.
> 
> > This one is also a constant, so something simpler may be better (and
> > it is also a power of 10 divisor, so the other suggestions on that
> > thread would apply too).
> 
> One downside of calling the C's functions is that the as_micros/millis
> methods can no longer be const fn (or is there a way to make that
> work?). We could implement the method Paolo suggested from Hacker's
> Delight, 2nd edition in Rust and keep using const fn, but I'm not sure
> if it's really worth it.
> 
> Any thoughts?
> 

For ARM, where the constant division optimization (into to mult/shift)
is not available, I'm OK with anything you and others come out with
(calling a C function, implementing our own optimization, etc.) For
other architectures where the compilers can do the right thing, I
suggest we use the compiler optimization and don't re-invent the wheel.
For example, in your div10() solution below, we can have a generic
version which just uses a normal division for x86, arm64, riscv, etc,
and an ARM specific version.

Btw, the const fn point is a good one, thanks for bringing that up.

Regards,
Boqun

> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index a8089a98da9e..daf9e5925e47 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -229,12 +229,116 @@ pub const fn as_nanos(self) -> i64 {
>      /// to the value in the [`Delta`].
>      #[inline]
>      pub const fn as_micros_ceil(self) -> i64 {
> -        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
> +        const NSEC_PER_USEC_EXP: u32 = 3;
> +
> +        div10::<NSEC_PER_USEC_EXP>(self.as_nanos().saturating_add(NSEC_PER_USEC - 1))
>      }
>  
>      /// Return the number of milliseconds in the [`Delta`].
>      #[inline]
>      pub const fn as_millis(self) -> i64 {
> -        self.as_nanos() / NSEC_PER_MSEC
> +        const NSEC_PER_MSEC_EXP: u32 = 6;
> +
> +        div10::<NSEC_PER_MSEC_EXP>(self.as_nanos())
> +    }
> +}
> +
> +/// Precomputed magic constants for division by powers of 10.
> +///
> +/// Each entry corresponds to dividing a number by `10^exp`, where `exp` ranges from 0 to 18.
> +/// These constants were computed using the algorithm from Hacker's Delight, 2nd edition.
> +struct MagicMul {
> +    mult: u64,
> +    shift: u32,
> +}
> +
> +const DIV10: [MagicMul; 19] = [
> +    MagicMul {
> +        mult: 0x1,
> +        shift: 0,
> +    },
> +    MagicMul {
> +        mult: 0x6666666666666667,
> +        shift: 66,
> +    },
> +    MagicMul {
> +        mult: 0xA3D70A3D70A3D70B,
> +        shift: 70,
> +    },
> +    MagicMul {
> +        mult: 0x20C49BA5E353F7CF,
> +        shift: 71,
> +    },
> +    MagicMul {
> +        mult: 0x346DC5D63886594B,
> +        shift: 75,
> +    },
> +    MagicMul {
> +        mult: 0x29F16B11C6D1E109,
> +        shift: 78,
> +    },
> +    MagicMul {
> +        mult: 0x431BDE82D7B634DB,
> +        shift: 82,
> +    },
> +    MagicMul {
> +        mult: 0xD6BF94D5E57A42BD,
> +        shift: 87,
> +    },
> +    MagicMul {
> +        mult: 0x55E63B88C230E77F,
> +        shift: 89,
> +    },
> +    MagicMul {
> +        mult: 0x112E0BE826D694B3,
> +        shift: 90,
> +    },
> +    MagicMul {
> +        mult: 0x036F9BFB3AF7B757,
> +        shift: 91,
> +    },
> +    MagicMul {
> +        mult: 0x00AFEBFF0BCB24AB,
> +        shift: 92,
> +    },
> +    MagicMul {
> +        mult: 0x232F33025BD42233,
> +        shift: 101,
> +    },
> +    MagicMul {
> +        mult: 0x384B84D092ED0385,
> +        shift: 105,
> +    },
> +    MagicMul {
> +        mult: 0x0B424DC35095CD81,
> +        shift: 106,
> +    },
> +    MagicMul {
> +        mult: 0x480EBE7B9D58566D,
> +        shift: 112,
> +    },
> +    MagicMul {
> +        mult: 0x39A5652FB1137857,
> +        shift: 115,
> +    },
> +    MagicMul {
> +        mult: 0x5C3BD5191B525A25,
> +        shift: 119,
> +    },
> +    MagicMul {
> +        mult: 0x12725DD1D243ABA1,
> +        shift: 120,
> +    },
> +];
> +
> +const fn div10<const EXP: u32>(val: i64) -> i64 {
> +    crate::build_assert!(EXP <= 18);
> +    let MagicMul { mult, shift } = DIV10[EXP as usize];
> +    let abs_val = val.wrapping_abs() as u64;
> +    let ret = ((abs_val as u128 * mult as u128) >> shift) as u64;
> +    if val < 0 {
> +        -(ret as i64)
> +    } else {
> +        ret as i64
>      }
>  }

