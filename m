Return-Path: <netdev+bounces-157739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7BA0B789
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A36188577B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8522F156;
	Mon, 13 Jan 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqeNaOGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3BB22AE7E
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772932; cv=none; b=rDKiZhKhUm1ezAL4zh/uh0q8UOLDgydD1OujNe7dIk+ZEMDpCh2iwWLRfCbejneYsn+NffhHf8DAPhWqhn/4x6McC7yaL0jwp1yfwQFiulHQ5gxo8PukhXjmPrhhT9SqqgK3qGM6noOFTQy6ZPQcIYeIWsFmjPEWeWWDtvqiNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772932; c=relaxed/simple;
	bh=YLrl8VYSFTSrGG4GhXV8wS86hquO4gDAgjRSoD4vQJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPBeIUYMWlGO8g9U08S4LN9Kg5ulo2kflV5Pi7sRElz6RBD1C1eDrlAZS8AgNlt0yQf7K4zH2ya6AHE8rUcyKVyTAlLDoeEgEMPXeXTY0uqp3dF1C7rJMBzQ/fEY5BhXPW1kujo9j9+A29zPglYxi3xWMXhv8jiIK/wddrMNPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqeNaOGx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so6009250a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 04:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736772929; x=1737377729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHv4HvPC5bL0i5yRVgFgRjKl9rnWsl6q6YWYF/ESsqI=;
        b=yqeNaOGxCjXiEksx7VvdQx23f0CBJocl9s8T7Fm6GBYXusIRn5UyHUrIdM5JHQX56I
         2j2O6Hxfnb2LwJWfTFUKL3YPhDQSPnmwjcUKA+pQHA8yBFMp/MoIW+hB2CI36aY9uP7b
         XNjaZ7nUXOoC/JOtYA+x+w+MOWdtO/3aNOM4iPHKILiPrU78LDUFnaqWO5/+QR+ioaJl
         s8xXuMPaKsCcMjkVo4I58cTglN3sGgL4gmVZdgHipDwHYLPuwGnaVAm5ylAUVOgZyCSR
         n5FrlmVWnX/LgEmY3LsqhVloqiJSgk71PV/G45MlY3Drual36Dgb8Rihi6J6cbVo5x05
         aRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736772929; x=1737377729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHv4HvPC5bL0i5yRVgFgRjKl9rnWsl6q6YWYF/ESsqI=;
        b=S0VM/0rm7RZrDAaPc35icpWmzfbmF5fVv/4DkiVK0anjX5pzZkrNLfgtz4tUokkDTu
         ij2MnkUal85LV3g0D0PtnLjlrs3Rfr7cg2veXWdHJomRT0Dcmck8XyabFBOKloeFBUn4
         78dFlq04mT7FT1WcmOE8Ef+sHt6yCyqELLUe8xibQ+4RQ/x5wOgzlGHYc7uVc0jmeEWM
         xhSsUk0hxiVeis7ppRGV8MK0qiuJo13tC8Nr9ZyJiii4sS+hh5x2D1OvbhzqXgf1QeAa
         /UAJ+riC9in55WZhTz6K2LStH6EhAvr2dCQFCnPDWDGF6nsI7yvSWyrMCs8J3XdcN9VH
         8TFg==
X-Forwarded-Encrypted: i=1; AJvYcCWaxX9j3iEVaOuO4dJNRPxw/oiv5QPnzj4raBEyBYcZIOOdEHV1glv6d8Nrc/8+p+ispIsRjDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgyXzGipiGRmHcMQ/jT30DA9vrdXbjGTvfgPqtkZuLJckx9yP
	1zg+g3MTMuYklYoWJeJdWlFV09dChp+kQcBu6fyg8tdeQ4lpQnnxs/uHMyAZn9r+0HWJYriUqKa
	zVnBOCqSJvUHGeOwd3B+9iCwb5uAehHyiWU8P
X-Gm-Gg: ASbGncsT3Ui1biVMbvpWky7hKc1D5Vs3FtMVwSKpWqPZQ1CmFrG+4nij4jS38TA4bhW
	460TFpgQPpK1Wnz2Anb9sk4phLtmLlup/KxVbqQ==
X-Google-Smtp-Source: AGHT+IGIrZPspzs4KJUIrJpR4AFrymP9EIKTA4AJIoj1D/potKcbA0/yKDxNb4qIQN7Jt2VWxGoF0HmduMQbhptOSvc=
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d972e70945mr48931761a12.28.1736772929208; Mon, 13 Jan 2025
 04:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109142724.29228-1-tbogendoerfer@suse.de> <CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
 <20250113122818.2e6292a9@samweis>
In-Reply-To: <20250113122818.2e6292a9@samweis>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 13:55:18 +0100
X-Gm-Features: AbW1kvZKNvjbC2qhR7P5EH7UH9dv9V8IGtqUKIK8oOHVThEz2naZjvjF6gn1-9g
Message-ID: <CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:28=E2=80=AFPM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> On Thu, 9 Jan 2025 15:56:24 +0100
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Thu, Jan 9, 2025 at 3:27=E2=80=AFPM Thomas Bogendoerfer
> > <tbogendoerfer@suse.de> wrote:
> > >
> > > gro_cells_receive() passes a cloned skb directly up the stack and
> > > could cause re-ordering against segments still in GRO. To avoid
> > > this copy the skb and let GRO do it's work.
> > >
> > > Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > ---
> > >  net/core/gro_cells.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > > index ff8e5b64bf6b..2f8d688f9d82 100644
> > > --- a/net/core/gro_cells.c
> > > +++ b/net/core/gro_cells.c
> > > @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcells, s=
truct sk_buff *skb)
> > >         if (unlikely(!(dev->flags & IFF_UP)))
> > >                 goto drop;
> > >
> > > -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)=
) {
> > > +       if (!gcells->cells || netif_elide_gro(dev)) {
> > > +netif_rx:
> > >                 res =3D netif_rx(skb);
> > >                 goto unlock;
> > >         }
> > > +       if (skb_cloned(skb)) {
> > > +               struct sk_buff *n;
> > >
> > > +               n =3D skb_copy(skb, GFP_KERNEL);
> >
> > I do not think we want this skb_copy(). This is going to fail too often=
.
>
> ok
>
> > Can you remind us why we have this skb_cloned() check here ?
>
> some fields of the ip/tcp header are going to be changed in the first gro
> segment

Presumably we should test skb_header_cloned()

This means something like skb_cow_head(skb, 0) could be much more
reasonable than skb_copy().

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b76451a69e3eae132b593c60ee204..bd8966484da3fe85d1d87bf847d=
3730d7ad094e5
100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -20,7 +20,7 @@ int gro_cells_receive(struct gro_cells *gcells,
struct sk_buff *skb)
        if (unlikely(!(dev->flags & IFF_UP)))
                goto drop;

-       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+       if (!gcells->cells || netif_elide_gro(dev) || skb_cow_head(skb, 0))=
 {
                res =3D netif_rx(skb);
                goto unlock;
        }

