Return-Path: <netdev+bounces-144921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2C49C8C76
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338701F24AF0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D829429;
	Thu, 14 Nov 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ALfL0Gb1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299191799B;
	Thu, 14 Nov 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593289; cv=none; b=Gd34C6YVOlagMsAllXnzaoSwJ64LjYKY5YPUBRDALYuQ39Xj2VUXmgrp9lLn60WcvlW2Kqvx4ZNxx5lI+8qIikfmpGqOpHs+Tt568OhF+UtwqqEtq2tzTCFwSpcmy+o4S02l9crwHHbFPfcGwbJRHKZ/wvg3XoSanJ8ZqaphJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593289; c=relaxed/simple;
	bh=Q5U+PJg1rcx9XWNl+P+/n5J1Fu65OrQwexbEb6Wk/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukqmy2nySNZrdAz3Ibo5wgsN3Pi/F8gWxVejo0XqP+y+CEZXKAX4lZwkfofLHWORLErSRZGfC4ZZGi0sYtHrrP7GRcZxcAyH03xMVyiyUNEDVbvIpWgF+fFpA1kf2lhXODHvulxSq2ivly0RKaoT7KAdpajWS7Ou/AdQjSXbTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ALfL0Gb1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9oj7rXsLkt3YOArpegG66nk5POyVHtry4taLnVtBxpU=; b=ALfL0Gb1uwFBZqdcRmk5nIcrza
	6I4Pgdf2ci5biGO0CUxnmoed/4K43wbC6Jjh9A1MlILNhUB4aT0eRvOTcyo/Q+o+0Pk40a063cseo
	eV4uypcF6l5WNk4/T/i7YfYvPhmrCsv387yC/xGaGuw3/D/vdXSlNdrd31bk7+OWzzbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBaVt-00DItG-Em; Thu, 14 Nov 2024 15:08:01 +0100
Date: Thu, 14 Nov 2024 15:08:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH v6 7/7] net: phy: qt2025: Wait until PHY becomes ready
Message-ID: <2d70826b-6d6c-43f6-b6ba-542d25e6e0c0@lunn.ch>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
 <20241114070234.116329-8-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114070234.116329-8-fujita.tomonori@gmail.com>

On Thu, Nov 14, 2024 at 04:02:34PM +0900, FUJITA Tomonori wrote:
> Wait until a PHY becomes ready in the probe callback by
> using read_poll_timeout function.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/phy/qt2025.rs | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> index 28d8981f410b..c042f2f82bb9 100644
> --- a/drivers/net/phy/qt2025.rs
> +++ b/drivers/net/phy/qt2025.rs
> @@ -12,6 +12,7 @@
>  use kernel::c_str;
>  use kernel::error::code;
>  use kernel::firmware::Firmware;
> +use kernel::io::poll::read_poll_timeout;
>  use kernel::net::phy::{
>      self,
>      reg::{Mmd, C45},
> @@ -19,6 +20,7 @@
>  };
>  use kernel::prelude::*;
>  use kernel::sizes::{SZ_16K, SZ_8K};
> +use kernel::time::Delta;
>  
>  kernel::module_phy_driver! {
>      drivers: [PhyQT2025],
> @@ -93,7 +95,13 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
>          // The micro-controller will start running from SRAM.
>          dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
>  
> -        // TODO: sleep here until the hw becomes ready.
> +        read_poll_timeout(
> +            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
> +            |val| val != 0x00 && val != 0x10,

Do we have any idea what these magic numbers mean? Can we replace the
numbers with names?

Apart from that, this patch looks O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

