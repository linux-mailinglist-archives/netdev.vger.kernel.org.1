Return-Path: <netdev+bounces-204651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645CFAFB9F5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F219189E911
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB322253BC;
	Mon,  7 Jul 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+RNW+Bz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451541F4192;
	Mon,  7 Jul 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909703; cv=none; b=P4QugemOmJ92axjJrPY+eHG5o9lPXoWom15ptMDQ0h797HYADw1IUtDiTgxk7v9w/i+Cp/IjqZjN/f9dLz6jsQEsF+PEh8vCmrsWCF8eNWhuQlvwUYgdKVxsYSGRXtWQFZHRB3Bfg2iYtCCQ57PA9ZHPktL/i0vjRk5vP7M8SjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909703; c=relaxed/simple;
	bh=O2JN6S7yUjtZ5614ufaGRXdRQ2/PylgFkAVfo9SYR1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRnqnbQSK8m2OZh5mLejYd77x+a5sfOB1Dsc0OFHy/j5ob6AQWTWsVCBvuxrhQyXi9NwBebFD8c0XXWBvdSFK709xBhhcY+G0rPyl5CZqc00ZY1b6cpM7lcrBRmppO/2Vlh1Ob8Fn+0fG+W3yQbPt69v0y+fNzBjHRMYNLUf/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+RNW+Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A45C4CEFA;
	Mon,  7 Jul 2025 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751909702;
	bh=O2JN6S7yUjtZ5614ufaGRXdRQ2/PylgFkAVfo9SYR1g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=F+RNW+BzPadulCJB0CA09JWF7YO/MhLLMmXvUZgJvf/x1srOti75U+WFxwcIFoACB
	 2PaB/91o05oay79AMwei4NgUYYiMVwsXviilybgrz/6HDnwiwNt7UDkvQ5wTgQ315M
	 RKQX0Ns/E0L2FeNlMQhVjQ+dKWk410GKFICJga/AusDSc344LRemaLm/VhNLFpg2Z7
	 gRk2jb/QuqFbRsRKuyuS88xSfee6GclfhqdB6vVTSfibH2MrgLsYJqcTiTg7of1QfE
	 RdsP+ZZAvPZXl3KuvKw06S+cqWc/Ajnavcs549+pdXgY8VTw3lq4VVLgVAjPhq8Xtd
	 J83SnFi4nGrGw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553dceb345eso4042079e87.1;
        Mon, 07 Jul 2025 10:35:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW52Ifjx7StJZL6TXtESmp2ZLdg9TderGXcoI8kI4f3te4RH4G1dhWMqcQpzieR02mkwNhW95h7@vger.kernel.org, AJvYcCXFHOLZcuAM/obnoFxpVqUxvrhU3ZvR2/l0WwSgPYjlXeQmZ/jXfkCLeXcpfkPg123/7TnoxcrN8KpD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzug7UPvLaGBdGlI9C3csKV59dExneAY+UW0XiB5cBrI24OFpQ4
	nQh9L8IRrooPlFiWVkaF9ZtQP/iQRVqSUdo/7UJF3QF9pEOkfjYEBnYsqdoucVkmYLJK4XsSYM7
	Q2zLIUf9O4ACK5ZlM6FZVjhgNZ1sGzCU=
X-Google-Smtp-Source: AGHT+IGOttXp/lkLoXck4zz9g7NH+hpLyXdxDc6Zd3dXWLU0JpEMOgZlssrJ930cSWYiNmZYPR2XYxUcHWoDaQuCREs=
X-Received: by 2002:a05:6512:3c84:b0:553:297b:3d4e with SMTP id
 2adb3069b0e04-556de363d36mr3692791e87.52.1751909701165; Mon, 07 Jul 2025
 10:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628054438.2864220-1-wens@kernel.org> <20250705083600.2916bf0c@minigeek.lan>
 <CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
 <e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch> <20250706002223.128ff760@minigeek.lan>
 <CAGb2v64vxtAVi3QK3a=mvDz2u+gKQ6XPMN-JB46eEuwfusMG2w@mail.gmail.com> <20250707181513.6efc6558@donnerap.manchester.arm.com>
