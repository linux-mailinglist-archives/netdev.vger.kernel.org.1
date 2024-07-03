Return-Path: <netdev+bounces-108963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F094926624
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E9F1C22825
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B91822D8;
	Wed,  3 Jul 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w02YCLA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53417B42A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024225; cv=none; b=V3QWAfkZuWCvR9PPxswh6Sd3n61EMaR+1sBPflm4bLHb51TssQE3STfl2y7IxUwAPohzD6N/v9UpqrBkM8YGEzYtvt12dIqMHU2OOLyim0NxQzuAPVstK0IOBUnH3bdA8SfLsepiP5Y//GQ/m+7tWfOCkcbZ59hqKKeoLly5GQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024225; c=relaxed/simple;
	bh=d0NAZPug++84yb4AClA5Oi57MC5MzzyJOItoVtUB+f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3hkQjQJCfBIGYk0Vse/rMDiJQFATAIuS5F/SieZdQnPP2khrsx9FLVwl5rtKXtfOxT/aOcVTvHABquAbn9ynCBgiYdkLELHw0FAQUewOShkRBrrU5Z9oFn+pJbYn1DXRWOQMiVJU8cPF97BEoKsk1cl496EnT6TLHafvySdlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w02YCLA2; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so176215ab.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720024222; x=1720629022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2QmZejWA+lzJtqe0C34oQ5/ww4Ua8unvP+2Hn+v+eA=;
        b=w02YCLA2fIWbQqRFLC/GgONfKrAwApTpQWM6uz15kVgKz6v9QzsM6TDKE7C/4Rhgfd
         J7nzyv2eEsGAb5JoljsKjd7fFflaaEj/3P/GtChE8bGORvYr1U4ZBqKfLiQa55K55Eqj
         oDoZey7pmzllBJXRo37fCkEsKNz90oMGLV2I9Apz2jCws7JRCFtJzsxF/haCO0bjygYR
         okYSb7H1wo1KMcUmWPBybPCadt+KSeXFJVqLPoC8X9XCz1Eji83shBbFQVyxyJtN7V4Q
         HlS1Wd00eoX45jLnSjSs8W1nfM8TpDzQjgckNjiwbnI4VHtAgQ71PXo9Z1Imw1IS/vWG
         OuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024222; x=1720629022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2QmZejWA+lzJtqe0C34oQ5/ww4Ua8unvP+2Hn+v+eA=;
        b=VNtMFBaZe1qbu4oUG+hG5LOt9ePJ38NU9cfuDA2KngRqH5+pOLzybdXfW/poMsYbwM
         WxyxY6hc4PhIB3PGu5wvrGYXs11hrdBJ9O+yjQ+r2xTaLxbB63YVAZkJgIfclnx2gQmI
         yMD9mEoc3pjqt6eJ+AYKfWIy+H0veuMCCGuguQyUh9+qjWzbVRJaqqSrOTjyCO1kN5VE
         lQIo3BvtZZT1nCqezspj2TO9zXukvvsWcXG5WZ5/zUs1XOD8hwdrW3Hr4sVUUHCmFwXQ
         16hXsFHqZ5jLRuAhky04rXr9jG3jtW7jVuUzX+L/fC0InRkuiJux8o7BkE55NocMu4A4
         rlOA==
X-Forwarded-Encrypted: i=1; AJvYcCVbQHPGcx2bKbDS/YR1re3SSkZWjgBpoiOLdbP8U+mkk25U2nUxW+oerEXhIu3cDEDA8bGx9O4vgznUaMuFM26Kate09Eqk
X-Gm-Message-State: AOJu0YxCCdgCg/xER8XoBZpyhxnBZQoAn9jfq65JwiHMmhQns1K5YLtv
	BfizTmOOBDRlcmyd95xh/X6Hdjh7CYkLckgb31grNhv2tA7mp3wFO8/rXGDokLfAJVLN+FgIxlk
	N29xPvwOjdTKTHsoRaGtoOl1TFfE97wZ0Z631
X-Google-Smtp-Source: AGHT+IG6hY5y4NoTYor41L2x0GP2NyHLBmVuFfxMPssEry84/PqOf7ZeBqMct8kfno+pOkP7LjodSM/1XSZqM1fcVf0=
X-Received: by 2002:a05:6e02:152c:b0:376:48d1:1764 with SMTP id
 e9e14a558f8ab-3820cbf3e21mr3107115ab.17.1720024221710; Wed, 03 Jul 2024
 09:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZoVrzGBouwEQU3Bu@localhost.localdomain> <20240703160210.83667-1-aha310510@gmail.com>
