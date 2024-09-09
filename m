Return-Path: <netdev+bounces-126642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985B49721C1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E03B22516
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42917AE19;
	Mon,  9 Sep 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFmLKPRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B316DEB4;
	Mon,  9 Sep 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906034; cv=none; b=TLntXpuJlp5mCfQmYkBms/nAawyUBVs4vMO/YeZL6S/uCFhH6ip9A27F+ySHfIt0aImjY/Jc7HRiOW9DzXesHItVNzG9OII+Z2B1XeAI8jZnEAKqYuCurvHJ48LdYzSciQaIZWUow6LEtwboKm9/vLKb9CFqXDL3EYC/OGTmVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906034; c=relaxed/simple;
	bh=ijaoW8rdHDJMqkLnU1K/ZuLQ4A6Uzq5QAar3wN4Tt4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjT0dRH258+bZrROQdZyS8IfnyXtKPWKnXC0NO5V6UV6EY+3aKvv5EqngxjAzYv4QuZDuzlbsXOAyRgiq6wSG0vsRT41D20Uz9TCQ+YTXVwJLUZLLQo42pVPApRwaDHuf3PuzvPHOC+zMLTqQu2DZzrlPNrJdIp1mMND/cwnhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFmLKPRm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6db20e22c85so39789157b3.0;
        Mon, 09 Sep 2024 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906032; x=1726510832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHTORZOA/voUQKooKk4KrDwjO0B09zNlT3Nb/W5GV5E=;
        b=GFmLKPRmDSz3BwVOihg36pi2aIlbyFqPlqWDuObrUqZSbYqmBRDEhSHIOlaHaZ0hyu
         /w5m42fIKGYNiahmL5IodcJSc0dpt7dG9EdMSft2buQOQPpQ6Ajy2WamoQbupmYxe32N
         5mmuuqdDHzLhtG9nmR38T/6S896okLXd5MCN+vVdwtNwinoAjW7xtTDefXBoQ8yIVRWO
         Z0gUcOMgwaqIGWfL4IjOvG6sbT2L5DsSWOq8tjY5v7edDQ3eMPohfRwqSDEIXrLmhYb8
         Mq7cOymm05juqqkFophCwPxHyjpWmcLYUzqPnmZdjMWinZlVpRAlgdw06RK+2GtSX6Nr
         DzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906032; x=1726510832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHTORZOA/voUQKooKk4KrDwjO0B09zNlT3Nb/W5GV5E=;
        b=P7K6uTJ7aKAzvreqftHrGV1eOSe+uZRSUqYl4brXMn9h2Suxh1Wv7wsJHRmYIlM/gQ
         pSG6oOnjxlAwYbX8h4dv550iHCFhNZ7Nho7F1HMN8m5Y98pI2gUd8592i7wjzULBiW6m
         VvVek7OKo7Y50ctU9GwaS917HvIwDeFDMbypr4ovWejDLlBH8cm1DckHNNRX8k2nQt0A
         hGk5Vlv22YbUutKymHfRTfsJ4D49YQQhQxT5hiISujsky2SL3gNHXvcB1vcnISzmeZP3
         TtuUV/3FEMkglUWek/rn1l0Kzjq0m/nkGo5xKgz9e22KOXbegV6NKw2pWkRupqKBuhKk
         Lrog==
X-Forwarded-Encrypted: i=1; AJvYcCXciPLlj73lnTMXZnZL5qirBGQqvUMNmpUyQKv5bB9FpbzQTvHq5iT5GSc4/QEfJTgXKtLyUKWaJ+9Hjbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjxXDniKLI8vaNusighwZrgNAimOhWi4BivtZTFWnutT6PUr8
	/Vzhnbg35c1RTyM53xuabhtMvd6wkpRsiBpqNLcHWc+XgNDrHA0C+dSkiceGX183KIEtS8hVwZX
	epB2q26QsZW4PkLcpKdk5KWMK88A=
X-Google-Smtp-Source: AGHT+IHAz7Q98VrdVDQ6iVqnCpGEWbi+3X4/FbbVqZ/q/y6RNDr4poX9sj1LaJGZzXD7Gd7Kl9jTikAgusfPh+oKONI=
X-Received: by 2002:a05:690c:3205:b0:63b:d055:6a7f with SMTP id
 00721157ae682-6db452d5328mr88831967b3.38.1725906032248; Mon, 09 Sep 2024
 11:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908213554.11979-1-rosenp@gmail.com> <20240909085542.GV2097826@kernel.org>
 <CAKxU2N_1t5osUc53p=G2tRLRctwbxQr3p3fScR-N1kgoNxc80Q@mail.gmail.com>
In-Reply-To: <CAKxU2N_1t5osUc53p=G2tRLRctwbxQr3p3fScR-N1kgoNxc80Q@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Sep 2024 11:20:20 -0700
Message-ID: <CAKxU2N9kgnqAgo2mHxExjgZos+MvhZw40LWCr4pYOL5DUcJJWg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com, mail@david-bauer.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:11=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Mon, Sep 9, 2024 at 1:55=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
> >
> > On Sun, Sep 08, 2024 at 02:35:54PM -0700, Rosen Penev wrote:
> > > If nvmem loads after the ethernet driver, mac address assignments wil=
l
> > > not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> > > case so we need to handle that to avoid eth_hw_addr_random.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/net/ethernet/freescale/gianfar.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/e=
thernet/freescale/gianfar.c
> > > index 634049c83ebe..9755ec947029 100644
> > > --- a/drivers/net/ethernet/freescale/gianfar.c
> > > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > > @@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_device *o=
fdev, struct net_device **pdev)
> > >               priv->device_flags |=3D FSL_GIANFAR_DEV_HAS_BUF_STASHIN=
G;
> > >
> > >       err =3D of_get_ethdev_address(np, dev);
> > > +     if (err =3D=3D -EPROBE_DEFER)
> > > +             return err;
> >
> > To avoid leaking resources, I think this should be:
> >
> >                 goto err_grp_init;
> will do in v2. Unfortunately net-next closes today AFAIK.
On second thought, where did you find this?

git grep err_grp_init

returns nothing.

Not only that, this function has no goto.
> >
> > Flagged by Smatch.
> >
> > >       if (err) {
> > >               eth_hw_addr_random(dev);
> > >               dev_info(&ofdev->dev, "Using random MAC address: %pM\n"=
, dev->dev_addr);
> >
> > --
> > pw-bot: cr

