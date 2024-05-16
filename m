Return-Path: <netdev+bounces-96799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A38F8C7DF5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0BC1C2160C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071F1581FB;
	Thu, 16 May 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qErQRtYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61350157E9E
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894208; cv=none; b=Dk3xvpHcFVb+ojg+VgudpSegRnz+i3YYw+wNPPf39FlOgAs/U/YB0kwQXxQfteUBLOnD6VCKSmyVVr4D3rn2yjqO5LHUGTE6hhLy/I7NxaQQwvM2QmQrydS2IOFDMN92Ce3YHlxocMfp10/SAkUY47cZs+dM7V7blBbk3GT91Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894208; c=relaxed/simple;
	bh=gFPsoV7ajUF4OLv6oP0wqZRUo4Lbg8VL2YddkU3Eewk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVMGidvi+2jso9pzxWQBiDvoNgPFRqI6L2AXsLz9iwEnmA7ziesso6Uowt12fE6O/T+TwBclf79Ezd1PpCljwhRlA4d/Y4aezIBg4yfSG60ZM4lr/Oiun6fuZa4m1XuugXaPMTnt7FhFSC5iMvnSB+4qsYKP0dq63PtRfZCSYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qErQRtYT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61df903aa05so97045287b3.3
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715894206; x=1716499006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMaG7IMR+sJ8J2lgAfgFE3v9q0yB6kP5iGncpbVhbpk=;
        b=qErQRtYTfnYqwiXjUMSggknieXJvkRhoVC+zfoRBpe+aycMSnFIkPBOM4yrZ2YGjI6
         3wylWWdDCHoGjwJDYqzlfWjdS7L7YBHZvTtMy7RKR6M/mVbZUc7oVyycxe8z3Xm8fDKJ
         LbDBp6zSILAopX1w0Oq/LJ8kGKt3xcYu9U7hmBwPOi4Y5dQyjePOicf1ErL4Hzm8bGSK
         EsHqWmhVOybwZBgZab31Wa6C2gsrz2E4JqghckjyPz8oQSXzhEZqVIbFBzc0vDrNNXjM
         jGmujmdX8JO0/q2OWScgqe5iccpM62BpNF+KmU0D82whVtBDGWuDXZVYt4GWgst7/eVn
         t5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715894206; x=1716499006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMaG7IMR+sJ8J2lgAfgFE3v9q0yB6kP5iGncpbVhbpk=;
        b=OzWK7HQK+dHDQVk3hea+bK6lmxqTqKThVFJItKT8nhDqTCcl9jE9Z8Gcj5U196B/Jr
         bH8JSMr+wy3BZ2LUtWN7hJODloZ+jp8kzl8q4440gCg0GSAdEKxX0XJOuSNmd+2OSeGB
         7UEsmLd1cLtEcPtOSUusaM83QqCh3iKubXP3MtxtMZuePdEK/LlGf2orNKrNPQbLJCBu
         aVUpZq/KZOBWvBEarpQ6x8aHlr7zecmIjgNSYB/hSJgMcGAZ1qHWxLVfaUvgBf9SMEFg
         MhkAwVo0gzuVo95AmXHv2DLdR6jWpVwNx/3qQkFrFbU3j5lSMIIYO5UQ1Ed/pxuYgOkV
         32Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWg/q3kgnq0EpwN/3MPJ7NxJ6GYlO7UjFeRdwdLO1RUbpilwtdIp1k7hX6ioF7FORgdYmLhJFc5fDPIyDAzxEkbLu4aJDFA
X-Gm-Message-State: AOJu0Yx3mIhP0n6CXfAcFgq++FlDop4r+1ahpxwJlakm6ggM4XyjNJnF
	CXcafaP+Z1/NPjLKE33PTTGTphveI2+SFiJfA/g41bCltiBvHFIMuQ4eRtpGd/f9B7qXoAmVZ4d
	acs8r8TjVCicsK3gJI27CVxym5Gi/wbrQjLReXw==
X-Google-Smtp-Source: AGHT+IHi/TdfEGw3EfNBftgoaaFE87uBdegpQdEeB+HWJl+FuAzYVky8zv7+C2XzjBQIad3znH86FViC0867riw+l7o=
X-Received: by 2002:a0d:e6d3:0:b0:627:7871:e172 with SMTP id
 00721157ae682-6277871e364mr40009687b3.51.1715894206225; Thu, 16 May 2024
 14:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
 <20240427-realtek-led-v2-3-5abaddc32cf6@gmail.com> <20240429063923.648c927f@kernel.org>
 <CAJq09z6kBRXKG6QVyfUO6qzKaOZL6sbRnNXu8aT+siywjX7xLg@mail.gmail.com> <CACRpkda9W7SjX+saGY9U5ct6MdD_f-B6C0PTF0OffCRPEsEnrQ@mail.gmail.com>
In-Reply-To: <CACRpkda9W7SjX+saGY9U5ct6MdD_f-B6C0PTF0OffCRPEsEnrQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 May 2024 23:16:35 +0200
Message-ID: <CACRpkda7pSe_ffVpiBsUkEmE0A-+GJ0rdocP2PxGX0Ebm6whcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: add LED drivers for rtl8366rb
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:05=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> On Thu, May 16, 2024 at 7:30=E2=80=AFPM Luiz Angelo Daros de Luca
> <luizluca@gmail.com> wrote:
> > > On Sat, 27 Apr 2024 02:11:30 -0300 Luiz Angelo Daros de Luca wrote:
> > > > +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> > > > +{
> > > > +     struct device_node *leds_np, *led_np;
> > > > +     struct dsa_switch *ds =3D &priv->ds;
> > > > +     struct dsa_port *dp;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     dsa_switch_for_each_port(dp, ds) {
> > > > +             if (!dp->dn)
> > > > +                     continue;
> > > > +
> > > > +             leds_np =3D of_get_child_by_name(dp->dn, "leds");
> > > > +             if (!leds_np) {
> > > > +                     dev_dbg(priv->dev, "No leds defined for port =
%d",
> > > > +                             dp->index);
> > > > +                     continue;
> > > > +             }
> > > > +
> > > > +             for_each_child_of_node(leds_np, led_np) {
> > > > +                     ret =3D rtl8366rb_setup_led(priv, dp,
> > > > +                                               of_fwnode_handle(le=
d_np));
> > > > +                     if (ret) {
> > > > +                             of_node_put(led_np);
> > > > +                             break;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +             of_node_put(leds_np);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +     return 0;
> > > > +}
> > >
> > > coccicheck generates this warning:
> > >
> > > drivers/net/dsa/realtek/rtl8366rb.c:1032:4-15: ERROR: probable double=
 put.
> > >
> > > I think it's a false positive.
> >
> > Me too. I don't think it is a double put. The put for led_np is called
> > in the increment code inside the for_each_child_of_node macro. With a
> > break, we skip that part and we need to put it before leaving. I don't
> > know coccicheck but maybe it got confused by the double for.
>
> Maybe I can use for_each_child_of_node_scoped() and
> get the handling for free? The checkers should learn about
> *_scoped now.
>
> (I'm still working on the patch, I'm just slow.)

Referring to my Marvell LED patch, confusing it for this one,
damn I need to get to sleep :D

Luiz: try to use for_each_child_of_node_scoped()!

Yours,
Linus Walleij

