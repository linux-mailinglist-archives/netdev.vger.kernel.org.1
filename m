Return-Path: <netdev+bounces-194035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023FAC6F3E
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ADE18826B3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176127A110;
	Wed, 28 May 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoiYCpYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF11EE7B7;
	Wed, 28 May 2025 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453136; cv=none; b=PrHOsGr4A50p6DBJH/q54pXaS0OEBZlQI9mTBNQU5sl4F6VAHCwD6g3Am3XwloLXrfWOgP2aVIu/Omv0zzCwdslzcGlTiSkQ3f9bOco/jZ584arM2auSS1quxsYWeNcAaOma0U+u1rbYEYF6x3QcxF+p4xQwGr0RNDkNsVPmL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453136; c=relaxed/simple;
	bh=/OzUyuVqnOB7miLFV37uZy05en+YqG3p0V1Vv2/8lTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqvKphxCs1HEdDEuelCY7LbSpv/Hbnbz3bD5g4inxmkmg4YVuWwfYBVwpCWv9Mz8/R5z88x8gjDeODRRAK1+AV6ox8Qomk5s6gfQHDQEvGX0AOnB/a2HzyhI6isnoKo4bn4XGZwnVdXeVoDt21cBN6khTBXPcTEaFwByC/EfMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoiYCpYt; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso926686d6.3;
        Wed, 28 May 2025 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748453134; x=1749057934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OzUyuVqnOB7miLFV37uZy05en+YqG3p0V1Vv2/8lTk=;
        b=RoiYCpYt9dX/nmBRfRsDFN8/QyIo61MOVV1xymizxstQ9HK4murJufDE9NxDw5bj/N
         DfNHKPF9IH3tVSeSrP3FUvQZYNJlAzJZqcgN9E7RsthTQywnC2Yr27MqDmLkONzXqZvx
         TtobWHmtDzvh6dGuvOlary7ATwxGMpM+TqXk2SYXAw7+QBU6v763WJBZcmkgHwDVTSU3
         QSM0Gs0aGwxwxET/QRjO8vjiFYbjKF07cUpK8/R665jsUAe7WHBSs/QwB9HReWNP+c3W
         fe5krBdphLuyEG/TcyFfxAmgBI3lW6lhTYcLm6WYfBckLWQ/uA2jl5QPivCIKUvvIUMS
         VCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453134; x=1749057934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OzUyuVqnOB7miLFV37uZy05en+YqG3p0V1Vv2/8lTk=;
        b=ih1O9HkdA/2PaGM+1F+cgvH+FAkDwCn2SqOTPPMJ8RWLtTtY/9PM8TOVTjkLJ5oFB1
         QpWXDPjsvrpaDNLuh0qT3V+DrN0GW59sWHkUzNDb98nBgRvANPcOsWl/o/RaHMV32NHc
         xKH4/T2uZUyBNYGDfOvL4WOiJ5CJYp9j7gA0A9+kiR+XlgBtafcQlB5G/cc/LGwtEPrN
         UIu/c6bNV0zfv6oU376+H3hbafl4+XoxfnhJsTy8zQF5AZ4Az+joTPIN/j1t3yaDQz7L
         wuXJWgeP4ECMET2SA9J2BE4pO6JQExcwqc9mYKnuoSBJz8jDPOoKujP9BIp4s3qR49qy
         AB1g==
X-Forwarded-Encrypted: i=1; AJvYcCU5IS96gb2s5UjeXQ1IfiFgtZAe1p+LZ5RuNgHtQ6Md/0zZWl3zt0wybrnNnH/qmbwbBo7/eqavWanTofk=@vger.kernel.org, AJvYcCVop4KJYAxpaNmCNlGikX8OSCxhaXGOF6DxnMgKyLCjntb6oDQjuiNZ0bwLlM7gzTAiySooXioZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywny9iw6NBgVu5/ON5FUgjmVdZDc/FobUW1z3ttveN8ZE9UKz9i
	B64BQQJuBMp1LPVe0t9WREOLXT08GeYN697t5xEONXjY3c5Aw2a5WB86WcU1aAH2F/PSfh4CXpn
	mxJms7xku7aPpvY/99JEK3IXMbfipCJw=
X-Gm-Gg: ASbGncvv08Dy4EGzgBLHp/SmpAiN3X4hhQBox5imPWGftiYZ20qqiCEO5L4zWrrIRGT
	USAbl/QZ+TL8OWNB4Eg6RwTk6SlSNA347I/B0ti/izHrkR2bg4djyYnXAiYH507Dmmps+hWB6KR
	QTTm5ThMmIFRuqkKmqGbITwYh1wa1NcHuP6A==
