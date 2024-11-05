Return-Path: <netdev+bounces-141737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E29BC27D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1068B2126C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C81C68F;
	Tue,  5 Nov 2024 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClY3iNFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510E168BD;
	Tue,  5 Nov 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769729; cv=none; b=nabeFs7gtg6ebmALrDSFQqJRePlUWahHUgUsrHI47tzs238x4pz8iwl0D3SAZ6woD/JRiqrISwSpAvRAgS/JyJ2UidCCPWk1Nulyry7sivcD6CuZ9x0T4NUnYntFsV9puEr3+HY3yEWoSN4aXrbJOshewErqX2GnKWa1xBFz+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769729; c=relaxed/simple;
	bh=tCezBHR+AU3Fc1qCjRs49S4nsZi324BZ8BZ4BQUucv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igpGcDNpZxH+Ww+bA7vRtZWmM4IQqAPHiTbIOnVWK60PbRw8wuxgfarqyb577HIHBKkGzZvPVd89YEbgrb0/maLDnB+jEXR3LfZ3nIOW66KxH18sXNJPrVAbXgt6qMgDw6Qfyg0IKGo0IMSVyjM1+UK0qQlCHRTYvHWsVwiH6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClY3iNFZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fb1225a89so1452031241.2;
        Mon, 04 Nov 2024 17:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730769727; x=1731374527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7PpwU4l5u2l4cBOPMg04ckyA4nGZAiY09PYAWu+pHI=;
        b=ClY3iNFZPqomT3pcxbyT1w/CriXd60/FCFfBV2TJ1cbgy8Mp2ZzQk40VZ4rcyE+MyV
         nnAzBQUXVyGS+JecS8TluYcDm65V1iFknt34PU60C3OeZFaNtKKbXrbkwFMlqxDgFQSL
         R7iaBOXVbtQGU8BaQYj9To+z/kKKPrI4TcKDOM9pxiP7YOvqc4N2TY5fFPaNF9qy82Pz
         DN3hA4ta1xP19ZXrItgxGmdMN35d9dQ/9gIrDgc1kzl2GdxdxL9Uiaax6VV1QILJ8ss8
         Kr8BbQB+6urYX+UnMW02+kPBIDFXNXfzpdtcQyrpYYttGaSbqyTRcbqc5817288mD4kG
         6EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769727; x=1731374527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7PpwU4l5u2l4cBOPMg04ckyA4nGZAiY09PYAWu+pHI=;
        b=N97cyoOxCKqlqknEhPOANBAxHWXIeiuwG8hvWtooXV5AzJTrWABF7O86rcqvMQkO8y
         Im34PabjCy0amQIlVIi7xgD3SNlox8y1WEDGfZebHC6Ftzs/qxIqztF9VEqXjwSnUO6u
         4OwN4HIVIKpsZ5yTj8IYRRxB5t/8GsUJQDGWg53QPLw+8Azw6TY1l7N05f6Jq7vuspTY
         JVL0F9DeZFP/4H7EoaDQlFYJYsGUFIlLNhp5Gykk877X+cVyhFcao9XWJeR3CehBE13r
         lKGlysXzRB+/2yueuj+R+EmnVGArCbHtEx7tGO0JYXAyPBgJZy0MFQBxdheQ3W8RXMZz
         0hhw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ31K0Si5VMpDKCx5FgT8U4BxdZioWpIsAxPb6TTDSig5IAKrQoIkmAgBLkH3hCkWDwgb6lkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZbjeJ8n1eR5ZHqcbYGNIwlogW7RR8MlEJ1SsR4DlkensJ7mc
	/jxwkLEKGyousWERqT1fS3sPyFfLZ5FhUgnNk8ce5lNpvftTGlpnFwXfZyHjuVcqal6UaC8oYc4
	TOkl8E1VGSEZusf/CoZpndHTYppwSm3Ye
