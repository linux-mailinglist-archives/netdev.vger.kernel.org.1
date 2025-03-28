Return-Path: <netdev+bounces-178174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D7A75348
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 00:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F97172CCA
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EF1F426F;
	Fri, 28 Mar 2025 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT4R7yzn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14E4A35;
	Fri, 28 Mar 2025 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743204405; cv=none; b=RmgIrjBNWpAoTTkzP1doQSXm/0PvivfmmdV3QpoaKC6oK6YnsEWKE7F0qYu4GFTjzP47TRUhPhXAISdQF3OdM3QB6eEh7N4s+zFBA+TSyiEVVgAECSkP64L85Xabo/t4xv+H4VXGVdlBUUkAMeiOs7bL8KvaV8/qvEC+6LLsW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743204405; c=relaxed/simple;
	bh=JawYoD4Ca8+88pv0PMzL0lnzpoWfKoO/3BBdwzlSd2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnrR+FG/PM0iqp0/BTgt5bAlLu0JHKH42IG6bZrfEUKR33wPqJir+tDus58sDpESomnmQsCc6+M/CeJ2At6gURO1eMEjpuSWm9ydjXzxQkUrtwPxbTD3k9bxHB1KyAYpJ2Gxy5QWHCB+Z9b3xUqUQV1hVzsnwZEMfrj4/0s/V04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT4R7yzn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso27422955e9.0;
        Fri, 28 Mar 2025 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743204402; x=1743809202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6STaknpZNYUi31WfcbcFyYuyQ/X3QqoCZMhNEWphEY=;
        b=mT4R7yznqmGZB0/bMR1e1Ae/Bf0OIuAwatlEy2tznj8kM4/4FpYYaDG1hnf6ioJD4/
         WEGNvTaFr909AfI1ekf5e4+I9t9ViQXg0YtMuhEbueORn0fb/yTsMkL2Y69lQQyknYah
         T/oMgmlNJ9SoX5OLg1b1NYsLyKscFg2JSPW7EaAzfXsGOZXnl3kjzHl0CP3ySxyiyHTK
         5inATqzwpkKPi1IpdFJiAipnYvB0tLAropwX+57Qzdo6syRANql52k6psXsv3xrbREp8
         7RspJmO8CkZjSd1q57ZLXM798k27PvvMUPY7tEkHNaFo3hd6ooKIjOi3pAzXpgwx76IW
         fTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743204402; x=1743809202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6STaknpZNYUi31WfcbcFyYuyQ/X3QqoCZMhNEWphEY=;
        b=LWIF9SqcQzaIkgWumeLxJPCCFbBuUwyK5cUc1qRa08WGAdpsw3SU2eudu/2a4SmUq0
         IuQ2nRtvJpGtZ9P8fVUpQeB56UmDuKJSx1OhkBYDvAdBQy58fSSLHPB9o1gPfAVCAYRQ
         jdhC4y2rOw8TCnULl7wqDLl549fpWrk0dTXWGBG/DKuq5YYphdwIBUxwJ3K/pAlwXv78
         10XTMZ/lBJgiLe4HfpaLEEnc8BALKWgQGZwQ+HrhmRC3GTYPQw2wpczdqU7LTeFuJBJM
         EI1oZEq2OdhTJeuXa/A4jdJBMD5kmrLSHTwoeOF4sa4hG+FVR2iAUhkcC+CVU6EyB9YJ
         ynDg==
X-Forwarded-Encrypted: i=1; AJvYcCXe9igQaduo6GKMzbiQZiMH7KCUkWVlInYb0yu/AjgAau56MbopPemxtux+jd0dcU4k7Sa/oZXpmmvhClc=@vger.kernel.org, AJvYcCXhMX8aL9ndKqL7XM627PcB0cjTXnKtm3h2QNNzYKV4l7Ldu5mDZadWP+P9PQDqWQFiNohBkW6R@vger.kernel.org
X-Gm-Message-State: AOJu0YyXYJ8RxlulkAn4ngmLqK2KQkUIbC9z27HdKQxTTT4qxWikC/cj
	B6S10LDMcp6xnkJlAflsxkNvvl/TZdwDg0aTteAnwWD3cKCicnwG36q7qOi1KlBTIIcNZ0yj52Z
	Moy/6vafdr/R9Mv9AJSRndk5vgKM=
