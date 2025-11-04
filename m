Return-Path: <netdev+bounces-235593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF03C33365
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53B63A46E3
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44402C15BC;
	Tue,  4 Nov 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFYjumT7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CB757EA;
	Tue,  4 Nov 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294952; cv=none; b=Zeu+J+ScxIp+/yGTx0NVz3Y8HxPRNIxVqZvl+FV1vFs3svULmPV6cuYVrUmclDlWmX0INIg4j7i/L5bnRLD6ZFVQ6Vp2nZ6j+CBtgd83beCM+V59BMNktPEvsbDhlVQviKQ75WZxov99ingdiqvDPgts1J+3qodiAnvNj9diPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294952; c=relaxed/simple;
	bh=aqlUNg0c596uHdeWTUDcu6EdnafDbwK2pjKj403x1Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDSVLRceTuExCXkhkE5WI7T4W7c0xlwDFsvkgVWI9yKjMsEmLDCtzWpMLmqgzDTrEDsjABvOu6wQWuHKo+Cvi4Vd6opvXEh/pc9hYuHmOxR7hn0EdFnHdI6Ih8urN1S5kJtuDPDbFIWgo3OLy4CgB7UMFfzIm4yJVtryxrPEAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFYjumT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1884C4CEF8;
	Tue,  4 Nov 2025 22:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762294952;
	bh=aqlUNg0c596uHdeWTUDcu6EdnafDbwK2pjKj403x1Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFYjumT7IDjptaa+VauHwXCHykC6cd3SeIip1xQ/bUH83S4u37qHbm7Zs2PqmPn86
	 V5r96lDUrCEXwsAFPwk46TSN0qQMdCbA0cGiM+dxaQUX6xgb87nZQxVZmfiksEqtDk
	 2KaCcglRLURC1P6ouRVVQP8i5YpqcNhJZKw4CL8k=
Date: Wed, 5 Nov 2025 07:22:30 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: make RUST_FW_LOADER_ABSTRACTIONS select
 FW_LOADER
Message-ID: <2025110555-purifier-veneering-d9e8@gregkh>
References: <20251104-b4-select-rust-fw-v1-1-afea175dba22@nvidia.com>
 <2025110407-scouting-unpiloted-39f4@gregkh>
 <DDZZRCRHBLVI.MGWBUONLZ94K@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDZZRCRHBLVI.MGWBUONLZ94K@kernel.org>

On Tue, Nov 04, 2025 at 03:48:10PM +0100, Danilo Krummrich wrote:
> On Tue Nov 4, 2025 at 3:35 PM CET, Greg Kroah-Hartman wrote:
> > On Tue, Nov 04, 2025 at 11:04:49PM +0900, Alexandre Courbot wrote:
> >> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> >> index 752b9a9bea03..15eff8a4b505 100644
> >> --- a/drivers/base/firmware_loader/Kconfig
> >> +++ b/drivers/base/firmware_loader/Kconfig
> >> @@ -38,7 +38,7 @@ config FW_LOADER_DEBUG
> >>  config RUST_FW_LOADER_ABSTRACTIONS
> >>  	bool "Rust Firmware Loader abstractions"
> >>  	depends on RUST
> >> -	depends on FW_LOADER=y
> >> +	select FW_LOADER
> >
> > Please no, select should almost never be used, it causes hard-to-debug
> > issues.
> 
> I agree that select can be very annoying at times, but in this case it seems to
> be the correct thing to do?
> 
> For instance for something like:
> 
> 	config MY_DRIVER
> 		depends on PCI
> 		depends on DRM
> 		select AUXILIARY_BUS
> 		select FW_LOADER
> 
> In this case MY_DRIVER is only available if PCI and DRM is enabled, which makes
> sense, there is no reason to show users PCI and DRM drivers if both are
> disabled.
> 
> However, for things like AUXILIARY_BUS and FW_LOADER, I'd argue that they are
> implementation details of the driver and should be selected if the driver is
> selected.
> 
> Otherwise, wouldn't we expect users to know implementation details of drivers
> before being able to select them?

Ah, good point, I guess this is something like a "feature" that a driver
needs to work properly.  Ok, no objection from me (other than agreeing
that it needs to be split up as you already said.)

thanks,

greg k-h

