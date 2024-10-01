Return-Path: <netdev+bounces-130850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E098BC17
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A0C1F21E7C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AB19AD8C;
	Tue,  1 Oct 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MJdWj5h7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A023156C6A;
	Tue,  1 Oct 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785905; cv=none; b=NbWcbr/aAuILps2hGQLYUsTQZrX0ihskhL62o+Z47Bb3I8Dja7MfEeIUhbpP1YqQKazQrbrqYVkpMWAkw4FrZ025Sbl3/0UQ+cmys2RB5F7AQYRvWHSs1/T7DpbeSE0I6+pGyGwwyi53yEsNW3ZezAALl2rvPxcRCe5wtLxQ92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785905; c=relaxed/simple;
	bh=/51c9MhiWej11bMjED/Rsmf6YhHHO3ghVNUbq20uTvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjXF6sy+dkaJBMpHqHwvjfPtxou6o6I5nLaPxx/Z5SmIKXlwBT/FwovkoNNCaFH+85C02S1X9UhKbsqI11w+jAe2SFo7vKoxt/trplGZne7MXvRgBRQVYWb326vK8PzlKXiAzN8NJMhZDJYOue+TCBt/SOWW0pCGcfpXLriMQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MJdWj5h7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sJxUfQiQyjfwCaDUOeV+iM6wEahc8rD83EY2RTnC5Xg=; b=MJdWj5h7dh/SV6Bj03cW1dyK4r
	nzgKzuQb53J/WeqP1Fj2OYF3KyDXKhnMqyBOVy3TByQvwFJxHlsC6UjHTwGNP58g+BwLwR7xIJE46
	e08Ylin7RA94Bja0F5BkWkEtcRS9OHoixZysMmx3zjsk0rdv2EZ3fvX2yoALQ9+urn/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svc2V-008j6u-Mo; Tue, 01 Oct 2024 14:31:39 +0200
Date: Tue, 1 Oct 2024 14:31:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
Message-ID: <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001112512.4861-2-fujita.tomonori@gmail.com>

On Tue, Oct 01, 2024 at 11:25:11AM +0000, FUJITA Tomonori wrote:
> Add an abstraction for sleep functions in `include/linux/delay.h` for
> dealing with hardware delays.
> 
> The kernel supports several `sleep` functions for handles various

s/for/which

> lengths of delay. This adds fsleep helper function, internally calls
> an appropriate sleep function.
> 
> This is used by QT2025 PHY driver to wait until a PHY becomes ready.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/delay.c            |  8 ++++++++
>  rust/helpers/helpers.c          |  1 +
>  rust/kernel/delay.rs            | 18 ++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  5 files changed, 29 insertions(+)
>  create mode 100644 rust/helpers/delay.c
>  create mode 100644 rust/kernel/delay.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..29a2f59294ba 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> +#include <linux/delay.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/firmware.h>
> diff --git a/rust/helpers/delay.c b/rust/helpers/delay.c
> new file mode 100644
> index 000000000000..7ae64ad8141d
> --- /dev/null
> +++ b/rust/helpers/delay.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +
> +void rust_helper_fsleep(unsigned long usecs)
> +{
> +	fsleep(usecs);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..279ea662ee3b 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -12,6 +12,7 @@
>  #include "build_assert.c"
>  #include "build_bug.c"
>  #include "err.c"
> +#include "delay.c"
>  #include "kunit.c"
>  #include "mutex.c"
>  #include "page.c"
> diff --git a/rust/kernel/delay.rs b/rust/kernel/delay.rs
> new file mode 100644
> index 000000000000..79f51a9608b5
> --- /dev/null
> +++ b/rust/kernel/delay.rs
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep routines.
> +//!
> +//! C headers: [`include/linux/delay.h`](srctree/include/linux/delay.h).
> +
> +use core::{ffi::c_ulong, time::Duration};
> +
> +/// Sleeps for a given duration.
> +///
> +/// Equivalent to the kernel's [`fsleep`] function, internally calls `udelay`,
> +/// `usleep_range`, or `msleep`.

Is it possible to cross reference
Documentation/timers/timers-howto.rst ?  fsleep() points to it, so it
would e good if the Rust version also did.

I would also document the units for the parameter. Is it picoseconds
or centuries?

	Andrew

