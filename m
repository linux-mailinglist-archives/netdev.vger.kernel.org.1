Return-Path: <netdev+bounces-194448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DCAC988B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 02:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BCC3B00AB
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD502904;
	Sat, 31 May 2025 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJoVWst3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A8195;
	Sat, 31 May 2025 00:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748649792; cv=none; b=QlSbh2BUEZWqKywOh0LbzTP2N1KhDi8QsP6QkN549PERpVeZ1BNYFZQcWcBkWQ2sZ+ZaVgefUtN4MvqFNvzzJ77ifFYqTVKGdbTXVPeY5zBkQoqiJ9sIT0/hLGp69EEMGCNSmEBUvxthTHfm2RVRV5nDvV8mNSp59Hc1Ai68Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748649792; c=relaxed/simple;
	bh=w/dKbBbIAJRxT8vr39V0wwDize8rkJ2vri92QYY0yFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC7xZNL1qimZdOc0B9YcmTNEAOGIijIY+Y2xacVR93GzemICp8sTOIP0Y8qnVAjd25G2U7ngUu7WjEKztnhGk1txMVnBZNaSkXLtabKXDPuJn+72rDxFshu8yzFJMlTb7UJqourC7jwj2wXOlDswfZQuub0Def/iLwuSUIQC8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJoVWst3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c559b3eb0bso167380485a.1;
        Fri, 30 May 2025 17:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748649789; x=1749254589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/dKbBbIAJRxT8vr39V0wwDize8rkJ2vri92QYY0yFU=;
        b=iJoVWst3BaY/sY8bswmnLJvIIkoDYJ060iS3JEcScBoYKmsGYNtQYjax8jbEEODB91
         CbJXioMLP8w/SY8iwYVA9Nsn0cqJ2cOcKNQJQXGC2GLTrRgIQoZP8/OLj0Nuy6bd7NCR
         6n9Cu2FOBTS8uAUsPyzHLY9iiEEq1Xxes9FPCElDYe8RTbtiwlS0IA2tWYC4ManqSnHd
         j5iuiB/tgLXlcTeKDtBk7xgmqljSgUIULMQbGk/aAebPiWjH/TJuCRuUInakUFp7tUmc
         ida2nslWgHQphRHgVCYoiqDeuYsdhiZGF0N+fXt9B8AmUwFkUO8eqaG7opJKu5UBmmHb
         kJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748649789; x=1749254589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/dKbBbIAJRxT8vr39V0wwDize8rkJ2vri92QYY0yFU=;
        b=i+K438gZkQdoy5/7CKheKY7h1QLRPxRQW4W52GUKsb5pi8l6HYdsKS6qaZGsbQrvl+
         gd0WUeTvRz5GiszFNH9dZYk+nFTI+O6d0IfUP4LIoCjKXMfpP+ntrZbgFaJzQqeUDP+E
         ew72yIKdH8a/6bQzFt+K4yIAlTJtYsKWKgMLW8quct43Z+hKu3R9qWvXFmTQVWJWU2PC
         qNapBUgP9VdgByFmVDpy//4rxs+WggnkrM5JBiNjaAyhBjk7TxbsD4FShIGvYxnd50X7
         pugHg+bGlZNM8Hlh8dWJ/D5tMdJtSylDIXCwfT7AKYvIKw+DFGPlFPZtNbcUYgMinppY
         SmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9SKlfxXsc/4VMktD6KqLxFoNaaOQHZMM/h/6fijKfIi504E9oxWtQo5cbSfVICotiCE6rvmra@vger.kernel.org, AJvYcCXvgzgLXdpmOUc4DRAVbSgSs9DMK5+J+zyuOIAtTk/HsOeBucf6uC+EKjtFNnYkeHtBi3i2C83aLCrFsk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKmcz2puT/aXeZoftXiig5KDtUwe4DQc3A2cC+LyNF+kvmyni
	n28WJdWAqgG0GnF6drjk4Y40d/fkUFwONaOqk0CKwbpBD8dCuauqGWer6icrPcJOTCz2pssTYsT
	n3jC1+2Sw6mLlIS86ZSFWinzO9qgsDSI=
X-Gm-Gg: ASbGnctmWhXe28Kfpge8QEqI5e5ap2MfaxC+Q4vKkvbVqPXEatC/LFTm47IJ8TsJA6+
	d5V4FtmRbjPDopGDLyL+pOm6YJEGRfrbPyroMv7LZIgSc9vo07V6EApUJtk+cbtObqOx5MhBevl
	mN2XjhZGSgRvCyHrfbztmJ32aDZOz/7/7pfg==
