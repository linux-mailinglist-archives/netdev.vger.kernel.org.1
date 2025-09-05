Return-Path: <netdev+bounces-220473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EBEB46450
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB868A44ECA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779FB2777F9;
	Fri,  5 Sep 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Ocb70a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5681C700D;
	Fri,  5 Sep 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102753; cv=none; b=ugkIxcAEzCmNuNRI8DalCAhGRFr8QL8WLBI7N/kctLEHfuCtiTuFrw5rK3sOAQoGpCElxDnS1yB+XyTBrdANMuKzs9icXNWmMtN5JST4kJwJlw2g9vilSBnB4v2zAh+lUl/H3kQgr08UCfQ49zt/ME8NNB+o+edmWoI6fHZSk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102753; c=relaxed/simple;
	bh=bqrbs/PC1eIAekPYCJDqrwWGrDDmHXavP3fx+WNi4qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srEEQpktTVBhSNUK6PWfToOcn963VhVYQ1jsd+rIGAfKn59gyEmBTIYNmBkmD8QVUelGP6s/zu17cfYWaecrmLd17DgStk//hWK2cdUUxPpa46JH342XMxBv+n7iul9W9QNedu59m1rxeRJjuKIAalNYOwcivNLOaRisD70JvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Ocb70a; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72267c05050so24199907b3.3;
        Fri, 05 Sep 2025 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757102750; x=1757707550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKA6hEtZK0kmYrwUxRuYJdAUenXw/zULxrpsnwN5K2w=;
        b=b4Ocb70af/PRA7PXsHi1i7+vJ1Ab8mcRfUUWpqJ22N0L3Iy9ruXu9XxUWXUYyj53z4
         P9YUNOFwvV/fJkHYyf6XTQFDvdBLZuA0Ilj8O3aZxoYX2r29PmJsABiYqckCLgMc71f0
         kNuhBLoUpDGlmlFIHHoRdE4Iu/QTb+LMKwI/fxaYkPOPf7GXQEFqHrbAUw+V5URfjkAG
         blp1Xj6jTpKF0XGETipMd77UhEiKPROFb/SBs3oxo+1aZM2BvRpBdHe0XI2nXiUrbTPy
         3Lq5dOfPYmQtbzB9BjgyxzNPg71602FJi1gU66rEYMd6K3T4W1umbDvpLF8NkWfb9pUE
         ugsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102750; x=1757707550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKA6hEtZK0kmYrwUxRuYJdAUenXw/zULxrpsnwN5K2w=;
        b=Y8U19ZE4y+s+KL8wVZetx8tem4CXQToIrd6brkrqXWZ6MiC0Q3s9QIbfMowH1JogqO
         xdTlEcfp1ho8dPQMmQ6ANqJ+VkzE82UFH8lFzJ4eO20CukXfoH1ymQe1SMAL/wXd5C8A
         Z2VtfdsRtcnzmY6ZPnL/LX6eqec/i/oNpjslC3PVHEUU6ICvxBvzdQMj0anTIPH0X9Q1
         K8UOd6Nyt5hpmy/b0M+R8/9NAV0BJzoACbLklpOJziyMbwoWeMzG74BA2Vl6Sx9NKli/
         Sd8+TL4A3wN3RzUkad85CTa6tH/NV8esXAFX6ifMUfLwXbMDHLZBEDmVaqTk/M/vRcCq
         8quA==
X-Forwarded-Encrypted: i=1; AJvYcCX5c60TCSesOBELuPxaLUYg3Q+EvxzPJjTgUeUbYUaFjnuG+L0eLj1tsYrZKknIKSw/S640CbbNTnkNbeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8dhFtTM+F3WOJaZV5n7WW+0imTU3xBtH0vmJIaT84LwwUAQq
	i9D2BYT3VzyxuB46F74gpxc3bO8Ou98kzPPB511+o9RSFm9YUVaYm30iAhegaVzvUfdMnX+h575
	Rko6OI3W5XbaeW1bIynubvWvlnJXq65o=
X-Gm-Gg: ASbGncuzY446FNjAR66CX2q1xq6aY87fJQ/xLwzJ0oYhSSiwWLAqcCErsFHS39mWEh2
	8RgG+4MklPk1tJiYtAeIc8NaSD+iTOfDwEck/+QJb045j5NbfAUfCga/DyDAdcWw7Y2K+9V4C5e
	lAlbdshQY0xdplqsK+expZZe5A9cTpzlsYCUy9Q9Qv0oEALLCGo6Rv4XTSyzpHS02ZY/SzuXKeI
	N77FDqGuFO7RtbcQv3QENLMcRExNfc4oGn6EI0NYkPBJRaa7RcCvXC2APPQiukyuqdhkU6FVtrI
	Ociv6w==
X-Google-Smtp-Source: AGHT+IFy0fxvP0JYNQImtQhsURo0dkg7o4UCvVnuBobrArzGidginhLo0KRcfz2oxOMAO0h2OgfwOYJfSkRT4zAnFpE=
X-Received: by 2002:a05:690c:46c9:b0:721:30a5:3bf1 with SMTP id
 00721157ae682-727f31adea8mr1518317b3.16.1757102749594; Fri, 05 Sep 2025
 13:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904203834.3660-1-rosenp@gmail.com> <20250905125220.mhy7ln4ufhg4onwo@skbuf>
In-Reply-To: <20250905125220.mhy7ln4ufhg4onwo@skbuf>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 5 Sep 2025 13:05:38 -0700
X-Gm-Features: Ac12FXzrINMLTF1f4ATSLLF5dHd20WdzpcBmq3Ju8d8S_HmRhijP1V4W9X46oe8
Message-ID: <CAKxU2N8MCKGoj2kfVC5ZM=6jj5v1NSjTkS2d8X6eOKcmbUiD2w@mail.gmail.com>
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 5:52=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Thu, Sep 04, 2025 at 01:38:34PM -0700, Rosen Penev wrote:
> > The documentation for lan966x states that phy-mode is a required
> > property but the code does not enforce this. Add an error check.
> >
> > Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 7001584f1b7a..5d28710f4fd2 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -1199,6 +1199,9 @@ static int lan966x_probe(struct platform_device *=
pdev)
> >                       continue;
> >
> >               phy_mode =3D fwnode_get_phy_mode(portnp);
> > +             if (phy_mode)
> > +                     goto cleanup_ports;
>
> It's not really great to submit bug fixes without testing them.
>
> /**
>  * fwnode_get_phy_mode - Get phy mode for given firmware node
>  * @fwnode:     Pointer to the given node
>  *
>  * The function gets phy interface string from property 'phy-mode' or
>  * 'phy-connection-type', and return its index in phy_modes table, or err=
no in
>  * error case.
>  */
>
> The test you add will only pass for phy-mode =3D "", where phy_mode will
> be PHY_INTERFACE_MODE_NA. Otherwise, it will be a negative error code,
> or a positive phy_interface_t value, and both will result in a "goto
> cleanup_ports".
>
> What is the impact of the problem? What happens without your fix?
According to Daniel Machon (one of the developers), it ends up working
with phy_mode missing.

In my OF conversion patch, I'm getting mixed messages on whether to
handle the error or not. I think I'll let someone else deal with this.
>
> > +
> >               err =3D lan966x_probe_port(lan966x, p, phy_mode, portnp);
> >               if (err)
> >                       goto cleanup_ports;
> > --
> > 2.51.0
> >
> >

