Return-Path: <netdev+bounces-120576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318AB959CA2
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25F428333E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78FB195B37;
	Wed, 21 Aug 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjNQ3iti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA6192D85;
	Wed, 21 Aug 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245028; cv=none; b=lPgRMHyQ91HcOWzpIyRk4AT/ND4Y61gRB8+Aklc0ihhs4RSSOXfLAWJ9t1GkkOISt5yzoUaIAdk+oLM0ccDMB7Mn7QIdy2uYOXYz7fAS+pk3sxdHoy5dJEMDwgeeN2hztpRkRrRf3syv/tyBQ0I0Eh0eD8R/yQ0I+B1jWm2YErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245028; c=relaxed/simple;
	bh=RQtgQ/txpDPP8Ez+z7evF97Nbo5S0TR59sICJ6vNqdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jA7kDE3cioNi1a75u5Oi90e9Z+82bbUQn/hq0QYwbPX4sZV7Vmp0dVGtsYKAa93HDq4BYuskVBqCKIHDH+28PiaNFA8LLqvVUCc4muxzwH94m9BA4dcjrFrYghhbIQU8bABFWbARdwMYly6SaUOBzjcJd/4T39nHlohbaOfOo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjNQ3iti; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e1205de17aaso5516506276.2;
        Wed, 21 Aug 2024 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724245026; x=1724849826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u8vdwNxQLv7IxTwuMvTHz7QysezAb/GHoNkx/3NosY=;
        b=UjNQ3iti1ShbKnktPgRITmyDgnMkX6oWsKg8FYrig9yZ2G365vZnRdgZPFk/sAnq0z
         Ig50tt8H188tS4rackUN2qem8nRewbw01hP8UAQ0NYa9/0f+QkpGfKPo7V/IXojkZOR+
         MZlHUi7G4B64QzAYWnI3QE2+F7Rmjr5RVXoCjzPf3xpox9LVNkJB8KzIrIYYDrYVcJIe
         j2r2rRbMq4+WrSD00zgiBs80T5kGLQPSVKhuhGx2Y3jmNiebZTxoB2jYNGtW7FNV4XRI
         exqp4WRZquAq9btNyJhxZ+mU/DRNa8oLxI+ViLb+IF2RxKqh3nD0kEMtQTCEmu8x2Hhc
         k05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724245026; x=1724849826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u8vdwNxQLv7IxTwuMvTHz7QysezAb/GHoNkx/3NosY=;
        b=G1SuRaR8osbCFYQ8BISmkc5Okgjpr4zBP2eZ2beNe4bbNpSmjSgl78YqQ4MIjkQKrV
         mHoUVHGmfk7TtNrAVutnYHPfbVbi98g2oenUsRyFqP3rjJc6aKI5wDVI794mPPIrSvdb
         89ocUXLk0knwqlsp9FMCfBgcf1+nFO+mXb6A1KH16HIwI5bBFxDm/QWWnAZn+zxCuJFj
         e8q79BOuUiTYcryZ2vQviWWlrBpWe1dR3taxUXx4lR0Jyla/mNQNMQboyFw93+EP14/P
         CIAbNEUkSTte0qR3y9MjmDlkrkgACX+kzTUGP75u0KoRB8Ia1pDRZepLENvNcvHyZUGr
         YCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUulnMNT9a96KvFEg/mTot6/nb+hbadxLIYmMDEmOPz4b7Ndxtk6eTCIBc2loqOdf/5lg64FlQq@vger.kernel.org, AJvYcCWiTD/R9jQvwCd6do+8Xsu8D0t1G83THDd8viVnLExHXPUxsugtai5xndywFm0EQUBvlWjAX+nkL0lxWvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLrU1GzjYeOGGVkaAVaP0Q0eCBeKndZ2EHb1nwixUBRZD18aK
	H6pjK8kI6w2d6Izj7J2GLZa/92kslETVdjn56d09TnnM9HOQc6HJQsdMhKApwjA/u9IeYwd7tTL
	xj+SZnqLfwML1kSRzzQq3AYEXSn8=
X-Google-Smtp-Source: AGHT+IEh/mYS+KRWIT5WP9qwgrcLHUh4T4aoMR/zY1Vx76QQPIFgyRtUmP5Qo8mbqQJlpiL+h2vKscu91k11vATP9us=
X-Received: by 2002:a05:6902:12c9:b0:e0b:5d76:c22c with SMTP id
 3f1490d57ef6-e166540ec3fmr2687598276.5.1724245025888; Wed, 21 Aug 2024
 05:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-8-dongml2@chinatelecom.cn> <ZsSL_QJfZqp6zqtc@shredder.mtl.com>
In-Reply-To: <ZsSL_QJfZqp6zqtc@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Aug 2024 20:57:02 +0800
Message-ID: <CADxym3ZW5DxyKvRhU89JQG5uBEgRzgwhUYTcYDKQ16z8STKLuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] net: vxlan: use vxlan_kfree_skb() in vxlan_xmit()
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:29=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, Aug 15, 2024 at 08:42:59PM +0800, Menglong Dong wrote:
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index 9a61f04bb95d..22e2bf532ac3 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -2729,7 +2729,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >                       if (info && info->mode & IP_TUNNEL_INFO_TX)
> >                               vxlan_xmit_one(skb, dev, vni, NULL, false=
);
> >                       else
> > -                             kfree_skb(skb);
> > +                             vxlan_kfree_skb(skb, VXLAN_DROP_TXINFO);
>
> This one probably belongs in include/net/dropreason-core.h as there are
> other devices that support tunnel info with similar checks.
>

OK, I'll add it to the drop reason core as SKB_DROP_REASON_TUNNEL_TXINFO.

> >                       return NETDEV_TX_OK;
> >               }
> >       }
> > @@ -2792,7 +2792,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >                       dev_core_stats_tx_dropped_inc(dev);
> >                       vxlan_vnifilter_count(vxlan, vni, NULL,
> >                                             VXLAN_VNI_STATS_TX_DROPS, 0=
);
> > -                     kfree_skb(skb);
> > +                     vxlan_kfree_skb(skb, VXLAN_DROP_REMOTE);
> >                       return NETDEV_TX_OK;
> >               }
> >       }
> > @@ -2815,7 +2815,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >               if (fdst)
> >                       vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
> >               else
> > -                     kfree_skb(skb);
> > +                     vxlan_kfree_skb(skb, VXLAN_DROP_REMOTE);
>
> Maybe VXLAN_DROP_NO_REMOTE? Please add it to vxlan_mdb_xmit() as well
>

Okay!

> >       }
> >
> >       return NETDEV_TX_OK;
> > --
> > 2.39.2
> >