X-Google-Smtp-Source: AGHT+IER5qx1DwG+fJoBcyq/OD8RJi4KmfX7CsQR2aaR2iNxoMBecCu9w8+lxoiC4pk7miaSH11257NF0qW83P2oVoA=
X-Received: by 2002:a05:6214:20e5:b0:6e8:9dc9:1c03 with SMTP id
 6a1803df08f44-6fa9d290768mr317566926d6.21.1748453133588; Wed, 28 May 2025
 10:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch> <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch> <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk> <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch> <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
In-Reply-To: <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 11:25:20 -0600
X-Gm-Features: AX0GCFveR1vAlsAT85LmMrDh-cWJLkLNiCTzyzcFYtPEIKrvDRjHUdM3zbS3iJQ
Message-ID: <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: wens@csie.org, Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:12=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, May 28, 2025 at 9:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Wed, May 28, 2025 at 05:57:38AM -0600, James Hilliard wrote:
> > > On Wed, May 28, 2025 at 1:53=E2=80=AFAM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > > > > On Tue, May 27, 2025 at 2:30=E2=80=AFPM Andrew Lunn <andrew@lunn.=
ch> wrote:
> > > > > >
> > > > > > > Sure, that may make sense to do as well, but I still don't se=
e
> > > > > > > how that impacts the need to runtime select the PHY which
> > > > > > > is configured for the correct MFD.
> > > > > >
> > > > > > If you know what variant you have, you only include the one PHY=
 you
> > > > > > actually have, and phy-handle points to it, just as normal. No =
runtime
> > > > > > selection.
> > > > >
> > > > > Oh, so here's the issue, we have both PHY variants, older hardwar=
e
> > > > > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > > > > when I surveyed our deployed hardware using these boards many
> > > > > systems of similar age would randomly mix AC200 and AC300 PHY's.
> > > > >
> > > > > It appears there was a fairly long transition period where both v=
ariants
> > > > > were being shipped.
> > > >
> > > > Given that DT is supposed to describe the hardware that is being ru=
n on,
> > > > it should _describe_ _the_ _hardware_ that the kernel is being run =
on.
> > > >
> > > > That means not enumerating all possibilities in DT and then having =
magic
> > > > in the kernel to select the right variant. That means having a corr=
ect
> > > > description in DT for the kernel to use.
> > >
> > > The approach I'm using is IMO quite similar to say other hardware
> > > variant runtime detection DT features like this:
> > > https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366db82=
8d845bade3a1
> >
> > That is for things link a HAT on a RPi. It is something which is easy
> > to replace, and is expected to be replaced.
>
> Actually it's for second sourced components that are modules _within_
> the device (a tablet or a laptop) that get swapped in at the factory.
> Definitely not something easy to replace and not expected to be replaced
> by the end user.

Yeah, to me it seems like the PHY situation is similar, it's not replaceabl=
e
due to being copackaged, it seems the vendor just switched over to a
second source for the PHY partway through the production run without
distinguishing different SoC variants with new model numbers.

Keep in mind stmmac itself implements mdio PHY scanning already,
which is a form of runtime PHY autodetection, so I don't really see
how doing nvmem/efuse based PHY autodetection is all that different
from that as both are forms of PHY runtime autodetection.

https://github.com/torvalds/linux/blob/v6.15/drivers/net/ethernet/stmicro/s=
tmmac/stmmac_mdio.c#L646-L673

> The other thing is that there are no distinguishing identifiers for a
> device tree match for the swap-in variants at the board / device level.
> Though I do have something that does DT fixups in the kernel for IDs
> passed over by the firmware. There are other reasons for this arrangement=
,
> one being that the firmware is not easily upgradable.
>
> ChenYu
>
> > You are talking about some form of chiplet like component within the
> > SoC package. It is not easy to replace, and not expected to be
> > replaced.
> >
> > Different uses cases altogether.
> >
> > What i think we will end up with is the base SoC .dtsi file, and two
> > additional .dtsi files describing the two PHY variants.

I think having a single PHY .dtsi for both here is ideal if we can
do runtime detection, since it's difficult to know which potential
variants of PHY various devices shipped with, in our case we
have access to enough hardware to determine that we have
both variants but for other devices most developers will likely
only have access to one PHY variant even if hardware at various
points in time may have shipped with both variants.

IMO without runtime detection this will likely be a major footgun
for anyone trying to add ethernet support to H616 boards as they
will have difficulty testing on hardware they don't have. If we provide
a single .dtsi that implements the autodetection correctly then they
will simply be able to include that and the hardware will then likely
function on both variants automatically by including the single .dtsi
file.

Requiring the bootloader to modify the DT adds a good bit of
complexity and will be difficult for most developers to test as
many will not have access to hardware with both PHY variants.

