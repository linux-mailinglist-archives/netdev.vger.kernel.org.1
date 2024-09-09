Return-Path: <netdev+bounces-126655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0CF97226A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7201C23A2D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8E189B95;
	Mon,  9 Sep 2024 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/V8sEuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09254278;
	Mon,  9 Sep 2024 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909292; cv=none; b=ksANZ9ChoATGjWQ+Y6IDEdO6z/K0asi+otw04sqTofbnlCw3cNRj6rNK+HJtZzfDTP1DGBLTZS3zT6UoxNmUEqPbBErKqUFkplRfYZLQMD0bsYvl23u5vTtsvnw9pEsT7Z0FGZLqmPnrA4eksqbngtR8K2qvO+iuyXoglAXfnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909292; c=relaxed/simple;
	bh=EDPpU4CjXdONxAJVx32sMdE9LeQBk9tR2GAaJ2kQOAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjTPlYVBlccfTv5aJWiKvnlr+RBsvelgxOTLZumEiNS6YkTIK5dfO0uLd4sGeIiXSWBn2zi23fjt5RPojii++loV2vdEOWzJ3ibDRHUCl4AlDIqEehrNIkJKWpCMhbomR9rqA/Z9PqRBrzf4Sk0Y5z/rN9SdVXm8AByRfDZkdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/V8sEuE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6bada443ffeso35205707b3.0;
        Mon, 09 Sep 2024 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725909289; x=1726514089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXpPhEAkazUKV9cAwnL8D8r9ewqpmxLEV7GBLQ29Enw=;
        b=R/V8sEuEYVtgFW1B/G5HUqvH4OpZw0HUKefSX8k6K7SlsaaKxeaJVwH7RV1L0w5Jmz
         rMBABNNwEhRgtmvT4mSS9z4N0yVy+L8hnmVA6Rn+rZPfyXwVLhfnOGYStJ2FWXnBYXqo
         WGiH9frX0LwpOiQXIKYCW8kFw56Rzupukgz2PVUOYPeS5iBcdmJMMJtFRlomewuF82FF
         nR41i6S1tZrsk1EHJgvS3vbSe1j08knOXtO2UcEgvHjokORMBvxWNs2bA9OLyVumCTNv
         b2Llw+Uk31Y/RoaWgbtWdZo//gVOJuOHWHrSyuhpRYTmEquLBGGw2RdtrEzdjRcdVWB1
         BMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725909289; x=1726514089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXpPhEAkazUKV9cAwnL8D8r9ewqpmxLEV7GBLQ29Enw=;
        b=EY4B6OAHAvtAIJ4DGKpIV1ON+Fjtmr3oEYrNqxoXsdapimQoHlDn/2UN7IPvHxSsQ7
         Th6NhgD4wQ0k964AWAiqCQDI1PswuJpKiNKqRXkDrSnIrQm/TVKym5qGGPn47qHUyQug
         TPts29rmn4XYhRgax24A6Jgq/mPKaO9AHDDpVQruLtxiKSaRfFjgo+e/kDdw/SooAzQI
         UtIbKx/V8s0ZIrDeTx509tPTqHd7mETCpnAbSvYtWL9H1XJiZjVt7tdqb6V4DpoVPV7T
         utxLQyfHeGVaQZx8FpN+4iutoHEQn14qAduWMOvjvlanDVkIC+1wQnNdl8TRRauE6/fA
         YFPw==
X-Forwarded-Encrypted: i=1; AJvYcCUE7j0ZHBpZZsPBwKnzXUEP0FJLMWKEYj7r7SR83dzpGqVRzU+BXRfzzlVWExeohvWiwxilCKspOjsdTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJtFNJBvjAY+DDyJZxT/lbCUaauY+K4R+QP3ajiEfW9h/Kt/H
	nGRWPcrIJvWdLlP6qkSEZRmYAcV1W2ojZP6lgW4gKlXSIZrjiYd7u4f0L6KGY6KJMIhBtLtQkIR
	Xsi8T5G/BxEnJQ9bFp4ANnNj2zo0mqbNY
