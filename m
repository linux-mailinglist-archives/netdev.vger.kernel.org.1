Return-Path: <netdev+bounces-158824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D569A136AA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A700F3A6F90
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CE1D935C;
	Thu, 16 Jan 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXMY6IaZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB11D619D
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019981; cv=none; b=jyP9RBR4+3c9QGJz4pWpmsJTRCZpyocldK4qsSKlUjG2qQCFifKzSKnokk4KXi1KuGqLs0oBB1EGx7RnWfMCthmoSY6lM4TE96WQK2pFuVWHbaQTWBEbWNowda3+vp4KOFZTTnIJSOHVlVsseqbtXSQ1AqWxwV7lQsCZ/og0d9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019981; c=relaxed/simple;
	bh=V8+QvPpARnKrkJb8595G+XtmIKFpdAON5phNCpj3p4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYgL4TkOanZSscy3nX+RiqnLVlS4PkGx5TkcGcZ5iAkZw39boWr1K6QjseF+FOxJWAm643EIcPK/OvMHM3ZlreVN9si1ndB9JJ4ee7fwp1Tt6fXPsGwXawGKeeE6DphCMPIBPP7t6EcXV1qQkPMZQMN7lAldm3Kq4rb007QWd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXMY6IaZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385de59c1a0so408647f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737019977; x=1737624777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AphgVzvfaUIVqVYPr6fiv7DOFwwK3EuZo7EKsczRJA=;
        b=yXMY6IaZq6hp5fEyfkEVFk7XSizEHcqHXRen7CmWB8pZB1ZEgnua5n6EOFUYq4UcCC
         ivIXUyd3Q3rsBszqAW5v+48A0JOQ22kT+2KMYU320o5ULeNmcGcAVUM36BS1u4VQoDbl
         iBHIgEy1JihRXoruDBxIX3XvcrAiuVWFFwgu8GGRotd91m9c9RmALCOXATPPx7EN4e+T
         n11pB/9m4fVwDIAApqptcigNXlDuQbTFDFovPhjltaE2lKiECJWv+2GO9cIg8meT+O3r
         1UGW+WO8FA6KeGcXNw3pwrqz01aa0nHdqc13+i0DUkh+1Gvd3yRxrP2UhgChMcYRlfLq
         Qi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019977; x=1737624777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AphgVzvfaUIVqVYPr6fiv7DOFwwK3EuZo7EKsczRJA=;
        b=mzCytfHaWss/XKFRL9DaNcgrOA1tad0xrtdINmH7zLx+0rsChDfu04duP8K9B59V0f
         6vBWt/laPg/ZrsqhVpdC/80Q/rki6/MfZ3O35jT4+pb6jrzauuruHMVsCOApEZwW+m20
         OmCZhEdAPjXN74WiJ78knYVgPr9dAQ+0Tiu9oZ2LZSSCIjmGhYMsHtBG36l//OnUmPxk
         gB210PXHioazlYSQslG9sVHJU+hcf2HJq7x7jidMfGqxYjSD7rTLKyT1akFK/R2xAvfK
         jTce4Mi4tHZtqnotBhszB4V9JMmyQNsw8iYKXgLpgH1p1lZfMUMXjVH2r5zIfOUaU7qI
         hsOw==
X-Forwarded-Encrypted: i=1; AJvYcCWND0gjUkjCcrAsGiPWNzaTtJur3Jq5tZLli5pC2e/aBBmljRsK9s3y1CNiu3kceDdAmxJMjnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrb+3Yn7bO6nZtpu0TDlZlRHNRBBZjcVDPt1KcR8IRpAFAbcP6
	1uqEga2iWrLT7ZEeYy2i4pE3EqnGLsRBECFlPiIkIFPMKFAfmCA09i/vRNoftgsAuJHFMMz9DXb
	INHKL5Eazmvh08EPPINcQBzbGOwJq1GtKHxc4
X-Gm-Gg: ASbGncuPP91Iorx+5qswtB59O6jCcnZjySlZmVb1q9neICxHxLHXZBWV6yZcRFj+9HY
	rBP6qPIZuPmvmJevmH+kGHFD0IJrY5iDdiQgINCFVmpVmhtA+b6vpNY1ofzCMcz2KrBU=
X-Google-Smtp-Source: AGHT+IGavv/S+FGMzRsD+B5yFTbKHW8KU60XCAD7woJDoOOlcNj17H9fQLQvapryZJuBJhN8/kutcCVcpGlP3vhrktM=
X-Received: by 2002:a5d:6484:0:b0:385:fd07:85f4 with SMTP id
 ffacd0b85a97d-38a87312c8dmr30099106f8f.31.1737019977029; Thu, 16 Jan 2025
 01:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-4-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-4-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jan 2025 10:32:45 +0100
X-Gm-Features: AbW1kvYpLLcgfXZGH-liSIppmg5D9F3z56wv2IDdFqulwdya8AAzonAHOGxg9Lo
Message-ID: <CAH5fLggz0t3wTxSNUw9oVBDbR_PSWpQysaSSt6drd7vw8AXQfw@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Introduce a type representing a specific point in time. We could use
> the Ktime type but C's ktime_t is used for both timestamp and
> timedelta. To avoid confusion, introduce a new Instant type for
> timestamp.
>
> Rename Ktime to Instant and modify their methods for timestamp.
>
> Implement the subtraction operator for Instant:
>
> Delta =3D Instant A - Instant B
>
> The operation never overflows (Instant ranges from 0 to
> `KTIME_MAX`).
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs | 48 +++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 55a365af85a3..da54a70f8f1f 100644
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

Please keep this function public.

>      /// Get the current time using `CLOCK_MONOTONIC`.
>      #[inline]
> -    pub fn ktime_get() -> Self {
> +    pub fn now() -> Self {
>          // SAFETY: It is always safe to call `ktime_get` outside of NMI =
context.
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

Nit: This places the #[inline] marker before the documentation. Please
move it after to be consistent.

Alice

