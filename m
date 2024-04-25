Return-Path: <netdev+bounces-91452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B48B29F9
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D8B1C20A14
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2D5B697;
	Thu, 25 Apr 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSJgOOLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32E6BFBC
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077354; cv=none; b=qbJxBtbtq9DYM6oS1q+/tgq2ku9yuFfY73WmgJRhyjAxNMJVpW3H0H2v6VUzCKRUJ6VxoMEoo3kOVglsxZ4d+rzwkYpJiobhep9T+JzM5c3vXSl7o3yQJkepJ6xGw5R5Yu/dXDylHS40WXbGso5k80I/JoCy4QnbHtw+i0zPff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077354; c=relaxed/simple;
	bh=pouMjJyt+QNlCKqX/KnbSgBr3kK1CB3YCtBLK3D4fHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO8Rpn/0YY/vlNQvtxnH96yo2yJ4nNHWi2emBYIF2jybl/fgNfHKVA8PgyZmbBVean0hxTAVpzrLyM9Yimx/L/d+2H06Il6MwrU2MB6+hqruC2hc3qVSrp7WIscuml0TYaKwtQBwIp9a/eId8asMZSBlR0jdV+MY42K4Tl0L/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSJgOOLC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so4053a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714077351; x=1714682151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV5zqE16mi1eU3okesZU+zUjFNTAbDUZrH643aBLWXY=;
        b=RSJgOOLCXp5Zseb4K5tnx8NTz1Um2ua24pvLJR2rfdg8xLEJzVR00XGwrmX5JW3/MP
         6ET/XpY9y2avUH1E6N0fQHc+odai+t0uNvuWWC04uOWDfzMm8E/2nzDuMwx26fupqqz9
         u5dI0Jwa66Ip0K34CuCtknLMWZ4hapN2lgTsmwHoSvJ5HmfyDNxH23UO+7BGSwl6jeQN
         L0ChGf0rnGl/rbmjfe9jhPbwkBVi9eVDe39c1Q2BJUnIMbXghhFze+0MBAu4negZQk/G
         IbmLkgTGpsfIw0om6MQnZhlRhjegiakqR7/9q9vmITbwxLleh81Z1Mb1azaA3oVmn2U9
         WV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077351; x=1714682151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV5zqE16mi1eU3okesZU+zUjFNTAbDUZrH643aBLWXY=;
        b=YTf2iIhTzx3uWzk6qnG4sa7tJvW+4XGoZZbEzvH7SgJ1O8V9+GPOSofwJeUaK+lmbw
         HjdIBkQqj1d4mDodbJJliQsVXMrx9YbkM0rUkTgK6zs+CsjDx7dHXP2Qo1TEjgKRAbHo
         FM6L3OEigw5vO1YDTWII5s3mcAeIS6/PeJJUJJw43FkwJvRdaBItS5+wiZN2zLBfHB+L
         NpL0swzpeaUQPRku2wJpAeHhv6er90SYSYmXTvXYTbQV+Ye7la6oK5gwRdNaxLsRTH4L
         ddhQOYBSyQpfEfuTKeTfTXAVr5zp867zGUlORP7kXwn+icEIqdZEXXNzTn7yAlcGBnDX
         bAXA==
X-Forwarded-Encrypted: i=1; AJvYcCXq9J0LvsxIWBp8XBTnl6njiLh/NZEZH6MbIMsxcxksNlfxcEjcTOJ65RBptWPY5hueQe/zNQPBDwcputTP5f4k/Suox/gy
X-Gm-Message-State: AOJu0YwgBNlIBxAHsQFAkoUUcN3kD8C+U2BSBPN2A81qH3w4/LjG5sCZ
	vlo8xMaQ1XlwJSLhsqC939y7pJQwfXL1zTOitB43M+c6+ap2Aj8Vnkrwdd38oe40EfQmOHVc7OW
	q507y5lxXo2RA77rNExzGuC4gZgfM7HS99Yof
X-Google-Smtp-Source: AGHT+IF+FAlJRy0Xe9vH5WAvaNDiVbM0cZgAG34n0rTv9K+r+t5mubf3h2ZkXxq7k7wvYc3wfVisj/nWwXSZz+mEQWg=
X-Received: by 2002:a05:6402:313b:b0:572:469c:3c91 with SMTP id
 dd27-20020a056402313b00b00572469c3c91mr13527edb.6.1714077351158; Thu, 25 Apr
 2024 13:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJEWs7AYSJqGCUABeVqOCTkErponfZdT5kV-iD=-SajnQ@mail.gmail.com>
 <20240425175146.73458-1-kuniyu@amazon.com>
