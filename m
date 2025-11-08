Return-Path: <netdev+bounces-236977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CAC42BE9
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 677CC3499EA
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B79223DF9;
	Sat,  8 Nov 2025 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrLwPfcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B961F4CA9
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762601477; cv=none; b=pHPa/Mp8foFuwHFnJo67s5SJ8X1ipvDo120+VQ2ottNg1/0+7dbNM6uKm/rC4aaV1pOye/GnZQGdL3GUfMvYlh/UFYx8q501cBLZEvjp4SaEvavQZpsfvnpFRG3zUvR6bme3hPsESRRA38mOaGw4hnFEpatcSc3hTkdA6PiAZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762601477; c=relaxed/simple;
	bh=BVqZOiuHq1xKbjFJroWD/ayEpS2V8z6nVjtDvArFpCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FotIrYNF/pnJBAxZ9uYkTZtX4SlmN2krj+n2sJJ/ULMbGoMG1mfD+kjeAz8a/5FeQDZNdbkeLfXnTi6Q5aIXnWJpgdxgwkAr9ctOarCpITAhSEzjy1xap/3xCGahH5Wsh3usPfNn3tmpdzvIANUvTCAI8I7fkI+fWpAKAAzvAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrLwPfcJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-786a85a68c6so15868537b3.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 03:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762601474; x=1763206274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kul+ldlZcfc/to5UiPCGqycfdspo1AsYJb25duvzMaE=;
        b=JrLwPfcJh+ktBerU25Y8g0AAECzCh4wv3xEpisk+2BUvXGb28DqwLkK0rJz6DfciX1
         SQI2wE4XSgsnqk+NdHGk66VHMn3XrIM14/e1G0a2XVOvkLRn5MoUHLnPI3f2ZN9/wfTm
         WHH54s6+DhQ3Hs8p+gIi8WooUDmvlGghgo6S5qfbNkGjOpfkOxcaWQD3jdihxGivdwkk
         8rJPSo4X3s7BwosiiNSbKNxBtqbI5OD4jG93rIRxSa9QQhvT6O7QExVAuqIA6wh4E5Un
         GFKXHTGma6YlW+SxmAFg/e5oensWA3Ln/SpPqv6c5Df08Q1LWEj72h9YZuhiWTjyNxYI
         Lj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762601474; x=1763206274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kul+ldlZcfc/to5UiPCGqycfdspo1AsYJb25duvzMaE=;
        b=h5B1IdVF14H1k1hHFLZ18dYsBrlarrcDHb/VlpOLLQj5x/MBLTLabmSQdKLjZwW8my
         lV+ajyKyuUVqaysDzRfd6fxw3NHDwy0qbYSaJmZuXso4f6aF/CpAIzh8yQk/pTilqh1c
         HtcxfwgKwreTeC4593cjU8fZSiiydnbXGVKo/Eev8IxMPWhcg21JmMTDJUpz47MfY82G
         XVwLhasiDaeCreuI+7ScujLwl6+ECZptNQFnckLkPYN4UyKsKWa5IJbtlgEHMI2ZkKtt
         vhR8a4xOwY9VfNXiOs4szK25k9wRpXv4ULwBvsEM7MfXLwPp7eFSPFfLIEN3Ft5RTR2e
         9sSg==
X-Forwarded-Encrypted: i=1; AJvYcCWS1vgnXKneZg6pUNrhH4LlI0EZFkBiNQaT2TAj6TI5Rt3gMlJf89WHC6SXCVrIki57w7Zfqb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVq1nuDsR7FvyrjEjUJVFvdHEg4KE5NJDkAySWADu91/CHuLJ
	HCWWXaf1ZmaHzyZwYJEPpyB16VewPuHd/BAo4aQJ4z7Ty4C4R1XJCIfIs3AQh9KwKmuqVbjTWtE
	62EkPU4axXsQ4YsdQ+RunKPhiRq/r7k8=
X-Gm-Gg: ASbGncvWirQJmVTiRMt4Qf65jYBMNwBsh3hmHCxJKp6AEZCcIYsBplJDxeiLYu46cDC
	qEPhOLJZ97CUNfK8vds+HaVOC452TIjzxTGM80OTpfn+gB+VDJuqyrli3PzHEJLUCBe69sxLe2j
	Y6vwPvDirba/zEygFvw8oDOVYZy/dVC5wxUq5+nJbgr7+4c0V7eCqZhMZaz0UO7YE3kxTHOS2Qb
	cy8x28ERwLzBv0JD2ynlUF2OQdwOQUPdnBf1IA/Kwn4j8hV0Z9is8ZILKUA6ACFOiHLRg==
