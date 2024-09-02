Return-Path: <netdev+bounces-124102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3E9680BE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3B3B22F4C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD652183092;
	Mon,  2 Sep 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="CSVNei58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092717E01A
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262509; cv=none; b=iZzDJ2HhWNxaQ29NmWosQsK2VesWMYPlSHrQlzVuCrywKfe6xvHII4xChdj1FfYt2i9V+gVXh9+Z6bD5DWde0KDs8DHkW3lGsKWl2+yLcvDYvlvCW8mbbKQlv0wqH2NyvsYzxCXMRlNs0lzuNQchNyjAzYfayg07d8PedszL8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262509; c=relaxed/simple;
	bh=y/phM2gtak5IpNmZ1ZyKmSpHCCT5yc5+SMu8zkK/6/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGvHObz/p9VhHKaZWOGWouNx+kFMM3WZ9XOQftcs0GHpiTeGPBrxIj4Dw78F764pWlPfVfddvLMAdyswIgKbm/HTNmYgJdFNTZF3gfh47K7DmvR140YABx2zHBdh9ci0OMoLLcGsln4eYM6TV63rUu1c6SWDNP0tDfdAXSCeBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=CSVNei58; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45692cd3585so2032321cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1725262505; x=1725867305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xwvTutx+VMx+U5m8ilJaZf9BSFWpaamYBl9FVfuHQY=;
        b=CSVNei58NdWx3pGiTneKFaD57wGIdaV/rRF182oiAxTgV552Qq5aZ/+E/dFKIUlQiG
         VPzlSTIfAew5jekxGjnJcB5GiSJaRIweZwZ9w56G2yQdrbuQQkCIA6Ci9tLUQDc9bgfZ
         FprrRCDZO1O44OuBz3hrmnffVkY1QdsuXqaMBNTvTHOeF+2TqktZXIa1gECfgiMcVm0v
         rzrEq2A8PUMhtl4MukJEutPhasMHIzzYsaKN5WuG0JNZYTgw+3k0QzodGLR/NVNaYZ1s
         iV3UlmofeNQ7qQErTS07CHks3vyp6WW7tJuOo/JOaSMtJyghMvuj6SO0al3AtmzP8Co6
         PKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262505; x=1725867305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xwvTutx+VMx+U5m8ilJaZf9BSFWpaamYBl9FVfuHQY=;
        b=lj5Pbd58lOfCei2BAJJadODDvTV4S/HxWK+KZmyLRsnhAf1KukQUGbxjmqZuknUaUw
         mPSDtwOXYDZKtr7+ScwZRKWbPMv6JL764eHsPVm/sG+Mwm7IFOFniEKLTrf12bZUPH47
         vXCWCPYRqUjSn+q966YU8Cmvx9b4OrlomrsXjlwRSVr97OSVV/ndv/RaAoUc1Wwfg06t
         5v+mnB5Uj32wOraVhUzHqq/4jTqxH22T/7xuoQf7qpIVi2/5eq5L4a4mCUK1bZ+Wo//U
         fkwDp7G48KwJQ3uMmIIx7ZTcKT9iOy497bEJPvPDQfui7eo0AKkj9Qop2u0qAxK08cx3
         tg3g==
X-Forwarded-Encrypted: i=1; AJvYcCVfo5K5AZ4pIA9+UyPUCaVPhmH0gym3Ml9su33gIC7r+S+bHHuDrcvbKq080DOov4VnTTaaYHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRMNZkQ0CoKo8dLvvQ3Ww2UAfLlmMvl/wrQlXFQq0SV3Q+G61
	qm/Dg2ZWofGaFbJ43KdG/4NFidziommMWTT+SBcgMcZ5OvyJBfL0DIV8nWdnBWZ40ap8K4UdGDx
	XuXUCbIm1r08nYSQlvYZ+6mVPixCjYDpnp2qF5xK2mu6pOuxn+UqSHKIe46x6ZTVOKG0t52o6I3
	SGq6VbBmYx8soI0mWonJSpdQ==
X-Google-Smtp-Source: AGHT+IFsXCmCKa5o+ksxosNJAkRGGSkpnJOljAKCmob6efSXTfN8qkkSolfkLbZfqv470jv4i64LAox7+Mon7bBclK8=
X-Received: by 2002:ac8:7c4f:0:b0:44e:d016:ef7 with SMTP id
 d75a77b69052e-4568cef97c9mr57086911cf.7.1725262504798; Mon, 02 Sep 2024
 00:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
 <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org> <ZtRWACsOAnha75Ef@shredder.mtl.com>
 <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
