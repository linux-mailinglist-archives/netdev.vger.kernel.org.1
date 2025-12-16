Return-Path: <netdev+bounces-245018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54599CC504C
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 20:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DC423028C67
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC0335553;
	Tue, 16 Dec 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="PIdvrWND"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35032334C23
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913765; cv=none; b=Yv4NBmb96DCD2QEYblWYym1leSOto6px2jGCmbL0CblzkquZyHfRo81NG0JeHHW32QUGn2UT896P0TJERg5hlfLw3qjchBDxFOcjqx/yrXuV5a11gshAqWBMXMMd5XhrZz7ff4ZSrS3tu6BMWnYSwWX07WqJCuuqXae2SXTdwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913765; c=relaxed/simple;
	bh=DyIKB2hJJPGNfOXTwj8MacflXxSMbpI7LrFqsSt1Jpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZl9a5GKjbP32c+70vdbXtVHDXLGHHNoxMDLqU/M2nwxqPwVtk5NNMEe+sAG96ACu8S/j4D1s9jCibOs2riLDznZ5DPuOywkPPxgF//KDhs4wcytcn5Aobsswa8S6j4W8dAGMj9Z1fE85XoPny+f7werMyB1X6Bn7vhqO/9y9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=PIdvrWND; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so876194566b.0
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765913760; x=1766518560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyIKB2hJJPGNfOXTwj8MacflXxSMbpI7LrFqsSt1Jpw=;
        b=PIdvrWNDDkXLnkqIgGC29aaQhDxS5xxdJwzQ1Gvo0YMV3PEI80xK6mO1gu11OnOZuv
         3BLETZeImjGoprIOUDGIYMfTiw9+Dg5wruZ7KlEYpOW0qxKg2h8/Zl840vJXydD2Ubyd
         xTnarw5j30I9lIp8OYc66k7Meoa1IGPl3DxM5IQyWajo+GU68PnkbIDOB8co1xgvUCvH
         wbYkynT7pDB4z9GALnUaExA6zSk5k+Uw6Qj+BBCGTlGixU8inglD6zNiJSQR8rzuOfdE
         jIUbfq1xEm/qbPDVHWByqjleRo/qIpJQJIYdbJwHNEooTlBabuq+0gXf6k8BNpA5uKJp
         3baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913760; x=1766518560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DyIKB2hJJPGNfOXTwj8MacflXxSMbpI7LrFqsSt1Jpw=;
        b=oXH7xjO3qGLFYpM3EguAs6yOurp82dp/v8kohmEYbzmlR9911GPYtSIHUkrtZswnzt
         uQU/t7IpY9ndi2xWS5D4WIGw16GGG3yjslfR2/FyTWVJI/rLwFsHKbt6xiaWfFVIHUzM
         +YZ8TKUW4ZgTSq1CsCgq/PW1itNaIL3bLa6D7eqEOM8/Kob4ij/WC2e1vXg04UoH70Jv
         pyrv8K+u6s5bu6mvtlLef9kPWSU2VERjLwJkIVNKzUwYS8SK6tAj9/W6hnJYSIh9UgKR
         gCO1pRB7Y4xXn0O4vWuoA14R5pQVlz8ilxpXdxSjg7ZCOUqgUt/faLKx+n133C5dp2WK
         WGWw==
X-Forwarded-Encrypted: i=1; AJvYcCU2J6eOiD8TLvz4ukHxorZ49xlVxzAtRlI3HUqsfVoj8on9nqBopznwuwsC2AJawpqtVaFkOOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznkK+Pge1sKa0cUnX7BMf8hZxP8srh6lBhQOy5WJaOEtsc7dJ6
	4PzjgUw9PF9Z++lIX4iyctJuri9Cwh8mBbTIZi/IVLfSXG3Jz/8enujKyheEcIlS8M9h93pOovL
	wDDyjHOZYnPDnMQx6AcroDffA31e2wLBOzSr+GbQfDw==