X-Google-Smtp-Source: AGHT+IHYyJlGTtpjLfDS2korruhddZalmtfRzHquW+3WyYzNkhp5Cmo7Al9su+C9WS0W0IHm4jkhbhjqHsgACCoVWZw=
X-Received: by 2002:a05:620a:4508:b0:7ce:f58e:7e9c with SMTP id
 af79cd13be357-7d0eac3dc9bmr54414885a.7.1748649789320; Fri, 30 May 2025
 17:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch> <CADvTj4posNXP4FCXPqABtP0cMD1dPUH+hXcRQnetZ65ReKjOKQ@mail.gmail.com>
 <e1f4e2b7-edf9-444c-ad72-afae6e271e36@gmail.com>
In-Reply-To: <e1f4e2b7-edf9-444c-ad72-afae6e271e36@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 May 2025 18:02:58 -0600
X-Gm-Features: AX0GCFszR54VKhpbiCp7QT24c4JTQPW5wRggeGSsldqyRuwmihD2lRx7cFJ2K-I
Message-ID: <CADvTj4oSbYLy3-w7m19DP-p0vwaJ8swNhoOFjOQiPFA24JKfMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 5:56=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 5/30/25 16:46, James Hilliard wrote:
> > On Tue, May 27, 2025 at 2:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> >>
> >> On Tue, May 27, 2025 at 01:21:21PM -0600, James Hilliard wrote:
> >>> On Tue, May 27, 2025 at 1:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> =
wrote:
> >>>>
> >>>> On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
> >>>>> Some devices like the Allwinner H616 need the ability to select a p=
hy
> >>>>> in cases where multiple PHY's may be present in a device tree due t=
o
> >>>>> needing the ability to support multiple SoC variants with runtime
> >>>>> PHY selection.
> >>>>
> >>>> I'm not convinced about this yet. As far as i see, it is different
> >>>> variants of the H616. They should have different compatibles, since
> >>>> they are not actually compatible, and you should have different DT
> >>>> descriptions. So you don't need runtime PHY selection.
> >>>
> >>> Different compatibles for what specifically? I mean the PHY compatibl=
es
> >>> are just the generic "ethernet-phy-ieee802.3-c22" compatibles.
> >>
> >> You at least have a different MTD devices, exporting different
> >> clocks/PWM/Reset controllers. That should have different compatibles,
> >> since they are not compatible. You then need phandles to these
> >> different clocks/PWM/Reset controllers, and for one of the PHYs you
> >> need a phandle to the I2C bus, so the PHY driver can do the
> >> initialisation. So i think in the end you know what PHY you have on
> >> the board, so there is no need to do runtime detection.
> >
> > Hmm, thinking about this again, maybe it makes sense to just
> > do the runtime detection in the MFD driver entirely, as it turns
> > out the AC300 initialization sequence is largely a subset of the
> > AC200 initialization sequence(AC300 would just not need any
> > i2c part of the initialization sequence). So if we use the same
> > MFD driver which internally does autodetection then we can
> > avoid the need for selecting separate PHY's entirely. This at
> > least is largely how the vendor BSP driver works at the moment.
> >
> > Would this approach make sense?
>
> This has likely been discussed, but cannot you move the guts of patch #2
> into u-boot or the boot loader being used and have it patch the PHY
> Device Tree node's "reg" property accordingly before handing out the DTB
> to the kernel?

No, that's not really the issue, the "reg" property can actually be
the same for both the AC200 and AC300 phy's, both support using
address 0, the AC200 additionally supports address 1. In my example
they are different simply so that they don't conflict in the device tree.

The actual issue is that they have differing initialization sequences and
won't appear in mdio bus scans until after the initialization is complete.

> Another way to address what you want to do is to remove the "reg"
> property from the Ethernet PHY node and just let of_mdiobus_register()
> automatically scan, you have the advantage of having the addresses
> consecutive so this won't dramatically increase the boot time... I do
> that on the boards I suppose that have a removable mezzanine card that
> includes a PHY address whose address is dictated by straps so we don't
> want to guess, we let the kernel auto detect instead.

Yeah, I noticed this, but it doesn't really help since it's not the address
that's incompatible but the reset sequence, I'm having trouble finding
examples for mdio based reset drivers in the kernel however.

