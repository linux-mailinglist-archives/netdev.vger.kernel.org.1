Return-Path: <netdev+bounces-139238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614559B1116
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4511C22162
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6051213159;
	Fri, 25 Oct 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek51nUKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77021315B;
	Fri, 25 Oct 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889744; cv=none; b=R3ItzZNnTOhBUNcMoxbtYxK4nf5IF4u3fQKx9/Xdi+YstByPXRlPx8oPVrl7JasEHoN1hJq0uBTnj3clMJNPoiIDntTWh3sH0Ksdb0H2jwzgH0WamsJRFjiS2KXGIqifwOK86+68l6LOP+IYWIsprNTkQ5cYGr/HwSBewcIKWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889744; c=relaxed/simple;
	bh=X0TZiLDky0GG3x8/CIBJH27urTQk5NE/O4qW5A1hzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyboCYL10WcQa6LUk80x/4MYyxACF5/EKUE5F1KShmoKB1uZlq9XKO0/S2gcYC0ms/j9YffdcNDxt4nC65x/2XT85u8+BCYX4DdKwcIj07DQKiyWLVSXGtAyMS9XFbRLsPFGby83gslN5JT/2m6CnkyHbicfewJ6y2wgrnGanPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek51nUKm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1434b00a2so174103685a.0;
        Fri, 25 Oct 2024 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729889741; x=1730494541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7mEpXeFEW3xGftukSJ1AQ1XFvzrLG0415ygSe3eXAw=;
        b=Ek51nUKmLmkAZl/1jRRY3v8MVhhwS2CMgnkfdnf++BQc5EGVhg8JI3xdeh5ta473TG
         DV/GroHbzH4nEtfKqRPW1CMGHgcjl0Er7HIooKsKBRUExEnSjYNoiD5roGvUXnjkc2DT
         I43PggSE2Sw3xtldIWgw8EoRIAyUfPJwr/clLh8QOb9qb4bb3ZIIzXh+abJmXwwGeQl5
         aToWzJhOKOO6BMMOAYum5UAVVSp4azu4hHqotJ8NxnfV1tyG9aQ0oRE6r42WCxQ4vsls
         0LXZ1Bnp/R6WOqjBxZ66kBElJEmGrcnBaJBV1bSJc2JZAlKadEw1VM5ffCVe5olJlA7J
         9CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889741; x=1730494541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7mEpXeFEW3xGftukSJ1AQ1XFvzrLG0415ygSe3eXAw=;
        b=KAgBiZGnMX3IMc940iKu7YIaVBZcFFIhjZBW/sxNYINjtEGJVFriAdQsmVx7JdDpkV
         gV0LfctEKFIVWEoYhKr8F9KlqLXIdUFKNQMKZsmGRzQ/QFECl+/nsQcTCs7FZ/2aVa2p
         NE+RYoyrQUC5V0Q0JjdTr0rlbA5O4GYbC2MOMsHW4bQOSFR+Ww+xWwefknGg+XZpuZyX
         nFRCpgXUWKaTu5FsE+L1NqjxZ0XUOiKaPsCKbzRTJTdQBSZtoI/VXCIZoPBO/Qz3rPp/
         /7rrz2KzevhNpy5zdxP2n5+qeG+5uutbjNKX6fDh8o/26fMpsgBumbfJuxkwWRppX8Ia
         hhEw==
X-Forwarded-Encrypted: i=1; AJvYcCUc+RQ5p1iK4gkbtBcYfEtCZNjLqjSauttzRnojEOO0Sw6Hjrz+LR4/Nk2WYTJAKm4U4KZh9PpNlbtjduV2IMw=@vger.kernel.org, AJvYcCV4dD9pB94qvi2p7k4zAYBjl0xmEqYQFkgPCt8WuCRlTqeV+jGRfdzoqeDqAsE6lbK701MXxSORYJknuwA=@vger.kernel.org, AJvYcCXFZYb2BSIc+XQaRGGQc6+LYhEfQ6YHX6EM29BTWzTSazotCW7uUrlJGE+0bGCEtAEtkXklK4pm@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4b7ro2SkYrwl2Ieu202k+ZpXuGC2Y3HfoEZ3PPleTlHk5PjG
	0RVHWrNKVRlPUnuyMuocVKx36517KvcLGWAFgrTCH2UQYjlL4INk
X-Google-Smtp-Source: AGHT+IEqQhKau5pPRGGlLuxWimNh2z4GtMCD8DH2lIJXQASpwX0eyAheXM/Votkbex8rG7D399vjoQ==
X-Received: by 2002:a05:620a:1a95:b0:7b1:45ac:86bd with SMTP id af79cd13be357-7b193eeda1dmr95709185a.18.1729889741159;
        Fri, 25 Oct 2024 13:55:41 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d278276sm90108685a.10.2024.10.25.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:55:40 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2C0211200043;
	Fri, 25 Oct 2024 16:55:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 25 Oct 2024 16:55:40 -0400