X-Gm-Gg: ASbGncstyeczZVe2bcmionUgSy4mCWxFwh203dntC2P6ifS8O2+diFLr2qV5OqTPvLG
	HXZ1cc2tsrfGj+99zb7qYc3mMlVQnfiEGM3fBuzEJEUxVqLXY9TMH+3D3HOFyt9j/29ftO4SPAH
	sTDl40rD1mWghsYOYY8f0xdNR9SLc/Nn9kj8o3LHgvtTb1QdRrVk1ZBIaDQGU=
X-Google-Smtp-Source: AGHT+IGqnOtE6iSguCCt/EOVRI29ntJXAd0Co1D5ys+CD+aLtuLOr2l+DKgmshYuKhMhJRzehRryDVjtuLL+QWYN8UA=
X-Received: by 2002:a05:600c:1d1f:b0:43c:fceb:91f with SMTP id
 5b1f17b1804b1-43db6226ecfmr11952995e9.11.1743204401846; Fri, 28 Mar 2025
 16:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com> <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
 <20250328090621.2d0b3665@fedora-2.home> <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
 <12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
In-Reply-To: <12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 28 Mar 2025 16:26:04 -0700
X-Gm-Features: AQ5f1JqDq9Q7sgwto-hg2UInEPPfl2eOmLlxCBC65yTnf1VkUtCGKdQGnJ3L08E
Message-ID: <CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 2:45=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Also I am not sure it makes sense to say we can't support multiple
> > modes on a fixed connection. For example in the case of SerDes links
> > and the like it isn't unusual to see support for CR/KR advertised at
> > the same speed on the same link and use the exact same configuration
> > so a fixed config could support both and advertise both at the same
> > time if I am not mistaken.
>
> Traditionally, fixed link has only supported one mode. The combination
> of speed and duplex fully describes a base-T link. Even more
> traditionally, it was implemented as an emulated C22 PHY, using the
> genphy driver, so limited to just 1G. With multigige PHY we needed to
> be a bit more flexible, so phylink gained its own fixed link
> implementation which did not emulate a PHY, just the results of
> talking to a multigige PHY.
>
> But i don't think you are actually talking about a PHY. I think you
> mean the PCS advertises CR/KR, and you want to emulate a fixed-link
> PCS? That is a different beast.
>
>         Andrew

A serdes PHY is part of it, but not a traditional twisted pair PHY as
we are talking about 25R, 50R(50GAUI & LAUI), and 100P interfaces. I
agree it is a different beast, but are we saying that the fixed-link
is supposed to be a twisted pair PHY only? That is the part I am
confused with as there are multiple scenarios where you might end up
with a fixed link configuration at a specific speed for something not
twisted pair. For example in our case the firmware provides us with
the fixed modulation/lanes/fec configuration so we can essentially
take that and treat it as a fixed-link configuration.

In addition one advantage is that it makes it possible to support
speeds that don't yet have a type in the phy_interface_t, so as I was
enabling things it allowed some backwards compatibility with older
kernels. In the case of fbnic I was planning to use pcs_validate to
strip down the supported features and essentially limit things based
on the bitrate per lane and the number of lanes. We were only using CR
so for us the result should only be 1 regardless based on the speed
match.

The general idea I had in mind for upstreaming the support for fbnic
was to initially bring it up as a fixed-link setup using
PHY_INTERFACE_MODE_INTERNAL as that is essentially what we have now
and I can get rid of the extraneous 40G stuff that we aren't using.
Then we pivot into enabling additional PHY interface modes and
QSFP+/28 support in the kernel. Then I would add a mailbox based i2c
and gpio to enable SFP/QSPF on fbnic. After that we could switch fbnic
back to the inband setup with support for the higher speed interfaces.

One option I would be open to is to have me take on addressing the
issue in net-next instead of net since I would need to sort it out to
enable my patches anyway. I was mostly bringing it up as I was
concerned that I may have not been the only one impacted. I was using
the fixed-link/internal combination to basically signal to the phylink
interface that we were locked in and weren't going to change it, as
such the only impact for me is it seemed to result in a warning
message about the link configuration not being recognized and the
supported/advertised modes being empty.

