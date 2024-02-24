Return-Path: <netdev+bounces-74701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C96862455
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F2AB21B21
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F722301;
	Sat, 24 Feb 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOr/zzou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1B21A0A
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708771596; cv=none; b=bSlfZjAkEy6O/pRCkvFEh18k3wcymamkDpU2SCgHXP0F9YwU0HxWvVnsvhpbALdDRK57FELCVijjip7GEimCcVor6xBgmOorTlIpVDPBWoskdzJedZO2vjjEIkfinoxbcCCHhChQ2oIw0ngqjehP2I/GDVzZDIO2XCflbTcDpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708771596; c=relaxed/simple;
	bh=+nX1ieRQc6C8CjqAHP03bthsu+2ipreCRIob0/fetkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOn2EgHG20BMiNA4o/9PnPkBg0WjMZ0WtI4FkGJCtUIusT04uWBCkzH21nI4LO4rpdej/In8prmiKiKR8y/JTdWtXnu4uEakafmUuqveet25YRxqjUA0S6njMTiELq1778cngR1hiK667XXKx7cQxCqBdNiqmGOnvOZLK+afcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOr/zzou; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21f3a4ba205so667086fac.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 02:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708771594; x=1709376394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOiOh06BfiwgMCVRy5KSHc+P3SxlliXLSIhVlKW9SmQ=;
        b=HOr/zzouz/sgSrDdHIdbxGsYTXXKidk0FGZ31OvWD4bLGbWvGkj4YM3A30iOzWPY+F
         CEGFidcrjcdSSY3jpI548/nlT65VTbE6pWgu2RUs1WkA6n1KJYN6svni4kIVVN/2HuVe
         TP+sJyM+0Qd4usoxLO8Qyjp+rAQt2CpYIjpxQ5TKzbUucr0NqxHSHQIYb44P+X4FYo4M
         zGd9+iiFbnfbRh5kiwk/1OOm2Q8P7k8cme6GqHGYLjgLElUrk1ilE+ZVWPJOWHLQHpzz
         447WP37ldXpVfaIR0/cTb9F452zwlhyAtP9NdNM1aCNA8HFCG6qVxob8D+voh5X0r1oy
         Kphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708771594; x=1709376394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOiOh06BfiwgMCVRy5KSHc+P3SxlliXLSIhVlKW9SmQ=;
        b=QI8B83NpK2LtMgo7MHc27ZypmnfoT4Xe4yAHU2ycB+ypQpktjodlIlxdo3gzZlSQOF
         E8BLelTocwxVEYqhljlGKnFnputwvyzMzWdgqRLdIHlNv+oZjwbm9cLTh4uzkXF550/h
         wmnphYYQ7pYSiUI2vM7KTFgUHvoI3JSaUCE9kkrdB0m/FIlvOZBEZclJdufuxHFMg0st
         +d2u0w1Qen0ukPCY7iOfy/whYMXVbDN1DJeXndWmr7/J7fDDdcFOerO5E0r31edpXbMp
         u6Bvzcp34UH0l+vzsPraGfaAdR2dlz52gSW2qqMmQBjyY87n6VHFi+cjqonp7rOsiVtq
         Q6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB6OTyEtlXeAfHahx3mBVlTlD6rhUfFl9cWL+lLld7Vd+EfLWNuR9XPRVRwdjsUpTO/74UCXxZOpoC8N3st9aGg3wx9u57
X-Gm-Message-State: AOJu0Yx8ds8dcwH8j0W+saBi7O0IrKGcwaIZB30xSqeNldNCKWQiS3bZ
	NOZ/+Mc1TJUW1v9AQmawMF5RiLgEFJeB9H/fIWDSbjJdsjgyBhJILU06Ihv0L4OoK23c1FKK5B3
	pUMpn7DdwtyYvn13u4gC7FnNzwMk=
X-Google-Smtp-Source: AGHT+IEhpgWIU6Uh2SKd5drxetquxFpqEH79oKDQOrdPvf5p7Al5TXjMSajnk4lbFxQGp1mbNQhBpCIJpmLLEd0TbFI=
X-Received: by 2002:a05:6870:c186:b0:21e:b7cc:5728 with SMTP id
 h6-20020a056870c18600b0021eb7cc5728mr2647721oad.30.1708771594081; Sat, 24 Feb
 2024 02:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com> <20240222105021.1943116-2-edumazet@google.com>
 <m2wmqvqpex.fsf@gmail.com> <CANn89i+UXeRoG4yMF+xYVDDNv-j2iZYTwUogQWsHk_OiDwoukA@mail.gmail.com>
In-Reply-To: <CANn89i+UXeRoG4yMF+xYVDDNv-j2iZYTwUogQWsHk_OiDwoukA@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 24 Feb 2024 10:46:22 +0000
Message-ID: <CAD4GDZyV5H4RK_8H2CiUfEj_DSu=w12HqeCzy+2mmu3cMivGww@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 01/14] rtnetlink: prepare nla_put_iflink() to
 run under RCU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Feb 2024 at 08:21, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Feb 23, 2024 at 4:25=E2=80=AFPM Donald Hunter <donald.hunter@gmai=
l.com> wrote:
> >
> > I notice that several of the *_get_iflink() implementations are wrapped
> > with rcu_read_lock()/unlock() and many are not. Shouldn't this be done
> > consistently for all?
>
> I do not understand the question, could you give one example of what
> you saw so that I can comment ?

I did include a snippet of your patch showing ipoib_get_iflink() which
does not use rcu_read_lock() / unlock() and vxcan_get_iflink() which
does. Sorry if that wasn't clear. My concern is that I'd expect all
implementers of .ndo_get_iflink to need to be consistent, whether that
is with or without the calls. Does it just mean that individual
drivers are being overly cautious, or are protecting internal usage?

No use of rcu_read_lock() / unlock() here:

> index 7a5be705d71830d5bb3aa26a96a4463df03883a4..6f2a688fccbfb02ae7bdf3d55=
cca0e77fa9b56b4 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1272,10 +1272,10 @@ static int ipoib_get_iflink(const struct net_devi=
ce *dev)
>
>       /* parent interface */
>       if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags))
> -             return dev->ifindex;
> +             return READ_ONCE(dev->ifindex);
>
>       /* child/vlan interface */
> -     return priv->parent->ifindex;
> +     return READ_ONCE(priv->parent->ifindex);
>  }

And use of them here:

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 98c669ad5141479b509ee924ddba3da6bca554cd..f7fabba707ea640cab8863e63=
bb19294e333ba2c 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -119,7 +119,7 @@ static int vxcan_get_iflink(const struct net_device *=
dev)
>
>       rcu_read_lock();
>       peer =3D rcu_dereference(priv->peer);
> -     iflink =3D peer ? peer->ifindex : 0;
> +     iflink =3D peer ? READ_ONCE(peer->ifindex) : 0;
>       rcu_read_unlock();
>
>       return iflink;


> We do not need an rcu_read_lock() only to fetch dev->ifindex, if this
> is what concerns you.

In which case, it seems that no .ndo_get_iflink implementations should
need the rcu_read_* calls?