In-Reply-To: <20240703160210.83667-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jul 2024 18:30:05 +0200
Message-ID: <CANn89iKbP4r+uAkHiz8_pdMB9XWoyRWR0NJ7ZuNCOr+LiFr9zg@mail.gmail.com>
Subject: Re: [PATCH net] team: Fix ABBA deadlock caused by race in team_del_slave
To: Jeongjun Park <aha310510@gmail.com>
Cc: michal.kubiak@intel.com, davem@davemloft.net, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 6:02=E2=80=AFPM Jeongjun Park <aha310510@gmail.com> =
wrote:
>
> >
> > On Wed, Jul 03, 2024 at 11:51:59PM +0900, Jeongjun Park wrote:
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(&rdev->wiphy.mtx);
> > >                                lock(team->team_lock_key#4);
> > >                                lock(&rdev->wiphy.mtx);
> > >   lock(team->team_lock_key#4);
> > >
> > > Deadlock occurs due to the above scenario. Therefore,
> > > modify the code as shown in the patch below to prevent deadlock.
> > >
> > > Regards,
> > > Jeongjun Park.
> >
> > The commit message should contain the patch description only (without
> > salutations, etc.).
> >
> > >
> > > Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspot=
mail.com
> > > Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  drivers/net/team/team_core.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_cor=
e.c
> > > index ab1935a4aa2c..3ac82df876b0 100644
> > > --- a/drivers/net/team/team_core.c
> > > +++ b/drivers/net/team/team_core.c
> > > @@ -1970,11 +1970,12 @@ static int team_add_slave(struct net_device *=
dev, struct net_device *port_dev,
> > >                           struct netlink_ext_ack *extack)
> > >  {
> > >         struct team *team =3D netdev_priv(dev);
> > > -       int err;
> > > +       int err, locked;
> > >
> > > -       mutex_lock(&team->lock);
> > > +       locked =3D mutex_trylock(&team->lock);
> > >         err =3D team_port_add(team, port_dev, extack);
> > > -       mutex_unlock(&team->lock);
> > > +       if (locked)
> > > +               mutex_unlock(&team->lock);
> >
> > This is not correct usage of 'mutex_trylock()' API. In such a case you
> > could as well remove the lock completely from that part of code.
> > If "mutex_trylock()" returns false it means the mutex cannot be taken
> > (because it was already taken by other thread), so you should not modif=
y
> > the resources that were expected to be protected by the mutex.
> > In other words, there is a risk of modifying resources using
> > "team_port_add()" by several threads at a time.
> >
> > >
> > >         if (!err)
> > >                 netdev_change_features(dev);
> > > @@ -1985,11 +1986,12 @@ static int team_add_slave(struct net_device *=
dev, struct net_device *port_dev,
> > >  static int team_del_slave(struct net_device *dev, struct net_device =
*port_dev)
> > >  {
> > >         struct team *team =3D netdev_priv(dev);
> > > -       int err;
> > > +       int err, locked;
> > >
> > > -       mutex_lock(&team->lock);
> > > +       locked =3D mutex_trylock(&team->lock);
> > >         err =3D team_port_del(team, port_dev);
> > > -       mutex_unlock(&team->lock);
> > > +       if (locked)
> > > +               mutex_unlock(&team->lock);
> >
> > The same story as in case of "team_add_slave()".
> >
> > >
> > >         if (err)
> > >                 return err;
> > > --
> > >
> >
> > The patch does not seem to be a correct solution to remove a deadlock.
> > Most probably a synchronization design needs an inspection.
> > If you really want to use "mutex_trylock()" API, please consider severa=
l
> > attempts of taking the mutex, but never modify the protected resources =
when
> > the mutex is not taken successfully.
> >
>
> Thanks for your comment. I rewrote the patch based on those comments.
> This time, we modified it to return an error so that resources are not
> modified when a race situation occurs. We would appreciate your
> feedback on what this patch would be like.
>
> > Thanks,
> > Michal
> >
> >
>
> Regards,
> Jeongjun Park
>
> ---
>  drivers/net/team/team_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index ab1935a4aa2c..43d7c73b25aa 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1972,7 +1972,8 @@ static int team_add_slave(struct net_device *dev, s=
truct net_device *port_dev,
>         struct team *team =3D netdev_priv(dev);
>         int err;
>
> -       mutex_lock(&team->lock);
> +       if (!mutex_trylock(&team->lock))
> +               return -EBUSY;
>         err =3D team_port_add(team, port_dev, extack);
>         mutex_unlock(&team->lock);
>
> @@ -1987,7 +1988,8 @@ static int team_del_slave(struct net_device *dev, s=
truct net_device *port_dev)
>         struct team *team =3D netdev_priv(dev);
>         int err;
>
> -       mutex_lock(&team->lock);
> +       if (!mutex_trylock(&team->lock))
> +               return -EBUSY;
>         err =3D team_port_del(team, port_dev);
>         mutex_unlock(&team->lock);
>
> --

Failing team_del_slave() is not an option. It will add various issues.

