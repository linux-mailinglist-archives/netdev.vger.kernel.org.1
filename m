Return-Path: <netdev+bounces-194705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42789ACC015
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4682E7A4E2D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AF1586C8;
	Tue,  3 Jun 2025 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA4KVyng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B4182BC;
	Tue,  3 Jun 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931353; cv=none; b=TIMjp4AYHevUzRYeZiKSTZOso/V8F+x7bB9AduPeT7Tr5x7YDua6zBrJbNCjPlxb0pjSKIIEtjN4i5zbBkbf7nAjGvcCEeosanQ0Fg2un+G0BOu9CgAunSpisSyIvqOhAJSvEHKeBB6oeH9ZmAhxK1lz+/dY5fJzsKbkNBsZkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931353; c=relaxed/simple;
	bh=+TCfw6UJc0x8ReuGqpQSLdcc0Fq1J8YMPv6hWfnhg+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShgV8Txbpp9j9KE+aON5D7MP6q7m9xJcVN2iaGrA3L69MdUTWi5uHltDeytf/T4LHBg4DlYGCDmL/XoOc2ip1Bsjai60LpX77ndsNWYwZgfJ72zXEBW5idPUE1a9pQ8jJpG5cQhO3xadmfse0TQix6uAlt6KOdLHQ7NRxoLJveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA4KVyng; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e5599b795so50377787b3.3;
        Mon, 02 Jun 2025 23:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748931351; x=1749536151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExuFxCiiYbsiAIp1UmQZoEfKI6isD2hGXE7AN2ae6jI=;
        b=PA4KVyngyCnC54XYY10ZAkm4BQzDhintsxY5nVYd/2lJLqzKLcKL6skET32PBDUQdJ
         T0L+XeRIf0wqzoy77U45t42Y+VoKFMh+/dqJ01mB4FZ1c2qai1JB/ophwPjNNCQjD9YY
         lGCXfDhdorRDIDXfr8QAk6XZX0/6U1T0dU3G+2T57Szwcv483qNwAUbwNHqLCog0ru3U
         afXh4kteyWCxy1tWKCEaG23JnYiRRex8wRv+4KHdijOt0/64g5h782weS8zObK8IVeIL
         84CDiT9+cPJnDna1tm4o9CCasSj0MXvOWWxykvtoiXF1EsoNoHzwET8UJ6Kek4FOR0cs
         lU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748931351; x=1749536151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExuFxCiiYbsiAIp1UmQZoEfKI6isD2hGXE7AN2ae6jI=;
        b=WQY1IeC2511DrTNxoEwQrB5uOvPgkuf2VAcskDgtzYjwS9ln1dsfAQuSEbaVQhhkUy
         aBRV89tMO6YAZdv6EwfpnKVuvN549HngkNWLBMm5QLWPcCizXm6xR2Fu1i1YjdC843Zj
         wY8H7pU6wuduEPL1JYXgi76Nwu0zNQ8V6ntWzihtEVqoKHZf6piOKI7tsq+IuC/jMb7+
         P9Mt1E1hMqX6CtJDRQIQ0ZlAqyPHZbIhk+5pgidhldpq3rvSRoydvZEdx7ty+9XVIv76
         xON9uFadGhldCeac5PTaWmgGibm7bacRIxUdYX5RsnZF1ghHhV4WHPlvJVJBE+HSAVQu
         Mxiw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KzCH4768BVPjFTuPzZHg57/o9y3VrTwXS65ayxw2pKpTQIhPIm2KNQ2EIRV4WtD14BB4pz88J2uMuJo=@vger.kernel.org, AJvYcCXfifob8ESkBCnSTMfHReLvE/VnPa2mlMM6PwBbVICVQnsF0WzPdWUV9pP6YFIUY5+xUYmXFMaI@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY/+nmMLeL6TehepavrW3tmFugSJNNu+H5cSL/b9uKLYmahjR
	QDn3qydkg36cLXHLi51oTHP8L06PZQpugtbmcvWPCjSkv9IG1t91UJkQ9YfqrOehuRBSbQgXhOq
	XhoipaslJkvqYlBK5P14fo1Ip/zj7Nws=