In-Reply-To: <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Mon, 2 Sep 2024 09:34:48 +0200
Message-ID: <CAJpXRYReCbrh0z3fmgKqycJHZ+Z8=+KnK+YpOrhD1UsmgfiSxg@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Petr Machata <petrm@mellanox.com>, 
	Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am So., 1. Sept. 2024 um 14:25 Uhr schrieb Nikolay Aleksandrov
<razor@blackwall.org>:
>
> On 01/09/2024 14:54, Ido Schimmel wrote:
> > On Sat, Aug 31, 2024 at 11:31:50AM +0300, Nikolay Aleksandrov wrote:
> >> On 30/08/2024 17:53, Jonas Gorski wrote:
> >>> When userspace wants to take over a fdb entry by setting it as
> >>> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> >>> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> >>>
> >>> If the bridge updates the entry later because its port changed, we cl=
ear
> >>> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USE=
R
> >>> flag set.
> >>>
> >>> If userspace then wants to take over the entry again,
> >>> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> >>> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores th=
e
> >>> update:
> >>>
> >>>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> >>>            /* Refresh entry */
> >>>            fdb->used =3D jiffies;
> >>>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> >>>            /* Take over SW learned entry */
> >>>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> >>>            modified =3D true;
> >>>    }
> >>>
> >>> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LE=
ARN
> >>> by also allowing it if swdev_notify is true, which it will only be fo=
r
> >>> user initiated updates.
> >>>
> >>> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added b=
y user as such")
> >>> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> >>> ---
> >>>  net/bridge/br_fdb.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> >>> index c77591e63841..c5d9ae13a6fb 100644
> >>> --- a/net/bridge/br_fdb.c
> >>> +++ b/net/bridge/br_fdb.c
> >>> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge=
 *br, struct net_bridge_port *p,
> >>>             if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> >>>                     /* Refresh entry */
> >>>                     fdb->used =3D jiffies;
> >>> -           } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) =
{
> >>> +           } else if (swdev_notify ||
> >>> +                      !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) =
{
> >>>                     /* Take over SW learned entry */
> >>>                     set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> >>>                     modified =3D true;
> >>
> >> This literally means if added_by_user || !added_by_user, so you can pr=
obably
> >> rewrite that whole block to be more straight-forward with test_and_set=
_bit -
> >> if it was already set then refresh, if it wasn't modified =3D true
> >
> > Hi Nik,
> >
> > You mean like this [1]?
> > I deleted the comment about "SW learned entry" since "extern_learn" fla=
g
> > not being set does not necessarily mean the entry was learned by SW.
> >
> > [1]
> > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > index c77591e63841..ad7a42b505ef 100644
> > --- a/net/bridge/br_fdb.c
> > +++ b/net/bridge/br_fdb.c
> > @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge=
 *br, struct net_bridge_port *p,
> >                         modified =3D true;
> >                 }
> >
> > -               if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> > +               if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->f=
lags)) {
> >                         /* Refresh entry */
> >                         fdb->used =3D jiffies;
> > -               } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)=
) {
> > -                       /* Take over SW learned entry */
> > -                       set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)=
;
> > +               } else {
> >                         modified =3D true;
> >                 }
>
> Yeah, that's exactly what I meant. Since the added_by_user condition beco=
mes
> redundant we can just drop it.

br_fdb_external_learn_add() is called from two places; once when
userspace adds a EXT_LEARN flagged fdb entry (then swdev_nofity is
set), and once when a switchdev driver reports it has learned an entry
(then swdev_notify isn't).

AFAIU the previous condition was to prevent user fdb entries from
being taken over by hardware / switchdev events, which this would now
allow to happen. OTOH, the switchdev notifications are a statement of
fact, and the kernel really has a say into whether the hardware should
keep the entry learned, so not allowing entries to be marked as
learned by hardware would also result in a disconnect between hardware
and kernel.

My change was trying to accomodate for the former one, i.e. if the
user bit is set, only the user may mark it as EXT_LEARN, but not any
(switchdev) drivers.

I have no strong feelings about what I think is right, so if this is
the wanted direction, I can send a V2 doing that.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


