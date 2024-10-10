Return-Path: <netdev+bounces-134020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427D997AC5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57292834E0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BA186E52;
	Thu, 10 Oct 2024 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOOoKvhp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55827224CF;
	Thu, 10 Oct 2024 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528803; cv=none; b=SZaF02TmdPu+qsQCMKcbuO2PGiBnetwFzeTmOrwaW7yF8nZPiCHGp9WGewTuPNah6u7McW8cY40a3pIoyTLxppuuHFJTp6nC5VY2Coz47AepA2mNGp2foKIIY+WLPBhfPEd4lk+BcWY0SY4OgUepSyefABxptpVfaVZI3rC1Cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528803; c=relaxed/simple;
	bh=CtXQBe+HQizeL7jyS75vJwI3DoQoLmEmmZvTIP59uRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB7uomheUx1V0r0+ywmmO4cXPPANyYr+E+dHw3yJLX53+f5vSdxuti2mBU3G1cTjUgvAB3D6gaq559SzxTuo0RFZhM4lkVE/fZgx4AvLxAhczyD5xHovpK4/tuceXZ9+UFD48BVRyEAr4P43Z2aPgJQFK+OkKdSo/xhxHFmVYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOOoKvhp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbb24ee34dso4120667b3.2;
        Wed, 09 Oct 2024 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728528801; x=1729133601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewk/hethu2xH9dTgcQno5BfVBMtAricE6nwyyNlzaZI=;
        b=nOOoKvhptcoRSx7EYyYbBCvawFZrdlnOklz6ZBVhK9Q5eQCe1YEEaQXl7hmOIE7T97
         Z4ahWhLkx8UQKE8y0DZ2AFHHSEdYc8L/C/0J4TUIcGAdA1jXvjSuhw2xgo2mWUUhV6Ja
         LwU09ZrulIzo2Lc14+fDDbualBpV2OcwwBWK6l8zgAuHkfLMdHlHbxf2uzYo1UPD9haS
         WV9aqLERwWxRxYaKrQTzB0yoMtjTmn4inmgAyEDzt3yHhUsa4ALp5tqpLTbt9Em5/xv2
         c7i/QWQ/fMHAS+viygtegtQ745vVmNLZs2mS6A2gRf4tBxjPqKZsNd8YxGa6OxF9jHFA
         fONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728528801; x=1729133601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewk/hethu2xH9dTgcQno5BfVBMtAricE6nwyyNlzaZI=;
        b=b+PPZKqesAM4Zq5TN7rSJ4QZFBYwYs0KCJiCiwiN3vgENp9JKeI3HXsT8JVR4Zehvu
         1KQoeWBDWQlttXVPSzcfuEtYt91i2nH5MfsN9UkY2pMMOmU+KTPg5+w4Gyv8dbK45Mek
         gxwKRqxQjB2hdtl1f1P+fTLV3f0d659DL7Yt/k0Lp5uhn4G10pUOk2Fe5h1AUDnvJVDk
         Rykm36MDk8/vcruzCyC738BGPa+MBMrCn3jB9BKgsbPPBnlcGlY2jrcTZvGJRxxPE6wP
         qjDYYC4HEcpnRVz0uEWtv3Xl+R4mmpKIH/LS0K46soxecGvx2N5L0FVtH+Ex91PLbEUn
         41Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZkEsoqD0N/sQx1d0e35nFJH0t7quWWHsazL2DicHLFXOE/q05989mn5tHSV9Bz4nZ/5Vc+1pmwARaBk=@vger.kernel.org, AJvYcCUJ6SVI98lQIV5RQATuE3/OQq6etRqJ4DE2iv0G9JH6lHAxUpKLD6BsGR0067dx1m3vPFqyTXG2@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtrRYLVPsmykVnLSJGTdIkNxZP+0TvtM66npkyufN/F68LWLa
	/hK+gyKG6i/BUGH3ev0ePoACdKzKhtRUgzKvX3wH8PIczPebFNe5IMfz11N+E2S3kiX+Eh+QQiG
	fuSEa431WKPvEWNKf12JIy4W9CVk=
X-Google-Smtp-Source: AGHT+IHCeKSj/7lMhpketbVsq444uxxDZtMof7lBWNL03PxEo8ur5iGSDtL/Kb6EXvFGtxwlSpN4bpEtFWkZaOBHhNA=
X-Received: by 2002:a05:690c:2a43:b0:6db:4809:ed57 with SMTP id
 00721157ae682-6e32e20e276mr20343017b3.22.1728528801344; Wed, 09 Oct 2024
 19:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008233050.9422-1-rosenp@gmail.com> <20241009-precise-wasp-from-ganymede-defeeb@leitao>
 <20241009192854.28fb1f41@kernel.org>
In-Reply-To: <20241009192854.28fb1f41@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 9 Oct 2024 19:53:10 -0700
Message-ID: <CAKxU2N8kvKD4+a82jFdLuABsinZjiHsHuD33B8mgZ6tUBfn0_w@mail.gmail.com>
Subject: Re: [PATCHv2 net] net: ibm: emac: mal: add dcr_unmap to _remove
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	David Gibson <david@gibson.dropbear.id.au>, Jeff Garzik <jeff@garzik.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 7:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 9 Oct 2024 01:23:02 -0700 Breno Leitao wrote:
> > Hello Rosen,
> >
> > On Tue, Oct 08, 2024 at 04:30:50PM -0700, Rosen Penev wrote:
> > > It's done in probe so it should be done here.
> > >
> > > Fixes: 1d3bb996 ("Device tree aware EMAC driver")
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  v2: Rebase and add proper fixes line.
> > >  drivers/net/ethernet/ibm/emac/mal.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethern=
et/ibm/emac/mal.c
> > > index a93423035325..c634534710d9 100644
> > > --- a/drivers/net/ethernet/ibm/emac/mal.c
> > > +++ b/drivers/net/ethernet/ibm/emac/mal.c
> > > @@ -742,6 +742,8 @@ static void mal_remove(struct platform_device *of=
dev)
> > >
> > >     free_netdev(mal->dummy_dev);
> > >
> > > +   dcr_unmap(mal->dcr_host, 0x100);
> > > +
> > >     dma_free_coherent(&ofdev->dev,
> > >                       sizeof(struct mal_descriptor) *
> > >                       (NUM_TX_BUFF * mal->num_tx_chans +
> >
> > The fix per see seems correct, but, there are a few things you might
> > want to improve:
> >
> > 1) Fixes: format
> > Your "Fixes:" line does not follow the expected format, as detected by
> > checkpatch. you might want something as:
> >
> >       Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> >
> >
> > 2) The description can be improved. For instance, you say it is done in
> > probe but not in remove. Why should it be done in remove instead of
> > removed from probe()? That would help me to review it better, instead o=
f
> > going into the code and figure it out.
> >
> > Once you have fixed it, feel free to add:
> >
> > Reviewed-by: Breno Leitao <leitao@debian.org>
>
> Good points, I'll fix when applying - I want to make sure this gets
> into tomorrow's PR 'cause Rosen has patches for net-next depending
> on it.
Much appreciated.