X-Gm-Gg: ASbGncvWMU6s2VH3EhdIkRMOrwQI8jmMXQjawUy1bhRx58D1k57IvCisTTR3qNXwkzy
	K27wFaKtbI9erTFmxWIHpFqrP0qrLr6p2rgcDVftN750NP9sf/ssscHOweifgL3Q6LU6xIy5w3u
	asSSxsCRjD4mQTkSRYNiqjmR/hWM1X5+q6Btwt2PQvOg==
X-Google-Smtp-Source: AGHT+IGY6FBmZwmi0m/8ysBAH8/mLaagNSuxT/186P9VesCkOQnw6hhcDIYe/FLHli4CmyVMz+OZWeKmAV3QInXqeoQ=
X-Received: by 2002:a05:690c:6382:b0:70e:7503:1181 with SMTP id
 00721157ae682-70f97eaa4femr240501707b3.18.1748931350921; Mon, 02 Jun 2025
 23:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
 <20250602193953.1010487-6-jonas.gorski@gmail.com> <c1c3b951-19b8-462a-9dee-a1b893251d6f@broadcom.com>
In-Reply-To: <c1c3b951-19b8-462a-9dee-a1b893251d6f@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 3 Jun 2025 08:15:38 +0200
X-Gm-Features: AX0GCFu2kmJ_nnoOXZhbAertSNtMXnGhNEMlYn6h5PxdxbnewlMWrtzy2kbl8tE
Message-ID: <CAOiHx=n6Mc+nM2QOa8okQbFcj9UHgfMbKKcNXG6D-VJjELHrsw@mail.gmail.com>
Subject: Re: [PATCH net v2 5/5] net: dsa: b53: do not touch DLL_IQQD on bcm53115
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 11:40=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 6/2/25 12:39, Jonas Gorski wrote:
> > According to OpenMDK, bit 2 of the RGMII register has a different
> > meaning for BCM53115 [1]:
> >
> > "DLL_IQQD         1: In the IDDQ mode, power is down0: Normal function
> >                    mode"
> >
> > Configuring RGMII delay works without setting this bit, so let's keep i=
t
> > at the default. For other chips, we always set it, so not clearing it
> > is not an issue.
> >
> > One would assume BCM53118 works the same, but OpenMDK is not quite sure
> > what this bit actually means [2]:
> >
> > "BYPASS_IMP_2NS_DEL #1: In the IDDQ mode, power is down#0: Normal
> >                      function mode1: Bypass dll65_2ns_del IP0: Use
> >                      dll65_2ns_del IP"
> >
> > So lets keep setting it for now.
> >
> > [1] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob=
/master/cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h#L19871
> > [2] https://github.com/Broadcom-Network-Switching-Software/OpenMDK/blob=
/master/cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h#L14392
> >
> > Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitc=
h")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> > v1 -> v2:
> > * new patch
> >
> >   drivers/net/dsa/b53/b53_common.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index be4493b769f4..862bdccb7439 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -1354,8 +1354,7 @@ static void b53_adjust_531x5_rgmii(struct dsa_swi=
tch *ds, int port,
> >        * tx_clk aligned timing (restoring to reset defaults)
> >        */
> >       b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
> > -     rgmii_ctrl &=3D ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC |
> > -                     RGMII_CTRL_TIMING_SEL);
> > +     rgmii_ctrl &=3D ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
>
> Are not we missing a:
>
> if (dev->chip_id !=3D BCM53115_DEVICE_ID)
>         rgmii_ctrl &=3D ~RGMII_CTRL_TIMING_SEL;
>
> here to be strictly identical before/after?

We could add it for symmetry, but it would be purely decorational. We
unconditionally set this bit again later, so clearing it before has no
actual effect, which is why I didn't add it.

Regards,
Jonas

