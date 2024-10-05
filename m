Return-Path: <netdev+bounces-132425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CF991AC8
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 23:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829AB283C1C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924615A86B;
	Sat,  5 Oct 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IwNWICaP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416D10A18;
	Sat,  5 Oct 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728162611; cv=none; b=Y0c5l9Bn4FnqLVzYqqP+x/MdyV1FP7z3C8ZY7sEBOg2nZy1v+eUuQ/fX3ESJZVxcIZv2VXsd2kC9csXG/t/fySQcnk6CMrhxE3LfBYfgHgjrDEbxwhxFY5Sy2n/8ibTLF9RjTBjD5o0w4OS8FhKV3u4Erz/ACmvYhROiY920VGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728162611; c=relaxed/simple;
	bh=XNJ6j+NmfhQiOjzAkAYnWd6ZaNw4OuVy2Tk2vKusXHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE/xKU1/Bt2sXp1VHx5td4eDQKpedgwnnaas3AAMBoL0RkZd1OcOdur0adN3qsn8W6ugTObw2UOTy8pJtlOmqCl8cQ2tFQlBaV6oGkMLYA6o4BC/MU2HgupVjldfvsq3qSmMnjqSOd+MThJoW078HeLnCQOxSrCcvvO0rfNrrqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IwNWICaP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H6P87KlwUnyJtmGe5pYUTRscMy05gLwFR8H+OXIgxPE=; b=IwNWICaP+QO9NvNnf+PkL0GogY
	rwTllAmqKgaUWWmF9HAzUB4GCXLCbgJVxyituuINywYY5hGfW1NUyAUs2o+kryug/yv1ASV6NvWJZ
	juDUR2kPUXLGT07fEQ2mSG8D0d759RJteSbK5OYl9/D4XS9hLZFPlA3B13IDREMoxCA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxC28-0099YB-FM; Sat, 05 Oct 2024 23:09:48 +0200
Date: Sat, 5 Oct 2024 23:09:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
Message-ID: <7e6e0f84-1eef-4c7c-872a-3852a9a80034@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005122531.20298-3-fujita.tomonori@gmail.com>

On Sat, Oct 05, 2024 at 09:25:27PM +0900, FUJITA Tomonori wrote:
> Introduce a type representing a span of time. Define our own type
> because `core::time::Duration` is large and could panic during
> creation.
> 
> We could use time::Ktime for time duration but timestamp and timedelta
> are different so better to use a new type.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index c40105941a2c..6c5a1c50c5f1 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,9 +8,15 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>  
> +/// The number of nanoseconds per microsecond.
> +pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
>  
> +/// The number of nanoseconds per second.
> +pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
> +
>  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>  pub type Jiffies = core::ffi::c_ulong;
>  
> @@ -103,3 +109,61 @@ fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
>          }
>      }
>  }
> +
> +/// A span of time.
> +#[derive(Copy, Clone)]
> +pub struct Delta {
> +    nanos: i64,
> +}
> +
> +impl Delta {
> +    /// Create a new `Delta` from a number of nanoseconds.
> +    #[inline]
> +    pub fn from_nanos(nanos: u16) -> Self {
> +        Self {
> +            nanos: nanos.into(),
> +        }
> +    }

Just throwing out an idea:

How about we clamp delay to ~1 year, with a pr_warn() if it needs to
actually clamp. All the APIs take or return a u64.

> +    /// Return the number of microseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_micros(self) -> i64 {
> +        self.nanos / NSEC_PER_USEC
> +    }

Another dumb rust question. How does the Rust compiler implement 64
bit division on 32 bit systems? GCC with C calls out to a library to
do it, and the kernel does not have that library. So you need to use
the kernel div_u64() function.

Did you compiler this code for a 32 bit system?

	Andrew

