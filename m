Return-Path: <netdev+bounces-182141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D89A88012
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5550517328C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70A29AB18;
	Mon, 14 Apr 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czEcNWY+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2680B;
	Mon, 14 Apr 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632693; cv=none; b=qk+CJ3KEHPksT3BLCqVfnoSYGPqSCU/7qnAkdB3Lm0ca6iNatAeNkrBlKOSdIwCJJQPgK3UuCbN3849BCVIWIt+yNnWCCDvPCz9XCj51Y2657RMQwdpi1OSlyuctEF60qRphyzJd5dQ0W5V359ejtlWLKx4trmBdPOyPqROlXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632693; c=relaxed/simple;
	bh=yjklxsIZi4G/0FrM8nYOnD6uKZbJXa2YOYpp1NX6HXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mqb28Txd8K7olAf/rr5NpyeDVvLLa2GLLd4fYY81hytJ9gPT8B7/Iqo9i9/nB4GqLXR2MxtdyR7blQEFga/ECeQdrlyIOqnpTotsy/PFJ5ozKi/sazUxa+BYPg4GILic+yv4xJoBSTToToVfqqnL8DNKPZNmJXcs5LzxT228rGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czEcNWY+; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6e50418da6so3845814276.3;
        Mon, 14 Apr 2025 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744632690; x=1745237490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4nw7PbrtgjL7S19J+yVLhjLNTYkyI+7kVEtkH7yzDc=;
        b=czEcNWY+G6HeOo9d+toAEhIqTstNLYxrSWDlp7v+Tyy9yzzlFK4AqBfA5UXn2WVN9M
         5Ugj5v4+tTIIJkw5inPbllL9runeMhaApOSajipTCdC7LwQSps/mWetn6QWFha0JpOVF
         As3RkDM/4snWOFq65DfWwoQw6CrXyA/BBOckxBtsSdm1fEbnkmbE+XDKZBpCfWLotfMF
         yu6OOXT73bBtovJuH6La0USZfjRa3SrLU3B3fM2RHowl16Busei3rOTYzNGX+Sc9sMJM
         jRCvVm6lkrcs25hb+NPntFukHGDHomm0VA+jsW+AbsplF8IgyhZ0/ul4o7DK3oOlKxkI
         EKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744632690; x=1745237490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4nw7PbrtgjL7S19J+yVLhjLNTYkyI+7kVEtkH7yzDc=;
        b=ZiNHy4en95itV/RIRpnGd1ao/r1VoxdsbbnJ2tO63OTNAYbn5x7BTl2wAnEeJGwRoj
         bcSCX4Y4zFIf0DAHaIs9KN/gFFJTSCA0MtxQAFTV/4RP6tWPXQDdnoQYa/h7X5R4v+0d
         wENQpSzMrx9wUGMXYZrtYATPXjxOE+2vMRk8hP0YDK5ypGF6SxdwbyYaCxmlp6+1/tIb
         MZuYTZ4KCAnY3AfF7OaXuZ0CnmGlcDaliD16MuJ9z7oCH5PHEKLoygBgHTLqug5CblVb
         sPTeGcADPHk4GRyvtxGVu1Kk15NNa2gfv6Zit2WsJoOFPfEssRshQyaW2XmsJN/LPpD/
         jQdw==
X-Forwarded-Encrypted: i=1; AJvYcCVhfOur4jKoAN+gSGvDr+4ave5uPv901fosdpx8tNAd6+QgykekaGW5GhE12wN2egQQ5CzOjY/gNli90Y4=@vger.kernel.org, AJvYcCViqcM9xfPsB1/oRPfq3c5yCMubFxyDjmW2pXQUp6SIXu5ARlkKjmy00OcQ2Yw9YxttLuB9QvfI@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMwOGc9jJ/Tmmp8SzFk6o3l8y6nNpU48vU9L279XR1FvQviHL
	LRNHu9GNG7RKlOxm8nTENwZgRpK32WwMOCmlGH8bTbgw9BDKJkvWjTn/UiEdkfA3Yvrm8hZZgGV
	FvxUKD374wtzG4JhntW+5akGLhms=
X-Gm-Gg: ASbGncvzIyExSv0FIgzhz+KGIH54VDyOQHk3wsfFJJpOnEjDhNa9UV5NlgF8q26ecMz
	mvZb72h/Q4YvUWVvb7QNkr8u+HQKLZgMmTVb/WN+4spW/h95tn8bY8qTYKuoO+umzeiyslNbVnA
	YjKR+kw3ozwy/16m/8bRUk
