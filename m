Return-Path: <netdev+bounces-88167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BB8A6271
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1CB224F5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 04:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646A1BC5C;
	Tue, 16 Apr 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="do3WCFXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3F17554
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242085; cv=none; b=nXgIQ4jG261d0XiwnGnI4VsRzafAFY/fYfERieGlaLYkho5uAMHfq2BxgzncHdFHh2nAMOLKdCRlYmonnRGCl9bSPdzj7AmNigRSt/XrSeRNeFwsz8RQ4NqsDzVnvjNYofQszjGy/Hjg548cP9VCw7ouRYkqAluWX/Bt31ktCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242085; c=relaxed/simple;
	bh=ckuFnaAZyrvaPmoW29Qcog/aA0EJPKftH0hR/DYCVxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNkE2Ih66sXBfuSrkybZNIF2vTxyZ2acXINccELVEAtXuNVyon/JJIvtj576uRP/1oPCHtcjyyHqMiGFjyN60lUiZGzlKpHvGrq3RbVSds3Zc4r7+q3jaSuBBB8tTBH8Mymd+SKAzfkdJDnWJjNyhZ+V7BQ6YVAT/E2lJ5HXOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=do3WCFXP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso3941832276.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1713242081; x=1713846881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVnb03bD1Z8TQFj1cA3icDceZSAeMVLYBfSfOHapuPU=;
        b=do3WCFXPnvf9hOyKRMgCadwlSk6dAT56SUIoLsj4D1aitkmhyfyFloDo72lxNbKevK
         frbWB1E1vx+8HHiLHmsc3J6CSdi/HCTwbtuQ6w4nu2amkLv4xpZrx7GK++n4DCRrUwC3
         MG5sbf7TB6hWIAjOi52jRERfA4/yV+uLqyGsiAT1eB5iFq4oNR6w88vTpziCJZ8CrUFr
         eUMdZnFho4RuWuTrve8sjknO736/K2kd3lX3+4WViP1m2Fi9Ho+4SGhd/BFjQoAR0puj
         QF72/UNtt0dfiwQSz9LhqqYDvxnKyYt/0LoFWlqL0t0LE4qsdsptXuVJjOvZiQjz8PRq
         MMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713242081; x=1713846881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVnb03bD1Z8TQFj1cA3icDceZSAeMVLYBfSfOHapuPU=;
        b=Dg1r1m0nvlTnYpPa+41OQMb/2U9BuJT+rK9Fnw1CBv+qUiK/958F8eVsuPEFv/1aSM
         hgSgsdllq4YhDeLtbZhCMkQHW5+AOuVBMvV3NZ87qNm0YGGBou5M22v2Fv/9dHxVOdjp
         fDkZK9jg0W8+xwFKNX7mLd8EXRGNBwUh/JhU5l04RXzBGv+1fMOGoh0YH+60knYmwvFA
         oZqgLoxcdm4FGMfouSu1aRGNj82JDdvw3Ey34ACgu2H7uoXhhrVaAYo2xFEuV54hjtiC
         cf0xkE1n27+InRlmo4D+7JBIVZWP+3BKz8/JzzNAsHg4+C3DzjA8p6AVrpQePlXcBboc
         S+yA==
X-Gm-Message-State: AOJu0YyBQy02cWBuId3vtIW+kkJXmqWQ/Smk38owGGF4nItjW4DGRANk
	bCgQSyILlEDZcw5y4wnLmudUTMcuMKmwH0Va/NlC6uJ2PIH3WN+ouOTenMqbpdyTXSbOYhmrZ5z
	myUmODDTttNuxgkcuBady2FbLJsdUZOt9z58l4txKc+bPHr8Rw8A=
X-Google-Smtp-Source: AGHT+IEAbxIA+OY9506mxCbXOCtoissDBk6PAajWelbGc+T6BABwSPxhobkhj7tZC19fvPBDx2j6cUxcnSVSIQLMs1s=
X-Received: by 2002:a25:7405:0:b0:de3:ec94:2e94 with SMTP id
 p5-20020a257405000000b00de3ec942e94mr3519723ybc.15.1713242081392; Mon, 15 Apr
 2024 21:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415104701.4772-1-fujita.tomonori@gmail.com> <20240415104701.4772-5-fujita.tomonori@gmail.com>
In-Reply-To: <20240415104701.4772-5-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 16 Apr 2024 00:34:30 -0400
Message-ID: <CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY driver
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:47=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
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
> [...]
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
> +
> +const MDIO_MMD_PMAPMD: u8 =3D uapi::MDIO_MMD_PMAPMD as u8;
> +const MDIO_MMD_PCS: u8 =3D uapi::MDIO_MMD_PCS as u8;
> +const MDIO_MMD_PHYXS: u8 =3D uapi::MDIO_MMD_PHYXS as u8;
> +
> +struct PhyQT2025;
> +
> +#[vtable]
> +impl Driver for PhyQT2025 {
> +    const NAME: &'static CStr =3D c_str!("QT2025 10Gpbs SFP+");

Since 1.77 we have C string literals, `c"QT2025 10Gpbs SFP+"` (woohoo)

> +    const PHY_DEVICE_ID: phy::DeviceId =3D phy::DeviceId::new_with_exact=
_mask(0x0043A400);
> +
> +    fn config_init(dev: &mut phy::Device) -> Result<()> {
> +        let fw =3D Firmware::new(c_str!("qt2025-2.0.3.3.fw"), dev)?;

Same as above

> +        let phy_id =3D dev.c45_read(MDIO_MMD_PMAPMD, 0xd001)?;
> +        if (phy_id >> 8) & 0xff !=3D 0xb3 {
> +            return Ok(());
> +        }

Could you add a note about why you are returning early? Also some magic num=
bers

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

It might be nicer to put this in a table, like

    const QT2025_INIT_ROUTINE: &[(u8, u16, u16)] =3D &[
        // Add some notes about what the registers do, or put them in
separate consts
        (MDIO_MMD_PMAPMD, 0xC300, 0x0000),
        (MDIO_MMD_PMAPMD, 0xC302, 0x4),
        // ...
    ];

    for (add reg, val) in QT2025_INIT_ROUTINE {
        dev.c45_write(add, reg, val)?;
    }

> +        let mut j =3D 0x8000;

Could you give this one a name?

> +        let mut a =3D MDIO_MMD_PCS;
> +        for (i, val) in fw.data().iter().enumerate() {
> +            if i =3D=3D 0x4000 {
> +                a =3D MDIO_MMD_PHYXS;
> +                j =3D 0x8000;
> +            }

Looks like firmware is split between PCS and PHYXS at 0x4000, but like
Greg said you should probably explain where this comes from.

> +            dev.c45_write(a, j, (*val).into())?;

I think this is writing one byte at a time, to answer Andrew's
question. Can you write a `u16::from_le_bytes(...)` to alternating
addresses instead? This would be pretty easy by doing
`fw.data().chunks(2)`.

> +
> +            j +=3D 1;
> +        }
> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
> +
> +        Ok(())
> +    }
> +
> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> +        dev.genphy_c45_read_status()
> +    }
> +}

