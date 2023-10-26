Return-Path: <netdev+bounces-44556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC07D897B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692231C20E81
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40283C6B4;
	Thu, 26 Oct 2023 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqGOTNEe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2453C078;
	Thu, 26 Oct 2023 20:09:27 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F91AC;
	Thu, 26 Oct 2023 13:09:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so1497599e87.0;
        Thu, 26 Oct 2023 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698350964; x=1698955764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwlxXDyvdNf0C7GKTsb5fnIx1F5x2UfhhfNobRqGDQg=;
        b=DqGOTNEewc+LNeJ73iWPrNr+3l4DpR7W5y1Z6+0gVJvNK3Ci6L1sLCvL/gRt9guBhB
         Xcgv3CcbwcddLTLvffLMA+CnuFPzzbtOKuX3M2HNHmXoZf5zcAIR1KKXszuBgV5bjPOx
         iS2LS8lUsY0GXQWwllYLzVH9cxur9u5/dACywLhuIGNPXe4fDtiElYjitJfuq001+gZA
         lakiIfvVRCR1b3seiMtTzArBxXa8o8Br6F2lsB9ZKFJWDW0ph7bjAn59HZ98ZmtEf2BL
         x+k7O3i3koa0ubxTGHQ4kBhFd2cewbuINVo8Oa4sJthLJU9WICysnSRfDWOY5hxIX7yR
         UIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350964; x=1698955764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwlxXDyvdNf0C7GKTsb5fnIx1F5x2UfhhfNobRqGDQg=;
        b=dFAXdeGRDhn7wFulSsEyuY5f8aaIcn6u0fIuAgI3A8X8Rz3t32InsdEHtZULhIxPKE
         hZ+eyyTl3emqGQ54nm8aaRy9OEOHgbs2BhR2ZqDBcgOsL/u+bf4XdTcPjg6Y+0zJDYGy
         cJKJ5oWUVR5SlH193371fGgJNWI/2QzOhIQVA9eK7nyKLo+FnB+Q68Pw1kwr0ul9quGo
         sRkzRAy1BOK63rZUn9xTUdMm6JlDAzCiluUBP6OrHEZijYaWFPXR1VHYf47KCVXcA+Tp
         FM27OrFnwqwqaa0N5dhprA4mXppqYMGrulnu3ZWJQNRCyrHxs1S8lxWJtTi2Rpribw4F
         Lt9g==
X-Gm-Message-State: AOJu0YxbgKzH/lM8GBwVORowQDI23oyegHvHzJggdPlDSLg4dRMDxI8H
	H1H3Yt6UTpJK5nJt8/tGgIWzRt6m273io6E+WGI=
X-Google-Smtp-Source: AGHT+IEWgG+bKnd3TnlQekHFy3FlXIZtWQYklStSfx1Qy2UQkE8cBxdKjzfZkFPejRg57sBzjCeQDuaDARMpJI5vfWA=
X-Received: by 2002:a05:6512:3d0c:b0:508:15dc:ec11 with SMTP id
 d12-20020a0565123d0c00b0050815dcec11mr270286lfv.30.1698350963933; Thu, 26 Oct
 2023 13:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024205805.19314-1-luizluca@gmail.com> <20231024205805.19314-3-luizluca@gmail.com>
 <e5b55d22-9e02-49ad-ba5f-2596f17be8ea@arinc9.com>
In-Reply-To: <e5b55d22-9e02-49ad-ba5f-2596f17be8ea@arinc9.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 26 Oct 2023 17:09:12 -0300
Message-ID: <CAJq09z68_PKisypGjg=TvvNYXY5PhLTQqqoj5gA+GW2H=mKK3A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: dsa: realtek: add reset controller
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On 24.10.2023 23:58, Luiz Angelo Daros de Luca wrote:
> > Realtek switches can now be reset using a reset controller.
>
> The switch could always be reset using a reset controller. The fact that
> the Linux driver lacked the ability to do so is irrelevant here. The
> abilities or the features of the hardware had never changed. You should g=
et
> rid of the "now" above.

Yes, I need to avoid thinking about where it will be used.

> > The 'reset-gpios' were never mandatory for the driver, although they
> > are required for some devices if the switch reset was left asserted by
> > a previous driver, such as the bootloader.
>
> dt-bindings are for documenting hardware. The Linux driver details are
> irrelevant here. Also, from what I read above, I deduce that for the swit=
ch
> to be properly controlled in all possible states that it would be found i=
n,
> the switch must be reset.

I don't believe the switch must be reset by the HW. It will only be
necessary if the reset was kept asserted by the previous driver or its
initial state. And even in that case, we would only need to deassert
the reset, not assert it.
The driver will sw reset the switch during setup, leaving it in a
pristine state.

This is the current code flow:

realtek-smi/mdio probe()
   HW reset assert
   sleep
   HW reset deassert
   sleep
   rtl8365mb/rtl8366rb detect()
      SW reset

In fact, if we could make sure the hw reset was actually performed,
like checking a switch uptime register, we could avoid resetting it
again.

If you must not consider how the driver was implemented, I must assume
that an advanced driver might be able to configure every aspect of the
switch without a reset. Reset is the easiest solution but I believe
there is a narrow window between the reset and the switch is properly
configured where the switch might act like a dump switch, forwarding
some packets to all ports and possibly leaking traffic.

> So instead of above I'd say:
>
> Resetting the switch is mandatory. Resetting the switch with reset-gpios =
is
> not mandatory. Therefore require one of reset-gpios or resets and
> reset-names.
>
> For dt-bindings changes, I'd remove reset-gpios from else of
> if:required:reg as you already do with this patch, and add below to the
> root of the schema.
>
> oneOf:
>    - required:
>      - reset-gpios
>    - required:
>      - resets
>      - reset-names

As I said, I don't believe a way to HW reset is mandatory.

> And, like Vladimir said, this should be a separate patch.

OK. I'm just waiting some days for a v2.

>
> Also, please put the dt-bindings patches first in the patch series order.

OK

>
> Ar=C4=B1n=C3=A7

Regards,

Luiz