X-ME-Sender: <xms:zAUcZ4Xp0nlS9-mdCZRDU6sq7p_cNJyEUMJ43fYQrDGTeSWKSc9_rg>
    <xme:zAUcZ8kHLUHvVMI3bvMdmnY0cZwg_bicXZrYls2lFC89qsy_29D7EKiphKgJTshmL
    6Wdj7jAuKZnMiwTIA>
X-ME-Received: <xmr:zAUcZ8Y-16fStVU3MERCcmZTXaA-FcEzaMa4Mpk2D-eYixSPhoMf_k9sKTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepjhhsthhu
    lhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:zAUcZ3UKd7ADpjA5EONVWzudijOw9jZaS7zqBC1zfXU3Q-UHpFG-vQ>
    <xmx:zAUcZylWNGw_ZP00060z8nlk0qBsXohld85XF3trE2NxdqmvwXfJ3w>
    <xmx:zAUcZ8chZJSurud8yQxN8WAPT8PKBilMD9rKLgh5XEasPpDShf1szw>
    <xmx:zAUcZ0G9DE2lFLuFRWubeyv78yZf3TRnI87mRWhC9cWr62upmxJx6g>
    <xmx:zAUcZ4nHER8e6i3AnVj4jrtr2Ptb0PaSva2M9t_O8jbpw63EQMFVpRvR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 16:55:39 -0400 (EDT)
Date: Fri, 25 Oct 2024 13:55:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 3/7] rust: time: Introduce Instant type
Message-ID: <ZxwFyl0xIje5gv7J@Boquns-Mac-mini.local>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
 <20241025033118.44452-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025033118.44452-4-fujita.tomonori@gmail.com>

On Fri, Oct 25, 2024 at 12:31:14PM +0900, FUJITA Tomonori wrote:
> Introduce a type representing a specific point in time. We could use
> the Ktime type but C's ktime_t is used for both timestamp and
> timedelta. To avoid confusion, introduce a new Instant type for
> timestamp.
> 
> Rename Ktime to Instant and modify their methods for timestamp.
> 
> Implement the subtraction operator for Instant:
> 
> Delta = Instant A - Instant B
> 
> The operation never overflows (Instant ranges from 0 to
> `KTIME_MAX`).
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs | 48 +++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 574e72d3956b..3cc1a8a76777 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -31,59 +31,43 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>      unsafe { bindings::__msecs_to_jiffies(msecs) }
>  }
>  
> -/// A Rust wrapper around a `ktime_t`.
> +/// A specific point in time.
>  #[repr(transparent)]
>  #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
> -pub struct Ktime {
> +pub struct Instant {
> +    // Range from 0 to `KTIME_MAX`.
>      inner: bindings::ktime_t,
>  }
>  
> -impl Ktime {
> -    /// Create a `Ktime` from a raw `ktime_t`.
> +impl Instant {
> +    /// Create a `Instant` from a raw `ktime_t`.
>      #[inline]
> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> +    fn from_raw(inner: bindings::ktime_t) -> Self {
>          Self { inner }
>      }
>  
>      /// Get the current time using `CLOCK_MONOTONIC`.

I think eventually we want to have the `Instant` generic over
clocksource, i.e. an `Instant<MONOTOMIC>` cannot substract an
`Instant<BOOTTIME>`, but that's something we can do later.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>      #[inline]
> -    pub fn ktime_get() -> Self {
> +    pub fn now() -> Self {
>          // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
>          Self::from_raw(unsafe { bindings::ktime_get() })
>      }
>  
> -    /// Divide the number of nanoseconds by a compile-time constant.
>      #[inline]
> -    fn divns_constant<const DIV: i64>(self) -> i64 {
> -        self.to_ns() / DIV
> -    }
> -
> -    /// Returns the number of nanoseconds.
> -    #[inline]
> -    pub fn to_ns(self) -> i64 {
> -        self.inner
> -    }
> -
> -    /// Returns the number of milliseconds.
> -    #[inline]
> -    pub fn to_ms(self) -> i64 {
> -        self.divns_constant::<NSEC_PER_MSEC>()
> +    /// Return the amount of time elapsed since the `Instant`.
> +    pub fn elapsed(&self) -> Delta {
> +        Self::now() - *self
>      }
>  }
>  
> -/// Returns the number of milliseconds between two ktimes.
> -#[inline]
> -pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> -    (later - earlier).to_ms()
> -}
> -
> -impl core::ops::Sub for Ktime {
> -    type Output = Ktime;
> +impl core::ops::Sub for Instant {
> +    type Output = Delta;
>  
> +    // never overflows
>      #[inline]
> -    fn sub(self, other: Ktime) -> Ktime {
> -        Self {
> -            inner: self.inner - other.inner,
> +    fn sub(self, other: Instant) -> Delta {
> +        Delta {
> +            nanos: self.inner - other.inner,
>          }
>      }
>  }
> -- 
> 2.43.0
> 
> 

