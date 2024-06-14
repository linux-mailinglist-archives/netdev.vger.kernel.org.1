Return-Path: <netdev+bounces-103483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D79083FB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A11DB23435
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C21482FC;
	Fri, 14 Jun 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1y8s+XD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD9142658
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347707; cv=none; b=jyG45FTXHXN3aqrM3pDLEexNb7bvDOOGpii2xWCT9Z6WC4gXss3KZdmN1AD+Rm6zf5FGAplszeka0mkf9Xu9/eDsrTZ6YKS2gk3h7bD5kwiLp1lAEQrckavK4bt8ufIz0R/EDw+sPIRy776kzNSZBXnAkQ1PHXqqrCQC0TQL3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347707; c=relaxed/simple;
	bh=yTvhl2IUS1cbZ8FmnJISCj1I5etRv6Wb4WLy/6guEdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPjiPd/EA8mKj1QAZ+5/7jZsAOeyWwLPPaVhaF06kKSp6soke4CCkko3SE3SHHcKnNbaJJKKTVGW8Mn1feF1VrkJYaqgJeeBXX/piO2kqP5HwfL9Z7FhETMT9VY23ocPbWZliaT7UWah/6A3PRb00UoV9djMk1VhaLohzURnvO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n1y8s+XD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso2147349e87.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718347703; x=1718952503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n21AcI7ZyImS+JT8RLtnfNQgbRDZVCrUU5GE4hIUqKY=;
        b=n1y8s+XDYtXG7fhpqsr/Me/aaLsHqM6L7BmzH0OsoEn/Nmw5qJC2s4uHEZjc5gUpZ5
         QshZY44hT5xxhdSXKoLc59MLQU3bWoeA2K4DJk74kcxPEfdr/bbJC4amNLX4ZrK5cS8r
         7ILM158FnUCF2fZskwUGKtCg4Cdt+Ex6cCeGdGaGZKGsBsEJ3FI3lkuE/PwWTKy008fA
         xeCBRFDVLj/jDIgvZVqZ3T/RgvD7ob0EsqDD0VGYxrpT5PR6ksLu/HMjD/88rNhapTVe
         5kAS8qrwb5WolEJ7G1J+DopwNdf1f1jYNmauHLJkWlususNfRHFQgpXpIHesIJrHAZNH
         U90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718347703; x=1718952503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n21AcI7ZyImS+JT8RLtnfNQgbRDZVCrUU5GE4hIUqKY=;
        b=g8ICmXsgmc3p1ujmtD1R7pT7ONIkyMxTysp3AO2cyQRrw3xNy3jALIo3UHLJ0OrFdf
         koSuADlam2EIcLHJLAy/wY9Xm+IdU1wm9RFeZhY2DFVtSanG2y7BPeza8C48C+dKpFD0
         FywW9SaB7mvHx2j/+eUfoGNsjPiSU7i9R54jTxwFfq4CejKEyAASKNQf7LqbgfTPGIav
         A17h77gt0E3UtAFM+Ri0a1UyaZqhYs3suhAbYrs1Iu7Lg59eQqoiRbHHl30LcSu5oZYJ
         cRe6R6sNKUpobTOcT7F8hMvocbM5u2AjeaqUN2S1qs6etvzD9DDe+IMm7IhGm/r+z373
         KA9w==
X-Forwarded-Encrypted: i=1; AJvYcCVuODC+kjjp8f2Zkagu0qM4hFlRMRbxIuj96oEzzMSsdm5Mdm+tbyxD2sol204MSY3AW1exR4aRKdYCqSrtTRM4S+wH37uG
X-Gm-Message-State: AOJu0Ywl1AbaSFUkrfKNO7XTU/4WOhUIGPyvJANWOxwS7yO4AE36J9uV
	e6awxblRGTmm/v3vWp/H7YRfdGSqwhOn60kaOptA7XxKEY3KS0xWNA66zOcGGU2sGbXM6AE42xj
	ugTgv6BAXKil8dO/lcYndxLkCxpbjI9qCf6ZuMg==
X-Google-Smtp-Source: AGHT+IFrZm9K+8bcFC036pMlD/5EnYhtWdAcFipBud3JNlaPiInNyeWH7o20nlajvM9PGHxsP2H2vqWpmnHG0VfjOAY=
X-Received: by 2002:ac2:43d6:0:b0:52b:bdfe:e0c9 with SMTP id
 2adb3069b0e04-52ca6e562camr1241037e87.9.1718347703314; Thu, 13 Jun 2024
 23:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
In-Reply-To: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Jun 2024 08:48:11 +0200
Message-ID: <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
Subject: Re: net: dsa: Realtek switch drivers
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	"ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"luizluca@gmail.com" <luizluca@gmail.com>, "justinstitt@google.com" <justinstitt@google.com>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:49=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> I'm starting to look at some L2/L3 switches with Realtek silicon. I see
> in the upstream kernel there are dsa drivers for a couple of simple L2
> switches. While openwrt has support for a lot of the more advanced
> silicon. I'm just wondering if there is a particular reason no-one has
> attempted to upstream support for these switches?

It began with the RTL8366RB ("RTL8366 revision B") which I think is
equivalent to RTL8366S as well, but have not been able to test.

Then Luiz and Alvin jumped in and fixed up the RTL8365MB family.

So the support is pretty much what is stated in the DT bindings
in Documentation/devicetree/bindings/net/dsa/realtek.yaml:

properties:
  compatible:
    enum:
      - realtek,rtl8365mb
      - realtek,rtl8366rb
    description: |
      realtek,rtl8365mb:
        Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
        RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL836=
7S,
        RTL8367SB, RTL8370MB, RTL8310SR
      realtek,rtl8366rb:
        Use with models RTL8366RB, RTL8366S

It may look like just RTL8365 and RTL8366 on the surface but the sub-versio=
n
is detected at runtime.

> If I were to start
> grabbing drivers from openwrt and trying to get them landed would that
> be a problem?

I think the base is there, when I started with RTL8366RB it was pretty
uphill but the kernel DSA experts (Vladimir & Andrew especially) are super
helpful so eventually we have arrived at something that works reasonably.

The RTL8356MB-family driver is more advanced and has a lot more features,
notably it supports all known RTL8367 variants.

The upstream OpenWrt in target/linux/generic/files/drivers/net/phy
has the following drivers for the old switchdev:
-rw-r--r--. 1 linus linus 25382 Jun  7 21:44 rtl8306.c
-rw-r--r--. 1 linus linus 40268 Jun  7 21:44 rtl8366rb.c
-rw-r--r--. 1 linus linus 33681 Jun  7 21:44 rtl8366s.c
-rw-r--r--. 1 linus linus 36324 Jun  7 21:44 rtl8366_smi.c
-rw-r--r--. 1 linus linus  4838 Jun  7 21:44 rtl8366_smi.h
-rw-r--r--. 1 linus linus 58021 Jun 12 18:50 rtl8367b.c
-rw-r--r--. 1 linus linus 59612 Jun 12 18:50 rtl8367.c

As far as I can tell we cover all but RTL8306 with the current in-tree
drivers, the only reason these are still in OpenWrt would be that some
boards are not migrated to DSA.

But maybe I missed something?

Yours,
Linus Walleij

