Return-Path: <netdev+bounces-123583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFEE9655FE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9F1C20643
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5113049E;
	Fri, 30 Aug 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqsziju8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4C29A0;
	Fri, 30 Aug 2024 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990065; cv=none; b=jENhHp4dhCBQKxhADMJGp59khrIMhBwplBF/+tMrwcgKukQXissNZ0cm5GbBXJhiE0pPWJ/IXw28BBO09FyrvzS8NrjU34BiWb9XHITCYt1BFNvahL3F4zRRbD4xX92WJQKrTrpy0z23cwLocfINZasYPMqu30FExeR08t790bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990065; c=relaxed/simple;
	bh=qSa8qpEcqs43Et2vEMzXTv9OSIRSK4DuHrdY9SGNk6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpkCixpVrmU8oH3BdLbs5WYUxAOyTZ9BfJzDLCMNEa8YrpUonGgtRW3eIy8vLGVssB7Df5eAKrLHTBZAjDun75c69wJo6Xbg8oAG13SnIwMR2iqyttYVPXNvykxlRRlQQYYiGDvgeepWDSMtlphrBBHIGTWK7RhL+aU4y//Jttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqsziju8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c91f9fb0acso13041497b3.2;
        Thu, 29 Aug 2024 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724990062; x=1725594862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWMQeecFg7GeFpTeEpFKVAwQ46Jlz7cWmd8DkzfvIFE=;
        b=Dqsziju8uyJE0cEpOBPoaOuL1hizWuxjr0BszjDQlu2kvNka6A9ky9U5ocV+stX3Sf
         ClhkgEKGYQ93TmxXiR5wCa0KrsWBiFPi55UMa07nC4YU3BKXh1OjMOk8yS6CgV782ytW
         lkPw/DNA8HEIxV7SIGmK6sBVYyaWuveeu8Hyo7hmrgubmOVOSbR5JhAVli27JvF+UvtR
         398SlA1z7K+yUQvTJp19PXRP8GK8d4SQLHJUuk8cz3WB8rfMtyNphHUvju7ebLxDI6Kz
         jxnGnxz2netqaIaMwXQUtz44oysU9mdz0udxZLjZtCZql8ZxfTsV/UlT8XqNS13Zf5RV
         BzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724990062; x=1725594862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWMQeecFg7GeFpTeEpFKVAwQ46Jlz7cWmd8DkzfvIFE=;
        b=wW20dP9PYitVn1ZTHHChoqHV86DxEk1HqhN1+os+EBF5Ho9fuHjpNOQ4YP3ZYkXI3v
         20nAxeLGiDMdr/uApTnDLLHGuI4nCGWzwM8xEvwYznO21IX0ytD3fIMTOatsVdwYhmYn
         DewBEwi9I0kzxjGHzAK6Ihl9ACoI7UtpnbPNFaLoRvG+wwJ205mP2YmadZUFCj1UJN2b
         A2QnzQzx9L69igUF8uSbIawF6vkdIBU2LPHQ87Aj5XTTw7qdlrreFEu76zaNGLd4nmPX
         6uYlUXD61+i/lxO6qoMvxPtLnjmTgtoV7smM7fEnGW9v0a06c5BNpf/8j5lnMDqqur22
         H/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzEKNFCOclcAtQ9YyOHp/n09z/uz2btW1ge4AzAZFZHXtU9LoBMowHgXij1m/M/L+K0Zw6VbyK@vger.kernel.org, AJvYcCX6qNqZahE/aAdt1ieotNv3Gchps/o7S9Q1Rqbr/Kdpgz1JTXK5ewb6LwsibouDWOxVBemTIT0HNTQ2Vlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYs2fCvku3j4JGB4hiF/kq3CwuBeIk7rPt1dcwcDCj7VYGyR8
	EJjQN1ncyyrw6c07Ju98762UVN6KmHiFZPvFtCQCsIKsiGwzmMqVCsxRXmqFRkUtdvlUwMhiD9Q
	FtyFvYPqWLPCdxmjfdSLAEEXcdHo=