X-Google-Smtp-Source: AGHT+IG/uLpQWo2MPQvBC9Ui+c5pPAAagEbsIBPzcSjT7zoyWSnRJK3I205364ioYnyy+xPM9Vd9MpXPRAyXBdW/lT8=
X-Received: by 2002:a05:6102:374a:b0:4a3:d434:de03 with SMTP id
 ada2fe7eead31-4a8cfd304d3mr30764658137.23.1730769726800; Mon, 04 Nov 2024
 17:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104070950.502719-1-alistair.francis@wdc.com>
 <9ae6af15-790a-4d34-901d-55fca0be9fd2@lunn.ch> <CAKmqyKOX8gcRT2dSOvJY2o4bpoF+VuPmhaygJj7pTb1KesrFOQ@mail.gmail.com>
 <680bd06f-6a76-4a5c-b5d2-51dd172c8428@lunn.ch>
In-Reply-To: <680bd06f-6a76-4a5c-b5d2-51dd172c8428@lunn.ch>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 11:21:40 +1000
Message-ID: <CAKmqyKNkPGPg8xsYDY9FtNvqJQsFmQ1o8KYHQXutrN1kHxsPww@mail.gmail.com>
Subject: Re: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux@armlinux.org.uk, hkallweit1@gmail.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:37=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Nov 05, 2024 at 10:21:15AM +1000, Alistair Francis wrote:
> > On Mon, Nov 4, 2024 at 11:49=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > On Mon, Nov 04, 2024 at 05:09:50PM +1000, Alistair Francis wrote:
> > > > The static inline functions mdio45_ethtool_gset() and
> > > > mdio45_ethtool_ksettings_get() call mdio45_ethtool_gset_npage() and
> > > > mdio45_ethtool_ksettings_get_npage() which are both guarded by
> > > > CONFIG_MDIO. So let's only expose mdio45_ethtool_gset() and
> > > > mdio45_ethtool_ksettings_get() if CONFIG_MDIO is defined.
> > >
> > > Why? Are you fixing a linker error? A compiler error?
> >
> > I'm investigating generating Rust bindings for static inline functions
> > (like mdio45_ethtool_gset() for example). But it fails to build when
> > there are functions defined in header files that call C functions that
> > aren't built due to Kconfig options.
>
> Since this does not appear to be an issue for C, i assume these
> functions are not actually used in that configuration. And this is
> probably not an issue specific to MDIO. It will probably appear all
> over the kernel. Adding lots of #ifdef in header files will probably
> not be liked.

It's not actually a Rust issue, it's a problem with linking.

This is the type of errors I get

```
ld: vmlinux.o: in function `mdio45_ethtool_gset':
/scratch/alistair/software/linux/./include/linux/mdio.h:189:(.text+0x59e819=
):
undefined reference to `mdio45_ethtool_gset_npage'
ld: vmlinux.o: in function `mdio45_ethtool_ksettings_get':
/scratch/alistair/software/linux/./include/linux/mdio.h:206:(.text+0x59e839=
):
undefined reference to `mdio45_ethtool_ksettings_get_npage'
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
```

Which comes from autogenerated C code like this

```
void mdio45_ethtool_gset__extern(const struct mdio_if_info *mdio,
struct ethtool_cmd *ecmd) { mdio45_ethtool_gset(mdio, ecmd); }
```

mdio45_ethtool_gset__extern() is never called, so I'm not clear why
it's not optimised out.

It's not only MDIO that hits this, but so far there aren't too many
cases. That will obviously depend on the config used though.

There will be issues like this over the kernel. I'm not sure fixing
them all is the right approach as it might be too much work and too
hard to narrow down all occurance. But to me it seems like the corect
fix as the current code is calling a function that might not exist,
hence the patch :)

If it's not something that we think should be fixed then that's fine,
I can work around it.

Alistair

>
> Does Rust have the concept of inline functions? If it is never used,
> it never gets compiled? Or at least, it gets optimised out before it
> gets linked, which i think is your issue here.
>
>         Andrew