In-Reply-To: <20240425175146.73458-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 22:35:38 +0200
Message-ID: <CANn89iJGJQeYiUYX9a_tPB00fCibuOED_mbxZwcJAQLbMYiy8w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/6] arp: Convert ioctl(SIOCGARP) to RCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:52=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 25 Apr 2024 19:12:56 +0200
> > On Thu, Apr 25, 2024 at 7:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > ioctl(SIOCGARP) holds rtnl_lock() for __dev_get_by_name() and
> > > later calls neigh_lookup(), which calls rcu_read_lock().
> > >
> > > Let's replace __dev_get_by_name() with dev_get_by_name_rcu() to
> > > avoid locking rtnl_lock().
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/ipv4/arp.c | 26 +++++++++++++++++---------
> > >  1 file changed, 17 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> > > index 5034920be85a..9430b64558cd 100644
> > > --- a/net/ipv4/arp.c
> > > +++ b/net/ipv4/arp.c
> > > @@ -1003,11 +1003,15 @@ static int arp_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> > >   *     User level interface (ioctl)
> > >   */
> > >
> > > -static struct net_device *arp_req_dev_by_name(struct net *net, struc=
t arpreq *r)
> > > +static struct net_device *arp_req_dev_by_name(struct net *net, struc=
t arpreq *r,
> > > +                                             bool getarp)
> > >  {
> > >         struct net_device *dev;
> > >
> > > -       dev =3D __dev_get_by_name(net, r->arp_dev);
> > > +       if (getarp)
> > > +               dev =3D dev_get_by_name_rcu(net, r->arp_dev);
> > > +       else
> > > +               dev =3D __dev_get_by_name(net, r->arp_dev);
> > >         if (!dev)
> > >                 return ERR_PTR(-ENODEV);
> > >
> > > @@ -1028,7 +1032,7 @@ static struct net_device *arp_req_dev(struct ne=
t *net, struct arpreq *r)
> > >         __be32 ip;
> > >
> > >         if (r->arp_dev[0])
> > > -               return arp_req_dev_by_name(net, r);
> > > +               return arp_req_dev_by_name(net, r, false);
> > >
> > >         if (r->arp_flags & ATF_PUBL)
> > >                 return NULL;
> > > @@ -1166,7 +1170,7 @@ static int arp_req_get(struct net *net, struct =
arpreq *r)
> > >         if (!r->arp_dev[0])
> > >                 return -ENODEV;
> > >
> > > -       dev =3D arp_req_dev_by_name(net, r);
> > > +       dev =3D arp_req_dev_by_name(net, r, true);
> > >         if (IS_ERR(dev))
> > >                 return PTR_ERR(dev);
> > >
> > > @@ -1287,23 +1291,27 @@ int arp_ioctl(struct net *net, unsigned int c=
md, void __user *arg)
> > >         else if (*netmask && *netmask !=3D htonl(0xFFFFFFFFUL))
> > >                 return -EINVAL;
> > >
> > > -       rtnl_lock();
> > > -
> > >         switch (cmd) {
> > >         case SIOCDARP:
> > > +               rtnl_lock();
> > >                 err =3D arp_req_delete(net, &r);
> > > +               rtnl_unlock();
> > >                 break;
> > >         case SIOCSARP:
> > > +               rtnl_lock();
> > >                 err =3D arp_req_set(net, &r);
> > > +               rtnl_unlock();
> > >                 break;
> > >         case SIOCGARP:
> > > +               rcu_read_lock();
> > >                 err =3D arp_req_get(net, &r);
> > > +               rcu_read_unlock();
> >
> >
> > Note that arp_req_get() uses :
> >
> > strscpy(r->arp_dev, dev->name, sizeof(r->arp_dev));
> >
> > This currently depends on RTNL or devnet_rename_sem
>
> Ah, I missed this point, thanks for catching!
>
>
> >
> > Perhaps we should add a helper and use a seqlock to safely copy
> > dev->name into a temporary variable.
>
> So it's preferable to add seqlock around memcpy() in dev_change_name()
> and use a helper in arp_req_get() rather than adding devnet_rename_sem
> locking around memcpy() in arp_req_get() ?

Under rcu_read_lock(), we can not sleep.

devnet_rename_sem is a semaphore... down_read() might sleep.

So if you plan using current netdev_get_name(), you must call it
outside of rcu_read_lock() section.

