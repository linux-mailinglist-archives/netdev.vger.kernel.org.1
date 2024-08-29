Return-Path: <netdev+bounces-123423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DE964D2C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48411F22585
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B61B652E;
	Thu, 29 Aug 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBmrQgFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE34D8C1;
	Thu, 29 Aug 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953606; cv=none; b=OnIGbLBY3sevng+A6xEYtflWfzTZdvrbde4cNTGf/XFImqSDmzmT0i9e60pvZfengV6C9C0YmZq8sDHzH0OPVtGWUYudABqaucRKGcNH2AFe7HvhPkOJgH6TaEvYdrHyoncYbWuoGtxDetCM6SwIQOQTV5+9gsCmGHizNzcNyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953606; c=relaxed/simple;
	bh=ZMBy5eAWVQgtRSJGMBG/W2K5iiRKUnOw/zCQQXcVzsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP1EbMSJMTTjhx6/ZsT+a4viD79oCboe4wMDTA+QH5CT42nsnnqzRP/wlyLEWcxffYvrAW2CnSXt2B1U2rcPLHUZzZz2XEcIVoEoklWVZixJi9/iz0nMowfHt9KxvTe/LyTyqw69VnwOULqKMukvulGQPn6Ad6O3OurlTjnP4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBmrQgFf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b47ff8a59aso8886977b3.2;
        Thu, 29 Aug 2024 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724953604; x=1725558404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGO/t8uRBuQfP2zrjVa2XCS1Wb1wQnZ1r+LJpc9VPdc=;
        b=jBmrQgFfzRSKx7tvpyZ/2Na1wgLjqfbjGY8JeSmFcKDOyidAtijs4yiAZhpwKayuOB
         c36kWfV1fU3DYsKpL7I+oZKamKyZUfpCyM142Kz6rVc/9sVdpsUEGJVlt2UFY5AgDhyC
         O7FfDdU4MMw6JGIu2AivEz3JdlM+NzjMwdkpunVI1N3a4JVyVm9X1A9wQv0NTV6AO+kC
         tiPML9Vu7fs9Yq5kASJbFQwxA84aC8CxldgbAAcwob0FxCeid8xNA0jHhx/vjFtHyIJX
         h41Amd3tejkBCg7YjYgZfWkECBlakRQI1NsaCaHmn6ZoN4tzBNjxdk1lUmi9xaH0nXp5
         bGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724953604; x=1725558404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGO/t8uRBuQfP2zrjVa2XCS1Wb1wQnZ1r+LJpc9VPdc=;
        b=qalxaGtSsylICLKVQ01U0XvIaK3RQSH/l23APqG2/AeB4dJQApIekE7hZUG3q9kQrS
         O0CtAox4HiEhUTXUgQU9YSowCdWLaaOUOs6GNzcEhjv0W0pNQJ/sNHmKU0n2/xd+uPK3
         WfGa/pcVlYCBD75HnkQs6fbSoH70QI8MYmqURDJM6J0izSlDdLTMDu19CrCzPBZaPPxj
         jGt58ZnrgMhwnQGsdgXXIzqx1RtlEuWmbLcJQYss3KFzEAtg6xtnSulAApENc7PWC6UQ
         eD0iLEWBhZEbV4kttathbSroQzNDXrebdatBh1/QmobAnnb3I0iRqE40SxXHe1LpkJ2v
         BP2w==
X-Forwarded-Encrypted: i=1; AJvYcCXv+WX6y6R+utEbaFbHcs+QZDNxho7FTkUHMA8T+SY1upzrBIjtN070+0rWPuAN5GPd+zHxQecwOAo2bEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXyvENw1+mB5x3P1BbFQ3phO5kzmYNq3or/g9DkOQTXTO+ngv
	mZbWhu+s0h5ANPRw7oIvcVsfqmLk4JLbGltL46HI/kJAazJqeMZRDnHeddG6wWXHM3ODdj4PGT7
	cqq0OD6bWUYTOfukNAXv+iiulkuE=
X-Google-Smtp-Source: AGHT+IF/uLElLdnKtZT4of9DxbtwDzdB24Ok4hY8XDtGl79o2KGVVFZdFItH72gPaypIGX/poSIgL+WYa1qM3RJn7IM=
X-Received: by 2002:a05:690c:6608:b0:6b3:a6ff:769b with SMTP id
 00721157ae682-6d272708f30mr43782317b3.0.1724953604023; Thu, 29 Aug 2024
 10:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828204135.6543-1-rosenp@gmail.com> <cabb111b-37b4-493c-ad6c-c237c7091bf6@intel.com>
In-Reply-To: <cabb111b-37b4-493c-ad6c-c237c7091bf6@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 29 Aug 2024 10:46:33 -0700
Message-ID: <CAKxU2N_fHp1oWxau3VG7dFK+sdwqDUkzYvFbfjBCdg_VvobrVQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ag71xx: disable napi interrupts during probe
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:05=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 8/28/2024 1:41 PM, Rosen Penev wrote:
> > From: Sven Eckelmann <sven@narfation.org>
> >
> > ag71xx_probe is registering ag71xx_interrupt as handler for gmac0/gmac1
> > interrupts. The handler is trying to use napi_schedule to handle the
> > processing of packets. But the netif_napi_add for this device is
> > called a lot later in ag71xx_probe.
> >
> > It can therefore happen that a still running gmac0/gmac1 is triggering =
the
> > interrupt handler with a bit from AG71XX_INT_POLL set in
> > AG71XX_REG_INT_STATUS. The handler will then call napi_schedule and the
> > napi code will crash the system because the ag->napi is not yet
> > initialized.
> >
> > The gmcc0/gmac1 must be brought in a state in which it doesn't signal a
> > AG71XX_INT_POLL related status bits as interrupt before registering the
> > interrupt handler. ag71xx_hw_start will take care of re-initializing th=
e
> > AG71XX_REG_INT_ENABLE.
> >
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> The description reads like a bug fix, so I would expect this to be
> targeted to net and have a Fixes tag indicating what commit introduced
> the issue, maybe:
>
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
>
> The change seems reasonable to me otherwise.
OTOH there are currently no dual GMAC users upstream. Just single.

>
> >  drivers/net/ethernet/atheros/ag71xx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethern=
et/atheros/ag71xx.c
> > index 0674a042e8d3..435c4b19acdd 100644
> > --- a/drivers/net/ethernet/atheros/ag71xx.c
> > +++ b/drivers/net/ethernet/atheros/ag71xx.c
> > @@ -1855,6 +1855,12 @@ static int ag71xx_probe(struct platform_device *=
pdev)
> >       if (!ag->mac_base)
> >               return -ENOMEM;
> >
> > +     /* ensure that HW is in manual polling mode before interrupts are
> > +      * activated. Otherwise ag71xx_interrupt might call napi_schedule
> > +      * before it is initialized by netif_napi_add.
> > +      */
> > +     ag71xx_int_disable(ag, AG71XX_INT_POLL);
> > +
> >       ndev->irq =3D platform_get_irq(pdev, 0);
> >       err =3D devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
> >                              0x0, dev_name(&pdev->dev), ndev);

