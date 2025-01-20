Return-Path: <netdev+bounces-159794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556EEA16EDA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B5E161532
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E441E4110;
	Mon, 20 Jan 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="de+2gZ4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE931E3DEB
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384942; cv=none; b=YrI0ESfbhrJjSxQEa1cZbofCYblauEr0J8M2Ms+J9EObGEJXCls88QBnggDssEJ2WhCpf/kR3WMy0VHeTqzZIVVKnYKTPTdB5g0Gtnh76D0s3DRx6tJs1pbrBMkuhaBP2NmfhP8rOG3ud1xuGmuBJh7EtPp/kS68jbbjaaPtjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384942; c=relaxed/simple;
	bh=qN4rdIgd6pak1Vsxtiz8hIs8iuaAKPY5yGXYnx5/uXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVQVvDaDrNuDmzuU/ZI7Yu8gR5os9suN74SEUfL6GoJMMIkR0SvN0VE245Cx4d377pRCulJZLEmA7x9Flro32nw06MkDi5HoKSRjXp62irlSUsPpOwxcZOzm/Zkr3H6BNh2jDyHixdLmWFlSP/uyfByZRZfI0/1AJxWczFr9aJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=de+2gZ4R; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso6446709a12.0
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737384939; x=1737989739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nthe+lAnUx97NZjL5yuyoaenRcukPxbJVbeUoHlUn58=;
        b=de+2gZ4RPCVnFxTQjT6w4B5Kt26U3Q/CPHaZQOVa9G4q/XrPGTLSMSoGWZUmb1seQ5
         OWA8QA0O8ZcTaycNMSm1vJeyFNn46O2D+ezGFdgB4I3XbH6xdxuRoXB/ffYoaKgopqrY
         Dqntj9TBzbJqVEgNqLEzJFAHTC3piDcuB4KXV/D4zBUtXGDR61wsQfjumWaLTtlvzsmC
         BivFeMfNwKYl957A5oPSMAIoff3XvgmveiZMTTFNOJ7lI9g7D+JHs352yeyVvvBN5KtJ
         G7oeK7GmAs8b2/w47gF+v90i5vgMJmssw5o455g5s77h0r6EsGfHJ6CiQB/qzQF71npl
         +kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737384939; x=1737989739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nthe+lAnUx97NZjL5yuyoaenRcukPxbJVbeUoHlUn58=;
        b=c4P8i5s2yeHRHO04guBJjHE5DZg9VH5zKSG5jsxNhLNNAXx7gfpmF7qGs2HziPD25U
         JmFzPD7MJvpz/Rpu7+YUL56XEYrl3y945FnpnEqT1InA0BB77sYSKv45+cDf3MVnWmTb
         m5bJKVtg1BqMpVVK1ULA+TQpVRy5KUTMbRJMUjwGgNYDMcNyLjEoQDNp9uGqNuwABz8t
         YNSXnE3PxW3Dbv+tinihhxpuMfX1TTiWaZ15g0OAvSw7HPrnfkUA4VFaLcyN5ak6X/m/
         p1tvCNqMARRvWt6BZMxD4CbcExyOMAWBOtcUO5V5KzVFGM9CyezKlz4p1TjQK6Ydkysk
         gJeA==
X-Forwarded-Encrypted: i=1; AJvYcCXB40pHhvsLLmIzY3lY+WhVaYLI9QQeKcFmAQXVn7eCU5z2KdyQ6ZdTx0cW5UoKzTODn7Tzx+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKu7Td+1WcVsUibd3yy4KSeZzBKfmj9PSU98K3JkppTuwhpsS
	NaXUfhBRkOJJN+8VcsJuiTb6v/T8BQh5YEjZpmPL7no4Vyfm3TljJ92tLfltF4Xud4rVKx/yGP/
	p/ykKmXlKu6i/BUk2OL8hRNS0XxR3tj2I5S2F
X-Gm-Gg: ASbGncvoh/uPWsTLgm8YMp1e0kBiOovoLO1VTPnK8VyS8rS2PHwyaUOJziEPI/V0x1R
	7EEHHKVYbvMEZpvJcmGp2ZNlWIMTJcRyO2WiRyCM2WYwoS4ns2w==
