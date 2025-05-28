Return-Path: <netdev+bounces-194065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59948AC72E4
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025E11BA1316
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58C193062;
	Wed, 28 May 2025 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBEKTjwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034863B9;
	Wed, 28 May 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468755; cv=none; b=Kw7O3VefcHuQCg3i2YN++jx0FLesj8A1BFkv59w6nh1my8lknoAI6HQjpNZn7rQWOe3mSm73M66mwMMidBu6cxtCpG5BhjwnCFASKDKxYPcQnsEmcCjAb25fiKZIH9bGVeESySTpTpeAsH6qE8EVoU1s/3Vt7gY5+HdIHE9JvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468755; c=relaxed/simple;
	bh=hpEaJTEpfR9+TojleH3uk2aBSDLiXQVkHne1HqD9Ces=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke6ECF/G+9wR2Bl/fJChg2lCnQna5lSQP/7E1iAz5tLylGC8GbD+KU53LtAjvtz08C0IvcmSREvJzDUIlDWgsiNHoCV5Iz91HdC3mmMkO53LmkM2G27fVVQq+i0MfwN+t9T95ENH4TlNr581YyHLj8ZudN2coXOHVDk+CMxd5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBEKTjwU; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso135817e0c.3;
        Wed, 28 May 2025 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748468753; x=1749073553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpEaJTEpfR9+TojleH3uk2aBSDLiXQVkHne1HqD9Ces=;
        b=TBEKTjwUaPQY1JKkSAkae+nIUlVdZHWmnMcyCtPezNz2TjHs+SIEYyoaJjctmi5O9C
         rumHIhodvwZnN2W1Jvj4x9ytUGBBV7DY8si6BkUwD3gEEdIwgQ+gDB0KWA5k4KJrHxG2
         W/mgmKkTdqL0sLFP+sRtcWW8bx+Az8/yi7E57da7b0HfK08k1bRI5QRUEmpWXvSAJk/X
         3dak6YcHY84Ch778O7mIlZ9222XL8TmzVFhdmxOeBGdmv05oIr49xEEBrl2mPNLv9yo7
         ieUL6k0WNRaEWk+1MI0lmMl92tJOOoNw3ryJF5b20CojpQRvc0za4Z54XuixG4UbMjp+
         eerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748468753; x=1749073553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpEaJTEpfR9+TojleH3uk2aBSDLiXQVkHne1HqD9Ces=;
        b=tVJ+Pavdcpe3FRd1Xo4Mhoy+vr+xaqX5w4brhIRpQZnrhmSKWgvg/Oe2OKB0IhD9Jl
         3QdTc0GDL6QzlI+k33hZ1N4cZKI9k9Y+PL6mRkL0bhbmhOsZvnWq0WDUzdLgec6Q78b0
         XUpF/epG+VvF2NVz5TOm13B/jHoohn35xeZFSDN4v7WEdirwVySJ6rmweRrX3znUc3Kc
         Q4A9DqKlBVLjGys/xXtjBK6EBLm9cegP7iHbfNknpLTSdz/arvz1lwsbePa+RUrsAT+M
         6g20IRx2hemPiMOAIWIxJ2IlcTwmea1934TJf9LUKx/cWL+DD7Pe09jPluqmTwRrNajv
         YfHw==
X-Forwarded-Encrypted: i=1; AJvYcCUaEohQnIAV59YcZuFjaX9m68oVNxdm95hP4u89/CqbiW9J72ASyRGkEV9NNDhrMcYMjbPu4mFK@vger.kernel.org, AJvYcCUvUC0m5dmZ874OT812T4SfUkqWwrPm/PUBz5j7p3A37YKT97OrWiukU+Mt2JB4NpFeMoYbAvVyZuqMsqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RcUJYdsQIqm6CdWLCm2vcdEFMxiDCthH9gRNPwB/xCQaXaxw
	LGSbjLpbW1oUbpaSc2HOBfl/WX/S6+D8Nfr8dEJS3PpF/3Z3fGpze2cfPOZaFFfYsSCNAppU3DT
	RLyBDfCWHPnih4zAEiiALDISEcuEjBSY=
