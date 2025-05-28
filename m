Return-Path: <netdev+bounces-193979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE0AC6B75
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0073B22A3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096FB2882A6;
	Wed, 28 May 2025 14:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320E19B3CB;
	Wed, 28 May 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441532; cv=none; b=P7RNQ1cXCQYlYNUkzhpMswWlMMFliyYQ6UBpO+NbASvhWu24mTTXe/bSBhvJr0HQLM9DNbHK+Pu/IF3uZAxlaOKRwdgQLNp0laWuo38H2cnGLIyceckD7Gs9FpBX8nBg+ySawJ97+aFgHWCogLXb7Kl0TIm5JKhbX1NSEjqXSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441532; c=relaxed/simple;
	bh=RgnF/poN7NkMo2BBglJzOP/AgJJGoqN5W76orbXdxCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVaQpTqMB28ReTURkX2pEz4t74SjH5h9oiFxJz763TpweHf6fappqIw0UYTqRfkqYyEXNMZdzRPvznQ/ze8Fc2NSyR4lCwiJllTpR7RqsfCiJOFeO4+/H0Bkw58ELkhxVOCpUSsFVz2D7kNXHwJUQ6hzdA/BtalQQ5i9rdW6bwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55329bd977aso944117e87.1;
        Wed, 28 May 2025 07:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748441527; x=1749046327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ksdw7M5oeACHV4O06/7f6T9AIjZYxql+qwEMoPd8Euo=;
        b=FMYztMJhhU1xXoh0DDkL9wzlxXzxnqlLpHBF/Pbo3LZLpYz2k381a2e+SJA+YLyWOn
         1wO0cxCxZrDFZqh1Kzs6ft/L6dvrrD5KJXaCPqXg3vHFU4ke5siQnA8EGRAeQxBtxnfj
         LDbzNftwiAEZIbYOvD99h8Xi2SHMHlleuZyNgQ0tk0vwP0sFEvg0P3SG6hbyjEqU1gzP
         hvpgQo1z1eLNaDEPUhuFnZOuc3ZghUBm07M1ndzVw4taWz02Kxx6qsJf4+I7lN9TQ+qh
         2aNilZsT1NgGcFcahvR9Ylxqqyx5i/9a2u1ZjTCDzchVTEBGHMiP0Q3PEO3mWERyRKdD
         tctg==
X-Forwarded-Encrypted: i=1; AJvYcCVf4cSbbZgitCIpodZbYpgPPzUTlLG46Ke9E9S4Lbxnr1TDbymiMtqzluXQL8XDT5L4L3kpAmRX82PJcAo=@vger.kernel.org, AJvYcCVoQeqNpgoEio6x6zWOsc+PAhjUt3DpmeAdsHHtGkoyTEjk379HDpNkrE1OFB4V2R3VC3L3obYX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cBcNcetFVqbe0HxArkDH1Dlnxb05qjGkI5RmubDZC4A9jBhc
	Qm8i9B09fB64BLlU5InoIsdnAqyi59NWDLWluAgxcj0+9JGX5GvVd5CtixaYS35f
X-Gm-Gg: ASbGncvyWvtlFBvESV5NJhTzLQvh7lugiuj9a/TnqL6aJeKrn7VtdNxwhC98XSe6itE
	9Q35CG9/l8mw7Olb1yFpopuiq5rfpU60r4rThmIrIX7T319F1ucxixPHZcKFZcXSW7YuQ/JgJ4I
	S5rY/4/3x42LTpEIKS29ewIXa7ocWmXhnzSjb79QuDg7xsXB5OVe6tteR/ARUQRvuQKjovQeKpD
	saJUga+WDg91wkHS6Pk+OwGnT2aq+eUVlza888QZRF1n42Ma/WiG5KL/Bd6VvjKp0IPIfAelfh9
	/0J0BLoEgrCN37TI4qrh4/vKTzzdkrxczK0ooJyB1NmXQBbKfkynAaBBC9B6HUniIvv5ucQOyJa
	pDFBkEkRN
