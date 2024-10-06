Return-Path: <netdev+bounces-132486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990B991DD8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 12:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B91C2180E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0017333D;
	Sun,  6 Oct 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="RK6j4W02"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BB16A382;
	Sun,  6 Oct 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210546; cv=none; b=oAWKwqH93MVBVLJjw699xzFhDEKF59PHnNpwc0utYZ+a7vaquqo26BSFQHbHjEQTpK4r2wd7y8zXDnGZdskTUB7qL/UtkrKmsu0YbHO/KJQ6qyMG2r996+e7//4Jg8jQWMlTovD7dPS0JZmB8wOlqLmIJlW+a6Juih7V50bsZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210546; c=relaxed/simple;
	bh=clcboj/GbGUloJWwp8O582U00IpGJyOBX41Ha9a7szU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZDzTVuBg2cb4+5jlDTSTYngk5PPEeYnVLZ1p7qIgKcC+xhKXFyzgHD8HPVKPGBCFihxCOanDSWg8H+n85VgvXcbuY3ILn7YPhOWGVePoRmCM2duPIyD9nf4Qglu5Lipq2wcWl9iDFaB/EGisHV2yStRGx9PHIyDSK3BWKrth7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=RK6j4W02; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <finn@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1728210540; bh=ziC4zCQbxWnUPd91VeFNp/X/tZGtA6ExmUPFunWTlS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RK6j4W02GfgtVMJtKUzSssjbiyEZavENeJXX6xSg+mZktrCaSLnnu85niyaVUZrVA
	 sXSTMrLe6t3PxBO8CEpvpQDezsmb6SGCW9GuMX1nMI6D4oLsME87AGaWVjCMCYeHrs
	 aWGKcGZBv+85uXrpHgHD9QY4oPR/PgnXKyM3Q29U=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
Date: Sun, 06 Oct 2024 12:28:59 +0200
Message-ID: <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
In-Reply-To: <20241005122531.20298-2-fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 5 Oct 2024, at 14:25, FUJITA Tomonori wrote:

> Implement PartialEq and PartialOrd trait for Ktime by using C's
> ktime_compare function so two Ktime instances can be compared to
> determine whether a timeout is met or not.

Why is this only PartialEq/PartialOrd? Could we either document why or im=
plement Eq/Ord as well?

>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/time.c    |  8 ++++++++
>  rust/kernel/time.rs    | 22 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>  create mode 100644 rust/helpers/time.c
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..c274546bcf78 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -21,6 +21,7 @@
>  #include "slab.c"
>  #include "spinlock.c"
>  #include "task.c"
> +#include "time.c"
>  #include "uaccess.c"
>  #include "wait.c"
>  #include "workqueue.c"
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> new file mode 100644
> index 000000000000..d6f61affb2c3
> --- /dev/null
> +++ b/rust/helpers/time.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/ktime.h>
> +
> +int rust_helper_ktime_compare(const ktime_t cmp1, const ktime_t cmp2)
> +{
> +	return ktime_compare(cmp1, cmp2);
> +}
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index e3bb5e89f88d..c40105941a2c 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -81,3 +81,25 @@ fn sub(self, other: Ktime) -> Ktime {
>          }
>      }
>  }
> +
> +impl PartialEq for Ktime {
> +    #[inline]
> +    fn eq(&self, other: &Self) -> bool {
> +        // SAFETY: FFI call.
> +        let ret =3D unsafe { bindings::ktime_compare(self.inner, other=
=2Einner) };
> +        ret =3D=3D 0
> +    }
> +}
> +
> +impl PartialOrd for Ktime {
> +    #[inline]
> +    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering>=
 {
> +        // SAFETY: FFI call.
> +        let ret =3D unsafe { bindings::ktime_compare(self.inner, other=
=2Einner) };
> +        match ret {
> +            0 =3D> Some(core::cmp::Ordering::Equal),
> +            x if x < 0 =3D> Some(core::cmp::Ordering::Less),
> +            _ =3D> Some(core::cmp::Ordering::Greater),
> +        }
> +    }
> +}
> -- =

> 2.34.1

