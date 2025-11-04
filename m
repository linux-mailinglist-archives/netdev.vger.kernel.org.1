Return-Path: <netdev+bounces-235495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1494C3192F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6351920407
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F322226D00;
	Tue,  4 Nov 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJdGB6yv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278971494CC;
	Tue,  4 Nov 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266909; cv=none; b=QwZEgnFpmfcx0lsiWHByENV4VK+yRioCPkzIQA6LbBJUJw6Pv15T5EjBE4bS6yhj7IZAp8TINVEKBUhnD5RHOuARLYq6XCL5f9DmrmfCAUhWJAN7x95E5FY3CM/Rrllta3tRRAuSw66nQReOnfTJdkLYMuWQG0GidqTS6dGV9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266909; c=relaxed/simple;
	bh=780Lu7Vk+L7OEz1zpmgzeoNUJ51QqPpcyt599aDv/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4i6fKcD7M0oEbqjJ24HqaLXuEvFAhqrzH1JYqFPLpjcNOiGpeUHSlIzShY7LboaLkiPqtApYWfRGqSXmHDSr7AVlu10m91YMm5vMCr72w7MT0cSq7dW+uPkIY3HOzBb+/v2hgQuas7WsEGApTqWpFsbOikNfS/ojz5bOT2XlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJdGB6yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C021C116B1;
	Tue,  4 Nov 2025 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762266908;
	bh=780Lu7Vk+L7OEz1zpmgzeoNUJ51QqPpcyt599aDv/jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJdGB6yvX4Vbe5yrzv+YHesKh8NPm4vP2fWyWddFgPRpFv2veGF+wXvy9ddQU+/w8
	 bGKPWhgvqOsa3dPrsKDHmV0iaV2Hqbs5+Aki/rDp/qxxaoNmGeUvMDFApLYIWoA7J9
	 72XTUlA4u6wMB5MThXh4cHcxglNanfe93OVFbq5Y=
Date: Tue, 4 Nov 2025 23:35:03 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <2025110407-scouting-unpiloted-39f4@gregkh>
References: <20251104-b4-select-rust-fw-v1-1-afea175dba22@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-b4-select-rust-fw-v1-1-afea175dba22@nvidia.com>

On Tue, Nov 04, 2025 at 11:04:49PM +0900, Alexandre Courbot wrote:
> I have noticed that build will fail when doing the following:
> 
> - Start with the x86 defconfig,
> - Using nconfig, enable `CONFIG_RUST` and `CONFIG_DRM_NOVA`,
> - Start building.
> 
> The problem is that `CONFIG_RUST_FW_LOADER_ABSTRACTIONS` remains
> unselected, despite it being a dependency of `CONFIG_NOVA_CORE`. This
> seems to happen because `CONFIG_DRM_NOVA` selects `CONFIG_NOVA_CORE`.
> 
> Fix this by making `CONFIG_RUST_FW_LOADER_ABSTRACTIONS` select
> `CONFIG_FW_LOADER`, and by transition make all users of
> `CONFIG_RUST_FW_LOADER_ABSTRACTIONS` (so far, nova-core and net/phy)
> select it as well.
> 
> `CONFIG_FW_LOADER` is more often selected than depended on, so this
> seems to make sense generally speaking.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> I am not 100% percent confident that this is the proper fix, but the
> problem is undeniable. :) I guess the alternative would be to make nova-drm
> depend on nova-core instead of selecting it, but I suspect that the
> `select` behavior is correct in this case - after all, firmware loading
> does not make sense without any user.
> ---
>  drivers/base/firmware_loader/Kconfig | 2 +-
>  drivers/gpu/nova-core/Kconfig        | 2 +-
>  drivers/net/phy/Kconfig              | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 752b9a9bea03..15eff8a4b505 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -38,7 +38,7 @@ config FW_LOADER_DEBUG
>  config RUST_FW_LOADER_ABSTRACTIONS
>  	bool "Rust Firmware Loader abstractions"
>  	depends on RUST
> -	depends on FW_LOADER=y
> +	select FW_LOADER

Please no, select should almost never be used, it causes hard-to-debug
issues.

As something is failing, perhaps another "depends" needs to be added
somewhere instead?


thanks,

greg k-h

