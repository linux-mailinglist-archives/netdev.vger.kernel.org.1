Return-Path: <netdev+bounces-62663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46D82863F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D4BB22AE8
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9338DC9;
	Tue,  9 Jan 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+Wu+ee7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71F381BB
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso29668847b3.1
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704804569; x=1705409369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh8XLdDq/BTPS3YlBc+SIpy7Jy6WuYwqaxjYX/Z9Bbc=;
        b=G+Wu+ee7n7VuDIFhLgs/KgdUg5g8sYfXW+f0bCXH+LJsyyC7T2AzzpztfSSk4OxA6f
         PPJ5dKeYQ1iHmYcdaD1YAMOeaDtrtF1AGZvNyqS3Rd7oXVRxeU+3/d5KlGJ4m2v8XlrA
         VW8fpjt5RhbjXzapW0IPripsAeQmhcpFOtUKYrrt6YsttjnU/yeJ6jshhr8bCseCD1FD
         DD8hW5lVFqFlqk0dco7wFCR7fak5Ku8F2vXt6eviqUropYKcpPxsF0rRxh5579Z09E/k
         Vomzf8E8+N+i1vZLMGW39UgwfOtbSpUqzY9gm8jSIZgjXiKcc+E61STJaKZYUmeT1Fcz
         HW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804569; x=1705409369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh8XLdDq/BTPS3YlBc+SIpy7Jy6WuYwqaxjYX/Z9Bbc=;
        b=EFCr1HHWm+CU8IxDEceSMlVhytfjyfhtzSR1dICFxRNc1Zy5S6oNfTNic9ZtCMLFPF
         XipPQ/aWxk2QURALdhXPqDsOHFYGQ1f7GRtEIi6RPHYqhC1ZqidEzTMkPYxJAhjE/36Q
         E2V0al7d0OsKU7YDyJ56Go3MN2QxM/AeUdQ7JTklrCuv0DYEyjCHM3X0GTXvl/bDEY42
         FWGI1dD4AaB12RX5MS/QmCUGMlsTlaupOhgtXSgcU3F1nXQgiATzia3Z6dEEVIsbnjLv
         627LNLI6o+cfNpDJ0lYD39YE9kHNN4He2uW4f3t7IlJ8KczeeHpbnKClBTO5dggZcP6v
         d04w==
X-Gm-Message-State: AOJu0Yw5d86afYXqzt7h+ox5lb6JcGgv85WszyYf8pOLuEsBNWcM0wF9
	kn12+WJ3PWUGAG0MfEC2KxAtLHJ+0tOy0Mnp2JR1J2Zr1Tg2JQ==
X-Google-Smtp-Source: AGHT+IFnWJ1a+SxEIOr6msm1T5lg4IqUUZf0DVvKgWcwm+MGscS7q34ZdZTHKFDA+jnDexoYM2n5cTkBIhkROLuy9Mg=
X-Received: by 2002:a81:4f8f:0:b0:5f5:97c6:3f73 with SMTP id
 d137-20020a814f8f000000b005f597c63f73mr3873867ywb.53.1704804569096; Tue, 09
 Jan 2024 04:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-5-luizluca@gmail.com>
 <20240108141103.cxjh44upubhpi34o@skbuf>
In-Reply-To: <20240108141103.cxjh44upubhpi34o@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Jan 2024 13:49:17 +0100
Message-ID: <CACRpkdbU=jtYd4XgHZnwcgm66S-VOHp_XyfSKFYz0xU78KdPrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] net: dsa: realtek: merge common and
 interface modules into realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 3:11=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Fri, Dec 22, 2023 at 09:46:32PM -0300, Luiz Angelo Daros de Luca wrote=
:

> > +realtek-dsa-objs-y                   :=3D realtek-common.o
> > +realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) +=3D realtek-mdio.o
> > +realtek-dsa-objs-$(CONFIG_NET_DSA_REALTEK_SMI) +=3D realtek-smi.o
> > +realtek-dsa-objs                     :=3D $(realtek-dsa-objs-y)
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) +=3D rtl8366.o
> >  rtl8366-objs                                 :=3D rtl8366-core.o rtl83=
66rb.o
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) +=3D rtl8365mb.o
>
> Does "realtek-dsa-objs-y" have any particular meaning in the Kbuild
> system, or is it just a random variable name?

It's a Makefile naming convention, meaning this is always enabled.

linux$ git grep 'objs\-y'  | wc -l
52

Yours,
Linus Walleij

