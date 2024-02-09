Return-Path: <netdev+bounces-70514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE4884F5AE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D82288651
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23B381AB;
	Fri,  9 Feb 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPzgIgFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC637716
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484682; cv=none; b=Kl8nY4nOH971QhMnSxYeSL+Q14WxyCBPWvbvKKDtFrfIGz56cbkisd5lOnH0ktIAvnMPM7nO49iHbFaGvSUY3352bXCnQoa/KqdtJ2JthT2C4XAiAJYLW4IizR1cXaxP2W7M1N3NXXxqmyBS1KawBahfTXYorTHxV6+7EKM18Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484682; c=relaxed/simple;
	bh=Mim8vD8gJESe/0fUDuSiNMYfNHsNLNW6PUf+sKUsmmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li91wp4d3fZMf0NiQn5c1OhHJEAzhMPN9sniDPcgz6YkOtbyyl5euN9a3v9TA2TcOxhxOWSigrqOdvEjrF0nQU7qkWnsUxXobYVOv3FAwchyh7d0YPn4gR/yARK2cFLLrnzlnB/A7S6iGRUUX0OivwCGaqY/LhVeEWCMhUlTszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nPzgIgFk; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6049416cd38so8118727b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484679; x=1708089479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mim8vD8gJESe/0fUDuSiNMYfNHsNLNW6PUf+sKUsmmc=;
        b=nPzgIgFkObO0MOc3p2guR2EGNA9uycENx1/ttXnVcyTdBOkE1NsDiggiF2+2EurKYC
         FjhpT3X5sBPZAKv490e4/WlIkddhjRJWKA6ZVEHpjvQfbgIAnj2RIu4TF3pT90p3SlHs
         KlpPGaUcVu9RzQROoissIYYaIiXshhuybTbQz87t1oJYWcOnQWrqnQAT6t00doVPNv5M
         /L4JsmCNgV9SZtj3eVFf2lWsA24lFwLbu/uIUpoD5yUuS/5tAMZWMsmVmjlolZ3xZx15
         WycMnoG8b4XUyfhvan71FD1IHkx+kvL9wwOqqUbc4X235Q1JIn6Fu02aX7TKHlGHxetL
         6IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484679; x=1708089479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mim8vD8gJESe/0fUDuSiNMYfNHsNLNW6PUf+sKUsmmc=;
        b=qByCKsuTu/ipFWqcPueTz+GZLAXD1nOOEL657PkgNAtXOniVpatRnkdUl9G8PTTcWJ
         txUltw5o0lK2JZIJGihOpHDXaZReMH2S7V8yaQrkgQ/YbklrmL2RcrZ8IWnBD/4PpyhD
         Ssig7Z8yY7PBfOhNK0k5tgWsn88il3BPh7WStjbdfparp0fNKTZqUcMyKnJ+/z8wbBw6
         9+MxZ5y4Vueszkg/jA5ldW2B9Mtb6CgyVypt5T2zhvOemylc5nhjTeWSF1AiIJKM6ixZ
         WrMeX2DULd2lR0cmC3VV5ePwkWqNaK4W/Dt1JkYSgZzp85K4M80hEpMAOrLN/6sDz6yg
         yViQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdkCYv4ySgr+otchs/mA0ZRQmQ7MvYChiISarnFhb+zImas14rega5t8ACJPBAd4aQrINd/1W4EXP6XROX8Dqw10b7D9V/
X-Gm-Message-State: AOJu0YzfNRImrUvpYjpF+0ldNTbFU65tHXGtN/uSemGa10IkdhhJhywM
	TJnVvT1z6MD+8+kbrCD6mxfBMRtYThb6PqPtGtDcKfBq9GIBDsagaILAGIeDnCMId4C+SKa6Yli
	EVN+xy0GFyN6gQ9FeEYttZ2xEOuXRZGEgT7Zw4Q==
X-Google-Smtp-Source: AGHT+IFHT66k1WhwsagbjF5zSBn7DbWunprn10+GW30Mc1Txx10f+fBBGhs8Ga0o7pdvWU8CUBQ9Ep34Dd1f1e8Om98=
X-Received: by 2002:a0d:d696:0:b0:5ff:4e43:8430 with SMTP id
 y144-20020a0dd696000000b005ff4e438430mr1356875ywd.1.1707484679550; Fri, 09
 Feb 2024 05:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:17:48 +0100
Message-ID: <CACRpkdbw+mJsGb=6iu6f+mGoi+vouu6TPztaD5SyuG+n8Staew@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The current driver consists of two interface modules (SMI and MDIO) and
> two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
> modules serve as the platform and MDIO drivers, respectively, calling
> functions from the variant modules. In this setup, one interface module
> can be loaded independently of the other, but both variants must be
> loaded (if not disabled at build time) for any type of interface. This
> approach doesn't scale well, especially with the addition of more switch
> variants (e.g., RTL8366B), leading to loaded but unused modules.
> Additionally, this also seems upside down, as the specific driver code
> normally depends on the more generic functions and not the other way
> around.
>
> Each variant module was converted into real drivers, serving as both a
> platform driver (for switches connected using the SMI interface) and an
> MDIO driver (for MDIO-connected switches). The relationship between the
> variant and interface modules is reversed, with the variant module now
> calling both interface functions (if not disabled at build time). While
> in most devices only one interface is likely used, the interface code is
> significantly smaller than a variant module, consuming fewer resources
> than the previous code. With variant modules now functioning as real
> drivers, compatible strings are published only in a single variant
> module, preventing conflicts.
>
> The patch series introduces a new common module for functions shared by
> both variants. This module also absorbs the two previous interface
> modules, as they would always be loaded anyway.
>
> The series relocates the user MII driver from realtek-smi to rtl83xx. It
> is now used by MDIO-connected switches instead of the generic DSA
> driver. There's a change in how this driver locates the MDIO node. It
> now only searches for a child node named "mdio".
>
> The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
> always in use and avoids dynamic memory allocation.
>
> Testing has been performed with an RTL8367S (rtl8365mb) using MDIO
> interface and an RTL8366RB (rtl8366) with SMI interface.

Tested on my RTL8366RB on a D-Link DIR-685 as well, works like a
charm:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

