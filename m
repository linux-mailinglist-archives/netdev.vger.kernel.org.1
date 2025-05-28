Return-Path: <netdev+bounces-194046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC05AC7154
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E53A4E80
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5321ABDD;
	Wed, 28 May 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPAExC0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEB21ABC8;
	Wed, 28 May 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459452; cv=none; b=cxgMspFhsmnzE3/EycISLT+UnuMAAlPYuih7jzl86XGtHmXvKY+Oa1MLvdhMNeBWszc3moXdBcEOlPQcoQPsUyCBFLUp/yS8kIYiEJ+hEG4OcjRk9jM2lMuXLlR1d4wrhTwxSzRS7/lmyZ9vQH4b7QzRBSArpi/pF4jx0S85EaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459452; c=relaxed/simple;
	bh=+vXV8CibleBJLNxJ+dgTqNe61IgPpMT7YMSdJt8YOB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd6Wav6hPChzyl0o8V00HiXIruf9mzLZ6ojttGu3MJDdCy+1IFth49KE6X7XVZv1RaACFDuHTex2xNSjmOhXqxZit07kZubQK0KLSlGcvq6Z+p9+GdudtgkqAPCzQL26+0yekfRwlKxm4OMFVu5kqc1s8If4Hk3F085dGEEABxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPAExC0Z; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso1752956d6.3;
        Wed, 28 May 2025 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459449; x=1749064249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vXV8CibleBJLNxJ+dgTqNe61IgPpMT7YMSdJt8YOB4=;
        b=kPAExC0ZRBjM556DIEaLP2AAGl0iCa1YT8R2eT+j9Q4JOyMKQITtagfIePJhZDh7Qy
         8RzsyifVNPVOL7Mzy9f1EpuatkT2fbJKhwX8ba0nn9BV9zhNlCwL5WETEwqDaTXeRPUh
         fIGcIdHc1juzC0Q6snpzqMUSR4OhJPE+bc4dqSRovZmbBNcMN3taqPGUWZezaPBSQC+n
         vTK+zpPCmJwfzigODB+sTLmDUhlvIQpcnSE5aA9b6Js+ns1bBO7o/rf9f/BJlKBiAN7k
         HYtL6wVFBZ/74F1D7ge9uzcx8Hl6BAkUlR1agj3gEc5LknZNmTd2phJfI+gI4ypT8jZm
         lQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459449; x=1749064249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vXV8CibleBJLNxJ+dgTqNe61IgPpMT7YMSdJt8YOB4=;
        b=YTLcG2lBWVKsz4T+tbnPoOjJzTA5KWnbxB3JaDhTSLyWEVxwsq0PYvYo6J8ksUQQ+B
         TNfP0QBpQ8JOeEN9dJ4/VF6oFYDA6WxbDCzROPd6B+hFeAi+NckVcPyIZOQ0Ct6FFLQb
         JcZ9rwonVJzQguB8ZzQWIB65CM54iANIJ07j85utbq1N4y5aQVaNKgDpHrVSTJTL6pMs
         3uXS9CqYONK8GhfFE0eoH7yjCRJnWgSaLkQHiCvmJCzSjxTFu5JqiauCPJvA6svoe2/+
         8U+TU27VLp7Z3OAYfINJsMHGjGynpZiSbmpjm09dlg+3n9N9KV2tfiljGcY/tmKtKlIC
         ZMFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqDKj7vKZSmVhTf2XMNN1Xe6loB4nlBLu8fw5FxKuC53R3X2GzFBTG6TumxghH25GWjl8gekfJvA14hg=@vger.kernel.org, AJvYcCXE2QPQEoAt13aTz1dVvXua8g1xBt0Vn5AeJh1xBoYwlU1++A97yReXeyeha6rLTJuACUn5IW4z@vger.kernel.org
X-Gm-Message-State: AOJu0YyefnRQ2aYjfhaVfpXdGgB8TrQrjkJiLzFUfzihrEh/G+IiOH2X
	P/i2F4/New9OENc2ngRCb2ZcotwK+tk31PH/9Pfk1rTq/949rYdeODYr8y4iWwdUlMXcrBwGDL3
	9xv37cSUTMSHM209tBQVMnTGo2tOWjKQ=
X-Gm-Gg: ASbGnct2nbDfW3qr7P9FZ49I702hZmFxEdAlRJOX8oT7wjWjbFDwaJZLdLEx8RD14VH
	IeLduO07OpxMfuQ/QCgIUc5+7xAeFfGd5NRVyRR/zV2TCmnNwHeFYY888u+4SzlcpCMz8TOxYPl
	yhzTdczzuUzKtd3dcRrqCwj5oUoObvBsbfmQ==
X-Google-Smtp-Source: AGHT+IGVokqUFuch5bu9nFuPki/cq4vIjcMqBAkbbK4WqjP5C4EtlfVsOQ8KegrxN/Gxv4Xm6H/hNsYjoGFcdfxxUEo=
X-Received: by 2002:a05:6214:2488:b0:6fa:bb74:8d71 with SMTP id
 6a1803df08f44-6fabb749047mr58286646d6.22.1748459449367; Wed, 28 May 2025
 12:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch> <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch> <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk> <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch> <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com> <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk>