X-Google-Smtp-Source: AGHT+IFu8THfw/BxASPvGEBO7vTugahGZMyAP29Unmk6DgR5hr+vNrn1EW+gi4zJ7wAJ9SuQKez6duDcCA5TDQdnnDk=
X-Received: by 2002:a05:690c:6281:b0:618:691b:d261 with SMTP id
 00721157ae682-6db95383df6mr6444727b3.13.1725909289633; Mon, 09 Sep 2024
 12:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908213554.11979-1-rosenp@gmail.com> <20240909085542.GV2097826@kernel.org>
 <CAKxU2N_1t5osUc53p=G2tRLRctwbxQr3p3fScR-N1kgoNxc80Q@mail.gmail.com>
 <CAKxU2N9kgnqAgo2mHxExjgZos+MvhZw40LWCr4pYOL5DUcJJWg@mail.gmail.com> <20240909184850.GG2097826@kernel.org>
In-Reply-To: <20240909184850.GG2097826@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Sep 2024 12:14:38 -0700
Message-ID: <CAKxU2N_y9CM=P3ki2XGDV+9nZ9SCQwC3y2qWRHbiEZzKK_t62Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com, mail@david-bauer.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:48=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Sep 09, 2024 at 11:20:20AM -0700, Rosen Penev wrote:
> > On Mon, Sep 9, 2024 at 11:11=E2=80=AFAM Rosen Penev <rosenp@gmail.com> =
wrote:
> > >
> > > On Mon, Sep 9, 2024 at 1:55=E2=80=AFAM Simon Horman <horms@kernel.org=
> wrote:
> > > >
> > > > On Sun, Sep 08, 2024 at 02:35:54PM -0700, Rosen Penev wrote:
> > > > > If nvmem loads after the ethernet driver, mac address assignments=
 will
> > > > > not take effect. of_get_ethdev_address returns EPROBE_DEFER in su=
ch a
> > > > > case so we need to handle that to avoid eth_hw_addr_random.
> > > > >
> > > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > > ---
> > > > >  drivers/net/ethernet/freescale/gianfar.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/n=
et/ethernet/freescale/gianfar.c
> > > > > index 634049c83ebe..9755ec947029 100644
> > > > > --- a/drivers/net/ethernet/freescale/gianfar.c
> > > > > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > > > > @@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_devic=
e *ofdev, struct net_device **pdev)
> > > > >               priv->device_flags |=3D FSL_GIANFAR_DEV_HAS_BUF_STA=
SHING;
> > > > >
> > > > >       err =3D of_get_ethdev_address(np, dev);
> > > > > +     if (err =3D=3D -EPROBE_DEFER)
> > > > > +             return err;
> > > >
> > > > To avoid leaking resources, I think this should be:
> > > >
> > > >                 goto err_grp_init;
> > > will do in v2. Unfortunately net-next closes today AFAIK.
> > On second thought, where did you find this?
> >
> > git grep err_grp_init
> >
> > returns nothing.
> >
> > Not only that, this function has no goto.
>
> Maybe we are looking at different things for some reason.
Well that's embarrassing. Locally I seem to have a commit that adds a
bunch of devm and as a result these gotos. Unfortunately I don't have
the hardware to test those changes. I'll be doing a v2 for when
net-next opens.
>
> I'm looking at this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/=
drivers/net/ethernet/freescale/gianfar.c?id=3Dbfba7bc8b7c2c100b76edb3a646fd=
ce256392129#n814
>
> > > >
> > > > Flagged by Smatch.
> > > >
> > > > >       if (err) {
> > > > >               eth_hw_addr_random(dev);
> > > > >               dev_info(&ofdev->dev, "Using random MAC address: %p=
M\n", dev->dev_addr);
> > > >
> > > > --
> > > > pw-bot: cr
> >