X-Gm-Gg: AY/fxX43J6kusYOls56BxzlkWsYV8tobneZRrtFrDeo8g+OLZ4UJDJa907Hz5kBcVCk
	HZvpr5Up9HR7CrNZOguSGv3R4ic4vx8RVLLzLH/lhV6wKqePbV1i6ZJHisICnS0G2+yPrO4dSmM
	oJC+NEuxBqTmIdRMIwVprOk0Fj1DcW0Lw7IQCI5rQMUAr0ECKCJYpPL+AqNaSnvreLoZIgLs0eL
	KuUsaIdd717zYm4vyFvqwiZcYxZREcT35MF50wkLMRHus2C+lipN/tqsGTHPxjwkL2b1nhr
X-Google-Smtp-Source: AGHT+IHNQYfHhSZB51dtsDipQL9/5fDZcPe/Z6WdB1j+IUPGZTp0qnMPAX1NRpIDGnC0FktvfYyl1BhfRBlJ1lJ36qI=
X-Received: by 2002:a17:907:cd07:b0:b79:f965:1ce1 with SMTP id
 a640c23a62f3a-b7d238ba3e3mr1542684066b.42.1765913760345; Tue, 16 Dec 2025
 11:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-4-robert.marko@sartura.hr> <202512161628415e9896d1@mail.local>
 <CA+HBbNFG+xNokn5VY5G6Cgh41NZ=KteRi0D9c0B15xb77mzv8w@mail.gmail.com>
 <202512161726449fe42d71@mail.local> <20251216-underarm-trapped-626f16d856f5@spud>
In-Reply-To: <20251216-underarm-trapped-626f16d856f5@spud>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 16 Dec 2025 20:35:49 +0100
X-Gm-Features: AQt7F2ovlD6q1uGr-F_qGhYebApPtJxD_ztM4nzL5Jt_8Qv6aSDXR9OqFn9QCtE
Message-ID: <CA+HBbNFq=+uWp05YD08EQtaOhrN9FCBAtnOAsOJc4dNfoJRfxA@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] dt-bindings: arm: move AT91 to generic Microchip binding
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, vkoul@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linusw@kernel.org, 
	olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, richardcochran@gmail.com, wsa+renesas@sang-engineering.com, 
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com, 
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org, 
	kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-clk@vger.kernel.org, mwalle@kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 8:21=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Dec 16, 2025 at 06:26:44PM +0100, Alexandre Belloni wrote:
> > On 16/12/2025 17:56:20+0100, Robert Marko wrote:
> > > On Tue, Dec 16, 2025 at 5:29=E2=80=AFPM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > On 15/12/2025 17:35:21+0100, Robert Marko wrote:
> > > > > Create a new binding file named microchip.yaml, to which all Micr=
ochip
> > > > > based devices will be moved to.
> > > > >
> > > > > Start by moving AT91, next will be SparX-5.
> > > >
> > > > Both lines of SoCs are designed by different business units and are
> > > > wildly different and while both business units are currently owned =
by
> > > > the same company, there are no guarantees this will stay this way s=
o I
> > > > would simply avoid merging both.
> > >
> > > Hi Alexandre,
> > >
> > > The merge was requested by Conor instead of adding a new binding for =
LAN969x [1]
> > >
> > > [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251=
203122313.1287950-2-robert.marko@sartura.hr/
> > >
> >
> > I would still keep them separate, SparX-5 is closer to what is
> > devicetree/bindings/mips/mscc.txt than to any atmel descended SoCs.
>
> If you don't want the sparx-5 stuff in with the atmel bits, that's fine,
> but I stand over my comments about this lan969x stuff not getting a file
> of its own.
> Probably that means putting it in the atmel file, alongside the lan966x
> boards that are in there at the moment.

Hi Conor,
What do you think about renaming the SparX-5 binding and adding LAN969x to =
that?
Cause both are from the current Microchip and from the same UNG
business unit, with
probably more generations to follow.

LAN969x does not really belong in Atmel bindings to me, but I am flexible.

Regards,
Robert
--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

