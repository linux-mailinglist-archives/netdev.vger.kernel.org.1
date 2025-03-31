Return-Path: <netdev+bounces-178394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25562A76D54
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450DB3A7A1D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056F219A7E;
	Mon, 31 Mar 2025 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="Jz9qg6KA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB44156F3C
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448156; cv=none; b=mjnPshBq4F2v2hTeOv7uYRs//hLEzSLxUsmR+xDvRnB6bjBJdxrO2oZ1bA5Zh+KfpnH2KRiQlnvgFNSsUID5n+XrHPiia3qvGjD3gSd7K8rx+IXN6asGt0XiBwwk5xjU3LbVe899WVJz8Z7HIwuapv3kM1W22c6hL/w/GxaFVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448156; c=relaxed/simple;
	bh=++ctCPSO7v8Y2F/hnjtXCcshKYRfrd/6yeHWwU9K50Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M23uNBApHlemWDRR6/Edc+kIz2URwTEL4JzeB/GkzzumOE5vW65LMH+tt7N4IC5ioIcPqPz0RLQeNcw6ZBxLgKAKYF3tBeuNmCtukRnuU/QFL/n3jUpuxYwEYQqbAqqZXRzDCv3zCiUq0b/P8nCPyvRTwqN0Aszj2/zVowKhRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=Jz9qg6KA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301493f45aeso7788162a91.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1743448150; x=1744052950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weaeyc6Iq5KCbkTdB71O6escmnn+pUPOzFfZbmsaj8Q=;
        b=Jz9qg6KA2dufVLjj0lsx/ANrW37BeUNN5W/+g5wowQIZRb7SqSznEtls0WrQYDbY+d
         /0ik1j21AxhCIrGPXYTR9/NsBcP1CYhsWUp+MeTNtn+ORBu4FR7ZbzbL+CUiGiWKmXZP
         cwi93Ju2uqn6Fn5SpXFIN4CQoygDBxn2ImCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448150; x=1744052950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weaeyc6Iq5KCbkTdB71O6escmnn+pUPOzFfZbmsaj8Q=;
        b=Fx8ZSVe+u81cbUtQ4+UnPR5mBxdiIYhQ6cBUgUlyA2+w7LzE679MfKheugUYimFUGr
         qD5BLUbCsHt5RZHApBF3f6YdwFrzSq8pway3IQWHyblPp+p5KNjnICZBjpLQ0Mmv6ZjX
         QzzTGqR2QmToeyG0Z6OKOt1v+Oq4iU6Zn6d+toGSBBA1C77acrXCO//ycxqnXs//xbEI
         2qy9fzArpcr8/AoFmbR79bkQe0JEhztn55BLN5JLhI1QjeYdTk6IHIMdrHxwSQ7B6fCP
         CcwOr9aR/rdJV9b0h1e5l7iSZOTQMcyH0YtU4oKsYstD2kcUBGUPhmS4h4NkPdOQirIM
         cGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4gvArQVnHBAOWJyxDYQ8qTgiEaTq/noY4hEtQRR8eq4Xlh9MR578393gmwmvdGY4IaBocpgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEKygjvema4AnoDglpH4VdOomiIMZXGCjQ1goNMG1Eh3Jsj/8
	3ST4xRA3aMtpzFgB58OvPsgIPIFbnTbsHV5x4CaKgkl5xp2hShgpbbQPZUL3rsXzAcWvKqoZ1m+
	QtnTMvv6Fd/qg08AFcRJx+1Y6fNYig4BNcrjpAw==
X-Gm-Gg: ASbGnctFp+r6WEikcLibq9RbKyZvrXP5qmTmMeK0sAjSHIc0us6P6O1jTnmSTe4lBy8
	s/1JdzRqIgRICqrw5p+zmW+dpo8G3AhBmjxqV5i1ZnOqIG72s3UA6zI/o8AMvPsyp+LwEzBBnPL
	I5HDwSnrdl+jqX8WtUWA3BBfA=
X-Google-Smtp-Source: AGHT+IHI9tcVsJv+l9FCmeVZ2DxgRcZQhSRLltSRHjgXul/dSDhc9edkYByshaEyeXpvopZ8spvequ357SvBvqUtWE8=
X-Received: by 2002:a17:90b:5450:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-30531fa13bbmr20311472a91.12.1743448150396; Mon, 31 Mar 2025
 12:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch> <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
In-Reply-To: <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
From: Da Xue <da@lessconfused.com>
Date: Mon, 31 Mar 2025 15:09:00 -0400
X-Gm-Features: AQ5f1JocGacIomP9QycHriI_2lADeFj1Us7oWxzEiuO6mpCv_sUeGwQrjba2Abg
Message-ID: <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com>
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Da Xue <da@libre.computer>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, 
	linux-amlogic@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 9:55=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 31, 2025 at 03:43:26PM +0200, Andrew Lunn wrote:
> > On Mon, Mar 31, 2025 at 07:44:20AM +0000, Christian Hewitt wrote:
> > > From: Da Xue <da@libre.computer>
> > >
> > > This bit is necessary to enable packets on the interface. Without thi=
s
> > > bit set, ethernet behaves as if it is working, but no activity occurs=
.
> > >
> > > The vendor SDK sets this bit along with the PHY_ID bits. U-boot also
> > > sets this bit, but if u-boot is not compiled with networking support
> > > the interface will not work.
> > >
> > > Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
> > > Signed-off-by: Da Xue <da@libre.computer>
> > > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > > ---
> > > Resending on behalf of Da Xue who has email sending issues.
> > > Changes since v1 [0]:
> > > - Remove blank line between Fixes and SoB tags
> > > - Submit without mail server mangling the patch
> > > - Minor tweaks to subject line and commit message
> > > - CC to stable@vger.kernel.org
> > >
> > > [0] https://patchwork.kernel.org/project/linux-amlogic/patch/CACqvRUb=
x-KsrMwCHYQS6eGXBohynD8Q1CQx=3D8=3D9VhqZi13BCQQ@mail.gmail.com/
> > >
> > >  drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio=
/mdio-mux-meson-gxl.c
> > > index 00c66240136b..fc5883387718 100644
> > > --- a/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > +++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > @@ -17,6 +17,7 @@
> > >  #define  REG2_LEDACT               GENMASK(23, 22)
> > >  #define  REG2_LEDLINK              GENMASK(25, 24)
> > >  #define  REG2_DIV4SEL              BIT(27)
> > > +#define  REG2_RESERVED_28  BIT(28)
> >
> > It must have some meaning, it cannot be reserved. So lets try to find
> > a better name.
>
> Indeed, that was my thoughts as well, but Andrew got his reply in
> before I got around to replying!

The datasheets don't have much in the way of information about this
register bit. The Amlogic GXL datasheet is notoriously inaccurate.

ETH_REG2 0XC8834558
29:28 R 0x1 reserved

It claims the bit is read only while the BSP hard codes the setting of
this register. I am open to any name for this register bit.
This is the only thing holding up distro netbooting for these very
popular chip family.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