X-Gm-Gg: ASbGncujLcF7kPyusBJHUNTlp4n8FqFNt0eKL3ThvLtaWx2ikpdHAs+9uYxiFSyMwpb
	SUEExiL8FLxs8wDWwmnr9EW/KDriZAV50r44y/BI/KuX1moKVrQZc2PULbCTckBRNAVN1ZU5eJ1
	jejWa5z7Oqjf1k5lO3fpGClTxbso9rN/FTfA==
X-Google-Smtp-Source: AGHT+IGpsHKYbxIXwCy/oeyiPruU2kwkLfCm0N6ezu9dQx6lfofizVF8mmR7cTBw0/YoCHcNbrcZCx1R7ipPXQVnY1Y=
X-Received: by 2002:a05:6122:6185:b0:52f:4624:35ef with SMTP id
 71dfb90a1353d-52f46243757mr6427374e0c.6.1748468753120; Wed, 28 May 2025
 14:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch> <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk> <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch> <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
 <1e6e4a44-9d2b-4af4-8635-150ccc410c22@lunn.ch> <CADvTj4r1VvjiK4tj3tiHYVJtLDWtMSJ3GFQgYyteTnLGsQQ2Eg@mail.gmail.com>
 <0bf48878-a3d0-455c-9110-5c67d29073c9@lunn.ch>
In-Reply-To: <0bf48878-a3d0-455c-9110-5c67d29073c9@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 15:45:40 -0600
X-Gm-Features: AX0GCFsQQOiCt1aAs6THJH6hfyWkXOQcM4Hww3s0-x--VPr5n56VGuMBPUsnYgI
Message-ID: <CADvTj4qab272xTpZGRoPnCstufK_3e9CY99Og+2mey2co6u5dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 3:29=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Describe the one PHY which actually exists in device tree for the
> > > board, and point to it using phy-handle. No runtime detection, just
> > > correctly describe the hardware.
> >
> > But the boards randomly contain SoC's with different PHY's so we
> > have to support both variants.
>
> You have two .dts files, resulting in two .dtb files, which are 95%
> identical, but import a different .dtsi file for the PHY.
>
> You can test if the correct .dtb blob is used by checking the fuse. If
> it is wrong, you can give a hint what .dtb should be used.

How is this better than just choosing the correct PHY based on the
efuse?

> Or, as Russell suggested, you give the bootloader both .dtb blobs, and
> it can pick the correct one to pass to the kernel. Or the bootloader
> can patch the .dtb blob to make it fit the hardware.

This is what I'm really trying to avoid since it requires special
handling in the bootloader and therefore will result in a lot of broken
systems since most people doing ports to H616 based boards will only
ever test against one PHY variant.

> > > Do you have examples of boards where the SoC variant changed during
> > > the boards production life?
> >
> > Yes, the boards I'm working for example, but this is likely an issue fo=
r
> > other boards as well(vendor BSP auto detects PHY variants):
> > https://www.zeusbtc.com/ASIC-Miner-Repair/Parts-Tools-Details.asp?ID=3D=
1139
>
> Mainline generally does not care what vendors do, because they often
> do horrible things. Which is O.K, it is open source, they can do what
> they want in their fork of the kernel.

That's not really true IMO, mainline implements all sorts of workarounds
for various vendor hardware quicks/weirdness.

> But for Mainline, we expect a high level of quality, and a uniform way
> of doing things.

Sure, and I'm trying to do that here rather than do some super hacky
unmaintainable bootloader based device tree selector.

> This can also act as push back on SoC vendors, for doing silly things
> like changing the PHY within a SoC without changing its name/number.

It won't here, because Allwinner doesn't care about non-BSP kernels.