X-Google-Smtp-Source: AGHT+IFDx7OWF6Zc8GOJWDyoOfHOYCYKAA742Il10GG3lQlC5yIKGJNG/H7n38P7s8guEGT8uau2TNJ63PxsBNB56YA=
X-Received: by 2002:a05:690c:4f0d:b0:6d3:9129:575f with SMTP id
 00721157ae682-6d40ff1171fmr6271047b3.38.1724990062514; Thu, 29 Aug 2024
 20:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826212205.187073-1-rosenp@gmail.com> <20240827161258.535f8835@kernel.org>
 <CAKxU2N-SDtFCrXWDc_2fGKSjosjBg=s4PJ2ztETrocTDo75ayQ@mail.gmail.com> <CAJq09z6JvN4t=xSsxAY97FAtkL2YfkVCGJ6G5YA_PTsC=jFtHg@mail.gmail.com>
In-Reply-To: <CAJq09z6JvN4t=xSsxAY97FAtkL2YfkVCGJ6G5YA_PTsC=jFtHg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 29 Aug 2024 20:54:11 -0700
Message-ID: <CAKxU2N9SdcF=Ku1bNzuBNhPSqpHZ2930jehts27SEAHPRNkxMg@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:20=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:
>
> > On Tue, Aug 27, 2024 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 26 Aug 2024 14:21:57 -0700 Rosen Penev wrote:
> > > > Currently, the of variant is missing reset_control_put in error pat=
hs.
> > > > The devm variant does not require it.
> > > >
> > > > Allows removing mdio_reset from the struct as it is not used outsid=
e the
> > > > function.
> > >
> > > > @@ -683,6 +682,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> > > >       struct device *dev =3D &ag->pdev->dev;
> > > >       struct net_device *ndev =3D ag->ndev;
> > > >       static struct mii_bus *mii_bus;
> > > > +     struct reset_control *mdio_reset;
> > >
> > > nit: maintain the longest to shortest ordering of the variables
> > > (sorted by line length not type length)
> > >
> > > >       struct device_node *np, *mnp;
> > > >       int err;
> > > >
> > > > @@ -698,10 +698,10 @@ static int ag71xx_mdio_probe(struct ag71xx *a=
g)
> > > >       if (!mii_bus)
> > > >               return -ENOMEM;
> > > >
> > > > -     ag->mdio_reset =3D of_reset_control_get_exclusive(np, "mdio")=
;
> > > > -     if (IS_ERR(ag->mdio_reset)) {
> > > > +     mdio_reset =3D devm_reset_control_get_exclusive(dev, "mdio");
>
>
>
> > > > +     if (IS_ERR(mdio_reset)) {
> > > >               netif_err(ag, probe, ndev, "Failed to get reset mdio.=
\n");
> > > > -             return PTR_ERR(ag->mdio_reset);
> > > > +             return PTR_ERR(mdio_reset);
> > > >       }
> > > >
> > > >       mii_bus->name =3D "ag71xx_mdio";
> > > > @@ -712,10 +712,10 @@ static int ag71xx_mdio_probe(struct ag71xx *a=
g)
> > > >       mii_bus->parent =3D dev;
> > > >       snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag-=
>mac_idx);
> > > >
> > > > -     if (!IS_ERR(ag->mdio_reset)) {
> > > > -             reset_control_assert(ag->mdio_reset);
> > > > +     if (!IS_ERR(mdio_reset)) {
> > >
> > > Are you planning to follow up to remove this check?
> > > Would be nice to do that as second patch in the same series
> > I actually have no idea why this is here. I assume it's some mistake.
> > I don't think it's meant to be optional...
>
> {devm,of}_reset_control_get_exclusive() will return an error if the OF
> node is missing. If it should be optional, it should be
> devm_reset_control_get_optional_exclusive(), which would return NULL
> if it is missing.
I assume during upstreaming it was suggested to remove optional.
>
> The equivalent driver used in OpenWrt does explicitly make it
> optional. https://github.com/openwrt/openwrt/blob/4646aa169986036772b9f75=
393c08508d20ddf8b/target/linux/ath79/files/drivers/net/ethernet/atheros/ag7=
1xx/ag71xx_main.c#L1532,
And also the wrong check (it should be NULL).

> while the mac_reset is mandatory. They might have a reason for that or
> maybe only heritage from Atheros AG7100 driver.
>
> > >
> > > > +             reset_control_assert(mdio_reset);
> > > >               msleep(100);
> > > > -             reset_control_deassert(ag->mdio_reset);
> > > > +             reset_control_deassert(mdio_reset);
> > > >               msleep(200);
> > > >       }
>
> Regards,
>
> Luiz