In-Reply-To: <20250707181513.6efc6558@donnerap.manchester.arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 8 Jul 2025 01:34:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v64UTr1YSm7VXtzk5jmD_J_20ddPcWww_NPzx-e5HvaOpQ@mail.gmail.com>
X-Gm-Features: Ac12FXyqsURdwW8NxdfSatuYRJXxqkCB1KgR0rqYcDDm60yVTu4owZ1DToV_pqQ
Message-ID: <CAGb2v64UTr1YSm7VXtzk5jmD_J_20ddPcWww_NPzx-e5HvaOpQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 1:15=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> On Sun, 6 Jul 2025 21:14:09 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> > On Sun, Jul 6, 2025 at 7:23=E2=80=AFAM Andre Przywara <andre.przywara@a=
rm.com> wrote:
> > >
> > > On Sat, 5 Jul 2025 17:53:17 +0200
> > > Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > Hi Andrew,
> > >
> > > > > So it's really whatever Allwinner wants to call it. I would rathe=
r have
> > > > > the names follow the datasheet than us making some scheme up.
> > > >
> > > > Are the datasheets publicly available?
> > >
> > > We collect them in the sunxi wiki (see the links below), but just to
> > > make sure:
> > > I am not disputing that GMAC is the name mentioned in the A523 manual=
,
> > > and would have probably been the right name to use originally - even
> > > though it's not very consistent, as the same IP is called EMAC in the
> > > older SoCs' manuals. I am also not against renaming identifiers or ev=
en
> > > (internal) DT labels. But the problem here is that the renaming affec=
ts
> > > the DT compatible string and the pinctrl function name, both of which
> > > are used as an interface between the devicetree and its users, which =
is
> > > not only the Linux kernel, but also U-Boot and other OSes like the BS=
Ds.
> >
> > I reiterate my position: they are not stable until they actually hit a
> > release. This provides some time to fix mistakes before they are set in
> > stone.
> >
> > > In this particular case we would probably get away with it, because
> > > it's indeed very early in the development cycle for this SoC, but for
> > > instance the "emac0" function name is already used in some U-Boot
> > > patch series on the list:
> > > https://lore.kernel.org/linux-sunxi/20250323113544.7933-18-andre.przy=
wara@arm.com/
> > >
> > > If we REALLY need to rename this, it wouldn't be the end of the world=
,
> > > but would create some churn on the U-Boot side.
> > >
> > > I just wanted to point out that any changes to the DT bindings have
> > > some impact to other projects, even if they are proposed as a coheren=
t
> > > series on the Linux side. Hence my question if this is really necessa=
ry.
> >
> > For the compatible string, I can live with having a comment in the bind=
ing
> > stating the name used in the datasheet for reference.
>
> For the compatible string going with a fallback name, I can live with
> renaming it ;-)
>
> > For the pinctrl stuff, which is the contentious bit here, I thought the
> > whole idea of the newer pinctrl bindings is that the driver uses
> > "allwinner,pinmux" instead of "function". I think having both being val=
id
> > is confusing, and likely to cause conflicts later on. If we're going to
> > use the hardware register values in the device tree, I'd really like th=
em
> > to be the only source of truth. The commit message for the binding also
> > sort of suggests that "allwinner,pinmux" is the part that matters.
>
> Yes, it should be, but it turns out to be convenient for U-Boot to
> continue using the old method - until someone writes a driver for the new
> schema. And a function name is still mandatory, it's just mostly for
> reference now (so would indeed be fine to rename).

Hmm. Could we somehow make it clear in the binding that the function name
is for reference only?

> So if you really insist on this: please go ahead and merge it, so that
> the 6.16 release contains the new name.

I'm afraid I insist.

I think we still need an ack from the DT maintainers though, and then
the binding change would go through the net tree?

> But please note my silent protest about those cosmetic name changes in th=
e
> DT realm, which establishes an interface reaching beyond just the Linux
> kernel. When it comes to new boards, the U-Boot DT sync process is rather
> slow, so I really am eager to cherry-pick -rc1 DTs already, instead of
> waiting another 7 weeks - which bites me in this case. It's not merged
> yet, so is fine in this case, but I would really like to avoid similar
> hiccups in the future.

Noted. I will try to be more vigilant during the review process.


Thanks
ChenYu

