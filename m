Return-Path: <netdev+bounces-25410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B3773E3F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6595E1C20429
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A91426F;
	Tue,  8 Aug 2023 16:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2C13AF9
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:27:35 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222E2CED8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:27:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f38692b3so5799675b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691511988; x=1692116788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmZq8plralUfhUCeO0zuZ8rV58wpzJBRG27vY2vs6cs=;
        b=QXdRzmj41xMJtB1/38xVQaXjR+upFFHkrCQvnKAYJRbi7H7Lb56k8ULdYCS4hXt6G6
         GcpBxpUxgPpvyTJpBHneIMKppfaGM8Sf/nR5qXuxH2368KbXpwwy+s2IrzG/J38gUIsG
         qIIkupXypX12b5XJJZRJW4NTHarsIj21/exobmBNVg3ZntNjien3ljuUV7RbV6a9a4IA
         bU3dJoKbxANuKIiae2cnL0NmF83C+oL6hg/T/rYkvipFxZdBz566Ds+t5oiDuPYm/vYq
         hhmA8BY6HW/EpOrpM6Z6G/nTI86xWRDgBWNaXrKpEEVOKzW8+H5g01Tx6lNGscjaaZlm
         Kw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511988; x=1692116788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmZq8plralUfhUCeO0zuZ8rV58wpzJBRG27vY2vs6cs=;
        b=fW59m/jKbJEneG2erb7jfQ0brtkaWp/4On4KOHw3N+iNIhJNPDCVtFie8np8T9Xz5J
         g6RUEPyfwaQJZelCA/EOgEiECq7iWuP1gT3uhLzG+F2GMFX9pfe87BYP1tRc0YOu58y+
         k7p+F7uUzmmOWa57HejGNh+7/fCOCWDX942WTgA+1KP43+FQmVk1U5+iaX9N0Hl+3zfY
         b+T7k1t5yR5BAcrKLMtUTcZiSGST7tixfaqXeOLz31ufrSa/dqPRAoB23deg23aLMtRv
         yZhmoeZ4zYcTy2CxmYtOAs7Z4zQTMnOg+WBGw9yWWCwGLiWaB+K8oPUN1mVXZ8Gxv0w3
         wWLA==
X-Gm-Message-State: AOJu0YzgW66WMR11fkAOXvEiUvX1FbYWvMRB3lIicDKiebQAotrTU1CP
	drCkI+pJNj/ijV4GXYJbzgjpSnD3Fmszjx3qGGBbBZsJcG+d8dm6lJk=
X-Google-Smtp-Source: AGHT+IGKZbzqHtAQeH+ERa/8lc1KwqmrCEauq29EtyhIWFzJmE3Z/R6hI/O84pNycisvdvGnKhmQiTpqB01gZJI0Wxg=
X-Received: by 2002:a1f:bdd1:0:b0:471:8787:2c6c with SMTP id
 n200-20020a1fbdd1000000b0047187872c6cmr4968353vkf.6.1691505016313; Tue, 08
 Aug 2023 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807193102.6374-1-brgl@bgdev.pl> <54421791-75fa-4ed3-8432-e21184556cde@lunn.ch>
 <CAMRc=Mc6COaxM6GExHF2M+=v2TBpz87RciAv=9kHr41HkjQhCg@mail.gmail.com>
 <ZNJChfKPkAuhzDCO@shell.armlinux.org.uk> <CAMRc=MczKgBFvuEanKu=mERYX-6qf7oUO2S4B53sPc+hrkYqxg@mail.gmail.com>
 <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
In-Reply-To: <65b53003-23cf-40fa-b9d7-f0dbb45a4cb2@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Aug 2023 16:30:05 +0200
Message-ID: <CAMRc=MecYHi=rPaT44kuX_XMog=uwB9imVZknSjnmTBW+fb5WQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] net: stmmac: allow sharing MDIO lines
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 4:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > On Tue, Aug 08, 2023 at 10:13:09AM +0200, Bartosz Golaszewski wrote:
> > > > Ok so upon some further investigation, the actual culprit is in stm=
mac
> > > > platform code - it always tries to register an MDIO bus - independe=
nt
> > > > of whether there is an actual mdio child node - unless the MAC is
> > > > marked explicitly as having a fixed-link.
> > > >
> > > > When I fixed that, MAC1's probe is correctly deferred until MAC0 ha=
s
> > > > created the MDIO bus.
> > > >
> > > > Even so, isn't it useful to actually reference the shared MDIO bus =
in some way?
> > > >
> > > > If the schematics look something like this:
> > > >
> > > > --------           -------
> > > > | MAC0 |--MDIO-----| PHY |
> > > > -------- |     |   -------
> > > >          |     |
> > > > -------- |     |   -------
> > > > | MAC1 |--     ----| PHY |
> > > > --------           -------
> > > >
> > > > Then it would make sense to model it on the device tree?
> > >
> > > So I think what you're saying is that MAC0 and MAC1's have MDIO bus
> > > masters, and the hardware designer decided to tie both together to
> > > a single set of clock and data lines, which then go to two PHYs.
> >
> > The schematics I have are not very clear on that, but now that you
> > mention this, it's most likely the case.
>
> I hope not. That would be very broken. As Russell pointed out, MDIO is
> not multi-master. You need to check with the hardware designer if the
> schematics are not clear.

Sorry, it was not very clear. It's the case that two MDIO masters
share the MDC and data lines.

>
> > Good point, but it's worse than that: when MAC0 is unbound, it will
> > unregister the MDIO bus and destroy all PHY devices. These are not
> > refcounted so they will literally go from under MAC1. Not sure how
> > this can be dealt with?
>
> unbinding is not a normal operation. So i would just live with it, and
> if root decides to shoot herself in the foot, that is her choice.
>

I disagree. Unbinding is very much a normal operation. Less so for
platform devices but still, it is there for a reason and should be
expected to work correctly. Or at the very least not crash and burn
the system.

On the other hand, I like your approach because I may get away without
having to fix it. But if I were to fix it - I would reference the MDIO
bus from the secondary mac by phandle and count its references before
dropping it. :)

Bartosz

