Return-Path: <netdev+bounces-178432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1DA77005
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157C33AA91F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C921B9FC;
	Mon, 31 Mar 2025 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="Y7BP6nhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461221B9D1
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456083; cv=none; b=WtQiyMPDulxYpIiG9/1pElp260VYwv+N7LX8pQFatknUa3E/npA4XvVmqAei8IOsMd3SrwwO69k6KiZMIVGxonw/kcFTduwJ1rFCVRNzsbBQcRrSUt+XIH8u1lrzUjHcloqV2PHESXVFw2SsSQp44SwsDlrKh37Ws507pUGzSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456083; c=relaxed/simple;
	bh=VYxMbRRBbMozMTUiOpSryYZs6R37YG4QhxXtAYqdTQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKsUlgqC4tDkRlB7QtXJrTCl82OVGwLiqPTgnxjCF7MzoZQZZCFA0we2WZRFS9vpgoj9C2adtovvar3EiHrxv2RTCVgMRT9snFskmz+ccRP/Htw7mxiq4jhDnlukiM0opBoRlo+aAn23iR3/g4aO4USlsRlwiV6TjV57fpAON1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=Y7BP6nhf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so1756347a91.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1743456081; x=1744060881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqFv7p5NcVMXzdeHBPjYikjLO1JUbU/VCURUs/xfOEs=;
        b=Y7BP6nhfpsJxpHcx8RGyjlpQGTJ3+vFy1yASffS6kGj4aJzB6wEIxR1XkhnT+pbz0S
         xZSsXbAgZ1gr8LNgPMbrnyQzSz4NPRz09B0Ck9l1YShoPwSNJxpN/H1VaPr5ZO2HC69P
         +nojLK7i7/hzvrdi698SriU8i+5hVHKP1CSlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743456081; x=1744060881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqFv7p5NcVMXzdeHBPjYikjLO1JUbU/VCURUs/xfOEs=;
        b=nKP6iDXs1bESeC/eiVxA+VOXrf0uGwpufLXDvHspzEEaxWLfozt70y7b2b4WdaGKsU
         Vl7uqQJuAtXAeCeidVcH+egtefAtdlWicToHuXJRN/sM77bOPLLf+TJg/awtFp4XxKRh
         xE5wkckZ0vutfUGjxMnqbW/X55Gt+weLtr4CUk3hO1Qyt0bTbasZ6K8vLSt9HWgOA+da
         lbUtaQ1/Bw8F4Am++pnMF6Q18wFHd1JpdHnbiXAMooFO9WhK1hOYJw97iWw55C3DqK/u
         4qH1zWXoiwY0qpnNRs0Ta6LUOtdAKcKClZNIYdfVVgFksQwXil5BU65uGPgd6RUosSls
         nTdg==
X-Forwarded-Encrypted: i=1; AJvYcCXRN2iACKXIpE6+vcynzxdLBrLt0+6Ems4UQErEJtUp/xKWyatCWoku1//F2+hhX8m6+udEJEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz21TLcHKvHyApyax29ckdQrDIUpT7EFZXSOM3IA5B6p1BxtS2
	4JvNwF4IzgVE9uA+2NGZLOCMqUb/RzqrzKiDOQT5rgeoUavO5t0HqG2elacSMw1FC5MGPftDUml
	7OE9JXX6y6iPoyKV6oTn+bDY4mwftLcA7sVm9SQ==
X-Gm-Gg: ASbGncuXGrbKqLJ12occuXkZbjmiQtcryxxdGgzZ/4n60Sq2IJkTlwXVuO+VG5d0ZSQ
	RfULpKqIKpcxwPNz+jEvhqZNqZ0sdtREA0LNPwnrAuBse8isRTiSR8XOjJ/sM/fT0WRASzNIOIS
	g7D2enXdcKa6ngJ9sOl3pOvAI=
X-Google-Smtp-Source: AGHT+IHwfY9YDI7gAxVEnaSnjkABdZZOKgGT0o+XpttcOyVXA2GQq0jvYVFLH9NQlhONNF8RbNEGEwVheCtAyPLI7IM=
X-Received: by 2002:a17:90b:570d:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-30560949feemr889884a91.26.1743456080750; Mon, 31 Mar 2025
 14:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
 <17cfc9e2-5920-42e9-b934-036351c5d8d2@lunn.ch> <Z-qeXK2BlCAR1M0F@shell.armlinux.org.uk>
 <CACdvmAijY=ovZBgwBFDBne5dJPHrReLTV6+1rJZRxxGm42fcMA@mail.gmail.com> <Z-r7c1bAHJK48xhD@shell.armlinux.org.uk>
