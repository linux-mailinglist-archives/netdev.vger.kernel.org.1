Return-Path: <netdev+bounces-87878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133598A4D67
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572B1C2104E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05B5D732;
	Mon, 15 Apr 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OapMzZWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5525D49F;
	Mon, 15 Apr 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179711; cv=none; b=K4sbknlu0OdrO1w9UFajbsBLNaELSHeGaVbCM7yUSBWpCeMRNaygwPBoS9MrJc9l6hMD0m9nkYtw3SBkGjy41CtP4SKp+I1IpmlDFz88CMjRHky5LSwhZjWbrZ223R7mzA6TbBP48Bd0oDclXmUBmYne6QBdnA2L5N3LEL3fw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179711; c=relaxed/simple;
	bh=gfoSa9kp+IaCBIggHvTB3T3RKsXbSDiVaXSLI28z6hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tslzcj4W/xXlJsTYMBzMEUWi4zhwv+Z8jjLOsdV2zGPvNa+dUfvW4Pye+2t1BxB+3oypuCkCvApY06yHAOUAIB5+qI10bdIE6ZxJT2AqZJstAHqK3WgqgbeKf+q+4r0oKUcz4E+IcHNNlbJFkUrefmVT55/ld5ZGrNqYYeyMXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OapMzZWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C44C2BD11;
	Mon, 15 Apr 2024 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713179710;
	bh=gfoSa9kp+IaCBIggHvTB3T3RKsXbSDiVaXSLI28z6hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OapMzZWj6ycBdS8HFT8Uu9osGc5i83QF/sbkHWCMUg948/meMik4lEb8BiSyWhOo5
	 lnfCu2ybIqxOjH1p7HH616HgYNgKGq8VHpe8bC/6UIxnpRN7gVWSN6bDBBvpTFLXnt
	 Y6ODZP+pM3KKeqKJNeo5kFZHM7yHmFGn54wWutj0=
Date: Mon, 15 Apr 2024 13:15:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <2024041549-voicing-legged-3341@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104701.4772-5-fujita.tomonori@gmail.com>

On Mon, Apr 15, 2024 at 07:47:01PM +0900, FUJITA Tomonori wrote:
> This driver supports Applied Micro Circuits Corporation QT2025 PHY,
> based on a driver for Tehuti Networks TN40xx chips.
> 
> The original driver for TN40xx chips supports multiple PHY hardware
> (AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell 88X3120,
> 88X3310, and MV88E2010). This driver is extracted from the original
> driver and modified to a PHY driver in Rust.
> 
> This has been tested with Edimax EN-9320SFP+ 10G network adapter.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  MAINTAINERS               |  7 ++++
>  drivers/net/phy/Kconfig   |  6 ++++
>  drivers/net/phy/Makefile  |  1 +
>  drivers/net/phy/qt2025.rs | 75 +++++++++++++++++++++++++++++++++++++++
>  rust/uapi/uapi_helper.h   |  1 +
>  5 files changed, 90 insertions(+)
>  create mode 100644 drivers/net/phy/qt2025.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ba3fe6ac09c..f2d86e221ba3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1540,6 +1540,13 @@ F:	Documentation/admin-guide/perf/xgene-pmu.rst
>  F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
>  F:	drivers/perf/xgene_pmu.c
>  
> +APPLIED MICRO QT2025 PHY DRIVER
> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
> +L:	netdev@vger.kernel.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/phy/qt2025.rs
> +
>  APTINA CAMERA SENSOR PLL
>  M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3ad04170aa4e..8293c3d14229 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -110,6 +110,12 @@ config ADIN1100_PHY
>  	  Currently supports the:
>  	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
>  
> +config AMCC_QT2025_PHY
> +	tristate "AMCC QT2025 PHY"
> +	depends on RUST_PHYLIB_ABSTRACTIONS
> +	help
> +	  Adds support for the Applied Micro Circuits Corporation QT2025 PHY.
> +
>  source "drivers/net/phy/aquantia/Kconfig"
>  
>  config AX88796B_PHY
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 1d8be374915f..75d0b07a392a 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
>  obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
>  obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
>  obj-$(CONFIG_AMD_PHY)		+= amd.o
> +obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
>  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
>  ifdef CONFIG_AX88796B_RUST_PHY
>    obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> new file mode 100644
> index 000000000000..e42b77753717
> --- /dev/null
> +++ b/drivers/net/phy/qt2025.rs
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) Tehuti Networks Ltd.
> +// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Applied Micro Circuits Corporation QT2025 PHY driver
> +use kernel::c_str;
> +use kernel::net::phy::{self, DeviceId, Driver, Firmware};
> +use kernel::prelude::*;
> +use kernel::uapi;
> +
> +kernel::module_phy_driver! {
> +    drivers: [PhyQT2025],
> +    device_table: [
> +        DeviceId::new_with_driver::<PhyQT2025>(),
> +    ],
> +    name: "qt2025_phy",
> +    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
> +    description: "AMCC QT2025 PHY driver",
> +    license: "GPL",
> +}

What about support for MODULE_FIRMWARE() so it will be properly loaded
into the initramfs of systems now that you are needing it for this
driver?  To ignore that is going to cause problems :(



> +
> +const MDIO_MMD_PMAPMD: u8 = uapi::MDIO_MMD_PMAPMD as u8;
> +const MDIO_MMD_PCS: u8 = uapi::MDIO_MMD_PCS as u8;
> +const MDIO_MMD_PHYXS: u8 = uapi::MDIO_MMD_PHYXS as u8;
> +
> +struct PhyQT2025;
> +
> +#[vtable]
> +impl Driver for PhyQT2025 {
> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
> +
> +    fn config_init(dev: &mut phy::Device) -> Result<()> {
> +        let fw = Firmware::new(c_str!("qt2025-2.0.3.3.fw"), dev)?;
> +
> +        let phy_id = dev.c45_read(MDIO_MMD_PMAPMD, 0xd001)?;
> +        if (phy_id >> 8) & 0xff != 0xb3 {
> +            return Ok(());
> +        }
> +
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0000)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC302, 0x4)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC319, 0x0038)?;
> +
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC31A, 0x0098)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0x0026, 0x0E00)?;
> +
> +        dev.c45_write(MDIO_MMD_PCS, 0x0027, 0x0893)?;
> +
> +        dev.c45_write(MDIO_MMD_PCS, 0x0028, 0xA528)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0x0029, 0x03)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC30A, 0x06E1)?;
> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0002)?;
> +        dev.c45_write(MDIO_MMD_PCS, 0xE854, 0x00C0)?;
> +
> +        let mut j = 0x8000;
> +        let mut a = MDIO_MMD_PCS;
> +        for (i, val) in fw.data().iter().enumerate() {

So you are treating the firmware image as able to be iterated over here?


> +            if i == 0x4000 {

What does 0x4000 mean here?

> +                a = MDIO_MMD_PHYXS;
> +                j = 0x8000;

What does 0x8000 mean here?

> +            }
> +            dev.c45_write(a, j, (*val).into())?;
> +
> +            j += 1;
> +        }
> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;

Lots of magic values in this driver, is that intentional?

thanks,

greg k-h