X-Google-Smtp-Source: AGHT+IEPK3nR0sMFaFS7BVTaqHw85Bdn4UsHG71bXQaV4089JTCQ2FMUL36I5F+8NGGUYJOBhMwzB+DnUk0UOWj7D6o=
X-Received: by 2002:a05:690c:26ca:b0:786:a39e:e836 with SMTP id
 00721157ae682-787d545e8eamr14846547b3.60.1762601474112; Sat, 08 Nov 2025
 03:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
 <ce95eb8c-0d40-464d-b729-80e1ea71051c@lunn.ch> <CAOiHx=kt+pMVJ+MCUKC3M6QeMg+gamYsnhBAHkG3b6SGEknOuw@mail.gmail.com>
 <ec456ae4-18ea-4f77-ba9a-a5d35bf1b1fd@lunn.ch> <20251107144515.ybwcfyppzashtc5c@skbuf>
 <aQ4RR4OQI9f2bBOG@shell.armlinux.org.uk>
In-Reply-To: <aQ4RR4OQI9f2bBOG@shell.armlinux.org.uk>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 8 Nov 2025 12:31:02 +0100
X-Gm-Features: AWmQ_bnqz5T9iPGsG_Fj5OGHtnPj0EPUXcQY2h_Hcli3mW3aM4IFpy_1DrOQDgI
Message-ID: <CAOiHx=mBPUg-a=_PgdrOD25A=Gz8gEkG9Z+JkNkCv8u1zoLpVw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode interpretation
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:33=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 07, 2025 at 04:45:15PM +0200, Vladimir Oltean wrote:
> > On Fri, Nov 07, 2025 at 03:07:48PM +0100, Andrew Lunn wrote:
> > > > There is allwinner/sun7i-a20-lamobo-r1.dts, which uses "rgmii-txid"=
,
> > > > which is untouched by this patch. The ethernet interface uses "rgmi=
i".
> > >
> > > Which is odd, but lets leave it alone.
> > >
> > > > And there is arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dt=
s,
> > > > where a comment says that it has a BCM53134, but there is no such
> > > > node. The ethernet node uses "rgmii".
> > >
> > > aspeed pretty much always get phy-mode wrong. So i would not worry to=
o
> > > much about this.
> > >
> > > > So one doesn't define one, one uses rgmii-id on the switch / phy si=
de
> > > > and rgmii on the ethernet mac side, and one only defines the ethern=
et
> > > > mac side as rgmii.
> > >
> > > That is reasonable. It is a lot less clear what is correct for a
> > > MAC-MAC connection. For a MAC-PHY connection we do have documentation=
,
> > > the preference is that the PHY adds the delays, not the MAC. If the
> > > switch is playing PHY, then having it add delays is sensible.
> > >
> > > > > I would maybe add a dev_warn() here, saying the DT blob is out of=
 date
> > > > > and needs fixing. And fix all the in kernel .dts files.
> > > >
> > > > Sure I can add a warning.
> > >
> > > Great, thanks.
> > >
> > >     Andrew
> >
> > +Russell
>
> As this is discussing the applicability of RGMII delays for DSA
> switches, I've long held out that the situation is a mess, and
> diverges from what we decide to do for MACs - so I'd prefer not
> to get involved in this, except to say...
>
> > Since there is no 'correct' way to apply RGMII delays on a MAC accordin=
g
> > to phy-mode, my advice, if possible, would be to leave sleeping dogs li=
e
> > and fix broken setups by adding the explicit device tree properties in
> > the MAC, and adding driver support for parsing these.
>
> Indeed - let's not break existing working setups. If there is a
> problem with them, then that's the time to start thinking about
> changing them.

I completely understand the reluctance to change anything, and I'm
trying my best to not break anything:

The only mode used by in-tree device trees is "rgmii-txid". This
already behaved as it would for a PHY, and I did not change the
behavior.
As you probably know "rgmii" is often wrongly used, and the old
behavior was to enable delays in both directions in this case. I did
not change the behavior here either.

So for the known cases, and the suspected "wrong" usages, I did not
change anything, so these will continue working as expected.

My interpretation here so far was/is, and what I'm trying to follow here is=
:

if this is the CPU port that is connected to a different MAC (that is
controlled by the host), then on that port the switch is the "PHY", so
it is responsible for the delays according to phy-mode, as the other
MAC is supposed to not enable any (and doesn't know that there is a
DSA switch on the other side, unless it also is a DSA switch).

In any other case, don't apply any delays, because here the switch is
the MAC, and the other side is a PHY (or "PHY") and therefore
responsible for any delays that are needed.

Having an external b53 switch connected via its CPU port to an
internal b53 switch is a common setup on BCM63XX, so here b53 must
enable delays on one side, and currently it does not enable them on
either side.

Currently, the only way to configure this is by using the definitely
wrong "rgmii" phy-mode. Anyone writing a new board will just use it,
because it works, and we can't prevent it. I want to give the option
of using the less wrong "rgmii-id" value, which at least (in my
interpretation) matches the spirit of phy-mode.

Would it ease your concerns if I guard enabling delays with
dsa_port_is_cpu())? To make clear that we don't enable delays on any
user/dsa ports, and only the one that goes in the direction of the
kernel/host (the "root" of the DSA tree).

Best regards,
Jonas

