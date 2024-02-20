Return-Path: <netdev+bounces-73187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FFF85B4C9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD05282A3F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8D5C60B;
	Tue, 20 Feb 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P5fxi12v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E25C5F2
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417173; cv=none; b=BNtkd+q1rNAoq9oMoP6N5V/TOgLWFdqnGZXUzctNx8NUaVnO4/Mi5ISsHNF3eOSOeUo4/o5XUWsa8w0AAyXBzp43tvsN2xuKzA6uUhzhxQzZSTeau7ltH1byXNqQhzGvgodhYiDdJZj+IQLiU2H6ZfWKEc/THcO5x+GZe/FGlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417173; c=relaxed/simple;
	bh=ne6OIwC6Q4m/gonKfOP4zmqIeEWDkyxVyw9N1NHAagk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCkwLHK+SZBP0lY3dYMEGmb+F5nQtmPhDqOka9+UaWtxhKrMIEV92TdNFV5eq8YDq0mZRqz2br6PLdR4sTbWU/BGVUrWmh/YyqH/FT6xKwlvUFQQfrEFX3JuYqMtSudVS7z7Rm2kDVa+QtOaoUSvnB61HGW4ozkYYJv4C9noJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P5fxi12v; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511976c126dso6276376e87.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 00:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708417169; x=1709021969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEziOHGiSIYIXSE2DKbMAoSccSRuJEWP3yua6RmUOog=;
        b=P5fxi12vffvrIuvZB5sK08Fgaf/rRiFBMC9c1zposmptaMRna4tQ6mPCgMwtDNc3zX
         uRrCqrkKMBzVf8GYV3e5XH5Gs7qXxbrmjQui+y2TRb58xQXZgygCiSfp+yvGvwrQAVZn
         E62u32woJfva/G2fbh/aitCXYQq/J5535NdWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417169; x=1709021969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEziOHGiSIYIXSE2DKbMAoSccSRuJEWP3yua6RmUOog=;
        b=pU7wG8p3e7gUSOpDVZfov0NRyL4YsoKmx8DTNdWnlPSoYDBPf+fy79QxeKBWOKiDhJ
         /2gmb882zLB6tY5VJ2TdINJwmNfeE990AOys8OTWORvmEnGFJMhaY1ChtKEldd8PrCwK
         x2RfrU28N4+YV2ZNd5rUwjeGLE5bH6Ea1PMg4rxC20Lna6ESZKI/LzeMkEO4jcsYppMa
         sfeBUDHlwU9nUeHfYHonLzlGNqMY2k/jbFXgBTytGlscvafXTfk73RaX0/mp3MiI6lc5
         ZmH6VyETZdsY2DorW+Wh5naymId8r2WBtxKvX4Wg1xncuS0TIGXgPOdc3wl0XQNUl0Uk
         OI+A==
X-Forwarded-Encrypted: i=1; AJvYcCUbWuhFxJjd1IcaP3yR5E+yLvwVT7p5cawgXozxur0Jjm48xSWg5U3pdKwNZleU3+OsZZYFRpXLbQ9VK1SbaWsozAs+8lq1
X-Gm-Message-State: AOJu0YxSTo5wChzdg04UCDwCBoiCrqjFiyeGI7BwtB6h82T2bdL2UviD
	HLk63yE6tiTn5duVtgzdq3XPw3bkeddJHBlXGOtgrugfxx0mVLbPOueeR3Fl6j5M6ZTcb05JxYi
	0lcB9b8+KZcYYzRE99sEg6EaxX0IB+117mM68
X-Google-Smtp-Source: AGHT+IH5S9JhEAnlJW7wIUwPtqanO9wDlNvoGLQj6j/XUzV5A9r+YECp/Wu75hdzg56OEU7YxiSCvUVTZMQ1bRnLxMU=
X-Received: by 2002:a05:6512:3b89:b0:512:b3a3:4adc with SMTP id
 g9-20020a0565123b8900b00512b3a34adcmr3730322lfv.0.1708417169550; Tue, 20 Feb
 2024 00:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org> <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org> <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
 <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org> <CAGXv+5HAqmUizXztMH_nY6e+6oQh01hCtxEJXKtCn3_74-sOsQ@mail.gmail.com>
 <78241d63-3b9d-4c04-9ea5-11b45eac6f00@linaro.org> <20240130223856.GA2538998-robh@kernel.org>
 <CAGXv+5FwaNe7oesGwZ=yR0Pg82tEzEF3B0zjoex4qw+6zsSYbQ@mail.gmail.com> <CAPDyKFofy24N7ymzTF7wiADc17Tw9FiNTYMnbxgoioMBwDKVhA@mail.gmail.com>
