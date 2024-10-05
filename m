Return-Path: <netdev+bounces-132322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8E991369
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC48281DB9
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751FF7F6;
	Sat,  5 Oct 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgAndE0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DD182;
	Sat,  5 Oct 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087016; cv=none; b=Ucn7rOBZQRPDRoGPCKDadARpaO0YYD41rF4hlImoCYgXdoxF3N8VWTQoAiXqqaJ0CWPzeFNz09IeJJBikb7Kcc5MnlJY/VZX+aKpziNvMnpvPj9iVT6ZM2IYcGfCloxOsQ2o/uSkpLqLmQZXs6TOpoWkgjvNmKOUiXxHzPFozyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087016; c=relaxed/simple;
	bh=Oysw3GmSjkXliwqin77coeu5Qk3hCFPcA5qwfGC571s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXe4oqBoN7ZM2IwYqhyKlj+gP0vlsXBkj/EmAZGG2iOLBiT7fafVd6nVSogpAjWYeU6tTjOSQZmUFYRuX/ptJRxaM0vVeSc/e7ClJFPl3mg43b0PXK417gM/G/f/lRI+nNgLZm1J62uFWS8QWkqrC5ghjfcdw8AJyzlZZHFHX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgAndE0s; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e29c50ccbaso24794637b3.2;
        Fri, 04 Oct 2024 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728087014; x=1728691814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm/s3gxkoXKwNy8dfoUH0qEU6KVqpLJ4tNBszctqB7c=;
        b=KgAndE0sS9L2qqG2js7lSzMROt9TaO0tNouJWJQ4c02VXaasQ6tmPpaqZ8VYoTqfbW
         R+t9Jgorf4Hi3idDfy0cdozq+wAUvIXAKRc7ckWXXJ2c3lHGaaxVCrh+E9JIFKZ3zLfb
         px9E/Exkz24XhToUFKOqZVVhgOPGBtIVELqvtjjqcRiLhPqKSbZO+0y1unCERJA3TwuK
         6NXIRLf8+VLpzeVgq6ZVjU0cMNE0hlbf7hpat0BfOWCe1eRNjAzKYGfuFvJek5dXgmrY
         hYKWS79obTrPVwpV5UBSm/aaSQIaUPCAyO2aamQszZeYMlV1205LebOgCLSXDoHBanEW
         gz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728087014; x=1728691814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm/s3gxkoXKwNy8dfoUH0qEU6KVqpLJ4tNBszctqB7c=;
        b=mn+XKdlH0bCrBmpEUYhDr+TrfUFUs2CBukbHXCOq6rF6dK+rY4tMPzukrHdtvO7RJW
         n+8jysYi0giXezyAeGjK3dCN2RsD7RVb6RzKcuLCKYBnWjexiTDEXQdhUbVOgTqnEZu2
         aGv/A9vo9IpNu4rr1wHG/owEYmoPdWy16rKljet4LjnnASQDRolYtNw0mC4RpeaeZDRo
         /opPjvVvUS1rcY0fk33boYFBz4w7wsZlUzjlleZuFytl3ouZCSf8ENJlhBMi7PK8dTDN
         FQg9XOmD/hB0LjUMNxvAxYWClTLm93843KB2gaDe2fsx8mTQoh56NyTPIz+w7bRGI8yQ
         yeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcp4BJhuDv8LYkyNu4l19qw/e0Euuu0u8PWqdLv8IocarecfPOL26rhe5st8yZevrDgSU6TrwZi9Mda+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiPYneC+aPOY/Rt7P7TdRCDTfWe5J2SDOKjsvEbyqcWWV/2UD
	ifhKeF9nyNEJolOVqwSgQFSyBHa1QVsD0vaXC4z1ibF4auW/KlDSHG3mgtiKwFEdl3Ud1KP5V30
	TwBkqfvf4jHYz1/bLiXPS+bpyP/I=
X-Google-Smtp-Source: AGHT+IH2GjzGfx+GBi1ipTVYrpLH6UYzc9FzIVcbPgsCTJwGem434ZRPPptXsE4vsyyWByosX8s6hi9WVuuoztdp1qE=
X-Received: by 2002:a05:690c:dcc:b0:6e2:636:d9ee with SMTP id
 00721157ae682-6e2c724118emr49131117b3.9.1728087014016; Fri, 04 Oct 2024
 17:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003021135.1952928-1-rosenp@gmail.com> <20241003021135.1952928-4-rosenp@gmail.com>
 <20241004163213.2d275995@kernel.org>
In-Reply-To: <20241004163213.2d275995@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 4 Oct 2024 17:10:03 -0700
Message-ID: <CAKxU2N9sFq-4fBVkePERTjKGCNOK3KsfziwShzHqtbszXH8omg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/17] net: ibm: emac: use module_platform_driver
 for modules
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Oct 2024 19:11:21 -0700 Rosen Penev wrote:
> > These init and exit functions don't do anything special. Just macro it
> > away.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/mal.c   | 10 +---------
> >  drivers/net/ethernet/ibm/emac/rgmii.c | 10 +---------
> >  drivers/net/ethernet/ibm/emac/tah.c   | 10 +---------
> >  drivers/net/ethernet/ibm/emac/zmii.c  | 10 +---------
> >  4 files changed, 4 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet=
/ibm/emac/mal.c
> > index d92dd9c83031..a632d3a207d3 100644
> > --- a/drivers/net/ethernet/ibm/emac/mal.c
> > +++ b/drivers/net/ethernet/ibm/emac/mal.c
> > @@ -779,12 +779,4 @@ static struct platform_driver mal_of_driver =3D {
> >       .remove_new =3D mal_remove,
> >  };
> >
> > -int __init mal_init(void)
> > -{
> > -     return platform_driver_register(&mal_of_driver);
> > -}
> > -
> > -void mal_exit(void)
> > -{
> > -     platform_driver_unregister(&mal_of_driver);
> > -}
> > +module_platform_driver(mal_of_driver);
>
> This is not 1:1, right? We're now implicitly adding module_init()
> module_exit() annotations which weren't there before. Needs to be
> at least mentioned in the commit msg.
Sure. The prior commit removes direct usage by core.c of these functions.

