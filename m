Return-Path: <netdev+bounces-135868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901F99F770
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD24C285580
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D261F5824;
	Tue, 15 Oct 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu6+vb1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE941EBA0B;
	Tue, 15 Oct 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021505; cv=none; b=sm/NHv3cpmDenSlkqJ4Pj4YM71XWEijSDGaOeaRM+N9aTpczLHx2QmqfAZWRtJx3fgi+mvtgNbgVy0oLiCZe0f4RN+S8Wmei81a8Qhz/cFJ9lmFS0uxqxJAiyNeJ6iHOmuRvFFx80BPD9aghQYeMaxnoPcgOPN920qdrR9tGsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021505; c=relaxed/simple;
	bh=Q6gIsqbPWQZY8KO+ccS3pnE8GBPtmwXBTH+lqXGVDRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcCQGCaF2WNoilGwqxx5omrd+YEEec6XskiG9OdAZGgzsH53HAKFlw2JpsZi3r28V8w0NSQMpAceGJNE/6kdYByHNWXRORKXJ2tJvt7mtdYMgB3sC0CiTc0o3oE1C4biGrm59Iiq4fFZATGqLJMEAHRejYVnmx+rCCKO5CDPQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu6+vb1W; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e396a69062so19783047b3.0;
        Tue, 15 Oct 2024 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729021503; x=1729626303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m42kdib9zk5ToFc7jQXCVgkzCmUlpD/gymmWQ8KbQho=;
        b=Pu6+vb1WjSl3vK+rrqgy6atZz/OOtCauO9xMpP+A3DR8hBy5/CIxJbVBSQtYW+fNLb
         DVErf69o7vlq3Ky0gZpMFu4JrraMVUUtovbYsTua1uxBihdVAskqrjnFO4KDMBeC8f+x
         //SUs9LrxPRsZWNieBmnC7/3ymZ1H78HzOT6h4XDYcbhbOCeY91dncNgg8sn3w1JhKjJ
         n0XhszRIYMiuhw2vRoyts+cuJ9LcH/I2jNGAchj2ZzE3rwzd6zxoeU7gm/I3zUkgzmV0
         3xfAtlLDVQ+5Ts1A1b/9M4VHTGrdy1mWCddRYAkzrTF3J30gm7bX+0+nWyi42fBYxqdM
         4Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021503; x=1729626303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m42kdib9zk5ToFc7jQXCVgkzCmUlpD/gymmWQ8KbQho=;
        b=DybPCnE+bEyOlk7xdmJ3cJA6Dia8Lt85Gs62IcRsDIuogHaerSfT08Utg9gK803WNN
         MHOXnOUSB41QxdUiwMPZefemG3Gjgw5RCa7IFYQGdTVhX5uW/hPw92HAGPLsDLZ8ivH0
         1zlsDuW25WXQ2Lhq5I4wQwVPykab/+q1SzVBloimPF7k5PhmtoH9U7Kec5rLZSz74iw/
         bf3MN1+1F4zL+DSWPH3J3n1XVWv7BUayIOY6de5ICY/j2nGrdjkl0k4whllBnDqX7c1C
         vCQ5GnF37RTOgMtJ5OXUB6vZV6WRYDN/J3b1y9HrKnnxpYikTLq18448SYwlX3s9wDrG
         J6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUjIBdqJCXwOx3gxctxlNZXHtq1eBLHPJiuo709czK6u8MViF5KIVMscrwVX6F20MaQllqKCK/b83R3eBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5k+wOntbHMJWkQk+I6oA2Ozuh8hfeupiy9TC/3L4Ba0siysHR
	YqMjWjuLv3Cucbq8AcfdP9pFlfgVxiW5BNdWi1JZ6018TWj0uECbHVBTORO08wqon+dDnsv28nC
	4nWjP8O54kIhBgnC2bRz5LC/xyQM=
X-Google-Smtp-Source: AGHT+IHkItiEolL7LIA+8kG//UdQcyl5SXWJdW9LjXMVyn0uq5l0M5w2qsiNlSwpwaHJgzO7LSZgkzMhvlQ9xbjJMsw=
X-Received: by 2002:a05:690c:7506:b0:6e2:63e:f087 with SMTP id
 00721157ae682-6e347c6e493mr119845947b3.42.1729021503026; Tue, 15 Oct 2024
 12:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011195622.6349-1-rosenp@gmail.com> <20241011195622.6349-7-rosenp@gmail.com>
 <20241012131651.GE77519@kernel.org>
In-Reply-To: <20241012131651.GE77519@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 15 Oct 2024 12:44:52 -0700
Message-ID: <CAKxU2N87Nqa73M+wda3Phayu5dmkWEMhDXgxz=4bASV_-8D4yQ@mail.gmail.com>
Subject: Re: [PATCHv6 net-next 6/7] net: ibm: emac: generate random MAC if not found
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Shannon Nelson <shannon.nelson@amd.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Breno Leitao <leitao@debian.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 6:16=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 11, 2024 at 12:56:21PM -0700, Rosen Penev wrote:
> > On this Cisco MX60W, u-boot sets the local-mac-address property.
> > Unfortunately by default, the MAC is wrong and is actually located on a
> > UBI partition. Which means nvmem needs to be used to grab it.
> >
> > In the case where that fails, EMAC fails to initialize instead of
> > generating a random MAC as many other drivers do.
> >
> > Match behavior with other drivers to have a working ethernet interface.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/core.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index b9ccaae61c48..faa483790b29 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -2937,9 +2937,12 @@ static int emac_init_config(struct emac_instance=
 *dev)
> >
> >       /* Read MAC-address */
> >       err =3D of_get_ethdev_address(np, dev->ndev);
> > -     if (err)
> > -             return dev_err_probe(&dev->ofdev->dev, err,
> > -                                  "Can't get valid [local-]mac-address=
 from OF !\n");
> > +     if (err =3D=3D -EPROBE_DEFER)
> > +             return err;
> > +     if (err) {
> > +             dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. =
Generating random.");
> > +             eth_hw_addr_random(dev->ndev);
> > +     }
>
> The above seems to take the random path for all errors other than
> -EPROBE_DEFER. That seems too broad to me, and perhaps it would
> be better to be more specific. Assuming the case that needs
> to be covered is -EINVAL (a guess on my part), perhaps something like thi=
s
> would work? (Completely untested!)
>
>         err =3D of_get_ethdev_address(np, dev->ndev);
>         if (err =3D=3D -EINVAL) {
>                 /* An explanation should go here, mentioning Cisco MX60W
>                  * Maybe the logic should even be specific to that hw?
>                  */
>                 dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. =
Generating random.");
>                 eth_hw_addr_random(dev->ndev);
>         } else if (err) {
>                 return dev_err_probe(&dev->ofdev->dev, err,
>                                      "Can't get valid [local-]mac-address=
 from OF !\n");
>         }
That's just yak shaving. besides 0 and EPROBE_DEFER,
of_get_ethdev_address returns ENODEV, EINVAL, and maybe something
else. I don't see a good enough reason to diverge from convention
here. This same pattern is present in other drivers.
>
> Also, should this be a bug fix with a Fixes tag for net?
No. It's more of a feature honestly.
>
> >
> >       /* IAHT and GAHT filter parameterization */
> >       if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
> > --
> > 2.47.0
> >