X-Google-Smtp-Source: AGHT+IHHEFWXIOLKI0roGTOjKCap+7S8g7KR3bMraYLIhfxR/lFZPpRZ2HNcDlSgSfHXJ3hzXKAuYohMj1UUHJKkaRk=
X-Received: by 2002:a50:bb29:0:b0:5da:105b:86c1 with SMTP id
 4fb4d7f45d1cf-5db7db148ccmr9229682a12.23.1737384937348; Mon, 20 Jan 2025
 06:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109142724.29228-1-tbogendoerfer@suse.de> <CANn89iKY1x11hHgQDsVtTYe6L_FtN4SKpzFhPk-8fYPp5Wp4ng@mail.gmail.com>
 <20250113122818.2e6292a9@samweis> <CANn89iL-CcBxQUvJDn7o2ETSBnwf047hXJEf=q=O3m+qAenPFw@mail.gmail.com>
 <20250120153156.6bff963c@samweis>
In-Reply-To: <20250120153156.6bff963c@samweis>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Jan 2025 15:55:26 +0100
X-Gm-Features: AbW1kvb6PtA6PXzbvfyP3hBrjopae_rEPx0zZzohTY-p84fV07OHv70xCDl0At4
Message-ID: <CANn89iLLWZ3v46KfCuHKzskQb58tW2mp0d-uibX_GV+=ZG9iUA@mail.gmail.com>
Subject: Re: [PATCH net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 3:32=E2=80=AFPM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> On Mon, 13 Jan 2025 13:55:18 +0100
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Mon, Jan 13, 2025 at 12:28=E2=80=AFPM Thomas Bogendoerfer
> > <tbogendoerfer@suse.de> wrote:
> > >
> > > On Thu, 9 Jan 2025 15:56:24 +0100
> > > Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > > On Thu, Jan 9, 2025 at 3:27=E2=80=AFPM Thomas Bogendoerfer
> > > > <tbogendoerfer@suse.de> wrote:
> > > > >
> > > > > gro_cells_receive() passes a cloned skb directly up the stack and
> > > > > could cause re-ordering against segments still in GRO. To avoid
> > > > > this copy the skb and let GRO do it's work.
> > > > >
> > > > > Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > > > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > > > ---
> > > > >  net/core/gro_cells.c | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > > > > index ff8e5b64bf6b..2f8d688f9d82 100644
> > > > > --- a/net/core/gro_cells.c
> > > > > +++ b/net/core/gro_cells.c
> > > > > @@ -20,11 +20,20 @@ int gro_cells_receive(struct gro_cells *gcell=
s, struct sk_buff *skb)
> > > > >         if (unlikely(!(dev->flags & IFF_UP)))
> > > > >                 goto drop;
> > > > >
> > > > > -       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(=
dev)) {
> > > > > +       if (!gcells->cells || netif_elide_gro(dev)) {
> > > > > +netif_rx:
> > > > >                 res =3D netif_rx(skb);
> > > > >                 goto unlock;
> > > > >         }
> > > > > +       if (skb_cloned(skb)) {
> > > > > +               struct sk_buff *n;
> > > > >
> > > > > +               n =3D skb_copy(skb, GFP_KERNEL);
> > > >
> > > > I do not think we want this skb_copy(). This is going to fail too o=
ften.
> > >
> > > ok
> > >
> > > > Can you remind us why we have this skb_cloned() check here ?
> > >
> > > some fields of the ip/tcp header are going to be changed in the first=
 gro
> > > segment
> >
> > Presumably we should test skb_header_cloned()
> >
> > This means something like skb_cow_head(skb, 0) could be much more
> > reasonable than skb_copy().
>
> I don't think this will work, because at that point it's skb->data points
> at the IPv6 header in my test case (traffic between two namespaces connec=
ted
> via ip6 tunnel over ipvlan). Correct header offsets are set after later,
> when gro_cells napi routine runs.
>
> Do you see another option ?

Anything not attempting order-5 allocations will work :)

I would try something like that.

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b..74416194f148 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <net/gro_cells.h>
 #include <net/hotdata.h>
+#include <net/gro.h>

 struct gro_cell {
        struct sk_buff_head     napi_skbs;
@@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells,
struct sk_buff *skb)
        if (unlikely(!(dev->flags & IFF_UP)))
                goto drop;

-       if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+       if (!gcells->cells || netif_elide_gro(dev)) {
                res =3D netif_rx(skb);
                goto unlock;
        }
@@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *napi,
int budget)
                skb =3D __skb_dequeue(&cell->napi_skbs);
                if (!skb)
                        break;
-               napi_gro_receive(napi, skb);
+               /* Core GRO stack does not play well with clones. */
+               if (skb_cloned(skb))
+                       gro_normal_one(napi, skb, 1);
+               else
+                       napi_gro_receive(napi, skb);
                work_done++;
        }

