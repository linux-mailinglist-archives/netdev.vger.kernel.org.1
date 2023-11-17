Return-Path: <netdev+bounces-48850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB47EFBA3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AD1B20AD7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24F8BE0;
	Fri, 17 Nov 2023 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i2xdgMLI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21BA194;
	Fri, 17 Nov 2023 14:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OWS1IK5QydUi2U8bvSiXqhP7t+L6DFEwapGeMPvU5gI=; b=i2xdgMLI/hcW4QHeXe2L8eR3Z+
	hUkv+B7Da65QJnVKu16/iEW5qGWlO66WpEhRiQ2XEg3wG08BXe3iowmMmgAOUAUYZL4BZDH8lZMRx
	PB12hRCHkaDznfMnno7tQX4mONSElR4VhgASZUebz/PFqnNJPtnMGJ1grKKGg9232X54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r47iz-000Tib-6n; Fri, 17 Nov 2023 23:54:09 +0100
Date: Fri, 17 Nov 2023 23:54:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
Message-ID: <66455d50-9a3c-4b5c-ba2c-5188dae247a9@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-3-fujita.tomonori@gmail.com>
 <ZVfncj5R9-8aU7vB@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVfncj5R9-8aU7vB@boqun-archlinux>

On Fri, Nov 17, 2023 at 02:21:38PM -0800, Boqun Feng wrote:
> On Thu, Oct 26, 2023 at 09:10:47AM +0900, FUJITA Tomonori wrote:
> [...]
> > +
> > +/// Declares a kernel module for PHYs drivers.
> > +///
> > +/// This creates a static array of kernel's `struct phy_driver` and registers it.
> > +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
> > +/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// # mod module_phy_driver_sample {
> > +/// use kernel::c_str;
> > +/// use kernel::net::phy::{self, DeviceId};
> > +/// use kernel::prelude::*;
> > +///
> > +/// kernel::module_phy_driver! {
> > +///     drivers: [PhyAX88772A],
> > +///     device_table: [
> > +///         DeviceId::new_with_driver::<PhyAX88772A>()
> > +///     ],
> > +///     name: "rust_asix_phy",
> > +///     author: "Rust for Linux Contributors",
> > +///     description: "Rust Asix PHYs driver",
> > +///     license: "GPL",
> > +/// }
> > +///
> > +/// struct PhyAX88772A;
> > +///
> > +/// #[vtable]
> > +/// impl phy::Driver for PhyAX88772A {
> > +///     const NAME: &'static CStr = c_str!("Asix Electronics AX88772A");
> > +///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x003b1861);
> > +/// }
> > +/// # }
> > +/// ```
> 
> When run the following kunit command:
> 
> ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch x86_64 \
> 	--kconfig_add CONFIG_RUST=y \
> 	--kconfig_add CONFIG_RUST_PHYLIB_ABSTRACTIONS=y \
> 	--kconfig_add CONFIG_PHYLIB=y \
> 	--kconfig_add CONFIG_NETDEVICES=y \
> 	--kconfig_add CONFIG_NET=y \
> 	--kconfig_add CONFIG_AX88796B_RUST_PHY=y \
> 	--kconfig_add CONFIG_AX88796B_PHY=y
> 
> I got the following errors:
> 
> 	ERROR:root:ld.lld: error: duplicate symbol: __rust_asix_phy_init
> 	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
> 	>>>            rust/doctests_kernel_generated.o:(__rust_asix_phy_init) in archive vmlinux.a
> 	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
> 	>>>            drivers/net/phy/ax88796b_rust.o:(.text+0x160) in archive vmlinux.a
> 
> 	ld.lld: error: duplicate symbol: __rust_asix_phy_exit
> 	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
> 	>>>            rust/doctests_kernel_generated.o:(__rust_asix_phy_exit) in archive vmlinux.a
> 	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
> 	>>>            drivers/net/phy/ax88796b_rust.o:(.text+0x1E0) in archive vmlinux.a
> 
> 	ld.lld: error: duplicate symbol: __mod_mdio__phydev_device_table
> 	>>> defined at doctests_kernel_generated.5ed8fd29a53cf22f-cgu.0
> 	>>>            rust/doctests_kernel_generated.o:(__mod_mdio__phydev_device_table) in archive vmlinux.a
> 	>>> defined at ax88796b_rust.37fb93aefca595fa-cgu.0
> 	>>>            drivers/net/phy/ax88796b_rust.o:(.rodata+0x58) in archive vmlinux.a
> 
> Because kunit will use the above doc test to generate test, and since
> CONFIG_AX88796B_RUST_PHY is also selected, the `module_phy_driver!` has
> been called twice, and causes duplicate symbols.
> 
> For "rust_asix_phy_*" symbols, it's easy to fix: just rename the usage
> in the example. But for __mod_mdio__phydev_device_table, it's hard-coded
> in `module_phy_driver!`, I don't have a quick fix right now. Also, does
> it mean `module_phy_driver!` is only supposed to be "called" once for
> the entire kernel?

Each kernel module should be in its own symbol name space. The only
symbols which are visible outside of the module are those exported
using EXPORT_SYMBOL_GPL() or EXPORT_SYMBOL(). A PHY driver does not
export anything, in general.

Being built in also does not change this.

Neither drivers/net/phy/ax88796b_rust.o nor
rust/doctests_kernel_generated.o should have exported this symbol.

I've no idea how this actually works, i guess there are multiple
passes through the linker? Maybe once to resolve symbols across object
files within a module. Normal global symbols are then made local,
leaving only those exported with EXPORT_SYMBOL_GPL() or
EXPORT_SYMBOL()? A second pass through linker then links all the
exported symbols thorough the kernel?

	Andrew