X-Google-Smtp-Source: AGHT+IHPkU1HOH6Azz6SI+m7AVROLNZoTJwibx8Ipm/kJ+LLQsZKFeo76hF6rK47R6w0jKpxMgLJaA==
X-Received: by 2002:a05:6512:3408:b0:549:8c0c:ea15 with SMTP id 2adb3069b0e04-5532ccfd942mr1828332e87.0.1748441526984;
        Wed, 28 May 2025 07:12:06 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5532f6a5f86sm296428e87.179.2025.05.28.07.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 07:12:05 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32a61af11ffso11488781fa.1;
        Wed, 28 May 2025 07:12:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlBMpyE66xpTY2OvcrFGKjdo85mlQXDEi7u3DIyH6wuBoQs4wh7mVutBRl7PxOmcdbXULXyP0Fh/LwLqM=@vger.kernel.org, AJvYcCW0aapBmvDVZFKvc782+pbCxZnZ+KIEZWGgA9lLzrrjvZ1HLFy4cxNSqFNdVHemD1ldXU0RB/wJ@vger.kernel.org
X-Received: by 2002:a05:651c:418e:b0:326:cf84:63c4 with SMTP id
 38308e7fff4ca-32a736a7554mr15406341fa.1.1748441525068; Wed, 28 May 2025
 07:12:05 -0700 (PDT)
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
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch>
In-Reply-To: <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 28 May 2025 22:11:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
X-Gm-Features: AX0GCFvkvTc-VRmYOaYU5xGuR2czReptL7cuDFoxwx0sxNWmjpy1lDF4i_MRIR8
Message-ID: <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 9:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, May 28, 2025 at 05:57:38AM -0600, James Hilliard wrote:
> > On Wed, May 28, 2025 at 1:53=E2=80=AFAM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > > > On Tue, May 27, 2025 at 2:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch=
> wrote:
> > > > >
> > > > > > Sure, that may make sense to do as well, but I still don't see
> > > > > > how that impacts the need to runtime select the PHY which
> > > > > > is configured for the correct MFD.
> > > > >
> > > > > If you know what variant you have, you only include the one PHY y=
ou
> > > > > actually have, and phy-handle points to it, just as normal. No ru=
ntime
> > > > > selection.
> > > >
> > > > Oh, so here's the issue, we have both PHY variants, older hardware
> > > > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > > > when I surveyed our deployed hardware using these boards many
> > > > systems of similar age would randomly mix AC200 and AC300 PHY's.
> > > >
> > > > It appears there was a fairly long transition period where both var=
iants
> > > > were being shipped.
> > >
> > > Given that DT is supposed to describe the hardware that is being run =
on,
> > > it should _describe_ _the_ _hardware_ that the kernel is being run on=
.
> > >
> > > That means not enumerating all possibilities in DT and then having ma=
gic
> > > in the kernel to select the right variant. That means having a correc=
t
> > > description in DT for the kernel to use.
> >
> > The approach I'm using is IMO quite similar to say other hardware
> > variant runtime detection DT features like this:
> > https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366db828d=
845bade3a1
>
> That is for things link a HAT on a RPi. It is something which is easy
> to replace, and is expected to be replaced.

Actually it's for second sourced components that are modules _within_
the device (a tablet or a laptop) that get swapped in at the factory.
Definitely not something easy to replace and not expected to be replaced
by the end user.

The other thing is that there are no distinguishing identifiers for a
device tree match for the swap-in variants at the board / device level.
Though I do have something that does DT fixups in the kernel for IDs
passed over by the firmware. There are other reasons for this arrangement,
one being that the firmware is not easily upgradable.

ChenYu

> You are talking about some form of chiplet like component within the
> SoC package. It is not easy to replace, and not expected to be
> replaced.
>
> Different uses cases altogether.
>
> What i think we will end up with is the base SoC .dtsi file, and two
> additional .dtsi files describing the two PHY variants.
>
>         Andrew
>

