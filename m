Return-Path: <netdev+bounces-48293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC577EDF7F
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B31C209EF
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB22DF97;
	Thu, 16 Nov 2023 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Lw0jENns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0723AA
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:19:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso479431a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1700133582; x=1700738382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP061+Ljmcgn/I/ky1y60dNUaAgEa9xiG7meDpBf+38=;
        b=Lw0jENns2otjbJ9ioCR3XOGmnIPyh67//DDG29PaU91k7AIYH0yRG74oT0de5uPUCe
         cxAsleRY7xhtoF0HuhsTj/6UnTvshgevCc84ME53vcUMVK/dYO2/c+5gfKZf4y1yo+By
         OhzRcEr4+/7+vsFwc/KUPqqVpnTxIwqW0ChnFqlFJQZ5GH6aq1AXgzTgGks2vffEaFBt
         cXzrIvJGfhOGnJlaArPZUXY9MNJIEYdCbL1mAHi/Z/KovZz+fvxUCgXdQh7nMCEQNvJf
         SW96dRj8HVCItftUW9A+K8QWFqyxJm89WrcH37lZxlJfmYnvKYQajwJpek1RDD+QT+XD
         jkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133582; x=1700738382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP061+Ljmcgn/I/ky1y60dNUaAgEa9xiG7meDpBf+38=;
        b=nCLrieKuO0Ypg5WWtnpnyofNK1Oox8xGRqoLD0pFm8kasGutxM33/6zVPdsAQ3p/lZ
         xrSDrYXnC7lIC+gmoUojEruydA9DBaoFcChAUn8lkV+7M0w8vflNrB08aEtjGHsgP0qv
         dSQQZyW9zezFvBMvtepN2h7zaz0VDa6Oi5fy/zq4Fggnt4UKjdl5BSiNCeokH0ztaIl2
         1MxMDs7u3Omvj+KSBmTZ7REmQm2bLRUSu/StHiFIRBZzW4p6cKO0unbnsXknZaJB/b5C
         JnEJtgofTdK445m8uKR17pZ5RfxkUAbmR0h5e1X0guCVjHTbq9oCLGdoNM2MRsRQwWRE
         0WqQ==
X-Gm-Message-State: AOJu0YwRElzcmLiAxnbDfupYaXngwL/gySr598FgovKWmOCIe8eD8YsP
	qnAA3zn6xRmHLTaf62ONKp+aN39+G9rosbUe+lgR4g==
X-Google-Smtp-Source: AGHT+IGuLhI1VCL9i2gZcvyFeH+Ud9ZO0oIByakW8zS/mhncDg7kJgPau8PTD8bfhRSPXaKrjIuebEKFf4OogrjOYic=
X-Received: by 2002:a17:90b:3e8c:b0:27d:492e:137a with SMTP id
 rj12-20020a17090b3e8c00b0027d492e137amr15373839pjb.45.1700133581976; Thu, 16
 Nov 2023 03:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115032515.4249-1-quic_luoj@quicinc.com> <20231115032515.4249-4-quic_luoj@quicinc.com>
 <e740a206-37af-49b1-a6b6-baa3c99165c0@lunn.ch> <33246b49-2579-4889-9fcb-babec5003a88@quicinc.com>
In-Reply-To: <33246b49-2579-4889-9fcb-babec5003a88@quicinc.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 16 Nov 2023 12:19:30 +0100
Message-ID: <CA+HBbNG2Zx36oFT=dN3y21Ms0Dsy4C+cObe-yhsCEXctt6Btkg@mail.gmail.com>
Subject: Re: [PATCH 3/9] net: mdio: ipq4019: Enable GPIO reset for ipq5332 platform
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 12:14=E2=80=AFPM Jie Luo <quic_luoj@quicinc.com> wr=
ote:
>
>
>
> On 11/15/2023 11:11 PM, Andrew Lunn wrote:
> > On Wed, Nov 15, 2023 at 11:25:09AM +0800, Luo Jie wrote:
> >> Before doing GPIO reset on the MDIO slave devices, the common clock
> >> output to MDIO slave device should be enabled, and the related GCC
> >> clocks also need to be configured.
> >>
> >> Because of these extra configurations, the MDIO bus level GPIO and
> >> PHY device level GPIO can't be leveraged.
> >
> > Its not clear to me why the normal reset cannot be used. The MBIO bus
> > driver can probe, setup the clocks, and then register the MDIO bus to
> > the core. The core can then use the GPIO resets.
> >
> > What am i missing?
> >
> >       Andrew
>
> Hi Andrew,
> Looks we can leverage the MDIO bus GPIO to reset qca8084 PHY, but the
> mdio bus gpio only supports one GPIO number.

But, you can specify a PHY specific reset-gpio under the PHY subnode.
However, you must specify the PHY ID via compatible then, please look at:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Do=
cumentation/devicetree/bindings/net/ethernet-phy.yaml?h=3Dnext-20231116#n36

I do this commonly when there are multiple reset GPIO-s for different ether=
net
PHY-s.

Regards,
Robert
>
> Here are the reasons i put the GPIO reset here.
> 1. Currently one MDIO bus instance only connects one qca8084 PHY as
> MDIO slave device on IPQ5332 platform, since the MDIO address
> occupied by qca8084. if the other type PHY also needs to use MDIO
> bus GPIO reset, then we can't cover this case.
>
> 2. Before doing the GPIO reset on qca8084, we need to enable the clock
> output to qca8084 by configuring eth_ldo_rdy register, and the mdio
> bus->reset is called after the mdio bus level reset.
>
> 3. program the mdio address of qca8084 PHY and the initialization
> configurations needed before the registers of qca8084 can be accessed.
> if we take the PHY level GPIO reset for qca8084, there is no call point
> to do the initialization configurations and programing PHY address in
> the MDIO driver code.
>
> i will check the feasibility of taking the PHY level GPIO reset and do
> the initial configurations in the PHY probe function.
>
> FYI, here is the sequence to bring up qca8084.
> a. enable clock output to qca8084.
> b. do gpio reset of qca8084.
> c. customize MDIO address and initialization configurations.
> d. the PHY ID can be acquired.
>
>
> Thanks,
> Jie.



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

