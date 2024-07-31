Return-Path: <netdev+bounces-114558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF741942E52
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0B1C22925
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F41AED5A;
	Wed, 31 Jul 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LqynyEoD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4771AED20;
	Wed, 31 Jul 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428652; cv=none; b=IF1VTCdzUD6TyJ6LKBQjWVfgkQeDsHlM3aJ5n9/yP3WhDeXG6T/A9BJjuaM5hxxsMPGmZHMt7sF6Zd5VgygMb5j11sSnoHfSm9Dr+pfzzgQOARLkQcdXXyX64LNV5a+58QuYl9aLE6d4TCarxB3MgpglOknTkw2duBrtncGvlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428652; c=relaxed/simple;
	bh=RiB3L5dw4J0OXROqR71bXijLFtKhnGureRDJUnnV0/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjNsVZogDzp+YJ6aenH9HdHru8olSwbCFADQndsJ3hdfrECc+SiNQ5U5XAn6aloJvvkFuVdjBS1Trd19V0YWXpmLUXQZilRSUW1/6wBfceh4CP4HMvwZPyVDS6lNtBf770X0O7nZDqAzkOhFzg4+Mw55cvmggB2U4NRV2gpLKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LqynyEoD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eGVau2NKOweh/r97tXcrNUlPhiUoXGML3VsyLNUSM+I=; b=LqynyEoDXCK4bv8H8awH99Zn3o
	mvb+Wa7DTIGSbigvCqwjx/OcgY4CmCJe+wu48IzAq/5y7WmNSWVTXZ9xAleetyEyEkDnGcFnTBiHA
	IwQFquQJjhLwW/inbbgi1n2inC3CEhHVEj102/PoLnXvMEmN+7+kgpT6ZEVr/sABYf10=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZ8NE-003fkm-SX; Wed, 31 Jul 2024 14:24:08 +0200
Date: Wed, 31 Jul 2024 14:24:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 2/6] rust: net::phy support probe callback
Message-ID: <5525a61c-01b7-4032-97ee-4997b19979ad@lunn.ch>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
 <20240731042136.201327-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731042136.201327-3-fujita.tomonori@gmail.com>

On Wed, Jul 31, 2024 at 01:21:32PM +0900, FUJITA Tomonori wrote:
> Support phy_driver probe callback, used to set up device-specific
> structures.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index fd40b703d224..99a142348a34 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -338,6 +338,20 @@ impl<T: Driver> Adapter<T> {
>          })
>      }
>  
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: This callback is called only in contexts
> +            // where we can exclusively access to `phy_device`, so the accessors on
> +            // `Device` are okay to call.

This one is slightly different to other callbacks. probe is called
without the mutex. Instead, probe is called before the device is
published. So the comment is correct, but given how important Rust
people take these SAFETY comments, maybe it should indicate it is
different to others?

	Andrew