In-Reply-To: <CAPDyKFofy24N7ymzTF7wiADc17Tw9FiNTYMnbxgoioMBwDKVhA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 20 Feb 2024 16:19:18 +0800
Message-ID: <CAGXv+5Fvdp__Razz_nxcedCV_P=Wbj=F_a6=s4V4SbW4RooueA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:50=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Wed, 31 Jan 2024 at 04:39, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > (+CC Ulf Hansson)
> >
> > On Wed, Jan 31, 2024 at 6:38=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Tue, Jan 30, 2024 at 05:25:38PM +0100, Krzysztof Kozlowski wrote:
> > > > On 30/01/2024 08:47, Chen-Yu Tsai wrote:
> > > > > On Tue, Jan 30, 2024 at 3:37=E2=80=AFPM Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > >>
> > > > >> On 30/01/2024 04:32, Chen-Yu Tsai wrote:
> > > > >>> On Mon, Jan 29, 2024 at 3:34=E2=80=AFPM Krzysztof Kozlowski
> > > > >>> <krzysztof.kozlowski@linaro.org> wrote:
> > > > >>>>
> > > > >>>> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
> > > > >>>>
> > > > >>>>>>> +allOf:
> > > > >>>>>>> +  - $ref: bluetooth-controller.yaml#
> > > > >>>>>>> +
> > > > >>>>>>> +properties:
> > > > >>>>>>> +  compatible:
> > > > >>>>>>> +    enum:
> > > > >>>>>>> +      - mediatek,mt7921s-bluetooth
> > > > >>>>>>
> > > > >>>>>> Can it be also WiFi on separate bus? How many device nodes d=
o you need
> > > > >>>>>> for this device?
> > > > >>>>>
> > > > >>>>> For the "S" variant, WiFi is also on SDIO. For the other two =
variants,
> > > > >>>>> "U" and "E", WiFi goes over USB and PCIe respectively. On bot=
h those
> > > > >>>>> variants, Bluetooth can either go over USB or UART. That is w=
hat I
> > > > >>>>> gathered from the pinouts. There are a dozen GPIO pins which =
don't
> > > > >>>>> have detailed descriptions though. If you want a comprehensiv=
e
> > > > >>>>> binding of the whole chip and all its variants, I suggest we =
ask
> > > > >>>>> MediaTek to provide it instead. My goal with the binding is t=
o document
> > > > >>>>> existing usage and allow me to upstream new device trees.
> > > > >>>>>
> > > > >>>>> For now we only need the Bluetooth node. The WiFi part is per=
fectly
> > > > >>>>> detectable, and the driver doesn't seem to need the WiFi rese=
t pin.
> > > > >>>>> The Bluetooth driver only uses its reset pin to reset a hung =
controller.
> > > > >>>>
> > > > >>>> Then suffix "bluetooth" seems redundant.
> > > > >>>
> > > > >>> I think keeping the suffix makes more sense though. The chip is=
 a two
> > > > >>> function piece, and this only targets one of the functions. Als=
o, the
> > > > >>
> > > > >> That's why I asked and you said there is only one interface: SDI=
O.
> > > > >
> > > > > There's only one interface, SDIO, but two SDIO functions. The two
> > > > > functions, if both were to be described in the device tree, would
> > > > > be two separate nodes. We just don't have any use for the WiFi on=
e
> > > > > right now. Does that make sense to keep the suffix?
> > > >
> > > > Number of functions does not really matter. Number of interfaces on=
 the
> > > > bus would matter. Why would you have two separate nodes for the sam=
e
> > > > SDIO interface? Or do you want to say there are two interfaces?
> >
> > There is only one external interface. I don't know how the functions
> > are stitched together internally.
> >
> > It could be that the separate functions have nothing in common other
> > than sharing a standard external SDIO interface. Each function can be
> > individually controlled, and operations for different functions are
> > directed internally to the corresponding core.
> >
> > > Right, one device at 2 addresses on a bus should be a node with 2 "re=
g"
> > > entries, not 2 nodes with 1 "reg" address each.
> >
> > AFAICU that's not what the MMC controller binding, which I quote below,
> > says. It implies that each SDIO function shall be a separate node under
> > the MMC controller node.
>
> Yes, that's what we decided to go with, a long time ago. At least in
> this particular case, I think it makes sense, as each function
> (child-node) may also describe additional resources routed to each
> function.
>
> A typical description could be for a WiFi-Bluetooth combo-chip, where
> each function may have its own clocks, irqs and regulators being
> routed.

Rob, Krzysztof, does that help you understand why the binding and example
are written with bluetooth being one node and WiFi (should it ever be added=
)
being a separate node? It is based on the existing MMC controller bindings.

ChenYu


> >
> >
> > patternProperties:
> >   "^.*@[0-9]+$":
> >     type: object
> >     description: |
> >       On embedded systems the cards connected to a host may need
> >       additional properties. These can be specified in subnodes to the
> >       host controller node. The subnodes are identified by the
> >       standard \'reg\' property. Which information exactly can be
> >       specified depends on the bindings for the SDIO function driver
> >       for the subnode, as specified by the compatible string.
> >
> >     properties:
> >       compatible:
> >         description: |
> >           Name of SDIO function following generic names recommended
> >           practice
> >
> >       reg:
> >         items:
> >           - minimum: 0
> >             maximum: 7
> >             description:
> >               Must contain the SDIO function number of the function thi=
s
> >               subnode describes. A value of 0 denotes the memory SD
> >               function, values from 1 to 7 denote the SDIO functions.
> >
> >
> > ChenYu
>
> Kind regards
> Uffe