In-Reply-To: <Z-r7c1bAHJK48xhD@shell.armlinux.org.uk>
From: Da Xue <da@lessconfused.com>
Date: Mon, 31 Mar 2025 17:21:08 -0400
X-Gm-Features: AQ5f1JogYqSKmDgBJP4R985J7fldNhdkXea2BS9P9NlvEC_qQFM2qGPLO_OsWfE
Message-ID: <CACdvmAhvh-+-yiATTqnzJCLthtr8uNpJqUrXQGs5MFJSHafkSQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Da Xue <da@libre.computer>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, 
	linux-amlogic@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:30=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 31, 2025 at 03:09:00PM -0400, Da Xue wrote:
> > On Mon, Mar 31, 2025 at 9:55=E2=80=AFAM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Mar 31, 2025 at 03:43:26PM +0200, Andrew Lunn wrote:
> > > > On Mon, Mar 31, 2025 at 07:44:20AM +0000, Christian Hewitt wrote:
> > > > > From: Da Xue <da@libre.computer>
> > > > >
> > > > > This bit is necessary to enable packets on the interface. Without=
 this
> > > > > bit set, ethernet behaves as if it is working, but no activity oc=
curs.
> > > > >
> > > > > The vendor SDK sets this bit along with the PHY_ID bits. U-boot a=
lso
> > > > > sets this bit, but if u-boot is not compiled with networking supp=
ort
> > > > > the interface will not work.
> > > > >
> > > > > Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support=
");
> > > > > Signed-off-by: Da Xue <da@libre.computer>
> > > > > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > > > > ---
> > > > > Resending on behalf of Da Xue who has email sending issues.
> > > > > Changes since v1 [0]:
> > > > > - Remove blank line between Fixes and SoB tags
> > > > > - Submit without mail server mangling the patch
> > > > > - Minor tweaks to subject line and commit message
> > > > > - CC to stable@vger.kernel.org
> > > > >
> > > > > [0] https://patchwork.kernel.org/project/linux-amlogic/patch/CACq=
vRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=3D8=3D9VhqZi13BCQQ@mail.gmail.com/
> > > > >
> > > > >  drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/=
mdio/mdio-mux-meson-gxl.c
> > > > > index 00c66240136b..fc5883387718 100644
> > > > > --- a/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > > > +++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
> > > > > @@ -17,6 +17,7 @@
> > > > >  #define  REG2_LEDACT               GENMASK(23, 22)
> > > > >  #define  REG2_LEDLINK              GENMASK(25, 24)
> > > > >  #define  REG2_DIV4SEL              BIT(27)
> > > > > +#define  REG2_RESERVED_28  BIT(28)
> > > >
> > > > It must have some meaning, it cannot be reserved. So lets try to fi=
nd
> > > > a better name.
> > >
> > > Indeed, that was my thoughts as well, but Andrew got his reply in
> > > before I got around to replying!
> >
> > The datasheets don't have much in the way of information about this
> > register bit. The Amlogic GXL datasheet is notoriously inaccurate.
> >
> > ETH_REG2 0XC8834558
> > 29:28 R 0x1 reserved
> >
> > It claims the bit is read only while the BSP hard codes the setting of
> > this register. I am open to any name for this register bit.
> > This is the only thing holding up distro netbooting for these very
> > popular chip family.
>
> Which interface mode do we think this affects?
>
> As a suggestion, maybe call it:
>
> REG2_<interfacemode>_EN
>
> and possibly add a comment "This bit is documented as reserved, but
> needs to be set so that <interfacemode> can pass traffic. This is
> an unofficial name."

I found this on the zircon kernel:

#define REG2_ETH_REG2_REVERSED (1 << 28)

pregs->Write32(REG2_ETH_REG2_REVERSED | REG2_INTERNAL_PHY_ID, PER_ETH_REG2)=
;

I can respin and call it that.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