X-Google-Smtp-Source: AGHT+IGyRMgKNo0PrJaG9tIFBBWyclUfl5rSOD+CS6dgifaFt95O2XZhtFABT7IeajvldSLSfs+2pFRydG5JKaDclIs=
X-Received: by 2002:a05:6902:2e0b:b0:e6d:ea22:f32b with SMTP id
 3f1490d57ef6-e704dfa92c2mr20588206276.28.1744632690454; Mon, 14 Apr 2025
 05:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412122428.108029-2-jonas.gorski@gmail.com> <20250414113926.vpy3gvck6etkscmu@skbuf>
In-Reply-To: <20250414113926.vpy3gvck6etkscmu@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 14 Apr 2025 14:11:18 +0200
X-Gm-Features: ATxdqUHCD9GlyKIfgeBXNV_bmQRQFLMswkNjKtvjsnGrbL_Adgi9g8DQ-gPBprU
Message-ID: <CAOiHx=kRUE8_-4q6wOytrZObyyeSBMTHRMhaFGWDAJ-KBq5vFA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/2] net: bridge: switchdev: do not notify new
 brentries as changed
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:39=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Sat, Apr 12, 2025 at 02:24:27PM +0200, Jonas Gorski wrote:
> > When adding a bridge vlan that is pvid or untagged after the vlan has
> > already been added to any other switchdev backed port, the vlan change
> > will be propagated as changed, since the flags change.
> >
> > This causes the vlan to not be added to the hardware for DSA switches,
> > since the DSA handler ignores any vlans for the CPU or DSA ports that
> > are changed.
> >
> > E.g. the following order of operations would work:
> >
> > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1

as mentioned for the cover letter, I will fix the example to use
default_pvid 0 to have a "working" example.

> > $ ip link set lan1 master swbridge
> > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> > $ bridge vlan add dev lan1 vid 1 pvid untagged
> >
> > but this order would brake:
>
> nitpick: s/brake/break/

Thanks, :set spell clearly didn't help here.

> > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> > $ ip link set lan1 master swbridge
> > $ bridge vlan add dev lan1 vid 1 pvid untagged
> > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> >
> > Additionally, the vlan on the bridge itself would become undeletable:
> >
> > $ bridge vlan
> > port              vlan-id
> > lan1              1 PVID Egress Untagged
> > swbridge          1 PVID Egress Untagged
> > $ bridge vlan del dev swbridge vid 1 self
> > $ bridge vlan
> > port              vlan-id
> > lan1              1 PVID Egress Untagged
> > swbridge          1 Egress Untagged
> >
> > since the vlan was never added to DSA's vlan list, so deleting it will
> > cause an error, causing the bridge code to not remove it.
> >
> > Fix this by checking if flags changed only for vlans that are already
> > brentry and pass changed as false for those that become brentries, as
> > these are a new vlan (member) from the switchdev point of view.
> >
> > Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs f=
rom changed ones")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >  net/bridge/br_vlan.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> > index d9a69ec9affe..939a3aa78d5c 100644
> > --- a/net/bridge/br_vlan.c
> > +++ b/net/bridge/br_vlan.c
> > @@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *=
br,
> >                               u16 flags, bool *changed,
> >                               struct netlink_ext_ack *extack)
> >  {
> > -     bool would_change =3D __vlan_flags_would_change(vlan, flags);
> >       bool becomes_brentry =3D false;
> > +     bool would_change =3D false;
> >       int err;
> >
> >       if (!br_vlan_is_brentry(vlan)) {
> > @@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *=
br,
> >                       return -EINVAL;
> >
> >               becomes_brentry =3D true;
> > +     } else {
> > +             would_change =3D __vlan_flags_would_change(vlan, flags);
> >       }
> >
> >       /* Master VLANs that aren't brentries weren't notified before,
> > --
> > 2.43.0
> >
>
> You might want to mention that "bool *changed" is used later in
> br_process_vlan_info() to make a decision whether to call
> br_vlan_notify(RTM_NEWVLAN) or not. We want to notify switchdev with
> changed=3Dfalse, but we want to keep notifying the change to rtnetlink.
>
> The rtnetlink notification still happens even if we don't set
> would_change here, because it depends on this code snippet:
>
>         if (becomes_brentry) {
>                 ...
>                 *changed =3D true;
>                 ...
>         }
>
> and not on this one:
>
>         if (would_change)
>                 *changed =3D true;
>
> That was my only concern with this change (I had missed the first snippet
> when initially reading the code), and I didn't see in the commit log
> some sort of attention paid to this detail.

Will add it. And I did check that, even considered shortly to merge this to

        if (becomes_brentry || would_change)
                *changed =3D true;

but then considered that a refactoring too much.

>
> With that:
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thank you!

