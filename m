Return-Path: <netdev+bounces-243582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88732CA41AD
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7A53054CA9
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331324A066;
	Thu,  4 Dec 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/+H3j1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3B244670
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859642; cv=none; b=DhyK2SD1iINeaWUp5C31WeN6fIv0I7F/siVFK0Xm1L3l6Skaibbg9g9Zi/nbUkvGXVhbo7auqSXqPrFoERuI5Ba/UOsFTtN0B86b0vIu4eNGphT+TwH0qFg7TUJ16oeo3HPsTw8jUG5n/g7UR4GZjG3gzOugDPhRLzvwf5Fl4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859642; c=relaxed/simple;
	bh=JybPa22hequCHTzViYDdJ5mRKFAS7J+Wa2Wx6wxTYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbl4HBYy4QIdGdX2eKXf6/kwc8MzbpIb0qxfMi1kNO8wO3nAki6GDjNh7ARTxb3Pt7M6n/nHCD+wa7Zt2W3ioz/rMY6k9KJCPs3ZQHDYoY3o2P8eIs6L3k8bOJ+2iuXRvmL7I65W6+6is4Umr+bOx97r/5gPWl9D/i4bs2NOZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/+H3j1o; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f02dd964feso1067141cf.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 06:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764859639; x=1765464439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4901MAAOHDIAw8i2f787vuIzK36N58iA+QYan6LdnOU=;
        b=h/+H3j1oZ4E41kgRvklyaWYFUZDMnMJovElocaD9GlH1TvlQB1wcqSTcnCiVzdHxZC
         CJkJf0KeCDTK+sn2kKQvtmkilkogrmxWrV4RIyod83LIwTmYOMFZt7zwdT0AzbAMptMF
         ujtBuUXtPfILuWjHNHxITB8vCVP326BIabsxKNpdj3gYU/sMelnjP2D/N00V2uAgscIf
         oC4M3sCdOGc8TYrTc0ob7CGWX1mw2MeCEy8AV+0542CsPAlcfnPwHHxi5+SRjkSevRrW
         tZPYBn9fQ3p3TDrJ8rvYXwY+zAU/QLXkgsC3NuOwbh40yxGwkOWBCPULSgD9U7BRet+v
         xtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764859639; x=1765464439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4901MAAOHDIAw8i2f787vuIzK36N58iA+QYan6LdnOU=;
        b=iBhgLiEexw1hl9uvhEcB00j6if1S59d/8ZRcsdXm2LaYwxbSwMAXQN+R/EWuM6j2cl
         81kKJfC6JTMCTmxl9bBOdhdl6N/r1lt/KUdIA19tpdo8cSnbv7CxqUo9/G3/LJgHBtDq
         urBqgFW5CVWURS73C/UROQAETNggsUeXnwRR2UMTk9OMCLMar6JksMGxDG/qKw4C9V+4
         +ZJ/gle+npeku9QIbZUbOYstI7SoClfEcIUAZ7+u17dSXh56il/xLAvnXSF+f6QgUKjI
         GVSV350jtZ6uOrC+SuVSz1Nu9FffMW9kEsaGGIhA/Bavrl76LdKZ4siCf0yh3qPQknie
         zugQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlnMVyixbeacU3gDWNLUquV8Bp7lR8unfTen5bk2GOIeiMgicLbP+qbmVM0+XN64m3Z8hA50Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wkKCKq9LluKpV8nvEARXacaa4PA1EHoDeGPon4Fhk3PLRIuP
	CBYbnDD4ijIttC49i7v+3XtghnrfSLVsSRxyJW+KXy9rh5U0x4DeoWKI84m5AyNZ1nvcBY5MKLx
	l5vFDU5FvdKxNg8O+R16HiKJkDJWcIFFpcVDmTWSm
X-Gm-Gg: ASbGncuBDedR9U0tcXDjWoVTImCyColuTAdGTnCYysolG3LHmdQoQg/9ljYdW5+MBbc
	xt2bQGK1MCBeoTL8anTzpTxwHmGuvS2+rxaSrrQQwp66D/EGabLE17HcB+Lq+OAcyuFjJ5k8dJB
	D4F3y52NxXMERuBmQpZw2xCZRPa4r6+XtQjucP74hsHU1W9J50r5ZJfrQ+oLLOvu71N4gcdzNTV
	6OYVq2uB6lU/LvW7CIcH5djJIEoJX9WEzs1ASUUw+b1ibVnl8/koVmtbqZhWws7mXxVww2m/Bln
	wWvo
X-Google-Smtp-Source: AGHT+IEWOLIdfyq8kGrctzf2FRiR4+REsQ2rNEGJbECWsjCVrj2eMxqdIkvTVGNLdVvcmB5rzeoZ6tQLUOWB512ZlTg=
X-Received: by 2002:ac8:5dd1:0:b0:4ee:1e5a:5422 with SMTP id
 d75a77b69052e-4f0239cebd4mr39501651cf.10.1764859638935; Thu, 04 Dec 2025
 06:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
 <20251202141149.4144248-3-skorodumov.dmitry@huawei.com> <3029c00c-4df4-4389-a031-76d4793a426a@redhat.com>
In-Reply-To: <3029c00c-4df4-4389-a031-76d4793a426a@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Dec 2025 06:47:07 -0800
X-Gm-Features: AWmQ_bkm3_6bMXakiv_ey1vSxsSH-6nv696eE2lr0sFq93GXhfFtZ4g4h-KmHpU
Message-ID: <CANn89iLhfSGG_JOcpw8ovs6xzaaD8=xGpCFkjuAJ4rT1maZdXg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ipvlan: Take addr_lock in ipvlan_open()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xiao Liang <shaw.leon@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Etienne Champetier <champetier.etienne@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 6:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 12/2/25 3:11 PM, Dmitry Skorodumov wrote:
> > diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvl=
an_main.c
> > index c390f4241621..53d311af2f44 100644
> > --- a/drivers/net/ipvlan/ipvlan_main.c
> > +++ b/drivers/net/ipvlan/ipvlan_main.c
> > @@ -182,18 +182,18 @@ static void ipvlan_uninit(struct net_device *dev)
> >  static int ipvlan_open(struct net_device *dev)
> >  {
> >       struct ipvl_dev *ipvlan =3D netdev_priv(dev);
> > +     struct ipvl_port *port =3D ipvlan->port;
> >       struct ipvl_addr *addr;
> >
> > -     if (ipvlan->port->mode =3D=3D IPVLAN_MODE_L3 ||
> > -         ipvlan->port->mode =3D=3D IPVLAN_MODE_L3S)
> > +     if (port->mode =3D=3D IPVLAN_MODE_L3 || port->mode =3D=3D IPVLAN_=
MODE_L3S)
> >               dev->flags |=3D IFF_NOARP;
> >       else
> >               dev->flags &=3D ~IFF_NOARP;
> >
> > -     rcu_read_lock();
> > +     spin_lock_bh(&port->addrs_lock);
> >       list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
>
> I'm surprised lockdep/rcu debug does not complain above. In any case I
> think you should replace list_for_each_entry_rcu() with
> list_for_each_entry(), here and below.

This would require CONFIG_PROVE_RCU_LIST=3Dy
and some ipvlan selftests :)

> Thanks,
>
> Paolo
>

