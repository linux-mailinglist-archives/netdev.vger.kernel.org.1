Return-Path: <netdev+bounces-213465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA1B2529E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137CC1892C40
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94703298CA4;
	Wed, 13 Aug 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/WITrVl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721428D8F8
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107768; cv=none; b=K2VHCYs8VL27APro7EnxThgp18SZH6meU9dX87/ROihrON4FrL5qIlseHn2WKcyrno8+PuHtwAh5zH0gWhZPbSHk971tPpPuwE/2jS3zEOwT8Zgt5BgaFuSgyt3HPy0XLfWHjMBeNoLLySZS5xe824TBYrE/UbXouNlRUEdkyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107768; c=relaxed/simple;
	bh=V51uJT4A0r7hr5YTUOsZNBFHeS8Uo5cK1ak9EIJDOR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1DuRwhhjtTi1OpGPNXk9J7OufcELqIyLBFcQxHKSnVggpb7cok1j6AJLCm5OXe6HguCtnueyHHZE9L06YLuv3dJ8Og4wA/iN9tvETJuMsPhQ7scWCkipFu4vWKpNvYv1dxHKwnAc3WXMRr4h673BWh9xbEzVERAnVtpjWKEIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/WITrVl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445805aa2eso296405ad.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755107766; x=1755712566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9QMxHu3t+iVo775MrexW0tJfli2gyhC4QZtnbpfiQo=;
        b=b/WITrVlxvJNWOeRCTDycowpZVW8XWPAITxFnhD7Hzyjt42kHYlhsHmd4ky6vFjKJ9
         t9D1vgWAyT+2y2v4oi5DJ+WMooJXzNALsZ13IxQg/nAFkhOUEdd+Atm1lMl0l6PRfVr7
         7bY8VOOuVFST4mdgyrNYXMnBG9vG9up5ieaSmH3ULIY4+hCzBibe9DFaKKyg3EU/Zhjy
         4EwKb4QsuIsjMSbRKJK/597GQzPtU2i/sxhcfb3XHH4EMNd/2fTsM4Elf9ozGfIvcJqS
         +jTBCHFXaSzcc9GrXM2COHzc15/FLu5zOdZKdKT9u1Q5dbJwfZiMeY1uY8kAAXfzhg90
         X4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107766; x=1755712566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9QMxHu3t+iVo775MrexW0tJfli2gyhC4QZtnbpfiQo=;
        b=ADKog5Mz3d1GysS+iIa9MZCjiXoUnfz2E1oxlhihvWa0YtCnSrZ6MybHaqUUXii2gF
         UPS94xfLPfKlgq/92IpiA+HW1a+YUkjFmFXwohRvnykqbt2LHuLAMHAl8rh1nFjXVz1U
         OyG2xXqa5U0d4GKKDNFJwHcfugt/GsiGAX60j/S7p5U21Jxv4+OYnAslwtd9NzqyoLql
         dh9gxr/i95E82Y8IgcOmL/YULCacyJQFRBUVslKC0MtEjISr30LSPc+36XHPaLkRsZ4i
         /awTFzw8F523GKOSK+PQF+cEKc0ED95y6k50Ra70HJF2un117qLrsxwhLP0lw66Of/CO
         4deA==
X-Forwarded-Encrypted: i=1; AJvYcCXBLPjGe+1wsK/O/J2gYzlMa1ddjlTUjZ7nsP7sLHqt6QXGofCiREnYe80oNd4lpe445uaGeRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/ughYmhtPRziJMTHEzU2NhvLeCgQMWqY5dXokpV8+M+mFEn/
	oZWlPw5IRLbLK4CyHKcSe+BmW8xbIAy/EnFOT3eBanrJogkKEVhS7kSV3lgPNNlKAJL7Lsn9zC2
	c4EROQIeWabqMxcQ3CxgdswtL9UaZHZr9Mc0Rp1pJ
X-Gm-Gg: ASbGncvewjDB5IBo/Yv1Nj3JEYvav/01RjvqvBqLF3chVE/mFtevA9N+j3cA6fM5YJo
	qhZhRgs0PL8aNZ/tA4Mi2nxteEP2QU0aTkFt72pl7G1lX1dfC6xn/mmDBnpC5sKd4PaRj/h5yW3
	rJAWgaeOa8Gr7hupy3BuKzR0iCXD+/wP0MQ0qaAcKfQNstMmPbNGro3DmbM+R60S2NhM9ede83y
	5xbqz56gsYablpHAHprGnw/QPlrxx3P7jkehm1LcxuOse6gfJs=
X-Google-Smtp-Source: AGHT+IGs3FKzRr3oj4hqhoLmP3i10WnkmREI+GoYHnTSGNrLjIuVPInPJfZTAnaddEHUgl4hb24A0JuE74xwTlpCXr0=
X-Received: by 2002:a17:902:d486:b0:240:9ff:d546 with SMTP id
 d9443c01a7336-244584af9ccmr94195ad.6.1755107766091; Wed, 13 Aug 2025 10:56:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812125155.3808-3-richardbgobert@gmail.com>
 <20250813062904.109300-1-kuniyu@google.com> <799c2171-7b41-4202-9ea4-e28952f81a65@gmail.com>
 <aJy3la53tn3mS3Jc@shredder>
In-Reply-To: <aJy3la53tn3mS3Jc@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 10:55:54 -0700
X-Gm-Features: Ac12FXx6A6P3y10zhXnAjRuFnvi2QA9wi78ESybO_RVdBQRYKwugQpUGoKV9YAw
Message-ID: <CAAVpQUD4Z-UrANUtdrt5v8xwB5-Qfi+hVUcFr=FZc1eohYU7QA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
To: Ido Schimmel <idosch@nvidia.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, andrew+netdev@lunn.ch, daniel@iogearbox.net, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	menglong8.dong@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	petrm@nvidia.com, razor@blackwall.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:04=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Aug 13, 2025 at 05:46:44PM +0200, Richard Gobert wrote:
> > Kuniyuki Iwashima wrote:
> > > From: Richard Gobert <richardbgobert@gmail.com>
> > >> @@ -4044,15 +4045,37 @@ static int vxlan_nl2conf(struct nlattr *tb[]=
, struct nlattr *data[],
> > >>            conf->vni =3D vni;
> > >>    }
> > >>
> > >> +  if (data[IFLA_VXLAN_LOCALBIND]) {
> > >> +          if (changelink) {
> > >> +                  NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_LOCALBI=
ND], "Cannot rebind locally");
> > >> +                  return -EOPNOTSUPP;
> > >> +          }
> > >
> > > Are these two "if" necessary ?
> >
> > Creating a vxlan interface without localbind then adding localbind won'=
t
> > result in the socket being rebound. I might implement this in the futur=
e,
> > but for simplicity, I didn't implement this yet.
>
> I think Kuniyuki meant that you can just call vxlan_nl2flag() without
> those two "if"s because the function is a NO-OP when the attribute is
> not present and it will also fail the changelink operation.

Yes, I don't know why other places were not converted as such
when vxlan_nl2flag() was introduced in 70fb0828800b.

>
> >
> > >
> > >
> > >> +
> > >> +          err =3D vxlan_nl2flag(conf, data, IFLA_VXLAN_LOCALBIND,
> > >> +                              VXLAN_F_LOCALBIND, changelink,
> > >> +                              false, extack);
> > >> +          if (err)
> > >> +                  return err;
> > >> +  }
> > >> +