In-Reply-To: <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 13:10:38 -0600
X-Gm-Features: AX0GCFuaoONi18V1jbCdzW2xpOvgDWlCjKjVZpkQiI6k60N1aEB22gQ3UxxtMcg
Message-ID: <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: wens@csie.org, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 12:34=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, May 28, 2025 at 11:25:20AM -0600, James Hilliard wrote:
> > On Wed, May 28, 2025 at 8:12=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wr=
ote:
> > >
> > > On Wed, May 28, 2025 at 9:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> =
wrote:
> > > >
> > > > On Wed, May 28, 2025 at 05:57:38AM -0600, James Hilliard wrote:
> > > > > On Wed, May 28, 2025 at 1:53=E2=80=AFAM Russell King (Oracle)
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > > > > > > On Tue, May 27, 2025 at 2:30=E2=80=AFPM Andrew Lunn <andrew@l=
unn.ch> wrote:
> > > > > > > >
> > > > > > > > > Sure, that may make sense to do as well, but I still don'=
t see
> > > > > > > > > how that impacts the need to runtime select the PHY which
> > > > > > > > > is configured for the correct MFD.
> > > > > > > >
> > > > > > > > If you know what variant you have, you only include the one=
 PHY you
> > > > > > > > actually have, and phy-handle points to it, just as normal.=
 No runtime
> > > > > > > > selection.
> > > > > > >
> > > > > > > Oh, so here's the issue, we have both PHY variants, older har=
dware
> > > > > > > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > > > > > > when I surveyed our deployed hardware using these boards many
> > > > > > > systems of similar age would randomly mix AC200 and AC300 PHY=
's.
> > > > > > >
> > > > > > > It appears there was a fairly long transition period where bo=
th variants
> > > > > > > were being shipped.
> > > > > >
> > > > > > Given that DT is supposed to describe the hardware that is bein=
g run on,
> > > > > > it should _describe_ _the_ _hardware_ that the kernel is being =
run on.
> > > > > >
> > > > > > That means not enumerating all possibilities in DT and then hav=
ing magic
> > > > > > in the kernel to select the right variant. That means having a =
correct
> > > > > > description in DT for the kernel to use.
> > > > >
> > > > > The approach I'm using is IMO quite similar to say other hardware
> > > > > variant runtime detection DT features like this:
> > > > > https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366=
db828d845bade3a1
> > > >
> > > > That is for things link a HAT on a RPi. It is something which is ea=
sy
> > > > to replace, and is expected to be replaced.
> > >
> > > Actually it's for second sourced components that are modules _within_
> > > the device (a tablet or a laptop) that get swapped in at the factory.
> > > Definitely not something easy to replace and not expected to be repla=
ced
> > > by the end user.
> >
> > Yeah, to me it seems like the PHY situation is similar, it's not replac=
eable
> > due to being copackaged, it seems the vendor just switched over to a
> > second source for the PHY partway through the production run without
> > distinguishing different SoC variants with new model numbers.
> >
> > Keep in mind stmmac itself implements mdio PHY scanning already,
> > which is a form of runtime PHY autodetection, so I don't really see
> > how doing nvmem/efuse based PHY autodetection is all that different
> > from that as both are forms of PHY runtime autodetection.
>
> What is different is using "phys" and "phy-names" which historically
> has never been used for ethernet PHYs. These have been used for serdes
> PHYs (e.g. multi-protocol PHYs that support PCIe, SATA, and ethernet
> protocols but do not provide ethernet PHY capability).

Hmm, yeah, I had copied the convention used here
https://github.com/torvalds/linux/blob/v6.15/arch/arm64/boot/dts/ti/k3-j784=
s4-evm-quad-port-eth-exp1.dtso#L42-L43

> Historically, "phys" and "phy-names" have been the domain of
> drivers/phy and not drivers/net/phy. drivers/net/phy PHYs have
> been described using "phy-handle".

Yeah, I noticed it wasn't commonly used for ethernet PHYs, but
I didn't see any other way to define multiple named "phy-handle"s
for ethernet PHYs so I tried to use a similar style to serdes.

> So, you're deviating from the common usage pattern, and I'm not sure
> whether that has been made clear to the DT maintainers that that is
> what is going on in this patch series.

Ah, I thought it was fairly clear in the patch descriptions/example
that this was a non-standard situation due to unusual hardware.

> As for the PHY scanning is a driver implementation issue; it doesn't
> have any effect on device tree, it doesn't "abuse" DT properties to
> do so.

I was just pointing that out as an example of runtime autodetection
being something the kernel supports. To me it seems using existing
conventions like "phys" and "phy-names" is the least invasive way
to define phy's that need to be chosen at runtime.

> The PHY scanning is likely historical, probably from times
> where the stmmac platform data was provided by board files (thus
> having the first detected PHY made things simpler.)

I think a lot of ethernet drivers use phy_find_first() for phy scanning
as well so it's not limited to just stmmac AFAIU.

> Therefore, I
> don't think using it as a justification for more "autodetection"
> stands up.

If anything I think the i2c OF component probe functionality is
a much clearer example of precedent for DT integrated runtime
hardware detection since the purpose of that(supporting second
source components within the same device tree) is effectively
the same use case as this efuse based runtime hardware
detection.

