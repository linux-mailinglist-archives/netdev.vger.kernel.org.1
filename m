Return-Path: <netdev+bounces-152667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156579F53BD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0732D1732EC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16C1F8684;
	Tue, 17 Dec 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqhtGsvL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117B1F8911
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456511; cv=none; b=KEWvno4+9XFcMcs26EJXZN5+i6ECnN4GrGDE9ZGRqj23wXI4A1C2MgS9YX+OT5CSI6ojjNSFPe3hWOJVEe8L1HDwuEMW5SqFNpSEDK7ivN7xaAmuO8W0+s8d+eUwAbflJ+K7HN5k6vsSNa5kJxh4cuYa6RobSQC7UiclPiGzwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456511; c=relaxed/simple;
	bh=ifVj41hj0jHwMk0KkHdF7buwVYziTcdW95B2SXgLV5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+G6OL3Le9eBsDMaTMrO/L7E9+lEWF6dX9QoW53P5zeE3xzA9Jj9XXmkx4sYbYtPPGRb7Vopjfj1EPM+OZrXxTkSCQU2EGFCe5I5yzCjMrM7kJW/gBOzVdRu5/e2XjqLnE/ThAcotgT0qnvIAHGh6ausJhcfezkZQ2FWMkomM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqhtGsvL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so8661373a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734456508; x=1735061308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAx+NAq8WY91LPbX8Ct1FdJVOOs8fc/ZQiIFCF7xRKY=;
        b=UqhtGsvLzfeFn2sRgFp+BCSo55AKIxCbN7nPrcU7g9zY+M+iJxKFpP3vI3jR4oTyRf
         pVDnZr1eUpBUvhv0bqLb5aeslfZOBwbgupmarNopqSYj2W3qgQm+adah5j5ogEwzKLSs
         Rv7J5YTynsWwoSdm54V409JnvLjai4MiL3jeC05qsbWASIXJPiK76xcXTKUjovLEkyE9
         K7lTUhLV6AnFfbL4/Lyogzho5QUNqBzA+G032pJ7MCAf+EeL356VkVYdt+mzExZnSwT6
         PJ6DUxS7n8xiUpq5PQfTlCyLI5/KDDoovpb6DJ/2lNCnnD1mXkhGcUNkfAGiBWpBeD8T
         zK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456508; x=1735061308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAx+NAq8WY91LPbX8Ct1FdJVOOs8fc/ZQiIFCF7xRKY=;
        b=GYgi6Qh8vEKhQCAyeLIkoKq5dOo40nhrEChGIyqOiSgPE0Uom1on9C04g6Tbl1/gH8
         F08Qt5FDEdqHQD58Oy67S5uYfnrvCN0x0aF7YWQx/YM2H5gdKa/RiUPf060Fk3OdiicB
         cV7lxkV6+Q3CTeY+GbK9MMqbvGeZ9lzsUX/yoGGhhsScU+lKQ/z3mNJ6Fer5/D8ivHp9
         clb4C3XYLFfBTtQG4zuAFWt4a2vHnJXuAeLMrq+4N186NtuZ0tAy+IXC/74YOsPR4bsg
         oU5gyUesB3cj24sfHwVoOr/XPFG8hb/wOIu7h6tlMwWLHyfY/qTsv0zE4ecLyt3v2lse
         8rSw==
X-Forwarded-Encrypted: i=1; AJvYcCVqREOwndUaptiusICa4wmWn67cjRwhkMiOtDvLrWwGfPXKQ9beBNT5oMn7M/jRPONyClZ/sdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtMg7ydLxlQ6+XGPiY3VQqMMAKt2hkmmI+qD6wct3OjY00Ua8
	zZ6PiZWaQJRkrJ/KhnqKYcyZIj6XoffkhmhMD0X19Rf2sIS9KA4+KLeSIVjIVdqJBqVhC/TYKys
	LIXHE/okOor5Saya8+N7VicVNTCqaLHMrIpFx
X-Gm-Gg: ASbGnctCoKNrVJLA+BViAZfQBQKf1zqsBJF6Jj+jfZFtIS3KK8Mv3KrTSjBc3/m51cb
	w4GUEdZjCCk2XtrX02kTQfw5V645dyQp/bAUJM1RVaJgQqtP+qjVPidAS5DRsvH9Yu4zQSenr
X-Google-Smtp-Source: AGHT+IGkzEIVOrNt8YvlmESZDjkp+W2oK9qFDxe1kRqJA9t2QYfw71jrZAcbcD93ykRxoMr2IC257zK+/VmaHV/Fpxo=
X-Received: by 2002:a05:6402:11c7:b0:5d3:f325:2c3 with SMTP id
 4fb4d7f45d1cf-5d63c3c2d6fmr15451635a12.33.1734456507919; Tue, 17 Dec 2024
 09:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217140323.782346-1-kory.maincent@bootlin.com>
 <CANn89iJ3sax3eRDPCF+sgk4FQzTn45eFuz+c+tE9sD+gE_f4jA@mail.gmail.com> <20241217181712.049b5524@kmaincent-XPS-13-7390>
In-Reply-To: <20241217181712.049b5524@kmaincent-XPS-13-7390>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 18:28:16 +0100
Message-ID: <CANn89iJcQis_1u5PyBn6gPhge1r6SsVicCCywKeVTrjn9o83_g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethtool: Fix suspicious rcu_dereference usage
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com, 
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 6:17=E2=80=AFPM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> On Tue, 17 Dec 2024 16:47:07 +0100
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Tue, Dec 17, 2024 at 3:03=E2=80=AFPM Kory Maincent <kory.maincent@bo=
otlin.com>
> > wrote:
> > >
> > > The __ethtool_get_ts_info function can be called with or without the
> > > rtnl lock held. When the rtnl lock is not held, using rtnl_dereferenc=
e()
> > > triggers a warning due to improper lock context.
> > >
> > > Replace rtnl_dereference() with rcu_dereference_rtnl() to safely
> > > dereference the RCU pointer in both scenarios, ensuring proper handli=
ng
> > > regardless of the rtnl lock state.
> > >
> > > Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
> > > Closes:
> > > https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@googl=
e.com/
> > > Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support
> > > several hwtstamp by net topology") Signed-off-by: Kory Maincent
> > > <kory.maincent@bootlin.com> --- net/ethtool/common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > > index 02f941f667dd..ec6f2e2caaf9 100644
> > > --- a/net/ethtool/common.c
> > > +++ b/net/ethtool/common.c
> > > @@ -870,7 +870,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
> > >  {
> > >         struct hwtstamp_provider *hwprov;
> > >
> > > -       hwprov =3D rtnl_dereference(dev->hwprov);
> > > +       hwprov =3D rcu_dereference_rtnl(dev->hwprov);
> > >         /* No provider specified, use default behavior */
> > >         if (!hwprov) {
> > >                 const struct ethtool_ops *ops =3D dev->ethtool_ops;
> >
> > I have to ask : Can you tell how this patch has been tested ?
>
> Oh, it was not at all sufficiently tested. Sorry!
> I thought I had spotted the issue but I hadn't.
>
> > rcu is not held according to syzbot report.
> >
> > If rtnl and rcu are not held, lockdep will still complain.
>
> You are totally right.
> I may be able to see it with the timestamping kselftest. I will try.

syzbot has a repro that you can compile and run.

Make sure to build and use a kernel with

CONFIG_PROVE_LOCKING=3Dy

